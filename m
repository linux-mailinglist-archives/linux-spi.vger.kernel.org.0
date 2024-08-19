Return-Path: <linux-spi+bounces-4212-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AAA956286
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 06:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BA01C21360
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB15C613;
	Mon, 19 Aug 2024 04:15:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752013B5A6;
	Mon, 19 Aug 2024 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040937; cv=none; b=H5C3O0nWPOvfr32/3cFUA85FaVYDEcd8fQC43JU/xJd4ySHrxHlPX1LKqlpEc18+htPeANPoat44a3a6I/Yx/eYa6fTxdYpNWyXqSMWImRjvv3z6QkYK2aOkRAyAXZONGZmCdI1RRf50AXbI/dvBDLMfhlYhkhi6zmlRDkoi7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040937; c=relaxed/simple;
	bh=P1Qy6LD2DnIj5FCbq7QVbsr/EdYVpTsDY/fEO4oHpZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uwmt3Zai8cQdn/11LaGHt1KmMJDKuHWIfgT3tytRUCsQFPREHCWeK5YLjzdYje9gWqQhR96HZx0S6b9cXjKPrL5VNeiod3/amj9Lh/E+qbaGtZ8PTAThlcoOaAMfbxdkAi6s5N7nU5FNZhVbKV5Jo9Yuh59Kywi7KfcQcM/NfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnJfF3p4xzyR0m;
	Mon, 19 Aug 2024 11:55:33 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A2FCA140361;
	Mon, 19 Aug 2024 11:55:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 11:55:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jonas.gorski@gmail.com>, <broonie@kernel.org>, <noltari@gmail.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: bcm63xx: Fix missing pm_runtime_disable()
Date: Mon, 19 Aug 2024 12:03:10 +0800
Message-ID: <20240819040310.2801422-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

The pm_runtime_disable() is missing in the remove function, add it to
align with the probe error path.

Fixes: 2d13f2ff6073 ("spi: bcm63xx-spi: fix pm_runtime")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-bcm63xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 289f8a94980b..0531b6f3eef3 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -614,6 +614,8 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
+	pm_runtime_disable(&pdev->dev);
+
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
 }
-- 
2.34.1


