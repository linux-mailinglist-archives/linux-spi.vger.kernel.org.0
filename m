Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852CB3BE466
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGGIaj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60468 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230496AbhGGIaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:35 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678Mna7024407;
        Wed, 7 Jul 2021 10:27:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=qU0WX1c5atYHnfCgyCLb4HvKRNUahZQXZ2p9BujTCwY=;
 b=ekSn5kVk+D0oXZnGKGvvkK67zpS1Qjkcz34XgLU+Sn9n+CujnQRT6xM/u7SRAsLH1dfB
 vDYnm7NQ7bAwoshu4156WcGlyskaXCRRUMplcHRAgy5aGYVQKtCaIaePG6b35Aoz3pW3
 m4ANtkH+HMIa1G4tHUWcyF5FmRU+K+Gg/H7v1UiIzlnF0zqgi6kZASJztTp0wMCDxs2O
 8sDRHn5bsM76wlbH4wsEJJusE3UQDYTbqOCHOpNhwzWINtE+Dbf8JxZh3vn6ohHdp1Le
 DWLOwYOUQOV1TwKo+RTdZgtMe/kDRilMA3C7T2z//S1UrVmXKOQWQgg51VY7UZHHqoPx hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39mnebdasu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED68A10002A;
        Wed,  7 Jul 2021 10:27:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0E01215125;
        Wed,  7 Jul 2021 10:27:43 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul 2021 10:27:43
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 7/7] spi: stm32: finalize message either on dma callback or EOT
Date:   Wed, 7 Jul 2021 10:27:06 +0200
Message-ID: <1625646426-5826-8-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Depending on the usage, it is necessary to perform the finalize
message operation either upon receiving the EOT interruption,
eiher upon receiving the DMA callback. Indeed, when relying
on DMA, even if the SPI EOT IT has been received, it is
necessary to wait for the end of the DMA RX transaction before
accessing to the data.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 57 +++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 535f4bebc010..14ca7ea04e47 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -911,7 +911,10 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	if (sr & STM32H7_SPI_SR_EOT) {
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi);
-		end = true;
+		if (!spi->cur_usedma ||
+		    (spi->cur_usedma && (spi->cur_comm == SPI_SIMPLEX_TX ||
+		     spi->cur_comm == SPI_3WIRE_TX)))
+			end = true;
 	}
 
 	if (sr & STM32H7_SPI_SR_TXP)
@@ -1019,42 +1022,17 @@ static void stm32f4_spi_dma_tx_cb(void *data)
 }
 
 /**
- * stm32f4_spi_dma_rx_cb - dma callback
+ * stm32_spi_dma_rx_cb - dma callback
  * @data: pointer to the spi controller data structure
  *
  * DMA callback is called when the transfer is complete for DMA RX channel.
  */
-static void stm32f4_spi_dma_rx_cb(void *data)
+static void stm32_spi_dma_rx_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 
 	spi_finalize_current_transfer(spi->master);
-	stm32f4_spi_disable(spi);
-}
-
-/**
- * stm32h7_spi_dma_cb - dma callback
- * @data: pointer to the spi controller data structure
- *
- * DMA callback is called when the transfer is complete or when an error
- * occurs. If the transfer is complete, EOT flag is raised.
- */
-static void stm32h7_spi_dma_cb(void *data)
-{
-	struct stm32_spi *spi = data;
-	unsigned long flags;
-	u32 sr;
-
-	spin_lock_irqsave(&spi->lock, flags);
-
-	sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
-
-	spin_unlock_irqrestore(&spi->lock, flags);
-
-	if (!(sr & STM32H7_SPI_SR_EOT))
-		dev_warn(spi->dev, "DMA error (sr=0x%08x)\n", sr);
-
-	/* Now wait for EOT, or SUSP or OVR in case of error */
+	spi->cfg->disable(spi);
 }
 
 /**
@@ -1220,11 +1198,13 @@ static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
  */
 static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 {
-	/* Enable the interrupts relative to the end of transfer */
-	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
-						 STM32H7_SPI_IER_TXTFIE |
-						 STM32H7_SPI_IER_OVRIE |
-						 STM32H7_SPI_IER_MODFIE);
+	uint32_t ier = STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
+
+	/* Enable the interrupts */
+	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX)
+		ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE;
+
+	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
 
 	stm32_spi_enable(spi);
 
@@ -1736,7 +1716,7 @@ static const struct stm32_spi_cfg stm32f4_spi_cfg = {
 	.set_mode = stm32f4_spi_set_mode,
 	.transfer_one_dma_start = stm32f4_spi_transfer_one_dma_start,
 	.dma_tx_cb = stm32f4_spi_dma_tx_cb,
-	.dma_rx_cb = stm32f4_spi_dma_rx_cb,
+	.dma_rx_cb = stm32_spi_dma_rx_cb,
 	.transfer_one_irq = stm32f4_spi_transfer_one_irq,
 	.irq_handler_event = stm32f4_spi_irq_event,
 	.irq_handler_thread = stm32f4_spi_irq_thread,
@@ -1756,8 +1736,11 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	.set_data_idleness = stm32h7_spi_data_idleness,
 	.set_number_of_data = stm32h7_spi_number_of_data,
 	.transfer_one_dma_start = stm32h7_spi_transfer_one_dma_start,
-	.dma_rx_cb = stm32h7_spi_dma_cb,
-	.dma_tx_cb = stm32h7_spi_dma_cb,
+	.dma_rx_cb = stm32_spi_dma_rx_cb,
+	/*
+	 * dma_tx_cb is not necessary since in case of TX, dma is followed by
+	 * SPI access hence handling is performed within the SPI interrupt
+	 */
 	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
 	.irq_handler_thread = stm32h7_spi_irq_thread,
 	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
-- 
2.25.1

