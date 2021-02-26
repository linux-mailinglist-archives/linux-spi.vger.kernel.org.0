Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B73261C0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBZLG5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 06:06:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45048 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhBZLG5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Feb 2021 06:06:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11QB4twq079584;
        Fri, 26 Feb 2021 05:04:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614337495;
        bh=MdgbDRHH4dg8uTJtgWTuDNWRvpN3VoqBOgFyw0Qzq/I=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ntQy2PrRI5Qsyt2FubX0iw8ZrbOAnRqJKEKlkAbQNAEAx3Bs7KIWLeKKGmjhofOzD
         KfHtMhQYvnbGilCIUvCkSPyFkQXrPwpYkO+jcSX7Aorjo9GJqisVynL/SdIxD9RePg
         V9k1ZcbDrFXFwZ13klbItKptOucLmvtQTctQL3HM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11QB4t7L097559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Feb 2021 05:04:55 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Feb 2021 05:04:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Feb 2021 05:04:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11QB4s96066246;
        Fri, 26 Feb 2021 05:04:54 -0600
Date:   Fri, 26 Feb 2021 16:34:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
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
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
Message-ID: <20210226110451.ijpllyczuquerfsr@ti.com>
References: <20210225125541.1808719-1-arnd@kernel.org>
 <20210226081548.h5ls5fxihunzxjvx@ti.com>
 <CAK8P3a3ep7DFnMYnA7q5b-P8X7nd3TAz=t82011j8=koK3T08A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ep7DFnMYnA7q5b-P8X7nd3TAz=t82011j8=koK3T08A@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26/02/21 10:49AM, Arnd Bergmann wrote:
> On Fri, Feb 26, 2021 at 9:16 AM 'Pratyush Yadav' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Hi,
> >
> > On 25/02/21 01:55PM, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Building this file with clang leads to a an unreachable code path
> > > causing a warning from objtool:
> > >
> > > drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
> > >
> > > Use BUG() instead of unreachable() to avoid the undefined behavior
> > > if it does happen.
> > >
> > > Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/spi/spi-rockchip.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> > > index 936ef54e0903..972beac1169a 100644
> > > --- a/drivers/spi/spi-rockchip.c
> > > +++ b/drivers/spi/spi-rockchip.c
> > > @@ -521,7 +521,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
> > >                * ctlr->bits_per_word_mask, so this shouldn't
> > >                * happen
> > >                */
> > > -             unreachable();
> > > +             BUG();
> >
> > checkpatch says:
> >
> >   Avoid crashing the kernel - try using WARN_ON & recovery code rather
> >   than BUG() or BUG_ON()
> >
> > Which makes sense to me. This is not something bad enough to justify
> > crashing the kernel.
> 
> I thought about rewriting it more thoroughly when I wrote the patch, but
> couldn't come up with a good alternative, so I did the simplest change
> in this direction, replacing the silent crash with a loud one.
> 
> Should we just dev_warn() and return instead, hoping that it won't do
> more harm?

Hmm... I'm not very familiar with this device or driver so take what I 
say with a grain of salt. On the surface level it looks like it might 
end up doing something wrong or unexpected.

Returning an error code from this function (along with the dev_warn() or 
WARN_ON()) is the most sensible thing to do IMO. If the SPI layer sends 
an invalid value then the driver should be well within its rights to 
refuse the transaction. The function is currently void but making it 
return int seems fairly straightforward.

> 
> The backtrace from WARN_ON() probably doesn't help here.
> 
>        Arnd

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
