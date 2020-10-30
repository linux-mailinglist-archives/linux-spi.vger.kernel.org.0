Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09B129FD47
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 06:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgJ3FcI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 01:32:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:35925 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgJ3FcI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 01:32:08 -0400
IronPort-SDR: 0kDXaqEaOn0L9kJWxiZtcNyN4RB+kRi8lzQEK7D/Xlri35V8a6zmW6z4yl9KH6ydW3oOmIceV7
 ywzQQlkxkcKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="147846533"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="147846533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 22:32:07 -0700
IronPort-SDR: O3lhJVeeJ7vPZ8Sh8akdfcxnjpnulVuIeuEysl/LbitlD0brJrTwN4zDLcAYxopsDvLeB2PyAI
 RsoXA8pDGIPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="525788551"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2020 22:32:04 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v6 2/6] spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
Date:   Fri, 30 Oct 2020 13:31:49 +0800
Message-Id: <20201030053153.5319-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
index d7b10c46fa70..6d6f7c440ece 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1107,6 +1107,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 
 	cqspi_controller_enable(cqspi, 1);
+
+	/* Disable direct access controller */
+	if (!cqspi->use_direct_mode) {
+		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	}
 }
 
 static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
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

