Return-Path: <linux-spi+bounces-7878-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95AAA89BD
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 00:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697D47A6ABE
	for <lists+linux-spi@lfdr.de>; Sun,  4 May 2025 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8A1ACED9;
	Sun,  4 May 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVxDgeiG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D617BD9;
	Sun,  4 May 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746398251; cv=none; b=N6NjU5DLIepMZTEnTG7F/mtaKSNeGUDNUjtGbbLCvfPJSxWT6FVsY5ThDNKkXkSX2LsSGiGkiiIZTdNDcHKJVmuvwzJ9OvyUjgV5ZSscwMZscowypu+juyHFdpHaEypcqI71MlNxUv6FjZX42olAgWiQ7wG9KuLHd9WECdeITms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746398251; c=relaxed/simple;
	bh=G1SlpzCwnmgV4IcukddE7QYZRJnQcXDYrxSysqSlBoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym6gx4gZtY7+CKtaOPsCYdSDtLJzaPRkM9ccZMq6CvKqHiHvXnAO6Si6P2AMqQutaW2c+3jbtPG+Ymge5OEUU/kRoFHD3UL5Br7+JnubapVMv6l7Zi9P8/YHmp2S/KX5Y4tCfl2PKQLRSgRb1iOTPOOO2U9YVMivFv+NS2QLng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVxDgeiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB09C4CEE7;
	Sun,  4 May 2025 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746398250;
	bh=G1SlpzCwnmgV4IcukddE7QYZRJnQcXDYrxSysqSlBoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVxDgeiGj+3HNKmlrqz9Ca7e/FIYSBNGoddTZxCNe3KGiCoG9vX9x0KMlZdQ/sOO4
	 dz9eTcDJzKz3RAW5l/JF9ZrHRIcaswjqIS5cv3vboUPBoyBg0d1XCy8qgo31IlJw2c
	 ozKUu6ldYcpsQ7dGPp/I1CcHvwrPKeSMH2rb5O3pRWaHS0jsMa0oyaUllnarIcwvBf
	 SOwaCPMbajlHmaei4KeCatzM/kR7vCntm5OkgBZEvKC2ua9xQbkZYGINTyWmvtrXPA
	 DO9pCKbAKpNfEYsh8fCQyWC9iDZLZrs/ixafEVpVJq4OPuBhzYa/WMTjR4P0ND0hPT
	 KVlg2U6VsZ2eg==
Date: Mon, 5 May 2025 07:37:26 +0900
From: Mark Brown <broonie@kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: ldewangan@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [regression] jetson-tk1: spi do not probe anymore
Message-ID: <aBfsJpId0Jrcz228@finisterre.sirena.org.uk>
References: <aBdOMUhuUqbZm9w1@Red>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P27ERyOYMeKAF9Ow"
Content-Disposition: inline
In-Reply-To: <aBdOMUhuUqbZm9w1@Red>
X-Cookie: Well begun is half done.


--P27ERyOYMeKAF9Ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2025 at 01:23:29PM +0200, Corentin Labbe wrote:

> On my jetson-tk1, SPI do not probe anymore:
> [    1.330681] spi spi1.0: Invalid delay unit 2, should be SPI_DELAY_UNIT=
_SCK
> [    1.335185] spi-tegra114 7000da00.spi: can't setup spi1.0, status -22
> [    1.341643] spi_master spi1: spi_device register error /spi@7000da00/f=
lash@0
> [    1.348637] spi_master spi1: Failed to create SPI device for /spi@7000=
da00/flash@0
> I tested 6.14.7
> The SPI probed perfectly in 4.17.14

That's a pretty big jump in versions...

> I tried to debug a bit, and the driver requires units to be SPI_DELAY_UNI=
T_SCK, but it seems there is no way to set it.
> Removing the "return -EINVAL" in tegra_spi_set_hw_cs_timing() lead to a s=
uccessfull probe and the flash device appear.
> But I agree, it is not a correct fix:)
>=20
> Since only the test made it fail, I think the driver is bad since commit =
810593668468 ("spi: tegra114: change format for `spi_set_cs_timing()` funct=
ion")

Adding Alexandru who wrote that commit.  Assuming the delays came from
DT (I'm not actually finding them, I didn't look too hard though) and
are therefore in units of wall clock time I think we need to add a
conversion helper for the units which the driver can use to convert to
whatever units it actually wants to use, we do need to accept units of
wall clock time given the generic binding there.  That gets a bit
annoying if the bus speed changes, though that's quite infrequent in
practice.

--P27ERyOYMeKAF9Ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgX7CAACgkQJNaLcl1U
h9DnJwf+P8CFXkQ4BTKfGUCnkS6AW4SJFtkq1DIrRnzzg6JdNTrcbApRbC9cF8ms
OpPqbzVwYImrz8wIitxScfrgHf6UMGhwT2by7B2hZ/HvxUmUZBCo+0hcsOzE5uOs
ahI2/SdLvylujDWSzBofLKdTPdSQlKuj0wbbQ95mhqBAAs5VqTdv8QXELmPCV4L4
8isyBjE7q0fyDJmWbYlyzDEnsJrwtNDrId4qUaj4OJCmekdmgRTnpXDUze6w4g6p
olLSD1NRBfvA6GEIgVmwE0MvaCnjxtLtDflitbOR4bVEoOJ+FPB4vhWk13NRt2e7
0+MKrWi9zCQuNp1Qz1mbAkKCDDbpOQ==
=yLfy
-----END PGP SIGNATURE-----

--P27ERyOYMeKAF9Ow--

