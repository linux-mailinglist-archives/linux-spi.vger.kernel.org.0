Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F364BC87F
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiBSNNm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:13:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiBSNNj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:13:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6EB5FF3F;
        Sat, 19 Feb 2022 05:13:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d10so21393959eje.10;
        Sat, 19 Feb 2022 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :subject:content-transfer-encoding;
        bh=CeX+j8S+ZMIBHihlb3u0Wkc+ChPVHIk0qcdu7jMUVcY=;
        b=Yo9WW4sN7XrtbINqwUTYV2hXIcEgwILCNXAnFOrWwUb7/KTLjKJ70f+qKYpMrjHq6f
         f5NpDWo/29vt4ilqMf17JyXUROs2ey1/K2IwpvVWyzYR2AeSQoPABNQ7jRuuelcw8Xes
         o++i80V4JTjlQu/NzB3dpu5l1AKHCOdiYWCxATGiVE4gTHe7zxDZ6ggKJ/CqbhGWte47
         0Tm3KQrQNkcPZzTYknWvsygS4mmlfj/6a3lTtBtnFBTsDv4drJk865SI3rB04b1iFLdY
         5sdka6DwCxGrEhiXTJLUA2xsW/QojHRqBDWg/2eYg/TI49WJpl9jb9m/sqM+/xwWb6eR
         ygGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:subject:content-transfer-encoding;
        bh=CeX+j8S+ZMIBHihlb3u0Wkc+ChPVHIk0qcdu7jMUVcY=;
        b=D93MW3vUykx3yOBxITpHtwxcIYPtDAttxfhwRPgqxc542e043SbXMPh4TVD4MTwzhi
         K9E/ccIpGvW0FYtQw/UeGbJwHAk4VvbRW888ybC/dwJ04bJvSY12pIyKoPXs9ZUtZsR5
         O1P7kqPQrDO8WDU+c6gu6xB17jh6jySPJ/a9Jtw8bStqd+JLHnqchfGSTCFrnt+35aoc
         OtTdpXu6EI4pv58uqWiTsmijx5YojsJL+9NIVepX81AhDb2R2r1Amnf6XiBRxwJFMxZV
         RzOzHv27YzgQTgOqLFhzs1vESI1J2e0KsirrY8ShL9tyztEP4VqXk3JvsyDV4RjiRccb
         zqwg==
X-Gm-Message-State: AOAM531Uhmv0J0dTFHe8cm7SrhfKsud4ZORp3xCkm9y/xsOG7d4o+B/l
        NLD/PViRnAuqDVT3RliyyyY=
X-Google-Smtp-Source: ABdhPJxUvk2aY3tsottZeK8UirBdfhQt4sEqBSJG/aPh1LAhr9fHXcY8eziH4qDonlADIEAIA+/hdA==
X-Received: by 2002:a17:906:1703:b0:6d0:ee0a:7684 with SMTP id c3-20020a170906170300b006d0ee0a7684mr2711626eje.224.1645276398825;
        Sat, 19 Feb 2022 05:13:18 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id oz23sm3217749ejb.174.2022.02.19.05.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 05:13:18 -0800 (PST)
Message-ID: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
Date:   Sat, 19 Feb 2022 14:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7 segment
 display controller
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

To be decided is through which tree this series should go.
I'd think SPI would be most suited, but that's a decision I
leave up to the respective maintainers.

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

Andreas Färber (2):
  spi: gpio: Implement LSB First bitbang support
  dt-bindings: vendor-prefixes: Add Titan Micro Electronics

Heiner Kallweit (4):
  dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
  docs: ABI: document tm1628 attribute display-text
  auxdisplay: add support for Titanmec TM1628 7 segment display
    controller
  arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment
    display

 .../testing/sysfs-devices-auxdisplay-tm1628   |   7 +
 .../bindings/auxdisplay/titanmec,tm1628.yaml  |  82 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
 drivers/auxdisplay/Kconfig                    |  10 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/tm1628.c                   | 368 ++++++++++++++++++
 drivers/spi/spi-bitbang-txrx.h                |  66 ++++
 drivers/spi/spi-gpio.c                        |  42 +-
 9 files changed, 628 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
 create mode 100644 drivers/auxdisplay/tm1628.c

-- 
2.35.1

