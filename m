Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E41F1611
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgFHJ7p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 05:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgFHJ7p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 05:59:45 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E99C08C5C4
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 02:59:44 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by michel.telenet-ops.be with bizsmtp
        id oZzi2200H0R8aca06Zzioq; Mon, 08 Jun 2020 11:59:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007PI-H8; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007xL-Ez; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/8] spi: rspi: Increase bit rate range for QSPI
Date:   Mon,  8 Jun 2020 11:59:38 +0200
Message-Id: <20200608095940.30516-7-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Increase bit rate range for QSPI by extending the range of supported
dividers:
  1. QSPI supports a divider of 1, by setting SPBR to zero, increasing
     the upper limit from 48.75 to 97.5 MHz,
  2. Make use of the Bit Rate Frequency Division Setting field in
     Command Registers, to decrease the lower limit from 191 to 24 kbps.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ea3f2680d3c13e02..38c0cd7febabf114 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -334,14 +334,26 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
  */
 static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 {
-	int spbr;
+	unsigned long clksrc;
+	int brdv = 0, spbr;
 
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
-	spbr = DIV_ROUND_UP(clk_get_rate(rspi->clk), 2 * rspi->speed_hz);
-	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
+	clksrc = clk_get_rate(rspi->clk);
+	if (rspi->speed_hz >= clksrc) {
+		spbr = 0;
+	} else {
+		spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz);
+		while (spbr > 255 && brdv < 3) {
+			brdv++;
+			spbr = DIV_ROUND_UP(spbr, 2);
+		}
+		spbr = clamp(spbr, 0, 255);
+	}
+	rspi_write8(rspi, spbr, RSPI_SPBR);
+	rspi->spcmd |= SPCMD_BRDV(brdv);
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, 0, RSPI_SPDCR);
-- 
2.17.1

