Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBC23A31B
	for <lists+linux-spi@lfdr.de>; Mon,  3 Aug 2020 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHCLJH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Aug 2020 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCLJH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Aug 2020 07:09:07 -0400
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DF8C06174A
        for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2020 04:09:07 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 0F93D101E6B43;
        Mon,  3 Aug 2020 13:09:04 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id AC55F620DEE8;
        Mon,  3 Aug 2020 13:09:03 +0200 (CEST)
X-Mailbox-Line: From a8c3205088a969dc8410eec1eba9aface60f36af Mon Sep 17 00:00:00 2001
Message-Id: <a8c3205088a969dc8410eec1eba9aface60f36af.1596451035.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 3 Aug 2020 13:09:01 +0200
Subject: [PATCH] spi: Prevent adding devices below an unregistering controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CONFIG_OF_DYNAMIC and CONFIG_ACPI allow adding SPI devices at runtime
using a DeviceTree overlay or DSDT patch.  CONFIG_SPI_SLAVE allows the
same via sysfs.

But there are no precautions to prevent adding a device below a
controller that's being removed.  Such a device is unusable and may not
even be able to unbind cleanly as it becomes inaccessible once the
controller has been torn down.  E.g. it is then impossible to quiesce
the device's interrupt.

of_spi_notify() and acpi_spi_notify() do hold a ref on the controller,
but otherwise run lockless against spi_unregister_controller().

Fix by holding the spi_add_lock in spi_unregister_controller() and
bailing out of spi_add_device() if the controller has been unregistered
concurrently.

Fixes: ce79d54ae447 ("spi/of: Add OF notifier handler")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.19+
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/spi/Kconfig |  3 +++
 drivers/spi/spi.c   | 21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c3008e423f59e..c6ea760ea5f04 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1017,4 +1017,7 @@ config SPI_SLAVE_SYSTEM_CONTROL
 
 endif # SPI_SLAVE
 
+config SPI_DYNAMIC
+	def_bool ACPI || OF_DYNAMIC || SPI_SLAVE
+
 endif # SPI
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6626587e77b4b..dc12af018350c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -475,6 +475,12 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
 
+/*
+ * Prevents addition of devices with same chip select and
+ * addition of devices below an unregistering controller.
+ */
+static DEFINE_MUTEX(spi_add_lock);
+
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -554,7 +560,6 @@ static int spi_dev_check(struct device *dev, void *data)
  */
 int spi_add_device(struct spi_device *spi)
 {
-	static DEFINE_MUTEX(spi_add_lock);
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
 	int status;
@@ -582,6 +587,13 @@ int spi_add_device(struct spi_device *spi)
 		goto done;
 	}
 
+	/* Controller may unregister concurrently */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
+	    !device_is_registered(&ctlr->dev)) {
+		status = -ENODEV;
+		goto done;
+	}
+
 	/* Descriptors take precedence */
 	if (ctlr->cs_gpiods)
 		spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
@@ -2795,6 +2807,10 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	/* Prevent addition of new devices, unregister existing ones */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_lock(&spi_add_lock);
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
@@ -2815,6 +2831,9 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (found == ctlr)
 		idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
+
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_unlock(&spi_add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
-- 
2.27.0

