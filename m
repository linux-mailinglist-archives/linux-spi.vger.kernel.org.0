Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C921A37B4
	for <lists+linux-spi@lfdr.de>; Thu,  9 Apr 2020 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgDIQFZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Apr 2020 12:05:25 -0400
Received: from mail.secom.com.pl ([213.216.87.26]:43528 "EHLO
        mail.secom.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgDIQFZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Apr 2020 12:05:25 -0400
Received: from localhost.localdomain
        (host-85.14.70.3.static.3s.pl [85.14.70.3])
        by mail.secom.com.pl; Thu, 09 Apr 2020 18:05:02 +0200
From:   =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>
Cc:     =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-axi-spi-engine: Access register after clock  initialization
Date:   Thu,  9 Apr 2020 17:56:21 +0200
Message-Id: <20200409155621.12174-1-rafal.hibner@secom.com.pl>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Move register access after clock initialization.
Clock "s_axi_aclk" is needed for register access. Without the clock running
AXI bus hangs and causes kernel freeze.

Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Rafał Hibner <rafal.hibner@secom.com.pl>
---
 drivers/spi/spi-axi-spi-engine.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index eb9b78a90d..af86e6d6e1 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -489,22 +489,6 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spi_engine->lock);
 
-	spi_engine->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi_engine->base)) {
-		ret = PTR_ERR(spi_engine->base);
-		goto err_put_master;
-	}
-
-	version = readl(spi_engine->base + SPI_ENGINE_REG_VERSION);
-	if (SPI_ENGINE_VERSION_MAJOR(version) != 1) {
-		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%c\n",
-			SPI_ENGINE_VERSION_MAJOR(version),
-			SPI_ENGINE_VERSION_MINOR(version),
-			SPI_ENGINE_VERSION_PATCH(version));
-		ret = -ENODEV;
-		goto err_put_master;
-	}
-
 	spi_engine->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk)) {
 		ret = PTR_ERR(spi_engine->clk);
@@ -525,6 +509,22 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
+	spi_engine->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spi_engine->base)) {
+		ret = PTR_ERR(spi_engine->base);
+		goto err_ref_clk_disable;
+	}
+
+	version = readl(spi_engine->base + SPI_ENGINE_REG_VERSION);
+	if (SPI_ENGINE_VERSION_MAJOR(version) != 1) {
+		dev_err(&pdev->dev, "Unsupported peripheral version %u.%u.%c\n",
+			SPI_ENGINE_VERSION_MAJOR(version),
+			SPI_ENGINE_VERSION_MINOR(version),
+			SPI_ENGINE_VERSION_PATCH(version));
+		ret = -ENODEV;
+		goto err_ref_clk_disable;
+	}
+
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
-- 
2.24.1

