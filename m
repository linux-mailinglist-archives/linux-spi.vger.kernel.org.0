Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656C911E538
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 15:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfLMOHl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 09:07:41 -0500
Received: from foss.arm.com ([217.140.110.172]:60532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbfLMOHk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Dec 2019 09:07:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A39139F;
        Fri, 13 Dec 2019 06:07:39 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AB773F52E;
        Fri, 13 Dec 2019 06:07:34 -0800 (PST)
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        csd@princeton.com.tw, devicetree@vger.kernel.org, sales@fdhisi.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, zypeng@titanmec.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Dan Murphy <dmurphy@ti.com>,
        linux-rockchip@lists.infradead.org
References: <20191212033952.5967-1-afaerber@suse.de>
 <7110806f-ddbd-f055-e107-7a1f7e223102@arm.com>
 <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
Date:   Fri, 13 Dec 2019 14:07:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/12/2019 8:55 pm, Andreas Färber wrote:
> Hi Robin,
> 
> [- Roc He, + linux-rockchip]
> 
> Am 12.12.19 um 14:14 schrieb Robin Murphy:
>> On 12/12/2019 3:39 am, Andreas Färber wrote:
>>> This patch series implements the LED controllers found in some RTD1295
>>> based
>>> TV set-top boxes.
> [...]
>>> TM1628 and related chipsets have an internal Display RAM, from which they
>>> control a two-dimensional array of LED components, often used for
>>> seven-segment displays, i.e. clock display, but also for indicators.
>>> Individual LEDs can be turned on/off, but brightness is applied globally.
>>> Some chipsets also support polling a two-dimensional key pad.
> [...]
>>> Some more notes:
>>> * Public TM1628 V1.1 datasheet is in Chinese only and differs from the
>>>     unversioned English version found elsewhere on datasheet sites by
>>>     documenting more display modes, included here (guessed from Arabic
>>> numbers).
>>> * Public FD628 datasheet is Chinese only (guesses based on Arabic
>>> numbers).
>>>     FD623 appears to have more output lines, which would fit current
>>> data types.
>>> * AiP1618 links were all broken (404); try Google "site:szfdwdz.com"
>>> search
>>>     to actually find the documents available on their site.
>>> * Princeton PT6964 is another related LED controller with public
>>> datasheet
>>>     that I did not encounter in my TV boxes yet, thus not included here.
>>>     Datasheets are linked only for PT6959 and PT6967, but PT6964 V1.3
>>> and V1.4
>>>     are available elsewhere. PT6967 has more output lines, which my
>>> current
>>>     data types could barely hold. Maybe bump them all to u32 type right
>>> away?
>>> * TM1628 is also found on MeLE V9 TV box, to be tested.
>>> * FD628 is also found on Amlogic S905X2 based Vontar X96 Max TV box,
>>>     to be tested (once UART is soldered).
>>> * AiP1618 was found on Ava and Lake I TV boxes, to be tested.
>>> * It remained unclear to me which of these many similar chipsets was
>>> first.
>>>     My driver name is therefore based on the chip I encountered first.
>>
>> It's pretty cool to see this!
> 
> Glad someone else finds it useful. :)
> 
>> My Rockchip box has an AiP1618-driven
>> display [...]
> 
> You don't mention the model: Does it have a mainline .dts we can extend?
> If not, I'd ask you to get that merged into -next, then I can happily
> pick up patches adding the LED controller for your TV box into this
> series as it evolves. (I'm expecting at least two more RFC iterations.)

It's the Beelink A1, which we have indeed just landed a DT for - I'll 
certainly share whatever patch I come up with. I also have one of the 
H96 Max boxes (which I picked up out of curiosity for the mysterious 
RK3318) with an FD6551, although I've not attacked that one with the 
logic analyser yet to see how similar it is.

> Similarly, I'm planning to drop Xnano X5 in v2, if it doesn't require a
> respin, so that no Realtek-specific parts other than .dts node additions
> remain here.
> 
>> In case it helps, in my research I found that ARTSCHIP are another
>> vendor of these things with accessible datasheets[1],
> 
> Thanks, their HT1628 indeed looks compatible.
> 
> Sunmoon Microelectronics SM1628 also looks compatible.
> http://www.chinaasic.com/product.jsp#item=other#style=27#id=138
> 
>> and as far as I
>> could tell the command set appears to derive from (or is at least common
>> to) some old Holtek VFD controllers.
> 
> Hmm, HT16515 looks similar and has more lines, RAM and mode bits than I
> prepared here.
> https://www.holtek.com/productdetail/-/vg/ht16515
> 
> So I'd need to make more numbers model-dependent and allocate the
> Display RAM buffer dynamically.
> 
> Whereas HT16D35A seems incompatible command-wise, and HT16528 appears to
> be out of scope, for dot displays and with fancy embedded character map.
> 
> No Holtek email alias that I can quickly spot.
> 
> But given that I'm proposing vendor-specific compatibles just in case,
> the main decisions will be the Kconfig symbol and module name. The
> driver code itself we could always refactor after merging, and renaming
> the schema file (as opposed to compatible) should also be possible.

Yeah, I'm not sure that it really matters, as I doubt there are many 
Linux-capable devices with a real VFD anyway; it just seemed like an 
interesting datapoint that fell out of scouring the web trying to find 
any evidence for which the "canonical" 1618 might be (and the Holtek 
connection was actually a coincidence from a misidentification of the 
ARTSCHIP part number).

>> If I can figure out the DT parts (which was one of the areas that
>> stalled my attempt) I'll try to have a play with this series over the
>> holidays.
> 
> That reminded me that I forgot to push - done in the meantime. :)
> 
>> One thought to ponder is that I have an "88:88" display where
>> the entire middle grid is reserved for the colon (which is wired to just
>> one segment) - I'm not sure how that could be sanely described :/
> 
> Well, that sounds exactly like my bindings example and X9S. You'll find
> the colon configured as LED, separate from the four digits, which don't
> need to be contiguous due to separate reg entries per digit.

Aha, yes, I should have engaged the brain a bit more on that one :)

> While it may be possible to put more cleverness into text_store() to set
> the colon as part of five-char "88:88" text, we'd likely want to blink
> it every half second, which we should better do without updating the
> full display text from "88:88" to "88 88". "8888" updated every minute
> sounds less problematic.

Sure - perhaps at that point text_store() could also grow some caching 
and partial update logic to decide if writing individual grids is 
cheaper than clocking out the whole display for a given change, but this 
initial approach does seem good enough to start with. Lumping colons in 
with the other miscellaneous indicators many of these displays have does 
at least have a self-consistent logic in terms of "things that aren't 
7-segment grids".

Thanks,
Robin.

> Ugly with the colon LED is that the redone LED bindings don't yet have a
> function defined for this, so I'm currently misusing whatever was there.
> I should prepare a bindings addition, if we want to use an LED node.
> 
> Regards,
> Andreas
> 
>> [1]
>> http://www.artschip.com/products.asp?lx=small&anid=779&ParentName=Signal%20management%20_I_O%20Extender
>>
>>> This series is based on my not-yet-posted RTD1295 pinctrl and GPIO
>>> drivers.
>>>
>>> Latest experimental patches at:
>>> https://github.com/afaerber/linux/commits/rtd1295-next
> [snip]
> 
