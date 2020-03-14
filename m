Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76BC18592E
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 03:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCOCh2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Mar 2020 22:37:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgCOCh2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 14 Mar 2020 22:37:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so13939538wmi.5;
        Sat, 14 Mar 2020 19:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i/xUxgWq4UpEozlJruyu4esrihguskjSmgNCvfi8Eoc=;
        b=QWfaVXb1+kuKsZhnsCpwPE+phZrISNT+jXNPVDpAyyq8O9irHGRHF2hFvQyCKn92Lb
         BFlxXBYiTKWJ/YwwpYQNnQOQoEUzMnSbrn8mTxn573CCQm+ZhCOqdpfIZ01jIv5DUDgO
         Fl84o5/mRYZaQ4Zw0kKwfSppg1iJAjHxKINrEsmF8QXTh0ialVuSFT8rthQ5+Z0wwSZT
         j/jGZVqCDvKNmPJMtAQiEwz9u2gOL226I6p8POMpe7u6qyFQIIrUaQSZU5CgAJf32HDU
         KUMc90S9rc4hKEvwehNFWRQzIPoCkF6gBY1Ap9n5p8puY5JnV2+R6TbiZzM1le8LsV7c
         Y0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i/xUxgWq4UpEozlJruyu4esrihguskjSmgNCvfi8Eoc=;
        b=cS5cu7N9XsMQHpmmd6fgzdv+B7U+xtYrKHqLAHG9yaxl+ZcL/mtbOW+iTOJN975N/b
         VNPbjES/a+RdbS6iJQF4lVtX6MdWnK47xQY7zuvKELDv07UszPQPiC5l0bJmEl8FWjLm
         P2fDqcI5iGlAxF5tKEvx4IOH8Hf195in3h3QYmS2Nz2PUTE0ll1fQrWfiqPorOrC6IAC
         J+Wlkj2P/7ZCwOzYf/DVKPC95w541Tr6YpkX6WZz/QCE+CfOf10RDZB8Kym6fdiMccgh
         olgKWXemexc8P8KiimWpPeEu698NQBN5jW1v3tqy1sJTbRSJPdty/LmIijWlzaNG4qwU
         Aqww==
X-Gm-Message-State: ANhLgQ34FvTHNyQaFQgLLITtiB5HcHp9Dcd24zDpHoTe5Nojmt6uW6Fa
        ifd8rb15DsNqgId9hqHjAyfInuoYNGM=
X-Google-Smtp-Source: ADFU+vsJkFBk34Vz16tqJu/p5u21gr+Xhryd4WBfvUktE4uhuqZErap/kQ5LuEpE3hHEfrhiDxk6lg==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr18801079wmf.67.1584225839168;
        Sat, 14 Mar 2020 15:43:59 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id 133sm23690732wmd.5.2020.03.14.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 15:43:58 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH v3 02/12] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
Date:   Sun, 15 Mar 2020 00:43:30 +0200
Message-Id: <20200314224340.1544-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314224340.1544-1-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In XSPI mode, the 32-bit PUSHR register can be written to separately:
the higher 16 bits are for commands and the lower 16 bits are for data.

This has nicely been hacked around, by defining a second regmap with a
width of 16 bits, and effectively splitting a 32-bit register into 2
16-bit ones, from the perspective of this regmap_pushr.

The problem is the assumption about the controller's endianness. If the
controller is little endian (such as anything post-LS1046A), then the
first 2 bytes, in the order imposed by memory layout, will actually hold
the TXDATA, and the last 2 bytes will hold the CMD.

So take the controller's endianness into account when performing split
writes to PUSHR. The obvious and simple solution would have been to call
regmap_get_val_endian(), but that is an internal regmap function and we
don't want to change regmap just for this. Therefore, we just re-read
the "big-endian" device tree property.

Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v4:
None.

Changes in v3:
None.

Changes in v2:
Parse "big-endian" device tree bindings instead of taking the decision
based on compatible SoC.

 drivers/spi/spi-fsl-dspi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ca35881881b..be717776dd98 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -103,10 +103,6 @@
 #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
 #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
 
-/* Register offsets for regmap_pushr */
-#define PUSHR_CMD			0x0
-#define PUSHR_TX			0x2
-
 #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
 struct chip_data {
@@ -240,6 +236,13 @@ struct fsl_dspi {
 
 	int					words_in_flight;
 
+	/*
+	 * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
+	 * individually (in XSPI mode)
+	 */
+	int					pushr_cmd;
+	int					pushr_tx;
+
 	void (*host_to_dev)(struct fsl_dspi *dspi, u32 *txdata);
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
@@ -673,12 +676,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 	 */
 	if (dspi->len > dspi->oper_word_size)
 		cmd |= SPI_PUSHR_CMD_CONT;
-	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
+	regmap_write(dspi->regmap_pushr, dspi->pushr_cmd, cmd);
 }
 
 static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
-	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
+	regmap_write(dspi->regmap_pushr, dspi->pushr_tx, txdata);
 }
 
 static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
@@ -1259,6 +1262,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
+	bool big_endian;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
@@ -1284,6 +1288,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 		/* Only Coldfire uses platform data */
 		dspi->devtype_data = &devtype_data[MCF5441X];
+		big_endian = true;
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
@@ -1305,6 +1310,15 @@ static int dspi_probe(struct platform_device *pdev)
 			ret = -EFAULT;
 			goto out_ctlr_put;
 		}
+
+		big_endian = of_device_is_big_endian(np);
+	}
+	if (big_endian) {
+		dspi->pushr_cmd = 0;
+		dspi->pushr_tx = 2;
+	} else {
+		dspi->pushr_cmd = 2;
+		dspi->pushr_tx = 0;
 	}
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-- 
2.17.1

