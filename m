Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77B187578
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgCPWUl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 18:20:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44713 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPWUl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 18:20:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id 37so10530457pgm.11
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2020 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdJL97TnHEiwXNrNot3Nu+tTBwH6OViCGp++MAMoJjI=;
        b=LvC1OSwZYDZhevpzNqmBIv1hskVJduDT0SK46lnoXZM7yCRwcl/gdG0KzlWgHXMvhv
         LUgm3GaQaWEMgxGVKKdpsiCMfOg/h3Jp+Ii4+XN8ntv9ZXXcZiaZFjr3KlGAZX4TFhrU
         Z0d7m3y3RlzzMmNzKVc3B2P2bhbDiIsD36WbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdJL97TnHEiwXNrNot3Nu+tTBwH6OViCGp++MAMoJjI=;
        b=kHf350dGQTYdo/wtgzcbdNRJJ67LF/3/BEya0oWBUFHRxkFAgYSCNFajBXg/XGpCnz
         XKvI2kwCJ4SbL/96aBkxsYu/h/mzboctRsZ/7hJ87MpdWXI99URcOM+09fRSzM0vRFrn
         4zPv2hk2XlI+3aRGUpRYSP6P+fBs7WidmYgu1FJOMJ8AeIbSkaYblkCH7SAOmEH19ajZ
         h4PnEaZL8WlbOd8YGTgHE36+GP1A4b/+Rx1Eps3kE/EyPwzbX1PTMTbLBN9dONAKuHji
         5xxmTXJuTpCKcIv9HEYZxRG2lvUgus0UW3EG6pavnyYAZf0zGFAzz22GEaRiQeywCcO3
         +rpg==
X-Gm-Message-State: ANhLgQ2BQPDMvrM4TGBgN4qKQNB2G+BAwnRRoGmShbYkZne+xZmaHBok
        ISENsWpIgDlBvfweiRVagLX2mg==
X-Google-Smtp-Source: ADFU+vuzlYlb8p9d2+T6E5oG1EolUGtKK3FaYXBJKoHapG07JRQmTGibH+PYw4PUZ72sqbeZD6jwGw==
X-Received: by 2002:aa7:8d18:: with SMTP id j24mr1884679pfe.264.1584397238841;
        Mon, 16 Mar 2020 15:20:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f8sm828535pfq.178.2020.03.16.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 15:20:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>, skakit@codeaurora.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: Speculative fix of "nobody cared" about interrupt
Date:   Mon, 16 Mar 2020 15:20:01 -0700
Message-Id: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
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
Let's move it to be under spinlock.  While we're at it, let's not
return IRQ_NONE.  IRQ_NONE is supposed to check the _hardware_ status
registers and only be returned if your hardware says that there's no
interrupt present.  It's not supposed to check software state.  In any
case, the whole point of IRQ_NONE is if two separate devices are
trying to share an interrupt line, which just isn't true for anyone
using geni.

Looking more closely at the code, it looks as if there are some other
places that could be under spinlock, so let's add.  It looks as if the
original code was assuming that by the time that the interrupt handler
got called that the write to "cur_mcmd" (to make it not CMD_NONE
anymore) would make it to the processor handling the interrupt.
Perhaps with weakly ordered memory this sometimes (though very rarely)
happened.

Patch is marked "speculative" because I have no way to reproduce this
problem, so I'm just hoping this fixes it.  Weakly ordered memory
makes my brain hurt.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3972424af71..51290a3fd203 100644
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
@@ -479,12 +486,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	u32 m_irq;
 	unsigned long flags;
 
-	if (mas->cur_mcmd == CMD_NONE)
-		return IRQ_NONE;
-
 	spin_lock_irqsave(&mas->lock, flags);
 	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
 
+	/*
+	 * We don't expect to hit this, but if we do we should try our best
+	 * to clear the interrupts and return so we don't just get called
+	 * again.
+	 */
+	if (mas->cur_mcmd == CMD_NONE)
+		goto exit;
+
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
 		geni_spi_handle_rx(mas);
 
@@ -523,6 +535,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		complete(&mas->xfer_done);
 	}
 
+exit:
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
 	spin_unlock_irqrestore(&mas->lock, flags);
 	return IRQ_HANDLED;
-- 
2.25.1.481.gfbce0eb801-goog

