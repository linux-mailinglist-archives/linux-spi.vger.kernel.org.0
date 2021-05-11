Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDA37A9AA
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhEKOj6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhEKOjy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:39:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A295A61285;
        Tue, 11 May 2021 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620743928;
        bh=KtAqqyCSD2/PMLUzMvk41vJZrkttmXflY20N0F0OLzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ukIHJxTAu5BdyDy26nRYBGqWvO3onyx7l0X21OdTqi/KlZyTduAn7XWowP0CAfu8+
         OG2eO1SymeMJJ2M5tPKX7UHkxkKMxXhkWbI6Koo7CfA4VdbJDMlyNmdvkJGVGkPItc
         hpxmcumSirQkUGhj6Q3/yC+RYRwsfQ4M/j6rembcWbJXFPEzX5TG6uL1OC4HWfUgD1
         6Qv547lGeds/8lxChC8e6pdfWd6bs34hQbk5H7IsRbEIEs8voSbRPQwRYqwd/PBxE7
         n4/py/eF1XXlbkiSg0Sbq6mM42PNLjoOk5aOk6TLIJWMHNurtOPHTXQ0oLTUfxX3lJ
         3W7ek9xxUWNLw==
Date:   Tue, 11 May 2021 15:38:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <20210511143807.GL4496@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk>
 <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
 <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
 <YJqRBIdTlvnsCYsn@smile.fi.intel.com>
 <20210511142433.GK4496@sirena.org.uk>
 <CAHp75Vfh4AViMMSm6MKAGP7s_ANOSyHVDj5qG=j5YrLPjH+Y8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline
In-Reply-To: <CAHp75Vfh4AViMMSm6MKAGP7s_ANOSyHVDj5qG=j5YrLPjH+Y8w@mail.gmail.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 11, 2021 at 05:28:13PM +0300, Andy Shevchenko wrote:
> On Tue, May 11, 2021 at 5:25 PM Mark Brown <broonie@kernel.org> wrote:

> > Please stop.

> Okay, what should I do?

Nothing.  Just stop sending this out until I've had a chance to handle
the current version.

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCals4ACgkQJNaLcl1U
h9BEtQf+LrhwInOnS02oNHeKCYITflUNiWjMOxLrG+jowVO1vmSX1VMcMXPGKoA+
xfs2m2RZaDqieSsFszwMuwVsHPcG2OrApe2Je7lEihLv5SLkZWozt5o3ocNsQCoM
kBLF8siXnYB+nTrhMRLqu06h/1XW7dxYaRJp/XB2ABAaAcEOdMy5OxmfR4AkqtCG
IhoyzcLWMNpOqV21a+r1haRcIafy8ceaPXl+MVECP/HjLQ9N3VUiE5pnDvROOgz9
e7bIo2zelMSwERb/zjpROKo0c2ExluviDv3lWbySNmU65wRbAbHcJs/3xJLJGXyw
x0zHMkSCpa/eIkDqym432py3P3Y5fg==
=JIiX
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
