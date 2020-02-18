Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301F1162518
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgBRK6P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 05:58:15 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:58188 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgBRK6O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Feb 2020 05:58:14 -0500
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id 4AyC2200K5USYZQ01AyCyx; Tue, 18 Feb 2020 11:58:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j40Zw-0003jM-Hn; Tue, 18 Feb 2020 11:58:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j40Zw-0000Fc-Gc; Tue, 18 Feb 2020 11:58:12 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hoan Nguyen An <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: rspi: Factor out handling of common mode bits
Date:   Tue, 18 Feb 2020 11:58:08 +0100
Message-Id: <20200218105810.902-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218105810.902-1-geert+renesas@glider.be>
References: <20200218105810.902-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Basic SPI features like clock phase/polarity and loopback mode are
common to all RSPI variants.  Factor them out to reduce duplication.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 85575d45901cee1b..7a1e6d524f34a416 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -239,7 +239,7 @@ struct spi_ops {
 	int (*set_config_register)(struct rspi_data *rspi, int access_size);
 	int (*transfer_one)(struct spi_controller *ctlr,
 			    struct spi_device *spi, struct spi_transfer *xfer);
-	u16 mode_bits;
+	u16 extra_mode_bits;
 	u16 flags;
 	u16 fifo_size;
 	u8 num_hw_ss;
@@ -1122,7 +1122,6 @@ static int rspi_remove(struct platform_device *pdev)
 static const struct spi_ops rspi_ops = {
 	.set_config_register =	rspi_set_config_register,
 	.transfer_one =		rspi_transfer_one,
-	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,
 	.num_hw_ss =		2,
@@ -1131,7 +1130,6 @@ static const struct spi_ops rspi_ops = {
 static const struct spi_ops rspi_rz_ops = {
 	.set_config_register =	rspi_rz_set_config_register,
 	.transfer_one =		rspi_rz_transfer_one,
-	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
 	.num_hw_ss =		1,
@@ -1140,8 +1138,7 @@ static const struct spi_ops rspi_rz_ops = {
 static const struct spi_ops qspi_ops = {
 	.set_config_register =	qspi_set_config_register,
 	.transfer_one =		qspi_transfer_one,
-	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP |
-				SPI_TX_DUAL | SPI_TX_QUAD |
+	.extra_mode_bits =	SPI_TX_DUAL | SPI_TX_QUAD |
 				SPI_RX_DUAL | SPI_RX_QUAD,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		32,
@@ -1258,7 +1255,7 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
 	ctlr->unprepare_message = rspi_unprepare_message;
-	ctlr->mode_bits = ops->mode_bits;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LOOP | ops->extra_mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->use_gpio_descriptors = true;
-- 
2.17.1

