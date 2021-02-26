Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF53261E0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBZLQo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 06:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBZLQm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 06:16:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA12A64F13;
        Fri, 26 Feb 2021 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614338162;
        bh=Tq7NSjbRAdAUuZaD3N8ugNfUFezue/5tJoEZmiouilE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HSDB8oCeaoz1dG4ZA8Ol0WP+pHw/nmGxHXL83nYMrOu4l80vxZfAKYqMgcAo1TZiG
         26YyUWdS99K2D8XNFoOOYjtTcjzmRfD/IIC+Y0EH/PsAEM5MM8dDYrh9h3J/tVm6BD
         Qek6yDAQRYGEAj8qNsWq5a+T1kBeQbtxRAtEhDw232oQpvc3KaXqfn1MqY/azmfLAu
         aCUEi3Uq+MoAeSsmLdXq3kDj+T2+tz4+PXljT4okPQZLJ0SD7RVOuAW7D+3M86IQwY
         gXSdEpfghNjOT8oIkC5gPcLRBXhco4ZFVn3/Tw9V9p/nSjc9kVaS2GMdOQrvP1NjLd
         tKRoJ8WcTCx2w==
Received: by mail-ot1-f41.google.com with SMTP id f33so8699654otf.11;
        Fri, 26 Feb 2021 03:16:01 -0800 (PST)
X-Gm-Message-State: AOAM530wQ9RzXNMw7j5ejFu6gVx8MeAZ5OssvyVxHrO3RbNFTLl3nMZ/
        3Co8eVszOyNbgeOT1tR8m5G6tj4GAhAZlvvTOF4=
X-Google-Smtp-Source: ABdhPJzbTD9+oRPkTWtTivkvm9UEiJBIin+bmH7bPY6EBzrYJP+wMWV0rwR2zLORG1tj9Ocwv5TU3B9IwWvguTNSaxo=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr1870333otq.210.1614338160965;
 Fri, 26 Feb 2021 03:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20210225125541.1808719-1-arnd@kernel.org> <20210226081548.h5ls5fxihunzxjvx@ti.com>
 <CAK8P3a3ep7DFnMYnA7q5b-P8X7nd3TAz=t82011j8=koK3T08A@mail.gmail.com> <20210226110451.ijpllyczuquerfsr@ti.com>
In-Reply-To: <20210226110451.ijpllyczuquerfsr@ti.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 12:15:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0C1aSgDm10gPtcognECo0tq3oRw+DbFsy+wz383qmrJw@mail.gmail.com>
Message-ID: <CAK8P3a0C1aSgDm10gPtcognECo0tq3oRw+DbFsy+wz383qmrJw@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 12:05 PM 'Pratyush Yadav' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On 26/02/21 10:49AM, Arnd Bergmann wrote:
> > On Fri, Feb 26, 2021 at 9:16 AM 'Pratyush Yadav' via Clang Built Linux <clang-built-linux@googlegroups.com> wrote:

>
> Returning an error code from this function (along with the dev_warn() or
> WARN_ON()) is the most sensible thing to do IMO. If the SPI layer sends
> an invalid value then the driver should be well within its rights to
> refuse the transaction. The function is currently void but making it
> return int seems fairly straightforward.

Indeed, this seems like a clear -EINVAL case. I've updated my patch, will
send after build testing.

       Arnd
