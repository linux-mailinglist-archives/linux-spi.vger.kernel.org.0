Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8E1E368E
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgE0DbZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 23:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DbZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 23:31:25 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A0C061A0F;
        Tue, 26 May 2020 20:31:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a14so22652944ilk.2;
        Tue, 26 May 2020 20:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mYTDBjmF5P3Prc+HqW20hE68LTSpmhjJUYlei4pinL4=;
        b=gqG/fvpbY+IG7TyiRzSTZ9wDGJLAHqG+o9kNi1AF9EL+ny4VwJW8K4LxWrnbLj+2aG
         2glK+H/RU/c7WBt6NoFHIPTeid2VMzvufC3lzP+lg/+KT6G5OjUYdzk1eiT1uyVQcIOx
         Hs+qapgUNPryh9o3UdyGBOqeckXGT7W0FCKlX6QMQAFJAhXFk+RK2B+BvQ9mI88x7AKL
         +Nzf5eOLuW/BbgmASX4gDk97t8UoqWmo2RtbjP3ZKxtiFi7wEpH3aVcSKcIL+mBo5qPT
         7NtdN1wgwoI/hRCJwS/P90XKG51rV9cmbRn7RVOLBrZ4a7JnWmXWeTz++nPwy7tuupdz
         msfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mYTDBjmF5P3Prc+HqW20hE68LTSpmhjJUYlei4pinL4=;
        b=PSvomMg5KMakwm25l8Jm+bVu7M3VUCZYb2EUOfXeyRpMBAXlE+USj0W8hUNvXDVNe4
         Wvfog1JlcMytsKa+ZbQKv3ULmTc6sKGH4BuJh4zDtHzKyLM0GFYQy0khPAN2CJTYKDHt
         EdM8TSBEJ79MD6KVobLwCVQW0Mypg1SQivvVaEnnFNZtIBzDLXt8ZV1IvYM+Vkb6e5Zw
         RZ5icyRp/Ck017fTSnAg0JdNTozacvOQtbjamkffraSPfPT2yohSmjfwsNsDM1XQnU8r
         H3nvArc9pwPqBW2oc8f9FS4vO0PEc2iafL18Kbj8jfnt26FvLO3BNMvttfsa18wIE1UY
         sj0A==
X-Gm-Message-State: AOAM530rRltlB/sFl5mxyEQstnZOPYNkEehD934sn41PObWcG46bZx1R
        agpN2R7/g035p/X6Dh7IT3tFEg7PxzQUaQmsFFE=
X-Google-Smtp-Source: ABdhPJwuyAxSxLkhVb7QvcW25hO5jSZaAlIwIL+dnkE3kgzuiin71PvFpxjwpkiCyDSpFszGEGBvvFVmU0Khgad6kBg=
X-Received: by 2002:a92:40ca:: with SMTP id d71mr4124378ill.200.1590550284118;
 Tue, 26 May 2020 20:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
 <1590378348-8115-6-git-send-email-dillon.minfei@gmail.com> <159054389592.88029.12389551390229328953@swboyd.mtv.corp.google.com>
In-Reply-To: <159054389592.88029.12389551390229328953@swboyd.mtv.corp.google.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Wed, 27 May 2020 11:30:47 +0800
Message-ID: <CAL9mu0L1OxDMHwNjfh+11br+z3vt+wyq45Q7-KNVSLTENAxH+Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] clk: stm32: Fix stm32f429's ltdc driver hang in
 set clock rate, fix duplicated ltdc clock register to 'clk_core' case ltdc's
 clock turn off by clk_disable_unused()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Stephen,

Thanks for reviewing.

On Wed, May 27, 2020 at 9:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting dillon.minfei@gmail.com (2020-05-24 20:45:45)
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > ltdc set clock rate crashed
> >    'post_div_data[]''s pll_num is PLL_I2S, PLL_SAI (number is 1,2). but=
,
>
> Please write "post_div_data[]'s" if it is possessive. "But" doesn't
> start a sentence. This is one sentence, not two.
Ok.

