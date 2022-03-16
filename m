Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68FB4DBA0A
	for <lists+linux-spi@lfdr.de>; Wed, 16 Mar 2022 22:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiCPVUr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Mar 2022 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiCPVUq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Mar 2022 17:20:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F2DEA1;
        Wed, 16 Mar 2022 14:19:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h13so4305274ede.5;
        Wed, 16 Mar 2022 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=o8rjaWS1kfQZmN1hTJ3APAjZ2xrksFfaFvhOkPsgO/0=;
        b=n1f2rXKXrM7GLXVHcIR9Ey9z1Tpj6D41cpuSOTyWjpX8YONkPMsd2X556MgDIgqq5B
         cisGlxWsn3NSD1MJkOmiHTHrl48s74HCgRgJnmOZIHPBwW9kpo6JDPTnWXhG9g7+F5Uc
         tNVo6qQ1cd8wFOS66TL/z0GqaxfzAUinoAYlcX27MPTM0L/sCUAgP3oUxysoDg5/o8ey
         OsmYj9O3M1UFUFhaVySCodOj1CNmW08UjH5e69GWA4nbYycmk9BIVYXk3UbAWU8v7wP6
         blnfcCijOqb/GmBvQkoVZz1BUoNyOmf8Xw0fV8tlhmly6lL5T3LN5PJmXD5UfTowc8Ca
         2V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=o8rjaWS1kfQZmN1hTJ3APAjZ2xrksFfaFvhOkPsgO/0=;
        b=NqpyMCRWvuhWQPS1MaaRt+nc9Y9nPjl/Db6I4CdeCgr1LB4sob3iRU0kfrZLe+nvXA
         PKVYi9+8HtSVIDZlCrdKvxUw9zE/aI5k4hLLv2WjQRxoW7T6kiSr7n+OYoPrC+k3Gix8
         YZ02St4FTOxI6nu9/bhrsMrEEq1gYWplUP7b3y5+DKK+MIurcjWfg00OPNJr/JGgNONK
         mRjPOh309R1xjqMJ60JvWbX2rqkVd3I6nzIjoAh/VJuZWPA9zdC9qBVYhSph9m9v3Uph
         wHMW2IxyiM4Jl6xN8mlUcvNl69vKZ2Z3Fa5LQVgMXEXpQd+8GizpIPislIdIY5DnWtMa
         R7cA==
X-Gm-Message-State: AOAM532sFsGnnbtuLgIwRCPw8rjvaSTZx3fPt6pRL2hY7dAKVONjX13U
        tDrrFjKGk1Q2/xzqLSztkyE=
X-Google-Smtp-Source: ABdhPJw5w9N6SzTa9alUk6xMWAdxIogVq5xsyUm17wjP374+ZXAH4XG78RNMvKJavxDEKPcpIQH7yQ==
X-Received: by 2002:aa7:d945:0:b0:418:f041:f9bc with SMTP id l5-20020aa7d945000000b00418f041f9bcmr1318719eds.305.1647465568992;
        Wed, 16 Mar 2022 14:19:28 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b866:cc00:e490:2de6:a89f:9b66? (dynamic-2a01-0c23-b866-cc00-e490-2de6-a89f-9b66.c23.pool.telefonica.de. [2a01:c23:b866:cc00:e490:2de6:a89f:9b66])
        by smtp.googlemail.com with ESMTPSA id b19-20020aa7dc13000000b00418eef0a019sm874793edu.34.2022.03.16.14.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 14:19:28 -0700 (PDT)
Message-ID: <84739af1-cbb8-e957-6e30-4121ed0a3517@gmail.com>
Date:   Wed, 16 Mar 2022 22:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
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
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
 <8d138801-5447-5e88-25d2-3eb13d294530@arm.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
In-Reply-To: <8d138801-5447-5e88-25d2-3eb13d294530@arm.com>
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

