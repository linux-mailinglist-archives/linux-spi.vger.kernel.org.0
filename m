Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA579189D
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfHRSBe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33064 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRSBe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id p77so1114869wme.0
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCBDoC+ekFMnt3Xwl9qxhrGy1jvDdKzvnSRei93j4JU=;
        b=EM3eR+wk/79uzDuYsMZPURik9f/eAvrTOTnoHn2l9Yw+imOKY+3zhx/+UQ1AvkKXdW
         pdctnFK57KI7pPvDuUT7pP2HCInb1O7wwizgu9XOBqTPcmWeG3gBtI54OIEtCrHj399d
         srrMX/GlF36iJl5q/JJWSXyB+NjBYrTzYInrkbgW3SZR3L4uL/ZCKSxWK/SeTf85AgHB
         i6+bIM/hQiqS4w3rw7Ea0SjH89A8iinmgwZWABvSgdqqqfteCVcMYw2AUXC/KspdJ5VH
         8DlMTIGFu2E/jSaVMJq5y5GP1ubAhbFF3dLlucD+Zh9J0vSp1piBVXvsryycPb813yhw
         OIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCBDoC+ekFMnt3Xwl9qxhrGy1jvDdKzvnSRei93j4JU=;
        b=eZsIdnV0QvM8yKr2eeO3uND8lrabUKEwBrNjm7bA5q7iby633v8vJVhawhChEAUV7M
         /Eqj7fSgmhWZv9CvFlCnmKYjtMQIwKNGBeKoUQaFxCxajM0Lsk6u0Wswz+9VDloc/b6u
         QpsWiY9iCjrQAxRjQiAgjHzjjq1ej4HH5pUQUzIspxeRmD/zbdnyaOTql/tRq3lZGbLC
         p6TPLHWd6ugEQNPFrqj7NJEl/e1+2fEUNdHY84Ftd1mciX63xeAGJiQYGVqzmaYcR6Ir
         N+9IBpLF571Sc8CJQ6fDGE1RKVyCqZ14UWLKA+vSYVWsZ0o85ltlV96St60Ecu24/SCJ
         U4wg==
X-Gm-Message-State: APjAAAUeKjzbD/xZXLAIdcj6bsCRy8b8+/1DWqyha7oplY+O8h7R4fuA
        uh1sY73ij783UYBiUZz+TX4=
X-Google-Smtp-Source: APXvYqygCZijZNpsKHiW1MwcFeIhlapOyRMNQdSubRNlXxhKV3AHUWbv60Lkate9OqopH0yDJ9qTuA==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr16408974wmj.45.1566151292031;
        Sun, 18 Aug 2019 11:01:32 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:31 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 13/14] spi: spi-fsl-dspi: Reduce indentation level in dspi_interrupt
Date:   Sun, 18 Aug 2019 21:01:14 +0300
Message-Id: <20190818180115.31114-14-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no point in checking which interrupt source was triggered in
SPI_SR, since only EOQ and TCFQ modes trigger interrupts anyway (see the
writes to SPI_RSER). In DMA mode, the RSER is configured for RFDF_DIRS=1
and TFFF_DIRS=1, aka FIFO events generate eDMA requests and not CPU
interrupts.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 76 +++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 790cb02fc181..2993d15f640e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -658,47 +658,45 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
+	/* Get transfer counter (in number of SPI transfers). It was
+	 * reset to 0 when transfer(s) were started.
+	 */
+	regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
+	spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
+	/* Update total number of bytes that were transferred */
+	msg->actual_length += spi_tcnt * dspi->bytes_per_word;
+
+	trans_mode = dspi->devtype_data->trans_mode;
+	switch (trans_mode) {
+	case DSPI_EOQ_MODE:
+		dspi_eoq_read(dspi);
+		break;
+	case DSPI_TCFQ_MODE:
+		dspi_tcfq_read(dspi);
+		break;
+	default:
+		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
+			trans_mode);
+			return IRQ_HANDLED;
+	}
 
-	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
-		/* Get transfer counter (in number of SPI transfers). It was
-		 * reset to 0 when transfer(s) were started.
-		 */
-		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
-		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
-		/* Update total number of bytes that were transferred */
-		msg->actual_length += spi_tcnt * dspi->bytes_per_word;
-
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			dspi_eoq_read(dspi);
-			break;
-		case DSPI_TCFQ_MODE:
-			dspi_tcfq_read(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-				return IRQ_HANDLED;
-		}
+	if (!dspi->len) {
+		dspi->waitflags = 1;
+		wake_up_interruptible(&dspi->waitq);
+		return IRQ_HANDLED;
+	}
 
-		if (!dspi->len) {
-			dspi->waitflags = 1;
-			wake_up_interruptible(&dspi->waitq);
-		} else {
-			switch (trans_mode) {
-			case DSPI_EOQ_MODE:
-				dspi_eoq_write(dspi);
-				break;
-			case DSPI_TCFQ_MODE:
-				dspi_tcfq_write(dspi);
-				break;
-			default:
-				dev_err(&dspi->pdev->dev,
-					"unsupported trans_mode %u\n",
-					trans_mode);
-			}
-		}
+	switch (trans_mode) {
+	case DSPI_EOQ_MODE:
+		dspi_eoq_write(dspi);
+		break;
+	case DSPI_TCFQ_MODE:
+		dspi_tcfq_write(dspi);
+		break;
+	default:
+		dev_err(&dspi->pdev->dev,
+			"unsupported trans_mode %u\n",
+			trans_mode);
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1

