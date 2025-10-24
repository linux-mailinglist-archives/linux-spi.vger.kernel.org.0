Return-Path: <linux-spi+bounces-10815-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308FC047F4
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 08:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A819C19A3B80
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4319C553;
	Fri, 24 Oct 2025 06:31:40 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387818EB0;
	Fri, 24 Oct 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287500; cv=none; b=EbDJYRpIdyOtMNHLCGXml4kDijc1vKPiP/Qxoo1MMKwl4Xx0SvEq0j0v92pPjWagHBXUWVs4Oecw8HkrcqL+Z+3dFCVZgg5T4NI/hqvMxCnw/T36cGdEBt8wR995DzlaMQVYpulyzonu9SI9zN9yhgVQxJXfNF7jkN2+O6qEIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287500; c=relaxed/simple;
	bh=W+VMjUwi3SqExcQLsR0caNUq0NVimjkkzZ0u0W/O/7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfws+iyt7gbjCpGrDb0eJcJw8/qqdbcCLszLSrNd0QK8pK/db3sNUz6KJAVn7BMFxvDEMHXeT3ZXbPwBnOO6bIgqEt67E9+U5m4MijQpkDP/gOhjXuyUpc2mMwBhNTnRP0l/6OUu4k5ZFUSlzHB1+4wPAqd2LMkOF/6Ww9XWNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ctCdS05QBz1R9Zq;
	Fri, 24 Oct 2025 14:28:12 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D641140143;
	Fri, 24 Oct 2025 14:31:34 +0800 (CST)
Received: from kwepemn200006.china.huawei.com (7.202.194.129) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 14:31:34 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn200006.china.huawei.com (7.202.194.129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 14:31:33 +0800
From: Devyn Liu <liudingyuan@h-partners.com>
To: <shenyang39@huawei.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <kangfenglong@huawei.com>,
	<liuyonglong@huawei.com>, <lujunhua7@h-partners.com>, <yubowen8@huawei.com>,
	<liudingyuan@huawei.com>
Subject: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization
Date: Fri, 24 Oct 2025 14:31:33 +0800
Message-ID: <20251024063133.3796584-1-liudingyuan@h-partners.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn200006.china.huawei.com (7.202.194.129)

In hisi_spi_debugfs_init, spi controller pointer is calculated by
container_of macro, and the member is hs->dev. But the host pointer cannot
be calculated offset directly by this, because hs->dev points to the
device in platform device(pdev->dev), and it is the host->dev.parent
points to the pdev->dev, which is set in __spi_alloc_controller.

In this patch, this issues is fixed by getting the spi_controller data
from pdev->dev->driver_data directly, driver_data points to the spi
controller data in the probe stage.

Signed-off-by: Devyn Liu <liudingyuan@h-partners.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index dadf558dd9c0..7458a4bc0856 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -164,7 +164,7 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
 
 	struct spi_controller *host;
 
-	host = container_of(hs->dev, struct spi_controller, dev);
+	host = hs->dev->driver_data;
 	snprintf(name, 32, "hisi_spi%d", host->bus_num);
 	hs->debugfs = debugfs_create_dir(name, NULL);
 	if (IS_ERR(hs->debugfs))
-- 
2.33.0


