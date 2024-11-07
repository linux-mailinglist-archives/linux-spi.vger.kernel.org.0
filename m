Return-Path: <linux-spi+bounces-5644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5FA9C09A2
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 16:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31382284E92
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2906B2101BE;
	Thu,  7 Nov 2024 15:07:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F512B63
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992064; cv=none; b=QnFWuOvpThdqUUwS+aF0JIk61V5pzLW2L/EUbkRl/CaCREAZl8yFlQxOz+5eoylRvtMofcfxp2kCQDg9AEYmxVUiNwNO7zWv+1mVvvkBUHyut3/YExzA4LiXSkWJeFYIJCKhi1xZaaZBJBz5XGLnaGQC/GFxfsW/d2gxxrH+hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992064; c=relaxed/simple;
	bh=zmmURaCZvXE4+kB7JLY8MS1IeA8+E+rhjn3iho+XAj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JYTBM+4NfR66/N01Yzy+n4ToMBsxx6wd28tHCriuIPrrPLGwpRhahMN3jB5Vnz019kecKLzSH8Q6PSW5jePVXdXOrf0WIAbvF55sEhqy+A+wyFirwdx3Fj+N89ZnDlicQX5lRYPRddkbHbrPes4dC4bdw2AMv5j0gpNbW+5JMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1t946e-0003NQ-3U; Thu, 07 Nov 2024 16:07:32 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 07 Nov 2024 16:07:31 +0100
Subject: [PATCH] spi: spidev_test: add support for word delay
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-spidev-test-word-delay-v1-1-d4bba5569e39@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALLXLGcC/x3MSwqAMAwA0atI1gbaKgheRVykNmpAVBrxQ/HuF
 pdvMZNAOQortEWCyKeobGuGLQsYZlonRgnZ4IyrrTUN6i6BTzxYD7y2GDDwQg9a8uRd1dQVecj
 xHnmU+x93/ft+yB2VKGgAAAA=
X-Change-ID: 20241107-spidev-test-word-delay-1abab23743ab
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Support setting the word delay using the -w/--word-delay command line
parameter. Note that spidev exposes word delay only as an u8, allowing
for a maximum of 255us of delay to be inserted.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 9179942d7f15ceb5cab17477d950800f545b6ab4..f2135d619a0bb4aa3eff830af0f2114ad9991cc5 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -42,6 +42,7 @@ static char *input_file;
 static char *output_file;
 static uint32_t speed = 500000;
 static uint16_t delay;
+static uint16_t word_delay;
 static int verbose;
 static int transfer_size;
 static int iterations;
@@ -124,6 +125,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		.rx_buf = (unsigned long)rx,
 		.len = len,
 		.delay_usecs = delay,
+		.word_delay_usecs = word_delay,
 		.speed_hz = speed,
 		.bits_per_word = bits,
 	};
@@ -172,11 +174,12 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-2348CDFHILMNORSZbdilopsv]\n", prog);
+	printf("Usage: %s [-2348CDFHILMNORSZbdilopsvw]\n", prog);
 	puts("general device settings:\n"
 		 "  -D --device         device to use (default /dev/spidev1.1)\n"
 		 "  -s --speed          max speed (Hz)\n"
 		 "  -d --delay          delay (usec)\n"
+		 "  -w --word-delay     word delay (usec)\n"
 		 "  -l --loop           loopback\n"
 		 "spi mode:\n"
 		 "  -H --cpha           clock phase\n"
@@ -213,6 +216,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "device",        1, 0, 'D' },
 			{ "speed",         1, 0, 's' },
 			{ "delay",         1, 0, 'd' },
+			{ "word-delay",    1, 0, 'w' },
 			{ "loop",          0, 0, 'l' },
 			{ "cpha",          0, 0, 'H' },
 			{ "cpol",          0, 0, 'O' },
@@ -237,7 +241,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3ZFMNR248p:vS:I:",
+		c = getopt_long(argc, argv, "D:s:d:w:b:i:o:lHOLC3ZFMNR248p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -253,6 +257,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'd':
 			delay = atoi(optarg);
 			break;
+		case 'w':
+			word_delay = atoi(optarg);
+			break;
 		case 'b':
 			bits = atoi(optarg);
 			break;

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241107-spidev-test-word-delay-1abab23743ab

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


