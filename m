Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA13AF90
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2019 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfFJHWu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jun 2019 03:22:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32814 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387785AbfFJHWt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jun 2019 03:22:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so8051711wru.0
        for <linux-spi@vger.kernel.org>; Mon, 10 Jun 2019 00:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbLxpWuUonBzNVgnD/xYkcw7GrDlHMS37R/RDa4E2Kg=;
        b=abcOHs1oSH8mEsGUMSJzy5b1RaEKPt7RkL3pIvcDpv2/Oh1dFwoc/BMA9x2X7NGuaU
         8BakLflGRhZ+v7Y2Sai9DDGqdZCjRGFLOaU7hwveLAXKQ2dSBTr+7P9N2dQlWWMx3fMw
         6FnwUAfnPZa8o8RPcbm3PRlnj+nvkvPfHYD0hbiSX2lafD7Q641AJSoxEAnYBOscYGlD
         ZgU4LxAwRd8A20yrnIphC2fra/0ugdtvIuay4c+RJ+ABZ64movos5GBB2Fm+D1Tf5VkN
         MySvEsSsERbcPD6s4EOyp9rdNyA3RjB5HHhv+Bz7cSxLEG9/5FqmI0MZEcZQIK8e5wyR
         2I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbLxpWuUonBzNVgnD/xYkcw7GrDlHMS37R/RDa4E2Kg=;
        b=SUS1AZ/sA5VtYcQWimmGDNDcKyO9ng32fKBkNRvc8Chn5oPuU0K09wpRT96XBMPUQt
         oEGKlFGWdZG64VdzboskI2+DyPlm5EKO4pYtwHHFwi4hA56sHZ8bZzawfgx6kVlE/zSv
         6ObCXrh8J3xL/EOZe/G6+DqpwPv8toJ7hbQBohE9ZVRdrWed08kTZsvnaM4KFacWz/Ps
         8E1YsFDKF1nN6Y0zUenNYQnR+hKIKQUjBtFGd5x5G4uSQ8rw+AEbyIVRQc5B+fiqVBiH
         Gn650abHwNh9fLxcTHl1xhZAFV/bOmOEpouMf4Vwy8v4rbZgFvzrH+643mdgyQS2WWNp
         gX8g==
X-Gm-Message-State: APjAAAUkbQ5swTpb/EQtbvn0hkgnbpkWNbX7kdnMOGT1afw5sdAWJk9L
        oYUXb53IWNKBsTOBJ6q+WkKgNExGTBA=
X-Google-Smtp-Source: APXvYqzQEDfQc3vaIs3W803X6//9nQHYTuEqtlawE9U0l12vpy7sFBz3r42F3OHypKgv/d6CvaTDFA==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3mr17499958wrt.259.1560151367402;
        Mon, 10 Jun 2019 00:22:47 -0700 (PDT)
Received: from localhost.localdomain (233.red-79-146-84.dynamicip.rima-tde.net. [79.146.84.233])
        by smtp.gmail.com with ESMTPSA id y9sm12587654wma.1.2019.06.10.00.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jun 2019 00:22:46 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org
Subject: [PATCH] spi: qup: fix PIO/DMA transfers.
Date:   Mon, 10 Jun 2019 09:22:43 +0200
Message-Id: <20190610072243.19710-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

- DMA/PIO:
  If an error IRQ occurred during PIO or DMA mode make sure to log it so
on completion the transfer can be marked as an error.

- PIO:
  Do not complete a transaction until all data has been transferred or
an error IRQ was flagged.

1) If there was no error IRQ, ignore the done flag IRQ
(QUP_OP_MAX_INPUT_DONE_FLAG) until all data for the transfer has been
processed: not doing so risks completing the transfer returning
uninitialized data in the buffers.

2) Under stress testing we have identified the need to
protect read/write operations against spurious IN/OUT service events.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/spi/spi-qup.c | 51 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..0a2ffd2f968a 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -281,6 +281,9 @@ static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
+		if (!remainder)
+			goto exit;
+
 		if (is_block_mode) {
 			num_words = (remainder > words_per_block) ?
 					words_per_block : remainder;
@@ -310,11 +313,13 @@ static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 	 * to refresh opflags value because MAX_INPUT_DONE_FLAG may now be
 	 * present and this is used to determine if transaction is complete
 	 */
-	*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
-	if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
-		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
-			       controller->base + QUP_OPERATIONAL);
-
+exit:
+	if (!remainder) {
+		*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
+		if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
+			writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
+				       controller->base + QUP_OPERATIONAL);
+	}
 }
 
 static void spi_qup_write_to_fifo(struct spi_qup *controller, u32 num_words)
@@ -362,6 +367,10 @@ static void spi_qup_write(struct spi_qup *controller)
 		writel_relaxed(QUP_OP_OUT_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
+		/* make sure the interrupt is valid */
+		if (!remainder)
+			return;
+
 		if (is_block_mode) {
 			num_words = (remainder > words_per_block) ?
 				words_per_block : remainder;
@@ -575,10 +584,24 @@ static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 	return 0;
 }
 
+static bool spi_qup_data_pending(struct spi_qup *controller)
+{
+	unsigned int remainder_tx, remainder_rx;
+
+	remainder_tx = DIV_ROUND_UP(spi_qup_len(controller) -
+				    controller->tx_bytes, controller->w_size);
+
+	remainder_rx = DIV_ROUND_UP(spi_qup_len(controller) -
+				    controller->rx_bytes, controller->w_size);
+
+	return remainder_tx || remainder_rx;
+}
+
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
 	u32 opflags, qup_err, spi_err;
+	unsigned long flags;
 	int error = 0;
 
 	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
@@ -610,6 +633,11 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
+	spin_lock_irqsave(&controller->lock, flags);
+	if (!controller->error)
+		controller->error = error;
+	spin_unlock_irqrestore(&controller->lock, flags);
+
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
@@ -618,11 +646,22 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
 			spi_qup_write(controller);
+
+		if (!spi_qup_data_pending(controller))
+			complete(&controller->done);
 	}
 
-	if ((opflags & QUP_OP_MAX_INPUT_DONE_FLAG) || error)
+	if (error)
 		complete(&controller->done);
 
+	if (opflags & QUP_OP_MAX_INPUT_DONE_FLAG) {
+		if (!spi_qup_is_dma_xfer(controller->mode)) {
+			if (spi_qup_data_pending(controller))
+				return IRQ_HANDLED;
+		}
+		complete(&controller->done);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.21.0

