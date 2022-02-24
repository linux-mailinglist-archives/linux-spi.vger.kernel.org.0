Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB04C366D
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiBXUBT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiBXUBQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:01:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46C2763FF;
        Thu, 24 Feb 2022 12:00:45 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gb39so6658197ejc.1;
        Thu, 24 Feb 2022 12:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=/3kA9B1qVgjYJF+SPVMwxfyRv6VJXrJiJNZPzVdWdOQ=;
        b=QP1PhqsGteaJ1Pk5bUu1Y6dowRlHW/8xVAOcBIRgMCnLM38ltbIMyntMQLEy6hbznN
         zQ5IenipVoKjTfdLcvjBFw1c+zvd4l1V0MVpPOUAtuToSJnjraPdEpmqFQjjs2KdPx2b
         ijtkt4bvTP4xYviTKEB5Xh9B/oDiOZL5mtjuAluiX5v/XbqjKiB8D9RgdhZYzz1+S+Y6
         ysVhbw8KlS2QuJBuhpY8B+CiWGffmLQYUKJWjE8oP3lESxDwxY6lLIEC3bfmZxJNTa13
         ve46tD6ilSG8DiBRbz/XqYT4JpZ5vfClcAj0fhZ1sAbxUXxTeWI8aNj39+JY15M4OJ+W
         fYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=/3kA9B1qVgjYJF+SPVMwxfyRv6VJXrJiJNZPzVdWdOQ=;
        b=StEfzlcD4ZrEphjN0PE3pYYvojYMMozAClwk6lJuoKAbBOhUKjW7RKOt7ve8sSv5X+
         Hugv13QjOrDRc1d+Swd7SCptqSdgSUBLRonlcD4CXgWB7PJg48WnB9GYiM3UKXX3544i
         lwq1uCyFL9s8fHaZn94Y8U/NuTrHjlEwi3PPb9ZM30YGf2dyv2du9BfBJGxVCxNTumEk
         5b1u5saoZPHaQ0gD2FUjqLF4UI9BU0PFFEhmwTqT87nIjzqUysrwo1rXDTFvdZbyxy+m
         nK3P5whnFPGU/KGrjeAK5yrBO/eJjgFA5gDWsWLVCM7TzQBR/3Vt0BQPSsIIqATH8hUh
         am0Q==
X-Gm-Message-State: AOAM533OLcR7qiDO0L2JdJ7uLd7JYoip+cqwiXvEIdnLnxrhyg1LXVPa
        w7gnkt0fU3Ts3fKmg3/C2/0=
X-Google-Smtp-Source: ABdhPJxFuo+w3f/fLXUoO65roHhS9Ju3YJUgRZLjHzRtMgwLmAc/7c33PkT5jyB2MjVZDbbIFn7UYw==
X-Received: by 2002:a17:906:3152:b0:6cf:d100:a8b2 with SMTP id e18-20020a170906315200b006cfd100a8b2mr3541028eje.529.1645732843880;
        Thu, 24 Feb 2022 12:00:43 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm103209ejy.165.2022.02.24.12.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:00:43 -0800 (PST)
Message-ID: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
Date:   Thu, 24 Feb 2022 21:00:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 0/6] auxdisplay: Add support for the Titanmec TM1628 7
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

v4:
- add patch for MAINTAINERS entry
- incorporate Miguel's review comments
- Replace Co-Developed-by with Co-developed-by (checkpatch)

Andreas Färber (1):
  dt-bindings: vendor-prefixes: Add Titan Micro Electronics

Heiner Kallweit (5):
  dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
  docs: ABI: document tm1628 attribute display-text
  auxdisplay: add support for Titanmec TM1628 7 segment display
    controller
  arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment
    display
  MAINTAINERS: Add entry for tm1628 auxdisplay driver

 .../testing/sysfs-devices-auxdisplay-tm1628   |   7 +
 .../bindings/auxdisplay/titanmec,tm1628.yaml  |  92 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
 drivers/auxdisplay/Kconfig                    |  11 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/tm1628.c                   | 376 ++++++++++++++++++
 8 files changed, 555 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
 create mode 100644 drivers/auxdisplay/tm1628.c

-- 
2.35.1

