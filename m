Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E53488388
	for <lists+linux-spi@lfdr.de>; Sat,  8 Jan 2022 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiAHMH6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 Jan 2022 07:07:58 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:60864 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiAHMH6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 Jan 2022 07:07:58 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6AVnn9cLGUGql6AVnn8Qbq; Sat, 08 Jan 2022 13:07:56 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 08 Jan 2022 13:07:56 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: qcom: geni: Simplify DMA setting
Date:   Sat,  8 Jan 2022 13:07:54 +0100
Message-Id: <1b14e4ce91a33c16b2c655389c728071a9c9aa2e.1641643601.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-geni-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f7d905d2a90f..4e83cc5b445d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -898,11 +898,8 @@ static int spi_geni_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (ret) {
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-		if (ret)
-			return dev_err_probe(dev, ret, "could not set DMA mask\n");
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not set DMA mask\n");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
-- 
2.32.0

