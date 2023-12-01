Return-Path: <linux-spi+bounces-116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E58801320
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 19:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6157B280D9B
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A526ACF;
	Fri,  1 Dec 2023 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eix0RHOr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384B51023;
	Fri,  1 Dec 2023 18:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A377C433C7;
	Fri,  1 Dec 2023 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701456626;
	bh=nlNo7xM9XoRlNYHh2JQaIekxrQZHPuEHEh20xUWik9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eix0RHOryZ9fBUgKkiP3QDCZYWkQfGj0qw7PH2nt9Ij/gX120ikLc9r3jpDtMy6sf
	 rgmZGHvqQNVhKOxcLmZ161yUAiZn4s78Y23brUdPGdPhTAhFC+i6FJz3XugCzxHlRp
	 Ig+ududz0DuZtxihAgmEp4sXjkOSrBRJ2O122FhozAoQ+kb7GVueZW2LgPNs0rW5Bf
	 YXy8lQVXxIuYYtN19fcnKuN4Ec5bSzGzd23rAds2gzKmFGQo1LsE0NIgp0s2eRVuGk
	 VkpLlgLZlFsGR+b2Yk+9FKc8ZtqR2/HbOqP+o8Mbd+pizyhKM6IIQ+t/Dcj9TftAw6
	 NXhpQFInUQ95w==
Date: Fri, 1 Dec 2023 18:50:15 +0000
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
Subject: Re: (subset) [PATCH v11 01/10] mfd: tps6594: Use set/get APIs to
 access spi->chip_select
Message-ID: <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
 <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uaQ9X2fe+EqjZHC4"
Content-Disposition: inline
In-Reply-To: <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
X-Cookie: The early worm gets the late bird.


--uaQ9X2fe+EqjZHC4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 09:57:36AM +0000, Lee Jones wrote:
> On Sat, 25 Nov 2023 14:51:28 +0530, Amit Kumar Mahapatra wrote:
> > In preparation for adding multiple CS support for a device, set/get
> > functions were introduces accessing spi->chip_select in
> > 'commit 303feb3cc06a ("spi: Add APIs in spi core to set/get
> > spi->chip_select and spi->cs_gpiod")'.
> > Replace spi->chip_select with spi_get_chipselect() API.

> Applied, thanks!

> [01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
>         commit: dd636638446c87c95c5beddcd367d95ac6764c6c

Is there a signed tag available for this - without this change the
subsequent SPI changes introduce a build breakage.

--uaQ9X2fe+EqjZHC4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqKuYACgkQJNaLcl1U
h9APAwf+KLPqe9oVMKPnVoC0/RKtAWqn22qR/OisWnbE+SjMxYnOliwWr1Uy1gfO
VQpQx3O/7kKmZ5aYGt82J0rykYY+6IFwHvgwUu67iYpCzQgmhVbnbh1B94YeZIkV
SUkOiN7HUoTbbExTLVa5Jn+5+LKRmMkbjYXVdpb41Jz/fyGNAidXizOnpqct/Qp1
dMNggC1eWI/kqsOjSr9obsJHhIcyM7u1pwaicJzWGG7SwNM0PSramv3lCHpaKH5W
UbyLbyZ+G0Z2JIwwnq1hFEyklQ1RVInt+3p4rfYhIInMDF+5cQPUjBTcS4k8ho1J
FDPG03/Neeonh9yIf8+TSmQ4tVxszQ==
=/wO/
-----END PGP SIGNATURE-----

--uaQ9X2fe+EqjZHC4--

