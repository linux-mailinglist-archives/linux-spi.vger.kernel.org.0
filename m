Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703E52E9911
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 16:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbhADPob (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 10:44:31 -0500
Received: from smtp1.axis.com ([195.60.68.17]:32608 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbhADPoa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 10:44:30 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 10:44:29 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1609775070;
  x=1641311070;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vwg9cdBe27K4Huj5tOlGFkeGTHhfRYJ66GYymW0FLLc=;
  b=iLd6RpILK/a1KMeSQXE7decOnUBBfQR2vx/LTxUiPsIXg2XpKejqJmtr
   5d8WMdIr6e09l8Nw34Opv7f++H71tS6sVZQHGRNFkimOuzKJBE7su1zqS
   FwzjBof38bYO1gFTKuoLUsXcFpRZp69xDr0wftP8nIouq1+V0dzsRgZRV
   rkf7Gdr6Tf+eGE4nHdftrpQYmC34GyNAP8MaOTVIvbIM8wgE6y3bY3uVE
   R2KqZxxGFtUL33e1uMjjnxxF9lBvKIdlAyaLr9SwIY7drQqbZqID+O9c7
   esJXJ0J4rRze/rKNfpyJXFdHjhAF/SbUekCyqT5/OKR97ITz+hYdf9eqE
   w==;
From:   Gustav Wiklander <gustav.wiklander@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>, Gustav Wiklander <gustavwi@axis.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spidev: Fix so the module is autoloaded when built as external
Date:   Mon, 4 Jan 2021 16:34:35 +0100
Message-ID: <20210104153436.20083-1-gustav.wiklander@axis.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Gustav Wiklander <gustavwi@axis.com>

The spi framework sets the modalias for the spi device to belong in
either the acpi device table or the SPI device table. It can never
be in the OF table. Therefore the spidev driver should populate the
spi device table rather than the OF table.

NOTE: platform drivers and i2c drivers support aliases in the
      OF device table.

Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
---
 drivers/spi/spidev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 859910ec8d9f..5cf419a046da 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -687,6 +687,19 @@ static const struct of_device_id spidev_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
 #endif
 
+static const struct spi_device_id spidev_ids[] = {
+	{ .name = "dh2228fv" },
+	{ .name = "ltc2488" },
+	{ .name = "achc" },
+	{ .name = "sx1301" },
+	{ .name = "bk4" },
+	{ .name = "dhcom-board" },
+	{ .name = "m53cpld" },
+	{ .name = "xc7a35t" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, spidev_ids);
+
 #ifdef CONFIG_ACPI
 
 /* Dummy SPI devices not to be used in production systems */
@@ -817,7 +830,7 @@ static struct spi_driver spidev_spi_driver = {
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
-
+	.id_table = spidev_ids,
 	/* NOTE:  suspend/resume methods are not necessary here.
 	 * We don't do anything except pass the requests to/from
 	 * the underlying controller.  The refrigerator handles
-- 
2.11.0

