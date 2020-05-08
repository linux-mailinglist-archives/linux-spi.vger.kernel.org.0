Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218A51CB7B6
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEHSyv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 14:54:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56286 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgEHSyu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 14:54:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048IsQRZ041420;
        Fri, 8 May 2020 13:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588964066;
        bh=toNupare+j2SQ6enk8i6S7cHswN/UrZuCnT/Z5/dVbA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MEskzfXVUnoGbHeTvQfc1g3MrlzA9L7cqBcrgfzARtZS/mvLp1fBZmntPAlOt2ymX
         J76x6cy9kV0DS1RAfnggxeoRytzkjA/YUqW/dy3grii0iiwQpwGLqZUE3pIoIoOz6d
         SvDaDA8LN6b1XqNtSrs7ALzhtSS47s42qVLHXobA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048IsQW0117476;
        Fri, 8 May 2020 13:54:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 13:54:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 13:54:26 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048IsGpT077355;
        Fri, 8 May 2020 13:54:22 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: [PATCH 1/6] mtd: spi-nor: cadence-quadspi: Drop cdns,is-decoded-cs property
Date:   Sat, 9 May 2020 00:24:06 +0530
Message-ID: <20200508185411.487-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508185411.487-1-vigneshr@ti.com>
References: <20200508185411.487-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Cadence QSPI provides a way to automatically decode CS based on the
offset accessed within memory map window. This feature cannot be
supported in spi-mem framework as controller driver would not have
access to flash geometry. Therefore drop this feature in preparation to
moving to spi-mem.

Note that, this feature never worked in the driver (Direct/Indirect mode
accesses did not take into account size of flash on other CSs) and there
are no users of this feature in kernel. Therefore dropping this should
not cause a regression

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../mtd/spi-nor/controllers/cadence-quadspi.c | 59 +++----------------
 1 file changed, 9 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
index 494dcab4aaaa..fa54f85e16d7 100644
--- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
@@ -77,11 +77,7 @@ struct cqspi_st {
 	dma_addr_t		mmap_phys_base;
 
 	int			current_cs;
-	int			current_page_size;
-	int			current_erase_size;
-	int			current_addr_width;
 	unsigned long		master_ref_clk_hz;
-	bool			is_decoded_cs;
 	u32			fifo_depth;
 	u32			fifo_width;
 	bool			rclk_en;
@@ -715,19 +711,15 @@ static void cqspi_chipselect(struct spi_nor *nor)
 	unsigned int reg;
 
 	reg = readl(reg_base + CQSPI_REG_CONFIG);
-	if (cqspi->is_decoded_cs) {
-		reg |= CQSPI_REG_CONFIG_DECODE_MASK;
-	} else {
-		reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
+	reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
 
-		/* Convert CS if without decoder.
-		 * CS0 to 4b'1110
-		 * CS1 to 4b'1101
-		 * CS2 to 4b'1011
-		 * CS3 to 4b'0111
-		 */
-		chip_select = 0xF & ~(1 << chip_select);
-	}
+	/* Convert CS if without decoder.
+	 * CS0 to 4b'1110
+	 * CS1 to 4b'1101
+	 * CS2 to 4b'1011
+	 * CS3 to 4b'0111
+	 */
+	chip_select = 0xF & ~(1 << chip_select);
 
 	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
 		 << CQSPI_REG_CONFIG_CHIPSELECT_LSB);
@@ -736,32 +728,6 @@ static void cqspi_chipselect(struct spi_nor *nor)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_configure_cs_and_sizes(struct spi_nor *nor)
-{
-	struct cqspi_flash_pdata *f_pdata = nor->priv;
-	struct cqspi_st *cqspi = f_pdata->cqspi;
-	void __iomem *iobase = cqspi->iobase;
-	unsigned int reg;
-
-	/* configure page size and block size. */
-	reg = readl(iobase + CQSPI_REG_SIZE);
-	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
-	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
-	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-	reg |= (nor->page_size << CQSPI_REG_SIZE_PAGE_LSB);
-	reg |= (ilog2(nor->mtd.erasesize) << CQSPI_REG_SIZE_BLOCK_LSB);
-	reg |= (nor->addr_width - 1);
-	writel(reg, iobase + CQSPI_REG_SIZE);
-
-	/* configure the chip select */
-	cqspi_chipselect(nor);
-
-	/* Store the new configuration of the controller */
-	cqspi->current_page_size = nor->page_size;
-	cqspi->current_erase_size = nor->mtd.erasesize;
-	cqspi->current_addr_width = nor->addr_width;
-}
-
 static unsigned int calculate_ticks_for_ns(const unsigned int ref_clk_hz,
 					   const unsigned int ns_val)
 {
@@ -867,18 +833,13 @@ static void cqspi_configure(struct spi_nor *nor)
 	int switch_cs = (cqspi->current_cs != f_pdata->cs);
 	int switch_ck = (cqspi->sclk != sclk);
 
-	if ((cqspi->current_page_size != nor->page_size) ||
-	    (cqspi->current_erase_size != nor->mtd.erasesize) ||
-	    (cqspi->current_addr_width != nor->addr_width))
-		switch_cs = 1;
-
 	if (switch_cs || switch_ck)
 		cqspi_controller_enable(cqspi, 0);
 
 	/* Switch chip select. */
 	if (switch_cs) {
 		cqspi->current_cs = f_pdata->cs;
-		cqspi_configure_cs_and_sizes(nor);
+		cqspi_chipselect(nor);
 	}
 
 	/* Setup baudrate divisor and delays */
@@ -1145,8 +1106,6 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
-	cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
-
 	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
 		dev_err(&pdev->dev, "couldn't determine fifo-depth\n");
 		return -ENXIO;
-- 
2.26.2

