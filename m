Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C659E23C6F0
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHEHac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:30:32 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60648 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgHEHac (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:30:32 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07572gFl017714;
        Wed, 5 Aug 2020 09:04:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=MR0NzTVq272GJr+h7by9Bf1/nQnQ6WI6tLKx+kOBiq8=;
 b=pxs8v3QZByuCYgeM91J0267Ab1GT2GSrjSTFK+e82tgGue/Z8wfkmjK7vVod+41T/gts
 LugbCKvh297n209P/BxBHUwiV5HKYuR77dqHdYv9jFKFzh8WKuvoC48eTkjZSF4LB9D5
 epKNtqfcpeB3pLsMmhpNwmEqf5CjKFJ20MekA5t5YuHXvzaz8TKtXryXgIVYbiKBTw9o
 aXolgbVaZ12vSC7L8y0lH2V045LFpO/6FA5kApWAAhEIh5GqiaAxz9aCn8hWfrA2o6vH
 L/bVlmwYZfMb8OwWTVd5YNQSSgvNhNqplHYl4wAg9PapqsBgvLaQvo6Q2ZJ981JoM/o1 JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6sb6qx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA14210003A;
        Wed,  5 Aug 2020 09:04:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DCAEA2A4D8E;
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
Subject: [PATCH 08/18] spi: stm32h7: fix dbg/warn/err conditions in irq handler
Date:   Wed, 5 Aug 2020 09:02:03 +0200
Message-ID: <1596610933-32599-9-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Make spurious interrupts visible. We do not expect to receive
them, so rise at least a warning if it happens.

Don't bother repeating the suspended RX messages; to avoid RX
overrun we have set SPI_CR1_MASRX that enables the automatic
suspended RX so, mainly in irq mode, it's normal that we will
receive SUSP interrupts every time the CPU is too much loaded
or the spi speed too high and we fail to remove on-time the
data from the RX queue. Moreover, when the CPU is overloaded
there is a delay while serving the interrupt. This forces
inactivity on the SPI bus between bytes. So the warning message
"System too slow, spi speed not guaranteed" is inaccurate; the
term "spi speed" is currently used in kernel for the toggling
frequency of the spi CLK pin, which is driven by HW and is not
impacted by CPU overload. The correct term should be
"data throughput".

RX overrun is an error condition that signals a corrupted RX
stream both in dma and in irq modes. Report the error and
abort the transfer in either cases.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 06478643855a..6731e3ff0e50 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -904,14 +904,16 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	mask &= sr;
 
 	if (!mask) {
-		dev_dbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
-			sr, ier);
+		dev_warn(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
+			 sr, ier);
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return IRQ_NONE;
 	}
 
 	if (mask & STM32H7_SPI_SR_SUSP) {
-		dev_warn(spi->dev, "Communication suspended\n");
+		dev_warn_once(spi->dev,
+			      "System too slow is limiting data throughput\n");
+
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi);
 		/*
@@ -924,15 +926,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	}
 
 	if (mask & STM32H7_SPI_SR_OVR) {
-		dev_warn(spi->dev, "Overrun: received value discarded\n");
-		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32h7_spi_read_rxfifo(spi);
-		/*
-		 * If overrun is detected while using DMA, it means that
-		 * something went wrong, so stop the current transfer
-		 */
-		if (spi->cur_usedma)
-			end = true;
+		dev_err(spi->dev, "Overrun: RX data lost\n");
+		end = true;
 		ifcr |= STM32H7_SPI_SR_OVR;
 	}
 
-- 
2.7.4

