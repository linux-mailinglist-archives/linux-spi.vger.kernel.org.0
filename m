Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62B1FFEC6
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgFRXkM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFRXkD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 19:40:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E292C061795
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 16:40:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so3140732pld.13
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LwNUM9r2K766Bpc8uhRggwPkvLcxyldoWgAyqBsLHs=;
        b=JGQdHi4cAk9ynSlkc2MLZrVw9vuu0aa67R3mMbMXCKleaglDUWIgiBE9LgBxuCJX9/
         Q0AHLynQe4sKoPSZhrnps5qRe+CywpQ30+7AFC10rSRq/IajqSOZdLYKEDIR3Al6AAxc
         T9Sdas8h9nx2DwLg2KFwPelACgyIMiUDXlWw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LwNUM9r2K766Bpc8uhRggwPkvLcxyldoWgAyqBsLHs=;
        b=e/xUoZpqZclxNPFylxnb5r7faUJEztOvzygqdzNNL5vWLbBzkwtkb5d4gKuCiL+98P
         +m+ycXhZb79yS31/vL9smTvWAjtMcvDOOim0CEvgbA6zZYteYNcjqB2S+9V+wb6qaPHw
         fIZqs9qcggGFtGDun0DKCgiGX8PecC0RsgZiygehQp9OgTKvAeIx/fqZ7aAvqCZPHTc/
         IiwSw0LQa8IFe+zOLp60LmhPhe1bONlBKL5mc0tZW9+uRfsj4kWRkRpnRVvnq1BUJr2W
         gFsLZ0BP9s5FGCR/+b9jMD9SdEIldfM0BoAYZSnQWyip8pgC/GIbwT7dK0A7lkMz7Ti2
         8+OQ==
X-Gm-Message-State: AOAM532x7lmyZOMyaiyflrDYozbyorcX+nfiXa3XNhbq1TrXDpfd7JYc
        iKr5S2r3/rUWdAsX8JJ1/psU5Q==
X-Google-Smtp-Source: ABdhPJwQ/hJoSBJMHMkuQtqXhSeDW1z3BUpC+AR+YhDRj5//RUP55YF1vFN5nLf+YeDoKlM4/qVEcg==
X-Received: by 2002:a17:90a:7c4e:: with SMTP id e14mr732821pjl.175.1592523601795;
        Thu, 18 Jun 2020 16:40:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r202sm3876993pfr.185.2020.06.18.16.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:40:01 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 7/5] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily
Date:   Thu, 18 Jun 2020 16:39:59 -0700
Message-Id: <20200618233959.160032-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
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

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 42 ++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 670f83793aa4..828cfc988a3f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -126,7 +126,6 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	 * came in while cancelling.
 	 */
 	mas->cur_xfer = NULL;
-	mas->tx_rem_bytes = mas->rx_rem_bytes = 0;
 	geni_se_cancel_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
 
@@ -517,29 +516,30 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
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

