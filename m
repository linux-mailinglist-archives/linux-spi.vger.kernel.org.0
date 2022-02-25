Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863BB4C505B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiBYVJx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiBYVJw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:09:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D892186465;
        Fri, 25 Feb 2022 13:09:19 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g20so9105580edw.6;
        Fri, 25 Feb 2022 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=r+q3BnS/yso16BsfWpj6w5rHbh3h6hD4bXPBdy/jvnw=;
        b=SQL4BzgeZziN33zoc6V/odBjyMQxLclakUGEpkl/6UCYpqfkMIREM07lR4PB83NC93
         1SX+v7FtmA9tMGYAeC06LGaulgvP43oncv6HMhI1e5YZN0fTVwXtNZ1Ed0QkKBkdRkrR
         U2aKy61UxG0yaWWyYOX/XfoQvyR2WMNJMtqGZOsvryyVl3uokTqWnct5m478wtKG13mI
         velXDoyOrmafbDCUejXxUUVtRgR13jQmi813xhv4hIjlXKPy1ZmU26YKC9GkP7gredi5
         0VHzs7zthOKrXh2CRmKIXmuBMhSRQzdUAZPQxTcdT3dXAJOV7WnYkg+sQ6ZNgeKDAQL8
         qmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=r+q3BnS/yso16BsfWpj6w5rHbh3h6hD4bXPBdy/jvnw=;
        b=kjEnjh6aWOL3qP64WhJ5Cc4vH5yqMUK907PGLohSnfagF/IAYU7H8B6BrFQYqTMnCt
         zbHK7YHGc9i67vH35tTVrIWL2uHnIG8pJg3OyWZ5jQF4D71NYtuyaVtw2goKmApFplg2
         rhli2oa8TVQJWrCc/zJyYQ7QC/JsWTweKpz/lSiLd8NUsia3wehdu1Ji1aJZOaHN4GRe
         yUzlAVF7PXdScOj8hv4rgF9R0bkkFcVLJqEpweJnZVghMnRKq9RFjAASkjCxBrymg7Gx
         AuqQypu7VsGwiYNxNIoAoBqtcVm7hsubaGkqkcIVPz6DeP1h3l7mnifIIft+4NBWBdVi
         E4vw==
X-Gm-Message-State: AOAM530tjUY9V6IEBlQcjggt7Tei2DchJ6qv0Wse03lTzAWp6RmRUD57
        rcrZlsbl0gWjV0jH09vut8w=
X-Google-Smtp-Source: ABdhPJydKnvqx3rNZJ9qOOIWYHnadxaIIv4GvoIfoNio5jMICEuJlGcgOaL1GudECWijxYd8LzIKrg==
X-Received: by 2002:a05:6402:50cb:b0:412:ab6d:c807 with SMTP id h11-20020a05640250cb00b00412ab6dc807mr8879863edb.382.1645823357711;
        Fri, 25 Feb 2022 13:09:17 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id r3-20020aa7cb83000000b0040decce18bdsm1838499edt.99.2022.02.25.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:09:17 -0800 (PST)
Message-ID: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
Date:   Fri, 25 Feb 2022 22:09:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
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
v5:
- add vendor prefix to driver-specific dt properties

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

