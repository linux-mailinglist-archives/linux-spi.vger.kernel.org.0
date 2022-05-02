Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D37517641
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386794AbiEBSFa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386793AbiEBSF2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 14:05:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14365BC84
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 11:01:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nlaMv-0003qA-GH
        for linux-spi@vger.kernel.org; Mon, 02 May 2022 20:01:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EA2EC7361A
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 18:01:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 596AD735FE;
        Mon,  2 May 2022 18:01:48 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a4ec69c;
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
Subject: [PATCH v1 8/9] spi: spi-imx: add PIO polling support
Date:   Mon,  2 May 2022 19:54:56 +0200
Message-Id: <20220502175457.1977983-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502175457.1977983-1-mkl@pengutronix.de>
References: <20220502175457.1977983-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The driver supports several modes, one of them is PIO/IRQ
"spi_imx_pio_transfer()". The data is exchanged with the IP core using
PIO, an IRQ is setup to signal empty/full FIFOs and the end of the
transfer. The IRQ and scheduling overhead for short transfers is
significant. Using polling instead of IRQs can be beneficial to reduce
the overall CPU load, especially on small transfer workloads.

On an imx6 single core, a given RX workload of the mcp251xfd driver
results in 40% CPU load. Using polling mode reduces the CPU load to
30%.

This patch adds PIO polling support to the driver. For transfers with
a duration of less than 30 µs the polling mode instead of IRQ based
PIO mode is used. 30 µs seems to be a good compromise, which is used
the by the SPI drivers for the raspberry Pi (spi-bcm2835,
spi-bcm2835), too.

Co-developed-by: David Jander <david@protonic.nl>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 894801ed182b..fe2305e6e38e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -31,6 +31,12 @@ static bool use_dma = true;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Enable usage of DMA when available (default)");
 
+/* define polling limits */
+static unsigned int polling_limit_us = 30;
+module_param(polling_limit_us, uint, 0664);
+MODULE_PARM_DESC(polling_limit_us,
+		 "time in us to run a transfer in polling mode\n");
+
 #define MXC_RPM_TIMEOUT		2000 /* 2000ms */
 
 #define MXC_CSPIRXDATA		0x00
@@ -1488,6 +1494,54 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static int spi_imx_poll_transfer(struct spi_device *spi,
+				 struct spi_transfer *transfer)
+{
+	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
+	unsigned long timeout;
+
+	spi_imx->tx_buf = transfer->tx_buf;
+	spi_imx->rx_buf = transfer->rx_buf;
+	spi_imx->count = transfer->len;
+	spi_imx->txfifo = 0;
+	spi_imx->remainder = 0;
+
+	/* fill in the fifo before timeout calculations if we are
+	 * interrupted here, then the data is getting transferred by
+	 * the HW while we are interrupted
+	 */
+	spi_imx_push(spi_imx);
+
+	timeout = spi_imx_calculate_timeout(spi_imx, transfer->len) + jiffies;
+	while (spi_imx->txfifo) {
+		/* RX */
+		while (spi_imx->txfifo &&
+		       spi_imx->devtype_data->rx_available(spi_imx)) {
+			spi_imx->rx(spi_imx);
+			spi_imx->txfifo--;
+		}
+
+		/* TX */
+		if (spi_imx->count) {
+			spi_imx_push(spi_imx);
+			continue;
+		}
+
+		if (spi_imx->txfifo &&
+		    time_after(jiffies, timeout)) {
+
+			dev_err_ratelimited(&spi->dev,
+					    "timeout period reached: jiffies: %lu- falling back to interrupt mode\n",
+					    jiffies - timeout);
+
+			/* fall back to interrupt mode */
+			return spi_imx_pio_transfer(spi, transfer);
+		}
+	}
+
+	return 0;
+}
+
 static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 				      struct spi_transfer *transfer)
 {
@@ -1537,6 +1591,7 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
+	unsigned long hz_per_byte, byte_limit;
 
 	spi_imx_setupxfer(spi, transfer);
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
@@ -1548,6 +1603,17 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	if (spi_imx->slave_mode)
 		return spi_imx_pio_transfer_slave(spi, transfer);
 
+	/*
+	 * Calculate the estimated time in us the transfer runs. Find
+	 * the number of Hz per byte per polling limit.
+	 */
+	hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
+	byte_limit = hz_per_byte ? transfer->effective_speed_hz / hz_per_byte : 1;
+
+	/* run in polling mode for short transfers */
+	if (transfer->len < byte_limit)
+		return spi_imx_poll_transfer(spi, transfer);
+
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
 
-- 
2.35.1


