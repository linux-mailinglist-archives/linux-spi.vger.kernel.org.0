Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1086E4DD062
	for <lists+linux-spi@lfdr.de>; Thu, 17 Mar 2022 22:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiCQVui (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Mar 2022 17:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCQVuh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Mar 2022 17:50:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90A7A99F;
        Thu, 17 Mar 2022 14:49:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r10so9265558wrp.3;
        Thu, 17 Mar 2022 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=JXgwUv3v5D0fNnLgd4LktJrygnlNSpO2SFDyowKvJBc=;
        b=L4M3aNeFTBhljqC63W8UdBt3ArHtCmxtpMnHG9XBZS4/vhZdp5fWUxulJSP7HkJhD2
         1jjk/RKg8eUAV2M1MFAQhYBEQAcQ7U/rd0JTIMmXXPs7sNGLFztw+6Eh0mXAxbNemWd7
         UBU77ZTzvw11unbZApqINXA/GGzRBJ/TyYltTi7Vx6t8VaVZRdLY8eoCEgdFF3pq1xOW
         E+unDmcxcrqWF3/IPjBk98EriuoaBIe7Ga1xz0FarFQ2HTmPbACHAlITX/UFDV7L/sqC
         UCfmmKvTEmI4XXotGFeffvoprkT4RDmBx7NapaioQHckKhNN/8dfmsYElLQ1+Azft+gt
         nbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=JXgwUv3v5D0fNnLgd4LktJrygnlNSpO2SFDyowKvJBc=;
        b=jnT7TM3CPjBUCQVo1mQo1poZF7x6MP10rLv/qbWOO7ONduzj456UJsRIHY7sWMjd3a
         QBUylHeuTuy2pkmLHe28h5F9HTKis7y8JyMBbLfvykwFgpguOrZ4Qa+iorSzIKxVGlFa
         MBpu+bIisQKk7TY90fmzJA7EhitaObnERyTWGBcTVda9Zwoj4stF2QnUbb4HnkAxsZwr
         jA/Pqmj86hUpXAFz1DVdQuUD0uj+GPP/YALLXVb1llPw0nnll64HH+UlRfADGtypxTR3
         Gy8olcP7rnMRQYFdPvC8NL9N7katRZU5QtcrJ0sbUomC9lSO0FMCHkSMSdI1quBzmN1C
         /oNQ==
X-Gm-Message-State: AOAM531lTk569MP45F1Uz8XAK2XuhqdV5EFMcDyG4Db/kOmj/9TSErPZ
        nkAv4RG/9JZ0QUVgAM8WEIiJLAa3pNo=
X-Google-Smtp-Source: ABdhPJznx632WvFxaqb8yflLyhf6kA//k1q6bVXc6ZNqxGH7xDitPUOU1Q2r5XVUYBj/MyiD9xXVqg==
X-Received: by 2002:adf:e34c:0:b0:1ed:c3fc:2dcf with SMTP id n12-20020adfe34c000000b001edc3fc2dcfmr5804993wrj.430.1647553757589;
        Thu, 17 Mar 2022 14:49:17 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a2b:e900:a8b8:ece6:31f7:15f4? (dynamic-2a01-0c22-7a2b-e900-a8b8-ece6-31f7-15f4.c22.pool.telefonica.de. [2a01:c22:7a2b:e900:a8b8:ece6:31f7:15f4])
        by smtp.googlemail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm4945246wri.14.2022.03.17.14.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:49:16 -0700 (PDT)
Message-ID: <953246ad-282b-c182-cbf6-3caa28979dbc@gmail.com>
Date:   Thu, 17 Mar 2022 22:49:13 +0100
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
 <84739af1-cbb8-e957-6e30-4121ed0a3517@gmail.com>
 <132a5a99-6dbf-12d4-723b-2a327f23d24e@arm.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
In-Reply-To: <132a5a99-6dbf-12d4-723b-2a327f23d24e@arm.com>
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

On 17.03.2022 21:08, Robin Murphy wrote:
> On 2022-03-16 21:19, Heiner Kallweit wrote:
>> On 16.03.2022 01:38, Robin Murphy wrote:
>>> On 2022-02-25 21:09, Heiner Kallweit wrote:
>>>> This series adds support for the Titanmec TM1628 7 segment display
>>>> controller. It's based on previous RFC work from Andreas Färber.
>>>> The RFC version placed the driver in the LED subsystem, but this was
>>>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>>>> /drivers/auxdisplay what seems most reasonable to me.
>>>>
>>>> Further changes to the RFC version:
>>>> - Driver can be built also w/o LED class support, for displays that
>>>>     don't have any symbols to be exposed as LED's.
>>>> - Simplified the code and rewrote a lot of it.
>>>> - Driver is now kind of a MVP, but functionality should be sufficient
>>>>     for most use cases.
>>>> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>>>>     as suggested by Geert Uytterhoeven.
>>>>
>>>> Note: There's a number of chips from other manufacturers that are
>>>>         almost identical, e.g. FD628, SM1628. Only difference I saw so
>>>>         far is that they partially support other display modes.
>>>>         TM1628: 6x12, 7x11
>>>>         SM1628C: 4x13, 5x12, 6x11, 7x10
>>>>         For typical displays on devices using these chips this
>>>>         difference shouldn't matter.
>>>>
>>>> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
>>>> display with 4 digits and 7 symbols.
>>>
>>> FWIW I gave this a go on my Beelink A1, which has an AiP1618 and a clock display which would mapped like so:
>>>
>>>      titanmec,segment-mapping = /bits/ 8 <1 2 3 13 12 5 4>;
>>>      titanmec,grid = /bits/ 8 <5 4 2 1>;
>>>
>>> (grid 3 segment 2 is used for a colon in the middle)
>>>
>>> If I bodge around the lack of support for non-contiguous grids, it does otherwise work fairly well, other than being 6-segment displays because it needs to be in display mode 1 to drive SEG13 rather than GRID6. I wonder if we could be a bit cleverer about picking a display mode based on the grid/segment numbers used?
>>>
>> Definitely this could be one future extension. It could also consider that there's a number of more or less
>> identical chips from other vendors that differ primarily in the supported display modes.
>>
>>> I also have a couple of those TM1638 breakout boards with 8 digits, 8 single LEDs and 8 buttons that I might have a go with too. Have you given any thought to how the DT binding might support inputs as well? (The best time to be future-proof is before it's merged...)
>>>
>> With regards to inputs at least I have no plans because I have no hw supporting input.
> 
> FWIW, if you've got a board with exposed GPIO/SPI headers, searching "TM1638" on ebay/aliexpress/etc. should find the cheapo breakout boards. I believe they're quite popular with the Arduino crowd, so I expect that may well carry over to the Raspberry Pi crowd once they get wind of a kernel driver that can be driven by DT overlays.
> 
>> Since the first attempts to support this LED driver hw two years have been passed w/o any tangible (mainline) result.
>> Therefore I want to keep the initial version a MVP. Wanting to have too many features in an initial version
>> may result in longer discussions until maintainer or I give up.
> 
> Unfortunately the principle is that DT bindings describe the device, not whatever the current level of Linux driver support for it might be. Perhaps I'm a little sensitised since I'm currently feeling the pain of extending a decade-old binding with functionality that was overlooked at the time, and not breaking compatibility is now rather awkward.
> 
> I'm not suggesting that there needs to be any support implemented in the driver, just to be certain that we're not painting ourselves into a corner with the binding.
> 
>> Important is that user space interface / DT bindings are flexible enough so that future extensions don't have to break
>> existing users. And I think that's the case.
> 
> May I ask what you have in mind? I figure that inputs would most likely want to be described individually, similarly to the gpio-keys binding, which would lend itself to having them as child nodes, except that doesn't fit with the current scheme of child nodes having to be LEDs addressed by (grid,segment). I suppose there is a possible escape hatch of abusing unused addresses, e.g. saying a node at address (0,n) is input n rather than an LED segment, but that seems pretty horrid (and I'm not sure how well schema could validate it). Or possibly pretending to also be a GPIO controller to reference from a separate gpio-keys node, but again that seems ugly and more like something to only do if there's no other option.
> 

Not being an expert in OF stuff I'm just focused on getting support for the hw I own.
I tried to do this in the most simple and generic way so that others can follow-up
and add additional functionality.


> IMO it would be cleanest just to have an extra level of hierarchy, e.g.:
> 
> 
>     led-controller@0 {
>         compatible = "titanmec,tm1628";
>         ...
> 
>         leds {
>             #address-cells = <2>;
>             #size-cells = <0>;
> 
>             alarm@5,4 {
>                 ...
>             };
>         };
>     };
> 
> That way there's clearly almost no risk of breakage if an additional "inputs" node with its own children turns up later. Plus it should also be a trivial change to the current driver, compared to having to implement trick special cases or whole other APIs down the line - of course bindings should not be designed expressly for ease of driver implementation, but if they do work out that way it's usually a good sign :)
> 
> Thanks,
> Robin.

Heiner
