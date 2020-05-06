Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9B1C74DE
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgEFPac (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:9527 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbgEFPab (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:31 -0400
IronPort-SDR: 1oDv/lzNBdqCrzKhbppXbO34hYdPupXvKGR8O7uiQ8Ua249V80YDb1tOq/cBuALuLwj8n6GBd0
 CdtiMWuJ9rOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:30 -0700
IronPort-SDR: rnJA6flkWUD0UeEYr/RyFqWF3hkjWGMkBLwXQYF1DC6JsP/dRwuxxKbxj0FhTRj1HZowjg5d8+
 fhqUshUEvK/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="278263127"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2020 08:30:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77A833BA; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/8] spi: dw: Add 'mfld' suffix to Intel Medfield related routines
Date:   Wed,  6 May 2020 18:30:23 +0300
Message-Id: <20200506153025.21441-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In order to prepare driver for the extension to support newer hardware,
add 'mfld' suffix to some related functions.

While here, move DMA parameters assignment under existing #ifdef
CONFIG_SPI_DW_MID_DMA.

There is no functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 24 ++++++++++++++----------
 drivers/spi/spi-dw-pci.c |  4 ++--
 drivers/spi/spi-dw.h     |  3 ++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 64523e68490d7..13b548915c8f0 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -34,7 +34,7 @@ static bool mid_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static int mid_spi_dma_init(struct dw_spi *dws)
+static int mid_spi_dma_init_mfld(struct dw_spi *dws)
 {
 	struct pci_dev *dma_dev;
 	struct dw_dma_slave *tx = dws->dma_tx;
@@ -276,14 +276,23 @@ static void mid_spi_dma_stop(struct dw_spi *dws)
 	}
 }
 
-static const struct dw_spi_dma_ops mid_dma_ops = {
-	.dma_init	= mid_spi_dma_init,
+static const struct dw_spi_dma_ops mfld_dma_ops = {
+	.dma_init	= mid_spi_dma_init_mfld,
 	.dma_exit	= mid_spi_dma_exit,
 	.dma_setup	= mid_spi_dma_setup,
 	.can_dma	= mid_spi_can_dma,
 	.dma_transfer	= mid_spi_dma_transfer,
 	.dma_stop	= mid_spi_dma_stop,
 };
+
+static void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws)
+{
+	dws->dma_tx = &mid_dma_tx;
+	dws->dma_rx = &mid_dma_rx;
+	dws->dma_ops = &mfld_dma_ops;
+}
+#else	/* CONFIG_SPI_DW_MID_DMA */
+static inline void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws) {}
 #endif
 
 /* Some specific info for SPI0 controller on Intel MID */
@@ -297,7 +306,7 @@ static const struct dw_spi_dma_ops mid_dma_ops = {
 #define CLK_SPI_CDIV_MASK	0x00000e00
 #define CLK_SPI_DISABLE_OFFSET	8
 
-int dw_spi_mid_init(struct dw_spi *dws)
+int dw_spi_mid_init_mfld(struct dw_spi *dws)
 {
 	void __iomem *clk_reg;
 	u32 clk_cdiv;
@@ -314,14 +323,9 @@ int dw_spi_mid_init(struct dw_spi *dws)
 
 	iounmap(clk_reg);
 
-#ifdef CONFIG_SPI_DW_MID_DMA
-	dws->dma_tx = &mid_dma_tx;
-	dws->dma_rx = &mid_dma_rx;
-	dws->dma_ops = &mid_dma_ops;
-#endif
-
 	/* Register hook to configure CTRLR0 */
 	dws->update_cr0 = dw_spi_update_cr0;
 
+	dw_spi_mid_setup_dma_mfld(dws);
 	return 0;
 }
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 172a9f2996316..dd59df5122ee7 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -23,13 +23,13 @@ struct spi_pci_desc {
 };
 
 static struct spi_pci_desc spi_pci_mid_desc_1 = {
-	.setup = dw_spi_mid_init,
+	.setup = dw_spi_mid_init_mfld,
 	.num_cs = 5,
 	.bus_num = 0,
 };
 
 static struct spi_pci_desc spi_pci_mid_desc_2 = {
-	.setup = dw_spi_mid_init,
+	.setup = dw_spi_mid_init_mfld,
 	.num_cs = 2,
 	.bus_num = 1,
 };
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 5e1e78210d8d4..b7e3f0ebba44f 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -260,5 +260,6 @@ extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 				    struct spi_transfer *transfer);
 
 /* platform related setup */
-extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
+extern int dw_spi_mid_init_mfld(struct dw_spi *dws);
+
 #endif /* DW_SPI_HEADER_H */
-- 
2.26.2

