Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5211CEE3
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfLLN4L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 08:56:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40770 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbfLLN4F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 08:56:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCDtqSw063125;
        Thu, 12 Dec 2019 07:55:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576158952;
        bh=/VjfGP3WRkp95PceeWAWMC/LGOv+vDTnn9JLhZJ8NM4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ABuTfH8HNFdORfuhcBqXcsaqeQmzQvcV/Q9Ok0dDxOkbf2JsUpcFq8HtX/18ok+Jf
         LFENwjNTmAr+Cxw6xLoZNRLgucxKnqGfma3cSum7Hy/8pLl1Vu/FWwSuCWPFI+0BIC
         4I3eQPPF5PNOJciIP6uCEwew1yiihdZgUhhXS6+g=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDtqeb116351;
        Thu, 12 Dec 2019 07:55:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 07:55:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 07:55:51 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDtdqS048444;
        Thu, 12 Dec 2019 07:55:48 -0600
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
Subject: [PATCH 2/9] spi: bcm2835: Release the DMA channel if probe fails after dma_init
Date:   Thu, 12 Dec 2019 15:55:43 +0200
Message-ID: <20191212135550.4634-3-peter.ujfalusi@ti.com>
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

The DMA channel was not released if either devm_request_irq() or
devm_spi_register_controller() failed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-bcm2835.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fb61a620effc..662d55e9f21d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1327,20 +1327,22 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
-		goto out_clk_disable;
+		goto out_dma_release;
 	}
 
 	err = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI controller: %d\n",
 			err);
-		goto out_clk_disable;
+		goto out_dma_release;
 	}
 
 	bcm2835_debugfs_create(bs, dev_name(&pdev->dev));
 
 	return 0;
 
+out_dma_release:
+	bcm2835_dma_release(ctlr, bs);
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
 out_controller_put:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

