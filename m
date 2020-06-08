Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B287A1F1621
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 12:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgFHKAy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 06:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgFHKAw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 06:00:52 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DBC08C5C3
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 03:00:51 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by michel.telenet-ops.be with bizsmtp
        id oa0q2200j0R8aca06a0q5c; Mon, 08 Jun 2020 12:00:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEaI-0007PR-HL; Mon, 08 Jun 2020 12:00:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEaI-0007z4-FW; Mon, 08 Jun 2020 12:00:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spidev_test: Use %u to format unsigned numbers
Date:   Mon,  8 Jun 2020 12:00:49 +0200
Message-Id: <20200608100049.30648-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Consistently use %u to format unsigned numbers.
For "bits" this doesn't matter that much, as it is "uint8_t".
However, "speed" is "uint32_t", so in case people use "-s -1" to force
the maximum, they would see:

    max speed: -1 Hz (4294967 KHz)

While at it, use "k" (kilo) instead of "K" (kelvin) in "kHz".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/spi/spidev_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index eec23fa693bd5912..56ea053f72f2a276 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -461,8 +461,8 @@ int main(int argc, char *argv[])
 		pabort("can't get max speed hz");
 
 	printf("spi mode: 0x%x\n", mode);
-	printf("bits per word: %d\n", bits);
-	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
+	printf("bits per word: %u\n", bits);
+	printf("max speed: %u Hz (%u kHz)\n", speed, speed/1000);
 
 	if (input_tx)
 		transfer_escaped_string(fd, input_tx);
-- 
2.17.1

