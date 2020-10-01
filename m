Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80AA280A3F
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbgJAW25 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:28:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48078 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbgJAW2w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 18:28:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id CD4F48030171;
        Thu,  1 Oct 2020 22:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NpKLLKgQfoTF; Fri,  2 Oct 2020 01:28:47 +0300 (MSK)
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
Subject: [PATCH v3 04/21] spi: dw: Update SPI bus speed in a config function
Date:   Fri, 2 Oct 2020 01:28:12 +0300
Message-ID: <20201001222829.15977-5-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI bus speed update functionality will be useful in another parts of
the driver too (like to implement the SPI memory operations and from the
DW SPI glue layers). Let's move it to the update_cr0() method then and
since the later is now updating not only the CTRLR0 register alter its
prototype to have a generic function name not related to CR0.

Leave the too long line with the chip->clk_div setting as is for now,
since it's going to be changed later anyway.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 6b89330708bc..77dfd6681f0c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -269,8 +269,8 @@ static u32 dw_spi_get_cr0(struct dw_spi *dws, struct spi_device *spi)
 	return cr0;
 }
 
-static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
-			      struct spi_transfer *transfer)
+static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
+				 struct spi_transfer *transfer)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
@@ -286,6 +286,17 @@ static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
 		cr0 |= chip->tmode << DWC_SSI_CTRLR0_TMOD_OFFSET;
 
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
+
+	/* Handle per transfer options for bpw and speed */
+	if (transfer->speed_hz != dws->current_freq) {
+		if (transfer->speed_hz != chip->speed_hz) {
+			/* clk_div doesn't support odd number */
+			chip->clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
+			chip->speed_hz = transfer->speed_hz;
+		}
+		dws->current_freq = transfer->speed_hz;
+		spi_set_clk(dws, chip->clk_div);
+	}
 }
 
 static int dw_spi_transfer_one(struct spi_controller *master,
@@ -310,21 +321,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 
 	spi_enable_chip(dws, 0);
 
-	/* Handle per transfer options for bpw and speed */
-	if (transfer->speed_hz != dws->current_freq) {
-		if (transfer->speed_hz != chip->speed_hz) {
-			/* clk_div doesn't support odd number */
-			chip->clk_div = (DIV_ROUND_UP(dws->max_freq, transfer->speed_hz) + 1) & 0xfffe;
-			chip->speed_hz = transfer->speed_hz;
-		}
-		dws->current_freq = transfer->speed_hz;
-		spi_set_clk(dws, chip->clk_div);
-	}
+	dw_spi_update_config(dws, spi, transfer);
 
 	transfer->effective_speed_hz = dws->max_freq / chip->clk_div;
 
-	dw_spi_update_cr0(dws, spi, transfer);
-
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
 		dws->dma_mapped = master->cur_msg_mapped;
-- 
2.27.0

