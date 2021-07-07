Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57F13BE462
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGGIah (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:37 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230495AbhGGIaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:35 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678Qld7025058;
        Wed, 7 Jul 2021 10:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=O1KNeC18Wnz+O/bheDEu6+e3uNzXHpjc9sjcNExd6EY=;
 b=ZkvW0sCSbYEA3J+Kt58/gD+a+P5K+lKs+jS5ZyNcpR/OZagWKN0IHTgcYbbCAy8Tr4yM
 TrbQY/5yozHGNm5Gtm3vqvKY4tD6URFcS8PyxT53IU00phAHwFYKP4V9Sd5BDCPpIqQu
 sJO4LIgZ2hmsK1ht3fqqMUOL+SEfmrusc8Nk+zk+TXIZRH9EPhHszwxWIQQOQfAZcKIz
 dSf/5Fa+TNDh29ga1gB3iaCE8wdGWzODwH5Z5drbVBfwhQ4QKMZlc7bNTR95QJElLYos
 ieAbV3TRfFZHrJcv4MeAL+nsHUy8uOmao9aOrdT6JM0OeFQrtkPnFl8BoBv9WDRPfbIh TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39n8evr386-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61F6C100034;
        Wed,  7 Jul 2021 10:27:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56FE9215125;
        Wed,  7 Jul 2021 10:27:43 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH v2 6/7] spi: stm32h7: don't wait for EOT and flush fifo on disable
Date:   Wed, 7 Jul 2021 10:27:05 +0200
Message-ID: <1625646426-5826-7-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In nominal cases, disable is called as part of the unprepare_message,
after receiving a EOT and after receiving all data so it doesn't
make sense to check for EOT and empty the FIFO.
Moreover, at the end of the disable, the SPI is disable (SPE) leading
to clear of all internal FIFO, leaving the IP in a known status.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index c2144e3c57eb..535f4bebc010 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -677,13 +677,12 @@ static void stm32f4_spi_disable(struct stm32_spi *spi)
  * stm32h7_spi_disable - Disable SPI controller
  * @spi: pointer to the spi controller data structure
  *
- * RX-Fifo is flushed when SPI controller is disabled. To prevent any data
- * loss, use stm32_spi_read_rxfifo to read the remaining bytes in RX-Fifo.
+ * RX-Fifo is flushed when SPI controller is disabled.
  */
 static void stm32h7_spi_disable(struct stm32_spi *spi)
 {
 	unsigned long flags;
-	u32 cr1, sr;
+	u32 cr1;
 
 	dev_dbg(spi->dev, "disable controller\n");
 
@@ -696,25 +695,6 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 		return;
 	}
 
-	/* Wait on EOT or suspend the flow */
-	if (readl_relaxed_poll_timeout_atomic(spi->base + STM32H7_SPI_SR,
-					      sr, !(sr & STM32H7_SPI_SR_EOT),
-					      10, 100000) < 0) {
-		if (cr1 & STM32H7_SPI_CR1_CSTART) {
-			writel_relaxed(cr1 | STM32H7_SPI_CR1_CSUSP,
-				       spi->base + STM32H7_SPI_CR1);
-			if (readl_relaxed_poll_timeout_atomic(
-						spi->base + STM32H7_SPI_SR,
-						sr, !(sr & STM32H7_SPI_SR_SUSP),
-						10, 100000) < 0)
-				dev_warn(spi->dev,
-					 "Suspend request timeout\n");
-		}
-	}
-
-	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
-		stm32h7_spi_read_rxfifo(spi);
-
 	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
 	if (spi->cur_usedma && spi->dma_rx)
-- 
2.25.1

