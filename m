Return-Path: <linux-spi+bounces-4587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64396AE76
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 04:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D05B20CBB
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2E34CD8;
	Wed,  4 Sep 2024 02:11:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2D7E6;
	Wed,  4 Sep 2024 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415909; cv=none; b=C/HZjtFmc4pzoIqie1fLhSqZJdvs7DdCYo4iJ/2jnLv3MrapeZACxAjIEy2F1r7XvqMF+T4tn9aTcI/DWqU8Dd0YjaEj0pX5Jveh0Ne5FpH0fJPK9UOq3mw5Hl7MEx2GMyHm3Pfct37mVC25HgPSd0GRTpe7gXcS7U62FpTL5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415909; c=relaxed/simple;
	bh=Eaimopo3jk9/9ZlEpbVh/7v5+tOlWPuS2H1A3DF6kWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv1TGuk0mYN5ceLLVPTew23wAeMjdrW06GnDMdK4JSJSM909/Yc3uV/Bj5sjYVyyrkIYxckdvN0Mk6CtK9G9j2jhAmyFS46mzOZchX+FwpkLQYlN+2/wAxSf2zC9Qn8gGR8RxOnfFUNp1e3NMMqHwzU83VbAojKpuz1gJRi5RC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wz5TM69cDz69Ny;
	Wed,  4 Sep 2024 10:06:47 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EF92F18005F;
	Wed,  4 Sep 2024 10:11:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 10:11:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
Date: Wed, 4 Sep 2024 10:19:42 +0800
Message-ID: <20240904021943.2076343-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904021943.2076343-1-ruanjinjie@huawei.com>
References: <20240904021943.2076343-1-ruanjinjie@huawei.com>
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

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, switch to devm_pm_runtime_enable() to fix it.

Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-geni-qcom.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 77eb874e4f54..e5bece7be892 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1110,25 +1110,25 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
-	pm_runtime_enable(dev);
+	devm_pm_runtime_enable(dev);
 
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
@@ -1153,10 +1153,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 		goto spi_geni_release_dma;
 
 	return 0;
+
 spi_geni_release_dma:
 	spi_geni_release_dma_chan(mas);
-spi_geni_probe_runtime_disable:
-	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -1169,8 +1168,6 @@ static void spi_geni_remove(struct platform_device *pdev)
 	spi_unregister_controller(spi);
 
 	spi_geni_release_dma_chan(mas);
-
-	pm_runtime_disable(&pdev->dev);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
-- 
2.34.1


