Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B503F783779
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHVBiw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjHVBiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1795F110
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:42 -0700 (PDT)
Received: from dggpemm100017.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBjl1z7GzNn9n;
        Tue, 22 Aug 2023 09:35:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100017.china.huawei.com (7.185.36.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:41 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 10/24] spi: geni-qcom: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:57 +0800
Message-ID: <20230822013511.4161475-11-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-geni-qcom.c | 96 ++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f4f376a8351b..53d3cabfcf58 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -145,10 +145,10 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
-static void handle_se_timeout(struct spi_master *spi,
-				struct spi_message *msg)
+static void handle_se_timeout(struct spi_controller *spi,
+			      struct spi_message *msg)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	unsigned long time_left;
 	struct geni_se *se = &mas->se;
 	const struct spi_transfer *xfer;
@@ -160,9 +160,9 @@ static void handle_se_timeout(struct spi_master *spi,
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 
-	if (spi->slave) {
+	if (spi->target) {
 		/*
-		 * skip CMD Cancel sequnece since spi slave
+		 * skip CMD Cancel sequnece since spi target
 		 * doesn`t support CMD Cancel sequnece
 		 */
 		spin_unlock_irq(&mas->lock);
@@ -225,17 +225,17 @@ static void handle_se_timeout(struct spi_master *spi,
 	}
 }
 
-static void handle_gpi_timeout(struct spi_master *spi, struct spi_message *msg)
+static void handle_gpi_timeout(struct spi_controller *spi, struct spi_message *msg)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
 	dmaengine_terminate_sync(mas->tx);
 	dmaengine_terminate_sync(mas->rx);
 }
 
-static void spi_geni_handle_err(struct spi_master *spi, struct spi_message *msg)
+static void spi_geni_handle_err(struct spi_controller *spi, struct spi_message *msg)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
 	switch (mas->cur_xfer_mode) {
 	case GENI_SE_FIFO:
@@ -286,8 +286,8 @@ static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
 
 static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
-	struct spi_master *spi = dev_get_drvdata(mas->dev);
+	struct spi_geni_master *mas = spi_controller_get_devdata(slv->controller);
+	struct spi_controller *spi = dev_get_drvdata(mas->dev);
 	struct geni_se *se = &mas->se;
 	unsigned long time_left;
 
@@ -395,9 +395,9 @@ static int geni_spi_set_clock_and_bw(struct spi_geni_master *mas,
 }
 
 static int setup_fifo_params(struct spi_device *spi_slv,
-					struct spi_master *spi)
+					struct spi_controller *spi)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct geni_se *se = &mas->se;
 	u32 loopback_cfg = 0, cpol = 0, cpha = 0, demux_output_inv = 0;
 	u32 demux_sel;
@@ -434,7 +434,7 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 static void
 spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 {
-	struct spi_master *spi = cb;
+	struct spi_controller *spi = cb;
 
 	spi->cur_msg->status = -EIO;
 	if (result->result != DMA_TRANS_NOERROR) {
@@ -454,7 +454,7 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 }
 
 static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
-			  struct spi_device *spi_slv, struct spi_master *spi)
+			  struct spi_device *spi_slv, struct spi_controller *spi)
 {
 	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	struct dma_slave_config config = {};
@@ -560,14 +560,14 @@ static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
 static bool geni_can_dma(struct spi_controller *ctlr,
 			 struct spi_device *slv, struct spi_transfer *xfer)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
+	struct spi_geni_master *mas = spi_controller_get_devdata(slv->controller);
 	u32 len, fifo_size;
 
 	if (mas->cur_xfer_mode == GENI_GPI_DMA)
 		return true;
 
-	/* Set SE DMA mode for SPI slave. */
-	if (ctlr->slave)
+	/* Set SE DMA mode for SPI target. */
+	if (ctlr->target)
 		return true;
 
 	len = get_xfer_len_in_words(xfer, mas);
@@ -579,10 +579,10 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 		return false;
 }
 
