Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A72713CB
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgITLbB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:31:01 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53666 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgITL3u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 69250800254C;
        Sun, 20 Sep 2020 11:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D75veaiFf16H; Sun, 20 Sep 2020 14:29:32 +0300 (MSK)
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
Subject: [PATCH 15/30] spi: dw: Update Rx sample delay in the config function
Date:   Sun, 20 Sep 2020 14:28:59 +0300
Message-ID: <20200920112914.26501-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rx sample delay can be SPI device specific, and should be synchronously
initialized with the rest of the communication and peripheral device
related controller setups. So let's move the Rx-sample delay setup into
the DW APB SSI configuration update method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 92138a6ada12..f00fc4828480 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -273,13 +273,18 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		spi_set_clk(dws, clk_div);
 		dws->current_freq = speed_hz;
 	}
+
+	/* Update RX sample delay if required */
+	if (dws->cur_rx_sample_dly != chip->rx_sample_dly) {
+		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
+		dws->cur_rx_sample_dly = chip->rx_sample_dly;
+	}
 }
 
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
-	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
 	int ret;
@@ -305,12 +310,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	if (master->can_dma && master->can_dma(master, spi, transfer))
 		dws->dma_mapped = master->cur_msg_mapped;
 
-	/* Update RX sample delay if required */
-	if (dws->cur_rx_sample_dly != chip->rx_sample_dly) {
-		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
-		dws->cur_rx_sample_dly = chip->rx_sample_dly;
-	}
-
 	/* For poll mode just disable all interrupts */
 	spi_mask_intr(dws, 0xff);
 
-- 
2.27.0

