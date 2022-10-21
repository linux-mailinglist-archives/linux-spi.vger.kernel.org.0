Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0A6077EA
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJUNLY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJUNLW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:11:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684624E42C
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:10:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1olrna-0002Ri-VR
        for linux-spi@vger.kernel.org; Fri, 21 Oct 2022 15:10:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6E7041060D7
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 13:10:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A411E1060CF;
        Fri, 21 Oct 2022 13:10:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a4d18a8a;
        Fri, 21 Oct 2022 13:10:51 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     kernel@pengutronix.de, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH] spi: spi-imx: remove unused struct spi_imx_devtype_data::disable_dma callback
Date:   Fri, 21 Oct 2022 15:10:51 +0200
Message-Id: <20221021131051.1777984-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In commit 7a908832ace7 ("spi: imx: add fallback feature") the last
user of the struct spi_imx_devtype_data::disable_dma callback was
removed. However the disable_dma member of struct spi_imx_devtype_data
and the callback itself was not removed.

Remove struct spi_imx_devtype_data::disable_dma and mx51_disable_dma()
as they are unused.

Cc: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-imx.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 30d82cc7300b..a4bda03d3a8e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -77,7 +77,6 @@ struct spi_imx_devtype_data {
 	void (*reset)(struct spi_imx_data *spi_imx);
 	void (*setup_wml)(struct spi_imx_data *spi_imx);
 	void (*disable)(struct spi_imx_data *spi_imx);
-	void (*disable_dma)(struct spi_imx_data *spi_imx);
 	bool has_dmamode;
 	bool has_slavemode;
 	unsigned int fifo_size;
@@ -497,11 +496,6 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
-static void mx51_disable_dma(struct spi_imx_data *spi_imx)
-{
-	writel(0, spi_imx->base + MX51_ECSPI_DMA);
-}
-
 static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 {
 	u32 ctrl;
@@ -1043,7 +1037,6 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
 	.setup_wml = mx51_setup_wml,
-	.disable_dma = mx51_disable_dma,
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
@@ -1058,7 +1051,6 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.prepare_transfer = mx51_ecspi_prepare_transfer,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
-	.disable_dma = mx51_disable_dma,
 	.reset = mx51_ecspi_reset,
 	.fifo_size = 64,
 	.has_dmamode = true,
-- 
2.35.1


