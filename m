Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B622DDB64
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 23:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbgLQWaQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 17:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbgLQWaQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 17:30:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB7C0617A7
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 14:29:35 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c22so46423pgg.13
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7xCKWj505XOK8pmaVepIcbXuQ+piHeDyFLhHQR5U2Q=;
        b=MUIEHvh95AUP6V1mzbTcu2YJqrE/3xPIlBC0YJsbKW3ewh99f5g1nMnI0mXabiEg/B
         UroJpxJF6AzkjbS43C706tVZONxmo4K8NmNtdSn1RIU0XCnO0qFM4j4bY2tcd8IJt4z3
         WF6i2QGXLrhaI3qashWV5StE1S7SDu8OKFN0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7xCKWj505XOK8pmaVepIcbXuQ+piHeDyFLhHQR5U2Q=;
        b=CegQ/N+I4ZbHT2qOrJApF3Nrv/9xFjdLPC1E3mQTZOY0hN6PQxcMVrKNw6uTn6vEY/
         YjTFCn1MVvrDkHrBhnAAGDLknUoK7iCevdPBW0eZOrTzPKwn4u+4YUcXhNzIE3nM3DZx
         9GVtaOMP6+fCo2YdGxt5jx+IVN2AnDy+uiuApn7p1nk+00oJGyl1HmzcUuLhYTwVjMSe
         woaLZi7WBvYbtYugVEpf1YKggaBVDBW7cvpPd53+0whD+jH34N3tmn/RE3H2nHiHTbuY
         /Ko+ADqf3tydb31k6AGHiVpO1o0nc9Kga/MLy2Hue5q+wjOmEYnj7/ag2xfv0V52eAw0
         9ElQ==
X-Gm-Message-State: AOAM532Vm2rz4xqf5OxAzZaBqYpZBPMsjPJ4xhOuW0hrh/2R+am/3MQd
        K3RHE+9ug3lX6leh5o6ZrlYNeA==
X-Google-Smtp-Source: ABdhPJz6Dtc4cRRUFyl0u5B3TKJYZN6oBuUE1DwLdrGi6ti46ehE1k4YtBfuwM8sp2oD3Q2patXwcg==
X-Received: by 2002:aa7:93b0:0:b029:19d:e625:2062 with SMTP id x16-20020aa793b00000b029019de6252062mr1320109pff.47.1608244175337;
        Thu, 17 Dec 2020 14:29:35 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id gm18sm5805850pjb.55.2020.12.17.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 14:29:34 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     msavaliy@qti.qualcomm.com, Stephen Boyd <swboyd@chromium.org>,
        akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 1/4] spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout case
Date:   Thu, 17 Dec 2020 14:29:11 -0800
Message-Id: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In commit 7ba9bdcb91f6 ("spi: spi-geni-qcom: Don't keep a local state
variable") we changed handle_fifo_timeout() so that we set
"mas->cur_xfer" to NULL to make absolutely sure that we don't mess
with the buffers from the previous transfer in the timeout case.

Unfortunately, this caused the IRQ handler to dereference NULL in some
cases.  One case:

  CPU0                           CPU1
  ----                           ----
                                 setup_fifo_xfer()
                                  geni_se_setup_m_cmd()
                                 <hardware starts transfer>
                                 <transfer completes in hardware>
                                 <hardware sets M_RX_FIFO_WATERMARK_EN in m_irq>
                                 ...
                                 handle_fifo_timeout()
                                  spin_lock_irq(mas->lock)
                                  mas->cur_xfer = NULL
                                  geni_se_cancel_m_cmd()
                                  spin_unlock_irq(mas->lock)

  geni_spi_isr()
   spin_lock(mas->lock)
   if (m_irq & M_RX_FIFO_WATERMARK_EN)
    geni_spi_handle_rx()
     mas->cur_xfer NULL dereference!

tl;dr: Seriously delayed interrupts for RX/TX can lead to timeout
handling setting mas->cur_xfer to NULL.

Let's check for the NULL transfer in the TX and RX cases and reset the
watermark or clear out the fifo respectively to put the hardware back
into a sane state.

NOTE: things still could get confused if we get timeouts all the way
through handle_fifo_timeout() and then start a new transfer because
interrupts from the old transfer / cancel / abort could still be
pending.  A future patch will help this corner case.

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3:
- (ptr == NULL) => (!ptr), take 2.
- while loop => for loop

Changes in v2:
- (ptr == NULL) => (!ptr).
- Addressed loop nits in geni_spi_handle_rx().
- Commit message rewording from Stephen.

 drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 25810a7eef10..6939c6cabe91 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -354,6 +354,12 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
 	unsigned int bytes_per_fifo_word = geni_byte_per_fifo_word(mas);
 	unsigned int i = 0;
 
+	/* Stop the watermark IRQ if nothing to send */
+	if (!mas->cur_xfer) {
+		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+		return false;
+	}
+
 	max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * bytes_per_fifo_word;
 	if (mas->tx_rem_bytes < max_bytes)
 		max_bytes = mas->tx_rem_bytes;
@@ -396,6 +402,14 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
 		if (rx_last_byte_valid && rx_last_byte_valid < 4)
 			rx_bytes -= bytes_per_fifo_word - rx_last_byte_valid;
 	}
+
+	/* Clear out the FIFO and bail if nowhere to put it */
+	if (!mas->cur_xfer) {
+		for (i = 0; i < DIV_ROUND_UP(rx_bytes, bytes_per_fifo_word); i++)
+			readl(se->base + SE_GENI_RX_FIFOn);
+		return;
+	}
+
 	if (mas->rx_rem_bytes < rx_bytes)
 		rx_bytes = mas->rx_rem_bytes;
 
-- 
2.29.2.684.gfbc64c5ab5-goog

