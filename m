Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF679189C
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfHRSBd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51044 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfHRSBd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so1081598wml.0
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=igXPnduYhKBH5+mNSVyZR6NtJ1A9nwGY3f25lXnx6jo=;
        b=YKHlYZ/OaiLLmpWXd9M0s+RX4pI7hh1SlORRDUuPaN6IUX2c02d0fKTyy19XNIlOlm
         O6fLFl4xePyt43cxlhP9kIdf/2zFG5/K+WUmmYWSRkgVUnV3mZ7cOYmnpMimvEtOST4K
         YaX0FKREZdgQ7gq/ky1Bgo6XZ/0GoJihIlrkI9wxTlVTVyOAMk6Dko6vzMpPxrnaZOIL
         ConiNom76IUC2hx0RoB+LhE3inqurRkMR15K4GHErTnPY0HGRshZnjI0vqFmWvIp3Two
         pNJsVT7AELnd52Xs3JwJX4pinM1YkGvf2ZZ/zqqrPGy7uBMmi8eId3R1hOrt6jfjW+Bz
         ekCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=igXPnduYhKBH5+mNSVyZR6NtJ1A9nwGY3f25lXnx6jo=;
        b=KIdyewrv55W6jxmyIHVQ9CFhCo9G7S5XVuHj1uBRmniZCCdR19IHiLeRRfm/S3RMs6
         QOQvRdcEWpc90HSTTCLXaBct5U/6eHR2PIpagnucG6H+aFt4NA5g4sDbzfXKZt8ukXFN
         7HmbF443fwJJF9hl0vJRGUadl/1jgHr9zTSdtTRIAGsCDA5KEvyf2s1q3EJeZFvjWUbB
         WTwLsBeR60g8HWzXzJhk7RwuF4uJ3fPZl7uIFa08Djm/war9o8LkrSQMtmxv47auBoz0
         Yi4w1Q1YST7v2aVmu/2i0p6B1zNrsAx9+Ff2A+5npjoMCydyQf+e5vs17zcEOfj9s7iS
         in7g==
X-Gm-Message-State: APjAAAVdZ3un+9RRCd5Czf95SyvUzvHGe7Xq5ipJD0g6sVjdShFVx7v4
        t/di9YxmwOsiRzW8ZoDTJoc=
X-Google-Smtp-Source: APXvYqzcfAVDb0G469fefz5V9eY6GgWEwlSOFF1SWrGe1dXe28hzlaVO8xAX3f1jNDKZKbCXkUmb8g==
X-Received: by 2002:a05:600c:2c9:: with SMTP id 9mr16435769wmn.79.1566151291098;
        Sun, 18 Aug 2019 11:01:31 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:30 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 12/14] spi: spi-fsl-dspi: Move dspi_interrupt above dspi_transfer_one_message
Date:   Sun, 18 Aug 2019 21:01:13 +0300
Message-Id: <20190818180115.31114-13-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The two functions are loosely coupled through dspi->waitq, but
logically, dspi_transfer_one_message depends on dspi_interrupt in order
to complete. Move its definition above it so the I/O functions are
grouped closer together.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 114 ++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6128c695d06f..790cb02fc181 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -647,6 +647,63 @@ static void dspi_eoq_read(struct fsl_dspi *dspi)
 		dspi_push_rx(dspi, fifo_read(dspi));
 }
 
+static irqreturn_t dspi_interrupt(int irq, void *dev_id)
+{
+	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	struct spi_message *msg = dspi->cur_msg;
+	enum dspi_trans_mode trans_mode;
+	u32 spi_sr, spi_tcr;
+	u16 spi_tcnt;
+
+	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+	regmap_write(dspi->regmap, SPI_SR, spi_sr);
+
+
+	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
+		/* Get transfer counter (in number of SPI transfers). It was
+		 * reset to 0 when transfer(s) were started.
+		 */
+		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
+		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
+		/* Update total number of bytes that were transferred */
+		msg->actual_length += spi_tcnt * dspi->bytes_per_word;
+
+		trans_mode = dspi->devtype_data->trans_mode;
+		switch (trans_mode) {
+		case DSPI_EOQ_MODE:
+			dspi_eoq_read(dspi);
+			break;
+		case DSPI_TCFQ_MODE:
+			dspi_tcfq_read(dspi);
+			break;
+		default:
+			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
+				trans_mode);
+				return IRQ_HANDLED;
+		}
+
+		if (!dspi->len) {
+			dspi->waitflags = 1;
+			wake_up_interruptible(&dspi->waitq);
+		} else {
+			switch (trans_mode) {
+			case DSPI_EOQ_MODE:
+				dspi_eoq_write(dspi);
+				break;
+			case DSPI_TCFQ_MODE:
+				dspi_tcfq_write(dspi);
+				break;
+			default:
+				dev_err(&dspi->pdev->dev,
+					"unsupported trans_mode %u\n",
+					trans_mode);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				     struct spi_message *message)
 {
@@ -825,63 +882,6 @@ static void dspi_cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
-static irqreturn_t dspi_interrupt(int irq, void *dev_id)
-{
-	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
-	struct spi_message *msg = dspi->cur_msg;
-	enum dspi_trans_mode trans_mode;
-	u32 spi_sr, spi_tcr;
-	u16 spi_tcnt;
-
-	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-	regmap_write(dspi->regmap, SPI_SR, spi_sr);
-
-
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
-
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
-	}
-
-	return IRQ_HANDLED;
-}
-
 static const struct of_device_id fsl_dspi_dt_ids[] = {
 	{ .compatible = "fsl,vf610-dspi", .data = &vf610_data, },
 	{ .compatible = "fsl,ls1021a-v1.0-dspi", .data = &ls1021a_v1_data, },
-- 
2.17.1

