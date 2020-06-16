Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C351FAE30
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgFPKlY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgFPKlT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 06:41:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDDCC08C5C2
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b7so1066212pju.0
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPfD16LMcnCPHfyxWwsic4qGGN1GTg8YG3jhDYqUndk=;
        b=ONPCf/tn87lXfOWlBr49mcpBon8SJ0/o14H2GFRj2pOkUHr3UjTzZY9ux3YCzU5zJV
         JZiMBHBK44NFc6lhQ4g8zJnOcsg6ICk+PrbiK2cxWvf8ZS1EPmPtxjmGcvr5JPj3BQUc
         nXaoRSh18sFwkUCvA00dFDTuLka6bP8VpqrZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPfD16LMcnCPHfyxWwsic4qGGN1GTg8YG3jhDYqUndk=;
        b=gYW8EctIq6/bFeey1egmXzLwv5tRuNLcg7JPebkJiWc2CWM3wSB+rS5MyaCgBk6pc9
         Dm99FqHAOFCUNXC37P4xbq+eJRzsE1JZ7YNPfMcND6502jj2BNNXw3FZRJqeYUhh/nQU
         WWg/GMPkmtZlUZJNz/tx1+HUaimWZrep1vKN2f34DUiwmgpL0M/nHw5miSKWRaz9OUL0
         5DCVA0FtwG7OlK7yEeYnn77xRd2pgtO0U9Y8MO4vF6coWuyZn6XdblSuYhVuHzBu2GO9
         WCk2KOhQKO7BcKlXPZMdKDPaXKVHwp7bwJ8rHJG2yLkbciPJz5NdOL4d9pfzFIR55/8j
         PSPA==
X-Gm-Message-State: AOAM532/ddALy4Fx6/EALH1DlQyaffoD+ilPI8Hn+CosujV8AmNqoUSc
        L4q/GG77cXyPUS8Agl3FGxiWpw==
X-Google-Smtp-Source: ABdhPJzzTOX0a5TxOiFL9gkTxc2JhbpANn1TcI4Nl1+7bGQ1sKBMNrrK8TvVznKEQRAx2l0f7EJe8w==
X-Received: by 2002:a17:902:d712:: with SMTP id w18mr1520710ply.63.1592304078627;
        Tue, 16 Jun 2020 03:41:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 140sm16947400pfz.154.2020.06.16.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:41:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 2/5] spi: spi-geni-qcom: Mo' betta locking
Date:   Tue, 16 Jun 2020 03:40:47 -0700
Message-Id: <20200616034044.v3.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200616104050.84764-1-dianders@chromium.org>
References: <20200616104050.84764-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If you added a bit of a delay (like a trace_printk) into the ISR for
the spi-geni-qcom driver, you would suddenly start seeing some errors
spit out.  The problem was that, though the ISR itself held a lock,
other parts of the driver didn't always grab the lock.

One example race was this:
a) Driver queues off a command to set a Chip Select (CS).
b) ISR fires indicating the CS is done.
c) Done bit is set, so we complete().
d) Second CPU gallops off and starts a transfer.
e) Second CPU starts messing with hardware / software state (not under
   spinlock).
f) ISR now does things like set "mas->cur_mcmd" to CMD_NONE, prints
   errors if "tx_rem_bytes" / "rx_rem_bytes" have been set, and also
   Acks all interrupts it handled.

Let's fix this.  Before we start messing with hardware, we'll grab the
lock to make sure that the IRQ handler from some previous command has
really finished.  We don't need to hold the lock unless we're in a
state where more interrupts can come in, but we at least need to make
sure the previous IRQ is done.  This lock is used exclusively to
prevent the IRQ handler and non-IRQ from stomping on each other.  The
SPI core handles all other mutual exclusion.

As part of this, we change the way that the IRQ handler detects
spurious interrupts.  Previously we checked for our state variable
being set to IRQ_NONE, but that was done outside the spinlock.  We
could move it into the spinlock, but instead let's just change it to
look for the lack of any IRQ status bits being set.  This can be done
outside the lock--the hardware certainly isn't grabbing or looking at
the spinlock when it updates its status register.

It's possible that this will fix real (but very rare) errors seen in
the field that look like:
  irq ...: nobody cared (try booting with the "irqpoll" option)

