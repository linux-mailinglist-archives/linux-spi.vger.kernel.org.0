Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC85BF00
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfGAPGC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 11:06:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46607 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfGAPGB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 11:06:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id 65so10187011oid.13
        for <linux-spi@vger.kernel.org>; Mon, 01 Jul 2019 08:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+/BeNXpQY3fWUmnHI29BXGihDlVgz9zE0fnn7Yy7wA=;
        b=ndPsNlZAQKNDTBm5HzSSADlo9LrewAV2b8qFqVrBbzzFR9KcT7+VDrixWQNb0d9MXc
         SG8qrUozpwdqzWTeo0WJ20OAJ/mYlw84v87O2jL7f+rjMDMYO3XnBg3tDjJQAgsGWv/E
         AZZj1nM9ok4HMLwxueoZoXtz8ZxLTG83O/C0PW81Y27kEwJ7/JRYTyatjI7jyk7FyRF5
         Dvk5PQJ5RmpI15Z/KvxpKIw5ydxPKFk/YP8nkyVP9TiSKwWHrIOe5iY4LHCYbMIXkjAE
         UiyOnXgjt4JM82cyJKH/aSaLbiZWHNXk//yhEtArHjJBb8Su2h8SFSXMCHSqrbyLqNXC
         /ffA==
X-Gm-Message-State: APjAAAWcMd1Hk20df8xM7nSTrz8XoV804gb12CN8/PcVAGoArgC6tE9x
        MrlHHuZ/PZtUEOxp2tn5rs6+CxGNpS2rxEfp/4Ltmt0C
X-Google-Smtp-Source: APXvYqyUGcSKuYm07SRhXR3vgXmgL7Rnq/dD+H9rsYyrFtH2mYJGY9yOhx3wIolWMKWqd5pgtVnv9gT7LGdZhr36U9Y=
X-Received: by 2002:aca:c4d5:: with SMTP id u204mr6959408oif.131.1561993561175;
 Mon, 01 Jul 2019 08:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
 <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de> <20190624132352.GL5316@sirena.org.uk>
 <7e9d963c-9402-979c-1dbd-51e548a15652@c-mauderer.de> <a1cb37c8-dc05-3827-0646-3bf58937a19b@c-mauderer.de>
In-Reply-To: <a1cb37c8-dc05-3827-0646-3bf58937a19b@c-mauderer.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Jul 2019 17:05:49 +0200
Message-ID: <CAMuHMdX7g0QePv4KustSExjyQOxHyATpShWEVBVyNXLvqon0Dw@mail.gmail.com>
Subject: Re: spi-gpio too fast for some devices
To:     Christian Mauderer <oss@c-mauderer.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Christian,

On Sat, Jun 29, 2019 at 11:44 AM Christian Mauderer <oss@c-mauderer.de> wrote:
> On 24/06/2019 20:58, Christian Mauderer wrote:
> > On 24/06/2019 15:23, Mark Brown wrote:
> >> On Sat, Jun 22, 2019 at 07:45:50AM +0200, Christian Mauderer wrote:
> >>> On 10/06/2019 18:56, Christian Mauderer wrote:
> >>
> >>>> I have a problem with the spi-gpio driver: It's too fast for one of my
> >>>> devices. Now I'm searching for a good solution that could be
> >>>> acceptable as a patch for the Linux kernel.
> >>
> >>>> Currently there is the following comment and implementation for the
> >>>> spidelay(...) function in spi-gpio.c:
> >>
> >>>>> /*
> >>>>>  * NOTE:  this clocks "as fast as we can".  It "should" be a function of the
> >>>>>  * requested device clock.  Software overhead means we usually have trouble
> >>>>>  * reaching even one Mbit/sec (except when we can inline bitops), so for now
> >>>>>  * we'll just assume we never need additional per-bit slowdowns.
> >>>>>  */
> >>>>> #define spidelay(nsecs)   do {} while (0)
> >>
> >>>>> #define spidelay(nsecs)   ndelay(nsecs)
> >>
> >>>> which basically works. But with that the maximum rate drops to 1.6MHz.
> >>>> I assume that such a drastic performance decrease isn't acceptable for
> >>>> the kernel?
> >>
> >> Yes, I can't imagine that other users are going to be happy with a
> >> performance reduction like that.
> >>
> >>>> Any directions for how an acceptable implementation could look like?
> >>
> >> Off the top of my head you probably need to build a second copy of the
> >> code with the delays included and then select that copy depending on the
> >> speed that's been requested for the device and the speed of the system
> >> somehow.  The actual bitbanging is in a header so that makes it a bit
> >> easier to build two copies than it might otherwise be.
> >>
> >
> > Hello Mark,
> >
> > thanks for the answer and the direction. I'll have a look at the driver
> > and try to create a rough plan which function I can replace without
> > creating too much of copy and paste code and without loosing too much
> > performance. I'm not sure yet where a good location would be to decide
> > which function should be used depending on the speed but I'll try to
> > find one.
> >
> > I'll report back as soon as I have a plan and (maybe) at least a sketch
> > for a patch. Most likely that will need some time because I only do that
> > in my free time.
> >
> > Best regards
> >
> > Christian
> >
>
> Hello Mark,
>
> I had a look at my options for slowing down the spi-gpio in some cases:
>
> == Approach 1:
>
> With some preprocessor magic I could create two sets of bitbang
> functions (bitbang_txrx_be_cpha0/1 and bitbang_txrx_be_cpha0/1_slow). I
> can then decide which of the functions to use in
> spi_gpio_txrx_word_mode0 (and similar functions) based on the nsecs
> value. For example if (nsecs > 1000) use bitbang_txrx_be_cpha0_slow()
> function otherwise use bitbang_txrx_be_cpha0().
>
> This approach would add a minimal delay between the bytes but not in the
> bits. It would allow to have fast and slow devices on the same bus. But
> it's a little intransparent from a user perspective because there is
> some special (hard coded) speed where the behaviour changes.
>
> == Approach 2:
>
> Add a kernel config option to allow the user to select whether he wants
> maximum speed or the possibility to slow down the SPI bus. Default would
> be the same as it is now.
>
> That is very simple to implement. It doesn't allow to mix slow and fast
> devices but it is quite clear from a user perspective and can be
> documented via a kernel option. Due to that I would slightly prefer that
> approach.
>
> What do you think: Would one of these be acceptable as a solution?

A third approach would be to set up the spi_bitbang.txrx_word[]
function pointers at runtime, to point to "fast" or "slow" versions,
depending on the runtime-detected speed of the system you're
running on.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
