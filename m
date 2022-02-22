Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B74BF7EE
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 13:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiBVMMb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 07:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBVMMa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 07:12:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4C2DAAB;
        Tue, 22 Feb 2022 04:12:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DCA621121;
        Tue, 22 Feb 2022 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645531923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBS4PZuC5+c1ZpU++txl+EIwtRqM8ZeskcgSWVW+4/k=;
        b=WTn7eaAkRSaOG5LGXQqzUZ0ovpX2fidrabSGjkykDgrODy1E7xLzR7fpQA03NZSJxxgnil
        G+eBDe6QBZY7Rk5iVmrpIxYYNkQ3l/rv+ClXHrTxgbvR3sBi46KMc9Be4veoYCx2emHpmi
        33x7EFwoTvN40NeXMXTnT76gbT+NIL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645531923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBS4PZuC5+c1ZpU++txl+EIwtRqM8ZeskcgSWVW+4/k=;
        b=QVdm7W7T3DPjo2X5wYH2dArPdbrExgsn4WmWtY6w+3kAnYUCgkSFVkZJgcCf8FCVUIaRxQ
        Y8/tyYmp7YzZM1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37B3E13BA0;
        Tue, 22 Feb 2022 12:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OhssDBPTFGJfNQAAMHmgww
        (envelope-from <afaerber@suse.de>); Tue, 22 Feb 2022 12:12:03 +0000
Message-ID: <a890337b-39e4-f796-2d53-05edd2d69c80@suse.de>
Date:   Tue, 22 Feb 2022 13:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
 <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
 <862fc0e3-6c76-8dea-6725-a6c45ade1ecd@suse.de>
 <09bf3d8a-2902-723b-80d2-0c4d1c24f53d@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
In-Reply-To: <09bf3d8a-2902-723b-80d2-0c4d1c24f53d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19.02.22 18:16, Heiner Kallweit wrote:
> On 19.02.2022 17:07, Andreas Färber wrote:
>> Hi,
>>
>> On 19.02.22 14:37, Heiner Kallweit wrote:
>>> On 19.02.2022 14:27, Miguel Ojeda wrote:
>>>> On Sat, Feb 19, 2022 at 2:13 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>
>>>>> This series adds support for the Titanmec TM1628 7 segment display
>>>>> controller. It's based on previous RFC work from Andreas Färber.
>>>>> The RFC version placed the driver in the LED subsystem, but this was
>>>>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>>>>> /drivers/auxdisplay what seems most reasonable to me.
>>>>
>>>> Could you please link to the discussion and/or summarize the rationale
>>>> behind the NAK?
>>>>
>>>
>>> +Pavel
>>>
>>> I didn't find an explicit reason, but I suppose Pavel sees this driver as
>>> one that makes use of the LED subsystem, but doesn't belong to it.
>>> In the following mail he's expressing his opinion that the driver should
>>> be best placed under auxdisplay.
>>>
>>> https://lore.kernel.org/linux-arm-kernel/20200226130300.GB2800@duo.ucw.cz/
>>
>> And I disagreed. It does not fit with the other drivers in auxdisplay
>> that were operating on a much higher level.
>>
> 
> We need to find a place. And if Pavel has good reasons that it doesn't
> fit into the LED subsystem, and Miguel should be fine with having
> it in auxdisplay, then I'd see no reason to not go this way.
> 
>> I'd also like to point out that I did implement the map_to_7segment API,
> 
> Looking at the history of include/uapi/linux/map_to_7segment.h I see no
> commit from you. Seems I'm missing something here.

You're replying inline too early:

>> as was suggested, as you will find in my tree

As I said, I implemented it in my driver:

https://github.com/afaerber/linux/commit/bbecf951348c7de8ba922c6c002a09369b717d82

Thus me saying you are unnecessarily duplicating work that I already
did, without ping'ing the thread or me and claiming the credit for an
implementation change which I already did myself.

>> - which you may have
>> missed, referencing only the RFC patchset and putting your authorship on
>> it exclusively? A move from one directory to another should not warrant
>> my author and SoB getting removed from the actual driver.
>>
> The driver includes major changes and I mentioned your work in the commit
> message. Also your still listed as MODULE_AUTHOR. My intention is to
> get a driver upstream, not to earn credits for something.
> So sure, your SoB can be (re-)added.

https://github.com/afaerber/linux/commits/rtd1295-next

Also note this 5-in-4 optimization:

https://github.com/afaerber/linux/commit/ff8284b6ed9dc1e354c35840afdaf50b1cd97fea

And several more chipsets being covered.

>> Given that we need to manage a buffer with bits per segment or LED
>> symbol, one idea that I haven't found time for yet was to implement it
>> as framebuffer or drm device instead. (And most Realtek platforms got
>> broken by removing the adjustable text base defines.)
>>
> I'm not aware of the Realtek platform issue, do you have a link to a
> related discussion?

Realtek has a boot ROM at the beginning of memory space, which has been
a problem from the first RFC and for most bootloaders required to tweak
the kernel's text offset for successful boot. (Some not Open Source (LK)
and/or not openly flashable.)

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/487718.html

In 2020 that arm64 feature got removed without any further discussion:

https://lore.kernel.org/all/20200825135440.11288-1-ardb@kernel.org/

I've tried to revert it, but that's been a pain:

https://github.com/afaerber/linux/commit/0d2c647781bc89ee95bfa7b80d71237c7ebea230

> And wouldn't you think it's overengineering to
> write a DRM driver for a 7 segment display with 4 digits?
> Framebuffer seems to be deprecated based on my experience with
> pygame / SDL2.

Is there any other API that would allow userspace to write to the buffer
and bitblt parts to the SPI device?

Thinking of some optimizations I implemented in my driver to avoid
unnecessary SPI transfers:

https://github.com/afaerber/linux/commit/46c40209db163a81474c6894ebbd90b5e238ce60

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Ivo Totev
HRB 36809 (AG Nürnberg)
