Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269E73DF5B5
	for <lists+linux-spi@lfdr.de>; Tue,  3 Aug 2021 21:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbhHCTbQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Aug 2021 15:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239395AbhHCTbQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Aug 2021 15:31:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36EC2603E7;
        Tue,  3 Aug 2021 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628019064;
        bh=QY2GEHpzXPPU0n5auFTFTfMaTFjPa4x8HiZo7mTWQgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLiKixCz8EnFb9V5uP5sl2zskq4skQRGJDWsaHY+BjhKr6Vl/zauwb4+7GEMHEU2t
         nMSXVjmqUsApK2A+HzwrWQ3HxtMgiWvhP2a9pJNFeLgGVo1hM9/A8/Xw64V7CMjQTV
         vXFIVSILYauP+bOsMEYUTco7ZNI3ona3u7GJ2sUtXSOzBjU2ay/EWb3qvxEYDCspHc
         H7UH7ykNGZfycktslFB0KNDzdaxhQipIYUCAehTwlDN1IV3cJCl1NiL0t7HoSyhOGA
         Dm25+oiXlRm7TU8thaVxRAE76DCalCv28td2CmW0TtnT+mwUR8q7mk+BSwNH+D1xah
         akfxiBDhQao8A==
Date:   Tue, 3 Aug 2021 20:30:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mason Zhang <Mason.Zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v2 3/4] spi: mediatek: modify set_cs_timing callback
Message-ID: <20210803193049.GQ4668@sirena.org.uk>
References: <20210803102428.6476-1-Mason.Zhang@mediatek.com>
 <CAHp75VcPhBB+21wVErWRq+mSDaCkpQBovn+xvMbXyfENnuu40Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z87VqPJ/HsYrR2WM"
Content-Disposition: inline
In-Reply-To: <CAHp75VcPhBB+21wVErWRq+mSDaCkpQBovn+xvMbXyfENnuu40Q@mail.gmail.com>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z87VqPJ/HsYrR2WM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2021 at 09:20:19PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 3, 2021 at 1:42 PM Mason Zhang <Mason.Zhang@mediatek.com> wrote:

> > +       inactive = inactive ? inactive : 1;

> All of these can be simplified by using ?: (short ternary) form.

Please don't, if anything just don't use the ternery operator at all for
things like this - it doesn't help with legibility.

--z87VqPJ/HsYrR2WM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEJmWIACgkQJNaLcl1U
h9DkVgf/Rv7cu2sTnh6I4OzeDeohVJspONWje3p7I9opiL1FrbONWkc1yKFmhBay
7aUfYhbl9Z+VXUyWmuBCe668PGRT/j0a/9uVsQaKER1xNaW3BaWH5Av99TSZsyB+
J90YRP+TqT9G60dD5jgHodAJ3jEJePoU+7CXCuR4OvhBqdn7SVLD0BMBiwH90cOg
CeyEHO/go1UN/B+CZbKds2d1/uYPh2wmH2JHsmxoYFIRxLKdQkEVpRgTy13dnzy2
p2doLPsVrdHI04N2O4yZKEZrmi5YEtReig8tyGRjMYdP1bC//tLdw21Fy49CsFxD
e8hBwYgr3MfOaL/EW96PbEdXWRGaKw==
=HNVE
-----END PGP SIGNATURE-----

--z87VqPJ/HsYrR2WM--
