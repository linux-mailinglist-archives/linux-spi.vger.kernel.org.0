Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C8B44C2C7
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 15:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhKJOOA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 09:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhKJON7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Nov 2021 09:13:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4AD1610F7;
        Wed, 10 Nov 2021 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636553471;
        bh=Di+3kJRyu5hzLlxOpZUKVUVFeNHawzNYIh09nmQ7lp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGG7jRKNQiATKNV6i4w26E6kdHwRy2flrBVv/9G7Vj2yAAos6xaTs0ivVcGe/Lchq
         YnOr9ntW1/cKljEtnDPJMkDtLL8MOWEvRswqEB/X76HPbEqKrFWGKPsRor+nS5BP4Y
         24Ev0LROapBeCHppsqSba44IXXeHLKDOtWGygDcKE1ccW+/mnWTx6KI3NpKSjD2sep
         EYqbKqYdVrbwjlV9LeWN3azg9Z3gVLBYIElwcw6DB1dUoF9dcoovyVpsAXy0AQYMcf
         791vw0qj6qzP2BGzJFMoQ64JqAkkUh2g+vrCGXyIXveEVafO4EtiWCWX70/KYin/qG
         Emboqujh7N7wA==
Date:   Wed, 10 Nov 2021 14:11:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lh Kuo =?utf-8?B?6YOt5Yqb6LGq?= <lh.Kuo@sunplus.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>,
        "qinjian@cqplus1.com" <qinjian@cqplus1.com>,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: Re: [PATCH v2 2/2] devicetree bindings SPI Add bindings doc for
 Sunplus SP7021
Message-ID: <YYvS+p4ON5D/V7jE@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-3-git-send-email-lh.kuo@sunplus.com>
 <YYqMcrEhVWxe5By/@sirena.org.uk>
 <2eeae9b780e94ac9810ffffe249098f2@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nyl6UvCBOw4Y9nmf"
Content-Disposition: inline
In-Reply-To: <2eeae9b780e94ac9810ffffe249098f2@sphcmbx02.sunplus.com.tw>
X-Cookie: You have junk mail.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Nyl6UvCBOw4Y9nmf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 02:47:09AM +0000, Lh Kuo =E9=83=AD=E5=8A=9B=E8=B1=
=AA wrote:

> > > +  reg-names:
> > > +    items:
> > > +      - const: spi_master
> > > +      - const: spi_slave

> > What exactly is the physical overlap between the two controllers - is i=
t just the
> > pinmux?

> According to the designer not only pinmux, The power source and more desi=
gn are overlap.

> That is why I hope set it in one driver.

The power source just sounds like a power domain which doesn't need a
shared driver, and shared elements in the design aren't really relevant
if they're not visible in the usage of the device which given the very
limited code sharing there seems to be in the driver doesn't seem to be
the case here.

--Nyl6UvCBOw4Y9nmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGL0vkACgkQJNaLcl1U
h9B9ggf+LhBJCEcQEiflSqmQWK6mee/XRX87kDJKZt7gA+iYGL6X7i252cT3Ky4L
3gfnLphDqNLlzexqLyZi3n2D0bv9YMfQJU84VM3mwXYHqmyzsLe9K0JuVqDWBl0D
N/uN893B8ZQIAvXfDT2jMP1N2ZAuOaCBIxKkQ4SszMNj+Pk2IFNsFbcQ1OoxI7LS
j8Wailql/PUeGLwLer0+8rYRZQHnstuxgnMF7UyIpPvrL9tW+5hDFgovugI4sOqc
r0mLOIwsNtVs/2Y+H974EYhJyUZjO2NU3DgGywqd3oql3Ij7pdWlHVIahJfMDO/p
haRzpeMQQVkGnLA5m2zyTTDpbgsH7Q==
=gDAp
-----END PGP SIGNATURE-----

--Nyl6UvCBOw4Y9nmf--
