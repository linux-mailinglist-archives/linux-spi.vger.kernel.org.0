Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69A333BB1
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhCJLoe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhCJLoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Mar 2021 06:44:21 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020DDC06174A;
        Wed, 10 Mar 2021 03:44:19 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id i8so17533119iog.7;
        Wed, 10 Mar 2021 03:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op8MuAs4SRxmTKVvah22QByz3q7Mi3iArZEjUk+Thxk=;
        b=tbZ0SW438zSVkyxkrUhPs282MdsJiT0nydSL1+q+VaeYCp1wR8gU7zUe/TUlSYglgs
         iIIIODc35S1SjI7uAF2/h03PXLNXux2vFLXcDxyq/ltPNbSZZ+PQHSXmj/FRCFuqxbto
         lxjj5dWzSescFEfPuLEUc5QVzR9hZEli26Wt4Q5IAuiWYr35c/1Xe+qihbPXQ9JSDBqH
         YPQ8wM3w5MZBkLolu9DGVN443g1F1hXK4D9B1/hjCnDMAeLrNQDuck9jIUCkskFy6Ezb
         /0N+E/Ry/VxfIWVLKcCCb5RLWGmjPoNitIV/QJL26I8g429kqEVv8PTtGYxzzuTnST9l
         yKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op8MuAs4SRxmTKVvah22QByz3q7Mi3iArZEjUk+Thxk=;
        b=T9FllSKU9cuQ4sNFzBHPGXK7xAQbfIZbKJ6a+VHKqczrtsxo2vDD4WOUZc1Zq5v95V
         d/bx4UnPC5untZs8A98mByhmh0zaUbDDrapMIvmiICj4vvgfSrHlIwGw1mNkFeWI5mIy
         Mnpj1dvWVDz++CiLONuX3nW9z/vcO8TWy1VwSXa+Z/zOpzsxn/w6vil0bBij/dvZ4lBB
         c2sYLwrxh56AST/gpxH9/wQheqbFUoC7RRcBo5xz/NImICUGNT1TY8FJZNDCXL4dBYrL
         4sGgSM9426gWZaIdXL0L5dPwwHCz9Eg3HrgIt2q5lBS7STC8adO6NQ+r6o20xWKOCu0a
         /T0g==
X-Gm-Message-State: AOAM531G87/qsSU6YkmzuYqazIj3sygnFIMFi24JhX6chaM6Rc7WDLjF
        +pvzLjL6nVAMWkyof0/Uktfhmdkx+Ea/vCnjuP0=
X-Google-Smtp-Source: ABdhPJz5M2eWPKf4NxOL+8DZYRTGWBX7CV9I1yHd6MspCfR/Ca1EfgXEzeeymZdkKrLM+bP4UCLuaOhuoetCi1bJpNg=
X-Received: by 2002:a5e:a519:: with SMTP id 25mr1857796iog.3.1615376658157;
 Wed, 10 Mar 2021 03:44:18 -0800 (PST)
MIME-Version: 1.0
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-7-git-send-email-dillon.minfei@gmail.com> <159056850835.88029.9264848839121822798@swboyd.mtv.corp.google.com>
In-Reply-To: <159056850835.88029.9264848839121822798@swboyd.mtv.corp.google.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 10 Mar 2021 19:43:42 +0800
Message-ID: <CAL9mu0KBKVufGx96=_5dWokC0uJBW35TnFxEofXA44QhpEK6-g@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] clk: stm32: Fix ltdc's clock turn off by
 clk_disable_unused() after kernel startup
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dave Airlie <airlied@linux.ie>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        p.zabel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, thierry.reding@gmail.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hua Dillon <dillonhua@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

still need more expert to review, so just a gentle ping for this patch

On Wed, May 27, 2020 at 4:35 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting dillon.minfei@gmail.com (2020-05-27 00:27:30)
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > stm32's clk driver register two ltdc gate clk to clk core by
> > clk_hw_register_gate() and clk_hw_register_composite()
> >
> > first: 'stm32f429_gates[]', clk name is 'ltdc', which no user to use.
> > second: 'stm32f429_aux_clk[]', clk name is 'lcd-tft', used by ltdc driver
> >
> > both of them point to the same offset of stm32's RCC register. after
> > kernel enter console, clk core turn off ltdc's clk as 'stm32f429_gates[]'
> > is no one to use. but, actually 'stm32f429_aux_clk[]' is in use.
> >
> > Fixes: daf2d117cbca ("clk: stm32f4: Add lcd-tft clock")
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
