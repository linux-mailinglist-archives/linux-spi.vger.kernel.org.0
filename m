Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8B517644
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 20:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386795AbiEBSFq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386791AbiEBSFp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 14:05:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60D113D
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 11:02:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlaNC-00045o-7W
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 20:02:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A79B873648
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 18:02:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C7EE97362B;
        Mon,  2 May 2022 18:02:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 89a2239c;
        Mon, 2 May 2022 17:54:59 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Baruch Siach <baruch@tkos.co.il>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 7/9] spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller
Date:   Mon,  2 May 2022 19:54:55 +0200
Message-Id: <20220502175457.1977983-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502175457.1977983-1-mkl@pengutronix.de>
References: <20220502175457.1977983-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There's no need to embed the struct spi_bitbang into our private
data (struct spi_imx_data), the spi core is flexible enough, so that
we only need a pointer to the allocated struct spi_controller.

This is also a preparation patch to add PIO based polling support to
the driver.

Co-developed-by: David Jander <david@protonic.nl>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/Kconfig   |  1 -
 drivers/spi/spi-imx.c | 58 +++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f09aff3cca1..f56fa715d4e7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -414,7 +414,6 @@ config SPI_IMG_SPFI
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC || COMPILE_TEST
-	select SPI_BITBANG
 	help
 	  This enables support for the Freescale i.MX SPI controllers.
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9defc55707c7..894801ed182b 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -18,7 +18,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -86,7 +85,7 @@ struct spi_imx_devtype_data {
 };
 
 struct spi_imx_data {
-	struct spi_bitbang bitbang;
+	struct spi_controller *controller;
 	struct device *dev;
 
 	struct completion xfer_done;
@@ -580,7 +579,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * the SPI communication as the device on the other end would consider
 	 * the change of SCLK polarity as a clock tick already.
 	 *
-	 * Because spi_imx->spi_bus_clk is only set in bitbang prepare_message
+	 * Because spi_imx->spi_bus_clk is only set in prepare_message
 	 * callback, iterate over all the transfers in spi_message, find the
 	 * one with lowest bus frequency, and use that bus frequency for the
 	 * delay calculation. In case all transfers have speed_hz == 0, then
@@ -1261,7 +1260,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->dynamic_burst = 0;
 	}
 
-	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
+	if (spi_imx_can_dma(spi_imx->controller, spi, t))
 		spi_imx->usedma = true;
 	else
 		spi_imx->usedma = false;
@@ -1282,7 +1281,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 static void spi_imx_sdma_exit(struct spi_imx_data *spi_imx)
 {
-	struct spi_controller *controller = spi_imx->bitbang.master;
+	struct spi_controller *controller = spi_imx->controller;
 
 	if (controller->dma_rx) {
 		dma_release_channel(controller->dma_rx);
@@ -1324,7 +1323,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	init_completion(&spi_imx->dma_tx_completion);
 	controller->can_dma = spi_imx_can_dma;
 	controller->max_dma_len = MAX_SDMA_BD_BYTES;
-	spi_imx->bitbang.master->flags = SPI_CONTROLLER_MUST_RX |
+	spi_imx->controller->flags = SPI_CONTROLLER_MUST_RX |
 					 SPI_CONTROLLER_MUST_TX;
 
 	return 0;
@@ -1367,7 +1366,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
 	unsigned long timeout;
-	struct spi_controller *controller = spi_imx->bitbang.master;
+	struct spi_controller *controller = spi_imx->controller;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
 	unsigned int bytes_per_word, i;
@@ -1450,7 +1449,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		return -ETIMEDOUT;
 	}
 
-	return transfer->len;
+	return 0;
 /* fallback to pio */
 dma_failure_no_start:
 	transfer->error |= SPI_TRANS_FAIL_NO_START;
@@ -1486,14 +1485,14 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
-	return transfer->len;
+	return 0;
 }
 
 static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 				      struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
-	int ret = transfer->len;
+	int ret = 0;
 
 	if (is_imx53_ecspi(spi_imx) &&
 	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
@@ -1533,11 +1532,13 @@ static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 	return ret;
 }
 
-static int spi_imx_transfer(struct spi_device *spi,
+static int spi_imx_transfer_one(struct spi_controller *controller,
+				struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 
+	spi_imx_setupxfer(spi, transfer);
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
 
 	/* flush rxfifo before transfer */
@@ -1642,7 +1643,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	controller->use_gpio_descriptors = true;
 
 	spi_imx = spi_controller_get_devdata(controller);
-	spi_imx->bitbang.master = controller;
+	spi_imx->controller = controller;
 	spi_imx->dev = &pdev->dev;
 	spi_imx->slave_mode = slave_mode;
 
@@ -1659,20 +1660,20 @@ static int spi_imx_probe(struct platform_device *pdev)
 	else
 		controller->num_chipselect = 3;
 
-	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
-	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
-	spi_imx->bitbang.master->setup = spi_imx_setup;
-	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
-	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
-	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
-	spi_imx->bitbang.master->slave_abort = spi_imx_slave_abort;
-	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	spi_imx->controller->transfer_one = spi_imx_transfer_one;
+	spi_imx->controller->setup = spi_imx_setup;
+	spi_imx->controller->cleanup = spi_imx_cleanup;
+	spi_imx->controller->prepare_message = spi_imx_prepare_message;
+	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
+	spi_imx->controller->slave_abort = spi_imx_slave_abort;
+	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
+		spi_imx->controller->mode_bits |= SPI_LOOP | SPI_READY;
 
 	if (is_imx51_ecspi(spi_imx) || is_imx53_ecspi(spi_imx))
-		spi_imx->bitbang.master->mode_bits |= SPI_RX_CPHA_FLIP;
+		spi_imx->controller->mode_bits |= SPI_RX_CPHA_FLIP;
 
 	if (is_imx51_ecspi(spi_imx) &&
 	    device_property_read_u32(&pdev->dev, "cs-gpios", NULL))
@@ -1681,7 +1682,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 		 * setting the burst length to the word size. This is
 		 * considerably faster than manually controlling the CS.
 		 */
-		spi_imx->bitbang.master->mode_bits |= SPI_CS_WORD;
+		spi_imx->controller->mode_bits |= SPI_CS_WORD;
 
 	spi_imx->spi_drctl = spi_drctl;
 
@@ -1754,10 +1755,10 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
 	controller->dev.of_node = pdev->dev.of_node;
-	ret = spi_bitbang_start(&spi_imx->bitbang);
+	ret = spi_register_controller(controller);
 	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "bitbang start failed\n");
-		goto out_bitbang_start;
+		dev_err_probe(&pdev->dev, ret, "register controller failed\n");
+		goto out_register_controller;
 	}
 
 	pm_runtime_mark_last_busy(spi_imx->dev);
@@ -1765,7 +1766,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	return ret;
 
-out_bitbang_start:
+out_register_controller:
 	if (spi_imx->devtype_data->has_dmamode)
 		spi_imx_sdma_exit(spi_imx);
 out_runtime_pm_put:
@@ -1788,7 +1789,7 @@ static int spi_imx_remove(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
-	spi_bitbang_stop(&spi_imx->bitbang);
+	spi_unregister_controller(controller);
 
 	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
@@ -1803,7 +1804,6 @@ static int spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
-	spi_controller_put(controller);
 
 	return 0;
 }
-- 
2.35.1


