Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D081E257961
	for <lists+linux-spi@lfdr.de>; Mon, 31 Aug 2020 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHaMfP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Aug 2020 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgHaMdZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Aug 2020 08:33:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80CC061239;
        Mon, 31 Aug 2020 05:33:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so8300647ejc.2;
        Mon, 31 Aug 2020 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hbcUYwYW/xJDLtbCqjA6b7sU1ZfzYZFemLdx1cJX5XA=;
        b=CWi+7MgN9lN1o9/Gla8LTUEZXuTqcW621vsMgcTys05vudCBxOQqVdt3eIxg0xZ684
         Z5LS2jOzihJoWu7RUij/ngwzO7OPP3gDvJUKpfXSWF15+pVlnd2JbEffONNHLckeiBbn
         XMUItGS/S5un58oWy/8dNw42Dm3Eee+28ijJ507vL2p7jzbZVY3/5KD1vF5PzPRQdJGj
         UE+yFphAlabWPDjXUgLmZgBNPpcLL+Q+9YEuila8S/qRU9BJJJLGEpOh4/4nSyxCIAhi
         TumItxAqUhVGFyDvkYYLYNf1eTJmKW4lAwO+YIPF8o/ZRMToQiiklPKlFInSiC0k64b8
         6pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbcUYwYW/xJDLtbCqjA6b7sU1ZfzYZFemLdx1cJX5XA=;
        b=SlkFXePxOeUAE0+19+8e61hxgems+DDifClHROeejzXxiiJL07RzSo2tpoDyqkuwAh
         lcs/ZC3WbKVtcEfPf7mKvlmi7aRTxJqJWJK0hrlhyVV2yL9Lc06/Hg8daa+lRMYTmCLM
         KnO0JpkMYAlMfLYLDo4AEpI3nuzJ0Rw+Tdw+We86HsHXpxmAr4Z4mpQZ/Y0X1VfPQ1OZ
         3DQ+TtUyxB24nPQcLS0erzQ7uWNMdJ6IC0kn/9kw5e+VESBgl/jvGUrkbcLfgwQcUjAA
         /LCQzNBajDbpjWZ7dzUX4F1rQ3nxlZGcHk4Zw1toB169AjGMpXzCZHctnCl81fLtXz8L
         b7vA==
X-Gm-Message-State: AOAM5308qzc6gXPCPy/6nV+9KIc/O1B0+pG/P+6uVDhBTNtoYeIzkj+o
        n6i7U+FuswkMB8KxmKHOylVOrvCYG8Bn6A==
X-Google-Smtp-Source: ABdhPJy/8IkFbalv91EKccdsv+UO41f+dzMA/FEZXgFGihTYsRlXiL+amrnzkGKIBJJQ7odSUi1VYA==
X-Received: by 2002:a17:906:6884:: with SMTP id n4mr1017257ejr.50.1598877202929;
        Mon, 31 Aug 2020 05:33:22 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:b116:6da2:9c8c:de81? (p200300ea8f235700b1166da29c8cde81.dip0.t-ipconnect.de. [2003:ea:8f23:5700:b116:6da2:9c8c:de81])
        by smtp.googlemail.com with ESMTPSA id r26sm8090266ejb.102.2020.08.31.05.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 05:33:22 -0700 (PDT)
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
 <5ca7ba48-ef9c-2b7c-67ff-88d0a2c9f380@gmail.com>
 <6a9eb498-2982-05de-52f9-da5f6a626e49@alliedtelesis.co.nz>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <5bf05188-a52e-c8c0-9d2d-c87eff6f1588@gmail.com>
