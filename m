Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B523BE465
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhGGIai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29700 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230492AbhGGIaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678MhXF003169;
        Wed, 7 Jul 2021 10:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=JFihWyCt2PJ0euphUNgFoY2OzTe2RhTz2i7OqbL8v4o=;
 b=xi7MGojenQVRco8mrt0iGc3OEnNu1Z9IfqRHRkOHwGpoJC31kcRLIeCwwxSOZcEeeXrC
 YMi+UlHWBBzXC6ZwYMindiKak/5S7qMe6q22TnzGZHE2wNBmEz8/0RupDXPympNlXd45
 /ByBDFgjxDT06xj49NWyi6jKxGkTi1Tfr97647aMMAOCbq0UBRoYaqO0majvqoWwQpm6
 zVMSGuV3Kk9yLTgn5ShmrKcYuD93FtVg6mWNhqak+d4l/nSWpM7DsEwvmaPVARDuj69i
 ZwxUIHSUQ5soRqLtHIFDQlOWlZmzl4yHqsPU6Ta/idZUa2RdFlVy6Ugc+kVgdS1zZQvm Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39mxgxjrb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E764210002A;
        Wed,  7 Jul 2021 10:27:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DB9E5215125;
        Wed,  7 Jul 2021 10:27:42 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul 2021 10:27:42
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 5/7] spi: stm32h7: rework rx fifo read function
Date:   Wed, 7 Jul 2021 10:27:04 +0200
Message-ID: <1625646426-5826-6-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

Remove flush parameter and check RXWNE or RXPLVL when end of transfer
flag is set.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index d37bfead4d8c..c2144e3c57eb 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -570,29 +570,30 @@ static void stm32f4_spi_read_rx(struct stm32_spi *spi)
 /**
  * stm32h7_spi_read_rxfifo - Read bytes in Receive Data Register
  * @spi: pointer to the spi controller data structure
- * @flush: boolean indicating that FIFO should be flushed
  *
  * Write in rx_buf depends on remaining bytes to avoid to write beyond
  * rx_buf end.
  */
-static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
+static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi)
 {
 	u32 sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
 	u32 rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 
 	while ((spi->rx_len > 0) &&
 	       ((sr & STM32H7_SPI_SR_RXP) ||
-		(flush && ((sr & STM32H7_SPI_SR_RXWNE) || (rxplvl > 0))))) {
+		((sr & STM32H7_SPI_SR_EOT) &&
+		 ((sr & STM32H7_SPI_SR_RXWNE) || (rxplvl > 0))))) {
 		u32 offs = spi->cur_xferlen - spi->rx_len;
 
 		if ((spi->rx_len >= sizeof(u32)) ||
-		    (flush && (sr & STM32H7_SPI_SR_RXWNE))) {
+		    (sr & STM32H7_SPI_SR_RXWNE)) {
 			u32 *rx_buf32 = (u32 *)(spi->rx_buf + offs);
 
 			*rx_buf32 = readl_relaxed(spi->base + STM32H7_SPI_RXDR);
 			spi->rx_len -= sizeof(u32);
 		} else if ((spi->rx_len >= sizeof(u16)) ||
-			   (flush && (rxplvl >= 2 || spi->cur_bpw > 8))) {
+			   (!(sr & STM32H7_SPI_SR_RXWNE) &&
+			    (rxplvl >= 2 || spi->cur_bpw > 8))) {
 			u16 *rx_buf16 = (u16 *)(spi->rx_buf + offs);
 
 			*rx_buf16 = readw_relaxed(spi->base + STM32H7_SPI_RXDR);
@@ -608,8 +609,8 @@ static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 		rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 	}
 
-	dev_dbg(spi->dev, "%s%s: %d bytes left\n", __func__,
-		flush ? "(flush)" : "", spi->rx_len);
+	dev_dbg(spi->dev, "%s: %d bytes left (sr=%08x)\n",
+		__func__, spi->rx_len, sr);
 }
 
 /**
@@ -677,12 +678,7 @@ static void stm32f4_spi_disable(struct stm32_spi *spi)
  * @spi: pointer to the spi controller data structure
  *
  * RX-Fifo is flushed when SPI controller is disabled. To prevent any data
- * loss, use stm32h7_spi_read_rxfifo(flush) to read the remaining bytes in
- * RX-Fifo.
- * Normally, if TSIZE has been configured, we should relax the hardware at the
- * reception of the EOT interrupt. But in case of error, EOT will not be
- * raised. So the subsystem unprepare_message call allows us to properly
- * complete the transfer from an hardware point of view.
+ * loss, use stm32_spi_read_rxfifo to read the remaining bytes in RX-Fifo.
  */
 static void stm32h7_spi_disable(struct stm32_spi *spi)
 {
@@ -717,7 +713,7 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 	}
 
 	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
-		stm32h7_spi_read_rxfifo(spi, true);
+		stm32h7_spi_read_rxfifo(spi);
 
 	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
@@ -913,7 +909,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		if (__ratelimit(&rs))
 			dev_dbg_ratelimited(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi);
 		/*
 		 * If communication is suspended while using DMA, it means
 		 * that something went wrong, so stop the current transfer
@@ -934,7 +930,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	if (sr & STM32H7_SPI_SR_EOT) {
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, true);
+			stm32h7_spi_read_rxfifo(spi);
 		end = true;
 	}
 
@@ -944,7 +940,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	if (sr & STM32H7_SPI_SR_RXP)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi);
 
 	writel_relaxed(sr & mask, spi->base + STM32H7_SPI_IFCR);
 
-- 
2.25.1