NOTE: an alternate strategy considered here was to always make the
complete() / spi_finalize_current_transfer() the very last thing in
our IRQ handler.  With such a change you could consider that we could
be "lockless".  In that case, though, we'd have to be very careful w/
memory barriers so we made sure we didn't have any bugs with weakly
ordered memory.  Using spinlocks makes the driver much easier to
understand.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Split out some lock cleanup to previous patch.
- Don't need to read IRQ status register inside spinlock.
- Don't check for state CMD_NONE; later patch is removing state var.
- Don't hold the lock for all of setup_fifo_xfer().
- Comment about why it's safe to Ack interrupts at the end.
- Subject/desc changed since race is definitely there.

Changes in v2:
- Detect true spurious interrupt.
- Still return IRQ_NONE for state machine mismatch, but print warn.

 drivers/spi/spi-geni-qcom.c | 45 ++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c7d2c7e45b3f..e0f0e5c241f3 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -151,16 +151,18 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
 
-	reinit_completion(&mas->xfer_done);
 	pm_runtime_get_sync(mas->dev);
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag = !set_flag;
 
+	spin_lock_irq(&mas->lock);
+	reinit_completion(&mas->xfer_done);
 	mas->cur_mcmd = CMD_CS;
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
 	else
 		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
+	spin_unlock_irq(&mas->lock);
 
 	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (!time_left)
@@ -307,6 +309,21 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	u32 spi_tx_cfg, len;
 	struct geni_se *se = &mas->se;
 
+	/*
+	 * Ensure that our interrupt handler isn't still running from some
+	 * prior command before we start messing with the hardware behind
+	 * its back.  We don't need to _keep_ the lock here since we're only
+	 * worried about racing with out interrupt handler.  The SPI core
+	 * already handles making sure that we're not trying to do two
+	 * transfers at once or setting a chip select and doing a transfer
+	 * concurrently.
+	 *
+	 * NOTE: we actually _can't_ hold the lock here because possibly we
+	 * might call clk_set_rate() which needs to be able to sleep.
+	 */
+	spin_lock_irq(&mas->lock);
+	spin_unlock_irq(&mas->lock);
+
 	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
 	if (xfer->bits_per_word != mas->cur_bits_per_word) {
 		spi_setup_word_len(mas, mode, xfer->bits_per_word);
@@ -367,6 +384,12 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	}
 	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
 	mas->cur_mcmd = CMD_XFER;
+
+	/*
+	 * Lock around right before we start the transfer since our
+	 * interrupt controller could come in at any time now.
+	 */
+	spin_lock_irq(&mas->lock);
 	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
 
 	/*
@@ -376,6 +399,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	 */
 	if (m_cmd & SPI_TX_ONLY)
 		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
+	spin_unlock_irq(&mas->lock);
 }
 
 static int spi_geni_transfer_one(struct spi_master *spi,
@@ -478,11 +502,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct geni_se *se = &mas->se;
 	u32 m_irq;
 
-	if (mas->cur_mcmd == CMD_NONE)
+	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
+	if (!m_irq)
 		return IRQ_NONE;
 
 	spin_lock(&mas->lock);
-	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
 
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
 		geni_spi_handle_rx(mas);
@@ -522,8 +546,23 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		complete(&mas->xfer_done);
 	}
 
+	/*
+	 * It's safe or a good idea to Ack all of our our interrupts at the
+	 * end of the function. Specifically:
+	 * - M_CMD_DONE_EN / M_RX_FIFO_LAST_EN: Edge triggered interrupts and
+	 *   clearing Acks. Clearing at the end relies on nobody else having
+	 *   started a new transfer yet or else we could be clearing _their_
+	 *   done bit, but everyone grabs the spinlock before starting a new
+	 *   transfer.
+	 * - M_RX_FIFO_WATERMARK_EN / M_TX_FIFO_WATERMARK_EN: These appear
+	 *   to be "latched level" interrupts so it's important to clear them
+	 *   _after_ you've handled the condition and always safe to do so
+	 *   since they'll re-assert if they're still happening.
+	 */
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
+
 	spin_unlock(&mas->lock);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.27.0.290.gba653c62da-goog

