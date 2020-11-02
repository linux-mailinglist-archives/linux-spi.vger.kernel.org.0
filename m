Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1A92A2D47
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgKBOr6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 09:47:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgKBOr6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Nov 2020 09:47:58 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPwkg072nz15N3g;
        Mon,  2 Nov 2020 22:47:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 22:47:50 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: imx: fix reference leak in two imx operations
Date:   Mon, 2 Nov 2020 22:58:35 +0800
Message-ID: <20201102145835.4765-1-zhangqilong3@huawei.com>
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
reference leak in callers(spi_imx_prepare_message and
spi_imx_remove), so we should fix it.

Fixes: 525c9e5a32bd7 ("spi: imx: enable runtime pm support")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 060b1f5c9b04..e582a6665d26 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1538,6 +1538,7 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
@@ -1740,6 +1741,7 @@ static int spi_imx_remove(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
-- 
2.17.1

