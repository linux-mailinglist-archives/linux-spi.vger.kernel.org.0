Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFD3437B2
	for <lists+linux-spi@lfdr.de>; Mon, 22 Mar 2021 04:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVD5y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 21 Mar 2021 23:57:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13653 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCVD5X (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 21 Mar 2021 23:57:23 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F3gcY1GF9znTTv;
        Mon, 22 Mar 2021 11:54:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 11:57:19 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: imx: Use of_device_get_match_data() helper
Date:   Mon, 22 Mar 2021 11:57:56 +0800
Message-ID: <1616385476-53327-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the of_device_get_match_data() helper instead of open coding.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/spi/spi-imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cf55192..4fe767a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1548,13 +1548,12 @@ static int spi_imx_slave_abort(struct spi_master *master)
 static int spi_imx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-			of_match_device(spi_imx_dt_ids, &pdev->dev);
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int ret, irq, spi_drctl;
-	const struct spi_imx_devtype_data *devtype_data = of_id->data;
+	const struct spi_imx_devtype_data *devtype_data =
+			of_device_get_match_data(&pdev->dev);
 	bool slave_mode;
 	u32 val;
 
-- 
2.7.4

