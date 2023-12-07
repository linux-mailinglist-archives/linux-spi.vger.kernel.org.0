Return-Path: <linux-spi+bounces-168-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD6808D00
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71511F2109C
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6D46B9E;
	Thu,  7 Dec 2023 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaX+Amr4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6D3309C;
	Thu,  7 Dec 2023 16:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE46FC433B9;
	Thu,  7 Dec 2023 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701966052;
	bh=MBl8jX+CYsWd6FZCSkh8ink0zxCjpM93rbZyvHRV2R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaX+Amr4+2De3B69b6K4i/wdD/KlCz19NtGb/HlW2OyVVH6jkUYW99P33NutAtN4J
	 A0nJKfpdTQgOybcd97ybL7zLpQcpAoIfs08y/yLVszKPYo/p+7aHgn5ouMxal5zYoQ
	 neQnIF9I8uOtFo2BAuAC+cNRUgo3VlEwViQgAwkE3Y6L8ngIELWn0jYiUvgC0Tfw/T
	 15nM8TDyTLAx6xgL9Dl9eBYcgSLXtLh34DH8JSLBQEIAB6zRSvv4ifzuKJxcwR84Qo
	 O6eqsr+covJ2qISwOFeGcu9CXz+wIGANUWkPYIT3T2/5srMqIVYD9zUL5gKYmw2wNS
	 ougPA1Q+aQ0Jw==
Date: Thu, 7 Dec 2023 16:20:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: tudor.ambarus@linaro.org, pratyush@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sbinding@opensource.cirrus.com, james.schulman@cirrus.com,
	david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
	tiwai@suse.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael@walle.cc, linux-mtd@lists.infradead.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, michal.simek@amd.com,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [GIT PULL] Immutable branch between MFD and SPI due for the v6.8
 merge window
Message-ID: <d12da7b2-f18c-4b56-85be-6d98b62d6ddd@sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
 <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
 <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
 <20231207133849.GB8867@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H1tMbLV73SdOkctb"
Content-Disposition: inline
In-Reply-To: <20231207133849.GB8867@google.com>
X-Cookie: Two is company, three is an orgy.


--H1tMbLV73SdOkctb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 01:38:49PM +0000, Lee Jones wrote:
> Good afternoon Mark,
>=20
> > Is there a signed tag available for this - without this change the
> > subsequent SPI changes introduce a build breakage.
>=20
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-spi-v6=
=2E8
>=20
> for you to fetch changes up to 4ae08845db4c1f759b8382bc7527ab8249230e7f:
>=20
>   mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select (=
2023-12-07 13:36:29 +0000)

Thanks!

--H1tMbLV73SdOkctb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVx8NoACgkQJNaLcl1U
h9BXiwf+NG+nYvE91fSSJn6y9dB1oLiMaR2BUDYVTOuWkwmRWLtbTbJgJwxJfBqH
itW5Xs7GuEJ8Rq82sl4K6ITes+jLCB1ljYdbbH4QTqo7Sm5MjdRwGQczHbe8FONG
FTu5Oa7WGJfTQa7tTu7TOJU16Dd1YPVT4QO8Zg2D6Fvltfdh5y0vTJO9LxdA99cE
11d/pzJGFKEojADXl3V7RFLAiJJAFpri7C730ZOZ30WRt42f18MTl7omglIGAQOE
6YvN9sSZ57FEQuWaoIKp8IGnOukM4eqEwuwx8CqUNGfD7ag9ffo17PpytPgQosoX
6xPrq5I2cgrNMJzC71jsMobrBpQF1w==
=4OmM
-----END PGP SIGNATURE-----

--H1tMbLV73SdOkctb--