On 16.03.2022 01:38, Robin Murphy wrote:
> On 2022-02-25 21:09, Heiner Kallweit wrote:
>> This series adds support for the Titanmec TM1628 7 segment display
>> controller. It's based on previous RFC work from Andreas Färber.
>> The RFC version placed the driver in the LED subsystem, but this was
>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>> /drivers/auxdisplay what seems most reasonable to me.
>>
>> Further changes to the RFC version:
>> - Driver can be built also w/o LED class support, for displays that
>>    don't have any symbols to be exposed as LED's.
>> - Simplified the code and rewrote a lot of it.
>> - Driver is now kind of a MVP, but functionality should be sufficient
>>    for most use cases.
>> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>>    as suggested by Geert Uytterhoeven.
>>
>> Note: There's a number of chips from other manufacturers that are
>>        almost identical, e.g. FD628, SM1628. Only difference I saw so
>>        far is that they partially support other display modes.
>>        TM1628: 6x12, 7x11
>>        SM1628C: 4x13, 5x12, 6x11, 7x10
>>        For typical displays on devices using these chips this
>>        difference shouldn't matter.
>>
>> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
>> display with 4 digits and 7 symbols.
> 
> FWIW I gave this a go on my Beelink A1, which has an AiP1618 and a clock display which would mapped like so:
> 
>     titanmec,segment-mapping = /bits/ 8 <1 2 3 13 12 5 4>;
>     titanmec,grid = /bits/ 8 <5 4 2 1>;
> 
> (grid 3 segment 2 is used for a colon in the middle)
> 
> If I bodge around the lack of support for non-contiguous grids, it does otherwise work fairly well, other than being 6-segment displays because it needs to be in display mode 1 to drive SEG13 rather than GRID6. I wonder if we could be a bit cleverer about picking a display mode based on the grid/segment numbers used?
> 
Definitely this could be one future extension. It could also consider that there's a number of more or less
identical chips from other vendors that differ primarily in the supported display modes.

> I also have a couple of those TM1638 breakout boards with 8 digits, 8 single LEDs and 8 buttons that I might have a go with too. Have you given any thought to how the DT binding might support inputs as well? (The best time to be future-proof is before it's merged...)
> 
With regards to inputs at least I have no plans because I have no hw supporting input.
Since the first attempts to support this LED driver hw two years have been passed w/o any tangible (mainline) result.
Therefore I want to keep the initial version a MVP. Wanting to have too many features in an initial version
may result in longer discussions until maintainer or I give up.
Important is that user space interface / DT bindings are flexible enough so that future extensions don't have to break
existing users. And I think that's the case.

> Cheers,
> Robin.
> 

Heiner

>> v2:
>> - (re-)add Andreas' SoB to two patches
>> - fix YAML issues
>> - include ctype.h explicitly
>> - add info message in probe()
>>
>> v3:
>> - remove patch 1 because it has been applied via the SPI tree already
>> - fix remaining YAML issues in patch 2
>> - follow Miguel's suggestion on usage of Co-Developed-by
>>
>> v4:
>> - add patch for MAINTAINERS entry
>> - incorporate Miguel's review comments
>> - Replace Co-Developed-by with Co-developed-by (checkpatch)
>> v5:
>> - add vendor prefix to driver-specific dt properties
>>
>> Andreas Färber (1):
>>    dt-bindings: vendor-prefixes: Add Titan Micro Electronics
>>
>> Heiner Kallweit (5):
>>    dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
>>    docs: ABI: document tm1628 attribute display-text
>>    auxdisplay: add support for Titanmec TM1628 7 segment display
>>      controller
>>    arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment
>>      display
>>    MAINTAINERS: Add entry for tm1628 auxdisplay driver
>>
>>   .../testing/sysfs-devices-auxdisplay-tm1628   |   7 +
>>   .../bindings/auxdisplay/titanmec,tm1628.yaml  |  92 +++++
>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>   MAINTAINERS                                   |   7 +
>>   .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
>>   drivers/auxdisplay/Kconfig                    |  11 +
>>   drivers/auxdisplay/Makefile                   |   1 +
>>   drivers/auxdisplay/tm1628.c                   | 376 ++++++++++++++++++
>>   8 files changed, 555 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
>>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>   create mode 100644 drivers/auxdisplay/tm1628.c
>>

