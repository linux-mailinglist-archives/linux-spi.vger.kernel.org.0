Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4D10A1F3
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 17:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKZQX5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 11:23:57 -0500
Received: from foss.arm.com ([217.140.110.172]:36464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfKZQX5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:23:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D2A30E;
        Tue, 26 Nov 2019 08:23:56 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471DA3F68E;
        Tue, 26 Nov 2019 08:23:56 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:23:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
Message-ID: <20191126162354.GA4205@sirena.org.uk>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
 <d144f86e-48ff-384a-2937-639c0c6dd3d8@c-s.fr>
 <CAOMZO5DJ+UGuNN-5gZE68Yt2ZTBVZ50teo9H0=c-Rgx+oFAa7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DJ+UGuNN-5gZE68Yt2ZTBVZ50teo9H0=c-Rgx+oFAa7A@mail.gmail.com>
X-Cookie: Where's SANDY DUNCAN?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2019 at 12:35:35PM -0300, Fabio Estevam wrote:
> On Tue, Nov 26, 2019 at 12:01 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:

> > How can we progress on that ? Problem is still present in 5.4

> Linus has sent the following fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20191126&id=c5923243eb3208ea63b5ed7905610039c4ca5201

> Does this fix the problem?

> If it does I think this need to get into stable too.

Ah, I hadn't registered that that fix was for something already in
Linus' tree rather than new development otherwise I'd have sent it as a
fix.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3dUZoACgkQJNaLcl1U
h9Cmwwf9HXe0814A4Tv9PLJBv9iG+wT9Dnv2nJeE/FAwL3lrS9HuGJrU+rmDD3+C
3Omxaf/pOwaCrisRH1jn7P+/qP5VCBqxo0KfE6h8XH+qMCskGFiwLJsVXi8m5mBd
SzTMr3qD46uxaIXCFDVIQIAMq6HVk+XF/SWtMRmvYeJe5br6OrGl+fDxd4ltNFuu
34g5qCJ10yk6aZ5xtFVKYQniQJ7Lk3ZoJT3lEl75a9FQ6bkKPpwRyu4ktZmDLFj9
VvbXUeu8gxQ3T/MFVmQ1tCeMI9twUq55h/H86FeHDTgiUbfJEJvSql4U2kOkcVFg
7KANnOyeSSNUnizMqet0tIecGzFuXQ==
=iom/
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
