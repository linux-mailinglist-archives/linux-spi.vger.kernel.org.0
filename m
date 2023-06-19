Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55836735B99
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjFSPyF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFSPyD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 11:54:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A31E4A
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 08:53:58 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687190037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIrH6l6h4FVOlNSp29zZGkHu1wVR3pubO6q4OyhE0xo=;
        b=WwruJTFPXXkT5hNeyj+ooIdhFe+Y3hhZ3Of48GDqkjJ2yK8h0yAAp55/pZJLQ2LZ+1AeED
        noqMYJEJ5W6eqWn35JuM/CFzlecNsAZm50Q7bBEEzVWsZKHCNz9K7JCtkzlT2TS0JkbtaR
        HXit51l66818IrnRrsF2NTYhMTBoiChg8KU5A7JxG4lccoyceZRQ06xVSiqTP2z0Wnu5MQ
        BNec9ai84G+gbV3JvlXjR7BMSp/UurwzAs/E4z+loYbUBXMRReM1+Gb9eft3EbCTwfOWlu
        sH+ayULL9CgawEzXrPElEO+UPe41Wl7NkSt2We278liiZvYBYCSXncZ5ImVy8g==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B1CC1BF20E;
        Mon, 19 Jun 2023 15:53:56 +0000 (UTC)
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
Subject: [PATCH v2 3/3] spi: sun6i: Use the new helper to derive the xfer timeout value
Date:   Mon, 19 Jun 2023 17:53:49 +0200
Message-Id: <20230619155349.3118420-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
References: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A helper was recently added to the core to factorize common code between
drivers, like the amount of time a driver should wait for a transfer to
happen.

It is of course possible to use a default value (like eg. 1s) but it is
way stronger to adapt this amount of time to the transfer. Indeed, long
transfers (eg. 4MiB) on a slow single-spi bus might take more than the
usual second of timeout and prevent lengthy transfers.

The core helper was heavily inspired by the logic applied in this
driver, the only difference being the minimum amount of time which was
enlarged from 0.1s to 0.5s.

Use this helper instead of open-coding it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 23ad052528db..180094dfae19 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -422,7 +422,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
-	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
+	tx_time = spi_controller_xfer_timeout(master, tfr);
 	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
 					      msecs_to_jiffies(tx_time));
-- 
2.34.1

