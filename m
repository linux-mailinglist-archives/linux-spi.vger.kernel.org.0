Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2146A1FAE40
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgFPKly (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgFPKlS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 06:41:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE1C08C5C7
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so8201116plo.12
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2020 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lePPQwo+mnHTXVB83gJI9+SsNpNRSndF9oxmatv8k7U=;
        b=DfEHxSBojphs0ObnKRo4J+et+0qiewmZYv/0OgsaZYBd2sfXX7jWAGuPWt3UtIO9pN
         /sA9X4OCpTwWyBWmV+/grX8R3FzDd73aQI8mCXdLFvnnfqRbbhhd7SYFpPx6MLR0pK8c
         lwyaiuQ6ap4hqnHiZlcUxUex35ERKeV0q5hy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lePPQwo+mnHTXVB83gJI9+SsNpNRSndF9oxmatv8k7U=;
        b=bhdat1DYf8XEjcLLTvIYz5w4Df4NgTabGEPTsDSa7AgoRVEOQKmy4YrZ88hN1ycrNu
         zwKghl46Uuh+voNRHSCJRGc2PAXziDlJfWAPm+APvZQGxi3kFqD+nx7Hr7yVQ2bajDKR
         J1Wkm7FXsDSGtT8e4pmln91GGfL+6hZoKYw4Kq2efHD4juIWvvzUBoIWf1HQXfV5J/k8
         e8jeRzrxpjeGSb7sItZwGojFPhpYVsuaMWY4N3IthxgRme0rYyGmFUlZ0JrEdxYWbg+9
         8SXPm0B2lMz5BTiXNWSF4+sm36bKjYb6b+wtPCEGaVco88C878uuiNK2qLQFickrpR2H
         yNog==
X-Gm-Message-State: AOAM533GSNbY5SWPsmEuFqeujjwjjL/xuRgn5Z9qumMvMQ8rfgyhIwrK
        +4BJJOOroi2XvzaL9QeMMfswuw==
X-Google-Smtp-Source: ABdhPJy3TA7Zm0d3Igecwi3K7vC2UTfhsaUsH3wa9qhNxxQdvtzae9mfrad6ZSTgTAbD042xH+gvNw==
X-Received: by 2002:a17:902:9009:: with SMTP id a9mr1561226plp.21.1592304077364;
        Tue, 16 Jun 2020 03:41:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 140sm16947400pfz.154.2020.06.16.03.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:41:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 1/5] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
Date:   Tue, 16 Jun 2020 03:40:46 -0700
Message-Id: <20200616034044.v3.1.Ic50cccdf27d42420a63485082f8b5bf86ed1a2b6@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200616104050.84764-1-dianders@chromium.org>
References: <20200616104050.84764-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver locks its locks in two places.

In the first usage of the lock the function doing the locking already
has a sleeping call and thus we know we can't be called from interrupt
context.  That means we can use the "spin_lock_irq" variant of the
function.

In the second usage of the lock the function is the interrupt handler
and we know interrupt handlers are called with interrupts disabled.
That means we can use the "spin_lock" variant of the function.

This patch is expected to be a no-op and is just a cleanup / slight
optimization.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- ("spi: spi-geni-qcom: No need for irqsave variant...") new for v3

Changes in v2: None

 drivers/spi/spi-geni-qcom.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c3972424af71..c7d2c7e45b3f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -122,23 +122,23 @@ static void handle_fifo_timeout(struct spi_master *spi,
 				struct spi_message *msg)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
-	unsigned long time_left, flags;
+	unsigned long time_left;
 	struct geni_se *se = &mas->se;
 
-	spin_lock_irqsave(&mas->lock, flags);
+	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->xfer_done);
 	mas->cur_mcmd = CMD_CANCEL;
 	geni_se_cancel_m_cmd(se);
 	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-	spin_unlock_irqrestore(&mas->lock, flags);
+	spin_unlock_irq(&mas->lock);
 	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (time_left)
 		return;
 
-	spin_lock_irqsave(&mas->lock, flags);
+	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->xfer_done);
 	geni_se_abort_m_cmd(se);
-	spin_unlock_irqrestore(&mas->lock, flags);
+	spin_unlock_irq(&mas->lock);
 	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
 	if (!time_left)
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
@@ -477,12 +477,11 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 	struct geni_se *se = &mas->se;
 	u32 m_irq;
-	unsigned long flags;
 
 	if (mas->cur_mcmd == CMD_NONE)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&mas->lock, flags);
+	spin_lock(&mas->lock);
 	m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
 
 	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
@@ -524,7 +523,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	}
 
 	writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
-	spin_unlock_irqrestore(&mas->lock, flags);
+	spin_unlock(&mas->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.27.0.290.gba653c62da-goog

