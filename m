Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2317E2E4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 15:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCIO4p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 10:56:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55758 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgCIO4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 10:56:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so10272942wmi.5;
        Mon, 09 Mar 2020 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bvntUJYC49krt3uRaXb0PYT5fEN5WflhqR8Yth6ZXnU=;
        b=aMT0LOEwErJYl3LS/ZTfIRVlU2Uth5WrFrh+k5uuGfFxDo/nFudZygIie0jLTVtoRR
         IrEK7B3MK7kUjq3lmOfP1S6Uw4vztEc9t3zanBALdX7nCNXEMpS/l7c1WWEvvV2NTozY
         dZu5fjCdi8N+ne4tzx+8ZkAj0vKu7oywBo4brJKWRsi8IXbgsjyyk1wmb9IYRer1htNf
         3Tbx82TFZnO4zg8A5IniYsp71diInP5Y5uGy/peH9KG38VzRF5Osm3vFaqBk2BTKvlXg
         fC1+q4EpIVurl4oqyzoTGh6A5Vg+a99dxYRMP6e1rUVzzmoxmqwlWNpkpL+HSiquuXDL
         ln+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bvntUJYC49krt3uRaXb0PYT5fEN5WflhqR8Yth6ZXnU=;
        b=Q+t6EI3BRVmgB/2do30RBFxvEeA9jjyMPR5swsrnhOoWR/FwUXY8K9y7Zm8afL26pW
         o/PfpzG0HYs986mNr0upE8LwRf8pJQPrpgw8NFd+La8UtCZ5ebG7WUhv0i3U+JZrs+OV
         4LOm2WCy7opcGP9U2tEb+if1KzRBA6ShMryek+4jHDtXzxcKzWU5PT+fnir0MTVcSHzC
         B8ClKTazFfkL6qAJ0CZxlsuwYwlODQPWDEN3pF2VVTX3BRyTx39m4GR2KYEeNa9QotQ3
         YwD+DRr6k1W95TDZKn4/0QBWHQIYZwsG2r7m3PPKIw0idE5zWcjhE+ua68DuvuMQROw2
         cIaA==
X-Gm-Message-State: ANhLgQ1NTPIsTWMTSZskn9jMxl+YCs9I6OXuJxvdxWRnIRLGAX6qniv3
        YHwH9wuAtJt2QWg+nuLm7Altmd0q
X-Google-Smtp-Source: ADFU+vsP3a6q3Wmz9x5/uencPfzeEDUZyl6oz7E6kg+VWfpLSL9wvdV1vbBjg+TwwWMZB6V1d13xAg==
X-Received: by 2002:a7b:cc9a:: with SMTP id p26mr1351851wma.0.1583765800574;
        Mon, 09 Mar 2020 07:56:40 -0700 (PDT)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id w22sm26905374wmk.34.2020.03.09.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:39 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Subject: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
Date:   Mon,  9 Mar 2020 16:56:20 +0200
Message-Id: <20200309145624.10026-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
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
don't want to change regmap just for this. Therefore, we define the
offsets per-instantiation, in the devtype_data structure. This means
that we have to know from the driver which controllers are big- and
which are little-endian (which is fine, we do, but it makes the device
tree binding itself a little redundant except for regmap_config).

This patch does not apply cleanly to stable trees, and a punctual fix to
the commit cannot be provided given this constraint of lack of access to
regmap_get_val_endian(). The per-SoC devtype_data structures (and
therefore the premises to fix this bug) have been introduced only a few
commits ago, in commit d35054010b57 ("spi: spi-fsl-dspi: Use specific
compatible strings for all SoC instantiations")

Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0ce26c1cbf62..a8e56abe20ac 100644
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
@@ -124,6 +120,12 @@ struct fsl_dspi_devtype_data {
 	u8			max_clock_factor;
 	int			fifo_size;
 	int			dma_bufsize;
+	/*
+	 * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
+	 * individually (in XSPI mode)
+	 */
+	int			pushr_cmd;
+	int			pushr_tx;
 };
 
 enum {
@@ -150,42 +152,56 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
+		.pushr_cmd		= 0,
+		.pushr_tx		= 2,
 	},
 	[LS1012A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
+		.pushr_cmd		= 0,
+		.pushr_tx		= 2,
 	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
+		.pushr_cmd		= 0,
+		.pushr_tx		= 2,
 	},
 	[LS1046A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
+		.pushr_cmd		= 0,
+		.pushr_tx		= 2,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
+		.pushr_cmd		= 2,
+		.pushr_tx		= 0,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
+		.pushr_cmd		= 2,
+		.pushr_tx		= 0,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
+		.pushr_cmd		= 2,
+		.pushr_tx		= 0,
 	},
 	[MCF5441X] = {
 		.trans_mode		= DSPI_EOQ_MODE,
@@ -670,12 +686,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 	 */
 	if (dspi->len > dspi->oper_word_size)
 		cmd |= SPI_PUSHR_CMD_CONT;
-	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
+	regmap_write(dspi->regmap_pushr, dspi->devtype_data->pushr_cmd, cmd);
 }
 
 static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
-	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
+	regmap_write(dspi->regmap_pushr, dspi->devtype_data->pushr_tx, txdata);
 }
 
 static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
-- 
2.17.1

