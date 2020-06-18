Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1131FF647
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgFRPLB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbgFRPKy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 11:10:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B53C0613EE
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so3023247pgo.9
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4WpNdW6vNPqyWYwEyXbMN3MKHk3EbcVItClv2f3EZU=;
        b=dH8VWtr5H0+lYfILsmT6ScmwmCOKzTfPUZe3jKBFZg9TNjr9hSU5sdTGWtB3RJncaN
         AtYBH9KOmXVWOPwZyAGiz0tshcbNFz8/Unp+P9oWAvA3rvsm0Fy6NaPdExkJJ2QJuWSx
         k/x6DPcz0WPccx0UG8h2uWoZjOLIK1p7jkBFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4WpNdW6vNPqyWYwEyXbMN3MKHk3EbcVItClv2f3EZU=;
        b=iOJUypZZ0luwuIerfdPFyVf5wJm9x+zRXTRdCV7Ak43xlNn4Hvy+oSEzqTq8TY0UCn
         HUxcAxp2HgT9HDb6ZcospD7Skg9Lcwc9rEbrH5UrLd/A5c8/q4bWCoi4KBpcPYe5jBSn
         ZDL0q5Z1YfbrgtTconKbrw0GXcLZ39wkph0k+LqCBbtxdtmGRLk4ydrGFbgilUSn+DVc
         ryaHPphNGj7v2DgXN1/Vh6qNjiQqC5moRuPrBKFjUV109Et0Mh/PaJtmnBZrW9yFpOSf
         hHK3PgeH1SrEbztXfK1eEnQGyeIQTauVgL9lFR4ltH+nFsvqXFlvljPtYbVfl/j2NWbu
         536Q==
X-Gm-Message-State: AOAM5307yru+Du7mTKqhRzL1p4q7LfT2+A9BQ3exE3Naj4Q9MDRbwAif
        1VPD0Rm8hbxFiXSiGTUEJsidnw==
X-Google-Smtp-Source: ABdhPJytq+tfcAyMoofwFs/+vA00AkGYTDF9W8ylxgUb2Mg8XNqsOtezXIuPvb60CeLZvUVmgSKhGg==
X-Received: by 2002:a63:1910:: with SMTP id z16mr3591357pgl.50.1592493053836;
        Thu, 18 Jun 2020 08:10:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b14sm3171510pft.23.2020.06.18.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:10:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
Date:   Thu, 18 Jun 2020 08:06:26 -0700
Message-Id: <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200618150626.237027-1-dianders@chromium.org>
References: <20200618150626.237027-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The variable "cur_mcmd" kept track of our current state (idle, xfer,
cs, cancel).  We don't really need it, so get rid of it.  Instead:
* Use separate condition variables for "chip select done", "cancel
  done", and "abort done".  This is important so that if a "done"
  comes through (perhaps some previous interrupt finally came through)
  it can't confuse the cancel/abort function.
* Use the "done" interrupt only for when a chip select or transfer is
  done and we can tell the difference by looking at whether "cur_xfer"
  is NULL.

This is mostly a no-op change.  However, it is possible it could fix
an issue where a super delayed interrupt for a cancel command could
have confused our waiting for an abort command.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- ("spi: spi-geni-qcom: Don't keep a local state variable") new in v3.

Changes in v2: None

 drivers/spi/spi-geni-qcom.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5b8ca8b93b06..0c534d151370 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -63,13 +63,6 @@
 #define TIMESTAMP_AFTER		BIT(3)
 #define POST_CMD_DELAY		BIT(4)
 
-enum spi_m_cmd_opcode {
-	CMD_NONE,
-	CMD_XFER,
-	CMD_CS,
-	CMD_CANCEL,
-};
-
 struct spi_geni_master {
 	struct geni_se se;
 	struct device *dev;
@@ -81,10 +74,11 @@ struct spi_geni_master {
 	unsigned int tx_rem_bytes;
 	unsigned int rx_rem_bytes;
 	const struct spi_transfer *cur_xfer;
-	struct completion xfer_done;
+	struct completion cs_done;
+	struct completion cancel_done;
+	struct completion abort_done;
 	unsigned int oversampling;
 	spinlock_t lock;
-	enum spi_m_cmd_opcode cur_mcmd;
 	int irq;
 };
 
@@ -126,20 +120,23 @@ static void handle_fifo_timeout(struct spi_master *spi,
 	struct geni_se *se = &mas->se;
 
 	spin_lock_irq(&mas->lock);
-	reinit_completion(&mas->xfer_done);
-	mas->cur_mcmd = CMD_CANCEL;
-	geni_se_cancel_m_cmd(se);
+	reinit_completion(&mas->cancel_done);
 	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	mas->cur_xfer = NULL;
+	mas->tx_rem_bytes = mas->rx_rem_bytes = 0;
+	geni_se_cancel_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+
+	time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
 	if (time_left)
 		return;
 
 	spin_lock_irq(&mas->lock);
-	reinit_completion(&mas->xfer_done);
+	reinit_completion(&mas->abort_done);
 	geni_se_abort_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+
+	time_left = wait_for_completion_timeout(&mas->abort_done, HZ);
 	if (!time_left)
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
 }
@@ -156,15 +153,14 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 		set_flag = !set_flag;
 
 	spin_lock_irq(&mas->lock);
-	reinit_completion(&mas->xfer_done);
-	mas->cur_mcmd = CMD_CS;
+	reinit_completion(&mas->cs_done);
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
 	else
 		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
 	spin_unlock_irq(&mas->lock);
 
-	time_left = wait_for_completion_timeout(&mas->xfer_done, HZ);
+	time_left = wait_for_completion_timeout(&mas->cs_done, HZ);
 	if (!time_left)
 		handle_fifo_timeout(spi, NULL);
 
@@ -383,7 +379,6 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		mas->rx_rem_bytes = xfer->len;
 	}
 	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
-	mas->cur_mcmd = CMD_XFER;
 
 	/*
 	 * Lock around right before we start the transfer since our
@@ -520,11 +515,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		geni_spi_handle_tx(mas);
 
 	if (m_irq & M_CMD_DONE_EN) {
-		if (mas->cur_mcmd == CMD_XFER)
+		if (mas->cur_xfer) {
 			spi_finalize_current_transfer(spi);
-		else if (mas->cur_mcmd == CMD_CS)
-			complete(&mas->xfer_done);
-		mas->cur_mcmd = CMD_NONE;
+			mas->cur_xfer = NULL;
+		} else {
+			complete(&mas->cs_done);
+		}
+
 		/*
 		 * If this happens, then a CMD_DONE came before all the Tx
 		 * buffer bytes were sent out. This is unusual, log this
@@ -546,10 +543,10 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 				mas->rx_rem_bytes, mas->cur_bits_per_word);
 	}
 
-	if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
-		mas->cur_mcmd = CMD_NONE;
-		complete(&mas->xfer_done);
-	}
+	if (m_irq & M_CMD_CANCEL_EN)
+		complete(&mas->cancel_done);
+	if (m_irq & M_CMD_ABORT_EN)
+		complete(&mas->abort_done);
 
 	/*
 	 * It's safe or a good idea to Ack all of our our interrupts at the
@@ -617,7 +614,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->handle_err = handle_fifo_timeout;
 	spi->set_cs = spi_geni_set_cs;
 
-	init_completion(&mas->xfer_done);
+	init_completion(&mas->cs_done);
+	init_completion(&mas->cancel_done);
+	init_completion(&mas->abort_done);
 	spin_lock_init(&mas->lock);
 	pm_runtime_enable(dev);
 
-- 
2.27.0.290.gba653c62da-goog

