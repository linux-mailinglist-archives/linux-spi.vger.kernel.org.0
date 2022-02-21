Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70F4BEBB5
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiBUUTs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:19:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiBUUTs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:19:48 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098213EBD;
        Mon, 21 Feb 2022 12:19:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h15so14719821edv.7;
        Mon, 21 Feb 2022 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:cc:content-language
         :subject:content-transfer-encoding;
        bh=uzQB996Y6w229dzKjEpHtyaZ7eebPm32v5je8cXlqR4=;
        b=jVNl55HnQFSHL8r2zu48hDsc9I9R9lGA7ty4tBY0aCiODO0x2JBnfif39D/IPKhWXJ
         IeN0lLb6IxqKOeWIcVo85V096xgnBb7+RKdFBJLyVQYeg2WP6cQDBWvtoygheTEdrQSQ
         LbG6/5bqj2mo1gXAhzEmYpMZejCMfUh8/D0RINOB+klffi+dG6c7g5g5v0IkxEU3PDE6
         fNYj9fBSrp44ZaxcWDCwFpDTvrjU4SQ1y5o8ytkmwq2r1ImNHVs+Ntp09ZIYS67+ak5z
         HI3PA4fTJdQw7UgvFh0unwn3HjfxJH9aju9Oy5hECnN8atFsAOyxI8qqvKF43vNl43mU
         +sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :cc:content-language:subject:content-transfer-encoding;
        bh=uzQB996Y6w229dzKjEpHtyaZ7eebPm32v5je8cXlqR4=;
        b=5Mq8CdnAa5832UmWAY0QG8IcSiervJItesNl6ADAs0Lift1oe/dYlUee7EuRGflHKM
         8L0UqDEsA9lXr1i/tF2GruPoF+pIX8vxnYNGT11AQeWBBBGP9vrDeV2khlUa97YTkBjG
         hoDlfBjhMSImY8RvCFR+MErkoD8J+VEPcKAYqjh6UFBUshCdEWUw5Vj0RFkcbsylLA7x
         WzSSCZNLGDmwwG1BuMUn8X8LQ0fWJOqlsTkRHu5I2WZZm/hosMjUCKAjrQsMCU0rm2ZW
         LNUsE667trHiKch0U60NIbxRm7tOEDmV4oMgAcDMuuh2PlNMm3moB4Dc1rGXHPHumtjq
         +1YQ==
X-Gm-Message-State: AOAM530cEC3sKXcT7yHVF07PM5KZhH5gg6NArfOmab6n4WWZQp0sp+82
        NmFOVCesImHvErG2BAVGJXA=
X-Google-Smtp-Source: ABdhPJzSq41NOGFPIVddi9Ip9Vo0oSHcoCBoG7JmEJiUUAk3c9bVD79HtxuyXJdRc9xFd3VfjuPrJQ==
X-Received: by 2002:a05:6402:c10:b0:40f:33cd:a39 with SMTP id co16-20020a0564020c1000b0040f33cd0a39mr23038572edb.234.1645474763115;
        Mon, 21 Feb 2022 12:19:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id 23sm5681807ejf.175.2022.02.21.12.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:19:22 -0800 (PST)
Message-ID: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
Date:   Mon, 21 Feb 2022 21:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
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
Content-Language: en-US
Subject: [PATCH v2 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
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

v2:
- (re-)add Andreas' SoB to two patches
- fix YAML issues
- include ctype.h explicitly
- add info message in probe()

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
 .../bindings/auxdisplay/titanmec,tm1628.yaml  |  88 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
 drivers/auxdisplay/Kconfig                    |  10 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/tm1628.c                   | 376 ++++++++++++++++++
 drivers/spi/spi-bitbang-txrx.h                |  66 +++
 drivers/spi/spi-gpio.c                        |  42 +-
 9 files changed, 642 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
 create mode 100644 drivers/auxdisplay/tm1628.c

-- 
2.35.1

