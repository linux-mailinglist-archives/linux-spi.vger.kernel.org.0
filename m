Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999B7156101
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 23:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgBGWEm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 17:04:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36013 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGWEm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 17:04:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so299321plm.3;
        Fri, 07 Feb 2020 14:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPDmhswiBJE1QLstk4ChpHjPj5mjGrF+m5q4SUTfNEg=;
        b=U3MjPxbM1K7k+8ZkbpekkqbvP1T3T9jED5khnh21/XhANQP7Wbgi80pEsmDkZwPHbl
         37lP5zlxvJpTjbYI1q6Oek5OnQnKNiru74FBLjRlHlUVKvW27Ktv5dvu36vGWvWTZ3jU
         4WY7XUcG9dCOy6Qca+R7E01Q/AfcWBP6uXOWrNhjpn8l7+cycHqBGDeHouyKWCkNfxgK
         c7gWN7a9HnL4uMLFC6JbjujSVUqxJnvUlNpB5bFQBjxRKncNHxmRkAVGKyxqm5WhJIkz
         CGMvrwf0/LCCTL/P5Y/ilk+OAXpbYIkLEpu2m8dcT46JTayEeTGAgWfPATDr2Jve2E86
         DAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPDmhswiBJE1QLstk4ChpHjPj5mjGrF+m5q4SUTfNEg=;
        b=Nwb1Uj48HN6cMhZibTR7Oo5JDREqjOcBcmowKfpzScbfYSfPB9Fp5nKpEjCA9YZKR2
         pfpAnp7rWoWi5cEjT9ASEe+lf3OGKxxw7Kcn3sMMIyw8qleIZdK4trqZGjCGmJOp4S5w
         v2FOpQIKcXvNl9x4/7x3a6JF7oGSRmE4OLCIH4u0gi3bS88ROXUVel3emXV30mqBp5gc
         LAb1vlZMi132hE+cf25TIizkLPdFQpmePXzms0SyH+0lK3GEmfKWTAHsuuW5iouXHwgt
         M1XPthipazyRcsC+dqv163CrhbsezuScK64/1mxl5hyAO4ES6/oCRbOe4M2iacub5mZw
         o0NQ==
X-Gm-Message-State: APjAAAX8BGg+Nd/+6Kzgim7k9SbFriHV2gZFPWywASSyMfo7EQE0SjxG
        Z7/Lf3pSdBgdByai20JzN1e5FUxfbNOemUM/4zA=
X-Google-Smtp-Source: APXvYqwUGO/t9jLS9CaSuQuKmDq6P8+bwQMpcMN5kIypEPaCtb9UXqltBm4E05L20vsp5xsi56TmgrSZ0H6BHE4UsLU=
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr6351388pjc.20.1581113080425;
 Fri, 07 Feb 2020 14:04:40 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com> <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com> <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
 <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com> <CAHp75VdO2+Kkgo1Nv3EJXTMqP6Y7XgLVXtRvURk6Zz0p=R9zNQ@mail.gmail.com>
 <ca8a832e-ceeb-3ce1-9807-96ee41e0f166@linux.vnet.ibm.com>
In-Reply-To: <ca8a832e-ceeb-3ce1-9807-96ee41e0f166@linux.vnet.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Feb 2020 00:04:29 +0200
Message-ID: <CAHp75VduJn=kMuriGNAGk1ZrL4b2LpqEn5c8AC=PHFKrgoz=vg@mail.gmail.com>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 7, 2020 at 11:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 2/7/20 2:34 PM, Andy Shevchenko wrote:
> > On Fri, Feb 7, 2020 at 10:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >> On 2/7/20 1:39 PM, Andy Shevchenko wrote:
> >>> On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> >>>>> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
> >>>>>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> >>>>>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>>>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> >
> >>>>>>>>>> +       for (i = 0; i < num_bytes; ++i)
> >>>>>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>>>>>>>> Redundant & 0xffULL part.
> >>>>> For me it looks like
> >>>>>
> >>>>>      u8 tmp[8];
> >>>>>
> >>>>>      put_unaligned_be64(in, tmp);
> >>>>>      memcpy(rx, tmp, num_bytes);
> >>>>>
> >>>>> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> >>>>> See, for example, linux/unaligned/be_byteshift.h implementation.
> >>>> Unforunately it is not the same. put_unaligned_be64 will take the
> >>>> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
> >>>> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
> >>>> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
> >>>> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
> >>>> tmp[1], etc. So I think my current implementation is correct.
> >>> Yes, I missed correction of the start address in memcpy(). Otherwise
> >>> it's still the same what I was talking about.
> >>
> >> I see now, yes, thanks.
> >>
> >> Do you think this is worth a v3? Perhaps put_unaligned is slightly more
> >> optimized than the loop but there is more memory copy with that way too.
> > I already forgot the entire context when this has been called. Can you
> > summarize what the sequence(s) of num_bytes are expected usually.
> >
> > IIUC if packets small, less than 8 bytes, than num_bytes will be that value.
> > Otherwise it will be something like 8 + 8 + 8 ... + tail. Is it
> > correct assumption?
>
>
> Yes, it will typically be 8 + 8 +... remainder. Basically, on any RX,
> the driver polls for the rx register full. Once full, it will read
> however much data is left to be transferred. Since we use min(len, 8)
> then we read 8 usually, until we get to the end.

I asked that because we might have a better optimization, i.e, call
directly put_unaligned_be64() when we know that length is 8 bytes. For
the rest your approach might be simpler. Similar for the TX case.

> >>>>>>>>>> +       return num_bytes;
> >>>>>>>>>> +}

-- 
With Best Regards,
Andy Shevchenko
