Return-Path: <linux-spi+bounces-4253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF639586F4
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 14:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F91F22AAC
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA218CBE6;
	Tue, 20 Aug 2024 12:31:04 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38518B48D;
	Tue, 20 Aug 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157064; cv=none; b=LhYVfe+hQSmJQv7v/OZ13Eyg+d9Xp20HKoSZZzQub7QNxHe64V57f9DdPhbW4dubJdQMTX8V/d1tB9gjwn4HA7nD5rvmwoI68uIB8xhEw5OO1pK5H3yWC0af8nhnpvnzPlFQFDwWkjbnRRp8UHcaXf4fZ8xPUoOeLYYa3A5qYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157064; c=relaxed/simple;
	bh=xGZo4eLDbjtx+gSY2eoHHcyjsbszdXN2a4MU28GqAmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WphC901rPzUI6Smia0EzL/JjHEg3Drglw3wABH650SpJkzIodjjacMHNmaeaYgWxqgHxBKyfx9ixgAWfslCdgyW0Ya1B1CZ8kLhFH1zJCeyT5fnZsuTd2GK5Dg/TI4CIcfC4qurfx6Ep1KaxDUJ79Uh71cafZXA0yyCODMvl+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wp7x65JS9z20mDJ;
	Tue, 20 Aug 2024 20:26:18 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BB0A18002B;
	Tue, 20 Aug 2024 20:30:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 20:30:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: atmel-quadspi: Simpify resource lookup
Date: Tue, 20 Aug 2024 20:38:18 +0800
Message-ID: <20240820123818.1788432-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/atmel-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 5aaff3bee1b7..2b5c72176711 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -601,16 +601,14 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	aq->pdev = pdev;
 
 	/* Map the registers */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
-	aq->regs = devm_ioremap_resource(&pdev->dev, res);
+	aq->regs = devm_platform_ioremap_resource_byname(pdev, "qspi_base");
 	if (IS_ERR(aq->regs)) {
 		dev_err(&pdev->dev, "missing registers\n");
 		return PTR_ERR(aq->regs);
 	}
 
 	/* Map the AHB memory */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
-	aq->mem = devm_ioremap_resource(&pdev->dev, res);
+	aq->mem = devm_platform_ioremap_resource_byname(pdev, "qspi_mmap");
 	if (IS_ERR(aq->mem)) {
 		dev_err(&pdev->dev, "missing AHB memory\n");
 		return PTR_ERR(aq->mem);
-- 
2.34.1


