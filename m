Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6F33363C
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 08:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhCJHRK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 02:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhCJHRG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Mar 2021 02:17:06 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C81C06174A
        for <linux-spi@vger.kernel.org>; Tue,  9 Mar 2021 23:17:03 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id p24so8199702vsj.13
        for <linux-spi@vger.kernel.org>; Tue, 09 Mar 2021 23:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5O4bWXBCQeQuk0BdQom2dNS7Jmj8ph1wsbHk08MJAMo=;
        b=h1lBv7HHj122ZOQj79sUyMEcd0w5tZ5oV+JyqbEAP6IjncbQiGVy8O14kGSopZ/RBx
         9v2gMNrpI9dt04NG+QIN/gmmZWg3fVjIn1tcv81o1Zn57C+4gpo/i+K6DDJGIjAYDD1d
         KZbwTuKJwz1WrxDTxcAVijM/GojWEq9d8mJct7JWW7QAaNeF1syI/sRvDtbi+HPObcfq
         5uHQyTctmvjfVGPbz5aASZ00uqwQaJVO9XeaiinwzqpdY68XcFk8CFpmzqPAMAbdjUeH
         vuZGlGdUJgO/m0f2Ul4b4DUBi6I43LHxDjtkfkGsgWwGw6cEOKY5wfKkRuGxJLBAuKXt
         OI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5O4bWXBCQeQuk0BdQom2dNS7Jmj8ph1wsbHk08MJAMo=;
        b=G9qtMVeh3B+nDlB5NAAAmvqNn1X9+6SQfDXl3xqQvUQIVSFKMSziBiuofqrg71iGE3
         jgP/m2JE6ZYeim4am1NkgyW8mY+cqjXpzWbXM7+r8tx4Xzbh0cmLEQCCbylJvxyaydke
         IyL4q9hlof+lhWUH2VGpU7KcJuvvK9D7yk6YGaXMs4YoFMxWOEEZhRerfrCKhWuL6Kj2
         vKZQswlpwHynAowNhUJYvToCZtPAL4LggaWx2Jgy7HRoARhp9KIkujBnKER+npS75xlb
         v+J9EWmBatVJ+4+7DgN+CEkY5GGPuX63Rxv9YO12aXkHf/C5HOhcShT1vrZcMuwIUI/c
         tuTA==
X-Gm-Message-State: AOAM531e/4EMx7Hf1JVvgyYWKlTyWjr0SsJpmIx29iW5WtFR28/+EmQ3
        Z1H/rWH+m0/W1nbKKaMSHFDWq5X9U8exmk00wsj3gQ==
X-Google-Smtp-Source: ABdhPJytTW7QIOLB8UPImbCUal1chmTmNyv6Z6uRJmeRfc+N68L2N1shNta5YcuAAXSn3Da5NzDEfquDQar0GSWxbDA=
X-Received: by 2002:a67:31d1:: with SMTP id x200mr972514vsx.16.1615360622918;
 Tue, 09 Mar 2021 23:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20210308145502.1075689-1-aardelean@deviqon.com>
 <20210308145502.1075689-2-aardelean@deviqon.com> <8a6ec9a1-71f8-ce1d-600a-66eba9244a54@metafoo.de>
In-Reply-To: <8a6ec9a1-71f8-ce1d-600a-66eba9244a54@metafoo.de>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Wed, 10 Mar 2021 09:16:51 +0200
Message-ID: <CAASAkoZ+3T27KK0HN6YikKczUFS15xSpOssaOmx4NtDQKiKvHQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] spi: spi-axi-spi-engine: remove usage of delay_usecs
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 8 Mar 2021 at 18:42, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 3/8/21 3:54 PM, Alexandru Ardelean wrote:
> > The 'delay_usecs' field was handled for backwards compatibility in case
> > there were some users that still configured SPI delay transfers with
> > this field.
> >
> > They should all be removed by now.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > ---
> >   drivers/spi/spi-axi-spi-engine.c | 12 ++++--------
> >   1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> > index af86e6d6e16b..80c3e38f5c1b 100644
> > --- a/drivers/spi/spi-axi-spi-engine.c
> > +++ b/drivers/spi/spi-axi-spi-engine.c
> > @@ -170,14 +170,10 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
> >       unsigned int t;
> >       int delay;
> >
> > -     if (xfer->delay_usecs) {
> > -             delay = xfer->delay_usecs;
> > -     } else {
> > -             delay = spi_delay_to_ns(&xfer->delay, xfer);
> > -             if (delay < 0)
> > -                     return;
> > -             delay /= 1000;
> > -     }
> > +     delay = spi_delay_to_ns(&xfer->delay, xfer);
> > +     if (delay < 0)
> > +             return;
>
> Bit of a nit, but this could be `delay <= 0` and then drop the check for
> `delay == 0` below.

hmm, that's a bit debatable, because the `delay == 0` check comes
after `delay /= 1000` ;
to do what you're suggesting, it would probably need a
DIV_ROUND_UP(delay, 1000) to make sure that even sub-microsecond
delays don't become zero;

if you're acking this suggestion i'll implement it;
i'll wait a few more days to see if there are any other acks or
complaints on the set before sending a V2;

btw: this new spi_delay struct supports delays in microseconds,
nanoseconds and clock cycles;
at some point it may be interesting to use a
`spi_delay_to_clk_cycles()` for this driver and other similar;

>
> > +     delay /= 1000;
> >
> >       if (delay == 0)
> >               return;
>
>
