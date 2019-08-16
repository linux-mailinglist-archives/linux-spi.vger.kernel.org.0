Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B19066C
	for <lists+linux-spi@lfdr.de>; Fri, 16 Aug 2019 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHPRFl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Aug 2019 13:05:41 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:48174 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfHPRFk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Aug 2019 13:05:40 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 13:05:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TMl0t22j8qYVABIvPAxoYrZBeDSEu0ad3kM77/ptRoY=; b=hbTpfDeLYXAn+UuBGXwhvLgYW1
        qE1JEkDq17OwOZsSvyKJAhAgykxc7KsKQyjq5YBrNJmbPfFZBodVEeJicEvKKDv+yL3e4rtI5E9Vg
        wBijc8pOhYzsAWdCHz2KN/PLm0H8cAB8oSNnxPmRQsPOOkvYg7VBe74IBRMBs2LK4JCA=;
Received: from pd9e2f4fd.dip0.t-ipconnect.de ([217.226.244.253] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hyfQc-0002DT-Pg; Fri, 16 Aug 2019 18:50:15 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1hyfQc-0008QU-CO; Fri, 16 Aug 2019 18:50:14 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-spi@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] gpio: of: fix Freescale SPI CS quirk handling
Date:   Fri, 16 Aug 2019 18:50:00 +0200
Message-Id: <20190816165000.32334-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On the gta04 we see:
spi_gpio: probe of spi_lcd failed with error -2

The quirk introduced in
commit e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
can also be triggered by a temporary -EPROBE_DEFER and
so "convert" it to a hard -ENOENT.

Disable that conversion by checking for -EPROBE_DEFER.

Fixes: e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
Suggested-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 567fb98c0892..9762dd6d99fa 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -363,7 +363,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	/* Special handling for SPI GPIOs if used */
 	if (IS_ERR(desc))
 		desc = of_find_spi_gpio(dev, con_id, &of_flags);
-	if (IS_ERR(desc)) {
+	if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER) {
 		/* This quirk looks up flags and all */
 		desc = of_find_spi_cs_gpio(dev, con_id, idx, flags);
 		if (!IS_ERR(desc))
-- 
2.20.1

