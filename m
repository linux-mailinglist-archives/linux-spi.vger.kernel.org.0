Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971502B3EFF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgKPIpB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:45:01 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:51037 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgKPIpB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:45:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 1863C1018982B;
        Mon, 16 Nov 2020 09:45:00 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id A46636035EEE;
        Mon, 16 Nov 2020 09:44:59 +0100 (CET)
X-Mailbox-Line: From a420c23a363a3bc9aa684c6e790c32a8af106d17 Mon Sep 17 00:00:00 2001
Message-Id: <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:10 +0100
Subject: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe error
 path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to of_match_device(), of_alias_get_id(),
devm_ioremap_resource(), devm_regmap_init_mmio() or devm_clk_get()
fail on probe of the NPCM FIU SPI driver, the spi_controller struct is
erroneously not freed.

Fix by switching over to the new devm_spi_alloc_master() helper.

Fixes: ace55c411b11 ("spi: npcm-fiu: add NPCM FIU controller driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.4+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.4+
Cc: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-fiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 341f7cffeaac..1cb9329de945 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -679,7 +679,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	struct resource *res;
 	int id;
 
-	ctrl = spi_alloc_master(dev, sizeof(*fiu));
+	ctrl = devm_spi_alloc_master(dev, sizeof(*fiu));
 	if (!ctrl)
 		return -ENOMEM;
 
-- 
2.28.0

