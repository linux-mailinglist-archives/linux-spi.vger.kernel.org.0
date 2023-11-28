Return-Path: <linux-spi+bounces-77-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21D7FB5BB
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250AB2826BD
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492B46546;
	Tue, 28 Nov 2023 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4706D0
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:34 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SfcWf6NgYzWhB2;
	Tue, 28 Nov 2023 17:25:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:33 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:28 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 26/26] spi: ljca: switch to use devm_spi_alloc_host()
Date: Tue, 28 Nov 2023 17:30:31 +0800
Message-ID: <20231128093031.3707034-27-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Switch to use modern name function devm_spi_alloc_host().

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ljca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
index c5a066c73817..1cc1422ddba0 100644
--- a/drivers/spi/spi-ljca.c
+++ b/drivers/spi/spi-ljca.c
@@ -223,7 +223,7 @@ static int ljca_spi_probe(struct auxiliary_device *auxdev,
 	struct ljca_spi_dev *ljca_spi;
 	int ret;
 
-	controller = devm_spi_alloc_master(&auxdev->dev, sizeof(*ljca_spi));
+	controller = devm_spi_alloc_host(&auxdev->dev, sizeof(*ljca_spi));
 	if (!controller)
 		return -ENOMEM;
 
-- 
2.25.1


