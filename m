Return-Path: <linux-spi+bounces-4698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C5196E781
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 04:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618EAB2316D
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 02:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3651FDD;
	Fri,  6 Sep 2024 02:04:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9108374F1
	for <linux-spi@vger.kernel.org>; Fri,  6 Sep 2024 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725588257; cv=none; b=UcOjRmFPV0zSQYkuiM+RNvLuMj9JunHwHaPJb1W6YBZaPB297NGE0a7QlDnuCvye+RrOwZiwQu6o8WHOcVdpJLh3/f2BHyFWTbMrQwgde3icswM1o/MU4fTT/NU9j8F4aFqlpGLCdDHBK1XCWO0LkSfqFIkxKzXYJLDZzEZII6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725588257; c=relaxed/simple;
	bh=2S63YJCbvPLZS+UcQ9vTajhGUq/g3pXPmXEv8pWlSHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3xL6rTYVSRTl+QN2AHsDOcY3vYos/CCtJ/Tv+cnUofp0hyM4Pmqr/RZCD+1s4VLR6QLD9AS9tA0MFP6nBpc+uG5cMUd1zKx7lCSAmMv/6XdmrUt6dX00ZueLi6J72SnKGMP09yi6qaTT+3wMuQGuTOo+WlPaERsYV4Vb0acS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X0KK10jflz1S9sH;
	Fri,  6 Sep 2024 10:03:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2143A1402CD;
	Fri,  6 Sep 2024 10:04:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 10:04:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <xiaoning.wang@nxp.com>, <frank.li@nxp.com>,
	<han.xu@nxp.com>, <linux-spi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
Date: Fri, 6 Sep 2024 10:12:51 +0800
Message-ID: <20240906021251.610462-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 944c01a889d9 ("spi: lpspi: enable runtime pm for lpspi")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-fsl-lpspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 350c5d91d869..8f8496578d6b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -986,6 +986,7 @@ static void fsl_lpspi_remove(struct platform_device *pdev)
 
 	fsl_lpspi_dma_exit(controller);
 
+	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);
 	pm_runtime_disable(fsl_lpspi->dev);
 }
 
-- 
2.34.1


