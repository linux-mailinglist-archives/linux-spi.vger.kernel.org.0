Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD7449CE1
	for <lists+linux-spi@lfdr.de>; Mon,  8 Nov 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhKHULw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Nov 2021 15:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234723AbhKHULv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Nov 2021 15:11:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19DA60234;
        Mon,  8 Nov 2021 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636402146;
        bh=k86+JyVs3h0yvS2kIAvv8hKAIORmA1OywHMPzN/pC8w=;
        h=From:To:Cc:Subject:Date:From;
        b=bb6jQLepV1ZMIOKS3/Bcm6Dz/H0XcSUuSwwTu6635bUgZu2jvKLg47O70bQ+00NPL
         CltxlDr4vNAbRaSAhYoCxWK9NxBAAzaQTFgGNEKfYDp/WDj7kbe0+ZaFFR8qD2wHYE
         XKhlZYB0Ml+ndBGemuowBUqYOlcpKb6G/OKn7UVVQ8DJC4vVHPxDTOppJbQrJra8/7
         KerArhBEpeszyCDmZgfc1QKxa/K5YdJ/Htc3EBif8rvr0/VEXr19vXk09tMbwAme44
         lFhTTp9eA4fyAQ9shD/kVVMbl2XHkMtZ99HZ10LmfUztW/9W+vW87Kggyi0iDM8f4L
         wZ9YVPQcAg8Zg==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     broonie@kernel.org
Cc:     dinguyen@kernel.org, a-nandan@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: cadence-quadspi: fix write completion support
Date:   Mon,  8 Nov 2021 14:08:54 -0600
Message-Id: <20211108200854.3616121-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some versions of the Cadence QSPI controller does not have the write
completion register implemented(CQSPI_REG_WR_COMPLETION_CTRL). On the
Intel SoCFPGA platform the CQSPI_REG_WR_COMPLETION_CTRL register is
not configured.

Add a quirk to not write to the CQSPI_REG_WR_COMPLETION_CTRL register.

Fixes: 9cb2ff111712 ("spi: cadence-quadspi: Disable Auto-HW polling)
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8b3d268ac63c..b808c94641fa 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -37,6 +37,7 @@
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -86,6 +87,7 @@ struct cqspi_st {
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
 	bool			use_dma_read;
 	u32			pd_dev_id;
+	bool			wr_completion;
 };
 
 struct cqspi_driver_platdata {
@@ -996,9 +998,11 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	 * polling on the controller's side. spinand and spi-nor will take
 	 * care of polling the status register.
 	 */
-	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
-	reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
-	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	if (cqspi->wr_completion) {
+		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
+		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	}
 
 	reg = readl(reg_base + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
@@ -1736,6 +1740,10 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
 	master->max_speed_hz = cqspi->master_ref_clk_hz;
+
+	/* write completion is supported by default */
+	cqspi->wr_completion = true;
+
 	ddata  = of_device_get_match_data(dev);
 	if (ddata) {
 		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
@@ -1747,6 +1755,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->use_direct_mode = true;
 		if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
 			cqspi->use_dma_read = true;
+		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
+			cqspi->wr_completion = false;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1859,6 +1869,10 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata socfpga_qspi = {
+	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
+};
+
 static const struct cqspi_driver_platdata versal_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
 	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA,
@@ -1887,6 +1901,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "xlnx,versal-ospi-1.0",
 		.data = (void *)&versal_ospi,
 	},
+	{
+		.compatible = "intel,socfpga-qspi",
+		.data = (void *)&socfpga_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.25.1

