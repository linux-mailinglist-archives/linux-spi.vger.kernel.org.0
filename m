Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6C739C67
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFVJPe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjFVJOy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 05:14:54 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D627EDA
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 02:06:39 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687424798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2183b6oDtby4XAIhp5msAg+vrfOlFnEs4/AO2GjwDM=;
        b=iVQtyiRuPipbaG/ykeAFvBFn49hkb2v9AQ9KnuvgqDJBW/KZzi9nwysilXKeIpFGdN7XPc
        fAfOVRAuuJMRHwMzcrc/vjiirp7bF0jEEFPfqrT8WfV/+QHNyswY/RSDOKNFwzKGPNrLnU
        Cbc1Fhy/ar6AUGzqYMR4E5K2foGRIoD/SkHoG18G4ycvQFldWDSJgu66m7UW+jxdWJ6SfD
        uZ3tQHjR0mUT5x+qEUAK/wf1gNMukVEI7k5h2qnd+6tPUeWRjNiWv/t7xL+IPMZSKh2l0T
        viTDH8m8wYGmBAfhH1YbSbNYUhd3aYzPg9XENJX05T+HtGScWXelUE6cznv1YQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62D8B40008;
        Thu, 22 Jun 2023 09:06:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 2/3] spi: atmel: Prevent false timeouts on long transfers
Date:   Thu, 22 Jun 2023 11:06:33 +0200
Message-Id: <20230622090634.3411468-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
References: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/spi/spi-atmel.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 943548aab8af..d87be2890597 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -233,7 +233,8 @@
  */
 #define DMA_MIN_BYTES	16
 
-#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
+#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
+#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4))
 
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -1279,7 +1280,8 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 	struct atmel_spi_device	*asd;
 	int			timeout;
 	int			ret;
-	unsigned long		dma_timeout;
+	unsigned int		dma_timeout;
+	long			ret_timeout;
 
 	as = spi_controller_get_devdata(host);
 
@@ -1333,11 +1335,13 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 			atmel_spi_unlock(as);
 		}
 
-		dma_timeout = wait_for_completion_timeout(&as->xfer_completion,
-							  SPI_DMA_TIMEOUT);
-		if (WARN_ON(dma_timeout == 0)) {
-			dev_err(&spi->dev, "spi transfer timeout\n");
-			as->done_status = -EIO;
+		dma_timeout = msecs_to_jiffies(spi_controller_xfer_timeout(host, xfer));
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

