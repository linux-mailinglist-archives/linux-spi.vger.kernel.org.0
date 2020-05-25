Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41261E0597
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbgEYDqR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbgEYDqQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:46:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CF2C061A0E;
        Sun, 24 May 2020 20:46:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a13so6999193pls.8;
        Sun, 24 May 2020 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iDnn3wwO4wgWkpXGhO1cGw9dx9qYzbrC+ZSQIhZHNL0=;
        b=hqbOEvcw06OY6j3P7+bFBZ29tnRr4/lpC0xWTFSN6coegVRH2XXkL7urt589wLipMm
         9D4u54qRumndh0M+ynNLd96aBTpv7rGuosIsdqoKe0oUl09oonBhHmQ1tftXIdKCUrUz
         62r7TG3KJrQ+tAgIfJKzURWIhVbz3VKiSMY190B0+LyG9PDnt4kDrs+bB0/LzLq85dl6
         eLEf/b6pdIViPbDiIwS4nvh52jdOXsvOuRIF7ZiN1248VZHInm9Kr77/fyKcA8+RxAmt
         IjL7mUnnYCgtdrfKHGl1cPKuM7VATRS76PKlRBtTlSy6+tg0eHO+u+JUHIYmKJU4dsHO
         JjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iDnn3wwO4wgWkpXGhO1cGw9dx9qYzbrC+ZSQIhZHNL0=;
        b=cTlz1CXcM+wy8tIIU3I6YNnJUafYNSlssfOoXPqhsF+SwqRzbNKR3ync/BZ9jGtKET
         FOnGVxqYQcqkRi8JCMsE6R0SPqa/0TrhSZV3C38bSyLBEK7WMae12BJUrtaCvdp5+re7
         YQjasRFFxRpA/QVWuRK0SwmeHs+XfFpnApCAkIuERpjFVLgzwSxd4Vr7CcjY1vpBgKZa
         4q/XjBABV9kYODcWZm5wk155BFRhuKf9Xs8HoOldjfZeRPiQiVM9yxi6Xn3NVS8ORulm
         GHEog8aBQa4RBesEIg5yt3p4ETOPRfJDXLje5pnl701EVDfS7MCfJxxL8eeKPIbegZu6
         zPsQ==
X-Gm-Message-State: AOAM533eRTGyrlHvQoT2ezHN5cTA92XgU5IJHxnPAbTomhYfGafgYHOk
        TSsWFWFewg4SwMFwoqXpgiU=
X-Google-Smtp-Source: ABdhPJzOrloW/eMzu31HMmNOhDwme/dtL8g4+OfgiK8OjPyb12J5sr16DZd4Hwdw4Wh811wotDAc6Q==
X-Received: by 2002:a17:90a:985:: with SMTP id 5mr17795701pjo.23.1590378375787;
        Sun, 24 May 2020 20:46:15 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id i98sm12152831pje.37.2020.05.24.20.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:46:15 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 7/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
Date:   Mon, 25 May 2020 11:45:47 +0800
Message-Id: <1590378348-8115-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

in l3gd20 driver startup, there is a setup failed error return from
stm32 spi driver

     "
     [    2.687630] st-gyro-spi spi0.0: supply vdd not found, using dummy
     regulator
     [    2.696869] st-gyro-spi spi0.0: supply vddio not found, using dummy
     regulator
     [    2.706707] spi_stm32 40015000.spi: SPI transfer setup failed
     [    2.713741] st-gyro-spi spi0.0: SPI transfer failed: -22
     [    2.721096] spi_master spi0: failed to transfer one message from queue
     [    2.729268] iio iio:device0: failed to read Who-Am-I register.
     [    2.737504] st-gyro-spi: probe of spi0.0 failed with error -22
     "

after debug into spi-stm32 driver, st-gyro-spi split two steps to read
l3gd20 id

first: send command to l3gd20 with read id command in tx_buf, rx_buf
is null.
second: read id with tx_buf is null, rx_buf not null.

so, for second step, stm32 driver recongise this process as 'SPI_SIMPLE_RX'
from stm32_spi_communication_type(), but there is no related process for this
type in stm32f4_spi_set_mode(), then we get error from
stm32_spi_transfer_one_setup().

we can use two method to fix this bug.
1, use stm32 spi's "In unidirectional receive-only mode (BIDIMODE=0 and
RXONLY=1)". but as our code running in sdram, the read latency is too large
to get so many receive overrun error in interrupts handler.

2, use stm32 spi's "In full-duplex (BIDIMODE=0 and RXONLY=0)", as tx_buf is
null, so add flag 'SPI_MASTER_MUST_TX' to spi master.

Change since V4:
1 remove dummy data sent out by stm32 spi driver
2 add flag 'SPI_MASTER_MUST_TX' to spi master

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Hi Mark,

This changes add 'SPI_MASTER_MUST_TX' for stm32 spi controller

thanks.


 drivers/spi/spi-stm32.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 44ac6eb3..4c643df 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -811,7 +811,9 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		mask |= STM32F4_SPI_SR_TXE;
 	}
 
-	if (!spi->cur_usedma && spi->cur_comm == SPI_FULL_DUPLEX) {
+	if (!spi->cur_usedma && (spi->cur_comm == SPI_FULL_DUPLEX ||
+				spi->cur_comm == SPI_SIMPLEX_RX ||
+				spi->cur_comm == SPI_3WIRE_RX)) {
 		/* TXE flag is set and is handled when RXNE flag occurs */
 		sr &= ~STM32F4_SPI_SR_TXE;
 		mask |= STM32F4_SPI_SR_RXNE | STM32F4_SPI_SR_OVR;
@@ -850,7 +852,7 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		stm32f4_spi_read_rx(spi);
 		if (spi->rx_len == 0)
 			end = true;
-		else /* Load data for discontinuous mode */
+		else if (spi->tx_buf)/* Load data for discontinuous mode */
 			stm32f4_spi_write_tx(spi);
 	}
 
@@ -1151,7 +1153,9 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
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
@@ -1462,10 +1466,16 @@ static int stm32f4_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
 					STM32F4_SPI_CR1_BIDIMODE |
 					STM32F4_SPI_CR1_BIDIOE);
-	} else if (comm_type == SPI_FULL_DUPLEX) {
+	} else if (comm_type == SPI_FULL_DUPLEX ||
+				comm_type == SPI_SIMPLEX_RX) {
 		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
 					STM32F4_SPI_CR1_BIDIMODE |
 					STM32F4_SPI_CR1_BIDIOE);
+	} else if (comm_type == SPI_3WIRE_RX) {
+		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
+					STM32F4_SPI_CR1_BIDIMODE);
+		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
+					STM32F4_SPI_CR1_BIDIOE);
 	} else {
 		return -EINVAL;
 	}
@@ -1906,6 +1916,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->prepare_message = stm32_spi_prepare_msg;
 	master->transfer_one = stm32_spi_transfer_one;
 	master->unprepare_message = stm32_spi_unprepare_msg;
+	master->flags = SPI_MASTER_MUST_TX;
 
 	spi->dma_tx = dma_request_chan(spi->dev, "tx");
 	if (IS_ERR(spi->dma_tx)) {
-- 
2.7.4

