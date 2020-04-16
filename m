Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FCF1ABDC2
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504736AbgDPKTB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504747AbgDPKSq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 06:18:46 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE4C061A41
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2020 03:18:45 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:fd83:81bb:c1d7:433d])
        by xavier.telenet-ops.be with bizsmtp
        id TNJj220064dKHqf01NJjeg; Thu, 16 Apr 2020 12:18:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1bX-0001Rc-BQ; Thu, 16 Apr 2020 12:18:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jP1bX-0003ny-A0; Thu, 16 Apr 2020 12:18:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] spi: spidev_test: Add support for Octal mode data transfers
Date:   Thu, 16 Apr 2020 12:18:35 +0200
Message-Id: <20200416101835.14573-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416101835.14573-1-geert+renesas@glider.be>
References: <20200416101835.14573-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for octal transfers using the -8/--octal command line
parameter.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/spi/spidev_test.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 27967dd90f8f3f77..4d219daea2ebcfa2 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -128,18 +128,22 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		.bits_per_word = bits,
 	};
 
-	if (mode & SPI_TX_QUAD)
+	if (mode & SPI_TX_OCTAL)
+		tr.tx_nbits = 8;
+	else if (mode & SPI_TX_QUAD)
 		tr.tx_nbits = 4;
 	else if (mode & SPI_TX_DUAL)
 		tr.tx_nbits = 2;
-	if (mode & SPI_RX_QUAD)
+	if (mode & SPI_RX_OCTAL)
+		tr.rx_nbits = 8;
+	else if (mode & SPI_RX_QUAD)
 		tr.rx_nbits = 4;
 	else if (mode & SPI_RX_DUAL)
 		tr.rx_nbits = 2;
 	if (!(mode & SPI_LOOP)) {
-		if (mode & (SPI_TX_QUAD | SPI_TX_DUAL))
+		if (mode & (SPI_TX_OCTAL | SPI_TX_QUAD | SPI_TX_DUAL))
 			tr.rx_buf = 0;
-		else if (mode & (SPI_RX_QUAD | SPI_RX_DUAL))
+		else if (mode & (SPI_RX_OCTAL | SPI_RX_QUAD | SPI_RX_DUAL))
 			tr.tx_buf = 0;
 	}
 
@@ -187,6 +191,7 @@ static void print_usage(const char *prog)
 	     "  -R --ready    slave pulls low to pause\n"
 	     "  -2 --dual     dual transfer\n"
 	     "  -4 --quad     quad transfer\n"
+	     "  -8 --octal    octal transfer\n"
 	     "  -S --size     transfer size\n"
 	     "  -I --iter     iterations\n");
 	exit(1);
@@ -213,13 +218,14 @@ static void parse_opts(int argc, char *argv[])
 			{ "dual",    0, 0, '2' },
 			{ "verbose", 0, 0, 'v' },
 			{ "quad",    0, 0, '4' },
+			{ "octal",   0, 0, '8' },
 			{ "size",    1, 0, 'S' },
 			{ "iter",    1, 0, 'I' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR24p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -280,6 +286,9 @@ static void parse_opts(int argc, char *argv[])
 		case '4':
 			mode |= SPI_TX_QUAD;
 			break;
+		case '8':
+			mode |= SPI_TX_OCTAL;
+			break;
 		case 'S':
 			transfer_size = atoi(optarg);
 			break;
@@ -295,6 +304,8 @@ static void parse_opts(int argc, char *argv[])
 			mode |= SPI_RX_DUAL;
 		if (mode & SPI_TX_QUAD)
 			mode |= SPI_RX_QUAD;
+		if (mode & SPI_TX_OCTAL)
+			mode |= SPI_RX_OCTAL;
 	}
 }
 
-- 
2.17.1

