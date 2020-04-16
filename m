Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858C1ABDC7
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 12:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504813AbgDPKTr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 06:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504744AbgDPKTW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 06:19:22 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FED9C061A0C
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2020 03:19:22 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by andre.telenet-ops.be with bizsmtp
        id TNEK2200D4dKHqf01NEKWv; Thu, 16 Apr 2020 12:14:19 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1XH-0001My-9v; Thu, 16 Apr 2020 12:14:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1XH-0003ke-7t; Thu, 16 Apr 2020 12:14:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spi-mem: Fix Dual/Quad modes on Octal-capable devices
Date:   Thu, 16 Apr 2020 12:14:18 +0200
Message-Id: <20200416101418.14379-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently buswidths 2 and 4 are rejected for a device that advertises
Octal capabilities.  Allow these buswidths, just like is done for
buswidth 2 and Quad-capable devices.

Fixes: b12a084c8729ef42 ("spi: spi-mem: add support for octal mode I/O data transfer")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/spi/spi-mem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index adaa0c49f966da97..9a86cc27fcc056bc 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -108,15 +108,17 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
-- 
2.17.1

