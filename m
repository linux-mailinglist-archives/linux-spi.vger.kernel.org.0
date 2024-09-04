Return-Path: <linux-spi+bounces-4586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0E96AE73
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 04:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438FE1C20B31
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 02:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C7208C4;
	Wed,  4 Sep 2024 02:11:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9812562E;
	Wed,  4 Sep 2024 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415908; cv=none; b=cdpvUvitmzexPPeTNPJ+cI4h5GByQkxV+/L5jttXY824CMK8GHdyDsUcU5Cahnt2qzg83CV39MIpXNYHJiyN3vhI11ViacVBnbkJow22gcAb58bLsN2ETX5p625izooJ0OWSEwEww/PHfJpgJYsgG9UDg+IA7c+v/SV8BpPcLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415908; c=relaxed/simple;
	bh=x2wcp+sdmH3AWGmRf9oC1sVPRcOtcLzGqP5+iZgBo38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxCoz3cy4krJ0vdhLdZ2QvO//byaalQa/3eLrPqLFcq96uD3Iy41o+Zq/fD27UiL6xBPhs/SXn+xCcR0TugPsV76QC5ILBlXonTnpsRHkPhJjhYivMqiqZphifTG3GjwdvRgWAwVXh9kUHC/XrTZ4loCqqvzUReNI2HkNatKIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz5Xc4C3kzgYvQ;
	Wed,  4 Sep 2024 10:09:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F2E4180105;
	Wed,  4 Sep 2024 10:11:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 10:11:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/3] spi: geni-qcom: Use devm_request_irq() helper
Date: Wed, 4 Sep 2024 10:19:41 +0800
Message-ID: <20240904021943.2076343-2-ruanjinjie@huawei.com>
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

Since spi_geni_probe() use managed function in most places, also use
devm_request_irq() to request the interrupt, so we can avoid
having to manually clean this up.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-geni-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 37ef8c40b276..77eb874e4f54 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1144,17 +1144,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (mas->cur_xfer_mode == GENI_GPI_DMA)
 		spi->flags = SPI_CONTROLLER_MUST_TX;
 
-	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
+	ret = devm_request_irq(dev, mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
 	if (ret)
 		goto spi_geni_release_dma;
 
 	ret = spi_register_controller(spi);
 	if (ret)
-		goto spi_geni_probe_free_irq;
+		goto spi_geni_release_dma;
 
 	return 0;
-spi_geni_probe_free_irq:
-	free_irq(mas->irq, spi);
 spi_geni_release_dma:
 	spi_geni_release_dma_chan(mas);
 spi_geni_probe_runtime_disable:
@@ -1172,7 +1170,6 @@ static void spi_geni_remove(struct platform_device *pdev)
 
 	spi_geni_release_dma_chan(mas);
 
-	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.34.1


