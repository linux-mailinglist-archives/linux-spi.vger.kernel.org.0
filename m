Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23D249EDE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHSNAE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgHSM7a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:59:30 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B280C061383
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:12 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id HQz62300F4C55Sk01Qz6y9; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002bq-31; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0005Sm-2B; Wed, 19 Aug 2020 14:59:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 5/7] spi: rspi: Increase bit rate range for QSPI
Date:   Wed, 19 Aug 2020 14:59:02 +0200
Message-Id: <20200819125904.20938-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
References: <20200819125904.20938-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Increase bit rate range for QSPI by extending the range of supported
dividers:
  1. QSPI supports a divider of 1, by setting SPBR to zero, increasing
     the upper limit from 48.75 to 97.5 MHz on R-Car Gen2,
  2. Make use of the Bit Rate Frequency Division Setting field in
     Command Registers, to decrease the lower limit from 191 to 24 kbps
     on R-Car Gen2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

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

