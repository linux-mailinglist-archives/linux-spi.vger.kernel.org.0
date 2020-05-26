Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79B1E1EC3
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 11:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgEZJhe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 05:37:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48458 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbgEZJhd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 05:37:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9bK5M068665;
        Tue, 26 May 2020 04:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590485840;
        bh=49K/f3vTIBXO8kwRFOg3JVbwPq6EjYxyjeJq81jcrOY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QEEXSpmpahCdh/VqaDlUgePLvY0hk+auroybjTmprn1gmdScclKM+2gu5CM9K9I5R
         cJtLFz5iuhariJIsYQhnOuRUa4BR8BAKJ0c31+p8paxro5d3LJhAMqcyPXWzVXuGmp
         irD83cLddoFifodbD0K+NsIpGojLrGGMTAIV27pQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04Q9bJR9041226
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 04:37:20 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 04:37:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 04:37:19 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9b9hK066907;
        Tue, 26 May 2020 04:37:15 -0500
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
Subject: [PATCH v2 1/6] mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
Date:   Tue, 26 May 2020 15:05:59 +0530
Message-ID: <20200526093604.11846-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526093604.11846-1-vigneshr@ti.com>
References: <20200526093604.11846-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drop configuration of Flash size, erase size and page size
configuration. Flash size is needed only if using AHB decoder (BIT 23 of
CONFIG_REG) which is not used by the driver.
Erase size and page size are needed if IP is configured to send WREN
automatically. But since SPI NOR layer takes care of sending WREN, there
is no need to configure these fields either.

Therefore drop these in preparation to move the driver to spi-mem
framework where flash geometry is not visible to controller driver.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../mtd/spi-nor/controllers/cadence-quadspi.c | 36 +------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
index 494dcab4aaaa..9b8554d44fac 100644
--- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
@@ -77,9 +77,6 @@ struct cqspi_st {
 	dma_addr_t		mmap_phys_base;
 
 	int			current_cs;
-	int			current_page_size;
-	int			current_erase_size;
-	int			current_addr_width;
 	unsigned long		master_ref_clk_hz;
 	bool			is_decoded_cs;
 	u32			fifo_depth;
@@ -736,32 +733,6 @@ static void cqspi_chipselect(struct spi_nor *nor)
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
@@ -867,18 +838,13 @@ static void cqspi_configure(struct spi_nor *nor)
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
-- 
2.26.2

