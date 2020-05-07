Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6251C88FE
	for <lists+linux-spi@lfdr.de>; Thu,  7 May 2020 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGLy4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 May 2020 07:54:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:54063 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgEGLyz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 May 2020 07:54:55 -0400
IronPort-SDR: tXkUqN8MdGeyEs6CJOgVANYPNBRnaldUhP/arztHsIUXx0cSSCk3ESkGWMEllgw9Dx2TVajv/c
 1PJRzsnBuLhw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 04:54:55 -0700
IronPort-SDR: G+1tGLeyeX+c3i+QNwtZonqiVB3Ns1TYNjsN4ChnKQvoNA6XMIctZjT5oEuT0X59wQiilq02Yg
 JSm3DPm9z6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="435265515"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 May 2020 04:54:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C6BE1101; Thu,  7 May 2020 14:54:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: dw: Get rid of dma_inited flag
Date:   Thu,  7 May 2020 14:54:49 +0300
Message-Id: <20200507115449.8093-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507115449.8093-1-andriy.shevchenko@linux.intel.com>
References: <20200507115449.8093-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This flag is superfluous in all cases where it's being used, i.e.
 * ->can_dma() won't be called without dma_inited == 1
 * DMA ->exit() callback can rely on txchan and rxchan variables

So, get rid of dma_inited flag.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 28 ++++++++++++++--------------
 drivers/spi/spi-dw.c     |  2 --
 drivers/spi/spi-dw.h     |  1 -
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 8b7b94c5a9ccf..177e1f5ec62b2 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -57,20 +57,21 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, rx);
 	if (!dws->rxchan)
 		goto err_exit;
-	dws->master->dma_rx = dws->rxchan;
 
 	/* 2. Init tx channel */
 	tx->dma_dev = &dma_dev->dev;
 	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, tx);
 	if (!dws->txchan)
 		goto free_rxchan;
+
+	dws->master->dma_rx = dws->rxchan;
 	dws->master->dma_tx = dws->txchan;
 
-	dws->dma_inited = 1;
 	return 0;
 
 free_rxchan:
 	dma_release_channel(dws->rxchan);
+	dws->rxchan = NULL;
 err_exit:
 	return -EBUSY;
 }
@@ -80,29 +81,31 @@ static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 	dws->rxchan = dma_request_slave_channel(dev, "rx");
 	if (!dws->rxchan)
 		return -ENODEV;
-	dws->master->dma_rx = dws->rxchan;
 
 	dws->txchan = dma_request_slave_channel(dev, "tx");
 	if (!dws->txchan) {
 		dma_release_channel(dws->rxchan);
+		dws->rxchan = NULL;
 		return -ENODEV;
 	}
+
+	dws->master->dma_rx = dws->rxchan;
 	dws->master->dma_tx = dws->txchan;
 
-	dws->dma_inited = 1;
 	return 0;
 }
 
 static void mid_spi_dma_exit(struct dw_spi *dws)
 {
-	if (!dws->dma_inited)
-		return;
-
-	dmaengine_terminate_sync(dws->txchan);
-	dma_release_channel(dws->txchan);
+	if (dws->txchan) {
+		dmaengine_terminate_sync(dws->txchan);
+		dma_release_channel(dws->txchan);
+	}
 
-	dmaengine_terminate_sync(dws->rxchan);
-	dma_release_channel(dws->rxchan);
+	if (dws->rxchan) {
+		dmaengine_terminate_sync(dws->rxchan);
+		dma_release_channel(dws->rxchan);
+	}
 }
 
 static irqreturn_t dma_transfer(struct dw_spi *dws)
@@ -126,9 +129,6 @@ static bool mid_spi_can_dma(struct spi_controller *master,
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
 
-	if (!dws->dma_inited)
-		return false;
-
 	return xfer->len > dws->fifo_len;
 }
 
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b9f651e9ca028..6de196df9c966 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -470,7 +470,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	dws->master = master;
 	dws->type = SSI_MOTO_SPI;
-	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 	spin_lock_init(&dws->buf_lock);
 
@@ -509,7 +508,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		ret = dws->dma_ops->dma_init(dev, dws);
 		if (ret) {
 			dev_warn(dev, "DMA init failed\n");
-			dws->dma_inited = 0;
 		} else {
 			master->can_dma = dws->dma_ops->can_dma;
 		}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 490cff260a3eb..e92d43b9a9e60 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -141,7 +141,6 @@ struct dw_spi {
 	u32			current_freq;	/* frequency in hz */
 
 	/* DMA info */
-	int			dma_inited;
 	struct dma_chan		*txchan;
 	struct dma_chan		*rxchan;
 	unsigned long		dma_chan_busy;
-- 
2.26.2

