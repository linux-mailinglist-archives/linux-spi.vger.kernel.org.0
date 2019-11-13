Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5895FAD51
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2019 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKMJmX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Nov 2019 04:42:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57270 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMJmW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Nov 2019 04:42:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9foGi063727;
        Wed, 13 Nov 2019 03:41:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638110;
        bh=fegJH3XV5JIUuk6tq+IcogbPbzoSxpz/U7cv/ovDxeU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ne6/6kT6gu1dhq1MZy+1TiIi/OY/Lx9nNz2sJL30WdvZQRES1IKMyPJ0eUL+EZRBs
         dejMHpbqYUPUOFao6R44aItdChTPale0Cg3cLrLjsGnqQNTGLfnHTmoQ6nj3X8p9JZ
         AL4k+aoQVYY/LKavjzLPL6klUzdv+mLn4Br7ElCk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9foXw001714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:41:50 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:41:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:41:32 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9feM1072663;
        Wed, 13 Nov 2019 03:41:45 -0600
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
Subject: [PATCH 1/9] spi: at91-usart: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:42:48 +0200
Message-ID: <20191113094256.1108-2-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-at91-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a40bb2ef89dc..88033422a42a 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -132,7 +132,7 @@ static int at91_usart_spi_configure_dma(struct spi_controller *ctlr,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	ctlr->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	ctlr->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR_OR_NULL(ctlr->dma_tx)) {
 		if (IS_ERR(ctlr->dma_tx)) {
 			err = PTR_ERR(ctlr->dma_tx);
@@ -145,7 +145,7 @@ static int at91_usart_spi_configure_dma(struct spi_controller *ctlr,
 		goto at91_usart_spi_error_clear;
 	}
 
-	ctlr->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	ctlr->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR_OR_NULL(ctlr->dma_rx)) {
 		if (IS_ERR(ctlr->dma_rx)) {
 			err = PTR_ERR(ctlr->dma_rx);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

