Return-Path: <linux-spi+bounces-4699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6BA96E7A0
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 04:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D590A1F243C3
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BEC1EB3D;
	Fri,  6 Sep 2024 02:19:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA721CF93;
	Fri,  6 Sep 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589195; cv=none; b=mOi3ENNn5lVIX6z7GF4aQozwdtuDP3vUXQsGtqv3tkqMD/pZqZf/v1rHyr38w7SGQ5lOLaZ2wwBpBcE7QDgzwMRauqoDTTj7riOBQ4RkFFPf9ByuZtJ8pPBmIgmvDXkG067nEG/qxg6VjStfnk0iLZqncuJ3CFK5PRANFGNEP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589195; c=relaxed/simple;
	bh=ee2Li6zmMFjp0QBnLLBVAalwAA9ZDs3r6pVg+jzKScs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clw8rycVqL1P5zMIgfrJt6e2exm7WcSdwLsxHLtRWzZMO5ZDrXB9DwcwnT8v2CDfVSsCn+1Y+b/iHHngZYbT180jm9FaDWNSmmfNpuyv9O+W5pLLpnG8YArqaTdbSgnRnpo5f12Ddf1PTyYVWvGuC5hSTr4XxFcUTFXd3X4WoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0Kd11cLCzfbcF;
	Fri,  6 Sep 2024 10:17:41 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DD63140158;
	Fri,  6 Sep 2024 10:19:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 10:19:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <xiaoning.wang@nxp.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Fri, 6 Sep 2024 10:28:28 +0800
Message-ID: <20240906022828.891812-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: 9728fb3ce117 ("spi: lpspi: disable lpspi module irq in DMA mode")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-fsl-lpspi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 8f8496578d6b..7ab251e911a8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -891,7 +891,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
+	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, IRQF_NO_AUTOEN,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
@@ -948,14 +948,10 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
-	if (ret < 0)
+	if (ret < 0) {
 		dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
-	else
-		/*
-		 * disable LPSPI module IRQ when enable DMA mode successfully,
-		 * to prevent the unexpected LPSPI module IRQ events.
-		 */
-		disable_irq(irq);
+		enable_irq(irq);
+	}
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-- 
2.34.1


