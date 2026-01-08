Return-Path: <linux-spi+bounces-12206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE0ED01BFF
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4289305784D
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717238B9A3;
	Thu,  8 Jan 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="KAlfEiDc"
X-Original-To: linux-spi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299438B98C
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858819; cv=none; b=CuZ2Zk7K/yFY3NHawhf6xvtR46UG1Fj5SAb5LRI/EbaG2OK3wgaKDM8d8TC8SCVqmljgpY9xSa/UXZIdUNEfTBJ6O346H1J0fDxAPK8UyYMcH9OobgG4Gc15xphF6MKPwcYm6L8dXt5P8soK83+BLccsu13Ux3wTeYN8LWCm654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858819; c=relaxed/simple;
	bh=ZOCtnOIUDGhtXFxpL7a+j98ZZWNUH6g4Uu4CU4oFuNI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CCNx47Apfk4HBzYfJwut0w/Ueal/wyuhoaNUL5x6ToUKcphGdk2u3DhjjTN1rL0aUNXe43aeglui4GqxiBZWZVpL+tbbzqoGVgr2hgTcf8+MMbZVJ1FCyUWnucsP7ZVUSW3RNbIE+CqilKC8QWjDRvrN44VuctfJg/BMp4AkEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=KAlfEiDc; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iWj7nOUU03u7CJJZ4hIqUKWg1L01ZekPymK3iNDetg0=;
	b=KAlfEiDcTPlBTE0TeRe1SgHGycdGHDWyAl6IiDBzSJZiVp7k48Vtikp3SMGPf3iLR3vMHA9vT
	gguF4bm0TGDw8D7p+wLG+SVla3pldusU69KmQyvinI0lWMLETiqOrAflCig0IixSBjnmym+2icD
	JQo4Ut5Fe2xEcKZ/G0rMz5U=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dmxrz0p39z1K968;
	Thu,  8 Jan 2026 15:50:11 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 099EF402AB;
	Thu,  8 Jan 2026 15:53:25 +0800 (CST)
Received: from kwepemn200006.china.huawei.com (7.202.194.129) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 15:53:24 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn200006.china.huawei.com (7.202.194.129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 15:53:24 +0800
From: Devyn Liu <liudingyuan@h-partners.com>
To: <shenyang39@huawei.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <yubowen8@huawei.com>,
	<zhanjie9@hisilicon.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>, <alireza.sanaee@huawei.com>,
	<salil.mehta@huawei.com>, <shiju.jose@huawei.com>,
	<kong.kongxinwei@hisilicon.com>, <liudingyuan@h-partners.com>,
	<lujunhua7@h-partners.com>
Subject: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization
Date: Thu, 8 Jan 2026 15:53:23 +0800
Message-ID: <20260108075323.3831574-1-liudingyuan@h-partners.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn200006.china.huawei.com (7.202.194.129)

In hisi_spi_debugfs_init, spi controller pointer is calculated
by container_of macro, and the member is hs->dev. But the host
cannot be calculated offset directly by this. (hs->dev) points
to (pdev->dev), and it is the (host->dev.parent) rather than
(host->dev) points to the (pdev->dev), which is set in
__spi_alloc_controller.

In this patch, this issues is fixed by getting the spi_controller
data from pdev->dev by dev_get_drvdata() directly. (dev->driver_data)
points to the spi controller data in the probe stage.

Signed-off-by: Devyn Liu <liudingyuan@h-partners.com>
Reviewed-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index dadf558dd9c0..80a1a15de0bc 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -161,10 +161,8 @@ static const struct debugfs_reg32 hisi_spi_regs[] = {
 static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 {
 	char name[32];
+	struct spi_controller *host = dev_get_drvdata(hs->dev);
 
-	struct spi_controller *host;
-
-	host = container_of(hs->dev, struct spi_controller, dev);
 	snprintf(name, 32, "hisi_spi%d", host->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
 	if (IS_ERR(hs->debugfs))
-- 
2.33.0


