Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA834CC56
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 11:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhC2JAf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 05:00:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15380 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbhC2I6K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 04:58:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F85zH0bS2zlVmM;
        Mon, 29 Mar 2021 16:56:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:58:04 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: davinci: Use of_device_get_match_data() helper
Date:   Mon, 29 Mar 2021 16:58:36 +0800
Message-ID: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/spi/spi-davinci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7453a1d..869045f 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -820,16 +820,14 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 	struct davinci_spi_of_data *spi_data;
 	struct davinci_spi_platform_data *pdata;
 	unsigned int num_cs, intr_line = 0;
-	const struct of_device_id *match;
 
 	pdata = &dspi->pdata;
 
-	match = of_match_device(davinci_spi_of_match, &pdev->dev);
-	if (!match)
+	spi_data = (struct davinci_spi_of_data *)
+			of_device_get_match_data(&pdev->dev);
+	if (!spi_data)
 		return -ENODEV;
 
-	spi_data = (struct davinci_spi_of_data *)match->data;
-
 	pdata->version = spi_data->version;
 	pdata->prescaler_limit = spi_data->prescaler_limit;
 	/*
-- 
2.7.4

