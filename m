Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123CD34F0CF
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhC3SSd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhC3SSZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 14:18:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67FC061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 11:18:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRIwK-0007hs-TK; Tue, 30 Mar 2021 20:18:08 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRIwH-0000Dn-TO; Tue, 30 Mar 2021 20:18:05 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH v4 0/6] clk: provide new devm helpers for prepared and enabled clocks
Date:   Tue, 30 Mar 2021 20:17:49 +0200
Message-Id: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

this series contains new helpers for devm managed clocks. Since v3 this
is a series that also contains four example conversions to show the
simplification that can be achieved. It was not hard to find these
candidates, there are drivers all over that can benefit.

The idea to provide these helpers is already quite old, I sent v1 back
in October and unfortunately didn't receive any feedback from the clk
maintainers yet on any of the patch series. It would be great if this
series is considered obviously good enough to consider it.

Best regards
Uwe

Uwe Kleine-König (6):
  clk: generalize devm_clk_get() a bit
  clk: Provide new devm_clk_helpers for prepared and enabled clocks
  pwm: atmel: Simplify using devm_clk_get_prepared()
  rtc: at91sma9: Simplify using devm_clk_get_enabled()
  i2c: imx: Simplify using devm_clk_get_enableded()
  spi: davinci: Simplify using devm_clk_get_enabled()

 drivers/clk/clk-devres.c     | 96 ++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-imx.c | 11 +----
 drivers/pwm/pwm-atmel.c      | 15 +-----
 drivers/rtc/rtc-at91sam9.c   | 22 ++-------
 drivers/spi/spi-davinci.c    | 11 +----
 include/linux/clk.h          | 87 +++++++++++++++++++++++++++++++-
 6 files changed, 176 insertions(+), 66 deletions(-)

base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
2.30.2

