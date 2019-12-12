Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46E811CEF2
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfLLN4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 08:56:13 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56958 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfLLN4N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 08:56:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCDu0cx130447;
        Thu, 12 Dec 2019 07:56:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576158960;
        bh=Nf2gNb/jS/G6cUNn8sWiq6/8AS6dlAnuvnEznHwOdRM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k6uYh5bU2/zzgvk7pRIgiuqGcu8mz94qs7oiyHD8Ih1TVnUuBzZR0/ZYEYBOLJvD3
         XJeSkDnN29o+7pHzUZrULOcrPZZzPRix0f7nPfoUaU7u0oBzHz/PcxY6r1NFHfrijW
         JfD2AOjbCNWzyhkgJ82tPVSPrQBpJD3NkuEks8nE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDu071116442;
        Thu, 12 Dec 2019 07:56:00 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 07:55:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 07:55:59 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDtdqU048444;
        Thu, 12 Dec 2019 07:55:56 -0600
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
Subject: [PATCH 4/9] spi: img-spfi: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 12 Dec 2019 15:55:45 +0200
Message-ID: <20191212135550.4634-5-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-img-spfi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index f4a8f470aecc..8543f5ed1099 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -666,8 +666,22 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->unprepare_message = img_spfi_unprepare;
 	master->handle_err = img_spfi_handle_err;
 
-	spfi->tx_ch = dma_request_slave_channel(spfi->dev, "tx");
-	spfi->rx_ch = dma_request_slave_channel(spfi->dev, "rx");
+	spfi->tx_ch = dma_request_chan(spfi->dev, "tx");
+	if (IS_ERR(spfi->tx_ch)) {
+		ret = PTR_ERR(spfi->tx_ch);
+		spfi->tx_ch = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto disable_pm;
+	}
+
+	spfi->rx_ch = dma_request_chan(spfi->dev, "rx");
+	if (IS_ERR(spfi->rx_ch)) {
+		ret = PTR_ERR(spfi->rx_ch);
+		spfi->rx_ch = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto disable_pm;
+	}
+
 	if (!spfi->tx_ch || !spfi->rx_ch) {
 		if (spfi->tx_ch)
 			dma_release_channel(spfi->tx_ch);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

