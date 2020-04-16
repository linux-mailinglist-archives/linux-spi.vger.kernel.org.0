Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9411ABDC3
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504747AbgDPKTQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 06:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504744AbgDPKSq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 06:18:46 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7727C061A10
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2020 03:18:42 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by andre.telenet-ops.be with bizsmtp
        id TNJh220024dKHqf01NJhiA; Thu, 16 Apr 2020 12:18:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1bV-0001RZ-17; Thu, 16 Apr 2020 12:18:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1bU-0003nv-Vu; Thu, 16 Apr 2020 12:18:41 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: spidev: Add support for Octal mode data transfers
Date:   Thu, 16 Apr 2020 12:18:34 +0200
Message-Id: <20200416101835.14573-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416101835.14573-1-geert+renesas@glider.be>
References: <20200416101835.14573-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Include the flags for Octal mode data transfers in the mask, so
userspace can set them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 80dd1025b9530493..d753df700e9ea3cc 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -62,7 +62,8 @@ static DECLARE_BITMAP(minors, N_SPI_MINORS);
 #define SPI_MODE_MASK		(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH \
 				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
-				| SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)
+				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
+				| SPI_RX_QUAD | SPI_RX_OCTAL)
 
 struct spidev_data {
 	dev_t			devt;
-- 
2.17.1

