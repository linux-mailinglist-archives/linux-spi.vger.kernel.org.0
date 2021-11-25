Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D7845DA3B
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 13:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349278AbhKYMqd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 07:46:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47110 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbhKYMoc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Nov 2021 07:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637844083; x=1669380083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Twni1p76FodKjv3xPWrmvD2cFE0XBN5XBjkX4FZSD1U=;
  b=jE7KG+5BF3P484I3mu/P88kgSaXkepu9q903zMke8VmdzlxI10ApC07F
   1RtZftuB+xoed78nZ+u3ZLF99DDhH6BQKTxXQ2qnk7p/xhiAqJXqabWRh
   SnrK7rz/InLNY/uClsdUFbzVJGD89lPSEvRvg6G/3h3j6XJ/F3vZpaZoG
   V3egs+OCktqEs7n5A0bOKR1H8VHHXfmkbaJgehH06EjLMYe59dh44kKPY
   jGiRAJ40YwrgrHIRIPlXrEjAqobK7uB+qEzhpaFJ8yufbKYT9Y71jKsI5
   bnUSwGwu45nLOz9JQCSLRcKShxzB3Hx+rk+fsRMcuqtvTp5Few8eLER3h
   Q==;
IronPort-SDR: kPC96V2z2oiETc3pap99SL43DJNlfOPFpfks2mZw/cOXVpeASiS466SPTT9cZMaBTyDFfu9+aK
 pAD7vIOxc6boCdRc1xkUml+NV9p2fUC6ewL57cRY/0+bsJw7Cdca1PKLrXb/zvuStVQS5tgILY
 ZFa1QUM45RDRcVjR5U8Vzf7hAaAlVHXy5q0s+TgTlWe6othSPxBw4lpEAv+qStvJ6iGse5u32U
 J9GfhGypj+/AOl36hJBLaPgahILPqZpJjQyBFaiYdbTL074QvMmGDP6eAEF32ulmDnoUS1we4k
 aAJxRD+oLMBLyOcWo8XOHcXV
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="144550448"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 05:41:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 05:41:21 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 05:41:19 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] spi: atmel: Drop slave_config argument in atmel_spi_dma_slave_config()
Date:   Thu, 25 Nov 2021 14:41:09 +0200
Message-ID: <20211125124110.838037-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125124110.838037-1-tudor.ambarus@microchip.com>
References: <20211125124110.838037-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The callers passed a pointer to slave_config as an argument of
atmel_spi_dma_slave_config(), but they did not use it afterwards.
Use instead a local variable in atmel_spi_dma_slave_config(), and
stop passing arguments that are not needed in the callers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi-atmel.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f872cf196c2f..22c7239aff75 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -433,26 +433,25 @@ static bool atmel_spi_can_dma(struct spi_master *master,
 
 }
 
-static int atmel_spi_dma_slave_config(struct atmel_spi *as,
-				struct dma_slave_config *slave_config,
-				u8 bits_per_word)
+static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 {
 	struct spi_master *master = platform_get_drvdata(as->pdev);
+	struct dma_slave_config	slave_config;
 	int err = 0;
 
 	if (bits_per_word > 8) {
-		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	} else {
-		slave_config->dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		slave_config->src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	}
 
-	slave_config->dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
-	slave_config->src_addr = (dma_addr_t)as->phybase + SPI_RDR;
-	slave_config->src_maxburst = 1;
-	slave_config->dst_maxburst = 1;
-	slave_config->device_fc = false;
+	slave_config.dst_addr = (dma_addr_t)as->phybase + SPI_TDR;
+	slave_config.src_addr = (dma_addr_t)as->phybase + SPI_RDR;
+	slave_config.src_maxburst = 1;
+	slave_config.dst_maxburst = 1;
+	slave_config.device_fc = false;
 
 	/*
 	 * This driver uses fixed peripheral select mode (PS bit set to '0' in
@@ -468,8 +467,8 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	 * So we'd rather write only one data at the time. Hence the transmit
 	 * path works the same whether FIFOs are available (and enabled) or not.
 	 */
-	slave_config->direction = DMA_MEM_TO_DEV;
-	if (dmaengine_slave_config(master->dma_tx, slave_config)) {
+	slave_config.direction = DMA_MEM_TO_DEV;
+	if (dmaengine_slave_config(master->dma_tx, &slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure tx dma channel\n");
 		err = -EINVAL;
@@ -483,8 +482,8 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	 * So the receive path works the same whether FIFOs are available (and
 	 * enabled) or not.
 	 */
-	slave_config->direction = DMA_DEV_TO_MEM;
-	if (dmaengine_slave_config(master->dma_rx, slave_config)) {
+	slave_config.direction = DMA_DEV_TO_MEM;
+	if (dmaengine_slave_config(master->dma_rx, &slave_config)) {
 		dev_err(&as->pdev->dev,
 			"failed to configure rx dma channel\n");
 		err = -EINVAL;
@@ -496,7 +495,6 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 static int atmel_spi_configure_dma(struct spi_master *master,
 				   struct atmel_spi *as)
 {
-	struct dma_slave_config	slave_config;
 	struct device *dev = &as->pdev->dev;
 	int err;
 
@@ -518,7 +516,7 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 		goto error;
 	}
 
-	err = atmel_spi_dma_slave_config(as, &slave_config, 8);
+	err = atmel_spi_dma_slave_config(as, 8);
 	if (err)
 		goto error;
 
@@ -700,7 +698,6 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	struct dma_chan		*txchan = master->dma_tx;
 	struct dma_async_tx_descriptor *rxdesc;
 	struct dma_async_tx_descriptor *txdesc;
-	struct dma_slave_config	slave_config;
 	dma_cookie_t		cookie;
 
 	dev_vdbg(master->dev.parent, "atmel_spi_next_xfer_dma_submit\n");
@@ -712,8 +709,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 
 	*plen = xfer->len;
 
-	if (atmel_spi_dma_slave_config(as, &slave_config,
-				       xfer->bits_per_word))
+	if (atmel_spi_dma_slave_config(as, xfer->bits_per_word))
 		goto err_exit;
 
 	/* Send both scatterlists */
-- 
2.25.1

