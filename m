Return-Path: <linux-spi+bounces-4720-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B0970F85
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB72B20D9F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BA1B011E;
	Mon,  9 Sep 2024 07:23:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFB1AE05B;
	Mon,  9 Sep 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866588; cv=none; b=S7BhmhjohA7NjetAi1olKlNCY9NUKU3/u+M4rNSMm5GXGdXaIh2joDvgF3Yk4A6hM67uC0EaTBeF08imJ4Aq79A3PIWuHkYlocokgZ7DTNcKeKpqoVYPqz/cljOnpMdkNI4CstqhPIYu1/UC4CEt7SCLHQ7GJpYe9GHhL2GHoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866588; c=relaxed/simple;
	bh=zD2KnE13L0ePtk54mxHDXPZ5Th+U5X3n/KYw+9tlNco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ssm5iCm/ogxZ5IrOTFhCeNkpg0IwTr/5/wRFjUqn89v9mC8wxpkoYsGLwqAJP0V0ht8p2Wkg054eCAXz0yrFD7zCvqTq4wr4gyb7KtTXAfsEb+AHHSUeoaEMYbMf9hwqMIJtCxZYFoMGksc2FOWzvnRR4nARNoJmZXpHRo+yD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2JFT3Tn8z1j8Dw;
	Mon,  9 Sep 2024 15:22:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id D87CD180041;
	Mon,  9 Sep 2024 15:23:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 15:23:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 1/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
Date: Mon, 9 Sep 2024 15:31:39 +0800
Message-ID: <20240909073141.951494-2-ruanjinjie@huawei.com>
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

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, switch to devm_pm_runtime_enable() to fix it, so the
pm_runtime_disable() in probe error path and remove function
can be removed.

Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
v3:
- Fix it with devm_pm_runtime_enable() as Dmitry suggested.
- Adjust to be the first patch.
- Add suggested-by.
v2:
- Fix it directly instead of use devm_pm_runtime_enable().
---
 drivers/spi/spi-geni-qcom.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 37ef8c40b276..fef522fece1b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1110,25 +1110,27 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
 		spi->target = true;
 
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		return ret;
 	/* Set the bus quota to a reasonable value for register access */
 	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
 	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
 
 	ret = geni_icc_set_bw(&mas->se);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		return ret;
 
 	ret = spi_geni_init(mas);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		return ret;
 
 	/*
 	 * check the mode supported and set_cs for fifo mode only
@@ -1157,8 +1159,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_release_dma:
 	spi_geni_release_dma_chan(mas);
-spi_geni_probe_runtime_disable:
-	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -1173,7 +1173,6 @@ static void spi_geni_remove(struct platform_device *pdev)
 	spi_geni_release_dma_chan(mas);
 
 	free_irq(mas->irq, spi);
-	pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
-- 
2.34.1


