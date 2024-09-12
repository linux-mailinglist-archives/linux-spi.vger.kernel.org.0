Return-Path: <linux-spi+bounces-4796-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B097652E
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B3A1C22053
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D31189F2D;
	Thu, 12 Sep 2024 09:08:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D91A28D;
	Thu, 12 Sep 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132087; cv=none; b=WodEDpOe7lflO0dD3+Na6wjubzyXfp6H8ccEQsqzTuNhjvX+irFz3uEKrephr7PNYO43EQyHf+R55HldQ0Q+sqLwQvgKvLMavlXBKLave2s3X/boY7urghUU7e6MSOWqVqsJQUk9JOj80YzpHoC7An9tdcn2XvJCm7884BRfOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132087; c=relaxed/simple;
	bh=dzWtXAdieK3vvRgxShkkfV9NVn5WJAutsJ84pSQo04Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjrMTZQEA+OTlogH3cA158EDADS2inP3PgfleopnHl2U2vasXXCNCxvubLIYW2JTwqqQliiJl8pkn6OZ2qrEDpZb9Nbj7pe/vcTtSUdd20cjXRrQKmr3+8nI/m0Vlg6NujsyILD6+t7NAWos19mxAuOR/P86TJvmVnYxCG2bHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X4BRT0YGbz69MY;
	Thu, 12 Sep 2024 17:07:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 45B991400D5;
	Thu, 12 Sep 2024 17:07:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 17:07:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<dianders@chromium.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v5] spi: geni-qcom: Use devm functions to simplify code
Date: Thu, 12 Sep 2024 17:17:01 +0800
Message-ID: <20240912091701.3720857-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v5:
- Do devm_add_action_or_reset() straight in spi_geni_grab_gpi_chan().
- Return devm_spi_register_controller() instead of return ret or 0.
- Add reviewed-by.
v4:
- Correct the "data" of devm_add_action_or_reset().
v3:
- Land the rest of the cleanups afterwards.
---
 drivers/spi/spi-geni-qcom.c | 63 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f4057330444..f6e40f90418f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -604,6 +604,21 @@ static int spi_geni_prepare_message(struct spi_controller *spi,
 	return -EINVAL;
 }
 
+static void spi_geni_release_dma_chan(void *data)
+{
+	struct spi_geni_master *mas = data;
+
+	if (mas->rx) {
+		dma_release_channel(mas->rx);
+		mas->rx = NULL;
+	}
+
+	if (mas->tx) {
+		dma_release_channel(mas->tx);
+		mas->tx = NULL;
+	}
+}
+
 static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
 {
 	int ret;
@@ -622,6 +637,12 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
 		goto err_rx;
 	}
 
+	ret = devm_add_action_or_reset(mas->dev, spi_geni_release_dma_chan, mas);
+	if (ret) {
+		dev_err(mas->dev, "Unable to add action.\n");
+		return ret;
+	}
+
 	return 0;
 
 err_rx:
@@ -632,19 +653,6 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
 	return ret;
 }
 
-static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
-{
-	if (mas->rx) {
-		dma_release_channel(mas->rx);
-		mas->rx = NULL;
-	}
-
-	if (mas->tx) {
-		dma_release_channel(mas->tx);
-		mas->tx = NULL;
-	}
-}
-
 static int spi_geni_init(struct spi_geni_master *mas)
 {
 	struct spi_controller *spi = dev_get_drvdata(mas->dev);
@@ -1146,33 +1154,11 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (mas->cur_xfer_mode == GENI_GPI_DMA)
 		spi->flags = SPI_CONTROLLER_MUST_TX;
 
-	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
-	if (ret)
-		goto spi_geni_release_dma;
-
-	ret = spi_register_controller(spi);
+	ret = devm_request_irq(dev, mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
-		goto spi_geni_probe_free_irq;
-
-	return 0;
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
+		return ret;
 
-	spi_geni_release_dma_chan(mas);
+	return devm_spi_register_controller(dev, spi);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
@@ -1254,7 +1240,6 @@ MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
 
 static struct platform_driver spi_geni_driver = {
 	.probe  = spi_geni_probe,
-	.remove_new = spi_geni_remove,
 	.driver = {
 		.name = "geni_spi",
 		.pm = &spi_geni_pm_ops,
-- 
2.34.1


