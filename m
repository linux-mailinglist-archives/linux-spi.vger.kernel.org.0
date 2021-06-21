Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB13AF2FE
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhFUR6W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 13:58:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhFUR4S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 13:56:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B63DE1F4267B
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0982F4800C7; Mon, 21 Jun 2021 19:54:00 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv5 1/5] spi: add ancillary device support
Date:   Mon, 21 Jun 2021 19:53:55 +0200
Message-Id: <20210621175359.126729-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621175359.126729-1-sebastian.reichel@collabora.com>
References: <20210621175359.126729-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce support for ancillary devices, similar to existing
implementation for I2C. This is useful for devices having
multiple chip-selects, for example some microcontrollers
provide a normal SPI interface and a flashing SPI interface.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/spi/spi.c       | 137 +++++++++++++++++++++++++++++++---------
 include/linux/spi/spi.h |   2 +
 2 files changed, 108 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 16b377581d16..b1b6031961b7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -564,49 +564,23 @@ static void spi_cleanup(struct spi_device *spi)
 		spi->controller->cleanup(spi);
 }
 
-/**
- * spi_add_device - Add spi_device allocated with spi_alloc_device
- * @spi: spi_device to register
- *
- * Companion function to spi_alloc_device.  Devices allocated with
- * spi_alloc_device can be added onto the spi bus with this function.
- *
- * Return: 0 on success; negative errno on failure
- */
-int spi_add_device(struct spi_device *spi)
+static int __spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
 	int status;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= ctlr->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
-			ctlr->num_chipselect);
-		return -EINVAL;
-	}
-
-	/* Set the bus ID string */
-	spi_dev_set_name(spi);
-
-	/* We need to make sure there's no other device with this
-	 * chipselect **BEFORE** we call setup(), else we'll trash
-	 * its configuration.  Lock against concurrent add() calls.
-	 */
-	mutex_lock(&spi_add_lock);
-
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
 		dev_err(dev, "chipselect %d already in use\n",
 				spi->chip_select);
-		goto done;
+		return status;
 	}
 
 	/* Controller may unregister concurrently */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
 	    !device_is_registered(&ctlr->dev)) {
-		status = -ENODEV;
-		goto done;
+		return -ENODEV;
 	}
 
 	/* Descriptors take precedence */
@@ -623,7 +597,7 @@ int spi_add_device(struct spi_device *spi)
 	if (status < 0) {
 		dev_err(dev, "can't setup %s, status %d\n",
 				dev_name(&spi->dev), status);
-		goto done;
+		return status;
 	}
 
 	/* Device may be bound to an active driver when this returns */
@@ -636,12 +610,64 @@ int spi_add_device(struct spi_device *spi)
 		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
 	}
 
-done:
+	return status;
+}
+
+/**
+ * spi_add_device - Add spi_device allocated with spi_alloc_device
+ * @spi: spi_device to register
+ *
+ * Companion function to spi_alloc_device.  Devices allocated with
+ * spi_alloc_device can be added onto the spi bus with this function.
+ *
+ * Return: 0 on success; negative errno on failure
+ */
+int spi_add_device(struct spi_device *spi)
+{
+	struct spi_controller *ctlr = spi->controller;
+	struct device *dev = ctlr->dev.parent;
+	int status;
+
+	/* Chipselects are numbered 0..max; validate. */
+	if (spi->chip_select >= ctlr->num_chipselect) {
+		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
+			ctlr->num_chipselect);
+		return -EINVAL;
+	}
+
+	/* Set the bus ID string */
+	spi_dev_set_name(spi);
+
+	/* We need to make sure there's no other device with this
+	 * chipselect **BEFORE** we call setup(), else we'll trash
+	 * its configuration.  Lock against concurrent add() calls.
+	 */
+	mutex_lock(&spi_add_lock);
+	status = __spi_add_device(spi);
 	mutex_unlock(&spi_add_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
 
+static int spi_add_device_locked(struct spi_device *spi)
+{
+	struct spi_controller *ctlr = spi->controller;
+	struct device *dev = ctlr->dev.parent;
+
+	/* Chipselects are numbered 0..max; validate. */
+	if (spi->chip_select >= ctlr->num_chipselect) {
+		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
+			ctlr->num_chipselect);
+		return -EINVAL;
+	}
+
+	/* Set the bus ID string */
+	spi_dev_set_name(spi);
+
+	WARN_ON(!mutex_is_locked(&spi_add_lock));
+	return __spi_add_device(spi);
+}
+
 /**
  * spi_new_device - instantiate one new SPI device
  * @ctlr: Controller to which device is connected
@@ -2126,6 +2152,55 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
 
+/**
+ * spi_new_ancillary_device() - Register ancillary SPI device
+ * @spi:         Pointer to the main SPI device registering the ancillary device
+ * @chip_select: Chip Select of the ancillary device
+ *
+ * Register an ancillary SPI device; for example some chips have a chip-select
+ * for normal device usage and another one for setup/firmware upload.
+ *
+ * This may only be called from main SPI device's probe routine.
+ *
+ * Return: 0 on success; negative errno on failure
+ */
+struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
+					     u8 chip_select)
+{
+	struct spi_device *ancillary;
+	int rc = 0;
+
+	/* Alloc an spi_device */
+	ancillary = spi_alloc_device(spi->controller);
+	if (!ancillary) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	strlcpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
+
+	/* Use provided chip-select for ancillary device */
+	ancillary->chip_select = chip_select;
+
+	/* Take over SPI mode/speed from SPI main device */
+	ancillary->max_speed_hz = spi->max_speed_hz;
+	ancillary->mode = ancillary->mode;
+
+	/* Register the new device */
+	rc = spi_add_device_locked(ancillary);
+	if (rc) {
+		dev_err(&spi->dev, "failed to register ancillary device\n");
+		goto err_out;
+	}
+
+	return ancillary;
+
+err_out:
+	spi_dev_put(ancillary);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(spi_new_ancillary_device);
+
 #ifdef CONFIG_ACPI
 struct acpi_spi_lookup {
 	struct spi_controller 	*ctlr;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f924160e995f..3ada36175e5f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -299,6 +299,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 		driver_unregister(&sdrv->driver);
 }
 
+extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
+
 /* use a define to avoid include chaining to get THIS_MODULE */
 #define spi_register_driver(driver) \
 	__spi_register_driver(THIS_MODULE, driver)
-- 
2.30.2

