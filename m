Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA531155FA4
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGUe0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 15:34:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32920 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgBGUeZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 15:34:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so385200pgk.0;
        Fri, 07 Feb 2020 12:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPHWMcpySeg2md9hRvh4nN53ZKbWdcZQ7Q42r2DM3hQ=;
        b=qGoYo7eDVXz+tTgVmwGzojl5oRZkZGp/aJnTH9QzgAejALP7c/LUCtfsi2h/7qVAl5
         86HkC8YMssBrgzMiYEbCe2OjX/RKo5M/hoAJlFazVVK1u1CuE4mC5baY+JnhrPswTtwt
         +Fsll3ls4D+1ld2XksqQEj2aDXPnWrcYCQS9y8iRIEoMr+xI87UGwI9qtMhlsAO4u0sM
         LhZDNqt9gWAgIvShf4q09rsQ4d+Jpo66gm/jtCWUvx5IerrvBlQ2NaqIEXpYLzqtuKTu
         NTWFldhN9qX7+SWfGqUSBnNyHkDOQAzvi2ibHwmZ2KW/c8/jShH4T1fv7fyoQsvYOAd/
         0rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPHWMcpySeg2md9hRvh4nN53ZKbWdcZQ7Q42r2DM3hQ=;
        b=lKE0v31QXgK14GOdSucNRV7A2WvH2fggCoLYO1ecsJrDQtXWJZJeCh01tJoivRu/nA
         Aj2fZ8+YJQPWH5b4862o5Z61WF8zmeVRkxcgmnLfOEyoQXbOrqp5ONx7fpXAI22IeBbS
         cOk0V+HynXWWEukCsWnmVu/irP0maOSoFpWn1EtO5hUzDy3P98GyQujhynvBln6OQUv0
         p70wUliUWvfu8C1HtGhWBIfd7KAWOx0J9qZwlHpnFeSfJy6z6VQGZHaBP45dBD5jWWPL
         tbBqe0ODlI1lI24bWKdH8+sp6ugzY1jbjXSj1qieG8cIqZcAQU4TyFrFobzUmHqIBDjx
         Xfag==
X-Gm-Message-State: APjAAAWIsrT5F7KyQUBgVoJJqI9oZAxDV8Qn24bp3BbJ0QeGULXCvL2T
        gSjvAaCYAHnpk7rXCY/lxOb6d84HDgVjWP4BQtc=
X-Google-Smtp-Source: APXvYqwHDcol8uJaYa/Legnylm5CzJnX+ABXIJLxx0tt1Krx6Rs4mx3LXcR8ZsET8QN5QDn2oZ5SagQFpkmDiYp/kYw=
X-Received: by 2002:a65:5242:: with SMTP id q2mr1016240pgp.74.1581107665130;
 Fri, 07 Feb 2020 12:34:25 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com> <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com> <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
 <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com>
In-Reply-To: <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Feb 2020 22:34:17 +0200
Message-ID: <CAHp75VdO2+Kkgo1Nv3EJXTMqP6Y7XgLVXtRvURk6Zz0p=R9zNQ@mail.gmail.com>
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

On Fri, Feb 7, 2020 at 10:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 2/7/20 1:39 PM, Andy Shevchenko wrote:
> > On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> >>> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
> >>>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> >>>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:


> >>>>>>>> +       for (i = 0; i < num_bytes; ++i)
> >>>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>>>>>> Redundant & 0xffULL part.

> >>> For me it looks like
> >>>
> >>>     u8 tmp[8];
> >>>
> >>>     put_unaligned_be64(in, tmp);
> >>>     memcpy(rx, tmp, num_bytes);
> >>>
> >>> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> >>> See, for example, linux/unaligned/be_byteshift.h implementation.
> >>
> >> Unforunately it is not the same. put_unaligned_be64 will take the
> >> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
> >> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
> >> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
> >> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
> >> tmp[1], etc. So I think my current implementation is correct.
> > Yes, I missed correction of the start address in memcpy(). Otherwise
> > it's still the same what I was talking about.
>
>
> I see now, yes, thanks.
>
> Do you think this is worth a v3? Perhaps put_unaligned is slightly more
> optimized than the loop but there is more memory copy with that way too.

I already forgot the entire context when this has been called. Can you
summarize what the sequence(s) of num_bytes are expected usually.

IIUC if packets small, less than 8 bytes, than num_bytes will be that value.
Otherwise it will be something like 8 + 8 + 8 ... + tail. Is it
correct assumption?

> >>>>>>>> +       return num_bytes;
> >>>>>>>> +}

-- 
With Best Regards,
Andy Shevchenko
