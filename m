Return-Path: <linux-spi+bounces-11694-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D9C982F7
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F84E1371
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299433468A;
	Mon,  1 Dec 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJDCkqCg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4B248898;
	Mon,  1 Dec 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605343; cv=none; b=FuMGXgJd/R8xPFxfEfIqf6ZWEaNN4UhHJCJIBikjlFbJjQ0uh7WyEhBWeKiyU0cxUPbPmb6J89wgixfAuUB/9mOMCyfVK6kcLK1wFWZkNOLtpqTF/QUrPSeVx3QRUT8cp2P0GkrShjACKIm7VNBe+R3gLiM6LskJGXpsiGk97hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605343; c=relaxed/simple;
	bh=p2riUpZt2f8P3dFBKBKBp5idIMSAisOHnNY+os6ih/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjQXm4wbQWqE5q5jXu/I2vZNgJvt16OW5tc1a0mwcoaQf9IWjZU5ZJpMVA4kmVFS+a/uwjFcWAsni/BsAXc3oOHIuie3RaqfRqp8u5k3XpkSHYKjDrInF7XDiZwZkTgzgwDSC9h6mE/cQ66CGHJxjt2uQlSyMX2M5sM/+erb6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJDCkqCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162ECC4CEF1;
	Mon,  1 Dec 2025 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764605341;
	bh=p2riUpZt2f8P3dFBKBKBp5idIMSAisOHnNY+os6ih/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJDCkqCgnL7Whx3r3NZZYOp0OUauC0FrN/yfKULpHjv2RsFJfwurltyW+6BkFyvWy
	 DxPeuXPWnSm3x6qSlR/zcws0aiaCKwgmE3uDUYgeA0YyRbDDJmiFvoadesuSNKmdk8
	 5kzeyF6/VCTy5h9dDEmZywlSE+IEP+9CcCoS6GO9aje1JKxvT7ahvg3n9MbEpC2w8O
	 etjlU18u368F0jSi7zt+hAbyAcgTBnPAy1mtddonvGQsHa8jrszbtPLRjNzDZyEAlT
	 DQBq6XDRvDh5zvD+f4h3mJhQg6gVQpkB5Zr5nQeWcXhKlPsZ8QTrE5AtTn3+fbCl+p
	 31oWBRK/a95Fw==
Date: Mon, 1 Dec 2025 16:08:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] spi: microchip-core: use XOR instead of ANDNOT to
 simplify the logic
Message-ID: <20251201-calamity-favoring-b2d1ec4bcc81@spud>
References: <20251128185518.3989250-1-andriy.shevchenko@linux.intel.com>
 <20251128185518.3989250-3-andriy.shevchenko@linux.intel.com>
 <CAOiHx==y-4Jjckr-KnwdmJhi=TR9_wzcHvNo8GAeUmJ43Y_bHw@mail.gmail.com>
 <aSqsdKpJ7CDd6jJn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IegB0pAUZdnof9LA"
Content-Disposition: inline
In-Reply-To: <aSqsdKpJ7CDd6jJn@smile.fi.intel.com>


--IegB0pAUZdnof9LA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 10:19:00AM +0200, Andy Shevchenko wrote:
> On Fri, Nov 28, 2025 at 08:30:43PM +0100, Jonas Gorski wrote:
> > On Fri, Nov 28, 2025 at 7:56=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>=20
> ...
>=20
> > > -       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits=
) {
> > > +       if ((spi->mode ^ spi->controller->mode_bits) & SPI_MODE_X_MAS=
K) {
> >=20
> > This changes the behavior: if a bit isn't set in spi->mode that is set
> > in mode_bits, it would have been previously accepted, now it's
> > refused. E.g. controller has (SPI_CPOL | SPI_CPHA), device only
> > SPI_CPOL. 0x1 & 0x3 & ~0x3 =3D> 0, vs (0x1 ^ 0x3) & 0x3 =3D> 0x2
> >=20
> > If this is the actually intended behavior here, it is a fix and should
> > carry a Fixes tag (the message below implies that).
>=20
> Yeah, yesterday I was thinking about the same and I was confused by the l=
ogic
> behind. As far as I understood the comments regarding mode provided by DT=
 is
> that the mode is configured in IP and may not be changed. And you are rig=
ht
> about the fix, but let's wait for Microchip to elaborate on the expected
> behaviour.

Prajna is on holiday and I don't have a setup to actually test this on,
but I'm 99% sure that you're both right and the original behaviour was
wrong. There's a verilog parameter to the IP block that determines which
motorola mode it is and a device that's not an exact match won't work.
FWIW:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> > >                 dev_err(&spi->dev, "incompatible CPOL/CPHA, must matc=
h controller's Motorola mode\n");
> > >                 return -EINVAL;
> > >         }
>=20
> Thanks for the review!
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--IegB0pAUZdnof9LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaS29dwAKCRB4tDGHoIJi
0pLdAP0RGR6QV7NxUY2WTwChYhBcLzQgVw/mFZOns3c4M4/cmgEA/EZhYNo8lqqC
j8UIX4IKuaL54E2IK9gCcQzfc2F6VAA=
=BVwB
-----END PGP SIGNATURE-----

--IegB0pAUZdnof9LA--

