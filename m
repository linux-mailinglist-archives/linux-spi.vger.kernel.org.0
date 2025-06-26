Return-Path: <linux-spi+bounces-8785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73DAE9CA1
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2473BD790
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3708F27584E;
	Thu, 26 Jun 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8t0lUe0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988C27584C;
	Thu, 26 Jun 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937675; cv=none; b=AW6O4EJ7NOj7Qr+yyJH7KAIpuEmf3R46e+i6t4oD4xkfjKwOUOHaq9TxHqNiQdilwMCqszH3jitlQUPy6yV6hSpSuEKcOfWWUqN3QWytjyeNGXZ/ekL9SIgrldNh5Sw3dTEe4YW0DgvOS0J2nDqKGpAuxCInRWddHwfteNg9KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937675; c=relaxed/simple;
	bh=y8dtuue6zG3Z62+ha6QZpJFJOue7deklq2PrhNeGUVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhpI9Y9KGAuKnDZXwP1yDaJoW651gvHmZIFzmKVs5SQuQKLSOHplZw5JIQlR/zRepk8+wvgsFmiG7Hpw7/zTBbnrAcFzEHQ9tQxJrpDOKtGjMm8/63vhBbG4UsMyvbwWcN62ZxM07D3Im4OalPyGV8QUi7iUisg0JfQ5b5qbv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8t0lUe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14633C4CEEE;
	Thu, 26 Jun 2025 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750937674;
	bh=y8dtuue6zG3Z62+ha6QZpJFJOue7deklq2PrhNeGUVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8t0lUe0dnz6RaK5LdH/exbPa16uKUOtSiPaw03l72RLwXsju6MWzQ1UBNcOIjhcs
	 dyYSTBvMlLdF8mbr9Z33+2aebEM8tKRidxEcKCbWetP/VG5l4ZtdytiOQZnzrwyTzT
	 ilvOS9Iz55pYWfTzbCa9CMq3l1hE7y51/LvDpgGGh+nPiZKKevXqLgGhWwO7I4e1/1
	 JIm3moezVZFf+Vexrpz/5V7ueppOuXm/5BfQNcxPjtk/OZ+T3Arba0WKYUbK5IDbnh
	 M4H3vIxhWAUdhxISc7ovYd2wnSfXazvNoluKgeHliaD15koq+9VvVGbVEhxAzcQy8f
	 b/650v3DU9+tg==
Date: Thu, 26 Jun 2025 12:34:28 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Message-ID: <aF0wRFKOkejfvuYT@finisterre.sirena.org.uk>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
 <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
 <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
 <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
 <884e86be-112b-44dd-a827-30355a5fdba6@linaro.org>
 <82824032-26d4-42a6-8a92-3e4a410741c5@app.fastmail.com>
 <faf23c39-af14-40ae-ad22-849aea87a4bd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ToakUxsci4O8JHpH"
Content-Disposition: inline
In-Reply-To: <faf23c39-af14-40ae-ad22-849aea87a4bd@linaro.org>
X-Cookie: Do not cut switchbacks.


--ToakUxsci4O8JHpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2025 at 11:04:50AM +0100, James Clark wrote:
> On 25/06/2025 11:54 am, Arnd Bergmann wrote:

> > In theory you may also want to turn off DMA mode for testing,
> > which is supported by at least the DW_DMA driver.

> > I see that SPI_TEGRA114 has a dependency on TEGRA20_APB_DMA,
> > which is yet another variation. This is clearly done for
> > usability purposes since that SPI driver only ever works with
> > the specific DMA driver in practice, but it seems worse
> > conceptually.

> I can add it, I'm just questioning the usefulness of adding a new config
> option that's unlikely to be used in reality. It only achieves the same
> thing as doing #if CONFIG_DMA_ENGINE in one place in the code.

> Ultimately we're just trying to fix some randconfig error, if we start
> adding new knobs for people to turn just do that, there's a risk they won't
> get used and we'll make configuring more complicated for people.

Please just keep things simple, as you say nobody is likely to be
actually trying to run such a configuration practically.

--ToakUxsci4O8JHpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhdMEIACgkQJNaLcl1U
h9D1uwf/W8rTmqkdTiKU7xj3NMtSpLL8sDI/4bHSRpuB6QSHXQDDRXuCYViMgF+U
kVQwp4yY74+/yow0Vu1M/CvdDxHfQDMo3Lh9/nSm+NQFGWLUxcgfV3I9IkZPmAS7
UOcbrJx7avU0i9o3To3WAhZHhej768yo0886n36qymiZwJdB2q4dIvx0tLw/Jy2a
oqD9w6yp5c623561vSUWNida2FbAIp8vhNac7RiylL3mWtxcZE3BXN2Vrlz8D33+
OIjxf129P5Up4H/lpD/mrhj7MS30zIjN1LjPKA3PcUJeWLTB8KEwTLGlEFPmdwAH
dCoZNv9w8YgG58EXqf/LFoqsd1nLOQ==
=MUyY
-----END PGP SIGNATURE-----

--ToakUxsci4O8JHpH--

