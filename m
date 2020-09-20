Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3F2713A0
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgITL3m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53682 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgITL3b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 160EE8001644;
        Sun, 20 Sep 2020 11:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sa7y3orPH8Hw; Sun, 20 Sep 2020 14:29:27 +0300 (MSK)
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
Subject: [PATCH 08/30] spi: dw: Discard DW SSI chip type storages
Date:   Sun, 20 Sep 2020 14:28:52 +0300
Message-ID: <20200920112914.26501-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Keeping SPI peripheral devices type is pointless since first it hasn't
been functionally utilized by any of the client drivers/code and second it
won't work for Microwire type at the very least. Moreover there is no
point in setting up the type by means of the chip-data in the modern
kernel. The peripheral devices with specific interface type need to be
detected in order to activate the corresponding frame format. It most
likely will require some peripheral device specific DT property or
whatever to find out the interface protocol. So let's remove the serial
interface type fields from the DW APB SSI controller and the SPI
peripheral device private data.

Note we'll preserve the explicit SSI_MOTO_SPI interface type setting up to
signify the only currently supported interface protocol.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 6 ++----
 drivers/spi/spi-dw.h      | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index be94ed5bb896..dd9574f9fafc 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -23,7 +23,6 @@
 /* Slave spi_dev related */
 struct chip_data {
 	u8 tmode;		/* TR/TO/RO/EEPROM */
-	u8 type;		/* SPI/SSP/MicroWire */
 
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
@@ -238,7 +237,7 @@ u32 dw_spi_update_cr0(struct spi_controller *master, struct spi_device *spi,
 
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
-		| (chip->type << SPI_FRF_OFFSET)
+		| (SSI_MOTO_SPI << SPI_FRF_OFFSET)
 		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
 		   (((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET) |
 		   (((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET))
@@ -260,7 +259,7 @@ u32 dw_spi_update_cr0_v1_01a(struct spi_controller *master,
 	cr0 = (transfer->bits_per_word - 1);
 
 	/* CTRLR0[ 7: 6] Frame Format */
-	cr0 |= chip->type << DWC_SSI_CTRLR0_FRF_OFFSET;
+	cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
 
 	/*
 	 * SPI mode (SCPOL|SCPH)
@@ -453,7 +452,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		return -ENOMEM;
 
 	dws->master = master;
-	dws->type = SSI_MOTO_SPI;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + DW_SPI_DR);
 
 	spi_controller_set_devdata(master, dws);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 063fa1b1352d..4420b4d29bac 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -111,7 +111,6 @@ struct dw_spi_dma_ops {
 
 struct dw_spi {
 	struct spi_controller	*master;
-	enum dw_ssi_type	type;
 
 	void __iomem		*regs;
 	unsigned long		paddr;
-- 
2.27.0

