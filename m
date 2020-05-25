Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449D51E0560
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 05:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbgEYDlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388397AbgEYDlo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 23:41:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C8C061A0E;
        Sun, 24 May 2020 20:41:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so8001900pjb.1;
        Sun, 24 May 2020 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iDnn3wwO4wgWkpXGhO1cGw9dx9qYzbrC+ZSQIhZHNL0=;
        b=jjlDtBWN/16JQmSFYC7TV23yXD3qJz4n3xV2sK420hC1YiK8ETGR0y4wpyWU8RukLV
         SqpSatLDtBr7+WKFLAtoAkTbwa+WhbfL5AYZ7w+KUr6QIKQmLmku6iJ38zSp8M0Z/Cmb
         hKSkvngi8kBBa0Uh4QpCznTFNcEKIpDxWa8XTYNfX6aZpDJbqeyQi/XT2VgZ6YCNtA71
         Kk+9tQIvVgA+nGLKNCEIlkz72uIXo0pi6PgjKOpf3LUWBR5m7B1SHBllrMxYIHcrn2t+
         14ZUIRRDAACib2/IOewbL8Gax9yeRir0geDiwg624a9kv4FvwO67JcFRQwvKBnOI8/kB
         Iweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iDnn3wwO4wgWkpXGhO1cGw9dx9qYzbrC+ZSQIhZHNL0=;
        b=qzygH3QDi+ScDaRfoFzDwroyZUDcwXtrT+Dr6aowjESzz+dSR1bS3ZRXu54G4gYHzg
         YmW2fIW4h7aWldnyyzQKxx6Mx5DEHL1XSz1+XpyvDrP4A2PQRmnDQNGtxNtYIhCu+70C
         6PqSrSf7RVQfsIirIcFPlV5yguzGx6Raee5w66jKuvkwZ7Xt8plOOD2dXyu1NBTriThS
         Xz1QEGO/2p8TZ5xJCInKiHAIVnqpc1acQt+Fyl+cNa7ykn1Hf9FYhff5fsfJiYAIuVWz
         8BoQCZK0nw+okxDtw4lTJDfHoDDfXhBu21PzISQM9SkewFDp/V6avqBDeLcEe/VOYepm
         v9IQ==
X-Gm-Message-State: AOAM530aTDvtS1XmX2Eq1szJpafTOjUeV3ZpU1Pqb1dYiZanyyV5C4Os
        zqRcEbFCmvGdKkCxtrFqm6o=
X-Google-Smtp-Source: ABdhPJxoKIdtw415DByT7hwTPxxjMmM+Hxr8JYe3K494S5OCo3VeF502e2OXLD2FZhSXNulrXDX2cg==
X-Received: by 2002:a17:90a:4497:: with SMTP id t23mr18625927pjg.88.1590378104137;
        Sun, 24 May 2020 20:41:44 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id 7sm11981695pfc.203.2020.05.24.20.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:41:43 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 7/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
Date:   Mon, 25 May 2020 11:41:01 +0800
Message-Id: <1590378062-7965-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
References: <broonie@kernel.org>
 <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
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

