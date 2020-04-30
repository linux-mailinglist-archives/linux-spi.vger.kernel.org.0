Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBC51BF45F
	for <lists+linux-spi@lfdr.de>; Thu, 30 Apr 2020 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgD3JoI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Apr 2020 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgD3JoH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Apr 2020 05:44:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF1C035494;
        Thu, 30 Apr 2020 02:44:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so2632950pfx.6;
        Thu, 30 Apr 2020 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3iE0ENs3U+fv2Eqqm2Bnr8UjitFetI73gpHRJaYjHKU=;
        b=ilIpKR0xTF1aZ/g6hXsNtlH3zf2fYi/M9PCp7dr2ymfF41Gje6JPtrCXmX6Ir7fFP7
         y7qqJ/RCU4YiWlYTmQssquDtdWptfOGfVr01IPJMz1T64/t3/0YFMipsXm7bYT0KCcFZ
         GhADDDtSWZTUOnrTm5tUIsXalg4P/SZnHluKCIi4CdUM5eD8B0d7t5hSp8A0t4t26jmY
         uloL2KYSNp8+DnGusiFvAl9oN03NT3HybGOP0+DcaHLXIMxliA8T6x6SvVMHfkPdyIHa
         KfgeQtAiVtD/pWNA+gbzxrrbs8eK2VInhgKwjmKTULw91A6+qT2hIhoDD9qPyiEP/xPt
         TfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3iE0ENs3U+fv2Eqqm2Bnr8UjitFetI73gpHRJaYjHKU=;
        b=nFb6Rtg5raKhoXeuji4mIpi/PYRaoud7neePf6B0La2jlSje530gBQNKeM3Wfufn6w
         H3B18RobaCQ1z/GndvHThlload3Ac7i0QHcJGQJXLc/3T8ZC6tVBqf0S3tvYWYMcRyaE
         rMfBnV+SS+dxQaD+68ohDOPIIHXXkzsqMq7j/6SRdO4zcR6X3TKK1l/X9DDUXzLhis7I
         jAbUwuq3T3vhbzVB7rm5OzbSHbRVcwc1KHS4hEzhzeSnNvix9Jr/I+yQA0Koi4hzrAM+
         NdSj+7IJk21xOWG532EVxJ8fkB2cAjSyew3nQgSGzIPrezlrEJ//iopOne2ZtbHBuaSA
         n7Cw==
X-Gm-Message-State: AGi0Pub2f73ZCSyXGZ6WyGEttqlTXDJ2NSnPGlH37IjFLDde8H7N6dHW
        UA1fp1cW9ahVmWtNe3xglFk=
X-Google-Smtp-Source: APiQypKnHvgqqqAo0U6w7NfYRJ1g2+uwUdHqCvqsCYwfXM+SnrqOWtoCuCALu+75Kg/qIGU36FZMOg==
X-Received: by 2002:a62:1a46:: with SMTP id a67mr2493063pfa.284.1588239846437;
        Thu, 30 Apr 2020 02:44:06 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.101.138])
        by smtp.gmail.com with ESMTPSA id cp22sm1288431pjb.28.2020.04.30.02.44.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:44:05 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@st.com
Cc:     broonie@kernel.org, mcoquelin.stm32@gmail.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon.minfei@gmail.com
Subject: [PATCH 4/4] add SPI_SIMPLEX_RX/SPI_3WIRE_RX support for spi-stm32f4
Date:   Thu, 30 Apr 2020 17:44:00 +0800
Message-Id: <1588239840-11582-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

add SPI_SIMPLEX_RX/SPI_3WIRE_RX in spi-stm32f4.c
for SPI_SIMPLEX_RX , as we running kernel in sdram, so
that the performance is not as good as internal flash,
need add send dummy data out while in rx,
otherwise will get many overrun errors.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/spi/spi-stm32.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 44ac6eb3..680cede 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -388,6 +388,10 @@ static int stm32h7_spi_get_fifo_size(struct stm32_spi *spi)
 	return count;
 }
 
+static void stm32f4_spi_tx_dummy(struct stm32_spi *spi)
+{
+	writeb_relaxed(0x55, spi->base + STM32F4_SPI_DR);
+}
 /**
  * stm32f4_spi_get_bpw_mask - Return bits per word mask
  * @spi: pointer to the spi controller data structure
@@ -811,7 +815,9 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		mask |= STM32F4_SPI_SR_TXE;
 	}
 
-	if (!spi->cur_usedma && spi->cur_comm == SPI_FULL_DUPLEX) {
+	if (!spi->cur_usedma && (spi->cur_comm == SPI_FULL_DUPLEX ||
+				 spi->cur_comm == SPI_SIMPLEX_RX ||
+				 spi->cur_comm == SPI_3WIRE_RX)) {
 		/* TXE flag is set and is handled when RXNE flag occurs */
 		sr &= ~STM32F4_SPI_SR_TXE;
 		mask |= STM32F4_SPI_SR_RXNE | STM32F4_SPI_SR_OVR;
@@ -850,8 +856,10 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		stm32f4_spi_read_rx(spi);
 		if (spi->rx_len == 0)
 			end = true;
-		else /* Load data for discontinuous mode */
+		else if (spi->tx_buf)/* Load data for discontinuous mode */
 			stm32f4_spi_write_tx(spi);
+		else if (spi->cur_comm == SPI_SIMPLEX_RX)
+			stm32f4_spi_tx_dummy(spi);
 	}
 
 end_irq:
@@ -1151,7 +1159,9 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 	/* Enable the interrupts relative to the current communication mode */
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		cr2 |= STM32F4_SPI_CR2_TXEIE;
-	} else if (spi->cur_comm == SPI_FULL_DUPLEX) {
+	} else if (spi->cur_comm == SPI_FULL_DUPLEX ||
+				spi->cur_comm == SPI_SIMPLEX_RX ||
+				spi->cur_comm == SPI_3WIRE_RX) {
 		/* In transmit-only mode, the OVR flag is set in the SR register
 		 * since the received data are never read. Therefore set OVR
 		 * interrupt only when rx buffer is available.
@@ -1170,6 +1180,8 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		stm32f4_spi_write_tx(spi);
+	else if (spi->cur_comm == SPI_SIMPLEX_RX)
+		stm32f4_spi_tx_dummy(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1462,9 +1474,15 @@ static int stm32f4_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
 					STM32F4_SPI_CR1_BIDIMODE |
 					STM32F4_SPI_CR1_BIDIOE);
-	} else if (comm_type == SPI_FULL_DUPLEX) {
+	} else if (comm_type == SPI_FULL_DUPLEX ||
+				comm_type == SPI_SIMPLEX_RX) {
 		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
 					STM32F4_SPI_CR1_BIDIMODE |
+					STM32F4_SPI_CR1_RXONLY);
+	} else if (comm_type == SPI_3WIRE_RX) {
+		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
+					STM32F4_SPI_CR1_BIDIMODE);
+		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
 					STM32F4_SPI_CR1_BIDIOE);
 	} else {
 		return -EINVAL;
-- 
2.7.4

