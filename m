Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E076B188F1C
	for <lists+linux-spi@lfdr.de>; Tue, 17 Mar 2020 21:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCQUiB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Mar 2020 16:38:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42730 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgCQUiB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Mar 2020 16:38:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so10121639plz.9
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2020 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jSVWcinVBkF0TMKRp+eiaEghUtTt1NtWoljB+scbYVU=;
        b=E7kG0Bh4ffCX+4pdDmDPEmUhRmqjjHdpF00agUUQidB2g5ozNWGsEsH0SIKM17G1o0
         kKvHkzZFHoDdyK2uhSwOtfxD85hYXYbqjBRhD2Z8MyBL1yLf91SoC8M8RanLJT9OhKxG
         UJbMDTT3i+mBSqkInAH4BzNZDwEB/dKYUUW8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jSVWcinVBkF0TMKRp+eiaEghUtTt1NtWoljB+scbYVU=;
        b=Xri7WRD9nv6tg4VzrKF3P2o/c3hyBNjWP3MRPRI/p5933ANs/iCu9lP0dAePO7ureE
         gr5BUVal1jr7RIhvqITGOinjQ3gAVhzA3GLOV36AG0Go3CgFLfbDclWKSB2b/C2mZ6Yt
         zLQJoZwWy246IQC3aFKbmbFG5+a+E6NMxPVjkGiM0bz6e40BeFFu2kCafvI3T2ARHLMe
         0GgPOaEamyPk2wL/mHK1P/IbYWPvTSDemNv4shPJnL87AeHYou41x/3AOVGby4HCj1ZK
         FAKCJVlgwM5WmY19TjqcquaF0UM33XwrrIR0ZqdfI1JZUqohp0vtBpS1yVSKHgTe6Mso
         ui3w==
X-Gm-Message-State: ANhLgQ0OqzNl4jo14r8e/39UVRm+Ox3f5JN9pvb60Am8AI7qJC6TBZ9I
        BWo8dewzfuxVYs+s5w7bGyxtrQ==
X-Google-Smtp-Source: ADFU+vuIDjiQMApXAYFSk7YrsY5SDvRSiRmwdvphWyIPFu20X5lDnDUyBU77VGieDUZBYjnqzJ4NKQ==
X-Received: by 2002:a17:902:7d97:: with SMTP id a23mr436529plm.31.1584477479756;
        Tue, 17 Mar 2020 13:37:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q123sm1039286pfb.54.2020.03.17.13.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:37:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
Date:   Tue, 17 Mar 2020 13:37:06 -0700
Message-Id: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Every once in a while (like once in a few months on a device) people
have seen warnings on devices using spi-geni-qcom like:

  irq ...: nobody cared (try booting with the "irqpoll" option)

...where the interrupt number listed matches up with "spi_geni" in
/proc/interrupts.

You can get "nobody cared" if the interrupt handler returns IRQ_NONE.
Once you get into this state the driver will just stop working.

Auditing the code makes me believe that it's probably not so good
checking "cur_mcmd" in the interrupt handler not under spinlock.
Let's move it to be under spinlock.  Looking more closely at the code,
it looks as if there are some other places that could be under
spinlock, so let's add.  It looks as if the original code was assuming
that by the time that the interrupt handler got called that the write
to "cur_mcmd" (to make it not CMD_NONE anymore) would make it to the
processor handling the interrupt.  Perhaps with weakly ordered memory
this sometimes (though very rarely) happened.

Let's also add a warning (with the IRQ status) in the case that we
ever end up getting an interrupt when we think we shouldn't.  This
would give us a better chance to debug if this patch doesn't help the
issue.  We'll also try our best to clear the interrupt to hopefully
get us out of this state.

Patch is marked "speculative" because I have no way to reproduce this
problem, so I'm just hoping this fixes it.  Weakly ordered memory
makes my brain hurt.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Detect true spurious interrupt.
- Still return IRQ_NONE for state machine mismatch, but print warn.

 drivers/spi/spi-geni-qcom.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3972424af71..92e51ccb427f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -151,16 +151,19 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
 
-	reinit_completion(&mas->xfer_done);
 	pm_runtime_get_sync(mas->dev);
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag = !set_flag;
 
+	spin_lock_irq(&mas->lock);
+	reinit_completion(&mas->xfer_done);
+
 	mas->cur_mcmd = CMD_CS;
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
 	else
 		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
+	spin_unlock_irq(&mas->lock);
 
 	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (!time_left)
@@ -307,6 +310,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	u32 spi_tx_cfg, len;
 	struct geni_se *se = &mas->se;
 
+	spin_lock_irq(&mas->lock);
+
 	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
 	if (xfer->bits_per_word != mas->cur_bits_per_word) {
 		spi_setup_word_len(mas, mode, xfer->bits_per_word);
@@ -376,6 +381,8 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	 */
 	if (m_cmd & SPI_TX_ONLY)
 		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
+
+	spin_unlock_irq(&mas->lock);
 }
 
 static int spi_geni_transfer_one(struct spi_master *spi,
@@ -478,13 +485,29 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct geni_se *se = &mas->se;
 	u32 m_irq;
 	unsigned long flags;
-
-	if (mas->cur_mcmd == CMD_NONE)
-		return IRQ_NONE;
+	irqreturn_t ret = IRQ_HANDLED;
 
 	spin_lock_irqsave(&mas->lock, flags);
 	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
 
+	/* Check for spurious interrupt */
+	if (!m_irq) {
+		ret = IRQ_NONE;
+		goto exit;
+	}
+
+	/*
+	 * If we got a real interrupt but software state machine thinks
+	 * we were idle then give a warning.  We'll do our best to clear
+	 * the interrupt but we'll still return IRQ_NONE.  If this keeps
+	 * happening the system will eventually disable us.
+	 */
+	if (mas->cur_mcmd == CMD_NONE) {
+		pr_warn("Unexpected SPI interrupt: %#010x\n", m_irq);
+		ret = IRQ_NONE;
+		goto exit;
+	}
+
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
 		geni_spi_handle_rx(mas);
 
@@ -523,9 +546,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		complete(&mas->xfer_done);
 	}
 
+exit:
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
 	spin_unlock_irqrestore(&mas->lock, flags);
-	return IRQ_HANDLED;
+
+	return ret;
 }
 
 static int spi_geni_probe(struct platform_device *pdev)
-- 
2.25.1.481.gfbce0eb801-goog

