Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9A2B3EE4
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKPIj5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKPIj5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:39:57 -0500
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57719C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 00:39:57 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id D8CF21018982B;
        Mon, 16 Nov 2020 09:39:55 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 97F066035EEE;
        Mon, 16 Nov 2020 09:39:55 +0100 (CET)
X-Mailbox-Line: From 4a7efc3865aace7d28ddb74776ee05695be80bd4 Mon Sep 17 00:00:00 2001
Message-Id: <4a7efc3865aace7d28ddb74776ee05695be80bd4.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:06 +0100
Subject: [PATCH for-5.10] spi: mxic: Don't leak SPI master in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to devm_clk_get() or devm_ioremap_resource() fail on probe
of the Macronix SPI driver, the spi_master struct is erroneously not freed.

Fix by switching over to the new devm_spi_alloc_master() helper.

Fixes: b942d80b0a39 ("spi: Add MXIC controller driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.0+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.0+
Cc: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/spi/spi-mxic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 8c630acb0110..96b418293bf2 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -529,7 +529,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	struct mxic_spi *mxic;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct mxic_spi));
+	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct mxic_spi));
 	if (!master)
 		return -ENOMEM;
 
@@ -574,15 +574,9 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
-		goto err_put_master;
+		pm_runtime_disable(&pdev->dev);
 	}
 
-	return 0;
-
-err_put_master:
-	spi_master_put(master);
-	pm_runtime_disable(&pdev->dev);
-
 	return ret;
 }
 
-- 
2.28.0

