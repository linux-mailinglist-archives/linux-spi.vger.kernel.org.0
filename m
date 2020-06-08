Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D431F174D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jun 2020 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgFHLLW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jun 2020 07:11:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgFHLLU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Jun 2020 07:11:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EA8B1FB;
        Mon,  8 Jun 2020 04:11:18 -0700 (PDT)
Received: from [10.57.9.113] (unknown [10.57.9.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 239553F73D;
        Mon,  8 Jun 2020 04:11:14 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>, lukas@wunner.de
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
Date:   Mon, 8 Jun 2020 12:11:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020-06-05 23:04, Florian Fainelli wrote:
> On 6/5/2020 7:41 AM, Robin Murphy wrote:
>> On 2020-06-05 14:46, Robin Murphy wrote:
>>> On 2020-06-05 14:20, Mark Brown wrote:
>>>> On Fri, Jun 05, 2020 at 12:34:36PM +0100, Robin Murphy wrote:
>>>>> On 2020-06-04 22:28, Florian Fainelli wrote:
>>>>
>>>>>> For the BCM2835 case which is deemed performance critical, we would
>>>>>> like
>>>>>> to continue using an interrupt handler which does not have the extra
>>>>>> comparison on BCM2835_SPI_CS_INTR.
>>>>
>>>>> FWIW, if I'm reading the patch correctly, then with sensible codegen
>>>>> that
>>>>> "overhead" should amount to a bit test on a live register plus a
>>>>> not-taken
>>>>> conditional branch - according to the 1176 TRM that should add up to a
>>>>> whopping 2 cycles. If that's really significant then I'd have to wonder
>>>>> whether you want to be at the mercy of the whole generic IRQ stack
>>>>> at all,
>>>>> and should perhaps consider using FIQ instead.
>>>>
>>>> Yes, and indeed the compiler does seem to manage that.  It *is* non-zero
>>>> overhead though.
>>>
>>> True, but so's the existing level of pointer-chasing indirection that
>>> with some straightforward refactoring could be taken right out of the
>>> critical path and confined to just the conditional complete() call.
>>> That's the kind of thing leaving me unconvinced that this is code
>>> where every single cycle counts ;)
>>
>> Ha, and in fact having checked a build out of curiosity, this patch
>> as-is actually stands to make things considerably worse. At least with
>> GCC 8.3 and bcm2835_defconfig, bcm2835_spi_interrupt_common() doesn't
>> get inlined, which means bcm2835_spi_interrupt() pushes/pops a stack
>> frame and makes an out-of-line call to bcm2835_spi_interrupt_common(),
>> resulting in massively *more* work than the extra two instructions of
>> simply inlining the test.
>>
>> So yes, the overhead of inlining the test vs. the alternative is indeed
>> non-zero. It's just also negative :D
> 
> Is it reliable across compiler versions if we use __always_inline?
> 
> The only other alternative that I can think of is using a static key to
> eliminate the test for the single controller case. This feels highly
> over engineered, but if that proves more reliable and gets everybody
> their cookie, why not.

Again, 2 cycles. The overhead of a static key alone is at least 50% of 
that. And that's not even considering whether the change in code layout 
caused by doubling up the IRQ handler might affect I-cache or branch 
predictor behaviour, where a single miss stands to more than wipe out 
any perceived saving. And all in code that has at least one obvious 
inefficiency left on the table either way.

This thread truly epitomises Knuth's "premature optimisation" quote... ;)

Robin.

> 
> Lukas, do you have any way to test with the conditional being present
> that the performance or latency does not suffer so much that it becomes
> unacceptable for your use cases?
> 
