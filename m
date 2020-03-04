Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A459179258
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgCDO3L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 09:29:11 -0500
Received: from foss.arm.com ([217.140.110.172]:35018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgCDO3L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 09:29:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC6B31B;
        Wed,  4 Mar 2020 06:29:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51E353F6CF;
        Wed,  4 Mar 2020 06:29:10 -0800 (PST)
Date:   Wed, 04 Mar 2020 14:29:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi_register_controller(): free bus id on error paths" to the spi tree
In-Reply-To:  <20200304111740.27915-1-aaro.koskinen@nokia.com>
Message-Id:  <applied-20200304111740.27915-1-aaro.koskinen@nokia.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi_register_controller(): free bus id on error paths

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f9981d4f50b475d7dbb70f3022b87a3c8bba9fd6 Mon Sep 17 00:00:00 2001
From: Aaro Koskinen <aaro.koskinen@nokia.com>
Date: Wed, 4 Mar 2020 13:17:40 +0200
Subject: [PATCH] spi: spi_register_controller(): free bus id on error paths

Some error paths leave the bus id allocated. As a result the IDR
allocation will fail after a deferred probe. Fix by freeing the bus id
always on error.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Message-Id: <20200304111740.27915-1-aaro.koskinen@nokia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 197c9e0ac2a6..94145b25f446 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2645,7 +2645,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (ctlr->use_gpio_descriptors) {
 			status = spi_get_gpio_descs(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 			/*
 			 * A controller using GPIO descriptors always
 			 * supports SPI_CS_HIGH if need be.
@@ -2655,7 +2655,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			/* Legacy code path for GPIOs from DT */
 			status = of_spi_get_gpio_numbers(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 		}
 	}
 
@@ -2663,17 +2663,14 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 * Even if it's just one always-selected device, there must
 	 * be at least one chipselect.
 	 */
-	if (!ctlr->num_chipselect)
-		return -EINVAL;
+	if (!ctlr->num_chipselect) {
+		status = -EINVAL;
+		goto free_bus_id;
+	}
 
 	status = device_add(&ctlr->dev);
-	if (status < 0) {
-		/* free bus id */
-		mutex_lock(&board_lock);
-		idr_remove(&spi_master_idr, ctlr->bus_num);
-		mutex_unlock(&board_lock);
-		goto done;
-	}
+	if (status < 0)
+		goto free_bus_id;
 	dev_dbg(dev, "registered %s %s\n",
 			spi_controller_is_slave(ctlr) ? "slave" : "master",
 			dev_name(&ctlr->dev));
@@ -2689,11 +2686,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		status = spi_controller_initialize_queue(ctlr);
 		if (status) {
 			device_del(&ctlr->dev);
-			/* free bus id */
-			mutex_lock(&board_lock);
-			idr_remove(&spi_master_idr, ctlr->bus_num);
-			mutex_unlock(&board_lock);
-			goto done;
+			goto free_bus_id;
 		}
 	}
 	/* add statistics */
@@ -2708,7 +2701,12 @@ int spi_register_controller(struct spi_controller *ctlr)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
-done:
+	return status;
+
+free_bus_id:
+	mutex_lock(&board_lock);
+	idr_remove(&spi_master_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
-- 
2.20.1

