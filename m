Return-Path: <linux-spi+bounces-4320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D40895F2B1
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 15:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB2028489F
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D653186600;
	Mon, 26 Aug 2024 13:18:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F317C9AB;
	Mon, 26 Aug 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678280; cv=none; b=ZJwOsL+xEnJ3Pm+QpAsOhOFbISvojY/Bz870zMDJ9g+Guf/BSYSr6M5spizgE7X4rUgFyho9ILBnaQYbfbuMkq8apXFmS6peqJ8hRvCrthXLQdsog2PRK/Tma40mVAGGAOMzYyvRrCiG2tQ8/X0CZV9xMlKkcyQDRZsXdlyds5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678280; c=relaxed/simple;
	bh=5m6oDVCj9g/ZHRsJq8A7eLQ/veV6ey1+JsGMi6Pnk+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgFx+Tn7+EISTTVlymzumU83sWtf2MCZ+iaO0wbfL8z3lavGnwiW/Y4l46jHw6iL7qzacnpPDAtB/PQ/H/IGDsqwS4F06SUXP32uKSTzpwH6CO3X2CANEV0yg1jXcZdhfl+lo/wZRYCPUsDnJ8noKb+h9FKgRFxA08ubMrn71Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WsrhL4CvRzQqj1;
	Mon, 26 Aug 2024 21:13:06 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 45A7B1401F0;
	Mon, 26 Aug 2024 21:17:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 21:17:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <j.neuschaefer@gmx.net>, <broonie@kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/2] spi: wpcm-fiu: Simplify with dev_err_probe()
Date: Mon, 26 Aug 2024 21:25:44 +0800
Message-ID: <20240826132544.3463616-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826132544.3463616-1-ruanjinjie@huawei.com>
References: <20240826132544.3463616-1-ruanjinjie@huawei.com>
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

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error
is printed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-wpcm-fiu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 05c10b3e6515..a9aee2a6c7dc 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -449,10 +449,9 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 	fiu->dev = dev;
 
 	fiu->regs = devm_platform_ioremap_resource_byname(pdev, "control");
-	if (IS_ERR(fiu->regs)) {
-		dev_err(dev, "Failed to map registers\n");
-		return PTR_ERR(fiu->regs);
-	}
+	if (IS_ERR(fiu->regs))
+		return dev_err_probe(dev, PTR_ERR(fiu->regs),
+				     "Failed to map registers\n");
 
 	fiu->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(fiu->clk))
@@ -461,10 +460,9 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
 	fiu->memory = devm_ioremap_resource(dev, res);
 	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
-	if (IS_ERR(fiu->memory)) {
-		dev_err(dev, "Failed to map flash memory window\n");
-		return PTR_ERR(fiu->memory);
-	}
+	if (IS_ERR(fiu->memory))
+		return dev_err_probe(dev, PTR_ERR(fiu->memory),
+			       "Failed to map flash memory window\n");
 
 	fiu->shm_regmap = syscon_regmap_lookup_by_phandle_optional(dev->of_node, "nuvoton,shm");
 
-- 
2.34.1


