Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB51CC4FE
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2019 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJDVni (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Oct 2019 17:43:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40928 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfJDVnh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Oct 2019 17:43:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so4672626pfb.7
        for <linux-spi@vger.kernel.org>; Fri, 04 Oct 2019 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42znpoZzZjmG9yaRFQAzNvyi78UFWYqHsVeXsUAMBvM=;
        b=MJ9Cw0wp0Mh+XkAZ37PArMbq3cXXTtMOK8MgPDNXCkP0yXajJDHPB5xaYgU0YftimM
         IZ9Xr5C2yJosZi22FLfNZvyhDcgs9mFbobfjnE1WeFcBQ21xU74RMtcoRM+q4pMigeCm
         sJyAZ9okOsrTu89hmigncAMqTy1HVXQqwb/PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42znpoZzZjmG9yaRFQAzNvyi78UFWYqHsVeXsUAMBvM=;
        b=l/uer618GT2GIS//kCrkFKEaBCJtmKsFBTlPOr4xyzvcEq1+pX6SDyNoWhdWcP+j80
         BalzhA5vhVIPmVBJJCSD+zCkdIB7WlK3Rdu47reBjtpxLTeUu4nRe5fK8e08Scn6b7Al
         aGDhT7cvOOKP321oPYNp8WdCYsPxeuee6kTS88/W8xYObm6/Ld+m7Y2bCMTbaF9z+PCg
         C2bPXpiALbWDJuUDM/AtrE3DF6Hy7VjDU3OZTvmPYNdao7HurOQcrqmPRd/oQ3wD8Zlx
         Hyit4wYTNlFmNOAj//WWsXiNMeU/sKYIU7Z3VxV2qtsgX1kJf4Zt3V3kK/kgevoJ4KLN
         iEbA==
X-Gm-Message-State: APjAAAUA9FxcTIzgOHlB0cwCrD1EbWOMdlRDqK6zQ80nfIJ9Zmo8wLik
        AQ5jcFCzTb6FrGnozTVOd7jWjg==
X-Google-Smtp-Source: APXvYqy1SG4O+l1PxmR4D+2nW3K5VMykMwaSO5DOFDZyCRsqYuEK129X6z1/RcOxIP4TfZnnBe0BMw==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr4003152pjy.55.1570225416541;
        Fri, 04 Oct 2019 14:43:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>, Dan Murphy <dmurphy@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Cooper <jason@lakedaemon.net>,
        Jean Delvare <jdelvare@suse.com>, Jiri Slaby <jslaby@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pavel Machek <pavel@ucw.cz>,
        Richard Leitner <richard.leitner@skidata.com>,
        Riku Voipio <riku.voipio@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 00/10] Stop NULLifying match pointer in of_match_device()
Date:   Fri,  4 Oct 2019 14:43:24 -0700
Message-Id: <20191004214334.149976-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

of_match_device() uses of_match_ptr() to make the match table argument
NULL via the pre-processor when CONFIG_OF=n. This makes life harder for
compilers who think that match tables are never used and warn about
unused variables when CONFIG_OF=n. This series changes various callers
to use of_device_get_match_data() instead, which doesn't have this
problem, and removes the of_match_ptr() usage from of_match_device() so
that the compiler can stop complaining about unused variables. It will
do dead code elimination instead and remove the match table if it isn't
actually used.

Huge Cc list!

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: <alsa-devel@alsa-project.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: <linux-hwmon@vger.kernel.org>
Cc: <linux-leds@vger.kernel.org>
Cc: <linux-media@vger.kernel.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-renesas-soc@vger.kernel.org>
Cc: <linux-rtc@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: <linux-spi@vger.kernel.org>
Cc: <linux-usb@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Richard Leitner <richard.leitner@skidata.com>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>

Stephen Boyd (10):
  leds: pca953x: Use of_device_get_match_data()
  media: renesas-ceu: Use of_device_get_match_data()
  rtc: armada38x: Use of_device_get_match_data()
  drivers: net: davinci_mdio: Use of_device_get_match_data()
  serial: stm32: Use of_device_get_match_data()
  usb: usb251xb: Use of_device_get_match_data()
  ASoC: jz4740: Use of_device_get_match_data()
  spi: gpio: Look for a device node instead of match
  hwmon: (lm70) Avoid undefined reference to match table
  of/device: Don't NULLify match table in of_match_device() with
    CONFIG_OF=n

 drivers/hwmon/lm70.c                   |  2 +-
 drivers/leds/leds-pca9532.c            | 14 +----
 drivers/media/platform/renesas-ceu.c   |  2 +-
 drivers/net/ethernet/ti/davinci_mdio.c | 12 ++---
 drivers/rtc/rtc-armada38x.c            | 10 ++--
 drivers/spi/spi-gpio.c                 |  5 +-
 drivers/tty/serial/stm32-usart.c       | 71 ++++++++++++--------------
 drivers/tty/serial/stm32-usart.h       |  2 +-
 drivers/usb/misc/usb251xb.c            | 12 ++---
 include/linux/of_device.h              |  4 +-
 sound/soc/jz4740/jz4740-i2s.c          |  5 +-
 11 files changed, 55 insertions(+), 84 deletions(-)


base-commit: 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c
-- 
Sent by a computer through tubes
