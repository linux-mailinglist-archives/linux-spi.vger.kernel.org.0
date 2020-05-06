Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5441C74DD
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgEFPab (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 11:30:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:43731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgEFPab (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 11:30:31 -0400
IronPort-SDR: Z12sUx3Ub3QGM285ugPJw3AvTvRxPT5C/ERQd2y5YIHZgT64/KyjyIOYMGjFh2Jy89+6TGX90A
 7Gpt/tV/OA3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:30:30 -0700
IronPort-SDR: dbDjZ5tdBvMH84rh2DcT7ue04oB2zKwuBv75B40t0VNq/KS+Jw2F+ueUGn/RuMawiXvRS5DBJy
 ym+0vs0K73qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="296217417"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2020 08:30:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8CC67869; Wed,  6 May 2020 18:30:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/8] spi: dw: Add Elkhart Lake PSE DMA support
Date:   Wed,  6 May 2020 18:30:25 +0300
Message-Id: <20200506153025.21441-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
References: <20200506153025.21441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Elkhart Lake PSE SPI is capable to utilize PSE DMA engine which is described
in ACPI. With help of acpi-dma module the support becomes a generic one.

Thus, add Elkhart Lake PSE DMA support and generic DMA hooks in SPI DesignWare
driver.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mid.c | 44 ++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw-pci.c |  1 +
 drivers/spi/spi-dw.h     |  1 +
 3 files changed, 46 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index d73aa4ae644d5..f3c85f92ef12c 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -75,6 +75,24 @@ static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	return -EBUSY;
 }
 
+static int mid_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
+{
+	dws->rxchan = dma_request_slave_channel(dev, "rx");
+	if (!dws->rxchan)
+		return -ENODEV;
+	dws->master->dma_rx = dws->rxchan;
+
+	dws->txchan = dma_request_slave_channel(dev, "tx");
+	if (!dws->txchan) {
+		dma_release_channel(dws->rxchan);
+		return -ENODEV;
+	}
+	dws->master->dma_tx = dws->txchan;
+
+	dws->dma_inited = 1;
+	return 0;
+}
+
 static void mid_spi_dma_exit(struct dw_spi *dws)
 {
 	if (!dws->dma_inited)
@@ -291,8 +309,25 @@ static void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws)
 	dws->dma_rx = &mid_dma_rx;
 	dws->dma_ops = &mfld_dma_ops;
 }
+
+static const struct dw_spi_dma_ops generic_dma_ops = {
+	.dma_init	= mid_spi_dma_init_generic,
+	.dma_exit	= mid_spi_dma_exit,
+	.dma_setup	= mid_spi_dma_setup,
+	.can_dma	= mid_spi_can_dma,
+	.dma_transfer	= mid_spi_dma_transfer,
+	.dma_stop	= mid_spi_dma_stop,
+};
+
+static void dw_spi_mid_setup_dma_generic(struct dw_spi *dws)
+{
+	dws->dma_tx = &mid_dma_tx;
+	dws->dma_rx = &mid_dma_rx;
+	dws->dma_ops = &generic_dma_ops;
+}
 #else	/* CONFIG_SPI_DW_MID_DMA */
 static inline void dw_spi_mid_setup_dma_mfld(struct dw_spi *dws) {}
+static inline void dw_spi_mid_setup_dma_generic(struct dw_spi *dws) {}
 #endif
 
 /* Some specific info for SPI0 controller on Intel MID */
@@ -329,3 +364,12 @@ int dw_spi_mid_init_mfld(struct dw_spi *dws)
 	dw_spi_mid_setup_dma_mfld(dws);
 	return 0;
 }
+
+int dw_spi_mid_init_generic(struct dw_spi *dws)
+{
+	/* Register hook to configure CTRLR0 */
+	dws->update_cr0 = dw_spi_update_cr0;
+
+	dw_spi_mid_setup_dma_generic(dws);
+	return 0;
+}
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index dd59df5122ee7..dde54a918b5d2 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -35,6 +35,7 @@ static struct spi_pci_desc spi_pci_mid_desc_2 = {
 };
 
 static struct spi_pci_desc spi_pci_ehl_desc = {
+	.setup = dw_spi_mid_init_generic,
 	.num_cs = 2,
 	.bus_num = -1,
 	.max_freq = 100000000,
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 642f0be642e56..490cff260a3eb 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -261,5 +261,6 @@ extern u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 
 /* platform related setup */
 extern int dw_spi_mid_init_mfld(struct dw_spi *dws);
+extern int dw_spi_mid_init_generic(struct dw_spi *dws);
 
 #endif /* DW_SPI_HEADER_H */
-- 
2.26.2

