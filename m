Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB810C293
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 03:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfK1Coi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 21:44:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727656AbfK1Coh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 21:44:37 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E2D785D4B2DD6B3E7B42;
        Thu, 28 Nov 2019 10:44:35 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 10:44:29 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] spi/topcliff-pch: Remove unneeded semicolon
Date:   Thu, 28 Nov 2019 10:51:52 +0800
Message-ID: <1574909512-24260-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixes coccicheck warning:

drivers/spi/spi-topcliff-pch.c:866:47-48: Unneeded semicolon
drivers/spi/spi-topcliff-pch.c:881:53-54: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 223353f..d7ea6af 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -863,7 +863,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	/* Set Tx DMA */
 	param = &dma->param_tx;
 	param->dma_dev = &dma_dev->dev;
-	param->chan_id = data->ch * 2; /* Tx = 0, 2 */;
+	param->chan_id = data->ch * 2; /* Tx = 0, 2 */
 	param->tx_reg = data->io_base_addr + PCH_SPDWR;
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
@@ -878,7 +878,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	/* Set Rx DMA */
 	param = &dma->param_rx;
 	param->dma_dev = &dma_dev->dev;
-	param->chan_id = data->ch * 2 + 1; /* Rx = Tx + 1 */;
+	param->chan_id = data->ch * 2 + 1; /* Rx = Tx + 1 */
 	param->rx_reg = data->io_base_addr + PCH_SPDRR;
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
--
2.7.4

