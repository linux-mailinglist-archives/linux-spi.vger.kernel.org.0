Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3C267BB9
	for <lists+linux-spi@lfdr.de>; Sat, 12 Sep 2020 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgILSSV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgILSST (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 14:18:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82144C061573
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 11:18:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so9607373pfg.2
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1GTBXxKUvJxoon/aNt1MN6fmALohNRxcmfcvMYUVuI=;
        b=cwvhRxfbcTFj4svbdXDZ9jcAEMhYVMR7LZ4P87bq1El3TaxmfOrqur6oTokv//oGuR
         O6lBjAZZoASK01mJbAZUMKWC8cxKClvwn+gDUrgegq07Rhz3N7cIq0hUCJNbKT3N6xVs
         DZAooRgvRH8KK96ejVU7xL8oGc/eW70Ngbe6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1GTBXxKUvJxoon/aNt1MN6fmALohNRxcmfcvMYUVuI=;
        b=Gkka2pgqHVPgI+zlQlYClVjXn/xMXzGZ2QlO6EhB3SSsHUwmK3eIwlWxnSeyTVTauu
         pyzRdc0XtHdYzQbWmI4GJFFQzWm7RDuXDOOU/clhcOVQdBcPLJW9rT0AdPqnxbM7nkdR
         6SpNugSopELzD6jJMvOwwkUTnOSjSpH48cLNcx6qCzuHtOke53T8Up1EK+kfoMxcsaET
         ny2P/htAMl0QvLXunPEFIEH11sxIeBPHrtGmov9p9m2l7cV76aZnNbckCzruYFkDdlwT
         YStCHFkkRNzSZ4606qdmN8G7e/ty15I3yyWnGp4JnBJz8IKAf+Nsu2EKHYe1MYHx796K
         gSrA==
X-Gm-Message-State: AOAM530V+35ByHv6E1iNrCw27GQyOTkw+AbgyAa7HFt2KJa63GA/GxAc
        66VoQtHUXTP4UUt/1+trsjjjqg==
X-Google-Smtp-Source: ABdhPJxwX4AccK3tYQzQmCHCIqpQZFNdVItS5jcKZcDzjfHI6EGkPeg1jTKnv2I6CfAhC/+Xma58Vw==
X-Received: by 2002:aa7:80d3:: with SMTP id a19mr7177026pfn.102.1599934698016;
        Sat, 12 Sep 2020 11:18:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id f6sm5858183pfq.82.2020.09.12.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 11:18:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Akash Asthana <akashast@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: Don't wait to start 1st transfer if transmitting
Date:   Sat, 12 Sep 2020 11:17:25 -0700
Message-Id: <20200912111716.1.Ied5e843fad0d6b733a1fb8bcfb364dd2fa889eb3@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If we're sending bytes over SPI, we know the FIFO is empty at the
start of the transfer.  There's no reason to wait for the interrupt
telling us to start--we can just start right away.  Then if we
transmit everything in one swell foop we don't even need to bother
listening for TX interrupts.

In a test of "flashrom -p ec -r /tmp/foo.bin" interrupts were reduced
from ~30560 to ~29730, about a 3% savings.

This patch looks bigger than it is because I moved a few functions
rather than adding a forward declaration.  The only actual change to
geni_spi_handle_tx() was to make it return a bool indicating if there
is more to tx.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 167 +++++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 81 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0dc3f4c55b0b..49c9eb870755 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -326,6 +326,88 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	return 0;
 }
 
+static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
+{
+	/*
+	 * Calculate how many bytes we'll put in each FIFO word.  If the
+	 * transfer words don't pack cleanly into a FIFO word we'll just put
+	 * one transfer word in each FIFO word.  If they do pack we'll pack 'em.
+	 */
+	if (mas->fifo_width_bits % mas->cur_bits_per_word)
+		return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
+						       BITS_PER_BYTE));
+
+	return mas->fifo_width_bits / BITS_PER_BYTE;
+}
+
+static bool geni_spi_handle_tx(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	unsigned int max_bytes;
+	const u8 *tx_buf;
+	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
+	unsigned int i = 0;
+
+	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
+	if (mas->tx_rem_bytes < max_bytes)
+		max_bytes = mas->tx_rem_bytes;
+
+	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
+	while (i < max_bytes) {
+		unsigned int j;
+		unsigned int bytes_to_write;
+		u32 fifo_word = 0;
+		u8 *fifo_byte = (u8 *)&fifo_word;
+
+		bytes_to_write = min(bytes_per_fifo_word, max_bytes - i);
+		for (j = 0; j < bytes_to_write; j++)
+			fifo_byte[j] = tx_buf[i++];
+		iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
+	}
+	mas->tx_rem_bytes -= max_bytes;
+	if (!mas->tx_rem_bytes) {
+		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+		return false;
+	}
+	return true;
+}
+
+static void geni_spi_handle_rx(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	u32 rx_fifo_status;
+	unsigned int rx_bytes;
+	unsigned int rx_last_byte_valid;
+	u8 *rx_buf;
+	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
+	unsigned int i = 0;
+
+	rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
+	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_word;
+	if (rx_fifo_status & RX_LAST) {
+		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
+		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
+		if (rx_last_byte_valid && rx_last_byte_valid < 4)
+			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
+	}
+	if (mas->rx_rem_bytes < rx_bytes)
+		rx_bytes = mas->rx_rem_bytes;
+
+	rx_buf = mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_rem_bytes;
+	while (i < rx_bytes) {
+		u32 fifo_word = 0;
+		u8 *fifo_byte = (u8 *)&fifo_word;
+		unsigned int bytes_to_read;
+		unsigned int j;
+
+		bytes_to_read = min(bytes_per_fifo_word, rx_bytes - i);
+		ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 1);
+		for (j = 0; j < bytes_to_read; j++)
+			rx_buf[i++] = fifo_byte[j];
+	}
+	mas->rx_rem_bytes -= rx_bytes;
+}
+
 static void setup_fifo_xfer(struct spi_transfer *xfer,
 				struct spi_geni_master *mas,
 				u16 mode, struct spi_master *spi)
