Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4D40076E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhICVaP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 17:30:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:23148 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhICVaP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Sep 2021 17:30:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="216376350"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="216376350"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 14:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="534425920"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2021 14:29:11 -0700
From:   mahesh.r.vaidya@intel.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mgross@linux.intel.com, kris.pan@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v1] spi: dw: Enable Autosuspend delay for SPI DesignWare
Date:   Sat,  4 Sep 2021 05:27:58 +0800
Message-Id: <20210903212758.22038-1-mahesh.r.vaidya@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>

Enable and set Autosuspend delay for SPI DesignWare driver.
The number 1000 ms for the autosuspend delay was picked a bit
arbitrarily, so if someone has measurements showing a better
value we could easily change this.

Signed-off-by: Mahesh R Vaidya <mahesh.r.vaidya@intel.com>
---
 drivers/spi/spi-dw-mmio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3379720cfcb8..8b588ce9c16b 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -33,6 +33,8 @@ struct dw_spi_mmio {
 	struct reset_control *rstc;
 };

+#define SPI_DW_DEFAULT_AUTOSUSP_VAL		1000
+
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
 #define OCELOT_IF_SI_OWNER_OFFSET		4
 #define JAGUAR2_IF_SI_OWNER_OFFSET		6
@@ -309,6 +311,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 			goto out;
 	}

+	/* Set initial autosuspend default delay value and enable */
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_DW_DEFAULT_AUTOSUSP_VAL);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);

 	ret = dw_spi_add_host(&pdev->dev, dws);
@@ -319,6 +325,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return 0;

 out:
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 out_clk:
--
2.17.1

