Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB68C249EE3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgHSNA2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgHSNAW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:00:22 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D9C06135B
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:15 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id HQz6230024C55Sk01Qz6d3; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002be-0X; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgH-0005Sc-W0; Wed, 19 Aug 2020 14:59:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/7] spi: rspi: Clean up Bit Rate Division Setting handling
Date:   Wed, 19 Aug 2020 14:58:59 +0200
Message-Id: <20200819125904.20938-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
References: <20200819125904.20938-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a macro for configuring the Bit Rate Division Setting field in
Command Registers, instead of open-coding the same operation using a
hardcoded shift.
Rename "div" to "brdv", as it is not a plain divider value, but controls
a power-of-two divider.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 1b635d6b7881f5b9..450a42ec2141a895 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -161,6 +161,7 @@
 #define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
 #define SPCMD_SSLA(i)		((i) << 4)	/* SSL Assert Signal Setting */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
+#define SPCMD_BRDV(brdv)	((brdv) << 2)
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
 
@@ -290,24 +291,24 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 {
 	int spbr;
-	int div = 0;
+	int brdv = 0;
 	unsigned long clksrc;
 
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	clksrc = clk_get_rate(rspi->clk);
-	while (div < 3) {
+	while (brdv < 3) {
 		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
 			break;
-		div++;
+		brdv++;
 		clksrc /= 2;
 	}
 
 	/* Sets transfer bit rate */
 	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
-	rspi->spcmd |= div << 2;
+	rspi->spcmd |= SPCMD_BRDV(brdv);
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, SPDCR_SPLBYTE, RSPI_SPDCR);
-- 
2.17.1

