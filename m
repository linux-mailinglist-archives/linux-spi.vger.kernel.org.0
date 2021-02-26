Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81331326085
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBZJuq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 04:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhBZJuE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 04:50:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 085B964F1B;
        Fri, 26 Feb 2021 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614332961;
        bh=/p6dOhcOYpFM640Kb6MMyylYPi1RlfxvVA6ObczgEhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lzJT/MU0B0CfNk3Od9WEkTaz2n39hSve8tsQ3B51OG+v8C9HX0tRwf4GTLm2dCCru
         bKsQpfIyw5c5iUwmaaAiWiVB4XUYJK7IX1xXZNMtXoYEqWP12xMsiwbl36DmbqVi/z
         ukRr5ZUvCD65qofwYxqx3J3F5TaiqaEYExRVZii1zRWSSWkbSD6iiDRpz0UZmHi2k2
         1qY8kNEjVoIDLeAIKeO/lOI2VWNxQy5RcjPfkj3qP1S29nD+nyPojgBrdM+plQyZi2
         Mg/7MwP2CW7wiCAOeezJLONwGgzqHlkfoUcd84vPXgZCN0e+HTe7MGqxhd03M6Vn/V
         GYzpBWde0OF1Q==
Received: by mail-ot1-f53.google.com with SMTP id g8so4903974otk.4;
        Fri, 26 Feb 2021 01:49:20 -0800 (PST)
X-Gm-Message-State: AOAM530wm272Kr9BSnn6ouIVs6pmYXn3kd2HyX/irVK1DisKQ6Y0h7U+
        urjBdyimjh8Wn2XIuTAvgiv7P9DVcgkH8z4/Qa4=
X-Google-Smtp-Source: ABdhPJz6LMQBQKLqBoeQS8rjpl42H7HBCEzMgMmWlkvE+pUpzvdpGIIYlIPKZf7sKPOWCYww0kyriDgqjAijjzESmdU=
X-Received: by 2002:a9d:4802:: with SMTP id c2mr1608747otf.305.1614332960079;
 Fri, 26 Feb 2021 01:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20210225125541.1808719-1-arnd@kernel.org> <20210226081548.h5ls5fxihunzxjvx@ti.com>
In-Reply-To: <20210226081548.h5ls5fxihunzxjvx@ti.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 10:49:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ep7DFnMYnA7q5b-P8X7nd3TAz=t82011j8=koK3T08A@mail.gmail.com>
Message-ID: <CAK8P3a3ep7DFnMYnA7q5b-P8X7nd3TAz=t82011j8=koK3T08A@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 26, 2021 at 9:16 AM 'Pratyush Yadav' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Hi,
>
> On 25/02/21 01:55PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Building this file with clang leads to a an unreachable code path
> > causing a warning from objtool:
> >
> > drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
> >
> > Use BUG() instead of unreachable() to avoid the undefined behavior
> > if it does happen.
> >
> > Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/spi/spi-rockchip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> > index 936ef54e0903..972beac1169a 100644
> > --- a/drivers/spi/spi-rockchip.c
> > +++ b/drivers/spi/spi-rockchip.c
> > @@ -521,7 +521,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
> >                * ctlr->bits_per_word_mask, so this shouldn't
> >                * happen
> >                */
> > -             unreachable();
> > +             BUG();
>
> checkpatch says:
>
>   Avoid crashing the kernel - try using WARN_ON & recovery code rather
>   than BUG() or BUG_ON()
>
> Which makes sense to me. This is not something bad enough to justify
> crashing the kernel.

I thought about rewriting it more thoroughly when I wrote the patch, but
couldn't come up with a good alternative, so I did the simplest change
in this direction, replacing the silent crash with a loud one.

Should we just dev_warn() and return instead, hoping that it won't do
more harm?

The backtrace from WARN_ON() probably doesn't help here.

       Arnd
