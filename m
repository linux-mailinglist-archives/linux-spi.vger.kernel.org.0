Return-Path: <linux-spi+bounces-4252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F3E9586EF
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 14:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E571284D73
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48018FDB0;
	Tue, 20 Aug 2024 12:29:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492418FC92;
	Tue, 20 Aug 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156987; cv=none; b=n6NhS6s6uHpKg4q3cGBKULaOCZNXf1xeYKy6ZdCy16QZ6pswXlmZGf2mUi6foKLQoPB/FdmYUTZ/rzEk+Fdr1grpjX1xgCrd9FGkbCrsEfM4DHqHJauhigXk+6yBCyZipTwbDwGULtMFU8M7xTFG+A8+KLDaPDrzB88cqQ6izlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156987; c=relaxed/simple;
	bh=Xg8mPZg905BuEpJkT/BRCHtb6i3uOCc+ZH6dVq+mkXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7GeGZBAobNQzvMj5QL+RRS1x8FQkEjozlWJLq0vREQbF80mOFBGCNj16YgWTjH+yTmGUfCQMtcpX61AXgWqohro+NWH3dsxueQqjUCDyk97DcXOYDxV0y1BU8TkM8glxkdBtbK/muhvDO1LUXBMU8+/bkkIPO6HChTGnSGKCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wp7yk3sLNzhY0f;
	Tue, 20 Aug 2024 20:27:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A0691140138;
	Tue, 20 Aug 2024 20:29:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 20:29:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <linux-spi@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: stm32-qspi: Simpify resource lookup
Date: Tue, 20 Aug 2024 20:37:07 +0800
Message-ID: <20240820123707.1788370-1-ruanjinjie@huawei.com>
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
 drivers/spi/spi-stm32-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 955c920c4b63..46081df73cb0 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -780,15 +780,13 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	qspi = spi_controller_get_devdata(ctrl);
 	qspi->ctrl = ctrl;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi");
-	qspi->io_base = devm_ioremap_resource(dev, res);
+	qspi->io_base = devm_platform_ioremap_resource_byname(pdev, "qspi");
 	if (IS_ERR(qspi->io_base))
 		return PTR_ERR(qspi->io_base);
 
 	qspi->phys_base = res->start;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
-	qspi->mm_base = devm_ioremap_resource(dev, res);
+	qspi->mm_base = devm_platform_ioremap_resource_byname(pdev, "qspi_mm");
 	if (IS_ERR(qspi->mm_base))
 		return PTR_ERR(qspi->mm_base);
 
-- 
2.34.1


