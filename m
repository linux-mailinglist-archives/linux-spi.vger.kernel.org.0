Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384991FF64E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgFRPLQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbgFRPKu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 11:10:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA3C0613ED
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z63so2928380pfb.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+eo8u2tvjQcobTsfwzlNHUA5Mu/KPf2pgVwBrin5d8=;
        b=HC73/dQnkC9Dn5aSVy4RnCYBA5ijhBmCJTKj2PsOBV/VghxkBBjfVyTFAGfWwIbAps
         0iYX0Bw2m+c18/djLCXhIcY6yGIFs5wJ3D/NZ9LshATV8SBeATCxim6b4ZeCdAJD/bpd
         s+HD0VcUYngCx818XJNFW6jugOMX4hlLdHHgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+eo8u2tvjQcobTsfwzlNHUA5Mu/KPf2pgVwBrin5d8=;
        b=HFFNk+6CSeFuoO6CNToUcbAUCgb4gkJTDu9qHVhDSrgNCV2m6wKIS3DA2Y1bPxykYI
         Lt15CqybDzI1xYtTGt28O6dfe7kNAxsRuAJfhH6/Q4glpOvkNhoxwAE8SUqtHMmeEcaA
         Pc0HNfgURlVcKqroKe3a4/CvLnBmCi4gnWaQ7iVB3QSSdsm32oU4y5KBFlmPlqnZzXgY
         zc6atGWLAuE7+twllC7GRrMPtYsBbG1xiUrCDHOi8x6c7JtVGvWjr1p2pZgTV2hf5Hvw
         FfBcgXORsdp6dpgNpLfTKspGH/XNFT08n+j6ZoKb862XiXiZCVCecQcjivY0aHQmm/bl
         YFUQ==
X-Gm-Message-State: AOAM5308EPGCYi8mtiML6DFDYW7kSWiHQIYsye/aokUoHDucSUjpSQSt
        Cg2VY/gkTHZyrPDK1btRp7ulzQ==
X-Google-Smtp-Source: ABdhPJwH4R+xbXw4ZAQeCHxEFnPqtmhSc85aG0KbO3UK44AAzlOvfA5p3syDpRaqGxQ1lUZzcDfIyg==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr3517250pgm.253.1592493047938;
        Thu, 18 Jun 2020 08:10:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 1/5] spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
Date:   Thu, 18 Jun 2020 08:06:22 -0700
Message-Id: <20200618080459.v4.1.Ic50cccdf27d42420a63485082f8b5bf86ed1a2b6@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
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

