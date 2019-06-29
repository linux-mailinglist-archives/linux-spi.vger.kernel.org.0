Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E465A9E2
	for <lists+linux-spi@lfdr.de>; Sat, 29 Jun 2019 11:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfF2JnU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 29 Jun 2019 05:43:20 -0400
Received: from server101.serverconfig.center ([195.242.103.101]:37561 "EHLO
        server101.serverconfig.center" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfF2JnU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 29 Jun 2019 05:43:20 -0400
Received: from christian-pc.localdomain (p2E5940A8.dip0.t-ipconnect.de [46.89.64.168])
        by server101.serverconfig.center (Postfix) with ESMTPSA id 6E1F72382A2F;
        Sat, 29 Jun 2019 11:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-mauderer.de;
        s=default; t=1561801398;
        bh=Fllw7ZiKyrkEBs2EreOkeQXcUFAZL36fcIGmxlrm+nM=; l=3607;
        h=Subject:From:To;
        b=HhZ70wqXT8isy25IaEd34VRO90urx/QCml45FR7Blj8+VywHNTusBPZJc3WN7a8X4
         54rWJDAT1g//X6EfchVLkbt0JjIcCcJWKRO74EgxnwMAL2gS9xttIU7N8lqXt4g5ao
         +K5xKFAkWhv0TT0N8+jc1fVwyWw/6Ef7ISzoAp/s=
Authentication-Results: server101.serverconfig.center;
        spf=pass (sender IP is 46.89.64.168) smtp.mailfrom=oss@c-mauderer.de smtp.helo=christian-pc.localdomain
Received-SPF: pass (server101.serverconfig.center: connection is authenticated)
Subject: Re: spi-gpio too fast for some devices
From:   Christian Mauderer <oss@c-mauderer.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
 <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
 <20190624132352.GL5316@sirena.org.uk>
 <7e9d963c-9402-979c-1dbd-51e548a15652@c-mauderer.de>
Message-ID: <a1cb37c8-dc05-3827-0646-3bf58937a19b@c-mauderer.de>
Date:   Sat, 29 Jun 2019 11:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7e9d963c-9402-979c-1dbd-51e548a15652@c-mauderer.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <156180139859.14335.3577005838699042217@server101.serverconfig.center>
X-PPP-Vhost: c-mauderer.de
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/06/2019 20:58, Christian Mauderer wrote:
> On 24/06/2019 15:23, Mark Brown wrote:
>> On Sat, Jun 22, 2019 at 07:45:50AM +0200, Christian Mauderer wrote:
>>> On 10/06/2019 18:56, Christian Mauderer wrote:
>>
>>>> I have a problem with the spi-gpio driver: It's too fast for one of my
>>>> devices. Now I'm searching for a good solution that could be
>>>> acceptable as a patch for the Linux kernel.
>>
>>>> Currently there is the following comment and implementation for the
>>>> spidelay(...) function in spi-gpio.c:
>>
>>>>> /*
>>>>>  * NOTE:  this clocks "as fast as we can".  It "should" be a function of the
>>>>>  * requested device clock.  Software overhead means we usually have trouble
>>>>>  * reaching even one Mbit/sec (except when we can inline bitops), so for now
>>>>>  * we'll just assume we never need additional per-bit slowdowns.
>>>>>  */
>>>>> #define spidelay(nsecs)	do {} while (0)
>>
>>>>> #define spidelay(nsecs)	ndelay(nsecs)
>>
>>>> which basically works. But with that the maximum rate drops to 1.6MHz.
>>>> I assume that such a drastic performance decrease isn't acceptable for
>>>> the kernel?
>>
>> Yes, I can't imagine that other users are going to be happy with a
>> performance reduction like that.
>>
>>>> Any directions for how an acceptable implementation could look like?
>>
>> Off the top of my head you probably need to build a second copy of the
>> code with the delays included and then select that copy depending on the
>> speed that's been requested for the device and the speed of the system
>> somehow.  The actual bitbanging is in a header so that makes it a bit
>> easier to build two copies than it might otherwise be.
>>
> 
> Hello Mark,
> 
> thanks for the answer and the direction. I'll have a look at the driver
> and try to create a rough plan which function I can replace without
> creating too much of copy and paste code and without loosing too much
> performance. I'm not sure yet where a good location would be to decide
> which function should be used depending on the speed but I'll try to
> find one.
> 
> I'll report back as soon as I have a plan and (maybe) at least a sketch
> for a patch. Most likely that will need some time because I only do that
> in my free time.
> 
> Best regards
> 
> Christian
> 

Hello Mark,

I had a look at my options for slowing down the spi-gpio in some cases:

== Approach 1:

With some preprocessor magic I could create two sets of bitbang
functions (bitbang_txrx_be_cpha0/1 and bitbang_txrx_be_cpha0/1_slow). I
can then decide which of the functions to use in
spi_gpio_txrx_word_mode0 (and similar functions) based on the nsecs
value. For example if (nsecs > 1000) use bitbang_txrx_be_cpha0_slow()
function otherwise use bitbang_txrx_be_cpha0().

This approach would add a minimal delay between the bytes but not in the
bits. It would allow to have fast and slow devices on the same bus. But
it's a little intransparent from a user perspective because there is
some special (hard coded) speed where the behaviour changes.

== Approach 2:

Add a kernel config option to allow the user to select whether he wants
maximum speed or the possibility to slow down the SPI bus. Default would
be the same as it is now.

That is very simple to implement. It doesn't allow to mix slow and fast
devices but it is quite clear from a user perspective and can be
documented via a kernel option. Due to that I would slightly prefer that
approach.

What do you think: Would one of these be acceptable as a solution?

With kind regards

Christian
