Return-Path: <linux-spi+bounces-4251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6879586E2
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66ADC282AB9
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437F18F2F9;
	Tue, 20 Aug 2024 12:28:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389662745C;
	Tue, 20 Aug 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156881; cv=none; b=c3bEonkFiY9W02ecNN0y1PBx5su7Ypa8m+cgPomHtHt6PflJQYJOSFEbuEBZV1iJBbYa9rl1kDL1vyRGOgi62S3Nefwhw5xtUe7tFwc7AynTc6FABExG8CLFHzc7t40YjTwOCT9W6k6Yf8f+/f4YFCArzBi7fnGKRciUIkG9Rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156881; c=relaxed/simple;
	bh=gF7YG4a3TnGr8KGTbVqme9uyc9f/6fGl/MYs5e2LrI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swVO0n0OQqBktnlN+6LInSPHJ59KMCEavXfJo8QRt9y8PJ2xwkAenrlVAcTVtiekPoSdPlC+YlMyk/QmAX/72XzN9k9LamEZaho+D+jICZ8WPGQdztKzwM0UJNpqezCkxIDBu1+33WxvZ8YvgoPZGmjhsFPMZWp4ng4tkCkGSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wp7yY6fHmzyR2p;
	Tue, 20 Aug 2024 20:27:33 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 855AF140138;
	Tue, 20 Aug 2024 20:27:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 20:27:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <j.neuschaefer@gmx.net>, <broonie@kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: wpcm-fiu: Use devm_platform_ioremap_resource_byname()
Date: Tue, 20 Aug 2024 20:35:18 +0800
Message-ID: <20240820123518.1788294-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-wpcm-fiu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 886d6d7771d4..47e485fd8f84 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -448,8 +448,7 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 	fiu = spi_controller_get_devdata(ctrl);
 	fiu->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
-	fiu->regs = devm_ioremap_resource(dev, res);
+	fiu->regs = devm_platform_ioremap_resource_byname(pdev, "control");
 	if (IS_ERR(fiu->regs)) {
 		dev_err(dev, "Failed to map registers\n");
 		return PTR_ERR(fiu->regs);
@@ -459,8 +458,7 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 	if (IS_ERR(fiu->clk))
 		return PTR_ERR(fiu->clk);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
-	fiu->memory = devm_ioremap_resource(dev, res);
+	fiu->memory = devm_platform_ioremap_resource_byname(pdev, "memory");
 	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
 	if (IS_ERR(fiu->memory)) {
 		dev_err(dev, "Failed to map flash memory window\n");
-- 
2.34.1


