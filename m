Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6A15349E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2020 16:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgBEPwB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Feb 2020 10:52:01 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35784 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgBEPwB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Feb 2020 10:52:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so1169382pjc.0;
        Wed, 05 Feb 2020 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLn08koeywOR0MXah19OglbUsPJAw65I3BZCI6HXccE=;
        b=lKhz68HuWBOiV5D8jYzxPIsvFHLUK5HKinADhqxRw+KHCqKFV4Tu+RkESN5OlY712C
         zwEaYigtO59yE82zCetlFVAvHJg85lxOKlW1pDu1YH8Nx5M0JOwc4+svzVh3itrSUD0i
         5xOdLBKLK+1qMtSoREwatJRHpx9uMxOPu0roj1Z+TxnOkuBNcDcQWuP2DhAp6XQ1p/Ee
         ZoH6KerpKCz4+lMg0WK3zWjFnFo/uj3WJjBDOxlPlJFtTT9xb0qRGI3UD1861WR/DVuA
         rLrxHZoISZ96p4qLe4lRa2l6fGUzbks6eCtRjcFGPD5Ia5t2CGkcfL4FGWgdVq15kN0k
         9M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLn08koeywOR0MXah19OglbUsPJAw65I3BZCI6HXccE=;
        b=SlonjGq4GzAKEcKUR4oXFmJpJ8qFoBxMMiSUmWswUhPpbJm2v66OVWKzrD8hlqyLV/
         nhpcKuAxyZ/3JnhszQI0QLYnMCyHQLXzTnJvO2khGvuXJpLiVBA6j8LHKC/wUn/plN8D
         uGuA24dUR6ipdmkX7ojcrBCb0daTKh9IVmAMet0RwPeEHNiDvC7Ahqr9MB2EY0CrNWsV
         RJTHeB15cufMwLtbdD2LYoqEag5Wg5Pz14zHtGOG66WIy0SDluf/i7EVW0zi2S0d6ODu
         VU8sYkarViN8WxPF83L18WT5VIvHrABkADd/9XCAY7KWPfhGZjDDsxRyb5U3WSUQanA9
         peKw==
X-Gm-Message-State: APjAAAXPJI3x8ZTIkTubYKQ3Di36xUB1ByFqo0eLvn7FXWNrDf2adJXy
        Dgbjak3PkXkiZ2g3eKRdNM6XNFqyIFEHrt7r++k=
X-Google-Smtp-Source: APXvYqwEz/h4FkioiW4MJqbKcf1W+n8tuz9XFL+3RUpksaNaPi89lH/0m9OgKg/bFyWXGHtRJPRJDyaPh3VivXeQ0cI=
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr34789589pls.262.1580917920662;
 Wed, 05 Feb 2020 07:52:00 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com> <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
In-Reply-To: <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Feb 2020 17:51:52 +0200
Message-ID: <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> > On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
> >> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> >>> On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames@linux.ibm.com> wrote:

...

> >>>> +       struct device *dev;
> >>> Isn't fsl->dev the same?
> >>> Perhaps kernel doc to explain the difference?
> >>
> >> No, it's not the same, as dev here is the SPI controller. I'll add a
> >> comment.
> > Why to have duplication then?
>
>
> Nothing is being duplicated, the two variables are storing entirely
> different information, both of which are necessary for each SPI
> controller that this driver is driving.

Oh, I see now, thanks!

...

> >>>> +       for (i = 0; i < num_bytes; ++i)
> >>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> >>> Redundant & 0xffULL part.
> >>>
> >>> Isn't it NIH of get_unalinged_be64 / le64 or something similar?
> >>
> >> No, these are shift in/out operations. The read register will also have
> >> previous operations data in them and must be extracted with only the
> >> correct number of bytes.
> > Why not to call put_unaligned() how the tail in this case (it's 0 or
> > can be easily made to be 0) will affect the result?
>
>
> The shift-in is not the same as any byte-swap or unaligned operation.
> For however many bytes we've read, we start at that many bytes
> left-shifted in the register and copy out to our buffer, moving right
> for each next byte... I don't think there is an existing function for
> this operation.

For me it looks like

  u8 tmp[8];

  put_unaligned_be64(in, tmp);
  memcpy(rx, tmp, num_bytes);

put_unaligned*() is just a method to unroll the value to the u8 buffer.
See, for example, linux/unaligned/be_byteshift.h implementation.

> >>>> +       return num_bytes;
> >>>> +}
> >>>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> >>>> +{
> >>> Ditto as for above function. (put_unaligned ...)
> > Ditto.
>
>
> I don't understand how this could work for transfers of less than 8
> bytes, any put_unaligned would access memory that it doesn't own.

Ditto.

> >>>> +}

-- 
With Best Regards,
Andy Shevchenko
