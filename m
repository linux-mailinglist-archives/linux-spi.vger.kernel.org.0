Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44567524D4A
	for <lists+linux-spi@lfdr.de>; Thu, 12 May 2022 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353941AbiELMq2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 May 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353967AbiELMq1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 May 2022 08:46:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08D6D1CEEE7;
        Thu, 12 May 2022 05:46:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90B5E106F;
        Thu, 12 May 2022 05:46:19 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0D03F66F;
        Thu, 12 May 2022 05:46:17 -0700 (PDT)
Message-ID: <695be0af-b642-af0c-052a-f4c05df7424f@arm.com>
Date:   Thu, 12 May 2022 13:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-GB
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
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
 <CANiq72m+OVcX1gPit94D1hjzkduyVFoCWXKSXTxpUDFtKs8z6g@mail.gmail.com>
 <aa97c09e-aa82-e2c4-326e-991330e65de7@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <aa97c09e-aa82-e2c4-326e-991330e65de7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2022-04-24 10:06, Heiner Kallweit wrote:
> On 23.04.2022 22:57, Miguel Ojeda wrote:
>> On Fri, Feb 25, 2022 at 10:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>> This series adds support for the Titanmec TM1628 7 segment display
>>> controller. It's based on previous RFC work from Andreas Färber.
>>
>> AFAIU the discussion has converged at this point, correct? Is there
>> any feedback left to address?
>>
> Still open is to define DT bindings that can support also the key input
> feature of the chip. Robin picked up this topic and has some ideas.

Sorry this slipped through the cracks again... :(

As mentioned, I think the discovery of the "linux,keymap" alleviates the 
concern I had with the binding - it seemed ugly to have to invent a 
device-specific property that worked that way, but if a common one 
already exists that's a different matter. I'm pretty confident now that 
the ideas I have for supporting the input side of things and the other 
16x8 chips that I have here can all be done as pure additions with no 
compatibility concerns, so from my PoV I'm happy if you want to go ahead 
and land this as-is for 5.19, and I can send patches later.

Cheers,
Robin.
