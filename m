Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571F11F163F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 12:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgFHKEq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgFHKEq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 06:04:46 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Jun 2020 03:04:46 PDT
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64221C08C5C3
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 03:04:46 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by albert.telenet-ops.be with bizsmtp
        id oZzi2200C0R8aca06ZziCh; Mon, 08 Jun 2020 11:59:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007P4-C4; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007x8-9y; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/8] spi: rspi: Use requested instead of maximum bit rate
Date:   Mon,  8 Jun 2020 11:59:34 +0200
Message-Id: <20200608095940.30516-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the RSPI driver always tries to use the maximum configured
bit rate for communicating with a slave device, even if the transfer(s)
in the current message specify a lower rate.

Use the mininum rate specified in the message instead.
Rename rspi_data.max_speed_hz accordingly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 0e786af546c9f513..1b635d6b7881f5b9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -179,7 +179,7 @@
 
 struct rspi_data {
 	void __iomem *addr;
-	u32 max_speed_hz;
+	u32 speed_hz;
 	struct spi_controller *ctlr;
 	struct platform_device *pdev;
 	wait_queue_head_t wait;
@@ -258,8 +258,7 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk),
-			    2 * rspi->max_speed_hz) - 1;
+	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Disable dummy transmission, set 16-bit word access, 1 frame */
@@ -299,14 +298,14 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 
 	clksrc = clk_get_rate(rspi->clk);
 	while (div < 3) {
-		if (rspi->max_speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
+		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
 			break;
 		div++;
 		clksrc /= 2;
 	}
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->max_speed_hz) - 1;
+	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 	rspi->spcmd |= div << 2;
 
@@ -341,7 +340,7 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->max_speed_hz);
+	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz);
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Disable dummy transmission, set byte access */
@@ -949,9 +948,24 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 {
 	struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = msg->spi;
+	const struct spi_transfer *xfer;
 	int ret;
 
-	rspi->max_speed_hz = spi->max_speed_hz;
+	/*
+	 * As the Bit Rate Register must not be changed while the device is
+	 * active, all transfers in a message must use the same bit rate.
+	 * In theory, the sequencer could be enabled, and each Command Register
+	 * could divide the base bit rate by a different value.
+	 * However, most RSPI variants do not have Transfer Data Length
+	 * Multiplier Setting Registers, so each sequence step would be limited
+	 * to a single word, making this feature unsuitable for large
+	 * transfers, which would gain most from it.
+	 */
+	rspi->speed_hz = spi->max_speed_hz;
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->speed_hz < rspi->speed_hz)
+			rspi->speed_hz = xfer->speed_hz;
+	}
 
 	rspi->spcmd = SPCMD_SSLKP;
 	if (spi->mode & SPI_CPOL)
-- 
2.17.1

