Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C02713AA
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgITL3m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53690 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgITL3d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 0261A800248D;
        Sun, 20 Sep 2020 11:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RV5-gS_4YUbN; Sun, 20 Sep 2020 14:29:28 +0300 (MSK)
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
Subject: [PATCH 09/30] spi: dw: Convert CS-override to DW SPI capabilities
Date:   Sun, 20 Sep 2020 14:28:53 +0300
Message-ID: <20200920112914.26501-10-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are several vendor-specific versions of the DW SPI controllers,
each of which may have some peculiarities with respect to the original
IP-core. Seeing it has already caused adding flags and a callback into the
DW SPI private data, let's introduce a generic capabilities interface to
tune the generic DW SPI controller driver up in accordance with the
particular controller specifics. It's done by converting a simple
Alpine-specific CS-override capability into the DW SPI controller
capability activated by setting the DW_SPI_CAP_CS_OVERRIDE flag.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 4 ++--
 drivers/spi/spi-dw-mmio.c | 2 +-
 drivers/spi/spi-dw.h      | 7 ++++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index dd9574f9fafc..78e5af8ed173 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -104,7 +104,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	 */
 	if (cs_high == enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
-	else if (dws->cs_override)
+	else if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
 		dw_writel(dws, DW_SPI_SER, 0);
 }
 EXPORT_SYMBOL_GPL(dw_spi_set_cs);
@@ -435,7 +435,7 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 	}
 
 	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
-	if (dws->cs_override)
+	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
 }
 
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 18772c0c9220..7111cb7ca23b 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -204,7 +204,7 @@ static int dw_spi_mscc_sparx5_init(struct platform_device *pdev,
 static int dw_spi_alpine_init(struct platform_device *pdev,
 			      struct dw_spi_mmio *dwsmmio)
 {
-	dwsmmio->dws.cs_override = 1;
+	dwsmmio->dws.caps = DW_SPI_CAP_CS_OVERRIDE;
 
 	/* Register hook to configure CTRLR0 */
 	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 4420b4d29bac..4c748b2853a8 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -2,6 +2,7 @@
 #ifndef DW_SPI_HEADER_H
 #define DW_SPI_HEADER_H
 
+#include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/irqreturn.h>
@@ -98,6 +99,9 @@ enum dw_ssi_type {
 	SSI_NS_MICROWIRE,
 };
 
+/* DW SPI capabilities */
+#define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
+
 struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct device *dev, struct dw_spi *dws);
@@ -118,7 +122,8 @@ struct dw_spi {
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
 
-	int			cs_override;
+	u32			caps;		/* DW SPI capabilities */
+
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
-- 
2.27.0

