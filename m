Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6574ADC5E4
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 15:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392988AbfJRNVl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 09:21:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:64737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfJRNVk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Oct 2019 09:21:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 06:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="186825700"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2019 06:21:38 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/3] spi: dw-pci: Add runtime power management support
Date:   Fri, 18 Oct 2019 16:21:30 +0300
Message-Id: <20191018132131.31608-2-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
References: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Raymond Tan <raymond.tan@intel.com>

Implement pm_runtime hooks at pci driver.

Signed-off-by: Raymond Tan <raymond.tan@intel.com>
[jarkko.nikula@linux.intel.com: Forward ported on top of
commit 1e6959832510 ("spi: dw: Add basic runtime PM support")]
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-dw-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 7ab53f4d04b9..1cddecea2715 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -7,6 +7,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
@@ -101,6 +102,11 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev_info(&pdev->dev, "found PCI SPI controller(ID: %04x:%04x)\n",
 		pdev->vendor, pdev->device);
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 }
 
@@ -108,6 +114,9 @@ static void spi_pci_remove(struct pci_dev *pdev)
 {
 	struct dw_spi *dws = pci_get_drvdata(pdev);
 
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
 	dw_spi_remove_host(dws);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.23.0

