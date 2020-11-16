Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9532B3EF3
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKPInT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKPInT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:43:19 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB93C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:43:19 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 30C9B101A7200;
        Mon, 16 Nov 2020 09:43:17 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id CD05B6035EEE;
        Mon, 16 Nov 2020 09:43:17 +0100 (CET)
X-Mailbox-Line: From a203c24658b7d70ddb27bf1f9898fe6f896fead5 Mon Sep 17 00:00:00 2001
Message-Id: <a203c24658b7d70ddb27bf1f9898fe6f896fead5.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:08 +0100
Subject: [PATCH for-5.10] spi: spi-mtk-nor: Don't leak SPI master in probe
 error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to devm_spi_register_controller() fails on probe of the
MediaTek SPI NOR driver, the spi_controller struct is erroneously not
freed.

Since commit a1daaa991ed1 ("spi: spi-mtk-nor: use dma_alloc_coherent()
for bounce buffer"), the same happens if the call to
dmam_alloc_coherent() fails.

Since commit 3bfd9103c7af ("spi: spi-mtk-nor: Add power management
support"), the same happens if the call to mtk_nor_enable_clk() fails.

Fix by switching over to the new devm_spi_alloc_master() helper.

Fixes: 881d1ee9fe81 ("spi: add support for mediatek spi-nor controller")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.7+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.7+
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/spi/spi-mtk-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index b97f26a60cbe..288f6c2bbd57 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -768,7 +768,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_err(&pdev->dev, "failed to allocate spi controller\n");
 		return -ENOMEM;
-- 
2.28.0

