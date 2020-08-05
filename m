Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C415423C677
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgHEHEp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:04:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728330AbgHEHEg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:36 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07572Sl8030166;
        Wed, 5 Aug 2020 09:04:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Roy09aPqq0Q7g5lXc4K4Kk544HN7j9g4NScvr1YV+3A=;
 b=J1f16BKCszXxXEBlLK1zO7uFldHfPTA9fb1TQnWWeEehDWLArFveJLevxiy0xSGVMrbF
 BZoqM42CAN3XRe9aplMmqHR6InBk+R1CKg/zsNbao9ZPhg8x8Yilfzzh9tye/8ToB0DU
 dTbtk1nKCMBmo491MV6TV+oDdMdgNsKUA3I/ng3dJ4v6TJyLfIrZ3h2W440LoLsNnigS
 YAl6GIGFUdUNCxi8CAgDQ43Xhwo7KRpXPE+fuKAor8I9TH2jWszRf5kJnC97vHovKDHU
 +S0WUFPMq/MZb0Y3EIbQ29SfZzpPum+L0gWbsFoNi8ALr6HXgTsppZ7dzxrfmawLqiNP LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6hyq7ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E3C310002A;
        Wed,  5 Aug 2020 09:04:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 824672A4D8E;
        Wed,  5 Aug 2020 09:04:18 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:18
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 12/18] spi: stm32: move spi disable out of irq handler
Date:   Wed, 5 Aug 2020 09:02:07 +0200
Message-ID: <1596610933-32599-13-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

The spi disable could potentially require some time to finish.
It has to be executed at the end of a transfer, but there is
no reason to call it in the irq handler.

Simplify the irq handler by moving out the spi disable. The
synchronization through xfer_completion is used to defer the
execution of spi disable.

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 0eda9903e11e..1a703c4a65db 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -874,7 +874,6 @@ static irqreturn_t stm32f4_spi_irq_thread(int irq, void *dev_id)
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
-	stm32f4_spi_disable(spi);
 	complete(&spi->xfer_completion);
 
 	return IRQ_HANDLED;
@@ -963,15 +962,18 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi);
 
-	writel_relaxed(ifcr, spi->base + STM32H7_SPI_IFCR);
-
-	spin_unlock_irqrestore(&spi->lock, flags);
-
 	if (end) {
-		stm32h7_spi_disable(spi);
+		/* Disable interrupts and clear status flags */
+		writel_relaxed(0, spi->base + STM32H7_SPI_IER);
+		writel_relaxed(STM32H7_SPI_IFCR_ALL,
+			       spi->base + STM32H7_SPI_IFCR);
+
 		complete(&spi->xfer_completion);
+	} else {
+		writel_relaxed(ifcr, spi->base + STM32H7_SPI_IFCR);
 	}
 
+	spin_unlock_irqrestore(&spi->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -1039,10 +1041,8 @@ static void stm32f4_spi_dma_tx_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 
-	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
-		stm32f4_spi_disable(spi);
+	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX)
 		complete(&spi->xfer_completion);
-	}
 }
 
 /**
@@ -1055,7 +1055,6 @@ static void stm32f4_spi_dma_rx_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 
-	stm32f4_spi_disable(spi);
 	complete(&spi->xfer_completion);
 }
 
@@ -1697,9 +1696,10 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	if (!ret) {
 		dev_err(spi->dev, "SPI transfer timeout (%u ms)\n", xfer_time);
 		spi->xfer_status = -ETIMEDOUT;
-		spi->cfg->disable(spi);
 	}
 
+	spi->cfg->disable(spi);
+
 	spi_finalize_current_transfer(master);
 
 	return spi->xfer_status;
-- 
2.7.4

