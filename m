Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3C201FBA
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jun 2020 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgFTCWk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 22:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbgFTCWh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 22:22:37 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A44C06174E
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 19:22:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so4934519pjb.0
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8daI+7CHtS2SGwOQ57VLIhX3tB1mOsr4d2U1XP+ENVs=;
        b=Jre00MLLpeaEgMC7xAvwh2VApA4lk7QcQsV8D6Mxzsvq52gxPrBBFi8bp0/8hHanCK
         7E2qXxpp5//4sx2ENJklcEAzL5VVFcq1pAbfN1/DmdQB7AZY8ysHqm+KBKWhPRm14hTa
         q+l3du9vfNpJxVxa+jI3vnJhiwzUUCNNx+vlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8daI+7CHtS2SGwOQ57VLIhX3tB1mOsr4d2U1XP+ENVs=;
        b=ZRLla/A2zPCR94BpCrh2Q75HDiqw71sK8y1XC8ozVUAtJ9o/UEoDJIWAUWgFY5n10B
         /2EbakKl0UlcPLYN7+4U+xXibfXuDbqbqJsEcHBddVvbqy/kESn9CySEQ4+woUCNqDGU
         BRckAdnfbH7eh9y1AauyqE5G0hMmXqERgrGCkiefZ4/Hir4s9R++P0j+m6bcVnPkIe6Q
         jDvGYShvvjTJtPZ3NdS7Zr2TFjNFt8nA/ql2juuAKIV7xVdy1fdsbm7zASg3SSsf00kN
         jUgvgCTDua3I/ncvhHUJWH6NTo+HwVaFpaCXGmdw+VAf6NjewaOfYYqOrAHci/kUhgz0
         mFOA==
X-Gm-Message-State: AOAM531mRhODm9apL94h1YIyjo4e6AQm0KcJ+IQxOFufbCn3qvQhn6PA
        nrChqcuJN5dibPIrePxWTCMKLA==
X-Google-Smtp-Source: ABdhPJxZVZK+DAbBoeCkpomttawBBc2pN2fNIkuE1bBJYMAglO+5AXAsYm304Uz2BQLoz+gqupcDXw==
X-Received: by 2002:a17:902:ed49:: with SMTP id y9mr10440152plb.284.1592619756732;
        Fri, 19 Jun 2020 19:22:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m14sm6241911pjv.12.2020.06.19.19.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 19:22:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v1 2/2] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily
Date:   Fri, 19 Jun 2020 19:22:33 -0700
Message-Id: <20200620022233.64716-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200620022233.64716-1-swboyd@chromium.org>
References: <20200620022233.64716-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We only need to test for these counters being non-zero when we see the
end of a transfer. If we're doing a CS change then they will already be
zero.  This implies that we don't need to set these to 0 if we're
cancelling an in flight transfer too, because we only care to test these
counters when the 'DONE' bit is set in the hardware and we've set them
to non-zero for a transfer.

This is a non-functional change, just cleanup to consolidate code.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 42 ++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d8f03ffb8594..5b1dca1fff79 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -122,7 +122,6 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	reinit_completion(&mas->cancel_done);
 	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 	mas->cur_xfer = NULL;
-	mas->tx_rem_bytes = mas->rx_rem_bytes = 0;
 	geni_se_cancel_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
 
@@ -513,29 +512,30 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		if (mas->cur_xfer) {
 			spi_finalize_current_transfer(spi);
 			mas->cur_xfer = NULL;
+			/*
+			 * If this happens, then a CMD_DONE came before all the
+			 * Tx buffer bytes were sent out. This is unusual, log
+			 * this condition and disable the WM interrupt to
+			 * prevent the system from stalling due an interrupt
+			 * storm.
+			 *
+			 * If this happens when all Rx bytes haven't been
+			 * received, log the condition. The only known time
+			 * this can happen is if bits_per_word != 8 and some
+			 * registers that expect xfer lengths in num spi_words
+			 * weren't written correctly.
+			 */
+			if (mas->tx_rem_bytes) {
+				writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+				dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
+					mas->tx_rem_bytes, mas->cur_bits_per_word);
+			}
+			if (mas->rx_rem_bytes)
+				dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
+					mas->rx_rem_bytes, mas->cur_bits_per_word);
 		} else {
 			complete(&mas->cs_done);
 		}
-
-		/*
-		 * If this happens, then a CMD_DONE came before all the Tx
-		 * buffer bytes were sent out. This is unusual, log this
-		 * condition and disable the WM interrupt to prevent the
-		 * system from stalling due an interrupt storm.
-		 * If this happens when all Rx bytes haven't been received, log
-		 * the condition.
-		 * The only known time this can happen is if bits_per_word != 8
-		 * and some registers that expect xfer lengths in num spi_words
-		 * weren't written correctly.
-		 */
-		if (mas->tx_rem_bytes) {
-			writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-			dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
-				mas->tx_rem_bytes, mas->cur_bits_per_word);
-		}
-		if (mas->rx_rem_bytes)
-			dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
-				mas->rx_rem_bytes, mas->cur_bits_per_word);
 	}
 
 	if (m_irq & M_CMD_CANCEL_EN)
-- 
Sent by a computer, using git, on the internet

