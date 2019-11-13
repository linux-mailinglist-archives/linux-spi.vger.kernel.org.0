Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C435FAD54
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKMJmZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 04:42:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57276 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMJmY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 04:42:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9fxZo063758;
        Wed, 13 Nov 2019 03:41:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638119;
        bh=of9+YUnlenzcOQnPEXYg3kP/q5s7kswFH3PKUJ8PaDE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R2P1fiX/UUTrDgFWBml9TN0Mmdqz0wV7lnggRWwBAN0HRnw8UHp5YmfY7xZ326KM8
         fnPl0BL1P3R+kg6VWIf9wtbcjEsbn7yfxiGvPg5ryElI54AUjU92Z3FpWcYBGtrIPq
         mFrBUkhC07xXwJ/s345+QgYm44axoPwwP0to8lq4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9fxDt080913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:41:59 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:41:41 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:41:41 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9feM3072663;
        Wed, 13 Nov 2019 03:41:54 -0600
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
Subject: [PATCH 3/9] spi: fsl-lpspi: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:42:50 +0200
Message-ID: <20191113094256.1108-4-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 6f4769a53f8a..2cc0ddb4a988 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -675,7 +675,7 @@ static int fsl_lpspi_dma_init(struct device *dev,
 	int ret;
 
 	/* Prepare for TX DMA: */
-	controller->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	controller->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(controller->dma_tx)) {
 		ret = PTR_ERR(controller->dma_tx);
 		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
@@ -684,7 +684,7 @@ static int fsl_lpspi_dma_init(struct device *dev,
 	}
 
 	/* Prepare for RX DMA: */
-	controller->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	controller->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(controller->dma_rx)) {
 		ret = PTR_ERR(controller->dma_rx);
 		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

