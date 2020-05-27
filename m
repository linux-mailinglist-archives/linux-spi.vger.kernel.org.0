Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9A1E34E3
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgE0Bo5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 21:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgE0Bo5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 21:44:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D60D207CB;
        Wed, 27 May 2020 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590543896;
        bh=X8IeUYi5TEn1bZovze7WvWR7fZ/TpSB3r+3JOJw+vJQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QLptIsKhuHarasq/W6RYkU8NHJoMp0xnt0xZil+C30FyLSxx0ko4GnJqD1aLFrCrv
         JahMQqsz6vQdQrXrr7Lr60y5v4JGPCylyVhsRe+7tPWmeip6Q9DrXJiEgtMwCK7xfM
         XKAngA+z8LBWFwXGQrGa2SIOEiDtNeNG0h/0i6vA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590378348-8115-6-git-send-email-dillon.minfei@gmail.com>
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com> <1590378348-8115-6-git-send-email-dillon.minfei@gmail.com>
Subject: Re: [PATCH v5 5/8] clk: stm32: Fix stm32f429's ltdc driver hang in set clock rate, fix duplicated ltdc clock register to 'clk_core' case ltdc's clock turn off by clk_disable_unused()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
To:     broonie@kernel.org, dillon.minfei@gmail.com,
        linus.walleij@linaro.org
Date:   Tue, 26 May 2020 18:44:55 -0700
Message-ID: <159054389592.88029.12389551390229328953@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting dillon.minfei@gmail.com (2020-05-24 20:45:45)
> From: dillon min <dillon.minfei@gmail.com>
>=20
> ltdc set clock rate crashed
>    'post_div_data[]''s pll_num is PLL_I2S, PLL_SAI (number is 1,2). but,

Please write "post_div_data[]'s" if it is possessive. "But" doesn't
start a sentence. This is one sentence, not two.

>     as pll_num is offset of 'clks[]' input to clk_register_pll_div(), whi=
ch
>     is FCLK, CLK_LSI, defined in 'include/dt-bindings/clock/stm32fx-clock=
.h'
>     so, this is a null object at the register time.
>     then, in ltdc's clock is_enabled(), enable(), will call to_clk_gate().
>     will return a null object, cause kernel crashed.
>     need change pll_num to PLL_VCO_I2S, PLL_VCO_SAI for 'post_div_data[]'
>=20
>  duplicated ltdc clock
>    'stm32f429_gates[]' has a member 'ltdc' register to 'clk_core', but no
>     upper driver use it, ltdc driver use the lcd-tft defined in
>    'stm32f429_aux_clk[]'. after system startup, as stm32f429_gates[]'s lt=
dc
>     enable_count is zero, so turn off by clk_disable_unused()

I sort of follow this. Is this another patch? Seems like two things are
going on here.

>=20
> Changes since V3:
> 1 drop last wrong changes about 'CLK_IGNORE_UNUSED' patch
> 2 fix PLL_SAI mismatch with PLL_VCO_SAI

This change log goes under the --- below.

>=20
> Signed-off-by: dillon min <dillon.minfei@gmail.com>

Any Fixes tag?
