Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2198249EDA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgHSM7v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgHSM7a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:59:30 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DFC061344
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2020 05:59:12 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id HQz62300G4C55Sk01Qz6yB; Wed, 19 Aug 2020 14:59:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0002bw-4s; Wed, 19 Aug 2020 14:59:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NgI-0005Ss-3u; Wed, 19 Aug 2020 14:59:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 7/7] spi: rspi: Fill in controller speed limits
Date:   Wed, 19 Aug 2020 14:59:04 +0200
Message-Id: <20200819125904.20938-8-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
References: <20200819125904.20938-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fill in the controller speed limits, so the SPI core can use them for
validating SPI transfers, and adjusting them where needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/spi/spi-rspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2b5334e22ae421b5..e39fd38f5180efb3 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -243,6 +243,8 @@ struct spi_ops {
 	int (*transfer_one)(struct spi_controller *ctlr,
 			    struct spi_device *spi, struct spi_transfer *xfer);
 	u16 extra_mode_bits;
+	u16 min_div;
+	u16 max_div;
 	u16 flags;
 	u16 fifo_size;
 	u8 num_hw_ss;
@@ -1181,6 +1183,8 @@ static int rspi_remove(struct platform_device *pdev)
 static const struct spi_ops rspi_ops = {
 	.set_config_register =	rspi_set_config_register,
 	.transfer_one =		rspi_transfer_one,
+	.min_div =		2,
+	.max_div =		4096,
 	.flags =		SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,
 	.num_hw_ss =		2,
@@ -1189,6 +1193,8 @@ static const struct spi_ops rspi_ops = {
 static const struct spi_ops rspi_rz_ops = {
 	.set_config_register =	rspi_rz_set_config_register,
 	.transfer_one =		rspi_rz_transfer_one,
+	.min_div =		2,
+	.max_div =		4096,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
 	.num_hw_ss =		1,
@@ -1199,6 +1205,8 @@ static const struct spi_ops qspi_ops = {
 	.transfer_one =		qspi_transfer_one,
 	.extra_mode_bits =	SPI_TX_DUAL | SPI_TX_QUAD |
 				SPI_RX_DUAL | SPI_RX_QUAD,
+	.min_div =		1,
+	.max_div =		4080,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		32,
 	.num_hw_ss =		1,
@@ -1260,6 +1268,7 @@ static int rspi_probe(struct platform_device *pdev)
 	int ret;
 	const struct rspi_plat_data *rspi_pd;
 	const struct spi_ops *ops;
+	unsigned long clksrc;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct rspi_data));
 	if (ctlr == NULL)
@@ -1312,6 +1321,9 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->unprepare_message = rspi_unprepare_message;
 	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
 			  SPI_LOOP | ops->extra_mode_bits;
+	clksrc = clk_get_rate(rspi->clk);
+	ctlr->min_speed_hz = DIV_ROUND_UP(clksrc, ops->max_div);
+	ctlr->max_speed_hz = DIV_ROUND_UP(clksrc, ops->min_div);
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.17.1

