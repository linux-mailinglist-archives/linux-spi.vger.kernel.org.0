Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88E12B7CF1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 12:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKRLlL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Nov 2020 06:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727934AbgKRLlK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Nov 2020 06:41:10 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EBB22244;
        Wed, 18 Nov 2020 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605699669;
        bh=/iWyRf0Qo73rzS60vJwLkUm9F/LYP/2TxpHaJJkQEU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1VHm5FT+8S07CtDm7rlRqg7+ZPh+I1bg+R85y88wiOlths0B5oUS0yJCOc/PruVb
         kXzkyGaPSyomjiOlIX6l9OvTXikH8VMMjTlCQdZU2u9aQV9U8aaUh+WUmSOFSnriDB
         ejhZTmSXt8kkc7GaV/IPtOpoas7ghjcI30Bd9XZo=
Date:   Wed, 18 Nov 2020 11:40:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
Message-ID: <20201118114049.GA4827@sirena.org.uk>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk>
 <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
 <20201116210632.GJ4739@sirena.org.uk>
 <CACRpkdayWzWKHv69cg_GL2O=NWozqi_ZLnH1WdMOHzEb1bU-xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <CACRpkdayWzWKHv69cg_GL2O=NWozqi_ZLnH1WdMOHzEb1bU-xA@mail.gmail.com>
X-Cookie: A nuclear war can ruin your whole day.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2020 at 02:03:41AM +0100, Linus Walleij wrote:
> On Mon, Nov 16, 2020 at 10:06 PM Mark Brown <broonie@kernel.org> wrote:

> > I think the main push in the other direction has always been people who
> > want to not have to write a driver at all and put absolutely everything
> > into DT which has scaling issues :/

> What I can't understand is what gave them that idea.

> This thing looks like a dream to these people for example:
> https://gist.github.com/Minecrell/56c2b20118ba00a9723f0785301bc5ec#file-dsi_panel_s6e88a0_ams452ef01_qhd_octa_video-dtsi
> And it looks like a nightmare to me.

> (There is even a tool to convert this description into a proper display
> driver now.)

> It just seems to be one of those golden hammer things: everything
> start to look like nails.

What people think they were sold was the idea that they shouldn't have
to write driver code or upstream things, something with more AML like
capabilities (not realising that AML works partly because ACPI hugely
constrains system design).

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+1CEAACgkQJNaLcl1U
h9Cw7Af/eN2uIk9j6rgmXtnqSC8+jausLofGPpPhhJXMNcbfaJ95BXqY3iGv6t+p
9P+7MiPqhttKApFoZr9sz4gCRycPKZjSRDjQNld51LxIHCZlomSVu0/+Zyp1Ox3f
pKDrfAam4S5mg//oDpIiNlfblsASf6vNe/yfpPHoKfH/Dup+kRjvZ2FI9dXILNex
CsNIVnPn+URCnzRpVLUv6KNWGfDhHmdtvU0XBm0QXjDBBq/K6qt82sDEBomMi+wc
YwpWzFgrE0Ml5LVmex9UISJM9txSbcmbL1IIG4rVFWvuMju1Lm2xDijTS1muytp0
pdtd/U3CZB5mFExu6KygsNjR8pwC8Q==
=FHzQ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