>
> >     as pll_num is offset of 'clks[]' input to clk_register_pll_div(), w=
hich
> >     is FCLK, CLK_LSI, defined in 'include/dt-bindings/clock/stm32fx-clo=
ck.h'
> >     so, this is a null object at the register time.
> >     then, in ltdc's clock is_enabled(), enable(), will call to_clk_gate=
().
> >     will return a null object, cause kernel crashed.
> >     need change pll_num to PLL_VCO_I2S, PLL_VCO_SAI for 'post_div_data[=
]'
> >
> >  duplicated ltdc clock
> >    'stm32f429_gates[]' has a member 'ltdc' register to 'clk_core', but =
no
> >     upper driver use it, ltdc driver use the lcd-tft defined in
> >    'stm32f429_aux_clk[]'. after system startup, as stm32f429_gates[]'s =
ltdc
> >     enable_count is zero, so turn off by clk_disable_unused()
>
> I sort of follow this. Is this another patch? Seems like two things are
> going on here.

This patch fix two bugs about stm32's clock.
bug1:  ltdc driver loading hang in clk_set_rate(), this is due to
misuse =E2=80=98PLL_VCO_SAI' and
           'PLL_SAI'.

 speak in short, from the below code,
    =E2=80=99PLL_SAI' is 2, 'PLL_VCO_SAI' is 7.
    'post_div' point to 'post_div_data[]', 'post_div->pll_num' is
PLL_I2S, PLL_SAI.
    'clks[PLL_VCOM_SAI' has vaild 'struct clk_hw* ' return from
stm32f4_rcc_register_pll()
    but, at line 1776, use the 'clks[post_div->pll_num]', equal to
'clks[PLL_SAI]', this is invaild
    at that time.

include/dt-bindings/clock/stm32fx-clock.h
29 #define PLL_VCO_SAI             7

drivers/clk/clk-stm32f4.c
 494 enum {
 495         PLL,
 496         PLL_I2S,
 497         PLL_SAI,
 498 };


 558 static const struct stm32f4_pll_post_div_data
post_div_data[MAX_POST_DIV] =3D {
 559         { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",
 560                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NUL=
L},
 561
 562         { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",
 563                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NUL=
L },
 564
 565         { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PA=
RENT,
 566                 STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },
 567 };


1759         clks[PLL_VCO_SAI] =3D stm32f4_rcc_register_pll("vco_in",
1760                         &data->pll_data[2], &stm32f4_clk_lock);
1761
1762         for (n =3D 0; n < MAX_POST_DIV; n++) {
1763                 const struct stm32f4_pll_post_div_data *post_div;
1764                 struct clk_hw *hw;
1765
1766                 post_div =3D &post_div_data[n];
1767
1768                 hw =3D clk_register_pll_div(post_div->name,
1769                                 post_div->parent,
1770                                 post_div->flag,
1771                                 base + post_div->offset,
1772                                 post_div->shift,
1773                                 post_div->width,
1774                                 post_div->flag_div,
1775                                 post_div->div_table,
1776                                 clks[post_div->pll_num],
1777                                 &stm32f4_clk_lock);
1778
1779                 if (post_div->idx !=3D NO_IDX)
1780                         clks[post_div->idx] =3D hw;
1781         }

bug2: ltdc's clock turn off by clk_disable_unused()

from your comments at '[PATCH v3 4/5] clk: stm32: Fix stm32f429 ltdc
driver loading hang
 in clk set rate. keep ltdc clk running after kernel startup' , i go
deep into the code, found
stm32's clk driver register two gate clk to clk core by
clk_hw_register_gate() and
clk_hw_register_composite()

first: 'stm32f429_gates[]', clk name is 'ltdc', this is no user used.
second: 'stm32f429_aux_clk[]', clk name is 'lcd-tft', this is used by
ltdc driver

both of them point to the same offset of stm32's RCC register. after
kernel enter console,
clk core turn off ltdc's clk as 'stm32f429_gates[]' is unused. but,
actually 'stm32f429_aux_clk[]'
is in use.

i can separate this patch to two, each bug a patch if necessary

>
> >
> > Changes since V3:
> > 1 drop last wrong changes about 'CLK_IGNORE_UNUSED' patch
> > 2 fix PLL_SAI mismatch with PLL_VCO_SAI
>
> This change log goes under the --- below.
ok

>
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
>
> Any Fixes tag?
ok, will add --fixup in git commit next time, this patch fix two bugs,
i should make two commit, each one has a
fixes tag, right?
first point to '517633e clk: stm32f4: Add post divisor for I2S & SAI PLLs'
second point to 'daf2d11 clk: stm32f4: Add lcd-tft clock'
