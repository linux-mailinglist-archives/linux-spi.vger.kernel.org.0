Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7392C1CA2
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 05:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKXES4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 23:18:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:8580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgKXES4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:18:56 -0500
IronPort-SDR: 4BvLlg7braVNUGWmkUcovuW/j+8MKB6R4ckeZ/eLB/J3BvpwpnCnBZC3P6Hay/oKzns47uYl6Y
 FrOXcsFR6m2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168378669"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="168378669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 20:18:56 -0800
IronPort-SDR: sBvWoYr74p3lWqqnUy+GsmydSZt6zi34vvPqv+loX2QigTV1lcwwOoglLotbf9NkFCuzUSrlK8
 OWYwl0KvlQfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="343029843"
Received: from sgsxdev004.isng.phoenix.local (HELO localhost) ([10.226.81.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2020 20:18:53 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 2/5] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
Date:   Tue, 24 Nov 2020 12:18:37 +0800
Message-Id: <20201124041840.31066-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

On Intel Lightning Mountain(LGM) SoCs QSPI controller do not use
Direct Access Controller(DAC).

This patch adds a quirk to disable the Direct Access Controller
for data transfer instead it uses indirect data transfe

DAC bit resets to 1 so there is no need to explicitly set it.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/spi/spi-cadence-quadspi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d7b10c46fa70..d12b765e87be 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1101,10 +1101,12 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
 	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 
-	/* Enable Direct Access Controller */
-	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
-	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
-	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	/* Disable direct access controller */
+	if (!cqspi->use_direct_mode) {
+		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	}
 
 	cqspi_controller_enable(cqspi, 1);
 }
@@ -1388,6 +1390,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
 	.quirks = CQSPI_NEEDS_WR_DELAY,
 };
 
+static const struct cqspi_driver_platdata intel_lgm_qspi = {
+	.quirks = CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1403,6 +1409,7 @@ static const struct of_device_id cqspi_dt_ids[] = {
 	},
 	{
 		.compatible = "intel,lgm-qspi",
+		.data = &intel_lgm_qspi,
 	},
 	{ /* end of table */ }
 };
-- 
2.11.0

