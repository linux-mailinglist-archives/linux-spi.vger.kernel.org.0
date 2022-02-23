Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3F4C1A4E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiBWR5N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 12:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiBWR5N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 12:57:13 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF011A03;
        Wed, 23 Feb 2022 09:56:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a23so53902027eju.3;
        Wed, 23 Feb 2022 09:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=/PO6oqBBGLbyvnqDkql90p5GH0BalUjP2WrLAq+W6DM=;
        b=X3C0wg3eFLnHA9PM74bynyVtyRjKYKBcIwrmbsmKgoypi6OAPm98mCcej94ww9OypS
         YwcLXyfFURJcodXTmmH8Ai05ohGE2Zsjk+lH3/Ui5KYWDtGZbcnVKDU7hn3kfcdCrQ5X
         BDwTE5FjAY/fEwAYlXmrK5bv917qFcFlc/QrKSX4yl0uIQEHdiOz0bMb0xY6cc9R2bqo
         9/ArYoxhOekhmKcf/2cPKEPqVpXxpmdLygDk1Ris0ZFweTk08cbJk1vqSZcTSJCzHi3r
         t/1uvCd2dYqvNPAwpV5BzJiOyXSD0dJ6uJ54DRIj5dIfayiS+5OOv9CBX7xwwgAiEY/2
         /0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=/PO6oqBBGLbyvnqDkql90p5GH0BalUjP2WrLAq+W6DM=;
        b=hiiLHEVDfzR7BbRp3ymwjP+TpQlZG9wBAx5K5govF+mZEDJIq18B/RR7vL29F1L8Ox
         vIlkOtqld/tLgY099D2QNRV8AOMqAbwV7XFga9MBuYk1nLRTIYMPueONhuEQmgjKZjVb
         vaf2ACKQNteS7VOSEyeXxlYzB+BfnLYIV0KkyVdpfFfU4y4wZYhy87ybYkUJwRbhMoCI
         dNQqWBvBz33Yvu51ZAN3KgJAkX1Va1VQ0OBUA01FQFvJsCm4MMiMuh9cK0/oOLwC1ODh
         5vf3m9D0MN9UjItKxNqCCLjVuAtlHFqwJQjGiOFCBL/PENf2u1mc6RfunjXhwkcBmTHD
         7Ijg==
X-Gm-Message-State: AOAM531USj530ggreyH7swpbVNpkXGyCHCsu0CoGnapt57ZTf21qNs9K
        S90in5f7PYpJpGqq35NSJko=
X-Google-Smtp-Source: ABdhPJyKbqAtnZB6CoBgZ25tIKyZpF49TmXYoUgQOdRxHjja/3AY3gCHBz6ChJ9vPCjvUTj9+IdTDQ==
X-Received: by 2002:a17:906:848f:b0:6cf:7234:8ae with SMTP id m15-20020a170906848f00b006cf723408aemr686250ejx.620.1645639001900;
        Wed, 23 Feb 2022 09:56:41 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:d12c:c0a:f603:b44d? (p200300ea8f4d2b00d12c0c0af603b44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:d12c:c0a:f603:b44d])
        by smtp.googlemail.com with ESMTPSA id j6sm141682eje.158.2022.02.23.09.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:56:41 -0800 (PST)
Message-ID: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
Date:   Wed, 23 Feb 2022 18:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/5] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds support for the Titanmec TM1628 7 segment display
controller. It's based on previous RFC work from Andreas Färber.
The RFC version placed the driver in the LED subsystem, but this was
NAK'ed by the LED maintainer. Therefore I moved the driver to
/drivers/auxdisplay what seems most reasonable to me.

Further changes to the RFC version:
- Driver can be built also w/o LED class support, for displays that
  don't have any symbols to be exposed as LED's.
- Simplified the code and rewrote a lot of it.
- Driver is now kind of a MVP, but functionality should be sufficient
  for most use cases.
- Use the existing 7 segment support in uapi/linux/map_to_7segment.h
  as suggested by Geert Uytterhoeven.

Note: There's a number of chips from other manufacturers that are
      almost identical, e.g. FD628, SM1628. Only difference I saw so
      far is that they partially support other display modes.
      TM1628: 6x12, 7x11
      SM1628C: 4x13, 5x12, 6x11, 7x10
      For typical displays on devices using these chips this
      difference shouldn't matter.

Successfully tested on a TX3 Mini TV box that has an SM1628C and a
display with 4 digits and 7 symbols.

v2:
- (re-)add Andreas' SoB to two patches
- fix YAML issues
- include ctype.h explicitly
- add info message in probe()

v3:
- remove patch 1 because it has been applied via the SPI tree already
- fix remaining YAML issues in patch 2
- follow Miguel's suggestion on usage of Co-Developed-by

Andreas Färber (1):
  dt-bindings: vendor-prefixes: Add Titan Micro Electronics

Heiner Kallweit (4):
  dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
  docs: ABI: document tm1628 attribute display-text
  auxdisplay: add support for Titanmec TM1628 7 segment display
    controller
  arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment
    display

 .../testing/sysfs-devices-auxdisplay-tm1628   |   7 +
 .../bindings/auxdisplay/titanmec,tm1628.yaml  |  92 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
 drivers/auxdisplay/Kconfig                    |  10 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/tm1628.c                   | 376 ++++++++++++++++++
 7 files changed, 547 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
 create mode 100644 drivers/auxdisplay/tm1628.c

-- 
2.35.1

