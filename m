Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C602F487C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 11:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbhAMKUB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbhAMKUA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jan 2021 05:20:00 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C4AC061795
        for <linux-spi@vger.kernel.org>; Wed, 13 Jan 2021 02:19:20 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id GAKJ240024C55Sk01AKJcj; Wed, 13 Jan 2021 11:19:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzdFF-003EHB-Ma; Wed, 13 Jan 2021 11:19:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzdFF-004oa3-5F; Wed, 13 Jan 2021 11:19:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: sh-msiof: Fill in spi_transfer.effective_speed_hz
Date:   Wed, 13 Jan 2021 11:19:15 +0100
Message-Id: <20210113101916.1147695-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113101916.1147695-1-geert+renesas@glider.be>
References: <20210113101916.1147695-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fill in the effective bit rate used for transfers, so the SPI core can
calculate instead of estimate delays.

Restore "reverse Christmas tree" order of local variables while adding
new variables.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b2579af0e3eb0e39..90b8aba8a4fd9f32 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -259,11 +259,13 @@ static const u32 sh_msiof_spi_div_array[] = {
 };
 
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
-				      unsigned long parent_rate, u32 spi_hz)
+				      struct spi_transfer *t)
 {
+	unsigned long parent_rate = clk_get_rate(p->clk);
+	unsigned int div_pow = p->min_div_pow;
+	u32 spi_hz = t->speed_hz;
 	unsigned long div;
 	u32 brps, scr;
-	unsigned int div_pow = p->min_div_pow;
 
 	if (!spi_hz || !parent_rate) {
 		WARN(1, "Invalid clock rate parameters %lu and %u\n",
@@ -292,6 +294,8 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 		brps = 32;
 	}
 
+	t->effective_speed_hz = parent_rate / (brps << div_pow);
+
 	scr = sh_msiof_spi_div_array[div_pow] | SISCR_BRPS(brps);
 	sh_msiof_write(p, SITSCR, scr);
 	if (!(p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
@@ -923,7 +927,7 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 
 	/* setup clocks (clock already enabled in chipselect()) */
 	if (!spi_controller_is_slave(p->ctlr))
-		sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
+		sh_msiof_spi_set_clk_regs(p, t);
 
 	while (ctlr->dma_tx && len > 15) {
 		/*
-- 
2.25.1

