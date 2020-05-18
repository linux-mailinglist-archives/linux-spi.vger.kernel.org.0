Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD61D7612
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgERLJt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgERLJs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 07:09:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8219C05BD09;
        Mon, 18 May 2020 04:09:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so4105352plr.0;
        Mon, 18 May 2020 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z0K0/5OzzViPZMz8dEGdWi2fs5WJcxW5HTeiBCJAzcg=;
        b=K4yu4oVsBUAvUVFewNEyHdUY5TBIs/1+QblQu5oIUbAg3rw1Eh9zW0Rm64Hkv5BX/2
         Cl0m3VOfl4AJojsx0o8gSJQ8XSC53BaoiHqcLhCLX6x5AdScum6jYOvNbZirieoVlMfn
         DCCwkqoULLl0Def4J32uJu/sB97pnJq8PsvnamZXrHXQX4Mkdb6QguKIMYzehOAvO6Jf
         TizH3AxhYv06FKMgUpsC9t5T3US4xWGDBaM27bGfaJt61AR7znME3x1nc1DJRGSJI6iG
         n25HPv62AqkKhHUZLEaCH5aGFcj9cysGKRnUROpvGzrnPeZWhFOxIBFvlb+3XudjEin8
         oMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z0K0/5OzzViPZMz8dEGdWi2fs5WJcxW5HTeiBCJAzcg=;
        b=fwF8PjimJ8BO4XV0ZchWvrBqShFCFFt74BWPMvNcljXJnGFwMMwQJu/1f1Dnmd51HG
         CPjyMQD9ikYzS5Rr67H8g12R3IXmN0RreYi8LqER1b71thp7xou9xxJDrQEyxYj5T67K
         E3cHszqB8xqhGVulY7LEy+v/uW54RGyEydyozNvp0mM7PB65h8M7rqMJXAw+g3QvavvK
         Dizd+OiY3sKzKfPsvbTOpMq0gINxQxVpOKg3fD6Vew176p2mmxuZVDrx56u9NLGkRhUf
         eTSIWMIEHIAsyvaP0U4uiCA8bhvwQ5HF1AxBqDR6iKQ50/vsF2Ukp6XD26mbI2w+7k+3
         o4tw==
X-Gm-Message-State: AOAM53344IL+TGbDmO/BbzS5axw5fK8ZYZ8h3HALxajZCHu6HOS8mhn/
        BgKNOVO1hqBpyhxGRtIoTsc=
X-Google-Smtp-Source: ABdhPJyWWs1JYZRi/j45YsKeOBSSYfAuy0RjZQll8EZvS/1kzTOj1iRG54tfK5bmmQSr5ewXc691vw==
X-Received: by 2002:a17:902:9b8e:: with SMTP id y14mr15833614plp.109.1589800188239;
        Mon, 18 May 2020 04:09:48 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id a15sm8290630pju.3.2020.05.18.04.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:09:47 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 3/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
Date:   Mon, 18 May 2020 19:09:20 +0800
Message-Id: <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
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

so, for second step, stm32 driver recongise this process is 'SPI_SIMPLE_RX'
from stm32_spi_communication_type(), but there is no related process for this
type in stm32f4_spi_set_mode(), then we get error from
stm32_spi_transfer_one_setup().

we can use two method to fix this bug.
1, use stm32 spi's "In unidirectional receive-only mode (BIDIMODE=0 and
RXONLY=1)". but as our code running in sdram, the read latency is too large
to get so many receive overrun error in interrupts handler.

2, use stm32 spi's "In full-duplex (BIDIMODE=0 and RXONLY=0)", as tx_buf is
null, we must add dummy data sent out before read data.
so, add stm32f4_spi_tx_dummy() to handle this situation.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/spi/spi-stm32.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 44ac6eb3..72d9387 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -388,6 +388,14 @@ static int stm32h7_spi_get_fifo_size(struct stm32_spi *spi)
 	return count;
 }
 
+static void stm32f4_spi_tx_dummy(struct stm32_spi *spi)
+{
+	if (spi->cur_bpw == 16)
+		writew_relaxed(0x5555, spi->base + STM32F4_SPI_DR);
+	else
+		writeb_relaxed(0x55, spi->base + STM32F4_SPI_DR);
+}
+
 /**
  * stm32f4_spi_get_bpw_mask - Return bits per word mask
  * @spi: pointer to the spi controller data structure
@@ -811,7 +819,9 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 		mask |= STM32F4_SPI_SR_TXE;
 	}
 
-	if (!spi->cur_usedma && spi->cur_comm == SPI_FULL_DUPLEX) {
+	if (!spi->cur_usedma && (spi->cur_comm == SPI_FULL_DUPLEX ||
+				spi->cur_comm == SPI_SIMPLEX_RX ||
+				spi->cur_comm == SPI_3WIRE_RX)) {
 		/* TXE flag is set and is handled when RXNE flag occurs */
 		sr &= ~STM32F4_SPI_SR_TXE;
 		mask |= STM32F4_SPI_SR_RXNE | STM32F4_SPI_SR_OVR;
@@ -850,8 +860,10 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
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
@@ -1151,7 +1163,9 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
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
@@ -1170,6 +1184,8 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		stm32f4_spi_write_tx(spi);
+	else if (spi->cur_comm == SPI_SIMPLEX_RX)
+		stm32f4_spi_tx_dummy(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1462,10 +1478,16 @@ static int stm32f4_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
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

