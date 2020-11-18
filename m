Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCBC2B7371
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 02:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgKRBD4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 20:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRBDz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 20:03:55 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28993C061A4D
        for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2020 17:03:54 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so485319lfe.12
        for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2020 17:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlgdtYEdscf+tUFxFKexbIH/xB8SATTGk+HtZWc0bWE=;
        b=Z26LAAgIMRvns+YZ8VKNh4K8pGmPO8h21+E3k1Ss952Ds8+3HjzO/6VaW4hLl/zw0n
         vFg7thdmnfIgF60Nmbp0Irvho8TtVEGlnsH78gqUVpE1560l97xDwRwnLpyzEZKAyoJ0
         8xV74Ax68cLJ6kkpWkYcqaN4W+13B0A0Q7Y8s7RuRJKC7G6w95xmky1uk3t719ABaO8E
         jihYCw8JiNNepaHlzMkj/FyCYzeISl92Jwmm2oBWxbR8UtDnUhMZN8f+1DOMfI19b6Gr
         tMzPxZwnq7OxXiFhfAAgwygwEtU6lS2tzIThdUUnLtha7pJS/IlxLaJaNbuTMFoN5VRu
         BduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlgdtYEdscf+tUFxFKexbIH/xB8SATTGk+HtZWc0bWE=;
        b=MR5UnigPsjzdq+OVA46ShT/Rh+lIpWJuaXvhdFi7hyAf2fDHjm2bG6lQ2Gfe5RuIDo
         RwDnYQ8RDRcVI1vSJdIdWrX5keegp+71LIyrU0FIb1q+9E4f0/hqD6EJHFOnBvQhrRkz
         Z4jIAJhVsVsxqCTFGaGv2dfxK/5+ZNJgnoavbKLHrAcpadgc4a4YP9Kr8ELpPBtnyETH
         bQRtrZcbA8e4QwqNSdK/TkfleH+RtzUDYtZGAP8ILupvOieDkgz4I+iPKr3Dgeyg/qcY
         VTqPUEbV59vpSAxgo1Q5EAiBWK/EXTh5fDmT8ghWcZQOzm4UTw8uWlAf/MXRIiSa0DxN
         G1Eg==
X-Gm-Message-State: AOAM5327Ynw3yH4YNccHdCUr0cgmrMdgv675KNQjNOdQxAJxva8xI978
        7pqmubq0fr5rpBcH1S0nh2f382cEmt78XKWAxPXsgw==
X-Google-Smtp-Source: ABdhPJxtYOMsiELQpvhHELtHITV36jbt6UUELQ1GVqJL6sY+qb8cCr4K+e625Tl0PN6+YLyd/w50j/5Q6lHpIFTHeMQ=
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr2551245lfp.572.1605661432618;
 Tue, 17 Nov 2020 17:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com> <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk> <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
 <20201116210632.GJ4739@sirena.org.uk>
In-Reply-To: <20201116210632.GJ4739@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 02:03:41 +0100
Message-ID: <CACRpkdayWzWKHv69cg_GL2O=NWozqi_ZLnH1WdMOHzEb1bU-xA@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 10:06 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 11, 2020 at 02:36:07PM +0100, Linus Walleij wrote:

> > I don't know if we ever formalized it, there is nowadays a rule akin to
>
> > "if a property can be determined from the compatible-string, and if the
> >  compatible-string is identifying the variant of the electronic component,
> >  then do not add this property to the device tree description. Just
> >  deduce it from the compatible-string, assign it with code to the device
> >  model of the operating system and handle it inside the operating system."
>
> > I think this, while clear and intuitive, wasn't at all clear and intuitive in
> > the recent past.
>
> I think the main push in the other direction has always been people who
> want to not have to write a driver at all and put absolutely everything
> into DT which has scaling issues :/

What I can't understand is what gave them that idea.

This thing looks like a dream to these people for example:
https://gist.github.com/Minecrell/56c2b20118ba00a9723f0785301bc5ec#file-dsi_panel_s6e88a0_ams452ef01_qhd_octa_video-dtsi
And it looks like a nightmare to me.

(There is even a tool to convert this description into a proper display
driver now.)

It just seems to be one of those golden hammer things: everything
start to look like nails.

Yours,
Linus Walleij
