Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A48FAD42
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 10:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfKMJmf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 04:42:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58582 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKMJmf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 04:42:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9g35M082788;
        Wed, 13 Nov 2019 03:42:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638123;
        bh=oKXlql9xtM1tdFz/BhYu3y6UiOAVOfa3WHxAfaksDDc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OBwZGSwhW7kHcindeeiQoEfqcO+H0xHdvXTCytrnO7Ky9tE8bhqwK6hH+o+FyF05n
         ohodYl+aCbHWFh90m16JjPdUWB4mLLXymWIyUmo+xMlMfYcXCjyxKuJ1lHwEvmjbaD
         zpuRqYlnPPaNuH3Mn8Hb7S4nFs/cOiYzYkQusrD4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9g3T7081084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:42:03 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:41:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:41:45 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9feM4072663;
        Wed, 13 Nov 2019 03:41:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <radu_nicolae.pirea@upb.ro>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linus.walleij@linaro.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <andi@etezian.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 4/9] spi: imx: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:42:51 +0200
Message-ID: <20191113094256.1108-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113094256.1108-1-peter.ujfalusi@ti.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 09c9a1edb2c6..49f0099db0cb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1272,7 +1272,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
-	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
 		ret = PTR_ERR(master->dma_tx);
 		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
@@ -1281,7 +1281,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	}
 
 	/* Prepare for RX : */
-	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	master->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(master->dma_rx)) {
 		ret = PTR_ERR(master->dma_rx);
 		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

