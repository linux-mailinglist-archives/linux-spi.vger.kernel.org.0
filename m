Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1D11CEE9
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 14:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfLLN4Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 08:56:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49790 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbfLLN4Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 08:56:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCDuBoE122342;
        Thu, 12 Dec 2019 07:56:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576158971;
        bh=N84nicFtZRDOC4if/LtlJxXAd3jsAQdvY5Hn/7Nnaa8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UAjuQ6DkrcsHCfp0NM1sS9F1OhDfnnaDg9e5p07XmCXAQM3kXTIxymohXQYJ5TlsE
         3zpH8/VlKyo8rzPxoP5I/FzqBMMt73l1SSOsBZnoeX2kp9oqjYu9u41HcDK055OUSA
         sywEIQE37EumheCoSUdZ4Xnv5oPE6nstjs5CtIZQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDuBR9117127;
        Thu, 12 Dec 2019 07:56:11 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 07:56:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 07:56:11 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDtdqX048444;
        Thu, 12 Dec 2019 07:56:07 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <baohua@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 7/9] spi: spi-fsl-dspi: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 12 Dec 2019 15:55:48 +0200
Message-ID: <20191212135550.4634-8-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212135550.4634-1-peter.ujfalusi@ti.com>
References: <20191212135550.4634-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 442cff71a0d2..52ccd8397c35 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -395,17 +395,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	if (!dma)
 		return -ENOMEM;
 
-	dma->chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!dma->chan_rx) {
+	dma->chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
 		dev_err(dev, "rx dma channel not available\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(dma->chan_rx);
 		return ret;
 	}
 
-	dma->chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!dma->chan_tx) {
+	dma->chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
 		dev_err(dev, "tx dma channel not available\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(dma->chan_tx);
 		goto err_tx_channel;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

