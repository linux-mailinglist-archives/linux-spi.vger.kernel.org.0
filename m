Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9289A23C678
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgHEHEp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:04:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54466 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728377AbgHEHEh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:37 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573OoQ002361;
        Wed, 5 Aug 2020 09:04:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=kkarxm8X3BivcUm0oMUvJCIJanlazmgq3utvhBEALOg=;
 b=sKF0ckelYOW6OTRQA65tlHybrH7UQNV+XVZq7VK138fQc5fe41D7hCoKDbZPhh6w7My1
 c6WEpzAqzExijeFkvK3vx7dtkGNAFK4h6QGZuljasl/D1tkSF+v2R6mWOMkyF1dLuQbq
 QkNNp6KJ5wmP0Ygt1eKIGseATWCBNcx4Kx1hO7hqXqALn9gZkzPwFsQKFIekG/hGW2DC
 uwggWLYa25HZkNkUYOnfWbUGj03zCnGmJrhJwWlbCPol8PL7XctqXe679GZtVnMDdo9d
 DHLp/dJQxfR4UcuEA27vYXjbK3jLSZyKzKvUcYmaJMfv4rObqt9wR3PVtSaM8OHkF2te KQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6knf7dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A011100039;
        Wed,  5 Aug 2020 09:04:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DBF92A4D8E;
        Wed,  5 Aug 2020 09:04:16 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:16
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 07/18] spi: stm32h7: rework rx fifo read function
Date:   Wed, 5 Aug 2020 09:02:02 +0200
Message-ID: <1596610933-32599-8-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Remove flush parameter and check RXWNE or RXPLVL when end of transfer
flag is set.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index bbda73937668..06478643855a 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -575,29 +575,30 @@ static void stm32f4_spi_read_rx(struct stm32_spi *spi)
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
@@ -613,8 +614,8 @@ static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 		rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 	}
 
-	dev_dbg(spi->dev, "%s%s: %d bytes left\n", __func__,
-		flush ? "(flush)" : "", spi->rx_len);
+	dev_dbg(spi->dev, "%s: %d bytes left (sr=%08x)\n",
+		__func__, spi->rx_len, sr);
 }
 
 /**
@@ -682,12 +683,7 @@ static void stm32f4_spi_disable(struct stm32_spi *spi)
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
@@ -722,7 +718,7 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 	}
 
 	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
-		stm32h7_spi_read_rxfifo(spi, true);
+		stm32h7_spi_read_rxfifo(spi);
 
 	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
@@ -917,7 +913,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	if (mask & STM32H7_SPI_SR_SUSP) {
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi);
 		/*
 		 * If communication is suspended while using DMA, it means
 		 * that something went wrong, so stop the current transfer
@@ -930,7 +926,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	if (mask & STM32H7_SPI_SR_OVR) {
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi);
 		/*
 		 * If overrun is detected while using DMA, it means that
 		 * something went wrong, so stop the current transfer
@@ -945,7 +941,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	if (mask & STM32H7_SPI_SR_EOT) {
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, true);
+			stm32h7_spi_read_rxfifo(spi);
 		end = true;
 		ifcr |= STM32H7_SPI_SR_EOT;
 	}
@@ -956,7 +952,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	if (mask & STM32H7_SPI_SR_RXP)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi);
 
 	writel_relaxed(ifcr, spi->base + STM32H7_SPI_IFCR);
 
-- 
2.7.4

