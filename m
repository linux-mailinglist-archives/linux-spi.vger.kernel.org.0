Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4049A4E6A2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2019 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfFULCh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jun 2019 07:02:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39070 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFULCh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jun 2019 07:02:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so6419172qta.6
        for <linux-spi@vger.kernel.org>; Fri, 21 Jun 2019 04:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKY+V1xDV646PH+WVED+pFbq8Ww+7SitfxHjplviGZc=;
        b=aF0DOSfADWcsweJOGSpZA/V3bLWzn5o2RmfrAzEYsjgxwtPBtR6Pm5cPFQbJa/VvuP
         rk6suBrva7qOL/TBMaYsEJ5+2Uo/fFYQKCuveS7MJZcXZW01xj3ejDBKcPoVc4qECbDn
         m+2sKDrkCdXPPrGAM9Dqulufvjqdanzpq7JXPhZ3QnBQgxN7mH63FipaQptaNzal/bG0
         0oEY3Q4wcT/HTS0V7/0iYHUtAF7SQXcvbyO2ekTApqFjIQZe37dijvLpab94nGuoNMEs
         ZvmSZ+zUWPUzeFnh0/k/CcTzfT5leH0i9tlugKwzmMm1Vg8LP2hzyC3F1u18BR7RsyrR
         W1xA==
X-Gm-Message-State: APjAAAWM6WC4OF+pTjU+giDGbi9QQ3RU+IQrQYLW4uUijxKXZd8OUUmF
        jAG+XHCkkR0JHBixXK+nhw+wbmelpiuNmvyBoJI=
X-Google-Smtp-Source: APXvYqxT46cC6hPATh/9Gdcn1KIMqJAxEwONqvzdM+3FecHSQv+Z3HcMroU85hlWedq+m4CsThzeXVvk3LjaEPTf0og=
X-Received: by 2002:ac8:7349:: with SMTP id q9mr112596158qtp.151.1561114956692;
 Fri, 21 Jun 2019 04:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com> <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com> <20190617093048.GD16364@dell>
 <07603eca-7e4b-e244-781f-e391c1a87319@cogentembedded.com>
In-Reply-To: <07603eca-7e4b-e244-781f-e391c1a87319@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Jun 2019 13:02:25 +0200
Message-ID: <CAMuHMdXawjCqe3K7MdD5CuwBc96h-xSychYnoLwfDjqCcNL+8w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei, Lee,

On Thu, Jun 20, 2019 at 8:46 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 06/17/2019 12:30 PM, Lee Jones wrote:
> >>>> Add the MFD driver for Renesas RPC-IF which registers either the SPI or
> >>>> HyperFLash  device depending on the contents of the device tree subnode.
> >>>> It also provides the absract "back end" device APIs that can be used by
> >>>> the "front end" SPI/MTD drivers to talk to the real hardware.
> >>>>
> >>>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> >>>>
> >>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >> [...]
> >>>> Index: mfd/drivers/mfd/rpc-if.c
> >>>> ===================================================================
> >>>> --- /dev/null
> >>>> +++ mfd/drivers/mfd/rpc-if.c
> >>>> @@ -0,0 +1,535 @@
> [...]
> >>>> +#define RPCIF_DIRMAP_SIZE 0x4000000
> >>>
> >>> Can you shift this lot out to a header file please.
> >>
> >>    You mean all register #defne's? Why? I'm not intending to use them outside
> >> this file.
> >
> > Because its 10's of lines of cruft.
>
>    Thank you! :-)
>
> > People won't want to wade through that to get to real functional C
> > code every time they open up this file.
>
>    This is how the most drivers are written.
>
> > You already have a header file, please use it.
>
>    Headers are for public things. I've encapsulated the h/w assess into
> the MFD driver, the client code doesn't have to see all the gory hardware
> details... IOW, I don't agree to this request.

+1

> >>>> +static int wait_msg_xfer_end(struct rpcif *rpc)
> >>>> +{
> >>>> +  u32 sts;
> >>>> +
> >>>> +  return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
> >>>> +                                  sts & RPCIF_CMNSR_TEND, 0,
> >>>
> >>> Aren't you using sts undefined here?
> >>
> >>    No, the macro reads 'sts' from the register first.
> >
> > That's confusing and ugly.
> >
> > Please re-write it to the code is clear and easy to read/maintain.

How to rewrite?
This is exactly how the various *_poll_timeout*() helpers are intended
to be used.

 * @val: Unsigned integer variable to read the value into

See also include/linux/iopoll.h.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
