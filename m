Return-Path: <linux-spi+bounces-4319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C395F2B0
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5532B284515
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2741865E7;
	Mon, 26 Aug 2024 13:18:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DB17C98A;
	Mon, 26 Aug 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678280; cv=none; b=i5JAmrFJHZoyGpeJvlTYso22EgoQonHwYQJpJG1knVmoYcEJpJTAGCY/6W1IrSDJahj1762/ma9nKNMt4D2O+0TOYjbroVRXGVTXpiLCspZqZV1RpvI7kPtCFBknIAjAqBwVxTnyPuMXe0qsB2QiedFXOj2igN2Uq8eAcTLhGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678280; c=relaxed/simple;
	bh=LGxWeWWnDJoSHo4M2oGC73nhWXO3AvzLr7NGSVgLw2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrGyQqdgct4SJw18g0YY4X0rHuicGWcnquQjBB6usRCgoFnCZZ/OW0iwqOwzTAgRVNeGAiUePX1hdA6FrjMrO9VUSlbiKUTg5lvwtVZPq6/wkc4xGDtZqFOPLtJUxGGgaZfVAuqe+cBfAZKMjDtjUfSY8rP/n3CLknSaj/KR5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wsrld1FG8z1xvrl;
	Mon, 26 Aug 2024 21:15:57 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EDC2C1402E1;
	Mon, 26 Aug 2024 21:17:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 21:17:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <j.neuschaefer@gmx.net>, <broonie@kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/2] spi: wpcm-fiu: Fix uninitialized res
Date: Mon, 26 Aug 2024 21:25:43 +0800
Message-ID: <20240826132544.3463616-2-ruanjinjie@huawei.com>
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

The second platform_get_resource_byname() can not be replaced with
devm_platform_ioremap_resource_byname(), because the intermediate "res"
is used by resource_size() later.

Fixes: 3bf2a5359b0b ("spi: wpcm-fiu: Use devm_platform_ioremap_resource_byname()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-wpcm-fiu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 47e485fd8f84..05c10b3e6515 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -458,7 +458,8 @@ static int wpcm_fiu_probe(struct platform_device *pdev)
 	if (IS_ERR(fiu->clk))
 		return PTR_ERR(fiu->clk);
 
-	fiu->memory = devm_platform_ioremap_resource_byname(pdev, "memory");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory");
+	fiu->memory = devm_ioremap_resource(dev, res);
 	fiu->memory_size = min_t(size_t, resource_size(res), MAX_MEMORY_SIZE_TOTAL);
 	if (IS_ERR(fiu->memory)) {
 		dev_err(dev, "Failed to map flash memory window\n");
-- 
2.34.1


