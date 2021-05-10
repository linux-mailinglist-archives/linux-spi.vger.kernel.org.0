Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED2378EE1
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhEJNcL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 09:32:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:17308 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239841AbhEJMme (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 08:42:34 -0400
IronPort-SDR: Q1JrWvgJSioMrSI4XzI9seqdiBTApWCdt1iPBm3MGCwIUcgxfjhnhwR1xybz1sCCzxEejtVIIy
 cDw/DZWn1/oQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="199252919"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="199252919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:41:19 -0700
IronPort-SDR: Y+SBbClKMT+quBN2SFxPF1Vp1KKsr/Q20srIifYjWkL+acijwuabggDm/qxi0zqHXAtiCwq6FQ
 6/liNFTEKlTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="468109084"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2021 05:41:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 61D1C147; Mon, 10 May 2021 15:41:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3 03/14] spi: pxa2xx: Utilize struct device from struct ssp_device
Date:   Mon, 10 May 2021 15:41:23 +0300
Message-Id: <20210510124134.24638-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
References: <20210510124134.24638-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We have a duplication of struct device in the struct driver_data,
get rid of it and reuse member from struct ssp_device instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c | 12 +++++-------
 drivers/spi/spi-pxa2xx-pci.c |  1 +
 drivers/spi/spi-pxa2xx.c     | 12 +++++-------
 drivers/spi/spi-pxa2xx.h     |  4 ----
 4 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 3b27f356a18f..2e4a49567146 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -111,7 +111,7 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
-		dev_warn(&drv_data->pdev->dev, "DMA slave config failed\n");
+		dev_warn(drv_data->ssp->dev, "DMA slave config failed\n");
 		return NULL;
 	}
 
@@ -125,7 +125,7 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 
 	status = pxa2xx_spi_read(drv_data, SSSR) & drv_data->mask_sr;
 	if (status & SSSR_ROR) {
-		dev_err(&drv_data->pdev->dev, "FIFO overrun\n");
+		dev_err(drv_data->ssp->dev, "FIFO overrun\n");
 
 		dmaengine_terminate_async(drv_data->controller->dma_rx);
 		dmaengine_terminate_async(drv_data->controller->dma_tx);
@@ -145,16 +145,14 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
 
 	tx_desc = pxa2xx_spi_dma_prepare_one(drv_data, DMA_MEM_TO_DEV, xfer);
 	if (!tx_desc) {
-		dev_err(&drv_data->pdev->dev,
-			"failed to get DMA TX descriptor\n");
+		dev_err(drv_data->ssp->dev, "failed to get DMA TX descriptor\n");
 		err = -EBUSY;
 		goto err_tx;
 	}
 
 	rx_desc = pxa2xx_spi_dma_prepare_one(drv_data, DMA_DEV_TO_MEM, xfer);
 	if (!rx_desc) {
-		dev_err(&drv_data->pdev->dev,
-			"failed to get DMA RX descriptor\n");
+		dev_err(drv_data->ssp->dev, "failed to get DMA RX descriptor\n");
 		err = -EBUSY;
 		goto err_rx;
 	}
@@ -191,8 +189,8 @@ void pxa2xx_spi_dma_stop(struct driver_data *drv_data)
 int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 {
 	struct pxa2xx_spi_controller *pdata = drv_data->controller_info;
-	struct device *dev = &drv_data->pdev->dev;
 	struct spi_controller *controller = drv_data->controller;
+	struct device *dev = drv_data->ssp->dev;
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 1833f5876e9f..f588fad77fc0 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -239,6 +239,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	spi_pdata.dma_burst_size = c->dma_burst_size ? c->dma_burst_size : 1;
 
 	ssp = &spi_pdata.ssp;
+	ssp->dev = &dev->dev;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
 	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d89db682179d..0f3f7d725937 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -628,7 +628,7 @@ static void int_error_stop(struct driver_data *drv_data, const char *msg)
 	pxa2xx_spi_flush(drv_data);
 	pxa2xx_spi_off(drv_data);
 
-	dev_err(&drv_data->pdev->dev, "%s\n", msg);
+	dev_err(drv_data->ssp->dev, "%s\n", msg);
 
 	drv_data->controller->cur_msg->status = -EIO;
 	spi_finalize_current_transfer(drv_data->controller);
@@ -731,8 +731,7 @@ static void handle_bad_msg(struct driver_data *drv_data)
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 
-	dev_err(&drv_data->pdev->dev,
-		"bad message state in interrupt handler\n");
+	dev_err(drv_data->ssp->dev, "bad message state in interrupt handler\n");
 }
 
 static irqreturn_t ssp_int(int irq, void *dev_id)
@@ -748,7 +747,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 * the IRQ was not for us (we shouldn't be RPM suspended when the
 	 * interrupt is enabled).
 	 */
-	if (pm_runtime_suspended(&drv_data->pdev->dev))
+	if (pm_runtime_suspended(drv_data->ssp->dev))
 		return IRQ_NONE;
 
 	/*
@@ -1158,7 +1157,7 @@ static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 	pxa2xx_spi_flush(drv_data);
 	pxa2xx_spi_off(drv_data);
 
-	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
+	dev_dbg(drv_data->ssp->dev, "transfer aborted\n");
 
 	drv_data->controller->cur_msg->status = -EINTR;
 	spi_finalize_current_transfer(drv_data->controller);
@@ -1645,7 +1644,7 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	if (has_acpi_companion(&drv_data->pdev->dev)) {
+	if (has_acpi_companion(drv_data->ssp->dev)) {
 		switch (drv_data->ssp_type) {
 		/*
 		 * For Atoms the ACPI DeviceSelection used by the Windows
@@ -1711,7 +1710,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data = spi_controller_get_devdata(controller);
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
-	drv_data->pdev = pdev;
 	drv_data->ssp = ssp;
 
 	controller->dev.of_node = pdev->dev.of_node;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index ad9980ebefa6..6724d7e056ce 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
 #include <linux/pxa2xx_ssp.h>
 #include <linux/scatterlist.h>
 #include <linux/sizes.h>
@@ -20,9 +19,6 @@
 #include <linux/spi/pxa2xx_spi.h>
 
 struct driver_data {
-	/* Driver model hookup */
-	struct platform_device *pdev;
-
 	/* SSP Info */
 	struct ssp_device *ssp;
 
-- 
2.30.2

