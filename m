Return-Path: <linux-spi+bounces-4313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8595F1AB
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23EF2B21F2E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44DE18785F;
	Mon, 26 Aug 2024 12:41:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66618786E;
	Mon, 26 Aug 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676081; cv=none; b=bWiRaZx7j/bmsrJfPcsaCxQJJsZ0g2ZWkmBfl55x1U3A8XuWalilbvrkcvgkF6KE44KiOq0IWmu25otal+WjvnZzAd905x8UQop+4ECOq//jTA9kvhnXrDACqdq+tVcY0J3i8E200oT6q9VofdKyuWtRRLytU2LyCyNsrtm1rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676081; c=relaxed/simple;
	bh=b2xYKUmE583dRNr1kmPqs3bZR11M38HKifcsQRb6+e0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPMPWwK0+T4JH/XWbYvQdRQ0qyp3e0fVTMn427XXneTvBpi/fwSD4c7J+1RGDjgtKTZnFEgTyZaNDp2MlJQnFVp6uS/nk3pWJvfh2JJFsTs3nd2uqIPSc4pANRY0RLP3Y+s3H6LW6JVoitUmdCqJqn6iQL5DqvahYsKK4hWTIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wsqxk0nGrzpTg3;
	Mon, 26 Aug 2024 20:39:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 312AE18006C;
	Mon, 26 Aug 2024 20:41:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:41:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
	<jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<broonie@kernel.org>, <anand.gore@broadcom.com>,
	<florian.fainelli@broadcom.com>, <rafal@milecki.pl>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/2] spi: bcmbca-hsspi: Use devm_spi_alloc_host()
Date: Mon, 26 Aug 2024 20:49:03 +0800
Message-ID: <20240826124903.3429235-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826124903.3429235-1-ruanjinjie@huawei.com>
References: <20240826124903.3429235-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use devm_spi_alloc_host() so that there's no need to call
spi_controller_put() in the error path.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-bcmbca-hsspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index f465daa473d0..d936104a41ec 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -480,7 +480,7 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*bs));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
 	if (!host) {
 		ret = -ENOMEM;
 		goto out_disable_pll_clk;
@@ -536,17 +536,17 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, irq, bcmbca_hsspi_interrupt, IRQF_SHARED,
 			       pdev->name, bs);
 		if (ret)
-			goto out_put_host;
+			goto out_disable_pll_clk;
 	}
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
-		goto out_put_host;
+		goto out_disable_pll_clk;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
-		goto out_put_host;
+		goto out_disable_pll_clk;
 	}
 
 	/* register and we are done */
@@ -560,8 +560,6 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 out_sysgroup_disable:
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-out_put_host:
-	spi_controller_put(host);
 out_disable_pll_clk:
 	clk_disable_unprepare(pll_clk);
 out_disable_clk:
-- 
2.34.1


