Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BFB23C686
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgHEHFS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:05:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8718 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728314AbgHEHEe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:34 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07572Sl7030166;
        Wed, 5 Aug 2020 09:04:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=3MRwNXcFNhvxFNa+Aw+KEYhccyIrQvOmuOQRumq6L9k=;
 b=PnXKrIQ+Db1H1eqxLrVPJO8WkfcMnLS7fnI3+9rbda+VxEZnMujP9JLqf7bq9lIKVXX7
 5JPR65l5Cx9sJgxiRBB/DJuraZpVsS1JrMBImu+TghD7QTj7DErO0PLkX+2fGwRk6g9b
 nBlkVvhu3Q1Xaod8Tr9y46oeiIka6nh3DnT3UA14BLngEwJLlLnAZC4ZljLIZr1Oo0iH
 uN3Ce2vy7vrIRseO7IXUVQ96D814H98WV0B8eWkO4rB0AJcJZj943l1HcndiKt+zoXX7
 7q65Az/l89WyuVNSPRC2hCm9F7WsOBG+ra3ZQr/+vinHFaFMSz60D/A8JuPMa5st3fm/ Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6hyq7tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C08B0100038;
        Wed,  5 Aug 2020 09:04:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B472F2A4D8E;
        Wed,  5 Aug 2020 09:04:17 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:17
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 10/18] spi: stm32: wait for completion in transfer_one()
Date:   Wed, 5 Aug 2020 09:02:05 +0200
Message-ID: <1596610933-32599-11-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

In irq mode, when cpu is under heavy load and spi speed is set too
high, the irq handler is not fast enough to feed the spi FIFOs.
This does not compromises the data tranferred; the spi clock is
temporarily stopped, the transfer takes longer time and the real
speed is much lower than expected.
The caller of transfer_one(), spi_transfer_one_message(), waits for
the end of current transfer. It sets a timeouts with quite a generous
tolerance of +100% + 100ms, but this can still expire.

We could make transfer_one() blocking till the end of the transfer
and bypass the wait/timeout mechanism in spi_transfer_one_message().
But if for some reason, we never get either an error (OVR, SUSP) event
or end of transfer (EOT) event, xfer_completion will never "complete".
That's why a timeout is useful here to avoid a hang. Timeout delay is
deducted from the transfer length, the real speed and the optional delay
we can add between each data frames. Timeout delay is doubled compared to
the theorical transfer duration.

While doing it to address irq mode only, take benefit of the new
code structure and wait also in dma mode so an eventual error can be
returned to the framework.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 87 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index a931c821c280..7e3894455331 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -240,7 +240,7 @@ struct stm32_spi_cfg {
 	int (*set_mode)(struct stm32_spi *spi, unsigned int comm_type);
 	void (*set_data_idleness)(struct stm32_spi *spi, u32 length);
 	int (*set_number_of_data)(struct stm32_spi *spi, u32 length);
-	void (*transfer_one_dma_start)(struct stm32_spi *spi);
+	int (*transfer_one_dma_start)(struct stm32_spi *spi);
 	void (*dma_rx_cb)(void *data);
 	void (*dma_tx_cb)(void *data);
 	int (*transfer_one_irq)(struct stm32_spi *spi);
@@ -276,6 +276,8 @@ struct stm32_spi_cfg {
  * @dma_tx: dma channel for TX transfer
  * @dma_rx: dma channel for RX transfer
  * @phys_addr: SPI registers physical base address
+ * @xfer_completion: completion to wait for end of transfer
+ * @xfer_status: current transfer status
  */
 struct stm32_spi {
 	struct device *dev;
@@ -303,6 +305,8 @@ struct stm32_spi {
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	dma_addr_t phys_addr;
+	struct completion xfer_completion;
+	int xfer_status;
 };
 
 static const struct stm32_spi_regspec stm32f4_spi_regspec = {
@@ -863,8 +867,8 @@ static irqreturn_t stm32f4_spi_irq_thread(int irq, void *dev_id)
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
-	spi_finalize_current_transfer(master);
 	stm32f4_spi_disable(spi);
+	complete(&spi->xfer_completion);
 
 	return IRQ_HANDLED;
 }
@@ -920,13 +924,16 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		 * If communication is suspended while using DMA, it means
 		 * that something went wrong, so stop the current transfer
 		 */
-		if (spi->cur_usedma)
+		if (spi->cur_usedma) {
+			spi->xfer_status = -EIO;
 			end = true;
+		}
 		ifcr |= STM32H7_SPI_SR_SUSP;
 	}
 
 	if (mask & STM32H7_SPI_SR_OVR) {
 		dev_err(spi->dev, "Overrun: RX data lost\n");
+		spi->xfer_status = -EIO;
 		end = true;
 		ifcr |= STM32H7_SPI_SR_OVR;
 	}
@@ -955,7 +962,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	if (end) {
 		stm32h7_spi_disable(spi);
-		spi_finalize_current_transfer(master);
+		complete(&spi->xfer_completion);
 	}
 
 	return IRQ_HANDLED;
@@ -1026,8 +1033,8 @@ static void stm32f4_spi_dma_tx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
-		spi_finalize_current_transfer(spi->master);
 		stm32f4_spi_disable(spi);
+		complete(&spi->xfer_completion);
 	}
 }
 
