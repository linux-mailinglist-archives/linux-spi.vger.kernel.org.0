Return-Path: <linux-spi+bounces-4747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C2971AAD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649F4284EA6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF81B9B29;
	Mon,  9 Sep 2024 13:19:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFBB1B86D5;
	Mon,  9 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887960; cv=none; b=aaGdAEfvMZ/Fb7K62TNGaZLDWGpC8rwseT0YvWW/z8dgBkRgvjNMs3EN+j99+ku3RuxWOPj+FHzHlcb67DTTpiv8MExCXFPi/kxWREE8CQAUjYcZ9Y3eabstax+ywhIS36aQGKSECOUK97eOo2NwJLjrOQOAnmMSspWLv2A15Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887960; c=relaxed/simple;
	bh=Ki5WA5qqiVF0X1eLtzA8aZ66vWvjlkyfsoxjR89nSRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLZCibopU+18Ofr7mXd19YZ0PwpEIIkPtoGdGp+oaXfxHV/VL94hDbjpfOo7AgXVf20C+VM0UH8WqgqEdpjZi9WibACA8CmOC+gqNfajZ9RHg8SjzIAxfwQDqZC15Knn8Q4bfkPn5ncnk3XPZI1Hp+NT4bHuVL2oX504JJngUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2S4v1hRfz1HJPn;
	Mon,  9 Sep 2024 21:15:43 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CF64180041;
	Mon,  9 Sep 2024 21:19:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:19:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <dianders@chromium.org>, <akashast@codeaurora.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 2/3] spi: geni-qcom: Fix incorrect free_irq() sequence
Date: Mon, 9 Sep 2024 21:28:09 +0800
Message-ID: <20240909132810.1296786-3-ruanjinjie@huawei.com>
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

In spi_geni_remove(), the free_irq() sequence is different from that
on the probe error path. And the IRQ will still remain and it's interrupt
handler may use the dma channel after release dma channel and before free
irq, which is not secure, fix it.

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v4:
- Add reviewed-by.
v3:
- Rebased on the devm_pm_runtime_enable() patch.
- Update the commit message.
---
 drivers/spi/spi-geni-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fef522fece1b..6f4057330444 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1170,9 +1170,9 @@ static void spi_geni_remove(struct platform_device *pdev)
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_controller(spi);
 
-	spi_geni_release_dma_chan(mas);
-
 	free_irq(mas->irq, spi);
+
+	spi_geni_release_dma_chan(mas);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
-- 
2.34.1


