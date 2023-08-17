Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5616477F01E
	for <lists+linux-spi@lfdr.de>; Thu, 17 Aug 2023 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348086AbjHQFIA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Aug 2023 01:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348085AbjHQFHi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Aug 2023 01:07:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D026A5
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 22:07:36 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRCb05H40ztSBc;
        Thu, 17 Aug 2023 13:03:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 13:07:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 13:07:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 19/23] spi: sh-msiof: switch to use modern name
Date:   Thu, 17 Aug 2023 13:03:28 +0800
Message-ID: <20230817050332.1274751-20-yangyingliang@huawei.com>
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

Change legacy name master/slave to modern name host/target.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sh-msiof.c   | 52 ++++++++++++++++++------------------
 include/linux/spi/sh_msiof.h |  4 +--
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 5c75b5c58d97..4415008cee7c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -54,7 +54,7 @@ struct sh_msiof_spi_priv {
 	dma_addr_t rx_dma_addr;
 	bool native_cs_inited;
 	bool native_cs_high;
-	bool slave_aborted;
+	bool target_aborted;
 };
 
 #define MAX_SS	3	/* Maximum number of native chip selects */
@@ -361,7 +361,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p, u32 ss,
 	tmp |= !cs_high << SIMDR1_SYNCAC_SHIFT;
 	tmp |= lsb_first << SIMDR1_BITLSB_SHIFT;
 	tmp |= sh_msiof_spi_get_dtdl_and_syncdl(p);
