Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1334BC49
	for <lists+linux-spi@lfdr.de>; Sun, 28 Mar 2021 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhC1MPm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhC1MPg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Mar 2021 08:15:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805BC061762
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 05:15:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so12696751lja.13
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VhzS3F9fDiMibbAV60JrhbjZyH39x12gVeIMu7q+PU=;
        b=jysgjn6YEaNFlfI4p3Jime9CQYiZPQMlUPOBDjHUEF2e5YnOE69dJqGH3j8owKzW/Y
         blYqG+0Yu/4hphMeRg556wrxgnG26xQ40xKBl6yhFdU9ITUg7KRu1LHchW9Eax9t4515
         ut4k41qJytSivdGqA0KlPu5aBtcde+zjkT9wJirbVZQosBPMsUpHBHsIDWVE6+zj7ngz
         2ktjHnLV16tH1KVijTiPPw6bvrL4GZn0HqM3M1SQYcQyYBrw1OMLzosIIgmJk1mzMKrM
         ivTGOS3saJsUbdesoJf1jWkI0Z9I2IOOxQHiQEnIEtQNFUEHBXJYqXiUemyFD9QXPbtj
         7uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6VhzS3F9fDiMibbAV60JrhbjZyH39x12gVeIMu7q+PU=;
        b=CfQl1FNquDrabaiIrBT35XGOn//LgkmiQTU81UdRKdW1jWjRGNLRiGNIiwZev0lCjX
         PH1DutaptrrRuUwtJlV1gosBEK6LKcDb71Tigz5Enfucyg6t5uwNotB6AD8qgwLBeCXt
         0Tc7+tQIaChd/4rBXXYpF5ogFFa5p5liuBXCR3t6zcSXPtojCV0VmXqHunRbX7dAyM3T
         aQpZC04ALboPZxRwHxIp7rhM0CrkVbkHCtNSHE0/xHXUg8FysmtsiWXdEn3Oq2TV6Dih
         7IzlBg+Gntv+2+oTOi5dwjKZBukNIc6sGHlk9rQ6FTTGUif5gRuoIV0qhpUqHrE2w1Lr
         XX+g==
X-Gm-Message-State: AOAM533TxwG1nzczeoe5DmAtww4ZsLLDcebgv9CdWfcsBomif9i5PEXd
        /5C36Hln4yYtb6pddSNnBgahmJ43mLyckzpWzg8=
X-Google-Smtp-Source: ABdhPJzv6lPeI2jhLa0GI53k3onP+/XBhs7zjRqphKeEDbpfIAxYl2cfELc+/DEYaNHEPDFOUtWXig==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr15061388ljn.30.1616933734730;
        Sun, 28 Mar 2021 05:15:34 -0700 (PDT)
Received: from localhost.localdomain (c-14cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.20])
        by smtp.gmail.com with ESMTPSA id i12sm1523233lfv.220.2021.03.28.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 05:15:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: pl022: User more sensible defaults
Date:   Sun, 28 Mar 2021 14:15:30 +0200
Message-Id: <20210328121530.1983081-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When using the device tree, which must be considered normal
these days, in order to get some kind of normal functionality
out of the PL022 users have to actively go into the device
tree and edit the SPI clients like this:

spi {
  compatible = "arm,pl022";
  num-cs = <1>;
  cs-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;

  foo@0 {
    compatible = "foo";
    reg = <0>;
    pl022,interface = <0>;
    pl022,com-mode = <0>;
  };
};

Otherwise the PL022 will come up as a client (slave) and
using polling mode. This is quite unintuitive and many users
will get their device trees wrong.

Alter the defaults such that we come up in host mode
(master) and use interrupt mode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index fd74ddfbb686..faaca7373b40 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1820,9 +1820,9 @@ static int calculate_effective_freq(struct pl022 *pl022, int freq, struct
  * supplies it.
  */
 static const struct pl022_config_chip pl022_default_chip_info = {
-	.com_mode = POLLING_TRANSFER,
+	.com_mode = INTERRUPT_TRANSFER,
 	.iface = SSP_INTERFACE_MOTOROLA_SPI,
-	.hierarchy = SSP_SLAVE,
+	.hierarchy = SSP_MASTER,
 	.slave_tx_disable = DO_NOT_DRIVE_TX,
 	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
 	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
-- 
2.29.2

