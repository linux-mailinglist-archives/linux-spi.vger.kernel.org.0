Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13613AE7F
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgANQJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 11:09:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgANQJc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 11:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UHxgWaTM10uTX8zhKb2baT4BudwMAnM3jluWZY2+P4w=; b=Ata4kVtqUCX/
        tnKJmnoY37P0LgDj+UEw210aRTxVk0RT0cfQsXheSi6co9jVOH2cwZdI6dZbsDE8LFewVjjAxcb+A
        s8fGtX3rNOKtHdyNk/yx6yEbgFJIR6OXUfzkkat7iEepTjDXKN7cmoodKW+yCZHqCNDWSsCuUaxzp
        oz6Gc=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkv-0001ZJ-IJ; Tue, 14 Jan 2020 16:09:25 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3D902D02C7C; Tue, 14 Jan 2020 16:09:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Arnout Vandecappelle <arnout.vandecappelle@essensium.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Applied "spi: spi-ti-qspi: optimize byte-transfers" to the spi tree
In-Reply-To: <20200114124125.361429-3-jean.pihet@newoldbits.com>
Message-Id: <applied-20200114124125.361429-3-jean.pihet@newoldbits.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:25 +0000 (GMT)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-ti-qspi: optimize byte-transfers

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e7cc5cfbea4c9bd2c452cb81d0829e9259dd84d8 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Tue, 14 Jan 2020 13:41:25 +0100
Subject: [PATCH] spi: spi-ti-qspi: optimize byte-transfers

Optimize the 8-bit based transfers, as used by the SPI flash
devices, by reading the data registers by 32 and 128 bits when
possible and copy the contents to the receive buffer.

The speed improvement is 4.9x using quad read.

Signed-off-by: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Ryan Barnett <ryan.barnett@rockwellcollins.com>
Cc: Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Cc: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Link: https://lore.kernel.org/r/20200114124125.361429-3-jean.pihet@newoldbits.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