-	if (spi_controller_is_slave(p->ctlr)) {
+	if (spi_controller_is_target(p->ctlr)) {
 		sh_msiof_write(p, SITMDR1, tmp | SITMDR1_PCON);
 	} else {
 		sh_msiof_write(p, SITMDR1,
@@ -553,7 +553,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		spi_controller_get_devdata(spi->controller);
 	u32 clr, set, tmp;
 
-	if (spi_get_csgpiod(spi, 0) || spi_controller_is_slave(p->ctlr))
+	if (spi_get_csgpiod(spi, 0) || spi_controller_is_target(p->ctlr))
 		return 0;
 
 	if (p->native_cs_inited &&
@@ -602,11 +602,11 @@ static int sh_msiof_prepare_message(struct spi_controller *ctlr,
 
 static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 {
-	bool slave = spi_controller_is_slave(p->ctlr);
+	bool target = spi_controller_is_target(p->ctlr);
 	int ret = 0;
 
 	/* setup clock and rx/tx signals */
-	if (!slave)
+	if (!target)
 		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_TSCKE);
 	if (rx_buf && !ret)
 		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_RXE);
@@ -614,7 +614,7 @@ static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_TXE);
 
 	/* start by setting frame bit */
-	if (!ret && !slave)
+	if (!ret && !target)
 		ret = sh_msiof_modify_ctr_wait(p, 0, SICTR_TFSE);
 
 	return ret;
@@ -622,27 +622,27 @@ static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 
 static int sh_msiof_spi_stop(struct sh_msiof_spi_priv *p, void *rx_buf)
 {
-	bool slave = spi_controller_is_slave(p->ctlr);
+	bool target = spi_controller_is_target(p->ctlr);
 	int ret = 0;
 
 	/* shut down frame, rx/tx and clock signals */
-	if (!slave)
+	if (!target)
 		ret = sh_msiof_modify_ctr_wait(p, SICTR_TFSE, 0);
 	if (!ret)
 		ret = sh_msiof_modify_ctr_wait(p, SICTR_TXE, 0);
 	if (rx_buf && !ret)
 		ret = sh_msiof_modify_ctr_wait(p, SICTR_RXE, 0);
-	if (!ret && !slave)
+	if (!ret && !target)
 		ret = sh_msiof_modify_ctr_wait(p, SICTR_TSCKE, 0);
 
 	return ret;
 }
 
-static int sh_msiof_slave_abort(struct spi_controller *ctlr)
+static int sh_msiof_target_abort(struct spi_controller *ctlr)
 {
 	struct sh_msiof_spi_priv *p = spi_controller_get_devdata(ctlr);
 
-	p->slave_aborted = true;
+	p->target_aborted = true;
 	complete(&p->done);
 	complete(&p->done_txdma);
 	return 0;
@@ -651,9 +651,9 @@ static int sh_msiof_slave_abort(struct spi_controller *ctlr)
 static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p,
 					struct completion *x)
 {
-	if (spi_controller_is_slave(p->ctlr)) {
+	if (spi_controller_is_target(p->ctlr)) {
 		if (wait_for_completion_interruptible(x) ||
-		    p->slave_aborted) {
+		    p->target_aborted) {
 			dev_dbg(&p->pdev->dev, "interrupted\n");
 			return -EINTR;
 		}
@@ -699,7 +699,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 		tx_fifo(p, tx_buf, words, fifo_shift);
 
 	reinit_completion(&p->done);
-	p->slave_aborted = false;
+	p->target_aborted = false;
 
 	ret = sh_msiof_spi_start(p, rx_buf);
 	if (ret) {
@@ -796,7 +796,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	reinit_completion(&p->done);
 	if (tx)
 		reinit_completion(&p->done_txdma);
-	p->slave_aborted = false;
+	p->target_aborted = false;
 
 	/* Now start DMA */
 	if (rx)
@@ -925,7 +925,7 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	sh_msiof_spi_reset_regs(p);
 
 	/* setup clocks (clock already enabled in chipselect()) */
-	if (!spi_controller_is_slave(p->ctlr))
+	if (!spi_controller_is_target(p->ctlr))
 		sh_msiof_spi_set_clk_regs(p, t);
 
 	while (ctlr->dma_tx && len > 15) {
@@ -1101,11 +1101,11 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 	if (!info)
 		return NULL;
 
-	info->mode = of_property_read_bool(np, "spi-slave") ? MSIOF_SPI_SLAVE
-							    : MSIOF_SPI_MASTER;
+	info->mode = of_property_read_bool(np, "spi-slave") ? MSIOF_SPI_TARGET
+							    : MSIOF_SPI_HOST;
 
 	/* Parse the MSIOF properties */
-	if (info->mode == MSIOF_SPI_MASTER)
+	if (info->mode == MSIOF_SPI_HOST)
 		of_property_read_u32(np, "num-cs", &num_cs);
 	of_property_read_u32(np, "renesas,tx-fifo-size",
 					&info->tx_fifo_override);
@@ -1175,7 +1175,7 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 	struct device *tx_dev, *rx_dev;
 
 	if (dev->of_node) {
-		/* In the OF case we will get the slave IDs from the DT */
+		/* In the OF case we will get the target IDs from the DT */
 		dma_tx_id = 0;
 		dma_rx_id = 0;
 	} else if (info && info->dma_tx_id && info->dma_rx_id) {
@@ -1279,12 +1279,12 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (info->mode == MSIOF_SPI_SLAVE)
-		ctlr = spi_alloc_slave(&pdev->dev,
-				       sizeof(struct sh_msiof_spi_priv));
+	if (info->mode == MSIOF_SPI_TARGET)
+		ctlr = spi_alloc_target(&pdev->dev,
+				        sizeof(struct sh_msiof_spi_priv));
 	else
-		ctlr = spi_alloc_master(&pdev->dev,
-					sizeof(struct sh_msiof_spi_priv));
+		ctlr = spi_alloc_host(&pdev->dev,
+				      sizeof(struct sh_msiof_spi_priv));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
@@ -1347,7 +1347,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->setup = sh_msiof_spi_setup;
 	ctlr->prepare_message = sh_msiof_prepare_message;
-	ctlr->slave_abort = sh_msiof_slave_abort;
+	ctlr->target_abort = sh_msiof_target_abort;
 	ctlr->bits_per_word_mask = chipdata->bits_per_word_mask;
 	ctlr->auto_runtime_pm = true;
 	ctlr->transfer_one = sh_msiof_transfer_one;
diff --git a/include/linux/spi/sh_msiof.h b/include/linux/spi/sh_msiof.h
index dc2a0cbd210d..f950d280461b 100644
--- a/include/linux/spi/sh_msiof.h
+++ b/include/linux/spi/sh_msiof.h
@@ -3,8 +3,8 @@
 #define __SPI_SH_MSIOF_H__
 
 enum {
-	MSIOF_SPI_MASTER,
-	MSIOF_SPI_SLAVE,
+	MSIOF_SPI_HOST,
+	MSIOF_SPI_TARGET,
 };
 
 struct sh_msiof_spi_info {
-- 
2.25.1

