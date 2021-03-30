Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36FB34E780
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhC3MbM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:31:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15825 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3Mau (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:30:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8pdk4bjbz9tG6;
        Tue, 30 Mar 2021 20:28:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 20:30:43 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>, <festevam@gmail.com>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH v2] spi: davinci: Use of_device_get_match_data() helper
Date:   Tue, 30 Mar 2021 20:31:14 +0800
Message-ID: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
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
v2: Removed forced type conversions
---
 drivers/spi/spi-davinci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7453a1d..9122235 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -817,19 +817,16 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 			struct davinci_spi *dspi)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct davinci_spi_of_data *spi_data;
+	const struct davinci_spi_of_data *spi_data;
 	struct davinci_spi_platform_data *pdata;
 	unsigned int num_cs, intr_line = 0;
-	const struct of_device_id *match;
 
 	pdata = &dspi->pdata;
 
-	match = of_match_device(davinci_spi_of_match, &pdev->dev);
-	if (!match)
+	spi_data = of_device_get_match_data(&pdev->dev);
+	if (!spi_data)
 		return -ENODEV;
 
-	spi_data = (struct davinci_spi_of_data *)match->data;
-
 	pdata->version = spi_data->version;
 	pdata->prescaler_limit = spi_data->prescaler_limit;
 	/*
-- 
2.7.4

