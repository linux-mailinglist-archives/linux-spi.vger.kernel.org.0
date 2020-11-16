Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB12B3EAC
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 09:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKPIa1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 03:30:27 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:57829 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKPIa0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 03:30:26 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 4A975101903D8;
        Mon, 16 Nov 2020 09:30:23 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E32486035EEE;
        Mon, 16 Nov 2020 09:30:23 +0100 (CET)
X-Mailbox-Line: From 76a3e9a52fdb5ff60d992c6cc2e64f29d3d3ea8b Mon Sep 17 00:00:00 2001
Message-Id: <76a3e9a52fdb5ff60d992c6cc2e64f29d3d3ea8b.1605512876.git.lukas@wunner.de>
In-Reply-To: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 16 Nov 2020 09:23:02 +0100
Subject: [PATCH for-5.10] spi: spi-qcom-qspi: Fix use-after-free on unbind
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

qcom_qspi_remove() accesses the driver's private data after calling
spi_unregister_master() even though that function releases the last
reference on the spi_master and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound.

Fixes: f79a158d37c2 ("spi: spi-qcom-qspi: Use OPP API to set clk/perf state")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.9+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.9+
Cc: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/spi/spi-qcom-qspi.c | 42 ++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index 5eed88af6899..8863be370884 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -462,7 +462,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 
 	dev = &pdev->dev;
 
-	master = spi_alloc_master(dev, sizeof(*ctrl));
+	master = devm_spi_alloc_master(dev, sizeof(*ctrl));
 	if (!master)
 		return -ENOMEM;
 
@@ -473,54 +473,49 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	spin_lock_init(&ctrl->lock);
 	ctrl->dev = dev;
 	ctrl->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ctrl->base)) {
-		ret = PTR_ERR(ctrl->base);
-		goto exit_probe_master_put;
-	}
+	if (IS_ERR(ctrl->base))
+		return PTR_ERR(ctrl->base);
 
 	ctrl->clks = devm_kcalloc(dev, QSPI_NUM_CLKS,
 				  sizeof(*ctrl->clks), GFP_KERNEL);
-	if (!ctrl->clks) {
-		ret = -ENOMEM;
-		goto exit_probe_master_put;
-	}
+	if (!ctrl->clks)
+		return -ENOMEM;
 
 	ctrl->clks[QSPI_CLK_CORE].id = "core";
 	ctrl->clks[QSPI_CLK_IFACE].id = "iface";
 	ret = devm_clk_bulk_get(dev, QSPI_NUM_CLKS, ctrl->clks);
 	if (ret)
-		goto exit_probe_master_put;
+		return ret;
 
 	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
-	if (IS_ERR(ctrl->icc_path_cpu_to_qspi)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
-				    "Failed to get cpu path\n");
-		goto exit_probe_master_put;
-	}
+	if (IS_ERR(ctrl->icc_path_cpu_to_qspi))
+		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
+				     "Failed to get cpu path\n");
+
 	/* Set BW vote for register access */
 	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, Bps_to_icc(1000),
 				Bps_to_icc(1000));
 	if (ret) {
 		dev_err(ctrl->dev, "%s: ICC BW voting failed for cpu: %d\n",
 				__func__, ret);
-		goto exit_probe_master_put;
+		return ret;
 	}
 
 	ret = icc_disable(ctrl->icc_path_cpu_to_qspi);
 	if (ret) {
 		dev_err(ctrl->dev, "%s: ICC disable failed for cpu: %d\n",
 				__func__, ret);
-		goto exit_probe_master_put;
+		return ret;
 	}
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto exit_probe_master_put;
+		return ret;
 	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
 			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to request irq %d\n", ret);
-		goto exit_probe_master_put;
+		return ret;
 	}
 
 	master->max_speed_hz = 300000000;
@@ -537,10 +532,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 
 	ctrl->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
-	if (IS_ERR(ctrl->opp_table)) {
-		ret = PTR_ERR(ctrl->opp_table);
-		goto exit_probe_master_put;
-	}
+	if (IS_ERR(ctrl->opp_table))
+		return PTR_ERR(ctrl->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
 	if (ret && ret != -ENODEV) {
@@ -562,9 +555,6 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 exit_probe_put_clkname:
 	dev_pm_opp_put_clkname(ctrl->opp_table);
 
-exit_probe_master_put:
-	spi_master_put(master);
-
 	return ret;
 }
 
-- 
2.28.0

