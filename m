Return-Path: <linux-spi+bounces-4721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24254970F88
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503081C2203E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698DF1B0139;
	Mon,  9 Sep 2024 07:23:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA41AF4E0;
	Mon,  9 Sep 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866589; cv=none; b=DqBVcb3n0RD+oAT10ryMHh6OlmZ8HaHs0Fx8y+2ZtFI9UUK1S6/6QqGrG/fx2pzivt1+M11c+DDQ1SR6PaUE/ynEQJ70PXKRszPOiKW9ZuljMwgD5a3Qx7x6S6vjJ6Au7Ja/+4q6DIZoBXm/mprHSgOQlmHNtxUayZ2Dp94Slsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866589; c=relaxed/simple;
	bh=f/gAvk3LY5QcZ5R+QAYNfr2fubYhtonii7MAMhcpejM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuTxa/p5HwIT07MOsytM8rY4MIFYmNPRk0ri+nc0dZJimvSNhfl4WkNwPaRP/50aSa+WN05Dhcdr23NFjuvZlde/sVMRwHsjI/5A8J0WciUcAuOK0eaMl499KlLIuc5rr0OqH9ZQ+BLTKQVgV2gKPTGcuNLjJWTOjEXYcT0J4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X2JDm5llNz1P9HD;
	Mon,  9 Sep 2024 15:22:00 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 917E2140336;
	Mon,  9 Sep 2024 15:23:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 15:23:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 3/3] spi: geni-qcom: Use devm functions to simplify code
Date: Mon, 9 Sep 2024 15:31:41 +0800
Message-ID: <20240909073141.951494-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909073141.951494-1-ruanjinjie@huawei.com>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
v3:
- Land the rest of the cleanups afterwards.
---
 drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f4057330444..8b0039d14605 100644
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
 
+	ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, spi);
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


