Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA71CD3ED
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgEKIar (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 04:30:47 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:58630 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgEKIao (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 04:30:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9A6FA2005E70;
        Mon, 11 May 2020 16:30:41 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AQdglLeM99ko; Mon, 11 May 2020 16:30:41 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 800B320020CB;
        Mon, 11 May 2020 16:30:41 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 7D911C01F94;
        Mon, 11 May 2020 16:30:41 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 78F212001DE; Mon, 11 May 2020 16:30:41 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jack Lo <jack.lo@gtsys.com.hk>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] spi: spi-rockchip: add support for spi slave mode
Date:   Mon, 11 May 2020 16:30:21 +0800
Message-Id: <20200511083022.23678-3-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511083022.23678-1-chris.ruehl@gtsys.com.hk>
References: <20200511083022.23678-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for spi slave mode in spi-rockchip. The register map has an entry
for it. If spi-slave is set in dts, set this corresponding bit and add to
mode_bits the SPI_NO_CS, allow slave mode without explicit CS use.
Slave abort function had been added.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/spi/spi-rockchip.c | 44 ++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index c501d8a84414..f57a8faa6f31 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -183,6 +183,8 @@ struct rockchip_spi {
 	u8 rsd;
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
+
+	bool slave_abort;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -359,7 +361,7 @@ static void rockchip_spi_dma_rxcb(void *data)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
-	if (state & TXDMA)
+	if (state & TXDMA && !rs->slave_abort)
 		return;
 
 	spi_enable_chip(rs, false);
@@ -372,7 +374,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 	int state = atomic_fetch_andnot(TXDMA, &rs->state);
 
-	if (state & RXDMA)
+	if (state & RXDMA && !rs->slave_abort)
 		return;
 
 	/* Wait until the FIFO data completely. */
@@ -457,7 +459,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 
 static void rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
-		bool use_dma)
+		bool use_dma, bool slave_mode)
 {
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
@@ -466,6 +468,10 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	u32 cr1;
 	u32 dmacr = 0;
 
+	if (slave_mode)
+		cr0 |= CR0_OPM_SLAVE << CR0_OPM_OFFSET;
+	rs->slave_abort = false;
+
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
@@ -535,6 +541,16 @@ static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
 	return ROCKCHIP_SPI_MAX_TRANLEN;
 }
 
+static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
+{
+	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
+
+	rs->slave_abort = true;
+	complete(&ctlr->xfer_completion);
+
+	return 0;
+}
+
 static int rockchip_spi_transfer_one(
 		struct spi_controller *ctlr,
 		struct spi_device *spi,
@@ -560,7 +576,7 @@ static int rockchip_spi_transfer_one(
 
 	use_dma = ctlr->can_dma ? ctlr->can_dma(ctlr, spi, xfer) : false;
 
-	rockchip_spi_config(rs, spi, xfer, use_dma);
+	rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
 
 	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, ctlr, xfer);
@@ -588,15 +604,26 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	struct rockchip_spi *rs;
 	struct spi_controller *ctlr;
 	struct resource *mem;
+	struct device_node *np = pdev->dev.of_node;
 	u32 rsd_nsecs;
+	bool slave_mode;
+
+	slave_mode = of_property_read_bool(np, "spi-slave");
+
+	if (slave_mode)
+		ctlr = spi_alloc_slave(&pdev->dev,
+				sizeof(struct rockchip_spi));
+	else
+		ctlr = spi_alloc_master(&pdev->dev,
+				sizeof(struct rockchip_spi));
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct rockchip_spi));
 	if (!ctlr)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, ctlr);
 
 	rs = spi_controller_get_devdata(ctlr);
+	ctlr->slave = slave_mode;
 
 	/* Get basic io resource and map it */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -676,6 +703,12 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->auto_runtime_pm = true;
 	ctlr->bus_num = pdev->id;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
+	if (slave_mode) {
+		ctlr->mode_bits |= SPI_NO_CS;
+		ctlr->slave_abort = rockchip_spi_slave_abort;
+	} else {
+		ctlr->flags = SPI_MASTER_GPIO_SS;
+	}
 	ctlr->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
@@ -686,7 +719,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = rockchip_spi_transfer_one;
 	ctlr->max_transfer_size = rockchip_spi_max_transfer_size;
 	ctlr->handle_err = rockchip_spi_handle_err;
-	ctlr->flags = SPI_MASTER_GPIO_SS;
 
 	ctlr->dma_tx = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
-- 
2.20.1

