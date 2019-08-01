Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6305B7DB2C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfHAMRN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 08:17:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56032 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAMRN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 08:17:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so64418633wmj.5;
        Thu, 01 Aug 2019 05:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWLPyME/jAkVEQ5t9L+p96xi6wCaF4hZN+jKl5GuaSU=;
        b=iaPKellIqry1urVGLGLZw4ECK83Qs7F4ud9GykT1F6hCB2YOFiiCtGqdLQReH4B6Bq
         41i10VvgP/BxucTfj/LTuHz0Fd4or+VTgKGmsh3KSufmm6FFQJV9Ymz3GkdD3En+NQ8R
         P5ULrf1pSyw336VUO5BHEr/t0GWlYJ0DDOAAQaCfsWnBvfKUgCF7yDdwZ84ARAr3YpK5
         pk06I6HMEBiRjeTj1fCtOpdwjLcy95dxivucFFOVgVgXlXvrdNPq7zjdiIYPE4VSMJzm
         OK8k4K21Nc9+VxPRZnNXlhbvxOF0q22avmBtOC16FU29HVV9K3tv1U4PbrGSaFOqKIJK
         EbIg==
X-Gm-Message-State: APjAAAVEkCon5HTXOW71NNtcYf/MMyf/1LjKQZMkVxTdW0DBbzYRBa60
        /EmIPg9qQXQlFQDT0gvymmRuT25kFlHC0wtj92TLVCmv
X-Google-Smtp-Source: APXvYqzpx/cJYpS36v0hwlYQJLzatqmdT+c3y247auU4r9Rk0kfrHFl0Ti8sUx1xFAeRY0I+yMm8s4oETnJTRSdV9/M=
X-Received: by 2002:a7b:c310:: with SMTP id k16mr75092863wmj.133.1564661830932;
 Thu, 01 Aug 2019 05:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111348.530242235@infradead.org> <20190801111541.917256884@infradead.org>
 <CAMuHMdU3D22PAWepGP6rMvDwJKVTfbxxH9J=kuo59PB7CCVKOA@mail.gmail.com> <20190801121209.GD31381@hirez.programming.kicks-ass.net>
In-Reply-To: <20190801121209.GD31381@hirez.programming.kicks-ass.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Aug 2019 14:16:58 +0200
Message-ID: <CAMuHMdXvq4ZDecpaiFHmQbETP=Z0Y2QVHsWpfDGU2bgaDDOA0A@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Peter,

On Thu, Aug 1, 2019 at 2:12 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Aug 01, 2019 at 01:27:03PM +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 1, 2019 at 1:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
> > >
> > > FIFO-99 is the very highest priority available to SCHED_FIFO and
> > > it not a suitable default; it would indicate the SPI work is the
> > > most important work on the machine.
> > >
> > > Cc: Benson Leung <bleung@chromium.org>
> > > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Cc: Guenter Roeck <groeck@chromium.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: linux-spi@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  drivers/platform/chrome/cros_ec_spi.c |    2 +-
> > >  drivers/spi/spi.c                     |    2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > --- a/drivers/platform/chrome/cros_ec_spi.c
> > > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > > @@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
> > >                                            struct cros_ec_spi *ec_spi)
> > >  {
> > >         struct sched_param sched_priority = {
> > > -               .sched_priority = MAX_RT_PRIO - 1,
> > > +               .sched_priority = MAX_RT_PRIO / 2,
> >
> > include/linux/sched/prio.h says:
> >
> >  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
> >  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
> >  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
> >  * values are inverted: lower p->prio value means higher priority.
> >
> > So the new 50 is actually a higher priority than the old 99?
> >
> > Given I'm far from an RT expert, I must be missing something?
> > Thanks!
>
> Ah; you found the confusion ;-)
>
> https://lkml.kernel.org/20190617122448.GA3436@hirez.programming.kicks-ass.net

/me adds /r after org/
Thanks!

> But basically, user-space prio is [1-99], while in-kernel prio is
> [0-98]. The above is user prio (it basically uses the
> sched_setscheduler() syscall).
>
> So 50 really is lower than 99.

IC.

BTW, what about having a #define for MAX_RT_PRIO / 2?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
