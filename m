Return-Path: <linux-spi+bounces-4777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7BF974026
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B728AAEE
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197341A76A5;
	Tue, 10 Sep 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC0K3opP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCA1A3BB8;
	Tue, 10 Sep 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989253; cv=none; b=ezNoRAh2KsHH9jZtD9n6TQ4qDJCWz4JRUiuzc024eF0dRmYt9pGYl1RgSLTobzs9OtxkON5gxDd50arcaYz5w19ulQupYp1R+3TIWgSlulvVHCbmdfB2Og1LEhoEiQUJIECB3WH/dHJ0CiHAHabrX/W4fXLiDZfhJ9tsnmJQUzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989253; c=relaxed/simple;
	bh=dlXBgd30sG1b7BKaQ9wxKbHzoEOj63Y0GD0O7Q2nZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4q1xhLpjND3DnsMg/pYKy6EXBOY7469nJKnr0pWSLge3vCi5cHQ/IYAgsPnfKAIkxNQjM+3vsm6OOxFxwPibAPUwv8tnYyPTL9DK4ZgF7IajQIUWjjnp9aRhjwNRK2nE7bOEI2qIv3KtshSRtTGHn7MFD5jdo2GfASA53bp018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC0K3opP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FD0C4CEC3;
	Tue, 10 Sep 2024 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989252;
	bh=dlXBgd30sG1b7BKaQ9wxKbHzoEOj63Y0GD0O7Q2nZJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VC0K3opPMwCpPQxdq7nsBjx5otInm4AUeNE3cKvbv/Z/VRKPOVjQmSz/LkYV5yDAe
	 mmLP5q8CyFSpCtEerznqas0WGPxkeAe1cUHapMbx40bMLndH8e3aHLeiOMiMGrK+6I
	 nS04Xl3syW1wBaS7tLC4pU2Q2nrrGQVC70iSIUF75KDPFMmnFDFFWPCJQ/02+7+p67
	 akIRjuggC/245shIRzCMsbGociucJmA/z2OtiloApTJjgvyznTBzwxVnLDOoVskykz
	 Ka1US6+ZPBl1/U9hgT+WooxdPFEfIcvG6/0INCsnEZkMjs/sa4UD/jq7/2Ec1+QFiZ
	 Lb+FPYX5mWZDQ==
Date: Tue, 10 Sep 2024 18:27:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 09/18] spi: spidev: Add an entry for
 elgin,jg10309-01
Message-ID: <23411f79-ac68-419e-8c28-640dc3df1e40@sirena.org.uk>
References: <20240910172214.2415568-1-sashal@kernel.org>
 <20240910172214.2415568-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjpU5CFqCk4L+kwi"
Content-Disposition: inline
In-Reply-To: <20240910172214.2415568-9-sashal@kernel.org>
X-Cookie: You're not Dave.  Who are you?


--gjpU5CFqCk4L+kwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 01:21:54PM -0400, Sasha Levin wrote:
> From: Fabio Estevam <festevam@gmail.com>
>=20
> [ Upstream commit 5f3eee1eef5d0edd23d8ac0974f56283649a1512 ]
>=20
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
>=20
> Add the "elgin,jg10309-01" compatible string.

There's also 5478a4f7b94414def7b56d2f18bc2ed9b0f3f1f2.

--gjpU5CFqCk4L+kwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbggX8ACgkQJNaLcl1U
h9DuXAf/UhjqNVahzVP40Mq3BEEhi/jeJCnC19zKpeV8uTuuVBsA3HoSaEOhzVj0
0A/5E20Qfi2miIEAbpvHfha28K2xUCNSCmGPrnEoA9mJwzSZiT6YUQICohMS3r0z
8GLNcjhGg6ak482VQ5SS6SGzJpjMGah3godJXZidmZ0XN6xt1m5NseqX0ekoZlG2
xTHQ4cxVufa6zzB0RNT+k9bjUmk97fNBBrCisRDqAVI/4BWLDEoyPy3zZV0Q47oW
sovp995kKViTVD8Kk/NT+TTvFvo2kt2AR36eER+WzSqHMjSjolpNwexPhF7AZVt/
mGd2Ih07bqxE40RMXj99ErZT8CoU/g==
=b4Ep
-----END PGP SIGNATURE-----

--gjpU5CFqCk4L+kwi--

