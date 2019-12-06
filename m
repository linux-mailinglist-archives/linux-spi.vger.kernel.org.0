Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57B1154C2
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLFQA2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 11:00:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfLFQA2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 11:00:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so8369198wrq.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Dec 2019 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFIvByA81LFz7lfVmJWwdH83asL5XC8YFzmQ8CPDf+M=;
        b=VRHS39ZKEQF6d1JgJtcM6SfYmjOG8APVHHlLzsDJRGbvPk5vJ7l7MwTEei6JGNZqaY
         8riIjKsx2kfyKDmLp7kTo8usA9MdlKnl2cTJBR/tdOXBEp1GBLOsAz88JiiQYFmWLlOz
         hnQjsKCrHIyrhqJd2gw4M99BXOWOKlvTuF9gY5/31bfP2lTXHPRAIe1BjzGqUoGmBkil
         aZV8PniJHpdwqSQZS/GqCHsfXhEHa5hcvMBigX6jtEJpmNSlRymow+U/pww7SIHEAHDt
         PPZhhJscj1NkVE7+S6LNFkcvHf3X5AV9n3ZpLoiX5wbCgvy4qNTcFVCGJ+yy0xXsqO11
         5H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFIvByA81LFz7lfVmJWwdH83asL5XC8YFzmQ8CPDf+M=;
        b=Zuhu001mc+u3TmUHjZMvEiIUZXVhkoyudhBTO26WeZjOzTnBavaGttQv6cYgfhn/xn
         4l6LerlzWLgwXYdf1jTEQl3KtuOMDhXB3kg+pvWneWxnM2hCQkaIir77SNv18d4rHh5H
         ALfZHwIhFp7kyK2Ape07Ze0Wit9R5sX8VQ4yggf8xReezgVk0nNz2SQw1ehAKZb/pIUw
         X8QK5jtPwGyxmjvnueX8dmLnY38sfXZyghIKWwN+9856DC7EwtWQsh/JuJ0HEGcrsYTw
         7xnMu/O//I4f3wD6xFATS8lB07RGOAWXuguQI/LZw53dzh7LH2u9Io63LnAkY7UALTyL
         t35g==
X-Gm-Message-State: APjAAAWCkiTx9ckI2aSDqtltQj37NTPKqdZwOWE+tHrTscQONKo84pB6
        HWXmhsIckD1c3ckrRNYpIWxMOQ==
X-Google-Smtp-Source: APXvYqwsW9MIlkZXXKhO8CIVTJMfeF4j78dDHCcsdzZNu6m5M2Zbl2NHuLKYSrhMSxZSV+fbS2Z9QA==
X-Received: by 2002:adf:c746:: with SMTP id b6mr15689207wrh.298.1575648026370;
        Fri, 06 Dec 2019 08:00:26 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id d19sm3891496wmd.38.2019.12.06.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:00:25 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 3/3] TI QSPI: optimize transfers for dual and quad read
Date:   Fri,  6 Dec 2019 17:00:07 +0100
Message-Id: <20191206160007.331801-4-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206160007.331801-1-jean.pihet@newoldbits.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

By reading the 32 bits data register and copy the contents to the
receive buffer, according to the single/dual/quad read mode and
the data length to read.

The speed improvement is 3.5x using quad read.
---
 drivers/spi/spi-ti-qspi.c | 48 ++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 13916232a959..65ec3bcb25ae 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -313,24 +313,25 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 			 int count)
 {
-	int wlen;
 	unsigned int cmd;
+	u32 rx;
 	u8 *rxbuf;
+	u8 xfer_len;
 
 	rxbuf = t->rx_buf;
 	cmd = qspi->cmd;
+	/* Optimize the transfers for dual and quad read */
 	switch (t->rx_nbits) {
-	case SPI_NBITS_DUAL:
-		cmd |= QSPI_RD_DUAL;
-		break;
 	case SPI_NBITS_QUAD:
-		cmd |= QSPI_RD_QUAD;
+		cmd |= QSPI_RD_QUAD | QSPI_WLEN(32);
+		break;
+	case SPI_NBITS_DUAL:
+		cmd |= QSPI_RD_DUAL | QSPI_WLEN(16);
 		break;
 	default:
-		cmd |= QSPI_RD_SNGL;
+		cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
 		break;
 	}
-	wlen = t->bits_per_word >> 3;	/* in bytes */
 
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
@@ -342,19 +343,34 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 			dev_err(qspi->dev, "read timed out\n");
 			return -ETIMEDOUT;
 		}
-		switch (wlen) {
-		case 1:
-			*rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
+
+		/* Optimize the transfers for dual and quad read */
+		rx = readl(qspi->base + QSPI_SPI_DATA_REG);
+		switch (t->rx_nbits) {
+		case SPI_NBITS_QUAD:
+			if (count >= 1)
+				*rxbuf++ = rx >> 24;
+			if (count >= 2)
+				*rxbuf++ = rx >> 16;
+			if (count >= 3)
+				*rxbuf++ = rx >> 8;
+			if (count >= 4)
+				*rxbuf++ = rx;
+			xfer_len = min(count, 4);
 			break;
-		case 2:
-			*((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
+		case SPI_NBITS_DUAL:
+			if (count >= 1)
+				*rxbuf++ = rx >> 8;
+			if (count >= 2)
+				*rxbuf++ = rx;
+			xfer_len = min(count, 2);
 			break;
-		case 4:
-			*((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
+		default:
+			*rxbuf++ = rx;
+			xfer_len = 1;
 			break;
 		}
-		rxbuf += wlen;
-		count -= wlen;
+		count -= xfer_len;
 	}
 
 	return 0;
-- 
2.23.0

