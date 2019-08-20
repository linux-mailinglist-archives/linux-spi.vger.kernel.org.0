Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2474795FA1
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfHTNOb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:31 -0400
Received: from mail-wm1-f98.google.com ([209.85.128.98]:33078 "EHLO
        mail-wm1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-wm1-f98.google.com with SMTP id p77so2392410wme.0
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=knOH35nIeGCDLJtaM+9WDyxWbBA4WGHvUCPF2svlFWA=;
        b=Ve0NYrQSOWgqKbZY7yN2hI10Lnny3WepvldduHGOi1M/xvHCaYaay+kp8jhiRNwKri
         I2e/nHbL2wV7WH4WS/BvEtCc2KBKSZAz/0sxrOoju84139cvhX1apkVMFagcHX0KMiRi
         4n6Pl0c5Z6AnVwO7hsx6Cp6X66x24bIqk+e/0JQtMG2VcA/L/YcFGNZQp1RuWhQTzS5d
         I/8u/fluIf4aDVrTlX5T59os5aXYZ5DTCSLako69dSGbmWiasukba8HPo4+f+VaH+vol
         aSwJb4fdQ1cju6NUvfqGxS+Yx+RcMKvqNWdJkbOvUkl4Fdw6tD+J4kkmcdV+X66ir4fB
         oPmA==
X-Gm-Message-State: APjAAAWz5rKbN+b0RXbRKFtW1ruP2Wc69J76D3+0Y/0l/Ee4SsWn9Vzc
        wBF3Sd1TsrK1v3vbe1njEzAE+TF8XNUhoGC9tvojlhTjKIuqpJyZ9EKCzlOCR1VI2Q==
X-Google-Smtp-Source: APXvYqyzIWDGlT8hN8qeEXlNv95ioCA3Qki1HYKsfysczwq6jrqF3KTANFc7iOVd6cbdgm3jJaXVTt1PjDK1
X-Received: by 2002:a1c:6c0d:: with SMTP id h13mr23922634wmc.74.1566306868662;
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id s15sm295757wru.34.2019.08.20.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03y0-0002MB-AD; Tue, 20 Aug 2019 13:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C64E7274314C; Tue, 20 Aug 2019 14:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Use BIT() and GENMASK() macros" to the spi tree
In-Reply-To: <20190818180115.31114-4-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131427.C64E7274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:27 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Use BIT() and GENMASK() macros

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

From b2655196cf9ce783d0b6cfec1f47ac4ecf3dcf95 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:04 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Use BIT() and GENMASK() macros

Switch to using more idiomatic register field definitions, which makes
it easier to look them up in the datasheet. Cosmetic patch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-4-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 58 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 358b381839fb..179a9818619f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -28,35 +28,35 @@
 #define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
 
 #define SPI_MCR				0x00
-#define SPI_MCR_MASTER			(1 << 31)
+#define SPI_MCR_MASTER			BIT(31)
 #define SPI_MCR_PCSIS			(0x3F << 16)
-#define SPI_MCR_CLR_TXF			(1 << 11)
-#define SPI_MCR_CLR_RXF			(1 << 10)
-#define SPI_MCR_XSPI			(1 << 3)
+#define SPI_MCR_CLR_TXF			BIT(11)
+#define SPI_MCR_CLR_RXF			BIT(10)
+#define SPI_MCR_XSPI			BIT(3)
 
 #define SPI_TCR				0x08
-#define SPI_TCR_GET_TCNT(x)		(((x) & 0xffff0000) >> 16)
-
-#define SPI_CTAR(x)			(0x0c + (((x) & 0x3) * 4))
-#define SPI_CTAR_FMSZ(x)		(((x) & 0x0000000f) << 27)
-#define SPI_CTAR_CPOL(x)		((x) << 26)
-#define SPI_CTAR_CPHA(x)		((x) << 25)
-#define SPI_CTAR_LSBFE(x)		((x) << 24)
-#define SPI_CTAR_PCSSCK(x)		(((x) & 0x00000003) << 22)
-#define SPI_CTAR_PASC(x)		(((x) & 0x00000003) << 20)
-#define SPI_CTAR_PDT(x)			(((x) & 0x00000003) << 18)
-#define SPI_CTAR_PBR(x)			(((x) & 0x00000003) << 16)
-#define SPI_CTAR_CSSCK(x)		(((x) & 0x0000000f) << 12)
-#define SPI_CTAR_ASC(x)			(((x) & 0x0000000f) << 8)
-#define SPI_CTAR_DT(x)			(((x) & 0x0000000f) << 4)
-#define SPI_CTAR_BR(x)			((x) & 0x0000000f)
+#define SPI_TCR_GET_TCNT(x)		(((x) & GENMASK(31, 16)) >> 16)
+
+#define SPI_CTAR(x)			(0x0c + (((x) & GENMASK(1, 0)) * 4))
+#define SPI_CTAR_FMSZ(x)		(((x) << 27) & GENMASK(30, 27))
+#define SPI_CTAR_CPOL(x)		(((x) << 26) & GENMASK(26, 26))
+#define SPI_CTAR_CPHA(x)		(((x) << 25) & GENMASK(25, 25))
+#define SPI_CTAR_LSBFE(x)		(((x) << 24) & GENMASK(24, 24))
+#define SPI_CTAR_PCSSCK(x)		(((x) << 22) & GENMASK(23, 22))
+#define SPI_CTAR_PASC(x)		(((x) << 20) & GENMASK(21, 20))
+#define SPI_CTAR_PDT(x)			(((x) << 18) & GENMASK(19, 18))
+#define SPI_CTAR_PBR(x)			(((x) << 16) & GENMASK(17, 16))
+#define SPI_CTAR_CSSCK(x)		(((x) << 12) & GENMASK(15, 12))
+#define SPI_CTAR_ASC(x)			(((x) << 8) & GENMASK(11, 8))
+#define SPI_CTAR_DT(x)			(((x) << 4) & GENMASK(7, 4))
+#define SPI_CTAR_BR(x)			((x) & GENMASK(3, 0))
 #define SPI_CTAR_SCALE_BITS		0xf
 
 #define SPI_CTAR0_SLAVE			0x0c
 
 #define SPI_SR				0x2c
-#define SPI_SR_EOQF			0x10000000
-#define SPI_SR_TCFQF			0x80000000
+#define SPI_SR_TCFQF			BIT(31)
+#define SPI_SR_EOQF			BIT(28)
 #define SPI_SR_CLEAR			0x9aaf0000
 
 #define SPI_RSER_TFFFE			BIT(25)
@@ -65,15 +65,15 @@
 #define SPI_RSER_RFDFD			BIT(16)
 
 #define SPI_RSER			0x30
-#define SPI_RSER_EOQFE			0x10000000
-#define SPI_RSER_TCFQE			0x80000000
+#define SPI_RSER_TCFQE			BIT(31)
+#define SPI_RSER_EOQFE			BIT(28)
 
 #define SPI_PUSHR			0x34
-#define SPI_PUSHR_CMD_CONT		(1 << 15)
-#define SPI_PUSHR_CMD_CTAS(x)		(((x) & 0x0003) << 12)
-#define SPI_PUSHR_CMD_EOQ		(1 << 11)
-#define SPI_PUSHR_CMD_CTCNT		(1 << 10)
-#define SPI_PUSHR_CMD_PCS(x)		((1 << x) & 0x003f)
+#define SPI_PUSHR_CMD_CONT		BIT(15)
+#define SPI_PUSHR_CMD_CTAS(x)		(((x) << 12 & GENMASK(14, 12)))
+#define SPI_PUSHR_CMD_EOQ		BIT(11)
+#define SPI_PUSHR_CMD_CTCNT		BIT(10)
+#define SPI_PUSHR_CMD_PCS(x)		(BIT(x) & GENMASK(5, 0))
 
 #define SPI_PUSHR_SLAVE			0x34
 
@@ -88,7 +88,7 @@
 #define SPI_RXFR2			0x84
 #define SPI_RXFR3			0x88
 
-#define SPI_CTARE(x)			(0x11c + (((x) & 0x3) * 4))
+#define SPI_CTARE(x)			(0x11c + (((x) & GENMASK(1, 0)) * 4))
 #define SPI_CTARE_FMSZE(x)		(((x) & 0x1) << 16)
 #define SPI_CTARE_DTCP(x)		((x) & 0x7ff)
 
-- 
2.20.1

