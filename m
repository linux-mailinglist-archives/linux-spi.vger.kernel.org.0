Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E92CEA05
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 09:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgLDIjv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 03:39:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8646 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLDIjv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 03:39:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnR1s2PKFz15XHc;
        Fri,  4 Dec 2020 16:38:41 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 16:38:58 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
CC:     Zhang Changzhong <zhangchangzhong@huawei.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: Fix error return code in dw_spi_bt1_probe()
Date:   Fri, 4 Dec 2020 16:42:37 +0800
Message-ID: <1607071357-33378-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/spi/spi-dw-bt1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index f382dfad..c279b78 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -280,8 +280,10 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
 	dws->bus_num = pdev->id;
 	dws->reg_io_width = 4;
 	dws->max_freq = clk_get_rate(dwsbt1->clk);
-	if (!dws->max_freq)
+	if (!dws->max_freq) {
+		ret = -EINVAL;
 		goto err_disable_clk;
+	}
 
 	init_func = device_get_match_data(&pdev->dev);
 	ret = init_func(pdev, dwsbt1);
-- 
2.9.5

