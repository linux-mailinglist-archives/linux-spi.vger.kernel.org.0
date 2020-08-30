Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A13E2570C2
	for <lists+linux-spi@lfdr.de>; Sun, 30 Aug 2020 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgH3VlT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 30 Aug 2020 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VlQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 30 Aug 2020 17:41:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E63C061573;
        Sun, 30 Aug 2020 14:41:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba12so3716643edb.2;
        Sun, 30 Aug 2020 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=flkqAUAGSpmzpt/BTyP/u7Uv4MTDnK9nGy4kWyS0QGo=;
        b=u71Dr6TY0sD/uSIJYQEuGVHJCQGYmaY0GU+G58XVwH8WR64ZTGNn1UEmJbohP5d92q
         u1PBtJK0dC8tuCvqztGjmwS/zYAL+p3ekXU0PkvQltj/tmyZP176jAyHONR0hNqtV2kq
         4SG0WjG6NLcxcggj6DPd9adsbtSkj6hxkYcBG1C5moP1LvPDQBRV773a8TZCdTBCAw+c
         Gp2MVg5+4lvwPk9SCgCyju7FcgWi2zQLlTNz7ghIB9cg1ZSsy7nDejP6cEKCHRPRosug
         QqJ9UVNrac+OBO4Cs1F/EqOoqqMPc7A8qLgzd4DR+TYh3UgdxkZeOmpKEG9Ttzlf0Py6
         l/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=flkqAUAGSpmzpt/BTyP/u7Uv4MTDnK9nGy4kWyS0QGo=;
        b=sPnwHD0BgQ3uwS3xYi7TAIE0ipSEsfabfHgzjoW+SwQFc5oBgCM26I4ZdXwZu2qBsU
         NnP42MDKOJX2f+Wne2e/VAP40igVpF7vyUfXLbGhs90346pDFxF3w9f1bQ55DDXWI+4/
         eKOXJPBhCjWBlrkX3VF7JWOkKmVvz+4mRYn8KwW7AYi7hzdEAnyRkAKFmtorn2zJxXFR
         xYGM9Oi39SqO+Rim/gXHH0mS/WmfiyUt7Y1BieW6SU5mJeESTbkUY2Alv5rg7dM0+Bae
         W+uPzGNb7RKYB6dVIr0ka4eQjrvylpiTT0YCqwuJosTRDnNZkWACwUaGKn1GUZEXkDip
         LoRA==
X-Gm-Message-State: AOAM530sB3yVKkY/J9ibYO0Tk2Rx5wANCqPQKpgwNvcXUx/U4hSGkrJE
        yZG7JRIA9rKtm3z6M94jNDzDj0peGQLr0A==
X-Google-Smtp-Source: ABdhPJz3o5Zk2bTMguju6wk5PKk2UphvYY9jIjAZMA4V/FqbZruJ7mdUtaopyePbbsOAmnHOuioFCQ==
X-Received: by 2002:a50:f197:: with SMTP id x23mr5560626edl.367.1598823674095;
        Sun, 30 Aug 2020 14:41:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:b849:b64c:7fd2:8e54? (p200300ea8f235700b849b64c7fd28e54.dip0.t-ipconnect.de. [2003:ea:8f23:5700:b849:b64c:7fd2:8e54])
        by smtp.googlemail.com with ESMTPSA id n15sm5671590eja.26.2020.08.30.14.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 14:41:13 -0700 (PDT)
Subject: Re: fsl_espi errors on v5.7.15
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Nicholas Piggin <npiggin@gmail.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <42107721-614b-96e8-68d9-4b888206562e@alliedtelesis.co.nz>
 <1020029e-4cb9-62ba-c6d6-e6b9bdf93aac@gmail.com>
 <1598510348.1g7wt0s02s.astroid@bobo.none>
 <0068446e-06f8-6648-2f40-56f324c1ee6e@alliedtelesis.co.nz>
 <1598788275.m90vz24p6x.astroid@bobo.none>
 <524a0f50-f954-f5a7-eccb-66eece59c7c4@alliedtelesis.co.nz>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5ca7ba48-ef9c-2b7c-67ff-88d0a2c9f380@gmail.com>
