Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22824595E7
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 21:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhKVUJi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 15:09:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:37358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233933AbhKVUJe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Nov 2021 15:09:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="214896364"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="214896364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 12:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="456780608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2021 12:06:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 16046B8; Mon, 22 Nov 2021 22:06:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v1 1/1] spi: pxa2xx: Remove redundant ->read() and ->write() in struct chip_data
Date:   Mon, 22 Nov 2021 22:06:22 +0200
Message-Id: <20211122200622.43305-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since the commit 196b0e2cf237 ("spi: pxa2xx: Remove if statement
that is always true in pump_transfers()") the ->read() and ->write()
methods in the struct driver_data are reconfigured for each transfer.
Hence no need to keep the intermediate state in the struct chip_data.

The same applies to n_bytes member of the same data structure.
Get rid of unneeded storage for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 35 ++++++-----------------------------
 drivers/spi/spi-pxa2xx.h |  4 ----
 2 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1573f6d8eb48..ee3297dd532e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -994,13 +994,10 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 		dev_err(&spi->dev, "Flush failed\n");
 		return -EIO;
 	}
-	drv_data->n_bytes = chip->n_bytes;
 	drv_data->tx = (void *)transfer->tx_buf;
 	drv_data->tx_end = drv_data->tx + transfer->len;
 	drv_data->rx = transfer->rx_buf;
 	drv_data->rx_end = drv_data->rx + transfer->len;
-	drv_data->write = drv_data->tx ? chip->write : null_writer;
-	drv_data->read = drv_data->rx ? chip->read : null_reader;
 
 	/* Change speed and bit per word on a per transfer */
 	bits = transfer->bits_per_word;
@@ -1010,22 +1007,16 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 
 	if (bits <= 8) {
 		drv_data->n_bytes = 1;
-		drv_data->read = drv_data->read != null_reader ?
-					u8_reader : null_reader;
-		drv_data->write = drv_data->write != null_writer ?
-					u8_writer : null_writer;
+		drv_data->read = drv_data->rx ? u8_reader : null_reader;
+		drv_data->write = drv_data->tx ? u8_writer : null_writer;
 	} else if (bits <= 16) {
 		drv_data->n_bytes = 2;
-		drv_data->read = drv_data->read != null_reader ?
-					u16_reader : null_reader;
-		drv_data->write = drv_data->write != null_writer ?
-					u16_writer : null_writer;
+		drv_data->read = drv_data->rx ? u16_reader : null_reader;
+		drv_data->write = drv_data->tx ? u16_writer : null_writer;
 	} else if (bits <= 32) {
 		drv_data->n_bytes = 4;
-		drv_data->read = drv_data->read != null_reader ?
-					u32_reader : null_reader;
-		drv_data->write = drv_data->write != null_writer ?
-					u32_writer : null_writer;
+		drv_data->read = drv_data->rx ? u32_reader : null_reader;
+		drv_data->write = drv_data->tx ? u32_writer : null_writer;
 	}
 	/*
 	 * If bits per word is changed in DMA mode, then must check
@@ -1391,20 +1382,6 @@ static int setup(struct spi_device *spi)
 	if (spi->mode & SPI_LOOP)
 		chip->cr1 |= SSCR1_LBM;
 
-	if (spi->bits_per_word <= 8) {
-		chip->n_bytes = 1;
-		chip->read = u8_reader;
-		chip->write = u8_writer;
-	} else if (spi->bits_per_word <= 16) {
-		chip->n_bytes = 2;
-		chip->read = u16_reader;
-		chip->write = u16_writer;
-	} else if (spi->bits_per_word <= 32) {
-		chip->n_bytes = 4;
-		chip->read = u32_reader;
-		chip->write = u32_writer;
-	}
-
 	spi_set_ctldata(spi, chip);
 
 	if (drv_data->ssp_type == CE4100_SSP)
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 9a20fb88e50f..4d77f4de6eda 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -61,7 +61,6 @@ struct chip_data {
 	u32 cr1;
 	u32 dds_rate;
 	u32 timeout;
-	u8 n_bytes;
 	u8 enable_dma;
 	u32 dma_burst_size;
 	u32 dma_threshold;
@@ -69,9 +68,6 @@ struct chip_data {
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
 
-	int (*write)(struct driver_data *drv_data);
-	int (*read)(struct driver_data *drv_data);
-
 	void (*cs_control)(u32 command);
 };
 
-- 
2.33.0

