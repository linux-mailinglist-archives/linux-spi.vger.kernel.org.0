Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763B5333BAE
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 12:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCJLoX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 06:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhCJLnn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Mar 2021 06:43:43 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002FC06174A;
        Wed, 10 Mar 2021 03:43:41 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p16so17578718ioj.4;
        Wed, 10 Mar 2021 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MDculd5PWLFOFwl290sy7CTqICAtBb0zJmC/83JNiY=;
        b=jyhuw1uUViTVh9mqzgoJ/J29crJCPM2TJeyX7WB/RlRW8RVVbQjnWXpzdkbCZfVK7y
         RRrsVERxnfxdAdkz2Wf6fgMQwHQl2It5TUvgjZbP1buY9VW1KR7M/9aF3D/QnUKV/wEi
         0eV7hG5BSbChAnQSi7vhkbAdfpTyn3eiIwZbKdRdU1FMzRH0XrE0EyxjNo5CgF+fzKAm
         i08ouwrBHH3ksVRAE7HJ7qX2f2p4KcP8AQz2XuiChoZ72uOpj1oWu0rCxwH1MzwczzzS
         lDyySAebm6U41iADqPqpRAQMBt1vPFmbIYT316NfnAOljlhkKJhuins3NibQAaRdQNd0
         0cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MDculd5PWLFOFwl290sy7CTqICAtBb0zJmC/83JNiY=;
        b=bgI/AnZRt/Y+uj0t1U4nQfKI70HPpvSYx//HoIPgEP1EaQvisDECBfZw/8CV+DWTtN
         U3zxSRtukGrF9nrvEuaSQSKXWYU9AlUe0EfX959FRfyb8wDDCzfiTxHlaSPe5aeosHfd
         3KKDhlgv6AWCPuCNRJ6upbdPxiZApdf5vN+4yPnw04v7qmlouVqpMHXghMmp6ASnzEqw
         c6HCa39GWhuMQdSfoLeOZMRbIhBg3D6u+3zRNLKU+2TOx4EIDDBtJroSidg6B0Vue08+
         adQeMNm6sy4WH9X2yaJxscrnZkkiPDqA3wHtVdESARYSlmIXXANKAasqDrMT++BOYZ7+
         vR+g==
X-Gm-Message-State: AOAM531fVtTa3lLU1OVK5eWjcO6p4IjdT00g58znKBIGqw8Ufn3l+sfN
        yhfWP0oIEkmS/gnVOHUF5Zk0qMNDQippnzPFEmA=
X-Google-Smtp-Source: ABdhPJymqoFFgZdz05brxOTgEYkI3NFm4i5o0rEnCSDmm6k2DAHa0k4EB+ukDihO1Mqa2o6zn3/4hb1NiTISMd094i4=
X-Received: by 2002:a6b:4f09:: with SMTP id d9mr2013952iob.60.1615376621486;
 Wed, 10 Mar 2021 03:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-6-git-send-email-dillon.minfei@gmail.com> <159056850384.88029.10852284922297394339@swboyd.mtv.corp.google.com>
In-Reply-To: <159056850384.88029.10852284922297394339@swboyd.mtv.corp.google.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 10 Mar 2021 19:43:05 +0800
Message-ID: <CAL9mu0+Uh84UGQ-1EW4+eVE1cFxuxJxLTLAa0rgJ_5C2pchUgA@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] clk: stm32: Fix stm32f429's ltdc driver hang in
 set clock rate
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
> Quoting dillon.minfei@gmail.com (2020-05-27 00:27:29)
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This is due to misuse \u2018PLL_VCO_SAI' and'PLL_SAI' in clk-stm32f4.c
> > 'PLL_SAI' is 2, 'PLL_VCO_SAI' is 7(defined in
> > include/dt-bindings/clock/stm32fx-clock.h).
> >
> > 'post_div' point to 'post_div_data[]', 'post_div->pll_num'
> > is PLL_I2S or PLL_SAI.
> >
> > 'clks[PLL_VCO_SAI]' has valid 'struct clk_hw* ' return
> > from stm32f4_rcc_register_pll() but, at line 1777 of
> > driver/clk/clk-stm32f4.c, use the 'clks[post_div->pll_num]',
> > equal to 'clks[PLL_SAI]', this is invalid array member at that time.
> >
> > Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
