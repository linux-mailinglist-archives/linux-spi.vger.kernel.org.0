Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6E4450820
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 16:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhKOPXJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 10:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhKOPXI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 10:23:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DAC061570;
        Mon, 15 Nov 2021 07:20:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m20so27702508edc.5;
        Mon, 15 Nov 2021 07:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOYdJpMpXy3DnmNfQTnpkndW2MOealtUhKN8wP1v95E=;
        b=CAu2a4oNDZbbP1pXzOx/lOgpWOmaJSQhdhxk+BiJfc3E78YGv+/QkQYm3N0CwD2FW4
         n11GfjkCysN+cbpMvenLPKXgySoyn5tp8IsaBfwUtCYLol+A63v4Yx++5KpePsVr768R
         G9hEAS7Q7KpuWbTnynpdnggVmiQsgbwBnjpM64Oj1o2IdcY+BCfFHXuzK7XFYhQ7F6cP
         Y0rvd+SH0ZCYhZNf590iSlgvhii/kosz3bzCweyRaSWhhkTMvxCRFNAKVgfyYG+M7K34
         sQeq3tbZrtVhPSeNRMXkXFosYEFnod//IK344jbUmdqL6HJ3dmI4tUO8zbY9y3wEXi1r
         qMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOYdJpMpXy3DnmNfQTnpkndW2MOealtUhKN8wP1v95E=;
        b=T6WFW68VRY5Bhs2pgm//a8bx2GohIv+djx1j+9zTSwvHfY7BIlduro7H5HVK+CI3Iz
         dAylkAR4DAru3k2VaFl21LEXDrIyWQ4iFiWRAXD4sTScTGEJdghKNaT4XpnTG06pDsUk
         CPuh++1CzQUL2aRieIBVZtcGKPdGohq8FYkwIbsnqn9swBocGDxoGizoD0JLNFSEu09Q
         G0MmSFtO9Z7vdMHXtPH9i3Brx1kE1YQgf2bRyoHxKKgR9JhWYugiU4RUi/LB5/jKK0pA
         B6k7HDfxLSGIvMugQQf4p6KEsx63HNJ2DeLCidGCvocasTRlkIqB/mLw+inxEh2NKw7Y
         ftew==
X-Gm-Message-State: AOAM531+h6Y5x9AhNZZd76gZfKK+JxpYMctSueuzMbupULIvfn4gQ4EP
        VcBsiDtVtIhwtVNvJXts5bvwvWYRL0lGnO3K7Pg=
X-Google-Smtp-Source: ABdhPJx2gD54wqAIqJ+c+IUxDANSOcQ7zKseUyGrPfMPv8SCKBk5l+XB15nH516cssOUY0hinrpXQd302salKjxuS9w=
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr27510759edz.107.1636989610439;
 Mon, 15 Nov 2021 07:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
 <20211114223026.13359-7-Sergey.Semin@baikalelectronics.ru>
 <YZJwTgAPZYVvzGpi@smile.fi.intel.com> <20211115150856.ma2wjg2ev5wylspg@mobilestation>
In-Reply-To: <20211115150856.ma2wjg2ev5wylspg@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 17:19:28 +0200
Message-ID: <CAHp75VdsAzpUiM7U+f69PguGAa4QV+izM0p5DNNWp=d9yNT0eA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] spi: dw: Replace DWC_HSSI capability with IP-core
 version checker
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 5:08 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> On Mon, Nov 15, 2021 at 04:35:58PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 01:30:26AM +0300, Serge Semin wrote:

...

> > >  /* DW SPI controller capabilities */
> > >  #define DW_SPI_CAP_CS_OVERRIDE             BIT(0)
> > >  #define DW_SPI_CAP_KEEMBAY_MST             BIT(1)
> > > -#define DW_SPI_CAP_DWC_HSSI                BIT(2)
> > > -#define DW_SPI_CAP_DFS32           BIT(3)
> > > +#define DW_SPI_CAP_DFS32           BIT(2)
>
> > In one patch you move this in the file upper.
> > Here you reshuffling it due to dropping one bit.
> >
> > Now I'm wondering if you may split these two into a separate patch, which
> > brings us to simple
> >
> > -#define DW_SPI_CAP_DWC_HSSI          BIT(3)
> >
> > here.
>
> I can change the bit-numbers assignment in the previous patch, which
> moves this block of macros up to the top of the file. Thus we'll
> have just a single
> -#define DW_SPI_CAP_DWC_HSSI            BIT(3)
> here. What do you think? Is that what you meant?

I think that reassignment doesn't fit the previous patch per se, hence
I proposed to have yet another one, But in any case it's a minor
thingy.

-- 
With Best Regards,
Andy Shevchenko