Date:   Sun, 30 Aug 2020 23:41:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <524a0f50-f954-f5a7-eccb-66eece59c7c4@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30.08.2020 23:00, Chris Packham wrote:
> 
> On 31/08/20 12:30 am, Nicholas Piggin wrote:
>> Excerpts from Chris Packham's message of August 28, 2020 8:07 am:
> 
> <snip>
> 
>>>>>>> I've also now seen the RX FIFO not empty error on the T2080RDB
>>>>>>>
>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>>>>>
>>>>>>> With my current workaround of emptying the RX FIFO. It seems
>>>>>>> survivable. Interestingly it only ever seems to be 1 extra byte in the
>>>>>>> RX FIFO and it seems to be after either a READ_SR or a READ_FSR.
>>>>>>>
>>>>>>> fsl_espi ffe110000.spi: tx 70
>>>>>>> fsl_espi ffe110000.spi: rx 03
>>>>>>> fsl_espi ffe110000.spi: Extra RX 00
>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>>>>> fsl_espi ffe110000.spi: tx 05
>>>>>>> fsl_espi ffe110000.spi: rx 00
>>>>>>> fsl_espi ffe110000.spi: Extra RX 03
>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>>>>> fsl_espi ffe110000.spi: tx 05
>>>>>>> fsl_espi ffe110000.spi: rx 00
>>>>>>> fsl_espi ffe110000.spi: Extra RX 03
>>>>>>>
>>>>>>>   From all the Micron SPI-NOR datasheets I've got access to it is
>>>>>>> possible to continually read the SR/FSR. But I've no idea why it
>>>>>>> happens some times and not others.
>>>>>> So I think I've got a reproduction and I think I've bisected the problem
>>>>>> to commit 3282a3da25bd ("powerpc/64: Implement soft interrupt replay in
>>>>>> C"). My day is just finishing now so I haven't applied too much scrutiny
>>>>>> to this result. Given the various rabbit holes I've been down on this
>>>>>> issue already I'd take this information with a good degree of skepticism.
>>>>>>
>>>>> OK, so an easy test should be to re-test with a 5.4 kernel.
>>>>> It doesn't have yet the change you're referring to, and the fsl-espi driver
>>>>> is basically the same as in 5.7 (just two small changes in 5.7).
>>>> There's 6cc0c16d82f88 and maybe also other interrupt related patches
>>>> around this time that could affect book E, so it's good if that exact
>>>> patch is confirmed.
>>> My confirmation is basically that I can induce the issue in a 5.4 kernel
>>> by cherry-picking 3282a3da25bd. I'm also able to "fix" the issue in
>>> 5.9-rc2 by reverting that one commit.
>>>
>>> I both cases it's not exactly a clean cherry-pick/revert so I also
>>> confirmed the bisection result by building at 3282a3da25bd (which sees
>>> the issue) and the commit just before (which does not).
>> Thanks for testing, that confirms it well.
>>
>> [snip patch]
>>
>>> I still saw the issue with this change applied. PPC_IRQ_SOFT_MASK_DEBUG
>>> didn't report anything (either with or without the change above).
>> Okay, it was a bit of a shot in the dark. I still can't see what
>> else has changed.
>>
>> What would cause this, a lost interrupt? A spurious interrupt? Or
>> higher interrupt latency?
>>
>> I don't think the patch should cause significantly worse latency,
>> (it's supposed to be a bit better if anything because it doesn't set
>> up the full interrupt frame). But it's possible.
> 
> My working theory is that the SPI_DON indication is all about the TX 
> direction an now that the interrupts are faster we're hitting an error 
> because there is still RX activity going on. Heiner disagrees with my 
> interpretation of the SPI_DON indication and the fact that it doesn't 
> happen every time does throw doubt on it.
> 
It's right that the eSPI spec can be interpreted that SPI_DON refers to
TX only. However this wouldn't really make sense, because also for RX
we program the frame length, and therefore want to be notified once the
full frame was received. Also practical experience shows that SPI_DON
is set also after RX-only transfers.
Typical SPI NOR use case is that you write read command + start address,
followed by a longer read. If the TX-only interpretation would be right,
we'd always end up with SPI_DON not being set.

> I can't really explain the extra RX byte in the fifo. We know how many 
> bytes to expect and we pull that many from the fifo so it's not as if 
> we're missing an interrupt causing us to skip the last byte. I've been 
> looking for some kind of off-by-one calculation but again if it were 
> something like that it'd happen all the time.
> 
Maybe it helps to know what value this extra byte in the FIFO has. Is it:
- a duplicate of the last read byte
- or the next byte (at <end address> + 1)
- or a fixed value, e.g. always 0x00 or 0xff


