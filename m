Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E69D13A987
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 13:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgANMlo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 07:41:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35425 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgANMlo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 07:41:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so13567338wmb.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jan 2020 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuFcvURIwl3QEskF2/O6O3xS34vena8ygMjl8ypgEHw=;
        b=P/9NID945fj+tW2UHMVnT3ozdvK2MzX6RDZJWoGW/ef3oxygVKB0rhf9IH2tpkG/tD
         J1NpL8DdhBEGPGhVlh6XBrtOx12B0aIGuikoUKUgvePAvztiK0AB9+cgQIDycBdlYgrW
         Np/eTUdbmsO6q3ju5kjPxFgN5YhhjDDIZeoFbbl4TJQ/eQtPyy9YAw9TLqSLG9VnjZwA
         gxUG9b3kg/kSug+Q1nq/quSe58QI/+XBycrL/Jkptpx3huukjy/IaPn8iCDFvftz/20U
         cZuQwzapdRI3mzzR7PZ1M9OKlovGodHmoo9jznr6vt5G0URAXoWzOjsvDXf1snqHlGBK
         5zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuFcvURIwl3QEskF2/O6O3xS34vena8ygMjl8ypgEHw=;
        b=tfFqVDXIdHcR4ESwLe1HFpslaxoed1/t0lNvQRmBe3ciHQ4lc/0KRFYImIaXmivjiA
         TRwMtyG7eVo6OIE1hWv8LBa0xkOZeBfIwYM/JjddBScCVDJ7vuz0mNDSUvC1eEUalfv8
         AqCgB76DmjfXcJw/j2tXqG2R637F6HRW5EpaqLDsU1IMg98FdCdTlaZrPRHHbmPH+DCl
         2RnBZ2OTwIyyjehePGKJnh66LV2WtWYe7p9X75ePc9IFbFGrsUEiUM/c/UryWqHxgoK5
         sk+nEG0ITqMY6tvA8SGgUMHMdWMWzKXxpmMUdL1JtMIffbjkB7RVmxdRmkKGbohFYp4x
         qyNw==
X-Gm-Message-State: APjAAAUjeeef+6X07yrjmnX55ZnhhtQrTKVLWto5V6NYxzXi1VaR/2lZ
        6PWp18iYf9nLuFy3ULw2QQYfug==
X-Google-Smtp-Source: APXvYqyz9OBeckCVBa1MPx1CpVOp9iXJMMupsGydT1vzHC77j7stWudOPiXkh82lnDgkCPBhBesxew==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr27616650wmc.173.1579005702690;
        Tue, 14 Jan 2020 04:41:42 -0800 (PST)
Received: from msilabo.lan (241.33-200-80.adsl-dyn.isp.belgacom.be. [80.200.33.241])
        by smtp.gmail.com with ESMTPSA id i5sm18260185wml.31.2020.01.14.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 04:41:42 -0800 (PST)
From:   Jean Pihet <jean.pihet@newoldbits.com>
To:     Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] spi: spi-ti-qspi: optimize byte-transfers
Date:   Tue, 14 Jan 2020 13:41:25 +0100
Message-Id: <20200114124125.361429-3-jean.pihet@newoldbits.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114124125.361429-1-jean.pihet@newoldbits.com>
References: <20200114124125.361429-1-jean.pihet@newoldbits.com>
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
index 0334e2926998..858fda8ac73e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -314,6 +314,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
 {
 	int wlen;
 	unsigned int cmd;
+	u32 rx;
+	u8 rxlen, rx_wlen;
 	u8 *rxbuf;
 
 	rxbuf = t->rx_buf;
@@ -336,14 +338,60 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
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
@@ -352,8 +400,8 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
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
2.24.1

