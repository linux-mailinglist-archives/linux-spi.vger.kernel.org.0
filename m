Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F20B1E86AD
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE2Sby (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 14:31:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:1611 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgE2Sbx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 14:31:53 -0400
IronPort-SDR: cAzfUtib4PqkH7LvajJc7KwXvXBCQ4IiR3UenCne/kpbZo7181mwuHCwTxuV5EX6cbX0/ALPq5
 oEN5ejMiaFlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:31:53 -0700
IronPort-SDR: gOwEVkjzx6SSzWAz1bweYUGzJy2gNyLTZeTUMP7SI39p0bnLbG9lwjRsM9ppHkf9enYzKjKQv7
 8uIqjNJ7++Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="256584032"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2020 11:31:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2E41C125; Fri, 29 May 2020 21:31:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] spi: dw: Make DMA request line assignments explicit for Intel Medfield
Date:   Fri, 29 May 2020 21:31:49 +0300
Message-Id: <20200529183150.44149-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
did a clean up of global variables, which is fine, but messed up with
the carefully provided information in the custom DMA slave structures.
There reader can find an assignment of the DMA request lines in use.

Partially revert the above mentioned commit to restore readability
and maintainability of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased against latest spi/for-next
 drivers/spi/spi-dw-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 1b96cec6d8cd..53d5257662e8 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -61,10 +61,8 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
-	struct dw_dma_slave slave = {
-		.src_id = 0,
-		.dst_id = 0
-	};
+	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
+	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
 
@@ -80,14 +78,14 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* 1. Init rx channel */
-	slave.dma_dev = &dma_dev->dev;
-	dws->rxchan = dma_request_channel(mask, dw_spi_dma_chan_filter, &slave);
+	rx->dma_dev = &dma_dev->dev;
+	dws->rxchan = dma_request_channel(mask, dw_spi_dma_chan_filter, rx);
 	if (!dws->rxchan)
 		goto err_exit;
 
 	/* 2. Init tx channel */
-	slave.dst_id = 1;
-	dws->txchan = dma_request_channel(mask, dw_spi_dma_chan_filter, &slave);
+	tx->dma_dev = &dma_dev->dev;
+	dws->txchan = dma_request_channel(mask, dw_spi_dma_chan_filter, tx);
 	if (!dws->txchan)
 		goto free_rxchan;
 
-- 
2.26.2

