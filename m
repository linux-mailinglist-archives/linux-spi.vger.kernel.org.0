Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251BA50BC8
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2019 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfFXNUr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jun 2019 09:20:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36547 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfFXNUr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jun 2019 09:20:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so13366856wmm.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2019 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=epLYrZfwE5nw1/sWE8ySfr+ROG6lto/SorZMam1Aa2c=;
        b=Ki30jh6qdMK2cou4m65m7raOl+nU6hDQYb4KE5PSQq780PsTRngQDkC3/gJO2/KIi/
         qWesOPc2a37qyJcbQ+4QoB2FLyvo5biyQgOXrPM2rZ9t90epZPCITS6sB4YFFBYlRkQd
         YHLyc64yxfVXWPuypGEDKDK/D3r7CcXUAT1Ht/Za8Ks2bkvAzf4gIruKTx9KH6VrkbHq
         AtImAWuqxyWktPlNiPVbHzYLuTCoqcAQkDr0DTtFjhsXWbdwsNC3JEPNLXq5Rxq4Y1rM
         M4y7tsoqBTGr+omgCbucHptWHt2Ai/o/9T0LXY3dghZG9cvdM8jj9mvWEBYycg3PEDPG
         lhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=epLYrZfwE5nw1/sWE8ySfr+ROG6lto/SorZMam1Aa2c=;
        b=PhF9w52hdTeX4ViJCMqsATqKABST/RjedNyDtjVzP1DQPlf8vX4vtwdvTzBDOwzNBc
         +7JaEaRBtRhK4Gu2R+wpfeQB08O/VVHos4J+AKo9mAV92qFNQfBX7ZJApTc4KcFw9NwR
         9ppIb6IYvesHmCikcyl7JKgAUIgDcS2a7PVvOySccSeCl3PphjJ/nGZbqya1gvGCNPwa
         MMm12Sm34CEkG5iR5lxZf3i2ofqmVu7y17W4WYaG5g9hoWGZ6hJjt0CagYg2Z+kHJHD6
         wlj+P2jNnJDF83ycRpKjI7CP8Jkkn4AMWkah6MpsgFqU0iQRZNrXdawbUU1sOley3y0H
         c3/w==
X-Gm-Message-State: APjAAAUgQBMFtr9FyKr6FWOwkDHLyear00RzcIWfMMssbP9JulsHykz/
        FYjoEEr1kthLqdJlXycaJ1uHsw==
X-Google-Smtp-Source: APXvYqz8OxSQCMieIItj3lePFEDWsZ1D2ETmisLiT+3QhMuPI9qiJUkqE9IOhJBXKe1RAkTVqkP1Hw==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr15953887wmd.117.1561382445447;
        Mon, 24 Jun 2019 06:20:45 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id y19sm14736835wmc.21.2019.06.24.06.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 06:20:44 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:20:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190624132043.GG4699@dell>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <07603eca-7e4b-e244-781f-e391c1a87319@cogentembedded.com>
 <CAMuHMdXawjCqe3K7MdD5CuwBc96h-xSychYnoLwfDjqCcNL+8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXawjCqe3K7MdD5CuwBc96h-xSychYnoLwfDjqCcNL+8w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Jun 2019, Geert Uytterhoeven wrote:

> Hi Sergei, Lee,
> 
> On Thu, Jun 20, 2019 at 8:46 PM Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On 06/17/2019 12:30 PM, Lee Jones wrote:
> > >>>> Add the MFD driver for Renesas RPC-IF which registers either the SPI or
> > >>>> HyperFLash  device depending on the contents of the device tree subnode.
> > >>>> It also provides the absract "back end" device APIs that can be used by
> > >>>> the "front end" SPI/MTD drivers to talk to the real hardware.
> > >>>>
> > >>>> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> > >>>>
> > >>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > >>
> > >> [...]
> > >>>> Index: mfd/drivers/mfd/rpc-if.c
> > >>>> ===================================================================
> > >>>> --- /dev/null
> > >>>> +++ mfd/drivers/mfd/rpc-if.c
> > >>>> @@ -0,0 +1,535 @@
> > [...]
> > >>>> +#define RPCIF_DIRMAP_SIZE 0x4000000
> > >>>
> > >>> Can you shift this lot out to a header file please.
> > >>
> > >>    You mean all register #defne's? Why? I'm not intending to use them outside
> > >> this file.
> > >
> > > Because its 10's of lines of cruft.
> >
> >    Thank you! :-)
> >
> > > People won't want to wade through that to get to real functional C
> > > code every time they open up this file.
> >
> >    This is how the most drivers are written.
> >
> > > You already have a header file, please use it.
> >
> >    Headers are for public things. I've encapsulated the h/w assess into
> > the MFD driver, the client code doesn't have to see all the gory hardware
> > details... IOW, I don't agree to this request.
> 
> +1

Header files aren't only for sharing.  Plenty of source files have
their own headers for storing defines which are of little use to the
reader.

Keeping 125 lines of defines at the top of a source file is pretty
ugly and only border-line unsociable.  If you had many more, I'd be
more insistent.

> > >>>> +static int wait_msg_xfer_end(struct rpcif *rpc)
> > >>>> +{
> > >>>> +  u32 sts;
> > >>>> +
> > >>>> +  return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
> > >>>> +                                  sts & RPCIF_CMNSR_TEND, 0,
> > >>>
> > >>> Aren't you using sts undefined here?
> > >>
> > >>    No, the macro reads 'sts' from the register first.
> > >
> > > That's confusing and ugly.
> > >
> > > Please re-write it to the code is clear and easy to read/maintain.
> 
> How to rewrite?
> This is exactly how the various *_poll_timeout*() helpers are intended
> to be used.
> 
>  * @val: Unsigned integer variable to read the value into
> 
> See also include/linux/iopoll.h.

Yuck!  What a horrible way to write a function.

Well if this is how the API is meant to called then I guess it is not
you I am taking exception to.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
