Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA497310A09
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 12:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBELPv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 06:15:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42454 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231360AbhBELKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 06:10:39 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115ArRs7013726;
        Fri, 5 Feb 2021 12:09:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=qBfGyd+NrOzOpgOTsQTPcxp2CatU64BwW4jRC2ZpIrY=;
 b=Cenv5c0z+L3Kt57IRgaln5ERWEQkW4WYh1WcuKqxAFB+Fav9oDk+vRPeo+z8EIjuFvqJ
 QmLnP9Cf7MxajMhFsun6A64PElB3rarXrH07B3fov1/jlPfuqT7rQxDJLO3QuuFRHvyM
 tAR2cgaifsOeNLlcx1NwJBvnQjReo2u3Ft8cf4rSLrVdu6yBkZURKGha8jVLk9g0tnm6
 WZO7QMFVIslX5mmWFh4zWMejux3EO22zGnWcqJ9pXQOT4iYe7Gkb5mbYe5tmpCEXwyuI
 VgKcc6BbP/358sN/kliP0gGP0wTmQRqMijmgoiKLaKXqsyGFO3gR5l3/4kQkgkyx+Z+N NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36h1ke9hum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:09:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81A7610002A;
        Fri,  5 Feb 2021 12:09:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7590B229F3C;
        Fri,  5 Feb 2021 12:09:46 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 12:09:46
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 6/8] spi: stm32: use bitfield macros
Date:   Fri, 5 Feb 2021 12:09:00 +0100
Message-ID: <1612523342-10466-7-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

To avoid defining shift and mask separately and hand-coding the bit
manipulation, use the bitfield macros.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 54 ++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index c40cea0640e6..cacd5b4b6823 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2017, STMicroelectronics - All Rights Reserved
 // Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
 
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -94,27 +95,22 @@
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
@@ -140,7 +136,6 @@
 #define STM32H7_SPI_SR_OVR		BIT(6)
 #define STM32H7_SPI_SR_MODF		BIT(9)
 #define STM32H7_SPI_SR_SUSP		BIT(11)
-#define STM32H7_SPI_SR_RXPLVL_SHIFT	13
 #define STM32H7_SPI_SR_RXPLVL		GENMASK(14, 13)
 #define STM32H7_SPI_SR_RXWNE		BIT(15)
 
@@ -415,9 +410,7 @@ static int stm32h7_spi_get_bpw_mask(struct stm32_spi *spi)
 	stm32_spi_set_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_DSIZE);
 
 	cfg1 = readl_relaxed(spi->base + STM32H7_SPI_CFG1);
-	max_bpw = (cfg1 & STM32H7_SPI_CFG1_DSIZE) >>
-		  STM32H7_SPI_CFG1_DSIZE_SHIFT;
-	max_bpw += 1;
+	max_bpw = FIELD_GET(STM32H7_SPI_CFG1_DSIZE, cfg1) + 1;
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -585,8 +578,7 @@ static void stm32f4_spi_read_rx(struct stm32_spi *spi)
 static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 {
 	u32 sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
-	u32 rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
-		     STM32H7_SPI_SR_RXPLVL_SHIFT;
+	u32 rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 
 	while ((spi->rx_len > 0) &&
 	       ((sr & STM32H7_SPI_SR_RXP) ||
@@ -613,8 +605,7 @@ static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 		}
 
 		sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
-		rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
-			 STM32H7_SPI_SR_RXPLVL_SHIFT;
+		rxplvl = FIELD_GET(STM32H7_SPI_SR_RXPLVL, sr);
 	}
 
 	dev_dbg(spi->dev, "%s%s: %d bytes left\n", __func__,
@@ -1397,15 +1388,13 @@ static void stm32h7_spi_set_bpw(struct stm32_spi *spi)
 	bpw = spi->cur_bpw - 1;
 
 	cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
-	cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
-		     STM32H7_SPI_CFG1_DSIZE;
+	cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_DSIZE, bpw);
 
 	spi->cur_fthlv = stm32h7_spi_prepare_fthlv(spi, spi->cur_xferlen);
 	fthlv = spi->cur_fthlv - 1;
 
 	cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
-	cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
-		     STM32H7_SPI_CFG1_FTHLV;
+	cfg1_setb |= FIELD_PREP(STM32H7_SPI_CFG1_FTHLV, fthlv);
 
 	writel_relaxed(
 		(readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
@@ -1423,8 +1412,7 @@ static void stm32_spi_set_mbr(struct stm32_spi *spi, u32 mbrdiv)
 	u32 clrb = 0, setb = 0;
 
 	clrb |= spi->cfg->regs->br.mask;
-	setb |= ((u32)mbrdiv << spi->cfg->regs->br.shift) &
-		spi->cfg->regs->br.mask;
+	setb |= (mbrdiv << spi->cfg->regs->br.shift) & spi->cfg->regs->br.mask;
 
 	writel_relaxed((readl_relaxed(spi->base + spi->cfg->regs->br.reg) &
 			~clrb) | setb,
@@ -1515,8 +1503,7 @@ static int stm32h7_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 	}
 
 	cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
-	cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
-		     STM32H7_SPI_CFG2_COMM;
+	cfg2_setb |= FIELD_PREP(STM32H7_SPI_CFG2_COMM, mode);
 
 	writel_relaxed(
 		(readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
@@ -1539,14 +1526,15 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
-		u32 midi = min((u32)DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
-			       (u32)STM32H7_SPI_CFG2_MIDI >>
-			       STM32H7_SPI_CFG2_MIDI_SHIFT);
+		u32 midi = min_t(u32,
+				 DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
+				 FIELD_GET(STM32H7_SPI_CFG2_MIDI,
+				 STM32H7_SPI_CFG2_MIDI));
+
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);
-		cfg2_setb |= (midi << STM32H7_SPI_CFG2_MIDI_SHIFT) &
-			     STM32H7_SPI_CFG2_MIDI;
+		cfg2_setb |= FIELD_PREP(STM32H7_SPI_CFG2_MIDI, midi);
 	}
 
 	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
@@ -1561,14 +1549,8 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
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
2.17.1

