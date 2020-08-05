Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E55823C679
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgHEHEp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:04:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54442 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728333AbgHEHEh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:37 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573OoP002361;
        Wed, 5 Aug 2020 09:04:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=RffTtPmKCv/Aa2h8bw9Avd3hjS+jAC1L4CxYDKOc4jw=;
 b=Z3lRBcUSGbru34zjrzwCPy6d5YlIhLUhDUDxUKiKZ9BZuy2OxFebVV1k9G4fqn+E7Zjk
 NVosWxv3t2aN39PHyIQLk4bu0jYqh0sxh/wcdJDG4NtTVuwDlAmsXAB+q4m+zFqgJ3YB
 qzhm45Bogxeoyuw3KvFJpOOEKBEnIO+Fp2TbScXSoOclwrBwYfkwFIfRLAE48iAIrckw
 SzjMV1ysL80RB2mZYzkmAD2Wxcx01d3TkcuwROaspJXQajcj5shYJP2MMenyPx8WkJax
 Ys4MD8e8Ff2sDAfPc8fmRllFJJ0v8YAkDOC05tBiYxxYODf1z8XDyvBWvTGzZGVY3LqB pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6knf7du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BC9D100038;
        Wed,  5 Aug 2020 09:04:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1CEC82A4D8E;
        Wed,  5 Aug 2020 09:04:16 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:15
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 06/18] spi: stm32h7: fix irq handler
Date:   Wed, 5 Aug 2020 09:02:01 +0200
Message-ID: <1596610933-32599-7-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Check the expected flags in irq handler instead of all flags set in
status register and clear only flags that are not automatically cleared
by hardware.
In case of Full-Duplex mode, DXP flag is set when RXP and TXP flags are
set. But to avoid 2 different handlings, just add TXP and RXP flag in
the mask instead of DXP, and then keep the initial handling of TXP and
RXP events.
Also rephrase comment about EOTIE which is one of the interrupt enable
bits. It is not triggered by any event.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b90367d522f2..bbda73937668 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -131,6 +131,7 @@
 #define STM32H7_SPI_SR_RXP		BIT(0)
 #define STM32H7_SPI_SR_TXP		BIT(1)
 #define STM32H7_SPI_SR_EOT		BIT(3)
+#define STM32H7_SPI_SR_TXTF		BIT(4)
 #define STM32H7_SPI_SR_OVR		BIT(6)
 #define STM32H7_SPI_SR_SUSP		BIT(11)
 #define STM32H7_SPI_SR_RXPLVL		GENMASK(14, 13)
@@ -881,7 +882,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
-	u32 sr, ier, mask;
+	u32 sr, ier, mask, ifcr;
 	unsigned long flags;
 	bool end = false;
 
@@ -889,26 +890,31 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
 	ier = readl_relaxed(spi->base + STM32H7_SPI_IER);
+	ifcr = 0;
 
 	mask = ier;
-	/* EOTIE is triggered on EOT, SUSP and TXC events. */
+	/*
+	 * EOTIE enables irq from EOT, SUSP and TXC events. We need to set
+	 * SUSP to acknowledge it later. TXC is automatically cleared
+	 */
 	mask |= STM32H7_SPI_SR_SUSP;
 	/*
-	 * When TXTF is set, DXPIE and TXPIE are cleared. So in case of
-	 * Full-Duplex, need to poll RXP event to know if there are remaining
-	 * data, before disabling SPI.
+	 * DXPIE is set in Full-Duplex, one IT will be raised if TXP and RXP
+	 * are set. So in case of Full-Duplex, need to poll TXP and RXP event.
 	 */
-	if (spi->rx_buf && !spi->cur_usedma)
-		mask |= STM32H7_SPI_SR_RXP;
+	if ((spi->cur_comm == SPI_FULL_DUPLEX) && (!spi->cur_usedma))
+		mask |= STM32H7_SPI_SR_TXP | STM32H7_SPI_SR_RXP;
 
-	if (!(sr & mask)) {
+	mask &= sr;
+
+	if (!mask) {
 		dev_dbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
 			sr, ier);
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return IRQ_NONE;
 	}
 
-	if (sr & STM32H7_SPI_SR_SUSP) {
+	if (mask & STM32H7_SPI_SR_SUSP) {
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi, false);
@@ -918,9 +924,10 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		 */
 		if (spi->cur_usedma)
 			end = true;
+		ifcr |= STM32H7_SPI_SR_SUSP;
 	}
 
-	if (sr & STM32H7_SPI_SR_OVR) {
+	if (mask & STM32H7_SPI_SR_OVR) {
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi, false);
@@ -930,23 +937,28 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		 */
 		if (spi->cur_usedma)
 			end = true;
+		ifcr |= STM32H7_SPI_SR_OVR;
 	}
 
-	if (sr & STM32H7_SPI_SR_EOT) {
+	if (mask & STM32H7_SPI_SR_TXTF)
+		ifcr |= STM32H7_SPI_SR_TXTF;
+
+	if (mask & STM32H7_SPI_SR_EOT) {
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi, true);
 		end = true;
+		ifcr |= STM32H7_SPI_SR_EOT;
 	}
 
-	if (sr & STM32H7_SPI_SR_TXP)
+	if (mask & STM32H7_SPI_SR_TXP)
 		if (!spi->cur_usedma && (spi->tx_buf && (spi->tx_len > 0)))
 			stm32h7_spi_write_txfifo(spi);
 
-	if (sr & STM32H7_SPI_SR_RXP)
+	if (mask & STM32H7_SPI_SR_RXP)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi, false);
 
-	writel_relaxed(mask, spi->base + STM32H7_SPI_IFCR);
+	writel_relaxed(ifcr, spi->base + STM32H7_SPI_IFCR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-- 
2.7.4

