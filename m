Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9225733337
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbjFPOMc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjFPOMb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 10:12:31 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933426BA
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 07:12:30 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686924748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LzITj3fzmJe1KpGO3Dwg9TUIzW0oQVwYevSz6N4g/0k=;
        b=g5y1IPprHUUvFK4Ues8ekTBs+fafE7VSxQYrLRE0dSVcqKQEoR8fz/hjuwY7AXw2fCaSye
        RD6C4zr9VeiVa/7Iskc/tyn1dZaStXVitj4p/31ruiFQqUGFcHA7XO37zentIY0kOKQtIP
        2WM+3Sfu8TjFC5bG+VZFdYBHmCq+ebqrKKA+t299sNQKrVAZ+zllsZhPjYIPjxmPRUCsux
        qSuQihNotheXogEmik07QDugPWDrxX2hQq+1ck1fCy4PpSIRR9UXyqvZu2hNK7f+z5hgiL
        M3M1WsVPuzJaNHOVdLoMdkSmxIfk8agJSrESjF1BtnlRWRe3uoKD1Ccn/84V6A==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FEF6C0018;
        Fri, 16 Jun 2023 14:12:25 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Date:   Fri, 16 Jun 2023 16:12:25 +0200
Message-Id: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A slow SPI bus clocks at ~20MHz, which means it would transfer about
2500 bytes per second with a single data line. Big transfers, like when
dealing with flashes can easily reach a few MiB. The current DMA timeout
is set to 1 second, which means any working transfer of about 4MiB will
always be cancelled.

With the above derivations, on a slow bus, we can assume every byte will
take at most 0.4ms. Said otherwise, we could add 4ms to the 1-second
timeout delay every 10kiB. On a 4MiB transfer, it would bring the
timeout delay up to 2.6s which still seems rather acceptable for a
timeout.

The consequence of this is that long transfers might be allowed, which
hence requires the need to interrupt the transfer if wanted by the
user. We can hence switch to the _interruptible variant of
wait_for_completion. This leads to a little bit more handling to also
handle the interrupted case but looks really acceptable overall.

While at it, we drop the useless, noisy and redundant WARN_ON() call.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-atmel.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c4f22d50dba5..00f269f955ef 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -233,7 +233,8 @@
  */
 #define DMA_MIN_BYTES	16
 
-#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
+#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
+#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4))
 
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -1280,6 +1281,7 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	int			timeout;
 	int			ret;
 	unsigned long		dma_timeout;
+	long			ret_timeout;
 
 	as = spi_master_get_devdata(master);
 
@@ -1308,6 +1310,11 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	as->current_remaining_bytes = xfer->len;
 	while (as->current_remaining_bytes) {
 		reinit_completion(&as->xfer_completion);
+		/* If transfer is bigger than 10kiB, enlarge the timeout */
+		dma_timeout = SPI_DMA_MIN_TIMEOUT;
+		if (as->current_remaining_bytes > 0x2800)
+			dma_timeout += (as->current_remaining_bytes / 0x2800) *
+				SPI_DMA_TIMEOUT_PER_10K;
 
 		if (as->use_pdc) {
 			atmel_spi_lock(as);
@@ -1333,11 +1340,12 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			atmel_spi_unlock(as);
 		}
 
-		dma_timeout = wait_for_completion_timeout(&as->xfer_completion,
-							  SPI_DMA_TIMEOUT);
-		if (WARN_ON(dma_timeout == 0)) {
-			dev_err(&spi->dev, "spi transfer timeout\n");
-			as->done_status = -EIO;
+		ret_timeout = wait_for_completion_interruptible_timeout(&as->xfer_completion,
+									dma_timeout);
+		if (ret_timeout <= 0) {
+			dev_err(&spi->dev, "spi transfer %s\n",
+				!ret_timeout ? "timeout" : "canceled");
+			as->done_status = ret_timeout < 0 ? ret_timeout : -EIO;
 		}
 
 		if (as->done_status)
-- 
2.34.1

