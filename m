Return-Path: <linux-spi+bounces-56-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C177FB5A6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562BE1C2102D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EED48CEF;
	Tue, 28 Nov 2023 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39C1A5
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:23 -0800 (PST)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SfcWf6FNrzvRD4;
	Tue, 28 Nov 2023 17:25:50 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:20 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 05/26] spi: stm32: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:10 +0800
Message-ID: <20231128093031.3707034-6-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Change legacy name master/slave to modern name host/target.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-stm32.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 94df3836834c..f48e4dcc29fc 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -180,7 +180,7 @@
 #define SPI_DMA_MIN_BYTES	16
 
 /* STM32 SPI driver helpers */
-#define STM32_SPI_MASTER_MODE(stm32_spi) (!(stm32_spi)->device_mode)
+#define STM32_SPI_HOST_MODE(stm32_spi) (!(stm32_spi)->device_mode)
 #define STM32_SPI_DEVICE_MODE(stm32_spi) ((stm32_spi)->device_mode)
 
 /**
@@ -229,7 +229,7 @@ struct stm32_spi;
  * @get_fifo_size: routine to get fifo size
  * @get_bpw_mask: routine to get bits per word mask
  * @disable: routine to disable controller
- * @config: routine to configure controller as SPI Master
+ * @config: routine to configure controller as SPI Host
  * @set_bpw: routine to configure registers to for bits per word
  * @set_mode: routine to configure registers to desired mode
  * @set_data_idleness: optional routine to configure registers to desired idle
@@ -287,7 +287,7 @@ struct stm32_spi_cfg {
  * @lock: prevent I/O concurrent access
  * @irq: SPI controller interrupt line
  * @fifo_size: size of the embedded fifo in bytes
- * @cur_midi: master inter-data idleness in ns
+ * @cur_midi: host inter-data idleness in ns
  * @cur_speed: speed configured in Hz
  * @cur_half_period: time of a half bit in us
  * @cur_bpw: number of bits in a single SPI data frame
@@ -1064,7 +1064,7 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 	unsigned long flags;
 	u32 clrb = 0, setb = 0;
 
-	/* SPI slave device may need time between data frames */
+	/* SPI target device may need time between data frames */
 	spi->cur_midi = 0;
 	if (np && !of_property_read_u32(np, "st,spi-midi-ns", &spi->cur_midi))
 		dev_dbg(spi->dev, "%dns inter-data idleness\n", spi->cur_midi);
@@ -1279,7 +1279,7 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
 
-	if (STM32_SPI_MASTER_MODE(spi))
+	if (STM32_SPI_HOST_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 
 	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
@@ -1343,7 +1343,7 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_enable(spi);
 
-	if (STM32_SPI_MASTER_MODE(spi))
+	if (STM32_SPI_HOST_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }
 
@@ -1516,7 +1516,7 @@ static void stm32h7_spi_set_bpw(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_set_mbr - Configure baud rate divisor in master mode
+ * stm32_spi_set_mbr - Configure baud rate divisor in host mode
  * @spi: pointer to the spi controller data structure
  * @mbrdiv: baud rate divisor value
  */
@@ -1628,7 +1628,7 @@ static int stm32h7_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 
 /**
  * stm32h7_spi_data_idleness - configure minimum time delay inserted between two
- *			       consecutive data frames in master mode
+ *			       consecutive data frames in host mode
  * @spi: pointer to the spi controller data structure
  * @len: transfer len
  */
@@ -1697,7 +1697,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	spi->cfg->set_bpw(spi);
 
 	/* Update spi->cur_speed with real clock speed */
-	if (STM32_SPI_MASTER_MODE(spi)) {
+	if (STM32_SPI_HOST_MODE(spi)) {
 		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
 					    spi->cfg->baud_rate_div_min,
 					    spi->cfg->baud_rate_div_max);
@@ -1717,7 +1717,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 	spi->cur_comm = comm_type;
 
-	if (STM32_SPI_MASTER_MODE(spi) && spi->cfg->set_data_idleness)
+	if (STM32_SPI_HOST_MODE(spi) && spi->cfg->set_data_idleness)
 		spi->cfg->set_data_idleness(spi, transfer->len);
 
 	if (spi->cur_bpw <= 8)
@@ -1738,7 +1738,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	dev_dbg(spi->dev,
 		"data frame of %d-bit, data packet of %d data frames\n",
 		spi->cur_bpw, spi->cur_fthlv);
-	if (STM32_SPI_MASTER_MODE(spi))
+	if (STM32_SPI_HOST_MODE(spi))
 		dev_dbg(spi->dev, "speed set to %dHz\n", spi->cur_speed);
 	dev_dbg(spi->dev, "transfer of %d bytes (%d data frames)\n",
 		spi->cur_xferlen, nb_words);
@@ -1803,7 +1803,7 @@ static int stm32_spi_unprepare_msg(struct spi_controller *ctrl,
 }
 
 /**
- * stm32fx_spi_config - Configure SPI controller as SPI master
+ * stm32fx_spi_config - Configure SPI controller as SPI host
  * @spi: pointer to the spi controller data structure
  */
 static int stm32fx_spi_config(struct stm32_spi *spi)
@@ -1819,8 +1819,8 @@ static int stm32fx_spi_config(struct stm32_spi *spi)
 	/*
 	 * - SS input value high
 	 * - transmitter half duplex direction
-	 * - Set the master mode (default Motorola mode)
-	 * - Consider 1 master/n slaves configuration and
+	 * - Set the host mode (default Motorola mode)
+	 * - Consider 1 host/n targets configuration and
 	 *   SS input value is determined by the SSI bit
 	 */
 	stm32_spi_set_bits(spi, STM32FX_SPI_CR1, STM32FX_SPI_CR1_SSI |
@@ -1860,8 +1860,8 @@ static int stm32h7_spi_config(struct stm32_spi *spi)
 		cr1 |= STM32H7_SPI_CR1_HDDIR | STM32H7_SPI_CR1_MASRX | STM32H7_SPI_CR1_SSI;
 
 		/*
-		 * - Set the master mode (default Motorola mode)
-		 * - Consider 1 master/n devices configuration and
+		 * - Set the host mode (default Motorola mode)
+		 * - Consider 1 host/n devices configuration and
 		 *   SS input value is determined by the SSI bit
 		 * - keep control of all associated GPIOs
 		 */
@@ -1977,9 +1977,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	}
 
 	if (device_mode)
-		ctrl = devm_spi_alloc_slave(&pdev->dev, sizeof(struct stm32_spi));
+		ctrl = devm_spi_alloc_target(&pdev->dev, sizeof(struct stm32_spi));
 	else
-		ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
+		ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(struct stm32_spi));
 	if (!ctrl) {
 		dev_err(&pdev->dev, "spi controller allocation failed\n");
 		return -ENOMEM;
@@ -2070,7 +2070,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	ctrl->unprepare_message = stm32_spi_unprepare_msg;
 	ctrl->flags = spi->cfg->flags;
 	if (STM32_SPI_DEVICE_MODE(spi))
-		ctrl->slave_abort = stm32h7_spi_device_abort;
+		ctrl->target_abort = stm32h7_spi_device_abort;
 
 	spi->dma_tx = dma_request_chan(spi->dev, "tx");
 	if (IS_ERR(spi->dma_tx)) {
@@ -2117,7 +2117,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	dev_info(&pdev->dev, "driver initialized (%s mode)\n",
-		 STM32_SPI_MASTER_MODE(spi) ? "master" : "device");
+		 STM32_SPI_HOST_MODE(spi) ? "host" : "device");
 
 	return 0;
 
-- 
2.25.1


