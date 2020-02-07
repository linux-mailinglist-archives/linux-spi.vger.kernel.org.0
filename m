Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44340155EA6
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGTj0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 14:39:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43715 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgBGTj0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 14:39:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so277773pfh.10;
        Fri, 07 Feb 2020 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMV9mrvxXKtF7veXVaTaKRwaBbMNRnkTmlI+NnwqDp0=;
        b=UVW1Jr3rxr43QMhieO9muTBS+hJj0+c93HmCQYuhH0kio1os13hyQ701MxvUvCE76v
         KFpgpEbaHsKkidsrjbiUQ4wODCM9UWOXmd+c56elI9tcMrKhXyJWQlgK47igUdYr6FLY
         gLlqN/z2b1rKywI+q/+V30XqwuH5x5X4ItHIdjrce/ehs1hisN/HFq/n0Y+jMOc3CvQ2
         1pGW9ZGUdxB59DHcHOBvOaFfRv8Tr2ddqrU9LzxkKFPp425UO3j6m0AJlKd9kx23EHSp
         ZUdv8KvcAiDMpL0c3onlAIrjRgWotEUBZqUrPUjh5pgNE0qOhSpeXkMF7iRgwtvkb8ZX
         ajFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMV9mrvxXKtF7veXVaTaKRwaBbMNRnkTmlI+NnwqDp0=;
        b=qE3sGm4l0ETkwL2FR9Xw7GMU43I0oT0lHRND2RJpwVzN4MLpnnxNzjuUx8Kjmj5wWD
         KmIg8tSct+FdJvgsBxpPvU0CmVBmMDWuftZeUbQCM9NJ1JtgSfuKGXUGLUopfcoOAWuX
         FhKzeY2HFm5ul/PVayowdtk3UQoLl0xvf4rxxkZsfzSS76EjSE89qdDAVfiEP1BMzXh/
         b1b6TRMQQSqUexLhrLDk8V3hL8eIjhlg7064WGnCoeuS50J9gtKWrQCydRgjg3yts1l1
         t71X84YunP6rHltqqjxEmMh4HFx7Lde+ilBsrKwXniO/kHp7w6s1IFf4K5bF4tLGCEdx
         WGqA==
X-Gm-Message-State: APjAAAXfhcaw1D3ZGZplQJkYwtNp10gtFOhWWX5xC8QqVqOkIi1wLbVE
        1/ItZQUAiySlEjb7G5T46SVZsMarA97rYC0fbNo=
X-Google-Smtp-Source: APXvYqyPLUNxHc5eaZYFb23Seh/CPSZFSy5A5kNWFuz5VbNhJw1ERrOtmz+X4gaYxJK7ZRoFnlqblRqMPWEBQiZRgh0=
X-Received: by 2002:a65:5242:: with SMTP id q2mr810978pgp.74.1581104365541;
 Fri, 07 Feb 2020 11:39:25 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com> <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com>
In-Reply-To: <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Feb 2020 21:39:17 +0200
Message-ID: <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
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

On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> > On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> >>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:

...

> >>>>>> +       for (i = 0; i < num_bytes; ++i)
> >>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>>>> Redundant & 0xffULL part.
> >>>>>
> >>>>> Isn't it NIH of get_unalinged_be64 / le64 or something similar?
> >>>> No, these are shift in/out operations. The read register will also have
> >>>> previous operations data in them and must be extracted with only the
> >>>> correct number of bytes.
> >>> Why not to call put_unaligned() how the tail in this case (it's 0 or
> >>> can be easily made to be 0) will affect the result?
> >>
> >> The shift-in is not the same as any byte-swap or unaligned operation.
> >> For however many bytes we've read, we start at that many bytes
> >> left-shifted in the register and copy out to our buffer, moving right
> >> for each next byte... I don't think there is an existing function for
> >> this operation.
> > For me it looks like
> >
> >    u8 tmp[8];
> >
> >    put_unaligned_be64(in, tmp);
> >    memcpy(rx, tmp, num_bytes);
> >
> > put_unaligned*() is just a method to unroll the value to the u8 buffer.
> > See, for example, linux/unaligned/be_byteshift.h implementation.
>
>
> Unforunately it is not the same. put_unaligned_be64 will take the
> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
> tmp[1], etc. So I think my current implementation is correct.

Yes, I missed correction of the start address in memcpy(). Otherwise
it's still the same what I was talking about.

> >>>>>> +       return num_bytes;
> >>>>>> +}
> >>>>>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> >>>>>> +{
> >>>>> Ditto as for above function. (put_unaligned ...)
> >>> Ditto.
> >>
> >> I don't understand how this could work for transfers of less than 8
> >> bytes, any put_unaligned would access memory that it doesn't own.
> > Ditto.
> >
> >>>>>> +}

-- 
With Best Regards,
Andy Shevchenko
