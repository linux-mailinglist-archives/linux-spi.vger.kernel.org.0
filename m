Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF82A8C00
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 02:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgKFBNm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 20:13:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7595 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFBNm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 20:13:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CS2TB1r5pzLsn7;
        Fri,  6 Nov 2020 09:13:34 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 09:13:37 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <linux-imx@nxp.com>, <festevam@gmail.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: mxs: fix reference leak in mxs_spi_probe
Date:   Fri, 6 Nov 2020 09:24:21 +0800
Message-ID: <20201106012421.95420-1-zhangqilong3@huawei.com>
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
reference leak in mxs_spi_probe, so we should fix it.

Fixes: b7969caf41a1d ("spi: mxs: implement runtime pm")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 918918a9e049..435309b09227 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -607,6 +607,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(ssp->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(ssp->dev);
 		dev_err(ssp->dev, "runtime_get_sync failed\n");
 		goto out_pm_runtime_disable;
 	}
-- 
2.17.1