Date:   Mon, 31 Aug 2020 14:33:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6a9eb498-2982-05de-52f9-da5f6a626e49@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30.08.2020 23:59, Chris Packham wrote:
> 
> On 31/08/20 9:41 am, Heiner Kallweit wrote:
>> On 30.08.2020 23:00, Chris Packham wrote:
>>> On 31/08/20 12:30 am, Nicholas Piggin wrote:
>>>> Excerpts from Chris Packham's message of August 28, 2020 8:07 am:
>>> <snip>
>>>
>>>>>>>>> I've also now seen the RX FIFO not empty error on the T2080RDB
>>>>>>>>>
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>>>>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>>>>>>>
>>>>>>>>> With my current workaround of emptying the RX FIFO. It seems
>>>>>>>>> survivable. Interestingly it only ever seems to be 1 extra byte in the
>>>>>>>>> RX FIFO and it seems to be after either a READ_SR or a READ_FSR.
>>>>>>>>>
>>>>>>>>> fsl_espi ffe110000.spi: tx 70
>>>>>>>>> fsl_espi ffe110000.spi: rx 03
>>>>>>>>> fsl_espi ffe110000.spi: Extra RX 00
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>>>>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>>>>>>> fsl_espi ffe110000.spi: tx 05
>>>>>>>>> fsl_espi ffe110000.spi: rx 00
>>>>>>>>> fsl_espi ffe110000.spi: Extra RX 03
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>>>>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>>>>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>>>>>>> fsl_espi ffe110000.spi: tx 05
>>>>>>>>> fsl_espi ffe110000.spi: rx 00
>>>>>>>>> fsl_espi ffe110000.spi: Extra RX 03
>>>>>>>>>
>>>>>>>>>    From all the Micron SPI-NOR datasheets I've got access to it is
>>>>>>>>> possible to continually read the SR/FSR. But I've no idea why it
>>>>>>>>> happens some times and not others.
>>>>>>>> So I think I've got a reproduction and I think I've bisected the problem
>>>>>>>> to commit 3282a3da25bd ("powerpc/64: Implement soft interrupt replay in
>>>>>>>> C"). My day is just finishing now so I haven't applied too much scrutiny
>>>>>>>> to this result. Given the various rabbit holes I've been down on this
>>>>>>>> issue already I'd take this information with a good degree of skepticism.
>>>>>>>>
>>>>>>> OK, so an easy test should be to re-test with a 5.4 kernel.
>>>>>>> It doesn't have yet the change you're referring to, and the fsl-espi driver
>>>>>>> is basically the same as in 5.7 (just two small changes in 5.7).
>>>>>> There's 6cc0c16d82f88 and maybe also other interrupt related patches
>>>>>> around this time that could affect book E, so it's good if that exact
>>>>>> patch is confirmed.
>>>>> My confirmation is basically that I can induce the issue in a 5.4 kernel
>>>>> by cherry-picking 3282a3da25bd. I'm also able to "fix" the issue in
>>>>> 5.9-rc2 by reverting that one commit.
>>>>>
>>>>> I both cases it's not exactly a clean cherry-pick/revert so I also
>>>>> confirmed the bisection result by building at 3282a3da25bd (which sees
>>>>> the issue) and the commit just before (which does not).
>>>> Thanks for testing, that confirms it well.
>>>>
>>>> [snip patch]
>>>>
>>>>> I still saw the issue with this change applied. PPC_IRQ_SOFT_MASK_DEBUG
>>>>> didn't report anything (either with or without the change above).
>>>> Okay, it was a bit of a shot in the dark. I still can't see what
>>>> else has changed.
>>>>
>>>> What would cause this, a lost interrupt? A spurious interrupt? Or
>>>> higher interrupt latency?
>>>>
>>>> I don't think the patch should cause significantly worse latency,
>>>> (it's supposed to be a bit better if anything because it doesn't set
>>>> up the full interrupt frame). But it's possible.
>>> My working theory is that the SPI_DON indication is all about the TX
>>> direction an now that the interrupts are faster we're hitting an error
>>> because there is still RX activity going on. Heiner disagrees with my
>>> interpretation of the SPI_DON indication and the fact that it doesn't
>>> happen every time does throw doubt on it.
>>>
>> It's right that the eSPI spec can be interpreted that SPI_DON refers to
>> TX only. However this wouldn't really make sense, because also for RX
>> we program the frame length, and therefore want to be notified once the
>> full frame was received. Also practical experience shows that SPI_DON
>> is set also after RX-only transfers.
>> Typical SPI NOR use case is that you write read command + start address,
>> followed by a longer read. If the TX-only interpretation would be right,
>> we'd always end up with SPI_DON not being set.
>>
>>> I can't really explain the extra RX byte in the fifo. We know how many
>>> bytes to expect and we pull that many from the fifo so it's not as if
>>> we're missing an interrupt causing us to skip the last byte. I've been
>>> looking for some kind of off-by-one calculation but again if it were
>>> something like that it'd happen all the time.
>>>
>> Maybe it helps to know what value this extra byte in the FIFO has. Is it:
>> - a duplicate of the last read byte
>> - or the next byte (at <end address> + 1)
>> - or a fixed value, e.g. always 0x00 or 0xff
> 
> The values were up thread a bit but I'll repeat them here
> 
> fsl_espi ffe110000.spi: tx 70
> fsl_espi ffe110000.spi: rx 03
> fsl_espi ffe110000.spi: Extra RX 00
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
> fsl_espi ffe110000.spi: tx 05
> fsl_espi ffe110000.spi: rx 00
> fsl_espi ffe110000.spi: Extra RX 03
> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
> fsl_espi ffe110000.spi: tx 05
> fsl_espi ffe110000.spi: rx 00
> fsl_espi ffe110000.spi: Extra RX 03
> 
> 
> The rx 00 Extra RX 03 is a bit concerning. I've only ever seen them with
> either a READ_SR or a READ_FSR. Never a data read.
> 
Just remembered something about SPIE_DON:
Transfers are always full duplex, therefore in case of a read the chip
sends dummy zero's. Having said that in case of a read SPIE_DON means
that the last dummy zero was shifted out.

READ_SR and READ_FSR are the shortest transfers, 1 byte out and 1 byte in.
So the issue may have a dependency on the length of the transfer.
However I see no good explanation so far. You can try adding a delay of
a few miroseconds between the following to commands in fsl_espi_bufs().

	fsl_espi_write_reg(espi, ESPI_SPIM, mask);

	/* Prevent filling the fifo from getting interrupted */
	spin_lock_irq(&espi->lock);

Maybe enabling interrupts and seeing the SPIE_DON interrupt are too close.
