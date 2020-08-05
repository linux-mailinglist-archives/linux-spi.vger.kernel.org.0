Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407A623C73F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHEH41 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:56:27 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:55055 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgHEH41 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:56:27 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573JXs012759;
        Wed, 5 Aug 2020 09:04:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=rC8MG2TwzcCBnSco9L6WaejFMXt4W3X2nbpLdDLuuHA=;
 b=NrxIqsEPcTYkJKpEK62nSrBqHcQja8jLVega7QHjwpc6zc7VE1cQy/vW9mPYQmBCiKFo
 rKmrPBGI9Gx5s7lml669az3Z8wBGV1DT0f43UazF1A1GgvPrYo2Tq2oqVLTY9FoIFpXQ
 ACSTqoT88/9ItatWSJ5x1FrtgW5N2IWLt3dPIa8JPJ2aN0MzWB58COq+0GLD0OQFkz5P
 23r4MaqGnk4Jj6BvDs7stgqPoFgEpQhYd9xqMmzMdP3PE3dBVATLC+KHKNSRMYskwsLL
 tcwGRxR9kwpgySevp5wquvgkZlDio6edtXUt3DWOY10bake4uB4UDxaHV90w1ZBy912j 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6theqhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F60A100034;
        Wed,  5 Aug 2020 09:04:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F2862A4D90;
        Wed,  5 Aug 2020 09:04:15 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:14
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 04/18] spi: stm32: use bitfield macros
Date:   Wed, 5 Aug 2020 09:01:59 +0200
Message-ID: <1596610933-32599-5-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

To avoid defining shift and mask separately and hand-coding the bit
manipulation, use the bitfield macros.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 55 ++++++++++++++++---------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index df22dea784d9..a5b926a5c4d9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2017, STMicroelectronics - All Rights Reserved
 // Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
 
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -30,8 +31,8 @@
 #define STM32F4_SPI_CR1_CPHA		BIT(0)
 #define STM32F4_SPI_CR1_CPOL		BIT(1)
 #define STM32F4_SPI_CR1_MSTR		BIT(2)
-#define STM32F4_SPI_CR1_BR_SHIFT	3
 #define STM32F4_SPI_CR1_BR		GENMASK(5, 3)
+#define STM32F4_SPI_CR1_BR_SHIFT	3
 #define STM32F4_SPI_CR1_SPE		BIT(6)
 #define STM32F4_SPI_CR1_LSBFRST		BIT(7)
 #define STM32F4_SPI_CR1_SSI		BIT(8)
@@ -93,27 +94,22 @@
 #define STM32H7_SPI_CR1_SSI		BIT(12)
 
 /* STM32H7_SPI_CR2 bit fields */
-#define STM32H7_SPI_CR2_TSIZE_SHIFT	0
 #define STM32H7_SPI_CR2_TSIZE		GENMASK(15, 0)
+#define STM32H7_SPI_TSIZE_MAX		GENMASK(15, 0)
 
 /* STM32H7_SPI_CFG1 bit fields */
-#define STM32H7_SPI_CFG1_DSIZE_SHIFT	0
 #define STM32H7_SPI_CFG1_DSIZE		GENMASK(4, 0)
-#define STM32H7_SPI_CFG1_FTHLV_SHIFT	5
 #define STM32H7_SPI_CFG1_FTHLV		GENMASK(8, 5)
 #define STM32H7_SPI_CFG1_RXDMAEN	BIT(14)
 #define STM32H7_SPI_CFG1_TXDMAEN	BIT(15)
-#define STM32H7_SPI_CFG1_MBR_SHIFT	28
 #define STM32H7_SPI_CFG1_MBR		GENMASK(30, 28)
+#define STM32H7_SPI_CFG1_MBR_SHIFT	28
 #define STM32H7_SPI_CFG1_MBR_MIN	0
 #define STM32H7_SPI_CFG1_MBR_MAX	(GENMASK(30, 28) >> 28)
 
 /* STM32H7_SPI_CFG2 bit fields */
-#define STM32H7_SPI_CFG2_MIDI_SHIFT	4
 #define STM32H7_SPI_CFG2_MIDI		GENMASK(7, 4)
-#define STM32H7_SPI_CFG2_COMM_SHIFT	17
 #define STM32H7_SPI_CFG2_COMM		GENMASK(18, 17)
-#define STM32H7_SPI_CFG2_SP_SHIFT	19
 #define STM32H7_SPI_CFG2_SP		GENMASK(21, 19)
 #define STM32H7_SPI_CFG2_MASTER		BIT(22)
 #define STM32H7_SPI_CFG2_LSBFRST	BIT(23)
@@ -137,7 +133,6 @@
 #define STM32H7_SPI_SR_EOT		BIT(3)
 #define STM32H7_SPI_SR_OVR		BIT(6)
 #define STM32H7_SPI_SR_SUSP		BIT(11)
