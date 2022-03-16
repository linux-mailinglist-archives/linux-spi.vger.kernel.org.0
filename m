Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE04DA6F5
	for <lists+linux-spi@lfdr.de>; Wed, 16 Mar 2022 01:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbiCPAkH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Mar 2022 20:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAkG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Mar 2022 20:40:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D73B31203;
        Tue, 15 Mar 2022 17:38:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA8661476;
        Tue, 15 Mar 2022 17:38:52 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AA973F73D;
        Tue, 15 Mar 2022 17:38:50 -0700 (PDT)
Message-ID: <8d138801-5447-5e88-25d2-3eb13d294530@arm.com>
Date:   Wed, 16 Mar 2022 00:38:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-GB
To:     Heiner Kallweit <hkallweit1@gmail.com>,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2022-02-25 21:09, Heiner Kallweit wrote:
> This series adds support for the Titanmec TM1628 7 segment display
> controller. It's based on previous RFC work from Andreas Färber.
> The RFC version placed the driver in the LED subsystem, but this was
> NAK'ed by the LED maintainer. Therefore I moved the driver to
> /drivers/auxdisplay what seems most reasonable to me.
> 
> Further changes to the RFC version:
> - Driver can be built also w/o LED class support, for displays that
>    don't have any symbols to be exposed as LED's.
> - Simplified the code and rewrote a lot of it.
> - Driver is now kind of a MVP, but functionality should be sufficient
>    for most use cases.
> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>    as suggested by Geert Uytterhoeven.
> 
> Note: There's a number of chips from other manufacturers that are
>        almost identical, e.g. FD628, SM1628. Only difference I saw so
>        far is that they partially support other display modes.
>        TM1628: 6x12, 7x11
>        SM1628C: 4x13, 5x12, 6x11, 7x10
>        For typical displays on devices using these chips this
>        difference shouldn't matter.
> 
> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
> display with 4 digits and 7 symbols.

FWIW I gave this a go on my Beelink A1, which has an AiP1618 and a clock 
display which would mapped like so:

	titanmec,segment-mapping = /bits/ 8 <1 2 3 13 12 5 4>;
	titanmec,grid = /bits/ 8 <5 4 2 1>;

(grid 3 segment 2 is used for a colon in the middle)

If I bodge around the lack of support for non-contiguous grids, it does 
otherwise work fairly well, other than being 6-segment displays because 
it needs to be in display mode 1 to drive SEG13 rather than GRID6. I 
wonder if we could be a bit cleverer about picking a display mode based 
on the grid/segment numbers used?

I also have a couple of those TM1638 breakout boards with 8 digits, 8 
single LEDs and 8 buttons that I might have a go with too. Have you 
given any thought to how the DT binding might support inputs as well? 
(The best time to be future-proof is before it's merged...)

Cheers,
Robin.

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
>    dt-bindings: vendor-prefixes: Add Titan Micro Electronics
> 
> Heiner Kallweit (5):
>    dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
>    docs: ABI: document tm1628 attribute display-text
>    auxdisplay: add support for Titanmec TM1628 7 segment display
>      controller
>    arm64: dts: meson-gxl-s905w-tx3-mini: add support for the 7 segment
>      display
>    MAINTAINERS: Add entry for tm1628 auxdisplay driver
> 
>   .../testing/sysfs-devices-auxdisplay-tm1628   |   7 +
>   .../bindings/auxdisplay/titanmec,tm1628.yaml  |  92 +++++
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   MAINTAINERS                                   |   7 +
>   .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |  59 +++
>   drivers/auxdisplay/Kconfig                    |  11 +
>   drivers/auxdisplay/Makefile                   |   1 +
>   drivers/auxdisplay/tm1628.c                   | 376 ++++++++++++++++++
>   8 files changed, 555 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>   create mode 100644 drivers/auxdisplay/tm1628.c
> 
