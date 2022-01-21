Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8794967C1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiAUWSY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 17:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiAUWSX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 17:18:23 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856FDC06173B
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 14:18:23 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id p7so12218866uao.6
        for <linux-spi@vger.kernel.org>; Fri, 21 Jan 2022 14:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV9w5EmTb4eZmKb/6aoUZvIPl80XkhsxfeqjuTrAbWA=;
        b=CbiJpoINDO3fnC6YidMztKRmjuScvLne0CTBdvYV7HQcZZBRBPhJaxeBTukX/orT2S
         GyCFX/uhbZgyio1zkCJEcRvJSujjW3NrKEg7c2gF/u2ilyBpVBso+yZE9o91o9KUEP/Q
         yLw39XLbvA9DeYRxAUmHq46Dug4HK3Ra0/TZizou9yKVpQSY3FBkxGxw/vi/3FcB8Ajg
         ZfXwzF8xq3xatmlwC+S60vkjXq92SaT1QbwxcU9rN5irYH64F6aWBmNT2t975h6WAq7k
         9m32EBu1zFyigaVvWO8GNpkhjjmxJXwMP1+X83tibz+haRdv2m97CiGX/9ATSuHcVeBh
         UmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV9w5EmTb4eZmKb/6aoUZvIPl80XkhsxfeqjuTrAbWA=;
        b=6VllRPDXnVMKk57MTiCN5OkrmFh5S+ZqRCkdZN18CD7Yi9wr3OFWDoAmhUDVh/Fxyy
         FWr1nfV9tr+i9v+1LPqRVS85gB1lsRiO1ufH6xnExGE7y7FHN0lIGcCbm0Rz2ViQukdx
         d0ThdNOAFZKmJXNcmuGZiVPqXWOZqFVvQ+EhPqL69VCHGcMqKkhqUHeaEdKhnZA4gLcb
         HOZ7RmQ2Nhd13i1ex/sxVDBAYeo4GmbNMyRsidY4WrKKNV0bmqTpWIQTTRF3j8V8gouV
         dL2GFc5aNgbdr2FnnezwIkuqYI98E/MU/cY0aRT3GLCye55IIQHdFm7VFRRe+SS2zBqX
         jQkA==
X-Gm-Message-State: AOAM532Q7kTLvkSqYt1ygW/rgkv1+m6GD59z7BnjrNsTOfRHVo7CBmjg
        U328KQli8Z25PpCFPK4CLdNA5Wm9lgRFZ8Jw0VGvRw==
X-Google-Smtp-Source: ABdhPJw9WJPHugvZi6jJqd9dpYrgpDyuT79IesWnkGmWdbKPFjfyS8SCR6ZwzsQkROFmqZ59yzBHoSq68FhpY1I12Tc=
X-Received: by 2002:a05:6102:204d:: with SMTP id q13mr2663269vsr.57.1642803502390;
 Fri, 21 Jan 2022 14:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20220118230915.157797-1-linus.walleij@linaro.org>
 <20220118230915.157797-3-linus.walleij@linaro.org> <CAPLW+4=6A=FLKOum48VNUaGBUUXBa=sMYRn4n1_nTtR8a+0YQA@mail.gmail.com>
 <CAHp75VftUNC6xFVRJqJhTqHwLvehtT+2+M9j_TsnhAyOf039rQ@mail.gmail.com>
In-Reply-To: <CAHp75VftUNC6xFVRJqJhTqHwLvehtT+2+M9j_TsnhAyOf039rQ@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 22 Jan 2022 00:18:11 +0200
Message-ID: <CAPLW+4mP0thEi0RbFa0p=_awMwRQ21T6JwW9tTz0gweP6ycVzA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v3] spi: s3c64xx: Convert to use GPIO descriptors
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Jan 2022 at 19:26, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jan 21, 2022 at 1:52 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> > On Wed, 19 Jan 2022 at 01:11, Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > Convert the S3C64xx SPI host to use GPIO descriptors.
> > >
> > > Provide GPIO descriptor tables for the one user with CS
> > > 0 and 1.
>
> ...
>
> > >         /* Configure feedback delay */
> > > -       writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
> > > +       if (!cs)
> > > +               /* No delay if not defined */
> > > +               writel(0, sdd->regs + S3C64XX_SPI_FB_CLK);
> > > +       else
> > > +               writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
> >
> > Looks good to me. I'd add {} braces and change "if (!cs)" to "if
> > (cs)", but that's hair splitting and not worth v4, it's fine as it is.
>
> If you are going to change code, then why not use positive conditions?
>
>   if (cs)
>     ...
>   else {
>     ...
>   }
>

It was already pointed out earlier AFAIR. Personally I don't think
it's too major to send v4. But theoretically speaking, maybe it would
be even better this way:

    u32 fb_delay = cs ? cs->fb_delay & 0x3 : 0;

    /* Configure feedback delay */
    writel(fb_delay, sdd->regs + S3C64XX_SPI_FB_CLK);

Again, I think it's not worth another submission, the same code will
be generated, and style is ok as it is.

> --
> With Best Regards,
> Andy Shevchenko
