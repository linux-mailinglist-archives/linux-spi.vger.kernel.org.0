Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504942DC921
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgLPWnr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 17:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgLPWnq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 17:43:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40613C061248
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 14:42:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t22so8170706pfl.3
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 14:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UErCAYhJNV6xENTjEWyjhUKDhkm78BgKdEVy9iP5rpY=;
        b=aGYwi3nCHT8nh/xWKQW6YYDtzh0JvnpyDaEJXPUIrRybqWWGZh4rvft41syG6W0grW
         2DpNBeSoHiOOySRCAsyZ5QZpQWTjpXqb8Fjy3XT2LUHz9i4+AtyMtS9A7O1d+jJDyoye
         b12DQaByTtamB9mNemAUUFCKhWDrl45BC91eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UErCAYhJNV6xENTjEWyjhUKDhkm78BgKdEVy9iP5rpY=;
        b=Gr3Vprgw21A9e1lrRhReZ+augDuc0QuoW8Ew76Pwde+Rffh3libBiJuNfi/4PGUHml
         y3MEMO0iLxDllKziQ2Q+fTcq0UIYcK0wEZ0OJgFTTcU86DrMMZWN+0GmxGoma+ruybW+
         3IOdzSRAv5D+2/Wy9paTx6imNFmpXlO1TmSyjFk0OhQLaOTJe8lEbhQiDxJgkcI19l11
         3SQiNZfVBvAAMcPp9wb0ieEv4a30xXnbM58IEiTQ5+gd+XmOh/tcBGFwQaG6iIJhgACa
         UP/t72f+QyqANg0wLjNZPtFgCyFtqFu+g40WEmAGK01fbAsX4DIfc4st5ZE1vfgeCxEo
         MP9A==
X-Gm-Message-State: AOAM531zNw/wWIZ1MNlXGAbHR2DZKA86INUAuui68zXeIzsY7Nh9CTag
        0Y19yl1pGKC/6FulRMtnXhyWog==
X-Google-Smtp-Source: ABdhPJzBgFjwuLAhEPeoSpgqaZPjMc1mH2n4DifWFn9DUPtuN2Gbp7liVDv6JOveNwetKOvc6iHXhw==
X-Received: by 2002:a62:1c16:0:b029:1a6:8b06:68e9 with SMTP id c22-20020a621c160000b02901a68b0668e9mr11441294pfc.45.1608158551710;
        Wed, 16 Dec 2020 14:42:31 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q26sm3561703pfl.219.2020.12.16.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:42:31 -0800 (PST)
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
Subject: [PATCH v2 2/4] spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
Date:   Wed, 16 Dec 2020 14:41:50 -0800
Message-Id: <20201216144114.v2.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If we got a timeout when trying to send an abort command then it means
that we just got 3 timeouts in a row:

1. The original timeout that caused handle_fifo_timeout() to be
   called.
2. A one second timeout waiting for the cancel command to finish.
3. A one second timeout waiting for the abort command to finish.

SPI is clocked by the controller, so nothing (aside from a hardware
fault or a totally broken sequencer) should be causing the actual
commands to fail in hardware.  However, even though the hardware
itself is not expected to fail (and it'd be hard to predict how we
should handle things if it did), it's easy to hit the timeout case by
simply blocking our interrupt handler from running for a long period
of time.  Obviously the system is in pretty bad shape if a interrupt
handler is blocked for > 2 seconds, but there are certainly bugs (even
bugs in other unrelated drivers) that can make this happen.

Let's make things a bit more robust against this case.  If we fail to
abort we'll set a flag and then we'll block all future transfers until
we have no more interrupts pending.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Make this just about the failed abort.

 drivers/spi/spi-geni-qcom.c | 56 +++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index bf55abbd39f1..d988463e606f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -83,6 +83,7 @@ struct spi_geni_master {
 	spinlock_t lock;
 	int irq;
 	bool cs_flag;
+	bool abort_failed;
 };
 
 static int get_spi_clk_cfg(unsigned int speed_hz,
@@ -141,8 +142,46 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	spin_unlock_irq(&mas->lock);
 
 	time_left = wait_for_completion_timeout(&mas->abort_done, HZ);
-	if (!time_left)
+	if (!time_left) {
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+
+		/*
+		 * No need for a lock since SPI core has a lock and we never
+		 * access this from an interrupt.
+		 */
+		mas->abort_failed = true;
+	}
+}
+
+static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+	u32 m_irq, m_irq_en;
+
+	if (!mas->abort_failed)
+		return false;
+
+	/*
+	 * The only known case where a transfer times out and then a cancel
+	 * times out then an abort times out is if something is blocking our
+	 * interrupt handler from running.  Avoid starting any new transfers
+	 * until that sorts itself out.
+	 */
+	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
+	m_irq_en = readl(se->base + SE_GENI_M_IRQ_EN);
+	if (m_irq & m_irq_en) {
+		dev_err(mas->dev, "Interrupts pending after abort: %#010x\n",
+			m_irq & m_irq_en);
+		return true;
+	}
+
+	/*
+	 * If we're here the problem resolved itself so no need to check more
+	 * on future transfers.
+	 */
+	mas->abort_failed = false;
+
+	return false;
 }
 
 static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
@@ -158,9 +197,15 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	if (set_flag == mas->cs_flag)
 		return;
 
+	pm_runtime_get_sync(mas->dev);
+
+	if (spi_geni_is_abort_still_pending(mas)) {
+		dev_err(mas->dev, "Can't set chip select\n");
+		goto exit;
+	}
+
 	mas->cs_flag = set_flag;
 
-	pm_runtime_get_sync(mas->dev);
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
@@ -173,6 +218,7 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	if (!time_left)
 		handle_fifo_timeout(spi, NULL);
 
+exit:
 	pm_runtime_put(mas->dev);
 }
 
@@ -280,6 +326,9 @@ static int spi_geni_prepare_message(struct spi_master *spi,
 	int ret;
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	if (spi_geni_is_abort_still_pending(mas))
+		return -EBUSY;
+
 	ret = setup_fifo_params(spi_msg->spi, spi);
 	if (ret)
 		dev_err(mas->dev, "Couldn't select mode %d\n", ret);
@@ -509,6 +558,9 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	if (spi_geni_is_abort_still_pending(mas))
+		return -EBUSY;
+
 	/* Terminate and return success for 0 byte length transfer */
 	if (!xfer->len)
 		return 0;
-- 
2.29.2.684.gfbc64c5ab5-goog

