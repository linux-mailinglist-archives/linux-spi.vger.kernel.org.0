Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E511DD337
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgEUQoh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 12:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgEUQog (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 12:44:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8461C061A0E;
        Thu, 21 May 2020 09:44:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so3351634pjs.5;
        Thu, 21 May 2020 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNnNOKPcCJnDhrNBfoLqWXDth88IQNayyaRQ0MQhdIQ=;
        b=AEKmNVY1LjBVa8pjvDi1wXwbMl8cBLu9Xzbh3+mrUBkDZKzMKVSVeiw9X3RfZjX9VY
         Z7fXfJxI44R+58Mag6LHI1F8Rm2q28Q42neHVq5ePNJYKBzMp0GTYyUIrcn9Th8KVezP
         szYUYQldj+9JTXGcMROA7nKAiSHsvQHqYNJ0vLWdPLDeB3rx+yeZ5D5Z96qY+pdxVTHx
         gzwGon0Gp5fqglzX+YCex2d8kErSXQI+pb4sc+cHNUYt2bKlFzE7VQOyWoowDOonboJ2
         AvxN76iWwHP+h5oxf8PeoMa5PYQDmPHX8DHHnHEyoiyr2MDqv6CkVfaQFIkdLZjqPlNi
         uV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNnNOKPcCJnDhrNBfoLqWXDth88IQNayyaRQ0MQhdIQ=;
        b=JXdiBkTuUqgj/VCxzB814HOhmUVgHlgQqLs1vSUxhKBHtiETK1ESw5u9TTWmhsTLRn
         NpTBC7NZrKQh+qc4vq/zqbTzkY3Vw4+ZKfVrEChhkiyNV2ZqMJC49N7vrH6Oh2qKmivR
         aCESoFzUGwLHxzBQwprMWxFrU4mLoXUWIY+2+78l3QFRS1pA+Uy34Wc0JGAwxN2t6Onv
         BA/SCAt0SSRGVGduqqcPN/ctQp7p4765EZht6jlgEPFn9T/6H0xkyJsXyRzr/+jnRTD7
         V5ccTsuMYqoJ9vlr84S5UpxRnnWqJiCOYaXdE7c3iumT02feLFlOKqloWjHLiBvudEs3
         sMQw==
X-Gm-Message-State: AOAM533CJL0bgG//4bXPnxZB7nABmlBTzBTu68XNkpv6zuvH3GHto6Iu
        GiVNuXx6mrXsJobI7SsS8NHsgOKNskjNKAn93YM=
X-Google-Smtp-Source: ABdhPJz6MpoA1Jm30R5gjYWhDlMf4dfSiRTbOJKoTkX2Omg1b4AYlvIqMqFjh2ECVG1B+PTm+mtysHKAccGS6RLVX3U=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr12674407pjb.228.1590079476071;
 Thu, 21 May 2020 09:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
 <20200521121228.aqplh6eftylnys3p@mobilestation> <20200521155143.GE4770@sirena.org.uk>
 <20200521155804.qgaaqc23h2nll7r3@mobilestation> <CAHp75VcY9HG3=wft9VFWKJD9PG6TiSbmOyjgYZyue+z3PW_eCQ@mail.gmail.com>
 <20200521163904.GF4770@sirena.org.uk>
In-Reply-To: <20200521163904.GF4770@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 19:44:23 +0300
Message-ID: <CAHp75VdAVX50zVC6dGfxnXLz+z7gM0aAoTaXocEvy1nbpkNndQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 7:39 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 21, 2020 at 07:02:32PM +0300, Andy Shevchenko wrote:
> > On Thu, May 21, 2020 at 6:58 PM Serge Semin
>
> > > Let's leave the patch as is.
>
> > Mark, should I send a partial revert afterwards in this case?
> > I'm not fully satisfied with it.
>
> That might be a suitable way to keep the peace here.  You are clearly
> both much more passionate about this choice than I am.

Okay, will work for me, thanks!

-- 
With Best Regards,
Andy Shevchenko
