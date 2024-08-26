Return-Path: <linux-spi+bounces-4310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5A95F0D4
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2572AB22F90
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7F17A58C;
	Mon, 26 Aug 2024 12:06:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C416BE09;
	Mon, 26 Aug 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673998; cv=none; b=pbfFpNbTTeLIKAfUd8C3nBOHSU62h6AHrlcYYAsfsFn1sONEI+jttPBMCO2jUu6vPl+8T/Iwx2u9qsoPvY1viqSFwLrZGydkZlSqZ9MGYMDclLqoIuq1moEHj4ZxYo/2mb2kJZY4dAAemkSPSkW6Ry3+bV1r0EjybQWBSR7WaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673998; c=relaxed/simple;
	bh=FMOKZ/Dxqr51t60QbYiJ1JQBeoZ5rXd72CTgkAsuFA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t52OCnNcXxlSKNU908VJwQWYxb0+gCLck9EsXZjs63JR83U0xsV4t1Fw2qf503FldmNUDF3KzKfoIki/9d3nGiz5i0sGpL9ij0GcKQ8zT9s/9nAg7vmnC+Y4YoMUGoU5ZCX+O632yfLxUWHNEl3qJkeNlusV1BcPjRAicTGVx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wsq632Kdlz20mjG;
	Mon, 26 Aug 2024 20:01:47 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 81F6118002B;
	Mon, 26 Aug 2024 20:06:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:06:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/2] spi: zynqmp-gqspi: Use devm_spi_alloc_host()
Date: Mon, 26 Aug 2024 20:14:20 +0800
Message-ID: <20240826121421.3384792-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826121421.3384792-1-ruanjinjie@huawei.com>
References: <20240826121421.3384792-1-ruanjinjie@huawei.com>
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

Use devm_spi_alloc_host() so that there's no need to call
spi_controller_put() in the error path.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 558c466135a5..597fcc7fce82 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1242,7 +1242,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	u32 num_cs;
 	const struct qspi_platform_data *p_data;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*xqspi));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1256,29 +1256,25 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		xqspi->has_tapdelay = true;
 
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xqspi->regs)) {
-		ret = PTR_ERR(xqspi->regs);
-		goto remove_ctlr;
-	}
+	if (IS_ERR(xqspi->regs))
+		return PTR_ERR(xqspi->regs);
 
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(dev, "pclk clock not found.\n");
-		ret = PTR_ERR(xqspi->pclk);
-		goto remove_ctlr;
+		return PTR_ERR(xqspi->pclk);
 	}
 
 	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(dev, "ref_clk clock not found.\n");
-		ret = PTR_ERR(xqspi->refclk);
-		goto remove_ctlr;
+		return PTR_ERR(xqspi->refclk);
 	}
 
 	ret = clk_prepare_enable(xqspi->pclk);
 	if (ret) {
 		dev_err(dev, "Unable to enable APB clock.\n");
-		goto remove_ctlr;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(xqspi->refclk);
@@ -1364,8 +1360,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
-remove_ctlr:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
-- 
2.34.1


