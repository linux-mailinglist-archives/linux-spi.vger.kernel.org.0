Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1015844F
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 21:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBJUeD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 15:34:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45080 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgBJUeC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Feb 2020 15:34:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so4490557pgk.12;
        Mon, 10 Feb 2020 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TB+axxjIWIjWk0PNAI7k0lI/JgFN7Ol9rXGRwoyIkuw=;
        b=LaxyU0AHuGnexTtLM6uVLtHFtF5cVZNVMZSdiig5wzdd7wXTurL+lFrqCLagEsKH03
         /z3KRLePj5KgplK69Lqu90Cup8wWshTsplKYLOFqnmNlXv+CUaJxJHhS/00dkokFhGUl
         U1hY8m1/DeY3NBwN7wSWl0RjWcBes/1WtWRfJXm14vkKzlIkoOIawp2n9gJERHqG5qkA
         Q9+Nw6ECEzgMugz5BAw2/ef9V/NXHICxN3RWiRy9y6lgKC/EPwpdYagip66bOuYTeVut
         XkL2/EuAki1qDBBbLz2IyNBYd0PwUb/hixCxpV9M0mRmnt0rm+Y3JrxbATS4IwS8DGlP
         u95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TB+axxjIWIjWk0PNAI7k0lI/JgFN7Ol9rXGRwoyIkuw=;
        b=GWYXX60W3UnKeEraKe+9z9FBd7Wp9Woxni7oIco5aFhScXHQp/owA7fif5hzVivgZD
         BIpkjg2/8Ueb8eHR4iGBE2ZY29VETalkuhw2jV07k2kVEZLTAuP3ik2isZ3xvrTGY9Ks
         7rqeo/1kQhSlX41XNyi2jTCllqdnfiJUtR4T06OcnW0NC2w16L8NtxqN+/jixdmEHWuD
         EjQ967thJQ3/ly0TTRwzhmR4OyoX40ldWMriNzIJKr5fTKLDj3rifkeDLThuF06zQSuv
         EXCgOM2RmXa81uLyomueWG2dZ3n8gusKU8HfwsUe6KDS4AxODayMdj66A/fwGggNlb47
         Id0w==
X-Gm-Message-State: APjAAAVtj3UZrNbXbK+xMxUMVNyYR8rpEGdqK8WchgEsHFphct0QOqB+
        Hs9MbKERFFKabqWtVOY6XUncpgndqlpmMgcwWpw=
X-Google-Smtp-Source: APXvYqzSBdySewAnLbg43ZSLOoR35ZgNr0IqSh9Rz8NJSnusNdMDHSDlNlDDJwZe9hGkn+W+qy9hi0XQFtCKHQt6eXQ=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr3403780pgb.4.1581366840214;
 Mon, 10 Feb 2020 12:34:00 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com> <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com> <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
 <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com> <CAHp75VdO2+Kkgo1Nv3EJXTMqP6Y7XgLVXtRvURk6Zz0p=R9zNQ@mail.gmail.com>
 <ca8a832e-ceeb-3ce1-9807-96ee41e0f166@linux.vnet.ibm.com> <CAHp75VduJn=kMuriGNAGk1ZrL4b2LpqEn5c8AC=PHFKrgoz=vg@mail.gmail.com>
 <3bbc98a7-838d-f57f-0478-a632ba68f500@linux.vnet.ibm.com>
In-Reply-To: <3bbc98a7-838d-f57f-0478-a632ba68f500@linux.vnet.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Feb 2020 22:33:49 +0200
Message-ID: <CAHp75VfpRV7UDMpPKo8Vu1PaOfLjUG24yUdkg8ip9=923cwarA@mail.gmail.com>
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

On Mon, Feb 10, 2020 at 10:05 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 2/7/20 4:04 PM, Andy Shevchenko wrote:
> > On Fri, Feb 7, 2020 at 11:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >> On 2/7/20 2:34 PM, Andy Shevchenko wrote:
> >>> On Fri, Feb 7, 2020 at 10:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>> On 2/7/20 1:39 PM, Andy Shevchenko wrote:
> >>>>> On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>>>> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> >>>>>>> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
> >>>>>>>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> >>>>>>>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>>>>>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> >>>>>>>>>>>> +       for (i = 0; i < num_bytes; ++i)
> >>>>>>>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>>>>>>>>>> Redundant & 0xffULL part.
> >>>>>>> For me it looks like
> >>>>>>>
> >>>>>>>       u8 tmp[8];
> >>>>>>>
> >>>>>>>       put_unaligned_be64(in, tmp);
> >>>>>>>       memcpy(rx, tmp, num_bytes);
> >>>>>>>
> >>>>>>> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> >>>>>>> See, for example, linux/unaligned/be_byteshift.h implementation.
> >>>>>> Unforunately it is not the same. put_unaligned_be64 will take the
> >>>>>> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
> >>>>>> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
> >>>>>> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
> >>>>>> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
> >>>>>> tmp[1], etc. So I think my current implementation is correct.
> >>>>> Yes, I missed correction of the start address in memcpy(). Otherwise
> >>>>> it's still the same what I was talking about.
> >>>> I see now, yes, thanks.
> >>>>
> >>>> Do you think this is worth a v3? Perhaps put_unaligned is slightly more
> >>>> optimized than the loop but there is more memory copy with that way too.
> >>> I already forgot the entire context when this has been called. Can you
> >>> summarize what the sequence(s) of num_bytes are expected usually.
> >>>
> >>> IIUC if packets small, less than 8 bytes, than num_bytes will be that value.
> >>> Otherwise it will be something like 8 + 8 + 8 ... + tail. Is it
> >>> correct assumption?
> >>
> >> Yes, it will typically be 8 + 8 +... remainder. Basically, on any RX,
> >> the driver polls for the rx register full. Once full, it will read
> >> however much data is left to be transferred. Since we use min(len, 8)
> >> then we read 8 usually, until we get to the end.
> > I asked that because we might have a better optimization, i.e, call
> > directly put_unaligned_be64() when we know that length is 8 bytes. For
> > the rest your approach might be simpler. Similar for the TX case.
>
>
> I just tried to implement as you suggested but I realized something: The
> value is already swapped from BE to CPU when the register is read in
> fsi_spi_read_reg. It happens to work out correctly to use
> put_unaligned_be64 on a LE CPU to flip the bytes here. But on a BE CPU,
> this wouldn't be correct I think.

Hmm... Any BE conversion op on BE architecture is no-op.
Same for LE on LE.

> Now I don't anticipate this driver
> running on a BE CPU, but I think it is weird to flip it twice, and
> better to do it manually here.
>
> What do you think Andy?



> >>>>>>>>>>>> +       return num_bytes;
> >>>>>>>>>>>> +}



-- 
With Best Regards,
Andy Shevchenko
