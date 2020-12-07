Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06B82D0BD0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGIdo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGIdo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:33:44 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37EC0613D0
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:33:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4BAC930000D04;
        Mon,  7 Dec 2020 09:32:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C4C03ACF2; Mon,  7 Dec 2020 09:33:02 +0100 (CET)
Message-Id: <d5b9f0289465394e73dedb8ec51e180a8f1dffc9.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:08 +0100
Subject: [PATCH 08/17] spi: spi-mtk-nor: Don't leak SPI master in probe error
 path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
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
Reviewed-by: Ikjoon Jang <ikjn@chromium.org>
Cc: <stable@vger.kernel.org> # v5.7+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.7+
Cc: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/spi/spi-mtk-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index bf2d0f9cdd19..2e2f36a2e385 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -781,7 +781,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_err(&pdev->dev, "failed to allocate spi controller\n");
 		return -ENOMEM;
-- 
2.29.2

