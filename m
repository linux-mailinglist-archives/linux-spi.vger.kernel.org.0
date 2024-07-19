Return-Path: <linux-spi+bounces-3904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D308B937512
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 10:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D86B21339
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 08:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071C57CBA;
	Fri, 19 Jul 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKl5ZV+4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554141A84;
	Fri, 19 Jul 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377832; cv=none; b=nxVvv6RjjXzFn0Qk49nwPa+ELu8LtVW3r+ktnLrWSBWPo0bbpvOL3FHE4KBiMHqATWCCf2WeHM93oSb1ywbJUVvXaUxpI6K2+3MXPzpML3OCe9tF2LYjvW2jnv8na4lzL/hq+G4Auko846swNgPDPpPsIY6Qn8paA0CIBEi7DTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377832; c=relaxed/simple;
	bh=2PmksIj6oonsnPWs40ZxdvxTFmSWN4RsqaK2jjv7Wbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtI94r+NRuGdoDCUdV5GnElO7VoQiVvyCx/nYvf74EXIcRpO0Od8/aWPTWyZGw2H8X1X9vg6M3d8vf7PEVsV+1zxIS4eUQU+BqBaD/poZWRnM/rtXPa6t4Wr1TJhMQNkmSoqyCQzpYIwUQWaziMa73Tb79R2CdP99Q8Uj81OhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKl5ZV+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D6C32782;
	Fri, 19 Jul 2024 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721377832;
	bh=2PmksIj6oonsnPWs40ZxdvxTFmSWN4RsqaK2jjv7Wbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKl5ZV+4+h7yPyZzbKrbMHjrHLAylIlFL9sRBuSv1+fkZOyBy8IJjJZlcqQRjchQm
	 TK8DKx2i9mhPkWDh3yzd8C55HvvaiKxB3mTVuB745m18ygg/fzrBG0v1Qtku5jGZ2K
	 CpWgAOuGbhDcvdWcvvq4FvoXaa+qyCgD0qoDdA3bYe4bz9KkWJMtgd12bDAYkvDjCA
	 JfVruBt9QlEBmUYlHZK+ouS9hMfyhhvb5a/+6x7lowdwfrtylkz0FrpEGEvvuPIeVF
	 4OnmLKbAd08Q9P1BZGhT1VY+pvGDRwn9Dy1DUDKi6JhTq9ENpVW9jC54jnRLik6+Rk
	 vR/YrDpivGwvg==
Date: Fri, 19 Jul 2024 09:30:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: broonie@kernel.org, Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe
 unexisting DAC device
Message-ID: <20240719-stagnant-chunk-dfc2a26fb345@spud>
References: <20240718200540.955370-1-festevam@gmail.com>
 <20240718200540.955370-3-festevam@gmail.com>
 <13142574.ZYm5mLc6kN@diego>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DL8qEaKK9QQKIWEX"
Content-Disposition: inline
In-Reply-To: <13142574.ZYm5mLc6kN@diego>


--DL8qEaKK9QQKIWEX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 10:02:56AM +0200, Heiko St=FCbner wrote:
> Am Donnerstag, 18. Juli 2024, 22:05:40 CEST schrieb Fabio Estevam:
> > There is no DAC connected to the SPI bus of the Elgin RV1108 R1 board.
> >=20
> > There is an LCD controlled via SPI though.
> >=20
> > Properly describe it by adding the "elgin,spi-lcd" compatible
> > string.
> >=20
> > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > Closes: https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-8=
3cc04bf6b36@spud/
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > ---
> > Hi Heiko,
> >=20
> > Conor sent a patch removing the rohm,dh2228fv entry from rv1108-elgin-r=
1.dts:
> >=20
> > https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6=
b36@spud/
> >=20
> > If you prefer, I can send a patch on top of his.
>=20
> The decision is interesting, one less patch vs. keeping Conor's separate
> patch history. Maybe Conor voices his opinion while we're still in the me=
rge
> window :-) .

Adding the correct device is an improvement over my patch, I don't see a
reason (other than vanity) for applying both. However, I don't think
that "elgin,spi-lcd" is a suitable compatible as it is far too generic.


--DL8qEaKK9QQKIWEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpokIwAKCRB4tDGHoIJi
0pwuAP9jiyYflvnsWtWCuzqtg/LKlZ4qtp/dVMasyjHgPq3u5QD+LIHZbj8ujmyo
P/pXBi2c+TQr5PNKwqpFKKGvhu2wDgI=
=QDKZ
-----END PGP SIGNATURE-----

--DL8qEaKK9QQKIWEX--

