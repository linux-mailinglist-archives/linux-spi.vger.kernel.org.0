Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692022713AD
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgITL3m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53698 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgITL3g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E4E238002547;
        Sun, 20 Sep 2020 11:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8t3FPMWf-_U5; Sun, 20 Sep 2020 14:29:29 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/30] spi: dw: Add KeemBay Master capability
Date:   Sun, 20 Sep 2020 14:28:54 +0300
Message-ID: <20200920112914.26501-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In a further commit we'll have to get rid of the update_cr0() callback and
define a DW SSI capability instead. Since Keem Bay master/slave
functionality is controller by the CTRL0 register bitfield, we need to
first move the master mode selection into the internal corresponding
update_cr0 method, which would be activated by means of the dedicated
DW_SPI_CAP_KEEMBAY_MST capability setup.

Note this will be also useful if the driver will be ever altered to
support the DW SPI slave interface.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c |  4 ++++
 drivers/spi/spi-dw-mmio.c | 20 +++-----------------
 drivers/spi/spi-dw.h      |  8 ++++++++
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 78e5af8ed173..8f9737640ec1 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -252,6 +252,7 @@ u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 			     struct spi_device *spi,
 			     struct spi_transfer *transfer)
 {
+	struct dw_spi *dws = spi_controller_get_devdata(master);
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0;
 
@@ -275,6 +276,9 @@ u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 	/* CTRLR0[13] Shift Register Loop */
 	cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
 
+	if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
+		cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
+
 	return cr0;
 }
 EXPORT_SYMBOL_GPL(dw_spi_update_cr0_v1_01a);
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 7111cb7ca23b..c0d351fde782 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -48,13 +48,6 @@ struct dw_spi_mmio {
 #define SPARX5_FORCE_ENA			0xa4
 #define SPARX5_FORCE_VAL			0xa8
 
-/*
- * For Keem Bay, CTRLR0[31] is used to select controller mode.
- * 0: SSI is slave
- * 1: SSI is master
- */
-#define KEEMBAY_CTRLR0_SSIC_IS_MST		BIT(31)
-
 struct dw_spi_mscc {
 	struct regmap       *syscon;
 	void __iomem        *spi_mst; /* Not sparx5 */
@@ -234,20 +227,13 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
 	return 0;
 }
 
-static u32 dw_spi_update_cr0_keembay(struct spi_controller *master,
-				     struct spi_device *spi,
-				     struct spi_transfer *transfer)
-{
-	u32 cr0 = dw_spi_update_cr0_v1_01a(master, spi, transfer);
-
-	return cr0 | KEEMBAY_CTRLR0_SSIC_IS_MST;
-}
-
 static int dw_spi_keembay_init(struct platform_device *pdev,
 			       struct dw_spi_mmio *dwsmmio)
 {
+	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST;
+
 	/* Register hook to configure CTRLR0 */
-	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_keembay;
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0_v1_01a;
 
 	return 0;
 }
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 4c748b2853a8..da9b543322c9 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -71,6 +71,13 @@
 #define DWC_SSI_CTRLR0_FRF_OFFSET	6
 #define DWC_SSI_CTRLR0_DFS_OFFSET	0
 
+/*
+ * For Keem Bay, CTRLR0[31] is used to select controller mode.
+ * 0: SSI is slave
+ * 1: SSI is master
+ */
+#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
+
 /* Bit fields in SR, 7 bits */
 #define SR_MASK				0x7f		/* cover 7 bits */
 #define SR_BUSY				(1 << 0)
@@ -101,6 +108,7 @@ enum dw_ssi_type {
 
 /* DW SPI capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
+#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
 
 struct dw_spi;
 struct dw_spi_dma_ops {
-- 
2.27.0

