Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06BD1FF640
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbgFRPKy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbgFRPKu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 11:10:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462FC0613EF
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so2926339pfe.4
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqrLxsOH23jMmWDCAvD7Zv1dq0cfbx+EXnsz1QwYjMc=;
        b=A0dJZO/ESj54vdLdSebDiEifYFwpT8y9FYfiJ68gcGnncK0ZwSwc2Fp9L8OPb4zYWK
         bFhk9bA8NDMtJ+ia5MsjEl0ziE+CSA67JfvtFpFqCtRMDU4O4ySMjskZy7Yx1jrl8JI1
         ua1bzHIZRI3BbrQm4RrtrYX1UuyuPolxSqg6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqrLxsOH23jMmWDCAvD7Zv1dq0cfbx+EXnsz1QwYjMc=;
        b=AQWxKLy1LIWwSv37lNNOxcWZj8z5Xr6k7NTQex/Gq6kPzNem0Mqb/aiEyKVFwngr03
         mqbUqwAwrtnWAV2h8CM2mL8uXoLspyz8sLN5FO5CDEK+QrMVANVH6sFUgGXhvZdKCpOR
         D16A12o1/lA03f2HhaKDDQ+xXsCWCInhs9ich2MSezArdQOHkkQMeHt5+x1z73kJK0bx
         DUrj0P7bUjj0R/HzsqxMNWDRml5zOTYiNGc1sBm5Whlu2sFOgyagI+iNYPvtLtT6ujhF
         kgkJQTwGysvsTFpUc+xtMKDYu4WJbAya3upyFCWiamyFFI84YrYp7CUEddUzScxeAMVX
         jcUg==
X-Gm-Message-State: AOAM532397GnyZHuKOtUaHr21B1TQXpqzT6MniEhxFzAE6AgcBEokNsp
        5USc3MqAci1qK5qZrcOGHztM1MPseZk=
X-Google-Smtp-Source: ABdhPJxTAr3ojc6iO/37TWVVPwyClnlGU0LJ1oS7TjCQ42cOm3S3Sf7uNaBPLZG9lCJygBt9d+a58A==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr2254438pgd.38.1592493049531;
        Thu, 18 Jun 2020 08:10:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 2/5] spi: spi-geni-qcom: Mo' betta locking
Date:   Thu, 18 Jun 2020 08:06:23 -0700
Message-Id: <20200618080459.v4.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
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
  CPU0                                         CPU1
  ----                                         ----
  spi_geni_set_cs()
   mas->cur_mcmd = CMD_CS;
   geni_se_setup_m_cmd(...)
   wait_for_completion_timeout(&xfer_done);
                                              <INTERRUPT>
                                               geni_spi_isr()
                                                complete(&xfer_done);
   <wakeup>
   pm_runtime_put(mas->dev);
  ... // back to SPI core
  spi_geni_transfer_one()
   setup_fifo_xfer()
    mas->cur_mcmd = CMD_XFER;
                                                mas->cur_cmd = CMD_NONE; // bad!
                                                return IRQ_HANDLED;

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

Changes in v4:
- Drop 'controller' in comment.
- Use Stephen's diagram to explain the race better.

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
index c7d2c7e45b3f..7d022ccb1b6c 100644
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
+	 * interrupt could come in at any time now.
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

