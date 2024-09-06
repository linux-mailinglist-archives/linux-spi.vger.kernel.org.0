Return-Path: <linux-spi+bounces-4703-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE296E7FB
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19401F2494E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FE1E521;
	Fri,  6 Sep 2024 03:05:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71211805A;
	Fri,  6 Sep 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591946; cv=none; b=l0yFbaorotmXkGvm8471Cxh5n+lwFtGFWeiUSGGf7t+WdOMfzVQ0y1MB5Od2+owYVm5ystBeqktud3tdRDvZUOhF4eVMa2+ipL8/jMVpHDj/bWkrv1bhhPTEfyqMns3sfdqY5+6Ozt0vynosEkRm8iXIIjMBhBTn6ZT2+QGAlVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591946; c=relaxed/simple;
	bh=DJRHofKba7PsrhmnqDwT2I/meHOOw0CAuhNH1kZIJH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILfsDuff8oOskKe9Hd9mtJaA/7oayn6YbtOYb7flFOM9FoU7JQTDy2GrF8DsPK6LKQ5sFu7ySYQ1T4sMBWnOm8qeoguivUrKnmOM8iHXt+1vuBjgg1LmSMjK3jrsqzJyXxfWb3EBsluNYPDd+Wf2n+QhAvvhE4mTJGXNsJc6S80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X0LYy0tWlz69YJ;
	Fri,  6 Sep 2024 11:00:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7491C1400DC;
	Fri,  6 Sep 2024 11:05:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 11:05:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <akashast@codeaurora.org>,
	<dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 1/2] spi: geni-qcom: Fix incorrect free_irq() sequence
Date: Fri, 6 Sep 2024 11:13:44 +0800
Message-ID: <20240906031345.1052241-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906031345.1052241-1-ruanjinjie@huawei.com>
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

In spi_geni_remove(), the IRQ will still remain and it's interrupt handler
may use the dma channel after release dma channel and before free irq,
which is not secure, fix it.

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-geni-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 37ef8c40b276..fc2819effe2d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1170,9 +1170,10 @@ static void spi_geni_remove(struct platform_device *pdev)
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_controller(spi);
 
+	free_irq(mas->irq, spi);
+
 	spi_geni_release_dma_chan(mas);
 
-	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.34.1


