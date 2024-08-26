Return-Path: <linux-spi+bounces-4316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4390195F222
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A0E1C22BE8
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA1193072;
	Mon, 26 Aug 2024 12:51:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E2192D96;
	Mon, 26 Aug 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676689; cv=none; b=UJvaVao1m/CzIALfdoEhXxtNWZtZ4eFUgxTRJ6zxc+2o8UDc3BMq4CwnBpApQSM3WmQCgMsKFBRqUTCrgWu1ahdDVyyLBEYk/fnM3x06QLYUqaA/a2Mi0YRAVwzdq/kxwHXgM03JfzmLWbjH5hABuD+FvWzWx1Y/idYptXX3Pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676689; c=relaxed/simple;
	bh=FClpLvEy+Sb/DUd1fFllUnLImDszQ3YId+MjUwXLA3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAY5XzjxdkA3N9g1usyj/uLMhoqwmg4Ax7vQUojUh6fiI/jLGaZlAvkXYxdPFNZzN+EFAngj9X8BqWyq4GTNHQfMhJFBqnOh+TvjlBS3xcNQz7ClUYBdnpq4IQ25JErh4CUy/zVjpJW6ZgZnQCxZ0LE9ye1kT3fbNXJmdHxBlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wsr8x2xfjzfZ39;
	Mon, 26 Aug 2024 20:49:21 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FDC21404FC;
	Mon, 26 Aug 2024 20:51:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:51:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/2] spi: atmel-quadspi: Simplify with dev_err_probe()
Date: Mon, 26 Aug 2024 20:59:13 +0800
Message-ID: <20240826125913.3434305-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826125913.3434305-1-ruanjinjie@huawei.com>
References: <20240826125913.3434305-1-ruanjinjie@huawei.com>
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error
is printed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/atmel-quadspi.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 56dd8dcb86cb..936d57869493 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -602,18 +602,16 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	/* Map the registers */
 	aq->regs = devm_platform_ioremap_resource_byname(pdev, "qspi_base");
-	if (IS_ERR(aq->regs)) {
-		dev_err(&pdev->dev, "missing registers\n");
-		return PTR_ERR(aq->regs);
-	}
+	if (IS_ERR(aq->regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(aq->regs),
+				     "missing registers\n");
 
 	/* Map the AHB memory */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
 	aq->mem = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(aq->mem)) {
-		dev_err(&pdev->dev, "missing AHB memory\n");
-		return PTR_ERR(aq->mem);
-	}
+	if (IS_ERR(aq->mem))
+		return dev_err_probe(&pdev->dev, PTR_ERR(aq->mem),
+				     "missing AHB memory\n");
 
 	aq->mmap_size = resource_size(res);
 
@@ -622,17 +620,15 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (IS_ERR(aq->pclk))
 		aq->pclk = devm_clk_get(&pdev->dev, NULL);
 
-	if (IS_ERR(aq->pclk)) {
-		dev_err(&pdev->dev, "missing peripheral clock\n");
-		return PTR_ERR(aq->pclk);
-	}
+	if (IS_ERR(aq->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(aq->pclk),
+				     "missing peripheral clock\n");
 
 	/* Enable the peripheral clock */
 	err = clk_prepare_enable(aq->pclk);
-	if (err) {
-		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to enable the peripheral clock\n");
 
 	aq->caps = of_device_get_match_data(&pdev->dev);
 	if (!aq->caps) {
-- 
2.34.1


