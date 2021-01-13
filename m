Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B752F487E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAMKUB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbhAMKUB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Jan 2021 05:20:01 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472BC0617A2
        for <linux-spi@vger.kernel.org>; Wed, 13 Jan 2021 02:19:20 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id GAKH2400V4C55Sk01AKHci; Wed, 13 Jan 2021 11:19:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzdFF-003EHD-Jl; Wed, 13 Jan 2021 11:19:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kzdFF-004oa7-5u; Wed, 13 Jan 2021 11:19:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] spi: sh-msiof: Fill in controller speed limits
Date:   Wed, 13 Jan 2021 11:19:16 +0100
Message-Id: <20210113101916.1147695-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113101916.1147695-1-geert+renesas@glider.be>
References: <20210113101916.1147695-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fill in the controller speed limits, so the SPI core can use them for
validating SPI transfers, and adjust or reject transfers when needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 90b8aba8a4fd9f32..41ed9ff8fad0d3b3 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1262,6 +1262,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct sh_msiof_spi_priv *p;
+	unsigned long clksrc;
 	int i;
 	int ret;
 
@@ -1337,6 +1338,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	/* init controller code */
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	ctlr->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
+	clksrc = clk_get_rate(p->clk);
+	ctlr->min_speed_hz = DIV_ROUND_UP(clksrc, 1024);
+	ctlr->max_speed_hz = DIV_ROUND_UP(clksrc, 1 << p->min_div_pow);
 	ctlr->flags = chipdata->ctlr_flags;
 	ctlr->bus_num = pdev->id;
 	ctlr->num_chipselect = p->info->num_chipselect;
-- 
2.25.1

