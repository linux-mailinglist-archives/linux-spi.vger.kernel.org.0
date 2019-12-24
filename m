Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC57A129D24
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2019 04:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLXDo4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Dec 2019 22:44:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfLXDoz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Dec 2019 22:44:55 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39C8264984EDFA1CBF35;
        Tue, 24 Dec 2019 11:44:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 11:44:45 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/3] spi: imx: use true,false for bool variable
Date:   Tue, 24 Dec 2019 11:52:05 +0800
Message-ID: <1577159526-33689-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
References: <1577159526-33689-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes coccicheck warning:

drivers/spi/spi-imx.c:1233:2-17: WARNING: Assignment of 0/1 to bool variable
drivers/spi/spi-imx.c:1235:2-17: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 49f0099..f4f28a4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1230,9 +1230,9 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	}

 	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
-		spi_imx->usedma = 1;
+		spi_imx->usedma = true;
 	else
-		spi_imx->usedma = 0;
+		spi_imx->usedma = false;

 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx = mx53_ecspi_rx_slave;
--
2.7.4

