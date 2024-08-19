Return-Path: <linux-spi+bounces-4223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC5956ADA
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE36282A9F
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D316CD00;
	Mon, 19 Aug 2024 12:26:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5B16CD01;
	Mon, 19 Aug 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070393; cv=none; b=XFC8QZZKyLBtsHMP3zGYRL47L/ORByNIrv1WfPdyktNAEe3XG22zUK9iPM/sHDrBiSu5GtBZjvO7Fg7alcB+cyzf90Cnk45UCctqTKvbtZ5GOHobrVamX5BbhbPl4cxI/qNq1SJ1sVcuKlGfoaHfxEL9P1phlU9ifHmSxe3iL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070393; c=relaxed/simple;
	bh=aK8DHVfkVZISmQEbSj/+H3OwAxquMaD5EXh1ACr8Pe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2SUaa/O+5ksYy96AAD61lIZ+OBi8QQ7nwyKgXvRpaut75KwnSXk1MCViXdHA0oWpwreBK7BcZ6pj8C3H+SkbptYs7ALU0XJmh9BZmSkKJPInH2CIGUWh7r/PidQzQoLFw+H8F81bm8Q7AxVz6/d2z0bj8Jhb+vJ6TByn7/WgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnWt337nkz2Cn02;
	Mon, 19 Aug 2024 20:21:31 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EC3B61A0188;
	Mon, 19 Aug 2024 20:26:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 20:26:29 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jonas.gorski@gmail.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 RESEND 2/2] spi: bcm63xx: Fix missing pm_runtime_disable()
Date: Mon, 19 Aug 2024 20:33:49 +0800
Message-ID: <20240819123349.4020472-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819123349.4020472-1-ruanjinjie@huawei.com>
References: <20240819123349.4020472-1-ruanjinjie@huawei.com>
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

The pm_runtime_disable() is missing in the remove function, fix it
by using devm_pm_runtime_enable(), so the pm_runtime_disable() in
the probe error path can also be removed.

Fixes: 2d13f2ff6073 ("spi: bcm63xx-spi: fix pm_runtime")
Cc: <stable@vger.kernel.org> # v5.13+
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v2:
- Change the fix way.
- Update the commit message.
- Add Suggested-by and Cc stable.
---
 drivers/spi/spi-bcm63xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 289f8a94980b..2fb79701a525 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -583,13 +583,15 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		goto out_clk_disable;
 
 	/* register and we are done */
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
-		goto out_pm_disable;
+		goto out_clk_disable;
 	}
 
 	dev_info(dev, "at %pr (irq %d, FIFOs size %d)\n",
@@ -597,8 +599,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:
-- 
2.34.1


