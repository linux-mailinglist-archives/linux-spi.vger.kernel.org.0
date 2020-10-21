Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33F294688
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 04:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439998AbgJUCg0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 22:36:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:24514 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439986AbgJUCgZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 22:36:25 -0400
IronPort-SDR: PTC0fctDHb6a3y1GIg11W/RzcwAbqAhVF734bN4ZF36hMcsET86Sx7k33W8LwNfpjkndZy8CG8
 fS0yPSHVUn1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231498477"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231498477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 19:36:24 -0700
IronPort-SDR: 7cxFznqZfMmN7tNNCEq3oetza45SHb8cZRgyM0J0es48dw5ZfMnRVng9C05N1kIZL8Re3hcnjf
 eeB1zQATHnkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="348118796"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2020 19:36:21 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 1/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
Date:   Wed, 21 Oct 2020 10:36:10 +0800
Message-Id: <20201021023615.48982-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

On Intel Lightning Mountain(LGM) SoCs QSPI controller do not use
Direct Access Controller(DAC).

This patch adds a quirk to disable the Direct Access Controller
for data transfer instead it uses indirect data transfer.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/spi/spi-cadence-quadspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d7b10c46fa70..3d017b484114 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1106,6 +1106,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
 	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 
+	/* Disable direct access controller */
+	if (!cqspi->use_direct_mode) {
+		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	}
+
 	cqspi_controller_enable(cqspi, 1);
 }
 
@@ -1388,6 +1395,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
 	.quirks = CQSPI_NEEDS_WR_DELAY,
 };
 
+static const struct cqspi_driver_platdata intel_lgm_qspi = {
+	.quirks = CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1403,6 +1414,7 @@ static const struct of_device_id cqspi_dt_ids[] = {
 	},
 	{
 		.compatible = "intel,lgm-qspi",
+		.data = &intel_lgm_qspi,
 	},
 	{ /* end of table */ }
 };
-- 
2.11.0

