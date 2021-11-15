Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868CB450F2C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 19:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhKOS1M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 13:27:12 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:45166 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbhKOSZC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 13:25:02 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] spi: dw: Replace DWC_HSSI capability with IP-core version checker
Date:   Mon, 15 Nov 2021 21:19:16 +0300
Message-ID: <20211115181917.7521-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since there is a common IP-core and component versions interface available
we can use it to differentiate the DW HSSI device features in the code.
Let's remove the corresponding DWC_HSSI capability flag then and use the
dw_spi_ip_is() macro instead.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changelog v2:
- This is a new patch created as a logical result of a new DW SSI IP-core
  versions internal interface introduced in the previous patch.

Changelog v3:
- Move the DW_SPI_CAP_DFS32 capability flag position fix to a separate
  patch.
---
 drivers/spi/spi-dw-core.c | 8 ++++----
 drivers/spi/spi-dw-mmio.c | 5 +++--
 drivers/spi/spi-dw.h      | 1 -
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 42536b448ddd..934cc7a922e8 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -272,7 +272,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 {
 	u32 cr0 = 0;
 
-	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
+	if (dw_spi_ip_is(dws, PSSI)) {
 		/* CTRLR0[ 5: 4] Frame Format */
 		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
 
@@ -325,7 +325,7 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
 	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
 
-	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
+	if (dw_spi_ip_is(dws, PSSI))
 		/* CTRLR0[ 9:8] Transfer Mode */
 		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 	else
@@ -832,7 +832,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dws->ver = dw_readl(dws, DW_SPI_VERSION);
 
 		dev_dbg(dev, "Synopsys DWC%sSSI v%c.%c%c\n",
-			(dws->caps & DW_SPI_CAP_DWC_HSSI) ? " " : " APB ",
+			dw_spi_ip_is(dws, PSSI) ? " APB " : " ",
 			DW_SPI_GET_BYTE(dws->ver, 3), DW_SPI_GET_BYTE(dws->ver, 2),
 			DW_SPI_GET_BYTE(dws->ver, 1));
 	}
@@ -860,7 +860,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 	 * writability. Note DWC SSI controller also has the extended DFS, but
 	 * with zero offset.
 	 */
-	if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
+	if (dw_spi_ip_is(dws, PSSI)) {
 		u32 cr0, tmp = dw_readl(dws, DW_SPI_CTRLR0);
 
 		dw_spi_enable_chip(dws, 0);
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 0b37bd32b041..c0e5bb6add0a 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -207,7 +207,7 @@ static int dw_spi_pssi_init(struct platform_device *pdev,
 static int dw_spi_hssi_init(struct platform_device *pdev,
 			    struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_DWC_HSSI;
+	dwsmmio->dws.ip = DW_HSSI_ID;
 
 	dw_spi_dma_setup_generic(&dwsmmio->dws);
 
@@ -217,7 +217,8 @@ static int dw_spi_hssi_init(struct platform_device *pdev,
 static int dw_spi_keembay_init(struct platform_device *pdev,
 			       struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_HSSI;
+	dwsmmio->dws.ip = DW_HSSI_ID;
+	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
 
 	return 0;
 }
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f7d77024b48..8334e6b35f89 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -32,7 +32,6 @@
 /* DW SPI controller capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-#define DW_SPI_CAP_DWC_HSSI		BIT(2)
 #define DW_SPI_CAP_DFS32		BIT(3)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
-- 
2.33.0

