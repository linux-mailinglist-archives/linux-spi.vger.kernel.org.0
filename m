Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B745D37A91B
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhEKO0U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 10:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231305AbhEKO0U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 10:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2336B61376;
        Tue, 11 May 2021 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620743113;
        bh=cYKm6HVUSnlFpYItm/yTuj98lPr3iKAOjcgTiF6rZq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsG2FuIq3Ck8y3US1ag35agxE88VEuQwZehX6D0TlMq1JASIKEiF9vUNCUO8uw3Px
         Sur8BGfFnnBYgsFCgR6PNaf45yhze1jrDBunl1J/KkoFefP3Tbpp0dJg8vAvfGct96
         6z8rvZVXNcd7Xb7gan2AOYSdOyvuSBzi1XsJ+dSgXm9UghLMSIUwZ+WjuhKoGP6T50
         C43SR9bxDMeSIcryWTuNyKhzHtsMKpyy6ZHUyQFGneP+D59gMaPgFvFOwvmvAuoWs/
         EHJZbHp8114QfSw7g/EP0uuFf+KmwjT7CBzN9sofGC6py/feYBr63nXnlRSMwZtZe1
         HTEA2eG/MNyCQ==
Date:   Tue, 11 May 2021 15:24:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <20210511142433.GK4496@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk>
 <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
 <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
 <YJqRBIdTlvnsCYsn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Content-Disposition: inline
In-Reply-To: <YJqRBIdTlvnsCYsn@smile.fi.intel.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 11, 2021 at 05:13:24PM +0300, Andy Shevchenko wrote:

> Just in case I'll send a v4 with only patches that missed.
> Otherwise it will be the same as in v3 (see above).

Please stop.

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCak6EACgkQJNaLcl1U
h9BzfAf+JkN8G2rlBgCENlamTmALPdNW3irdn7hPyTC4DM9BFCiQ9erqn4QE+bnA
tysguWfrDHJbYsdP69f9edgfJNDbsICh1x0lDWqh5nWrpUXVFoyxe+gwqH+2BsnS
32yNepXNDijBa4thZTEfGO5IRNt6xGRfNZCh3osEOyJUDpvSt6WRaK1HQSJ++f6o
nt2m9dhUM3fvScGGrnGjT95aPynrtHW76YoY48nUTv3dXtJJn8v7DHCGFIKvFmI7
DW4m2xsqQLW5SvuSMe/ikwVkso9MDNOqD1iAy5A/eElH4pCbRAiK7wy+w4Sz5NrM
V39IAC49EXHnhcAUE0wbZoS/M0bz7A==
=69fW
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--
