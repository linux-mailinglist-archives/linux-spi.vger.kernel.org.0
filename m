Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA35F1B724A
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgDXKnr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 06:43:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:57626 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgDXKnp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 06:43:45 -0400
IronPort-SDR: 2LF38Ww+7SFX2fAonbYCBKJpXoAs4TlQ1bh3oYhO6McgsDh3Hhx9rn947RzRx77FOoIJXjjaGZ
 SAHiPsUlZd8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 03:43:44 -0700
IronPort-SDR: hYzhB4UPsAzvlETcc5tInjsnGgPykrj0j6Bw2g80I+2+qN3x7+/EoaaGcTPKvvzvI65w56KUKP
 L/Iv0muCKI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="335307522"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2020 03:43:41 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 4/4] spi: lantiq: Add support to Lightning Mountain SoC
Date:   Fri, 24 Apr 2020 18:42:33 +0800
Message-Id: <5431aaf70b59ff668b347bc84782296a5f950439.1587702428.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1587702428.git.eswara.kota@linux.intel.com>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support to SPI controller on Intel Atom based Lightning Mountain
SoC which reuses Lantiq SPI controller IP.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/Kconfig          |  4 ++--
 drivers/spi/spi-lantiq-ssc.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4887be7f16de..089b0ba4afe3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -495,11 +495,11 @@ config SPI_NPCM_PSPI
 
 config SPI_LANTIQ_SSC
 	tristate "Lantiq SSC SPI controller"
-	depends on LANTIQ || COMPILE_TEST
+	depends on (LANTIQ || X86) || COMPILE_TEST
 	help
 	  This driver supports the Lantiq SSC SPI controller in master
 	  mode. This controller is found on Intel (former Lantiq) SoCs like
-	  the Danube, Falcon, xRX200, xRX300.
+	  the Danube, Falcon, xRX200, xRX300, Lightning Mountain.
 
 config SPI_OC_TINY
 	tristate "OpenCores tiny SPI"
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 74a5d36c5048..f07fa6fbadbe 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -789,6 +789,18 @@ static int lantiq_ssc_transfer_one(struct spi_master *master,
 	return transfer_start(spi, spidev, t);
 }
 
+static int intel_cfg_irq(struct platform_device *pdev, struct lantiq_ssc_spi *spi)
+{
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	return devm_request_threaded_irq(&pdev->dev, irq, NULL, lantiq_ssc_isr,
+					IRQF_ONESHOT, "spi", spi);
+}
+
 static int lantiq_cfg_irq(struct platform_device *pdev, struct lantiq_ssc_spi *spi)
 {
 	int irq, err;
@@ -837,10 +849,18 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
 	.irq_ack	= false,
 };
 
+static const struct lantiq_ssc_hwcfg intel_ssc_lgm = {
+	.irnen_r	= LTQ_SPI_IRNEN_R_XRX,
+	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
+	.fifo_size_mask	= GENMASK(7, 0),
+	.cfg_irq	= intel_cfg_irq,
+};
+
 static const struct of_device_id lantiq_ssc_match[] = {
 	{ .compatible = "lantiq,ase-spi", .data = &lantiq_ssc_xway, },
 	{ .compatible = "lantiq,falcon-spi", .data = &lantiq_ssc_xrx, },
 	{ .compatible = "lantiq,xrx100-spi", .data = &lantiq_ssc_xrx, },
+	{ .compatible = "intel,lgm-spi", .data = &intel_ssc_lgm, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lantiq_ssc_match);
-- 
2.11.0

