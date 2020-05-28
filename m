Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D681E5D0F
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbgE1KYB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 06:24:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:64683 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387866AbgE1KXs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 28 May 2020 06:23:48 -0400
IronPort-SDR: 2Rz9CjodAj9utOAf71Iw8dcKJiLIwAM2P1fX+p2EbVwIBE8jaYRXAwQqXnx8valo5gkcdSZNuk
 FudHaO1/9ybw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 03:23:13 -0700
IronPort-SDR: QkNTFzY5hikhnypA+ppEgvJynmXWTvZIAGhS4M7qGMtGj1KgSeNK8lk1gDNqb2+sRXbRkBhDQS
 NQtmTF+iHg7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="256117612"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 03:23:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B629125; Thu, 28 May 2020 13:23:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: dw: Make DMA request line assignments explicit for Intel Medfield
Date:   Thu, 28 May 2020 13:23:10 +0300
Message-Id: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-dw-mid.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index b1710132b7b2..0fd7543dc91a 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -33,10 +33,8 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 
 static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
-	struct dw_dma_slave slave = {
-		.src_id = 0,
-		.dst_id = 0
-	};
+	struct dw_dma_slave tx = { .dst_id = 1 };
+	struct dw_dma_slave rx = { .src_id = 0 };
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
 
@@ -52,14 +50,14 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* 1. Init rx channel */
-	slave.dma_dev = &dma_dev->dev;
-	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);
+	rx->dma_dev = &dma_dev->dev;
+	dws->rxchan = dma_request_channel(mask, mid_spi_dma_chan_filter, rx);
 	if (!dws->rxchan)
 		goto err_exit;
 
 	/* 2. Init tx channel */
-	slave.dst_id = 1;
-	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, &slave);
+	tx->dma_dev = &dma_dev->dev;
+	dws->txchan = dma_request_channel(mask, mid_spi_dma_chan_filter, tx);
 	if (!dws->txchan)
 		goto free_rxchan;
 
-- 
2.26.2

