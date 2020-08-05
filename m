Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482C823C6EB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHEH2d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:28:33 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:17776 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgHEH2d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:28:33 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07572hrU017746;
        Wed, 5 Aug 2020 09:04:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=IxKma3ZgGYqE2Up2PZlJEGac0OiQcXRirgMn7PShygY=;
 b=yeR2cygT/3Tzibk508I/VxZYclbiwW2+lwpvEHSagf/2j+XtNSBgl2QDP2WoIoV3WOpJ
 mtR+vb1xprRhx5ajdReoUVoOf52auphCrGE4vLD53bNsE6FAtycN+6pd8q3Gdh8NxtCN
 XGGzAqxVUaGpjt3dTidt0SX2UYuTVbcf0GPIsiVERf3TC87+hhxvoFYx3ckm65gqZt/f
 6bEx2GWZrFx9ynNLvFZrfUh1raT5mMKlio5QtjumgGhCjBsPft7+W2ECOtzNy7uJrqwA
 Oir0RjKEy2iJaL5Hp+kJgQzd8WvMmXjsAG6k/4FirwDcEbNe1i4GuUL52ZkkXRFzvvmN rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6sb6qwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD5F910002A;
        Wed,  5 Aug 2020 09:04:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0FB12A4D8E;
        Wed,  5 Aug 2020 09:04:14 +0200 (CEST)
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
Subject: [PATCH 03/18] spi: stm32h7: remove unused mode fault MODF event handling
Date:   Wed, 5 Aug 2020 09:01:58 +0200
Message-ID: <1596610933-32599-4-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

Accordingly to STM32H7 document RM0433, "mode fault" MODF is
a special mode to handle a spi bus with multiple masters, in
which each master has to "detect" if another master enables
its CS to take control of the bus. Once this is detected,
all other masters has to temporarily switch to "slave" mode.

Such multi-master mode is not supported in Linux and this
driver properly disables the mode by setting the bits
SPI_CR1_SSI and SPI_CFG2_SSM, thus forcing a master only
operating mode.

In this condition, we will never receive an interrupt due to
MODF event and we do not need to handle it.

Remove all the unused code around handling MODF events.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index eaa416c551c9..df22dea784d9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -129,7 +129,6 @@
 #define STM32H7_SPI_IER_EOTIE		BIT(3)
 #define STM32H7_SPI_IER_TXTFIE		BIT(4)
 #define STM32H7_SPI_IER_OVRIE		BIT(6)
-#define STM32H7_SPI_IER_MODFIE		BIT(9)
 #define STM32H7_SPI_IER_ALL		GENMASK(10, 0)
 
 /* STM32H7_SPI_SR bit fields */
@@ -137,7 +136,6 @@
 #define STM32H7_SPI_SR_TXP		BIT(1)
 #define STM32H7_SPI_SR_EOT		BIT(3)
 #define STM32H7_SPI_SR_OVR		BIT(6)
-#define STM32H7_SPI_SR_MODF		BIT(9)
 #define STM32H7_SPI_SR_SUSP		BIT(11)
 #define STM32H7_SPI_SR_RXPLVL_SHIFT	13
 #define STM32H7_SPI_SR_RXPLVL		GENMASK(14, 13)
@@ -933,11 +931,6 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 			end = true;
 	}
 
-	if (sr & STM32H7_SPI_SR_MODF) {
-		dev_warn(spi->dev, "Mode fault: transfer aborted\n");
-		end = true;
-	}
-
 	if (sr & STM32H7_SPI_SR_OVR) {
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
@@ -1201,7 +1194,7 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	/* Enable the interrupts relative to the end of transfer */
 	ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE |
-	       STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
+	       STM32H7_SPI_IER_OVRIE;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
@@ -1251,8 +1244,7 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 	/* Enable the interrupts relative to the end of transfer */
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
 						 STM32H7_SPI_IER_TXTFIE |
-						 STM32H7_SPI_IER_OVRIE |
-						 STM32H7_SPI_IER_MODFIE);
+						 STM32H7_SPI_IER_OVRIE);
 
 	stm32_spi_enable(spi);
 
-- 
2.7.4

