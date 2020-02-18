Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD7D162519
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgBRK6O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 05:58:14 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:58222 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRK6O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Feb 2020 05:58:14 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id 4AyD2200R5USYZQ01AyDzD; Tue, 18 Feb 2020 11:58:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j40Zx-0003jP-1O; Tue, 18 Feb 2020 11:58:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j40Zx-0000Fg-0L; Tue, 18 Feb 2020 11:58:13 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hoan Nguyen An <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] spi: rspi: Add support for LSB-first word order
Date:   Tue, 18 Feb 2020 11:58:09 +0100
Message-Id: <20200218105810.902-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218105810.902-1-geert+renesas@glider.be>
References: <20200218105810.902-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All RSPI variants support selecting the word order.
Advertize support for LSB-first order, and act upon the flag being set.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7a1e6d524f34a416..aef05f2ac749c21d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -933,6 +933,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 		rspi->spcmd |= SPCMD_CPOL;
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
+	if (spi->mode & SPI_LSB_FIRST)
+		rspi->spcmd |= SPCMD_LSBF;
 
 	/* Configure slave signal to assert */
 	rspi->spcmd |= SPCMD_SSLA(spi->cs_gpiod ? rspi->ctlr->unused_native_cs
@@ -1255,7 +1257,8 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
 	ctlr->unprepare_message = rspi_unprepare_message;
-	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LOOP | ops->extra_mode_bits;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_LOOP |
+			  ops->extra_mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.17.1

