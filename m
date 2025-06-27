Return-Path: <linux-spi+bounces-8837-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1EAEC232
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C891BC0C3B
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0E628A406;
	Fri, 27 Jun 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZJOBiR8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60693289E37;
	Fri, 27 Jun 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751060495; cv=none; b=j6rWMgEU99JsmIqxVZ0dmVbkcbCliNdp7j4LojruImfacvJjFVQwnGiRTz+Z7j4nz26vJu6ao0tWHB85vSVDinkEvPCaB5TjpB51DCREZ28SPAH/gZMeN7ngFim1lQLySrnvu7KVg5AmvTp9R6UZHgtxr9WKVIfWR8djsJF/kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751060495; c=relaxed/simple;
	bh=5Ljo3CcoOPKf5/DedTG4W2a6UHG8S1ZDpc+SXGnp4DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDPOmQKE3PpmeWt/9FAi1QcT+hkEyl86o5MUu+TelpejTJ73PvOkkE9QjkNSg088yQSwOzwEPwMeePmjCc+3VLk5M4Ym8+ceF/GJWlhwimLxLrnj25UiKxvH6juN4YoXrJFUeBSp/jbUfmqY/gLSqaWOndBz6aXSqNc+Uqo6atQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZJOBiR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1488C4CEE3;
	Fri, 27 Jun 2025 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751060494;
	bh=5Ljo3CcoOPKf5/DedTG4W2a6UHG8S1ZDpc+SXGnp4DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZJOBiR8DKoBr7HUN+DYQdov6AZSy1ItCrxaJkFHt7+5EiNrNPXDY2Lfp0hqGaq8y
	 2H9Wgk29NSEEd3JQe6ZjTauNTe2PCD6cPjyMSJgNz/zvyzMhkyso7PTEMlsgcTP4Ro
	 IzKdEiFLyHP5jkGRzE7vZoIbvN2dbR4BjdGRV6r8NJS5we6hqbu0C5bH3BMtSiUpxs
	 isH/yjg2l8vx9hLgNiaujAOVEG+J4/DxmgZJbmI0GMYLsA7H/TAkoeISTL1sSVjGrb
	 zvzstNFwRpgWyVivAhWHeMRLfFdb7/21Mjm5NpCes+X3z2DUqNZuw9/qjBht1SvhsH
	 vZZlYokiABIHQ==
Date: Fri, 27 Jun 2025 22:41:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: James Clark <james.clark@linaro.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <22d69113-fec0-4405-872d-af76bd038c09@sirena.org.uk>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-6-178dba20c120@linaro.org>
 <aF73e/ggeycsYiaD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1nt4mhY+dwym5Hr9"
Content-Disposition: inline
In-Reply-To: <aF73e/ggeycsYiaD@lizhi-Precision-Tower-5810>
X-Cookie: Avoid contact with eyes.


--1nt4mhY+dwym5Hr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 03:56:43PM -0400, Frank Li wrote:
> On Fri, Jun 27, 2025 at 11:21:42AM +0100, James Clark wrote:

> > In target mode, the host sending more data than can be consumed would be
> > a common problem for any message exceeding the FIFO or DMA buffer size.
> > Cancel the whole message as soon as this condition is hit as the message
> > will be corrupted.

> > Only do this for target mode in a DMA transfer, it's not likely these
> > flags will be set in host mode

> "not likely", I think SPI controller should stop CLK if FIFO empty and fu=
ll.
> It should be "never" happen.

> Only check FIFO error flags at target mode because it never happen at hos=
t mode.

> You can remove below whole paragram.

I agree it *should* never happen in host mode but it can be good
practice to look in case something gets messed up.  That said extra
device accesses in the hot path are probably going to be noticable so
likely not worth it, but in the dspi_poll() case:

> @@ -1067,6 +1080,9 @@ static void dspi_poll(struct fsl_dspi *dspi)
>                         regmap_read(dspi->regmap, SPI_SR, &spi_sr);
>                         regmap_write(dspi->regmap, SPI_SR, spi_sr);
>=20
> +                       dspi->cur_msg->status =3D dspi_fifo_error(dspi, s=
pi_sr);
> +                       if (dspi->cur_msg->status)
> +                               return;

we're reading the register anyway so the overhead is much lower.

--1nt4mhY+dwym5Hr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhfEAkACgkQJNaLcl1U
h9Bfiwf9Fa3LD6n+/brGDGbQJc6S5NZo/Iv8vZRtcpTQ4iXdTte85tTkmykGA+I0
kNkP6wImm2WAZx1qKa/QKK0zYBP8e8Be/N2/6mF+dB+qlzrD0g/W0GWIUSnyhAzt
xLs+VKHajdZgy16CyxV+KZAz9K4W7VZCd5b3/jIBJoVkyBEMAUkKgoZpZTff7WLd
3ObZOvGQxLU70o/MPz5v65neCmVIuu20V9A/7BZReFY1ZpgIycndnyzM+E80iVKF
uIJvbjuV6lmMjBO6GpyjMm1U6D+ebGte8JlE6mY2s1o1lJ5n35naBOaIURTrzOWS
yBcsW/v17RQ1UMqYRUPd6q++ciWczg==
=1ixx
-----END PGP SIGNATURE-----

--1nt4mhY+dwym5Hr9--

