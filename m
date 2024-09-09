Return-Path: <linux-spi+bounces-4748-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82549971AB1
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DDD1F24B47
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A81BA287;
	Mon,  9 Sep 2024 13:19:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A11B86DA;
	Mon,  9 Sep 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887962; cv=none; b=nLpFdajAyF+HCL2qKnNhmOhxVEYnnOj7ePJsZniIpKr/rOHM25K21E7CJgOFxtypUqADk74/cjsGQgNn5wZYxV01ATVzVtdvodh2aPk6nL5WwnzvBr10uqRE8a93b/VBYRpRvssGq+ESxEaP6zUrXTCnZ213ujoGTq25NczjoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887962; c=relaxed/simple;
	bh=CB2AzW3FnW6HxtU/k9kok5UmtGv0fLznU2CQjSTuWLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHI4KfYceY2oe5AvIeHWpyH3ZBLMsGBvjROkLfgEDBAjm2QFGC1Lk0tdNsmNsBNQdCG3BeMcPALLi6DZiHg26ncwOhk4rnWiEERe9fqW3a3QaeP4Q/S5a1o6dVuAF17hLcjGGbtHYh8UdDSKM+IYpmN/Kmq4ShTlmEUBVlrReyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X2S7m2457zyRKH;
	Mon,  9 Sep 2024 21:18:12 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A8D54180105;
	Mon,  9 Sep 2024 21:19:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:19:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <dianders@chromium.org>, <akashast@codeaurora.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify code
Date: Mon, 9 Sep 2024 21:28:10 +0800
Message-ID: <20240909132810.1296786-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909132810.1296786-1-ruanjinjie@huawei.com>
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use devm_pm_runtime_enable(), devm_request_irq() and
devm_spi_register_controller() to simplify code.

And also register a callback spi_geni_release_dma_chan() with
devm_add_action_or_reset(), to release dma channel in both error
and device detach path, which can make sure the release sequence is
consistent with the original one.

1. Unregister spi controller.
2. Free the IRQ.
3. Free DMA chans
4. Disable runtime PM.

So the remove function can also be removed.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Correct the "data" of devm_add_action_or_reset().
v3:
- Land the rest of the cleanups afterwards.
---
 drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f4057330444..5cb002d7d4a6 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -632,8 +632,10 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
 	return ret;
 }
 
-static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
+static void spi_geni_release_dma_chan(void *data)
 {
+	struct spi_geni_master *mas = data;
+
 	if (mas->rx) {
 		dma_release_channel(mas->rx);
 		mas->rx = NULL;
@@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
+	if (ret) {
+		dev_err(dev, "Unable to add action.\n");
+		return ret;
+	}
+
 	/*
 	 * check the mode supported and set_cs for fifo mode only
 	 * for dma (gsi) mode, the gsi will set cs based on params passed in
@@ -1146,33 +1154,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (mas->cur_xfer_mode == GENI_GPI_DMA)
 		spi->flags = SPI_CONTROLLER_MUST_TX;
 
-	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
+	ret = devm_request_irq(dev, mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
-		goto spi_geni_release_dma;
+		return ret;
 
-	ret = spi_register_controller(spi);
+	ret = devm_spi_register_controller(dev, spi);
 	if (ret)
-		goto spi_geni_probe_free_irq;
+		return ret;
 
 	return 0;
-spi_geni_probe_free_irq:
-	free_irq(mas->irq, spi);
-spi_geni_release_dma:
-	spi_geni_release_dma_chan(mas);
-	return ret;
-}
-
-static void spi_geni_remove(struct platform_device *pdev)
-{
-	struct spi_controller *spi = platform_get_drvdata(pdev);
-	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-
-	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
-	spi_unregister_controller(spi);
-
-	free_irq(mas->irq, spi);
-
-	spi_geni_release_dma_chan(mas);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
@@ -1254,7 +1244,6 @@ MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
 
 static struct platform_driver spi_geni_driver = {
 	.probe  = spi_geni_probe,
-	.remove_new = spi_geni_remove,
 	.driver = {
 		.name = "geni_spi",
 		.pm = &spi_geni_pm_ops,
-- 
2.34.1


