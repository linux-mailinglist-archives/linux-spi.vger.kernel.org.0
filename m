Return-Path: <linux-spi+bounces-83-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C147FD057
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA771C208DA
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E7107AB;
	Wed, 29 Nov 2023 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE0D40
	for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 00:07:43 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SgBkP074pzvRJ4;
	Wed, 29 Nov 2023 16:07:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 16:07:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 16:07:40 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <william.qiu@starfivetech.com>,
	<hal.feng@starfivetech.com>, <yangyingliang@huawei.com>
Subject: [PATCH] spi: cadence-quadspi: add missing clk_disable_unprepare() in cqspi_probe()
Date: Wed, 29 Nov 2023 16:11:47 +0800
Message-ID: <20231129081147.628004-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

cqspi_jh7110_clk_init() is called after clk_prepare_enable(cqspi->clk),
if it fails, it should goto label 'probe_reset_failed' to disable
cqspi->clk.

In the error path after calling cqspi_jh7110_clk_init(),
cqspi_jh7110_disable_clk() need be called.

Fixes: 33f1ef6d4eb6 ("spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 3d7bf62da11c..f94e0d370d46 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1840,7 +1840,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->jh7110_clk_init) {
 			ret = cqspi_jh7110_clk_init(pdev, cqspi);
 			if (ret)
-				goto probe_clk_failed;
+				goto probe_reset_failed;
 		}
 
 		if (of_device_is_compatible(pdev->dev.of_node,
@@ -1901,6 +1901,8 @@ static int cqspi_probe(struct platform_device *pdev)
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
+	if (cqspi->is_jh7110)
+		cqspi_jh7110_disable_clk(pdev, cqspi);
 	clk_disable_unprepare(cqspi->clk);
 probe_clk_failed:
 	return ret;
-- 
2.25.1


