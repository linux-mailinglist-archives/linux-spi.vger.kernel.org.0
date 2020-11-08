Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B92AADF0
	for <lists+linux-spi@lfdr.de>; Sun,  8 Nov 2020 23:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKHWtR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Nov 2020 17:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgKHWtP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Nov 2020 17:49:15 -0500
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Nov 2020 14:49:15 PST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FFC0613CF
        for <linux-spi@vger.kernel.org>; Sun,  8 Nov 2020 14:49:15 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 5B8E9101E6AB3;
        Sun,  8 Nov 2020 23:42:17 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 1F350603DAD2;
        Sun,  8 Nov 2020 23:42:17 +0100 (CET)
X-Mailbox-Line: From 232281df1ab91d8f0f553a62d5f97fc264ace4da Mon Sep 17 00:00:00 2001
Message-Id: <232281df1ab91d8f0f553a62d5f97fc264ace4da.1604874488.git.lukas@wunner.de>
In-Reply-To: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Nov 2020 23:41:00 +0100
Subject: [PATCH] spi: synquacer: Disable clock in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the calls to platform_get_irq() or devm_request_irq() fail on probe
of the SynQuacer SPI driver, the clock "sspi->clk" is erroneously not
unprepared and disabled.

If the clock rate "master->max_speed_hz" cannot be determined, the same
happens and in addition the spi_master struct is not freed.

Fix it.

Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.3+
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/spi/spi-synquacer.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 42e82dbe3d41..8cdca6ab8098 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -657,7 +657,8 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	if (!master->max_speed_hz) {
 		dev_err(&pdev->dev, "missing clock source\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto disable_clk;
 	}
 	master->min_speed_hz = master->max_speed_hz / 254;
 
@@ -670,7 +671,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	rx_irq = platform_get_irq(pdev, 0);
 	if (rx_irq <= 0) {
 		ret = rx_irq;
-		goto put_spi;
+		goto disable_clk;
 	}
 	snprintf(sspi->rx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-rx",
 		 dev_name(&pdev->dev));
@@ -678,13 +679,13 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 				0, sspi->rx_irq_name, sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "request rx_irq failed (%d)\n", ret);
-		goto put_spi;
+		goto disable_clk;
 	}
 
 	tx_irq = platform_get_irq(pdev, 1);
 	if (tx_irq <= 0) {
 		ret = tx_irq;
-		goto put_spi;
+		goto disable_clk;
 	}
 	snprintf(sspi->tx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-tx",
 		 dev_name(&pdev->dev));
@@ -692,7 +693,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 				0, sspi->tx_irq_name, sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "request tx_irq failed (%d)\n", ret);
-		goto put_spi;
+		goto disable_clk;
 	}
 
 	master->dev.of_node = np;
@@ -710,7 +711,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	ret = synquacer_spi_enable(master);
 	if (ret)
-		goto fail_enable;
+		goto disable_clk;
 
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
@@ -723,7 +724,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(sspi->dev);
-fail_enable:
+disable_clk:
 	clk_disable_unprepare(sspi->clk);
 put_spi:
 	spi_master_put(master);
-- 
2.28.0

