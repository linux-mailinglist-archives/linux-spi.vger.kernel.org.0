Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEA4D204B
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 19:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiCHSdm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 13:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349778AbiCHSd3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 13:33:29 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258AA6276;
        Tue,  8 Mar 2022 10:32:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so11701269wma.4;
        Tue, 08 Mar 2022 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=uiU2u9h2P4tMLPAe7w64PoUebLSo9Vimwlwo8ylFYLs=;
        b=ZwAztZtFBE9ICDMx0F3PPj7WRyX+tq8A6OHCNCfEmCeJWT7zhe+EVI4u6bK5b+GFhC
         V6pneVKJ7An6d5wgItrBuQO3z5QaOiFe0SNsR/FVwf4cRuNL0/t7gd2dbyjY2rSL7R6R
         TiI/nwlU1ys+gq7vRc1ZAXEpxJTskbtXKadT86cmZGE23w2CLFi0I+4/1+yosFsKnRDa
         Y7gFsEjY2XtdBO0lPHeGaa7hBje3CAE65GU9EoZaa+oJxkTffyUtAAvV2K0803l22451
         sMKweqa53WQugohaSivzRZ/EyY2rajSA8OOpov8Dxhpe+C5PZGSSN79P7lJ8Ny1TXSgV
         7iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=uiU2u9h2P4tMLPAe7w64PoUebLSo9Vimwlwo8ylFYLs=;
        b=A7d/XYBWmNHnIIT3RwYlPNjw4ae1RRPyNa8g1BIGxMVGj3LX8KcXIVZuDib1IlcNSE
         Y9F0+pVYgYyUK1jTH1/PbcV0u6bluGu6mYbPyuUCjt/iwjSQo6BMpE2AKLxNyz1IoVdo
         Itx3mhb4YXGW41OkBQTkMZXcSEWY/23JREyKt+1LLWaEoDoFc2F5FAMGHzBJgHvQBRPb
         s7PXWei4q77aFqkoYllQz3Bqx5HpciP899Yak1WMlkEyzCrc1CSEmLYA8Dx8iRZtFhIZ
         lI/Fz9dShBPduuWzcovT3L2ikSEIaacYI6wDgxNqUIRrRtOHMzt2lI3jDLT/Vhrv9eK0
         S8qw==
X-Gm-Message-State: AOAM530moj+DAjTsi5RfQTtLp9Z4Kw+DWZD/wBuSHkL+K1Bz2M5hpgXC
        5myTkFxumErUBL1FSwRt4GM=
X-Google-Smtp-Source: ABdhPJwxxmXjnDwNblhPpgodX9P8Rc2PWUzV6dK2oRmU4xtLcqoNvCsHvmIlKWLEgCvKz5HpP7IARw==
X-Received: by 2002:a1c:acc6:0:b0:380:e35f:ff1f with SMTP id v189-20020a1cacc6000000b00380e35fff1fmr4736527wme.52.1646764349476;
        Tue, 08 Mar 2022 10:32:29 -0800 (PST)
Received: from ?IPV6:2a01:c22:7b54:500:3175:f9ac:af86:a778? (dynamic-2a01-0c22-7b54-0500-3175-f9ac-af86-a778.c22.pool.telefonica.de. [2a01:c22:7b54:500:3175:f9ac:af86:a778])
        by smtp.googlemail.com with ESMTPSA id f8-20020adfb608000000b0020229d72a4esm3032670wre.38.2022.03.08.10.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:32:28 -0800 (PST)
Message-ID: <c3342c4d-85e7-b9dd-7fd5-b84b8fc850a4@gmail.com>
Date:   Tue, 8 Mar 2022 19:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25.02.2022 22:09, Heiner Kallweit wrote:
> This series adds support for the Titanmec TM1628 7 segment display
> controller. It's based on previous RFC work from Andreas Färber.
> The RFC version placed the driver in the LED subsystem, but this was
> NAK'ed by the LED maintainer. Therefore I moved the driver to
> /drivers/auxdisplay what seems most reasonable to me.
> 
> Further changes to the RFC version:
> - Driver can be built also w/o LED class support, for displays that
>   don't have any symbols to be exposed as LED's.
> - Simplified the code and rewrote a lot of it.
> - Driver is now kind of a MVP, but functionality should be sufficient
>   for most use cases.
> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>   as suggested by Geert Uytterhoeven.
> 
> Note: There's a number of chips from other manufacturers that are
>       almost identical, e.g. FD628, SM1628. Only difference I saw so
>       far is that they partially support other display modes.
>       TM1628: 6x12, 7x11
>       SM1628C: 4x13, 5x12, 6x11, 7x10
>       For typical displays on devices using these chips this
>       difference shouldn't matter.
> 
> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
> display with 4 digits and 7 symbols.
> 
> v2:
> - (re-)add Andreas' SoB to two patches
> - fix YAML issues
> - include ctype.h explicitly
> - add info message in probe()
> 
> v3:
> - remove patch 1 because it has been applied via the SPI tree already
> - fix remaining YAML issues in patch 2
> - follow Miguel's suggestion on usage of Co-Developed-by
> 
> v4:
> - add patch for MAINTAINERS entry
> - incorporate Miguel's review comments
> - Replace Co-Developed-by with Co-developed-by (checkpatch)
> v5:
> - add vendor prefix to driver-specific dt properties
> 
> Andreas Färber (1):
>   dt-bindings: vendor-prefixes: Add Titan Micro Electronics
> 
> Heiner Kallweit (5):
>   dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
>   docs: ABI: document tm1628 attribute display-text
>   auxdisplay: add support for Titanmec TM1628 7 segment display
>     controller
>   arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment
>     display
>   MAINTAINERS: Add entry for tm1628 auxdisplay driver
> 
>  .../testing/sysfs-devices-auxdisplay-tm1628   |   7 +
>  .../bindings/auxdisplay/titanmec,tm1628.yaml  |  92 +++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   7 +
>  .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
>  drivers/auxdisplay/Kconfig                    |  11 +
>  drivers/auxdisplay/Makefile                   |   1 +
>  drivers/auxdisplay/tm1628.c                   | 376 ++++++++++++++++++
>  8 files changed, 555 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>  create mode 100644 drivers/auxdisplay/tm1628.c
> 

Hi Miguel,

the DT extensions have been acked/reviewed.
Any other feedback from your side? Or can it be applied as-is?

Heiner