@@ -398,8 +480,10 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	 * setting up GENI SE engine, as driver starts data transfer
 	 * for the watermark interrupt.
 	 */
-	if (m_cmd & SPI_TX_ONLY)
-		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
+	if (m_cmd & SPI_TX_ONLY) {
+		if (geni_spi_handle_tx(mas))
+			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
+	}
 	spin_unlock_irq(&mas->lock);
 }
 
@@ -417,85 +501,6 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 	return 1;
 }
 
-static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
-{
-	/*
-	 * Calculate how many bytes we'll put in each FIFO word.  If the
-	 * transfer words don't pack cleanly into a FIFO word we'll just put
-	 * one transfer word in each FIFO word.  If they do pack we'll pack 'em.
-	 */
-	if (mas->fifo_width_bits % mas->cur_bits_per_word)
-		return roundup_pow_of_two(DIV_ROUND_UP(mas->cur_bits_per_word,
-						       BITS_PER_BYTE));
-
-	return mas->fifo_width_bits / BITS_PER_BYTE;
-}
-
-static void geni_spi_handle_tx(struct spi_geni_master *mas)
-{
-	struct geni_se *se = &mas->se;
-	unsigned int max_bytes;
-	const u8 *tx_buf;
-	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
-	unsigned int i = 0;
-
-	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
-	if (mas->tx_rem_bytes < max_bytes)
-		max_bytes = mas->tx_rem_bytes;
-
-	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
-	while (i < max_bytes) {
-		unsigned int j;
-		unsigned int bytes_to_write;
-		u32 fifo_word = 0;
-		u8 *fifo_byte = (u8 *)&fifo_word;
-
-		bytes_to_write = min(bytes_per_fifo_word, max_bytes - i);
-		for (j = 0; j < bytes_to_write; j++)
-			fifo_byte[j] = tx_buf[i++];
-		iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
-	}
-	mas->tx_rem_bytes -= max_bytes;
-	if (!mas->tx_rem_bytes)
-		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-}
-
-static void geni_spi_handle_rx(struct spi_geni_master *mas)
-{
-	struct geni_se *se = &mas->se;
-	u32 rx_fifo_status;
-	unsigned int rx_bytes;
-	unsigned int rx_last_byte_valid;
-	u8 *rx_buf;
-	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
-	unsigned int i = 0;
-
-	rx_fifo_status = readl(se->base + SE_GENI_RX_FIFO_STATUS);
-	rx_bytes = (rx_fifo_status & RX_FIFO_WC_MSK) * bytes_per_fifo_word;
-	if (rx_fifo_status & RX_LAST) {
-		rx_last_byte_valid = rx_fifo_status & RX_LAST_BYTE_VALID_MSK;
-		rx_last_byte_valid >>= RX_LAST_BYTE_VALID_SHFT;
-		if (rx_last_byte_valid && rx_last_byte_valid < 4)
-			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
-	}
-	if (mas->rx_rem_bytes < rx_bytes)
-		rx_bytes = mas->rx_rem_bytes;
-
-	rx_buf = mas->cur_xfer->rx_buf + mas->cur_xfer->len - mas->rx_rem_bytes;
-	while (i < rx_bytes) {
-		u32 fifo_word = 0;
-		u8 *fifo_byte = (u8 *)&fifo_word;
-		unsigned int bytes_to_read;
-		unsigned int j;
-
-		bytes_to_read = min(bytes_per_fifo_word, rx_bytes - i);
-		ioread32_rep(se->base + SE_GENI_RX_FIFOn, &fifo_word, 1);
-		for (j = 0; j < bytes_to_read; j++)
-			rx_buf[i++] = fifo_byte[j];
-	}
-	mas->rx_rem_bytes -= rx_bytes;
-}
-
 static irqreturn_t geni_spi_isr(int irq, void *data)
 {
 	struct spi_master *spi = data;
-- 
2.28.0.618.gf4bc123cb7-goog

