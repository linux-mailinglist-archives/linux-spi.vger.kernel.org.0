Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0035978D
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 10:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhDIIUO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 04:20:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15995 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhDIIUO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 04:20:14 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGrbb2WcbzvSFv;
        Fri,  9 Apr 2021 16:17:47 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 16:19:51 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] spi: dln2: Fix reference leak to master
Date:   Fri, 9 Apr 2021 08:29:55 +0000
Message-ID: <20210409082955.2907950-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Call spi_master_get() holds the reference count to master device, thus
we need an additional spi_master_put() call to reduce the reference
count, otherwise we will leak a reference to master.

This commit fix it by removing the unnecessary spi_master_get().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-dln2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 3902eadb892f..3ff63ab82f4f 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -781,7 +781,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 
 static int dln2_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = platform_get_drvdata(pdev);
 	struct dln2_spi *dln2 = spi_master_get_devdata(master);
 
 	pm_runtime_disable(&pdev->dev);

