Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60E6735B98
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFSPyE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjFSPyD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 11:54:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90739E77
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 08:53:57 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687190036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVl7mcQ2hRFnAGAiMjDiHg2vEcGhnErk/G4vbtij5nQ=;
        b=N/oKqopIgRPFhHRhcoBJVpXbyRInOqOPNYpdFtIt7iiIu7FsfgS6nrJslb5ep21xvzxikp
        QRjeYieP5o1uuHdfbflDHwPDQZ/HB7FiFqJdgBkTKKbwDLVC/DV16h1WXdaOj9Ds5SqntA
        OSW0l9A7GW4PlT2WvBpHNuFTL8W86gbwuwZGINrGJYbVfiBFbJDkqQg+NbKU0u/tPptpPT
        PfMlDupDsXVRmodLobC5m9JUngqhi8KOAycA04P/5vqbGygVpP5NrC1o7fIQRB2TiDhcEM
        emiH9h0JWRcrRMCS9T4j0HWDvlKPFojnAibVCGHYV5CNxzjr9Me+ozd1XHWH5w==
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
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EC2A1BF203;
        Mon, 19 Jun 2023 15:53:55 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/3] spi: atmel: Prevent false timeouts on long transfers
Date:   Mon, 19 Jun 2023 17:53:48 +0200
Message-Id: <20230619155349.3118420-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
References: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index c4f22d50dba5..d1743817a5da 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -233,7 +233,8 @@
  */
 #define DMA_MIN_BYTES	16
 
-#define SPI_DMA_TIMEOUT		(msecs_to_jiffies(1000))
+#define SPI_DMA_MIN_TIMEOUT	(msecs_to_jiffies(1000))
+#define SPI_DMA_TIMEOUT_PER_10K	(msecs_to_jiffies(4))
 
 #define AUTOSUSPEND_TIMEOUT	2000
 
@@ -1279,7 +1280,8 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 	struct atmel_spi_device	*asd;
 	int			timeout;
 	int			ret;
-	unsigned long		dma_timeout;
+	unsigned int		dma_timeout;
+	long			ret_timeout;
 
 	as = spi_master_get_devdata(master);
 
@@ -1333,11 +1335,13 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 			atmel_spi_unlock(as);
 		}
 
-		dma_timeout = wait_for_completion_timeout(&as->xfer_completion,
-							  SPI_DMA_TIMEOUT);
-		if (WARN_ON(dma_timeout == 0)) {
-			dev_err(&spi->dev, "spi transfer timeout\n");
-			as->done_status = -EIO;
+		dma_timeout = msecs_to_jiffies(spi_controller_xfer_timeout(master, xfer));
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

