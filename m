Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32077F016
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbjHQFHz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348079AbjHQFHf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932A1BF8
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:34 -0700 (PDT)
Received: from dggpemm100003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRCdZ0fj7zrScG;
        Thu, 17 Aug 2023 13:06:10 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100003.china.huawei.com (7.185.36.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:31 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH -next v2 13/23] spi: rockchip: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:22 +0800
Message-ID: <20230817050332.1274751-14-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817050332.1274751-1-yangyingliang@huawei.com>
References: <20230817050332.1274751-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
Cc: Heiko Stuebner <heiko@sntech.de>
---
 drivers/spi/spi-rockchip.c | 58 +++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a37943847e81..5b010094dace 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -104,8 +104,8 @@
 #define CR0_XFM_RO					0x2
 
 #define CR0_OPM_OFFSET				20
-#define CR0_OPM_MASTER				0x0
-#define CR0_OPM_SLAVE				0x1
+#define CR0_OPM_HOST				0x0
+#define CR0_OPM_TARGET				0x1
 
 #define CR0_SOI_OFFSET				23
 
@@ -125,7 +125,7 @@
 #define SR_TF_EMPTY					(1 << 2)
 #define SR_RF_EMPTY					(1 << 3)
 #define SR_RF_FULL					(1 << 4)
-#define SR_SLAVE_TX_BUSY				(1 << 5)
+#define SR_TARGET_TX_BUSY				(1 << 5)
 
 /* Bit fields in ISR, IMR, ISR, RISR, 5bit */
 #define INT_MASK					0x1f
@@ -151,7 +151,7 @@
 #define RXDMA					(1 << 0)
 #define TXDMA					(1 << 1)
 
-/* sclk_out: spi master internal logic in rk3x can support 50Mhz */
+/* sclk_out: spi host internal logic in rk3x can support 50Mhz */
 #define MAX_SCLK_OUT				50000000U
 
 /*
@@ -194,8 +194,8 @@ struct rockchip_spi {
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
-	bool slave_abort;
-	bool cs_inactive; /* spi slave tansmition stop when cs inactive */
+	bool target_abort;
+	bool cs_inactive; /* spi target tansmition stop when cs inactive */
 	bool cs_high_supported; /* native CS supports active-high polarity */
 
 	struct spi_transfer *xfer; /* Store xfer temporarily */
