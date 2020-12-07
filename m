Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3ED2D0BC9
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 09:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgLGIcf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 03:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGIcc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 03:32:32 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AADC0613D1
        for <linux-spi@vger.kernel.org>; Mon,  7 Dec 2020 00:31:52 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 35821100E4165;
        Mon,  7 Dec 2020 09:31:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E57AC369; Mon,  7 Dec 2020 09:31:50 +0100 (CET)
Message-Id: <4fa6857806e7e75741c05d057ac9df3564460114.1607286887.git.lukas@wunner.de>
In-Reply-To: <cover.1607286887.git.lukas@wunner.de>
References: <cover.1607286887.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 7 Dec 2020 09:17:07 +0100
Subject: [PATCH 07/17] spi: mxic: Don't leak SPI master in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
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
2.29.2

