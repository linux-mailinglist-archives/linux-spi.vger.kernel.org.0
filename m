Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1873E11D0A8
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 16:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfLLPPD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 10:15:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:34634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbfLLPPD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Dec 2019 10:15:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A95F9ADDF;
        Thu, 12 Dec 2019 15:15:00 +0000 (UTC)
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191212033952.5967-5-afaerber@suse.de>
 <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <9b4b6287-c1d9-1b41-88a8-7ac9fe222642@suse.de>
Date:   Thu, 12 Dec 2019 16:14:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

Am 12.12.19 um 09:40 schrieb Geert Uytterhoeven:
> On Thu, Dec 12, 2019 at 4:41 AM Andreas Färber <afaerber@suse.de> wrote:
>> Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.
>>
>> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
>> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".
>>
>> Conditionally call them from all the spi-gpio txrx_word callbacks.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
> 
> Thanks for your patch!

NP. I prefer fixing issues at the source over awkward workarounds. :)

>> --- a/drivers/spi/spi-gpio.c
>> +++ b/drivers/spi/spi-gpio.c
>> @@ -135,25 +135,37 @@ static inline int getmiso(const struct spi_device *spi)
>>  static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
>>                 unsigned nsecs, u32 word, u8 bits, unsigned flags)
>>  {
>> -       return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
>> +       if (unlikely(spi->mode & SPI_LSB_FIRST))
>> +               return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
>> +       else
>> +               return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
>>  }
> 
> Duplicating all functions sounds a bit wasteful to me.

Two functions duplicated, eight function calls duplicated.

> What about reverting the word first, and calling the normal functions?
> 
>     if (unlikely(spi->mode & SPI_LSB_FIRST)) {
>             if (bits <= 8)
>                     word = bitrev8(word) >> (bits - 8);
>             else if (bits <= 16)
>                     word = bitrev16(word) >> (bits - 16);
>             else
>                     word = bitrev32(word) >> (bits - 32);
>     }
>     return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);

Hm, wasn't aware of those helpers, so I opted not to loop over the bits
for reversing myself, as Thomas Gleixner disliked bit loops in irqchip.
Performance appeared to be a concern here, too.

Eight functions duplicated then. I don't like that - at least we should
pack that into an inline helper or macro, to not copy&paste even more
lines around. Who knows, maybe we'll get 64-bit support at one point?

Do you think it would be acceptable to instead encapsulate this inside
the _be inline helpers? That would lead the name ad absurdum, of course,
but we would then need to do it only twice, not eight times.

However, either way would seem to make the LSB code path slower than MSB
due to the prepended reversal.

Delays are already stubbed out, with open TODOs for further inlining
functions that are being dispatched today.

So from that angle I don't see a better way than either duplicating the
functions or using some macro magic to #include the header twice. If we
wanted to go down that path, we could probably de-duplicate the existing
two functions, too, but I was trying to err on the cautious side, since
I don't have setups to test all four code paths myself (and a ton of
more relevant but less fun patches to flush out ;)).

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
