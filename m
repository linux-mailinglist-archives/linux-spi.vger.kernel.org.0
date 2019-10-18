Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B77DC5E3
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfJRNVi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 09:21:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:64737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfJRNVi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Oct 2019 09:21:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 06:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="186825665"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2019 06:21:35 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 1/3] spi: dw: Move runtime PM enable/disable from common to platform driver part
Date:   Fri, 18 Oct 2019 16:21:29 +0300
Message-Id: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After commit 1e6959832510 ("spi: dw: Add basic runtime PM support")
there is following warning from PCI enumerated DesignWare SPI controller
during probe:

	dw_spi_pci 0000:00:13.0: Unbalanced pm_runtime_enable!

Runtime PM is already enabled for PCI devices by the PCI core and doing
it again in common DW SPI code leads to unbalanced enable calls.

Fix this by moving the runtime PM enable/disable calls to the platform
driver part of the driver.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 5 +++++
 drivers/spi/spi-dw.c      | 7 -------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index b5ce8bd58d9e..384a3ab6dc2d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/scatterlist.h>
@@ -193,6 +194,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			goto out;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto out;
@@ -201,6 +204,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;
 
 out:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
@@ -212,6 +216,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
 	dw_spi_remove_host(&dwsmmio->dws);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 54ed6eb3e252..466f5c67843b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -499,8 +498,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
-	pm_runtime_enable(dev);
-
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
@@ -529,7 +526,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
-	pm_runtime_disable(dev);
 	spi_controller_put(master);
 	return ret;
 }
@@ -544,9 +540,6 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
 	spi_shutdown_chip(dws);
 
-	if (dws->master)
-		pm_runtime_disable(&dws->master->dev);
-
 	free_irq(dws->irq, dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
-- 
2.23.0

