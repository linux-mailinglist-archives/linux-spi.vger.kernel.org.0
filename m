Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C63735B97
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jun 2023 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFSPyE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jun 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFSPyD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 11:54:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755BE72
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 08:53:56 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687190035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhIQmvwCqc8f2ldfvdDwrf5zFPY90uFTbI6lO/wBafo=;
        b=ZXzrLBsgbSEa2r0CaAMT7Tkop+dVa6ENEoT112qvP15DZzXWqfx08nu9gIxTrjKVJcGlQy
        Xn/ATd8crYS0Jm2GobR+8EFj2W03ObKiLCcbI4Q92hNGINiNSeKXZmJ4UMj9Lv0JbpHPFm
        02q9DHk86SKMg+0SYQ4Q1rw1O2nj1FQklaTWkoYdth+mqgZK/e7O3yPU9hakNGHmFS/AwF
        vRWe6BkgqqR0m03DwqRaD+h5iFF3rbu6n9VnWVMbA2KgzNs/jlB4mrfH1YTvZhaoVlz7YX
        treaYYh//jQ2MfZjHMPXqRUadUz5ITezyZZ/OnCjswhJAgTmyQUrXLR9Cc+g7g==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1ED2F1BF206;
        Mon, 19 Jun 2023 15:53:54 +0000 (UTC)
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
Subject: [PATCH v2 1/3] spi: Create a helper to derive adaptive timeouts
Date:   Mon, 19 Jun 2023 17:53:47 +0200
Message-Id: <20230619155349.3118420-2-miquel.raynal@bootlin.com>
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

Big transfers might take a bit of time, too constraining timeouts might
lead to false positives. In order to simplify the drivers work and with
the goal of factorizing code in mind, let's add a helper that can be
used by any spi controller driver to derive a relevant per-transfer
timeout value.

The logic is simple: we know how much time it would take to transfer a
byte, we can easily derive the total theoretical amount of time involved
for each transfer. We multiply it by two to have a bit of margin and
enforce a minimum of 500ms.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fbf8c0d95968..4d6636c50465 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1186,6 +1186,23 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 	return false;
 }
 
+/**
+ * spi_controller_xfer_timeout - Compute a suitable timeout value
+ * @ctlr: SPI device
+ * @xfer: Transfer descriptor
+ *
+ * Compute a relevant timeout value for the given transfer. We derive the time
+ * that it would take on a single data line and take twice this amount of time
+ * with a minimum of 500ms to avoid false positives on loaded systems.
+ *
+ * Returns: Transfer timeout value in milliseconds.
+ */
+static inline unsigned int spi_controller_xfer_timeout(struct spi_controller *ctlr,
+						       struct spi_transfer *xfer)
+{
+	return max(xfer->len * 8 * 2 / (xfer->speed_hz / 1000), 500U);
+}
+
 /*---------------------------------------------------------------------------*/
 
 /* SPI transfer replacement methods which make use of spi_res */
-- 
2.34.1

