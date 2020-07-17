Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0009A223493
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgGQGav (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:34814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgGQGas (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:48 -0400
IronPort-SDR: Ef4zPTRtIXbqlRtr6zknMf4+hYxbntpCUJCAjlyXgrzwmUBmz970PRjJ/qhwB/fROb5w6YGHug
 bNYNkWR/NtLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167677920"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167677920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:48 -0700
IronPort-SDR: Hi2y2CEkCmuNkqubBVtf1JbeMdy1yoTqHOpEuTqQgVUximFPKkNeaQT55SGyPwBqrm+uCUQQKD
 oUH9c9z+DDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="326758925"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2020 23:30:45 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 6/8] spi: lantiq: Move interrupt configuration to SoC specific data structure
Date:   Fri, 17 Jul 2020 14:27:55 +0800
Message-Id: <7eb6d863515245fedfa0296c72082df107367d07.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Moving interrupt configuration to SoC specific data structure helps to add
support for newer SoCs on which SPI controller with lesser interrupt lines
compared to existing chipsets.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/spi/spi-lantiq-ssc.c | 64 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index a0d1f82d309f9..2a433d9b5d8fe 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -150,7 +150,10 @@
 #define LTQ_SPI_IRNEN_T_XRX	BIT(0)	/* Receive end interrupt request */
 #define LTQ_SPI_IRNEN_ALL	0x1F
 
+struct lantiq_ssc_spi;
+
 struct lantiq_ssc_hwcfg {
+	int (*cfg_irq)(struct platform_device *pdev, struct lantiq_ssc_spi *spi);
 	unsigned int	irnen_r;
 	unsigned int	irnen_t;
 	unsigned int	irncr;
@@ -800,7 +803,40 @@ static int lantiq_ssc_transfer_one(struct spi_master *master,
 	return transfer_start(spi, spidev, t);
 }
 
+static int lantiq_cfg_irq(struct platform_device *pdev, struct lantiq_ssc_spi *spi)
+{
+	int irq, err;
+
+	irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_irq(&pdev->dev, irq, lantiq_ssc_xmit_interrupt,
+			       0, LTQ_SPI_RX_IRQ_NAME, spi);
+	if (err)
+		return err;
+
+	irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_irq(&pdev->dev, irq, lantiq_ssc_xmit_interrupt,
+			       0, LTQ_SPI_TX_IRQ_NAME, spi);
+
+	if (err)
+		return err;
+
+	irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_irq(&pdev->dev, irq, lantiq_ssc_err_interrupt,
+			       0, LTQ_SPI_ERR_IRQ_NAME, spi);
+	return err;
+}
+
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xway = {
+	.cfg_irq	= lantiq_cfg_irq,
 	.irnen_r	= LTQ_SPI_IRNEN_R_XWAY,
 	.irnen_t	= LTQ_SPI_IRNEN_T_XWAY,
 	.irnicr		= 0xF8,
@@ -810,6 +846,7 @@ static const struct lantiq_ssc_hwcfg lantiq_ssc_xway = {
 };
 
 static const struct lantiq_ssc_hwcfg lantiq_ssc_xrx = {
+	.cfg_irq	= lantiq_cfg_irq,
 	.irnen_r	= LTQ_SPI_IRNEN_R_XRX,
 	.irnen_t	= LTQ_SPI_IRNEN_T_XRX,
 	.irnicr		= 0xF8,
@@ -833,9 +870,9 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	struct lantiq_ssc_spi *spi;
 	const struct lantiq_ssc_hwcfg *hwcfg;
 	const struct of_device_id *match;
-	int err, rx_irq, tx_irq, err_irq;
 	u32 id, supports_dma, revision;
 	unsigned int num_cs;
+	int err;
 
 	match = of_match_device(lantiq_ssc_match, dev);
 	if (!match) {
@@ -844,18 +881,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	}
 	hwcfg = match->data;
 
-	rx_irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
-	if (rx_irq < 0)
-		return -ENXIO;
-
-	tx_irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
-	if (tx_irq < 0)
-		return -ENXIO;
-
-	err_irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
-	if (err_irq < 0)
-		return -ENXIO;
-
 	master = spi_alloc_master(dev, sizeof(struct lantiq_ssc_spi));
 	if (!master)
 		return -ENOMEM;
@@ -871,18 +896,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 
-	err = devm_request_irq(dev, rx_irq, lantiq_ssc_xmit_interrupt,
-			       0, LTQ_SPI_RX_IRQ_NAME, spi);
-	if (err)
-		goto err_master_put;
-
-	err = devm_request_irq(dev, tx_irq, lantiq_ssc_xmit_interrupt,
-			       0, LTQ_SPI_TX_IRQ_NAME, spi);
-	if (err)
-		goto err_master_put;
-
-	err = devm_request_irq(dev, err_irq, lantiq_ssc_err_interrupt,
-			       0, LTQ_SPI_ERR_IRQ_NAME, spi);
+	err = hwcfg->cfg_irq(pdev, spi);
 	if (err)
 		goto err_master_put;
 
-- 
2.11.0