@@ -206,13 +206,13 @@ static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
-static inline void wait_for_tx_idle(struct rockchip_spi *rs, bool slave_mode)
+static inline void wait_for_tx_idle(struct rockchip_spi *rs, bool target_mode)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5);
 
 	do {
-		if (slave_mode) {
-			if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_SLAVE_TX_BUSY) &&
+		if (target_mode) {
+			if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_TARGET_TX_BUSY) &&
 			    !((readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY)))
 				return;
 		} else {
@@ -351,9 +351,9 @@ static irqreturn_t rockchip_spi_isr(int irq, void *dev_id)
 	struct spi_controller *ctlr = dev_id;
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
-	/* When int_cs_inactive comes, spi slave abort */
+	/* When int_cs_inactive comes, spi target abort */
 	if (rs->cs_inactive && readl_relaxed(rs->regs + ROCKCHIP_SPI_IMR) & INT_CS_INACTIVE) {
-		ctlr->slave_abort(ctlr);
+		ctlr->target_abort(ctlr);
 		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
 		writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
 
@@ -405,7 +405,7 @@ static void rockchip_spi_dma_rxcb(void *data)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
-	if (state & TXDMA && !rs->slave_abort)
+	if (state & TXDMA && !rs->target_abort)
 		return;
 
 	if (rs->cs_inactive)
@@ -421,11 +421,11 @@ static void rockchip_spi_dma_txcb(void *data)
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 	int state = atomic_fetch_andnot(TXDMA, &rs->state);
 
-	if (state & RXDMA && !rs->slave_abort)
+	if (state & RXDMA && !rs->target_abort)
 		return;
 
 	/* Wait until the FIFO data completely. */
-	wait_for_tx_idle(rs, ctlr->slave);
+	wait_for_tx_idle(rs, ctlr->target);
 
 	spi_enable_chip(rs, false);
 	spi_finalize_current_transfer(ctlr);
@@ -525,7 +525,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 
 static int rockchip_spi_config(struct rockchip_spi *rs,
 		struct spi_device *spi, struct spi_transfer *xfer,
-		bool use_dma, bool slave_mode)
+		bool use_dma, bool target_mode)
 {
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 		| CR0_BHT_8BIT << CR0_BHT_OFFSET
@@ -534,9 +534,9 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	u32 cr1;
 	u32 dmacr = 0;
 
-	if (slave_mode)
-		cr0 |= CR0_OPM_SLAVE << CR0_OPM_OFFSET;
-	rs->slave_abort = false;
+	if (target_mode)
+		cr0 |= CR0_OPM_TARGET << CR0_OPM_OFFSET;
+	rs->target_abort = false;
 
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
@@ -614,7 +614,7 @@ static size_t rockchip_spi_max_transfer_size(struct spi_device *spi)
 	return ROCKCHIP_SPI_MAX_TRANLEN;
 }
 
-static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
+static int rockchip_spi_target_abort(struct spi_controller *ctlr)
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 	u32 rx_fifo_left;
@@ -659,7 +659,7 @@ static int rockchip_spi_slave_abort(struct spi_controller *ctlr)
 		dmaengine_terminate_sync(ctlr->dma_tx);
 	atomic_set(&rs->state, 0);
 	spi_enable_chip(rs, false);
-	rs->slave_abort = true;
+	rs->target_abort = true;
 	spi_finalize_current_transfer(ctlr);
 
 	return 0;
@@ -697,7 +697,7 @@ static int rockchip_spi_transfer_one(
 	rs->xfer = xfer;
 	use_dma = ctlr->can_dma ? ctlr->can_dma(ctlr, spi, xfer) : false;
 
-	ret = rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->slave);
+	ret = rockchip_spi_config(rs, spi, xfer, use_dma, ctlr->target);
 	if (ret)
 		return ret;
 
@@ -757,15 +757,15 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
 	u32 rsd_nsecs, num_cs;
-	bool slave_mode;
+	bool target_mode;
 
-	slave_mode = of_property_read_bool(np, "spi-slave");
+	target_mode = of_property_read_bool(np, "spi-slave");
 
-	if (slave_mode)
-		ctlr = spi_alloc_slave(&pdev->dev,
+	if (target_mode)
+		ctlr = spi_alloc_target(&pdev->dev,
 				sizeof(struct rockchip_spi));
 	else
-		ctlr = spi_alloc_master(&pdev->dev,
+		ctlr = spi_alloc_host(&pdev->dev,
 				sizeof(struct rockchip_spi));
 
 	if (!ctlr)
@@ -854,9 +854,9 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->auto_runtime_pm = true;
 	ctlr->bus_num = pdev->id;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
-	if (slave_mode) {
+	if (target_mode) {
 		ctlr->mode_bits |= SPI_NO_CS;
-		ctlr->slave_abort = rockchip_spi_slave_abort;
+		ctlr->target_abort = rockchip_spi_target_abort;
 	} else {
 		ctlr->flags = SPI_CONTROLLER_GPIO_SS;
 		ctlr->max_native_cs = ROCKCHIP_SPI_MAX_CS_NUM;
@@ -911,7 +911,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	case ROCKCHIP_SPI_VER2_TYPE2:
 		rs->cs_high_supported = true;
 		ctlr->mode_bits |= SPI_CS_HIGH;
-		if (ctlr->can_dma && slave_mode)
+		if (ctlr->can_dma && target_mode)
 			rs->cs_inactive = true;
 		else
 			rs->cs_inactive = false;
-- 
2.25.1

