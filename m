Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B7B1CEE51
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgELHhI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELHhH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 03:37:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08155C061A0C;
        Tue, 12 May 2020 00:37:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so9111567pjb.1;
        Tue, 12 May 2020 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+68zUT9ct7q6l7uIUZCLkOn4a7L9BomhNQ5jVg2Zxo=;
        b=dNh34QvshqjNp7DtA3MlOG2kBZxosBMZGl53Z/ldH18Yw5yg6Bcz+2gc/kgnq1Nd5y
         mIaBZTMnY7As80pi/E5gGV/PPR7kubeWI48JIFO6qcfDk13S+dMj5RItEcIsveEQFkLd
         eOi9fcmjAc0frIerTCer7F67YR1NhDS90OdLbshs3UeqTBIB2OhQLHOn8uykYTe+xC1S
         4UX2nIG6VldRDHeKMkKUW+Z+HMq/j8hxXvbgl/api+IT5rUVh7xtjsnU+xE9yZYPukBZ
         +n3pNfceWro8BjxsTesATA3SbdRFwATUv/jIRQUM/JpMC/69kFtz4L5lafJQTMxDIgn0
         NMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+68zUT9ct7q6l7uIUZCLkOn4a7L9BomhNQ5jVg2Zxo=;
        b=AFuEdrafo9kQKi7PXiDJCVNkoNp3v91oedmvSM7ecNXi7edcldsOwuIZUh9W77WE2r
         pKhZAqOARpiRlrgv1Yyf3Sy71R0gaccTxNCsADoBFowsMH12wE+zdxNliTt6fqrt/t6s
         VVM1sL6KvHAAeHzog2CTrqNzOAxlvRv8ErWFYekUzvlge3Jh4XHT11joC+Z4tADYuwQh
         Jx9o+PPnzc5pXlqp+99fCztvXM/hMInSLAw6udAgMVKZcEjPxNMC+joQwKASOw7KZmgO
         t80ksL8Sns5nVspMNCOnmiVutHLhfl/blxg/eD2ZKuQXR80jkq3N2G77OF+VyIQnqNHH
         SLEQ==
X-Gm-Message-State: AGi0PubswIv7rrxzVLFCmEAB+OiAKAQgnBI2RgtPfvCeEoG4Ghw+tPY9
        H/XL/8A8NwDZwJq/ZMqXXPo=
X-Google-Smtp-Source: APiQypIIHFRhIkvjAwcUxwC+9xmufAvKnXQChJcabuuo7RX0G98cZV0dD+L+0+qw56P7H8SyGS0nRA==
X-Received: by 2002:a17:90a:8807:: with SMTP id s7mr17888970pjn.157.1589269026260;
        Tue, 12 May 2020 00:37:06 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id 5sm11732471pjf.19.2020.05.12.00.37.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 00:37:05 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, broonie@kernel.org, p.zabel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, dillonhua@gmail.com,
        dillon.minfei@gmail.com
Subject: [PATCH v2 3/3] spi: stm32: Add SPI_SIMPLEX_RX, SPI_3WIRE_RX support for stm32f4
Date:   Tue, 12 May 2020 15:36:50 +0800
Message-Id: <1589269010-18472-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
References: <1589269010-18472-1-git-send-email-dillon.minfei@gmail.com>
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

first: send command to l3gd20 with read id command in tx_buf,
       rx_buf is null.
second: read id with tx_buf is null, rx_buf not null.

so, for second step, stm32 driver recongise this process is SPI_SIMPLE_RX
from stm32_spi_communication_type, but there is no related process for this
type in stm32f4_spi_set_mode, then we get error from
stm32_spi_transfer_one_setup.

we can use two method to fix this bug.
1, use stm32 spi's "In unidirectional receive-only mode (BIDIMODE=0 and
   RXONLY=1)". but as our code running in sdram, the read latency is
   too large to get so many receive overrun error in interrupts handler.

2, use stm32 spi's "In full-duplex (BIDIMODE=0 and RXONLY=0)", as
   tx_buf is null, we must add dummy data sent out before read data.
   so, add stm32f4_spi_tx_dummy to handle this situation.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/spi/spi-stm32.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 44ac6eb3..bcf1ba7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -388,6 +388,13 @@ static int stm32h7_spi_get_fifo_size(struct stm32_spi *spi)
 	return count;
 }
 
+static void stm32f4_spi_tx_dummy(struct stm32_spi *spi)
+{
+	if (spi->cur_bpw == 16)
+		writew_relaxed(0x5555, spi->base + STM32F4_SPI_DR);
+	else
+		writeb_relaxed(0x55, spi->base + STM32F4_SPI_DR);
+}
 /**
  * stm32f4_spi_get_bpw_mask - Return bits per word mask
  * @spi: pointer to the spi controller data structure
@@ -811,7 +818,9 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		mask |= STM32F4_SPI_SR_TXE;
 	}
 
-	if (!spi->cur_usedma && spi->cur_comm == SPI_FULL_DUPLEX) {
+	if (!spi->cur_usedma && (spi->cur_comm == SPI_FULL_DUPLEX ||
+				 spi->cur_comm == SPI_SIMPLEX_RX ||
+				 spi->cur_comm == SPI_3WIRE_RX)) {
 		/* TXE flag is set and is handled when RXNE flag occurs */
 		sr &= ~STM32F4_SPI_SR_TXE;
 		mask |= STM32F4_SPI_SR_RXNE | STM32F4_SPI_SR_OVR;
@@ -850,8 +859,10 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
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
@@ -1151,7 +1162,9 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
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
@@ -1170,6 +1183,8 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		stm32f4_spi_write_tx(spi);
+	else if (spi->cur_comm == SPI_SIMPLEX_RX)
+		stm32f4_spi_tx_dummy(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1462,10 +1477,16 @@ static int stm32f4_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
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
-- 
2.7.4

