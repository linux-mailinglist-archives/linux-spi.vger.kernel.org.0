Return-Path: <linux-spi+bounces-4317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A595F225
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125FA1C22D1E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2C193430;
	Mon, 26 Aug 2024 12:51:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567419306B;
	Mon, 26 Aug 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676690; cv=none; b=X7l2E3nyS6O0wr7cThRGK8EacBxk6fZj8dEpndvlBONW00GiGjxdOA2DqhLHy1OSsMwyUuKowp8Fv5xzXxuSIKBJ6Eb3WrQNcC5QjYjTVTvPMhmygAf6pg2bUixZ2KCSA0meKN6Rat/d2BVdCjYVOJFSvkp6kLlXyV+JvwDu+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676690; c=relaxed/simple;
	bh=z9JA6Q66F3olYpaNlUlg6UIMC86k457zMsOADKO0iAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0R2PLTf2Gtoi6ZklziFeWpEaujMCQvwMPvOqJky3kFetgCz0w8NLw08a38UCJVnwpdcv30jY9rJy52dsi+ao9at1M9caIGouTPwowcj7dfX8czIMydELqGUatcUfrTfLpwfRJXaR0uzY0cCd04ypYQG57PiWpGhR6LJeaUeJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wsr5m2QskzQqhH;
	Mon, 26 Aug 2024 20:46:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0265E14037E;
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
Subject: [PATCH -next 1/2] spi: atmel-quadspi: Fix uninitialized res
Date: Mon, 26 Aug 2024 20:59:12 +0800
Message-ID: <20240826125913.3434305-2-ruanjinjie@huawei.com>
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

The second platform_get_resource_byname() can not be replaced with
devm_platform_ioremap_resource_byname(), because the intermediate "res"
is used to assign for "aq->mmap_size".

Fixes: 3ccea1dedef3 ("spi: atmel-quadspi: Simpify resource lookup")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/atmel-quadspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 2b5c72176711..56dd8dcb86cb 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -608,7 +608,8 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	}
 
 	/* Map the AHB memory */
-	aq->mem = devm_platform_ioremap_resource_byname(pdev, "qspi_mmap");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
+	aq->mem = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(aq->mem)) {
 		dev_err(&pdev->dev, "missing AHB memory\n");
 		return PTR_ERR(aq->mem);
-- 
2.34.1