-#define STM32H7_SPI_SR_RXPLVL_SHIFT	13
 #define STM32H7_SPI_SR_RXPLVL		GENMASK(14, 13)
 #define STM32H7_SPI_SR_RXWNE		BIT(15)
 
@@ -412,9 +407,7 @@ static int stm32h7_spi_get_bpw_mask(struct stm32_spi *spi)
 	stm32_spi_set_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_DSIZE);
 
 	cfg1 = readl_relaxed(spi->base + STM32H7_SPI_CFG1);
-	max_bpw = (cfg1 & STM32H7_SPI_CFG1_DSIZE) >>
-		  STM32H7_SPI_CFG1_DSIZE_SHIFT;
-	max_bpw += 1;
+	max_bpw = FIELD_GET(STM32H7_SPI_CFG1_DSIZE, cfg1) + 1;
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -591,8 +584,7 @@ static void stm32f4_spi_read_rx(struct stm32_spi *spi)
 static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 {
 	u32 sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
-	u32 rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
-		     STM32H7_SPI_SR_RXPLVL_SHIFT;
+	u32 rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 
 	while ((spi->rx_len > 0) &&
 	       ((sr & STM32H7_SPI_SR_RXP) ||
@@ -619,8 +611,7 @@ static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 		}
 
 		sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
-		rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
-			 STM32H7_SPI_SR_RXPLVL_SHIFT;
+		rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 	}
 
 	dev_dbg(spi->dev, "%s%s: %d bytes left\n", __func__,
@@ -1380,15 +1371,13 @@ static void stm32h7_spi_set_bpw(struct stm32_spi *spi)
 	bpw = spi->cur_bpw - 1;
 
 	cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
-	cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
-		     STM32H7_SPI_CFG1_DSIZE;
+	cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_DSIZE, bpw);
 
 	spi->cur_fthlv = stm32h7_spi_prepare_fthlv(spi);
 	fthlv = spi->cur_fthlv - 1;
 
 	cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
-	cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
-		     STM32H7_SPI_CFG1_FTHLV;
+	cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_FTHLV, fthlv);
 
 	writel_relaxed(
 		(readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
@@ -1406,8 +1395,7 @@ static void stm32_spi_set_mbr(struct stm32_spi *spi, u32 mbrdiv)
 	u32 clrb = 0, setb = 0;
 
 	clrb |= spi->cfg->regs->br.mask;
-	setb |= ((u32)mbrdiv << spi->cfg->regs->br.shift) &
-		spi->cfg->regs->br.mask;
+	setb |= (mbrdiv << spi->cfg->regs->br.shift) & spi->cfg->regs->br.mask;
 
 	writel_relaxed((readl_relaxed(spi->base + spi->cfg->regs->br.reg) &
 			~clrb) | setb,
@@ -1498,8 +1486,7 @@ static int stm32h7_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 	}
 
 	cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
-	cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
-		     STM32H7_SPI_CFG2_COMM;
+	cfg2_setb |= FIELD_PREP(STM32H7_SPI_CFG2_COMM, mode);
 
 	writel_relaxed(
 		(readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
@@ -1522,14 +1509,14 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
-		u32 midi = min((u32)DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
-			       (u32)STM32H7_SPI_CFG2_MIDI >>
-			       STM32H7_SPI_CFG2_MIDI_SHIFT);
+		u32 midi = min_t(u32,
+				 DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
+				 FIELD_GET(STM32H7_SPI_CFG2_MIDI,
+					   STM32H7_SPI_CFG2_MIDI));
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);
-		cfg2_setb |= (midi << STM32H7_SPI_CFG2_MIDI_SHIFT) &
-			     STM32H7_SPI_CFG2_MIDI;
+		cfg2_setb |= FIELD_PREP(STM32H7_SPI_CFG2_MIDI, midi);
 	}
 
 	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
@@ -1544,14 +1531,8 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
  */
 static int stm32h7_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
 {
-	u32 cr2_clrb = 0, cr2_setb = 0;
-
-	if (nb_words <= (STM32H7_SPI_CR2_TSIZE >>
-			 STM32H7_SPI_CR2_TSIZE_SHIFT)) {
-		cr2_clrb |= STM32H7_SPI_CR2_TSIZE;
-		cr2_setb = nb_words << STM32H7_SPI_CR2_TSIZE_SHIFT;
-		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CR2) &
-				~cr2_clrb) | cr2_setb,
+	if (nb_words <= STM32H7_SPI_TSIZE_MAX) {
+		writel_relaxed(FIELD_PREP(STM32H7_SPI_CR2_TSIZE, nb_words),
 			       spi->base + STM32H7_SPI_CR2);
 	} else {
 		return -EMSGSIZE;
-- 
2.7.4

