Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C461C74E0
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgEFPad (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:57483 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbgEFPac (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:32 -0400
IronPort-SDR: /4/xD4HZXS98WW8yixebGw4ek0q7CQzhfDfJkGGpRZUknMIXtliUCpffZUPcXA+tO27A/27vl0
 2r8O1nYuSkUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:30 -0700
IronPort-SDR: MD93rtE4rKmLv72QZ+MGBkY7e0jrccyIio4PCQ1MTRFy3ELv/a+4fdEqJettdbINuIyzjm9Scz
 fCLInfNP1CfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="339041776"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2020 08:30:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7CDEB348; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/8] spi: dw: Propagate struct device pointer to ->dma_init() callback
Date:   Wed,  6 May 2020 18:30:24 +0300
Message-Id: <20200506153025.21441-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In some cases, one of which is coming soon, we would like to have
a struct device pointer to request DMA channel. For this purpose
propagate it to ->dma_init() callback in DMA ops.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 2 +-
 drivers/spi/spi-dw.c     | 2 +-
 drivers/spi/spi-dw.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 13b548915c8f0..d73aa4ae644d5 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -34,7 +34,7 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static int mid_spi_dma_init_mfld(struct dw_spi *dws)
+static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
 	struct pci_dev *dma_dev;
 	struct dw_dma_slave *tx = dws->dma_tx;
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 6e56a64ccc557..b9f651e9ca028 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -506,7 +506,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_hw_init(dev, dws);
 
 	if (dws->dma_ops && dws->dma_ops->dma_init) {
-		ret = dws->dma_ops->dma_init(dws);
+		ret = dws->dma_ops->dma_init(dev, dws);
 		if (ret) {
 			dev_warn(dev, "DMA init failed\n");
 			dws->dma_inited = 0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b7e3f0ebba44f..642f0be642e56 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -100,7 +100,7 @@ enum dw_ssi_type {
 
 struct dw_spi;
 struct dw_spi_dma_ops {
-	int (*dma_init)(struct dw_spi *dws);
+	int (*dma_init)(struct device *dev, struct dw_spi *dws);
 	void (*dma_exit)(struct dw_spi *dws);
 	int (*dma_setup)(struct dw_spi *dws, struct spi_transfer *xfer);
 	bool (*can_dma)(struct spi_controller *master, struct spi_device *spi,
-- 
2.26.2

