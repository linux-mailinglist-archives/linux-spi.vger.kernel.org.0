Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426161C70D4
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEFMwQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 08:52:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbgEFMwQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 08:52:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E7E35DC6618286ED034;
        Wed,  6 May 2020 20:52:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 20:52:03 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-spi@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] spi: bcm2835: Fix error return code in bcm2835_dma_init()
Date:   Wed, 6 May 2020 12:56:07 +0000
Message-ID: <20200506125607.90952-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix to return negative error code -ENOMEM from the dma mapping error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-bcm2835.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 11c235879bb7..c4f4bd135279 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -940,6 +940,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	if (dma_mapping_error(ctlr->dma_tx->device->dev, bs->fill_tx_addr)) {
 		dev_err(dev, "cannot map zero page - not using DMA mode\n");
 		bs->fill_tx_addr = 0;
+		ret = -ENOMEM;
 		goto err_release;
 	}
 
@@ -949,6 +950,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 						     DMA_MEM_TO_DEV, 0);
 	if (!bs->fill_tx_desc) {
 		dev_err(dev, "cannot prepare fill_tx_desc - not using DMA mode\n");
+		ret = -ENOMEM;
 		goto err_release;
 	}
 
@@ -979,6 +981,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	if (dma_mapping_error(ctlr->dma_rx->device->dev, bs->clear_rx_addr)) {
 		dev_err(dev, "cannot map clear_rx_cs - not using DMA mode\n");
 		bs->clear_rx_addr = 0;
+		ret = -ENOMEM;
 		goto err_release;
 	}
 
@@ -989,6 +992,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 					   DMA_MEM_TO_DEV, 0);
 		if (!bs->clear_rx_desc[i]) {
 			dev_err(dev, "cannot prepare clear_rx_desc - not using DMA mode\n");
+			ret = -ENOMEM;
 			goto err_release;
 		}



