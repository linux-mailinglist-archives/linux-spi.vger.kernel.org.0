Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CE281AD3
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbgJBS0q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 14:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBS0q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 14:26:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC57C0613D0;
        Fri,  2 Oct 2020 11:26:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so1826758pfp.11;
        Fri, 02 Oct 2020 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bH3LhQl50rze/g0fOzDKdyyNl1t2DQWWqcVRhwzgFcw=;
        b=nVvcACzwGxTCOgqLJ4m8IMODFbuvVdl2uslv/4Q2UB1IiT/uq9TWQzGBmeBOzAmXak
         t6hjgkIkG7cp+P8fb5Evb/LEaRaaLitosQmYtjmDgdlDutB2xXnqZ/cJTsb3vWCOSR1W
         W3vjVqMmtk5ciIETb6vuIJ6GzR+TSmy+X+LjsWvjDNkGBwV7hfvDkNduYlVkq+F+wouW
         0esbmD7OwGfuHK8ErE0hGc+2c+ClhtKdYsIbN3B3CeXZuMGTZ6giYhMZmOUvKg1KzIVB
         nKoE+U3D2Sm1VGVi1C7r7TlLaTrhLWbzQ2JEUqkn0L6Uf1L6zXW+E2Fw9BrWedQsNzwQ
         yuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH3LhQl50rze/g0fOzDKdyyNl1t2DQWWqcVRhwzgFcw=;
        b=B2WocXaCb0RrJ/r7AiCeQ8r1rvOx4hG56Yi7kIghi+0/jQIhkyfElI+FXpHvX5Sw5y
         oT6PnOdYkHRQWp4lG7sXq0Pr74Bqh4mWIfxenU4DJNyAf0aK03aGLTFhfIpiHTmjATbh
         opmwdoMzEu3e2h6jYftlT+9fvVSEAUJ8GDq8pw6hoh2t6BPaIzwPy7XjsBE5S22OFfWv
         YJn/zs1iC5Zxi+ylJsOWpLA7pGYLgTzfGjh2SDlYVQZMHqQG6rIfOh/ZA2UA2wqXiHcQ
         fsVw/DZRfxJSm2tSEx+NFKfVidS5XbwzvvXDLmSWcSC33+kJQCFqkaYHLOnv/vqKq5gP
         w7xA==
X-Gm-Message-State: AOAM530+sBMXZwLKf/ygL6LgPyxcU8Zp6NKHxUMZXDh+ifY1q3SzvL23
        Wdfg20gmnlaLDjLNjmIiOHaZNHmOmEx3DeOn3Lk=
X-Google-Smtp-Source: ABdhPJzKRBCZppPvyYuC4AWkQZz7tKDWXwV5Phj+OPoIoiKc9NDzkBSAAkHsHigpvv6+lztxxdqlZUkvGyKYlxgjsjA=
X-Received: by 2002:a63:d648:: with SMTP id d8mr3393820pgj.4.1601663205987;
 Fri, 02 Oct 2020 11:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201002102444.GY3956970@smile.fi.intel.com> <20201002125549.GB5527@sirena.org.uk>
In-Reply-To: <20201002125549.GB5527@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Oct 2020 21:26:27 +0300
Message-ID: <CAHp75VdHkTwwYmnMbqXJmjP3Fps4sAgLuvCyaJuQPAiV+Owz-Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] spi: dw: Add full Baikal-T1 SPI Controllers support
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 2, 2020 at 3:56 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 02, 2020 at 01:24:44PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2020 at 01:28:08AM +0300, Serge Semin wrote:
>
> > > the subject. Though some of them are mere cleanups or weakly related with
> > > the subject fixes, but we just couldn't leave the code as is at some
> > > places since we were working with the DW APB SSI driver anyway. Here is
> > > what we did to fix the original DW APB SSI driver, to make it less messy.
>
> > Maybe it's time to put your name into MAINTAINERS for this driver?
>
> Seems sensible to me - Andy, it probably makes sense to add you as well?

I have more than enough on my plate currently. Maybe in the future.

> Does one of you want to send a patch for this?

--
With Best Regards,
Andy Shevchenko
