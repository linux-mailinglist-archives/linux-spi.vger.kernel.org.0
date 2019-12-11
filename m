Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3608411BD2D
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2019 20:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLKTkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Dec 2019 14:40:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40259 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLKTkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Dec 2019 14:40:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so8314152wmi.5
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2019 11:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6aD3ZwnsdG7TKWm0dgTcaqxnRc3IcXouy4MGbRCkRU=;
        b=kujCsLCY1yor+FFFDqrEFqahY0s7rgN8LbecSpHECQVcTOTGtWjkUKa6pt+r2us32M
         AkwZ7QR7aHetXsHPnC38l+eEf0dZ7YTi11We+jSvuGUUuaUs4xx2IB/7OJ8xKiLNhgp6
         DnoRSbNzsGJO+S/1kui4C4dnq1f4l9Y7TJz5AMN6tB8wk8/KWlsLPaT2hb+5g4MFaQ06
         dzAOuSWcx1/4noCq/3Mfem7hjyHbjFNpMVH9OjHRWnSmU2pnArKAYOH8ycQSkJvkILcj
         aQ586rLsiAb7Vb/0c9i1np7i6eQ+wg+K571bWAGJO/x3n9T78S6QB34g0xrxmvmvRm1X
         YOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6aD3ZwnsdG7TKWm0dgTcaqxnRc3IcXouy4MGbRCkRU=;
        b=cs9bAKYnmHk7rSOS3XCCjknes999bvjQQnwjis9An2162yOR6Ufi0pOB/xOM1NWmbS
         Nfr7jWc0pnbDM90smqsucc3IKR68xk3eG/b/zWlNquKCVoDmGbgE4kvRjGX+7AvWhmXT
         YEMn+mBlliMHY+VGsVqXsS6q7Z0LFi/zzu8Dz3zBMMiEwfptMG39nZy+KLM00699iAkb
         OI4WC+ManYbAs3DHVpnwy+smKKHKXH2YihVfKXU2SCyCPkP3QcvYKmZnNT3WRlbwE3cZ
         eN3DSAflb4XT9UG+H7cHh1fn6AwcV9daZaAE66wDyKnGFtu/YGsqlj7CXBQ00dOpE5rV
         PfGA==
X-Gm-Message-State: APjAAAXwNfdt0udAy19QmarPtUUX+O9GqC3EDyctvhrIWe+pfA3KgkrY
        +Xu+jitG3EuVOqGnt0j41hkFVw==
X-Google-Smtp-Source: APXvYqyg62SDpqGnNqjiXv5hgkclclMtPjpRCK5K6TEYzFRcIhPUEoIj181s3viZTu+oR0ZQSuzYuw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr1749923wmb.150.1576093215057;
        Wed, 11 Dec 2019 11:40:15 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id x1sm3309964wru.50.2019.12.11.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 11:40:14 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 3/3] spi: spi-ti-qspi: optimize byte-transfers
Date:   Wed, 11 Dec 2019 20:39:54 +0100
Message-Id: <20191211193954.747745-4-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211193954.747745-1-jean.pihet@newoldbits.com>
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Optimize the 8-bit based transfers, as used by the SPI flash
devices, by reading the data registers by 32 and 128 bits when
possible and copy the contents to the receive buffer.

The speed improvement is 4.9x using quad read.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ryan Barnett <ryan.barnett@rockwellcollins.com>
Cc: Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
---
 drivers/spi/spi-ti-qspi.c | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index aee4709d105e..d37306cafd8b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -313,6 +313,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 {
 	int wlen;
 	unsigned int cmd;
+	u32 rx;
+	u8 rxlen, rx_wlen;
 	u8 *rxbuf;
 
 	rxbuf = t->rx_buf;
@@ -335,14 +337,60 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 		if (qspi_is_busy(qspi))
 			return -EBUSY;
 
+		switch (wlen) {
+		case 1:
+			/*
+			 * Optimize the 8-bit words transfers, as used by
+			 * the SPI flash devices.
+			 */
+			if (count >= QSPI_WLEN_MAX_BYTES) {
+				rxlen = QSPI_WLEN_MAX_BYTES;
+			} else {
+				rxlen = min(count, 4);
+			}
+			rx_wlen = rxlen << 3;
+			cmd &= ~QSPI_WLEN_MASK;
+			cmd |= QSPI_WLEN(rx_wlen);
+			break;
+		default:
+			rxlen = wlen;
+			break;
+		}
+
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
 		if (ti_qspi_poll_wc(qspi)) {
 			dev_err(qspi->dev, "read timed out\n");
 			return -ETIMEDOUT;
 		}
+
 		switch (wlen) {
 		case 1:
-			*rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
+			/*
+			 * Optimize the 8-bit words transfers, as used by
+			 * the SPI flash devices.
+			 */
+			if (count >= QSPI_WLEN_MAX_BYTES) {
+				u32 *rxp = (u32 *) rxbuf;
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG_3);
+				*rxp++ = be32_to_cpu(rx);
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG_2);
+				*rxp++ = be32_to_cpu(rx);
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG_1);
+				*rxp++ = be32_to_cpu(rx);
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG);
+				*rxp++ = be32_to_cpu(rx);
+			} else {
+				u8 *rxp = rxbuf;
+				rx = readl(qspi->base + QSPI_SPI_DATA_REG);
+				if (rx_wlen >= 8)
+					*rxp++ = rx >> (rx_wlen - 8);
+				if (rx_wlen >= 16)
+					*rxp++ = rx >> (rx_wlen - 16);
+				if (rx_wlen >= 24)
+					*rxp++ = rx >> (rx_wlen - 24);
+				if (rx_wlen >= 32)
+					*rxp++ = rx;
+			}
 			break;
 		case 2:
 			*((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
@@ -351,8 +399,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 			*((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
 			break;
 		}
-		rxbuf += wlen;
-		count -= wlen;
+		rxbuf += rxlen;
+		count -= rxlen;
 	}
 
 	return 0;
-- 
2.23.0

