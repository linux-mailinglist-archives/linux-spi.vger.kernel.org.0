Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A428D2AF8B3
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 20:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKTIf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 14:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgKKTIe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 14:08:34 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5DC0613D1
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 11:08:34 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 82636101933FD;
        Wed, 11 Nov 2020 20:08:28 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E6109609762E;
        Wed, 11 Nov 2020 20:08:28 +0100 (CET)
X-Mailbox-Line: From 272bae2ef08abd21388c98e23729886663d19192 Mon Sep 17 00:00:00 2001
Message-Id: <272bae2ef08abd21388c98e23729886663d19192.1605121038.git.lukas@wunner.de>
In-Reply-To: <cover.1605121038.git.lukas@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
        <cover.1605121038.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Nov 2020 20:07:10 +0100
Subject: [PATCH 1/4] spi: Introduce device-managed SPI controller allocation
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI driver probing currently comprises two steps, whereas removal
comprises only one step:

    spi_alloc_master()
    spi_register_controller()

    spi_unregister_controller()

That's because spi_unregister_controller() calls device_unregister()
instead of device_del(), thereby releasing the reference on the
spi_controller which was obtained by spi_alloc_master().

An SPI driver's private data is contained in the same memory allocation
as the spi_controller struct.  Thus, once spi_unregister_controller()
has been called, the private data is inaccessible.  But some drivers
need to access it after spi_unregister_controller() to perform further
teardown steps.

Introduce devm_spi_alloc_master() and devm_spi_alloc_slave(), which
release a reference on the spi_controller struct only after the driver
has unbound, thereby keeping the memory allocation accessible.  Change
spi_unregister_controller() to not release a reference if the
spi_controller was allocated by one of these new devm functions.

The present commit is small enough to be backportable to stable.
It allows fixing drivers which use the private data in their ->remove()
hook after it's been freed.  It also allows fixing drivers which neglect
to release a reference on the spi_controller in the probe error path.

Long-term, most SPI drivers shall be moved over to the devm functions
introduced herein.  The few that can't shall be changed in a treewide
commit to explicitly release the last reference on the controller.
That commit shall amend spi_unregister_controller() to no longer release
a reference, thereby completing the migration.

As a result, the behaviour will be less surprising and more consistent
with subsystems such as IIO, which also includes the private data in the
allocation of the generic iio_dev struct, but calls device_del() in
iio_device_unregister().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi.c       | 58 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h | 19 ++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..8a60926f9b0d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2453,6 +2453,49 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__spi_alloc_controller);
 
+static void devm_spi_release_controller(struct device *dev, void *ctlr)
+{
+	spi_controller_put(*(struct spi_controller **)ctlr);
+}
+
+/**
+ * __devm_spi_alloc_controller - resource-managed __spi_alloc_controller()
+ * @dev: physical device of SPI controller
+ * @size: how much zeroed driver-private data to allocate
+ * @slave: whether to allocate an SPI master (false) or SPI slave (true)
+ * Context: can sleep
+ *
+ * Allocate an SPI controller and automatically release a reference on it
+ * when @dev is unbound from its driver.  Drivers are thus relieved from
+ * having to call spi_controller_put().
+ *
+ * The arguments to this function are identical to __spi_alloc_controller().
+ *
+ * Return: the SPI controller structure on success, else NULL.
+ */
+struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
+						   unsigned int size,
+						   bool slave)
+{
+	struct spi_controller **ptr, *ctlr;
+
+	ptr = devres_alloc(devm_spi_release_controller, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	ctlr = __spi_alloc_controller(dev, size, slave);
+	if (ctlr) {
+		*ptr = ctlr;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(__devm_spi_alloc_controller);
+
 #ifdef CONFIG_OF
 static int of_spi_get_gpio_numbers(struct spi_controller *ctlr)
 {
@@ -2789,6 +2832,11 @@ int devm_spi_register_controller(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_spi_register_controller);
 
+static int devm_spi_match_controller(struct device *dev, void *res, void *ctlr)
+{
+	return *(struct spi_controller **)res == ctlr;
+}
+
 static int __unregister(struct device *dev, void *null)
 {
 	spi_unregister_device(to_spi_device(dev));
@@ -2830,7 +2878,15 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	list_del(&ctlr->list);
 	mutex_unlock(&board_lock);
 
-	device_unregister(&ctlr->dev);
+	device_del(&ctlr->dev);
+
+	/* Release the last reference on the controller if its driver
+	 * has not yet been converted to devm_spi_alloc_master/slave().
+	 */
+	if (!devres_find(ctlr->dev.parent, devm_spi_release_controller,
+			 devm_spi_match_controller, ctlr))
+		put_device(&ctlr->dev);
+
 	/* free bus id */
 	mutex_lock(&board_lock);
 	if (found == ctlr)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 99380c0825db..b390fdac1587 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -734,6 +734,25 @@ static inline struct spi_controller *spi_alloc_slave(struct device *host,
 	return __spi_alloc_controller(host, size, true);
 }
 
+struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
+						   unsigned int size,
+						   bool slave);
+
+static inline struct spi_controller *devm_spi_alloc_master(struct device *dev,
+							   unsigned int size)
+{
+	return __devm_spi_alloc_controller(dev, size, false);
+}
+
+static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
+							  unsigned int size)
+{
+	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+		return NULL;
+
+	return __devm_spi_alloc_controller(dev, size, true);
+}
+
 extern int spi_register_controller(struct spi_controller *ctlr);
 extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
-- 
2.28.0

