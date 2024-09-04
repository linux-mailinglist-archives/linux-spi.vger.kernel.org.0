Return-Path: <linux-spi+bounces-4588-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A496AE78
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 04:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F9B286F30
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE561C695;
	Wed,  4 Sep 2024 02:12:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5567E6;
	Wed,  4 Sep 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415923; cv=none; b=Tm9wDtcqo27Dc/rRHgeMqlTCFp42cD3yOPWrbQ52Otmdo0k4/89CXUWl/GZwGvvCHzA2738r++uP1mQhxoNjPaw0v0grOLsaOgL+wyEocteCGHzXWjnTvX3oITxk6KTJo7oc/74xxa9luNUMWrH+J4kdJvslzOs7bz0l9hhNZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415923; c=relaxed/simple;
	bh=HBci+jvwt7HfiuzVJeXuxIAHWk8z/lip14lvhCRHDGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDqFVaOPtOQod+NtTndQK7QSfVedoq72CU3AUdfGh/+Up+3yul/x7yPG5jiv+x9XNeFYoBVC1FulhQgtn0U7FlcvmsnXVqZkhnVHoydswScDOLQOxN7wVTCOMAIE5/Bvl3P7WzK30ATGrdh0o2e/WX0fD6JcUWEhSOsxZKu70O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wz5Tf0JRqz69Yp;
	Wed,  4 Sep 2024 10:07:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 280B41400CA;
	Wed,  4 Sep 2024 10:11:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 10:11:58 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 3/3] spi: geni-qcom: Use devm_spi_register_controller()
Date: Wed, 4 Sep 2024 10:19:43 +0800
Message-ID: <20240904021943.2076343-4-ruanjinjie@huawei.com>
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

Use devm_spi_register_controller() in the Qualcomm GENI based SPI
controller driver, which avoid having to manually call
spi_unregister_controller() in the remove function.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-geni-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e5bece7be892..fecb6f15de7b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1148,7 +1148,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_release_dma;
 
-	ret = spi_register_controller(spi);
+	ret = devm_spi_register_controller(dev, spi);
 	if (ret)
 		goto spi_geni_release_dma;
 
@@ -1164,9 +1164,6 @@ static void spi_geni_remove(struct platform_device *pdev)
 	struct spi_controller *spi = platform_get_drvdata(pdev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
-	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
-	spi_unregister_controller(spi);
-
 	spi_geni_release_dma_chan(mas);
 }
 
-- 
2.34.1