@@ -1041,8 +1048,8 @@ static void stm32f4_spi_dma_rx_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 
-	spi_finalize_current_transfer(spi->master);
 	stm32f4_spi_disable(spi);
+	complete(&spi->xfer_completion);
 }
 
 /**
@@ -1124,9 +1131,6 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
  * stm32f4_spi_transfer_one_irq - transfer a single spi_transfer using
  *				  interrupts
  * @spi: pointer to the spi controller data structure
- *
- * It must returns 0 if the transfer is finished or 1 if the transfer is still
- * in progress.
  */
 static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 {
@@ -1160,16 +1164,13 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	return 1;
+	return 0;
 }
 
 /**
  * stm32h7_spi_transfer_one_irq - transfer a single spi_transfer using
  *				  interrupts
  * @spi: pointer to the spi controller data structure
- *
- * It must returns 0 if the transfer is finished or 1 if the transfer is still
- * in progress.
  */
 static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 {
@@ -1202,7 +1203,7 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	return 1;
+	return 0;
 }
 
 /**
@@ -1210,8 +1211,12 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
  *					transfer using DMA
  * @spi: pointer to the spi controller data structure
  */
-static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
+static int stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
 	/* In DMA mode end of transfer is handled by DMA TX or RX callback. */
 	if (spi->cur_comm == SPI_SIMPLEX_RX || spi->cur_comm == SPI_3WIRE_RX ||
 	    spi->cur_comm == SPI_FULL_DUPLEX) {
@@ -1224,6 +1229,10 @@ static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
 	}
 
 	stm32_spi_enable(spi);
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+
+	return 0;
 }
 
 /**
@@ -1231,8 +1240,12 @@ static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
  *					transfer using DMA
  * @spi: pointer to the spi controller data structure
  */
-static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
+static int stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
 	/* Enable the interrupts relative to the end of transfer */
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
 						 STM32H7_SPI_IER_TXTFIE |
@@ -1241,15 +1254,16 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 	stm32_spi_enable(spi);
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+
+	return 0;
 }
 
 /**
  * stm32_spi_transfer_one_dma - transfer a single spi_transfer using DMA
  * @spi: pointer to the spi controller data structure
  * @xfer: pointer to the spi_transfer structure
- *
- * It must returns 0 if the transfer is finished or 1 if the transfer is still
- * in progress.
  */
 static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 				      struct spi_transfer *xfer)
@@ -1325,12 +1339,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		stm32_spi_set_bits(spi, spi->cfg->regs->dma_tx_en.reg,
 				   spi->cfg->regs->dma_tx_en.mask);
 	}
-
-	spi->cfg->transfer_one_dma_start(spi);
-
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	return 1;
+	return spi->cfg->transfer_one_dma_start(spi);
 
 dma_submit_error:
 	if (spi->dma_rx)
@@ -1640,6 +1651,7 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *transfer)
 {
 	struct stm32_spi *spi = spi_master_get_devdata(master);
+	u32 xfer_time, midi_delay_ns;
 	int ret;
 
 	spi->tx_buf = transfer->tx_buf;
@@ -1656,10 +1668,34 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 		return ret;
 	}
 
+	reinit_completion(&spi->xfer_completion);
+	spi->xfer_status = 0;
+
 	if (spi->cur_usedma)
-		return stm32_spi_transfer_one_dma(spi, transfer);
+		ret = stm32_spi_transfer_one_dma(spi, transfer);
 	else
-		return spi->cfg->transfer_one_irq(spi);
+		ret = spi->cfg->transfer_one_irq(spi);
+
+	if (ret)
+		return ret;
+
+	/* Wait for transfer to complete */
+	xfer_time = spi->cur_xferlen * 8 * MSEC_PER_SEC / spi->cur_speed;
+	midi_delay_ns = spi->cur_xferlen * 8 / spi->cur_bpw * spi->cur_midi;
+	xfer_time += DIV_ROUND_UP(midi_delay_ns, NSEC_PER_MSEC);
+	xfer_time = max(2 * xfer_time, 100U);
+
+	ret = wait_for_completion_timeout(&spi->xfer_completion,
+					  (msecs_to_jiffies(xfer_time)));
+	if (!ret) {
+		dev_err(spi->dev, "SPI transfer timeout (%u ms)\n", xfer_time);
+		spi->xfer_status = -ETIMEDOUT;
+		spi->cfg->disable(spi);
+	}
+
+	spi_finalize_current_transfer(master);
+
+	return spi->xfer_status;
 }
 
 /**
@@ -1810,6 +1846,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	spi->dev = &pdev->dev;
 	spi->master = master;
 	spin_lock_init(&spi->lock);
+	init_completion(&spi->xfer_completion);
 
 	spi->cfg = (const struct stm32_spi_cfg *)
 		of_match_device(pdev->dev.driver->of_match_table,
-- 
2.7.4

