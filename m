Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D192DA4F9
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 01:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgLOAcW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 19:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgLOAcS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Dec 2020 19:32:18 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99AC0617A7
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 16:31:38 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b8so3996930plx.0
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 16:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHZzN7QnB+fG/aCQ4IcntNNXDnPGesYQj+tjiQUFpFA=;
        b=CyxCwbcjcgYxxChvTPAi4Cp5pUrrvQM8W8jYk9w0SgcMS9Mu5nM23VmqYtNpOyjz1r
         ajrYVJhi/uNpr/lUZTIy4NOiz/FACFF5gN7B+BNHvw44rDZDjR2xziV6THm49b9sHcXY
         4b8enF8zT0YBnQqG3ZBF3F3gXjDPSdAs2hu8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHZzN7QnB+fG/aCQ4IcntNNXDnPGesYQj+tjiQUFpFA=;
        b=Flo63KJQS2DkNHjcFJ5qEuSE1tkY8nYwAd4J2ZbSCHY8sBYlQzcxB0tZLVD35stgZv
         yoNdcIEUvDlnPzZM3Cv0LBndLJYtGkcbzdE4W5zQ8IxIq/iqOn3ize2JMQOVZUcZfOYR
         0ufcYqAf/aqCN0wy7nr5FBEZ2dDUNZH2Hgy3+4He14dhPQGfnINGrC6Me223XXFwbtzy
         wDyRqQdxkYiQxbV/QzgdDTN/KjdD8BlDBqU1FQPa+1/pWY4xLK3Y1ZkR/fYvCtquIczH
         1qX2a3Y4IMwgj3uPldqiwCpm7IdgxbTDUaYsQkGZJAXD6jjYMRvMJF60hG3n7aIz+C1g
         3qEg==
X-Gm-Message-State: AOAM531XdzIAk9Js3pmWdhfjHY4SOiApZv8bNXouYEADT4xuXbnR49Ib
        CtoPQfbIIX84AbAgAJWrPwjlHw==
X-Google-Smtp-Source: ABdhPJxux+79KiPAWCaarQKpR+hNGV+g1cx4l3hLlPUGCsF7voj6qS4lOmQ2WyDroYZZt+r1Am+iEg==
X-Received: by 2002:a17:90b:4a10:: with SMTP id kk16mr27776109pjb.30.1607992297548;
        Mon, 14 Dec 2020 16:31:37 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id 77sm20412834pfx.156.2020.12.14.16.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 16:31:37 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-geni-qcom: Really ensure the previous xfer is done before new one
Date:   Mon, 14 Dec 2020 16:30:19 -0800
Message-Id: <20201214162937.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In commit 2ee471a1e28e ("spi: spi-geni-qcom: Mo' betta locking") we
added a dance in setup_fifo_xfer() to make sure that the previous
transfer was really done before we setup the next one.  However, it
wasn't enough.  Specifically, if we had a timeout it's possible that
the previous transfer could still be pending.  This could happen if
our interrupt handler was blocked for a long while (interrupt storm or
someone disablng IRQs for a while).  This pending interrupt could
throw off our logic.

Let's really make sure that the previous interrupt isn't still pending
before we start the next transfer.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-geni-qcom.c | 69 ++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6f736e94e9f4..5ef2e9f38ac9 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -145,12 +145,49 @@ static void handle_fifo_timeout(struct spi_master *spi,
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
 }
 
+static int spi_geni_check_busy(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	u32 m_irq, m_irq_en;
+
+	/*
+	 * We grab the spinlock so that if we raced really fast and the IRQ
+	 * handler is still actually running we'll wait for it to exit.  This
+	 * can happen because the IRQ handler may signal in the middle of the
+	 * function and the next transfer can kick off right away.
+	 *
+	 * Once we have the spinlock, if we're starting a new transfer we
+	 * expect nothing is pending.  We check this to handle the case where
+	 * the previous transfer timed out and then handle_fifo_timeout() timed
+	 * out.  This can happen if the interrupt handler was blocked for
+	 * a long time and we don't want to start any new transfers until it's
+	 * all done.
+	 *
+	 * We are OK releasing the spinlock after we're done here since (if
+	 * we're returning 0 and going ahead with the transfer) we know that
+	 * the SPI controller must be in a quiet state.
+	 */
+	spin_lock_irq(&mas->lock);
+	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
+	m_irq_en = readl(se->base + SE_GENI_M_IRQ_EN);
+	spin_unlock_irq(&mas->lock);
+
+	if (m_irq & m_irq_en) {
+		dev_err(mas->dev, "Busy, IRQs pending %#010x\n",
+			m_irq & m_irq_en);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
 	struct spi_master *spi = dev_get_drvdata(mas->dev);
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
+	int ret;
 
 	if (!(slv->mode & SPI_CS_HIGH))
 		set_flag = !set_flag;
@@ -158,6 +195,12 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	if (set_flag == mas->cs_flag)
 		return;
 
+	ret = spi_geni_check_busy(mas);
+	if (ret) {
+		dev_err(mas->dev, "Can't set chip select\n");
+		return;
+	}
+
 	mas->cs_flag = set_flag;
 
 	pm_runtime_get_sync(mas->dev);
@@ -277,8 +320,12 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 static int spi_geni_prepare_message(struct spi_master *spi,
 					struct spi_message *spi_msg)
 {
-	int ret;
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
+
+	ret = spi_geni_check_busy(mas);
+	if (ret)
+		return ret;
 
 	ret = setup_fifo_params(spi_msg->spi, spi);
 	if (ret)
@@ -440,21 +487,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	struct geni_se *se = &mas->se;
 	int ret;
 
-	/*
-	 * Ensure that our interrupt handler isn't still running from some
-	 * prior command before we start messing with the hardware behind
-	 * its back.  We don't need to _keep_ the lock here since we're only
-	 * worried about racing with out interrupt handler.  The SPI core
-	 * already handles making sure that we're not trying to do two
-	 * transfers at once or setting a chip select and doing a transfer
-	 * concurrently.
-	 *
-	 * NOTE: we actually _can't_ hold the lock here because possibly we
-	 * might call clk_set_rate() which needs to be able to sleep.
-	 */
-	spin_lock_irq(&mas->lock);
-	spin_unlock_irq(&mas->lock);
-
 	if (xfer->bits_per_word != mas->cur_bits_per_word) {
 		spi_setup_word_len(mas, mode, xfer->bits_per_word);
 		mas->cur_bits_per_word = xfer->bits_per_word;
@@ -511,6 +543,11 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 				struct spi_transfer *xfer)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
+
+	ret = spi_geni_check_busy(mas);
+	if (ret)
+		return ret;
 
 	/* Terminate and return success for 0 byte length transfer */
 	if (!xfer->len)
-- 
2.29.2.684.gfbc64c5ab5-goog

