Return-Path: <linux-spi+bounces-4254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C556958706
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 14:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C03282810
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB618DF60;
	Tue, 20 Aug 2024 12:32:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89E28FC;
	Tue, 20 Aug 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157171; cv=none; b=bc+6x5EwkzvCmoJlV0x4dAm4QSuR45cmwg5A/cMBef2NmH58t+/eIw7ClylpehsnN2ZYvwKwptg0Vm7s7Ax606nIwBg1vaQa5AlFLyUeiyDw11QwZMLWOThnJ4IKpf0vgu3v4g8ea2JZZYR9ftdNKIjG4O6pCCshQuZxtJvI+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157171; c=relaxed/simple;
	bh=G21nnuZEOvE5ATHCIdyrfO1DI30El2DybGVF5gL0Lfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TNafEae6CcBwqY6wnZgsOllMRiFRWumwkxY6zMEdpuiq+w9RnTF43f1LC3skCb9AQzU9crQpb/Q8I+1jyhfAf/1su0C4dlYQRFMQEi5mqCvRBCTI7dMxf0MSm7HNkmHW2GoJL851207fgogvrJ7hMupvmw1+RtbcDd3TIfD945w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wp83s0lZbz13X4R;
	Tue, 20 Aug 2024 20:32:09 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CBECB180105;
	Tue, 20 Aug 2024 20:32:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 20:32:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
	<jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<broonie@kernel.org>, <anand.gore@broadcom.com>,
	<florian.fainelli@broadcom.com>, <rafal@milecki.pl>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: bcmbca-hsspi: Simpify resource lookup
Date: Tue, 20 Aug 2024 20:40:11 +0800
Message-ID: <20240820124011.1788479-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Instead of calling platform_get_resource_byname() and
devm_ioremap_resource(), simplify the code by simply calling
devm_platform_ioremap_resource_byname().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-bcmbca-hsspi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 9f64afd8164e..e48a56c68ce7 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -433,7 +433,6 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *host;
 	struct bcmbca_hsspi *bs;
-	struct resource *res_mem;
 	void __iomem *spim_ctrl;
 	void __iomem *regs;
 	struct device *dev = &pdev->dev;
@@ -445,17 +444,11 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsspi");
-	if (!res_mem)
-		return -EINVAL;
-	regs = devm_ioremap_resource(dev, res_mem);
+	regs = devm_platform_ioremap_resource_byname(pdev, "hsspi");
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "spim-ctrl");
-	if (!res_mem)
-		return -EINVAL;
-	spim_ctrl = devm_ioremap_resource(dev, res_mem);
+	spim_ctrl = devm_platform_ioremap_resource_byname(pdev, "spim-ctrl");
 	if (IS_ERR(spim_ctrl))
 		return PTR_ERR(spim_ctrl);
 
-- 
2.34.1


