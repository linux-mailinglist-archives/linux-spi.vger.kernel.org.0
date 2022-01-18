Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FAA492D2D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 19:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbiARSWR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 13:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiARSWO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 13:22:14 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC90C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 10:22:14 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id c36so38383111uae.13
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LZNzj0gVFsf/tWnnArV/oep7oH7ni2/wbESJgVeIAs=;
        b=htAigmZtm9BSSN1q9F8ZxY2Y4pj0ZFOxFKRaBA3aqDnZAtPriB9OcJcAvbVxpSFZP4
         fxMwtpcnzT+ADV5N2nP6ZBDGyPKVkm1NbKou/IOWx59zlHFUdpq2K9dtbOvPjN2jxQtD
         ToBhItewgTADtYbKJvt8IOSGhY8PtD1+jtai/KUNqfX+2cW8aGGDO2WnLByx5oW7moo0
         Bt9oLKA3KUYjA0REs4zV/GQqINWuSc30iyg/x0ZjJzRPBtL6KaRuWrGiAESUjOnPes8M
         pwOCglmHxy49vghHzE0C9l3vu+SMcPTmdnjSoChAmPih7ttDDB0/bp7g7RdEwBbMN363
         0WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LZNzj0gVFsf/tWnnArV/oep7oH7ni2/wbESJgVeIAs=;
        b=CTy5hJQGuXxMCtoOmJUq0RNFW+VK5ecxuZ7wLm9x/UFFoyOQOZ+EPOuxCBUb+8sj2h
         WuSlBxkAYgG3wGGaB/UssgqzoPBNW/fA7TTsrilvTUgBTTjHGmjL5Ez+neG7qn2/ha2D
         UB49nmBV7fM4aroU/pEai8sYVXr6MNwo59R9k2xjyhxZTdexz/gYBEehH2tQrJUs+FSC
         SvbLXQjddDjHz8Lqzp2Qf3iTx/gNoMZQDb76tGkKFpZebE+tBiHMDjRtGzsN/SlcQX2m
         LBcY7JQqBrGSyRBsw1rxAiqstpTGunAim6wYB0qmaaXfu4+Qm4ek/l2TQ07KVJrmHskv
         mNNg==
X-Gm-Message-State: AOAM532reSVFnFiZjLTLIA2cm1so1eT5j5RaF0zeOhYAiz8oVC7yGoZI
        M/apNpYO5Sqmx2AIvt5U0L0mxT9teBKzQFoX4fZyEKIdKQSYeg==
X-Google-Smtp-Source: ABdhPJx2W8kaHg9EtEhlusRCmaUdX8dPceh/1TYnKoK+BeABx4NYXSa1sCGd0CtVcN4dwumpeXNWaypXzZOQtdNVo48=
X-Received: by 2002:a05:6102:108c:: with SMTP id s12mr10253415vsr.20.1642530133625;
 Tue, 18 Jan 2022 10:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org>
 <20220118110928.120640-3-linus.walleij@linaro.org> <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
 <CACRpkdaL3RFU-cJNW2e40RiHGP06BfunnmU73FK_6U=Syvx_Wg@mail.gmail.com>
In-Reply-To: <CACRpkdaL3RFU-cJNW2e40RiHGP06BfunnmU73FK_6U=Syvx_Wg@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 18 Jan 2022 20:22:02 +0200
Message-ID: <CAPLW+4kJHv-xhm1=igVdc9XYUhF20Zbbo_tXpORnkPGsLzuZ+A@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jan 2022 at 18:08, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jan 18, 2022 at 4:27 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>
> > > +       if (!cs)
> > > +               return 0;
> >
> > Shouldn't some error code be returned in that case? Or is it normal case?
>
> No, because it just means the platform didn't define any fb_delay.
>
> > >         /* Configure feedback delay */
> > >         writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
>
> But maybe I should always write 0 into this then.
>

Yeah, probably makes sense, as some other slave node may have
configured fb_delay on the same bus / driver instance. And of course 0
is correct value, just checked in Exynos850 TRM, means "do not use
this feedback clock".

> > > - * This is per SPI-Slave Chipselect information.
> > > + * This is per SPI-Slave FB delay information.
> >
> > Not sure if this change is needed: this comments will be incorrect if
> > some new fields are added in future. For example, downstream trees
> > like [1] have more fields there, not only feedback delay one.
>
> OK I fix
>
> > Other than minor comments above:
> >
> > Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> >
> > Btw, this SPI driver is used in Exynos850 SoC, which I'm working on
> > right now. It's the shame I didn't enable it yet on my board, so I
> > can't test the code. But I'm happy to see it's being modernized, kudos
> > for doing that!
>
> Yeah I saw it being used in the Tesla SoC and also Exynos850 so as
> I now know this is not going away any time soon we might as well just
> fix it up.
>
> Yours,
> Linus Walleij