-static int spi_geni_prepare_message(struct spi_master *spi,
-					struct spi_message *spi_msg)
+static int spi_geni_prepare_message(struct spi_controller *spi,
+				    struct spi_message *spi_msg)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
 	switch (mas->cur_xfer_mode) {
@@ -657,7 +657,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 
 	proto = geni_se_read_proto(se);
 
-	if (spi->slave) {
+	if (spi->target) {
 		if (proto != GENI_SE_SPI_SLAVE) {
 			dev_err(mas->dev, "Invalid proto %d\n", proto);
 			goto out_pm;
@@ -715,7 +715,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	}
 
 	/* We always control CS manually */
-	if (!spi->slave) {
+	if (!spi->target) {
 		spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
 		spi_tx_cfg &= ~CS_TOGGLE;
 		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
@@ -824,7 +824,7 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
 
 static int setup_se_xfer(struct spi_transfer *xfer,
 				struct spi_geni_master *mas,
-				u16 mode, struct spi_master *spi)
+				u16 mode, struct spi_controller *spi)
 {
 	u32 m_cmd = 0;
 	u32 len;
@@ -913,11 +913,11 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	return ret;
 }
 
-static int spi_geni_transfer_one(struct spi_master *spi,
-				struct spi_device *slv,
-				struct spi_transfer *xfer)
+static int spi_geni_transfer_one(struct spi_controller *spi,
+				 struct spi_device *slv,
+				 struct spi_transfer *xfer)
 {
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
 	if (spi_geni_is_abort_still_pending(mas))
@@ -939,8 +939,8 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 
 static irqreturn_t geni_spi_isr(int irq, void *data)
 {
-	struct spi_master *spi = data;
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_controller *spi = data;
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct geni_se *se = &mas->se;
 	u32 m_irq;
 
@@ -1042,7 +1042,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 static int spi_geni_probe(struct platform_device *pdev)
 {
 	int ret, irq;
-	struct spi_master *spi;
+	struct spi_controller *spi;
 	struct spi_geni_master *mas;
 	void __iomem *base;
 	struct clk *clk;
@@ -1064,12 +1064,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	spi = devm_spi_alloc_master(dev, sizeof(*mas));
+	spi = devm_spi_alloc_host(dev, sizeof(*mas));
 	if (!spi)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, spi);
-	mas = spi_master_get_devdata(spi);
+	mas = spi_controller_get_devdata(spi);
 	mas->irq = irq;
 	mas->dev = dev;
 	mas->se.dev = dev;
@@ -1113,7 +1113,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
-		spi->slave = true;
+		spi->target = true;
 
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
@@ -1135,7 +1135,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	 * for dma (gsi) mode, the gsi will set cs based on params passed in
 	 * TRE
 	 */
-	if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)
+	if (!spi->target && mas->cur_xfer_mode == GENI_SE_FIFO)
 		spi->set_cs = spi_geni_set_cs;
 
 	/*
@@ -1148,7 +1148,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_release_dma;
 
-	ret = spi_register_master(spi);
+	ret = spi_register_controller(spi);
 	if (ret)
 		goto spi_geni_probe_free_irq;
 
@@ -1164,11 +1164,11 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 static void spi_geni_remove(struct platform_device *pdev)
 {
-	struct spi_master *spi = platform_get_drvdata(pdev);
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_controller *spi = platform_get_drvdata(pdev);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
-	spi_unregister_master(spi);
+	spi_unregister_controller(spi);
 
 	spi_geni_release_dma_chan(mas);
 
@@ -1178,8 +1178,8 @@ static void spi_geni_remove(struct platform_device *pdev)
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 {
-	struct spi_master *spi = dev_get_drvdata(dev);
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_controller *spi = dev_get_drvdata(dev);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
 	/* Drop the performance state vote */
@@ -1194,8 +1194,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 
 static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 {
-	struct spi_master *spi = dev_get_drvdata(dev);
-	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	struct spi_controller *spi = dev_get_drvdata(dev);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
 
 	ret = geni_icc_enable(&mas->se);
@@ -1211,30 +1211,30 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 
 static int __maybe_unused spi_geni_suspend(struct device *dev)
 {
-	struct spi_master *spi = dev_get_drvdata(dev);
+	struct spi_controller *spi = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(spi);
+	ret = spi_controller_suspend(spi);
 	if (ret)
 		return ret;
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
-		spi_master_resume(spi);
+		spi_controller_resume(spi);
 
 	return ret;
 }
 
 static int __maybe_unused spi_geni_resume(struct device *dev)
 {
-	struct spi_master *spi = dev_get_drvdata(dev);
+	struct spi_controller *spi = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
-	ret = spi_master_resume(spi);
+	ret = spi_controller_resume(spi);
 	if (ret)
 		pm_runtime_force_suspend(dev);
 
-- 
2.25.1

