Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803D72A8C26
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 02:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgKFBkA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 20:40:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7415 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKFBkA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 20:40:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CS33Y1mmlz737D;
        Fri,  6 Nov 2020 09:39:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 09:39:51 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>, <orsonzhai@gmail.com>,
        <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: sprd: fix reference leak in sprd_spi_remove
Date:   Fri, 6 Nov 2020 09:50:35 +0800
Message-ID: <20201106015035.139574-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to pm_runtime_put_noidle will result in
reference leak in sprd_spi_remove, so we should fix it.

Fixes: e7d973a31c24b ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 635738f54c73..b41a75749b49 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1010,6 +1010,7 @@ static int sprd_spi_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(ss->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(ss->dev);
 		dev_err(ss->dev, "failed to resume SPI controller\n");
 		return ret;
 	}
-- 
2.17.1

