Return-Path: <linux-spi+bounces-11454-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0305C7A1D1
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id F050A2E036
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A106346FB8;
	Fri, 21 Nov 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EagljLLZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC9346E72;
	Fri, 21 Nov 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734734; cv=none; b=jbRbGy42Tl4CFfdtm8xX031PktOxILHGepdXQLi8XW32qKar0+02unbhLw0ArLbQvos81MK7vEoioWJrlGyr5yh7VDYv9SEJNvvP94+fA8wcQJ8XUDDvnLcIEc0bl09NL68jvX3+DJhoESFmjVaIILQbtdkNIk+18UtznhVXYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734734; c=relaxed/simple;
	bh=NsprtF+HIxjxhCRioUHdnInNCJikmnxU18uwM7I+1kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJaEazS5DwlC/IKuxqnsEl37vGlt0t6tUaEeQb8BLkvDRBEHGLT4/p2FpBWlMVfoTiTXSEwnBQ8ElCAv/gkhqzTBixOqSEb8U4OrtpHS2bhf/Jhqen37P5f1rCT3k5e7qcw2I9t/sd53yTnthta7egHGqHUovRJ898Enn8Ti8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EagljLLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91572C4CEFB;
	Fri, 21 Nov 2025 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763734733;
	bh=NsprtF+HIxjxhCRioUHdnInNCJikmnxU18uwM7I+1kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EagljLLZNrtDsGontDqDb8T45zIR9BkND/LHICMJq1ONW04Dq3EUaqqkHbu9Um5b6
	 +ow/TgXUOHRA1l3M2GxYVLF9ocD3szF2gWTofv1Bi1nVBRRxi6HQPGOGmEBXbr72cS
	 14ZHuyaBpoWiGUux+If4tIM9npcAR0ZkRENrE6DM1kM9Gd+ZTn79sqAgQuIxjYMaiI
	 keOQzVnGkNBFJhdhIzlC4nTH+cNLSQ4S2A/HBMCyrPWAIqA6S8myAWE+JfWa2LrEDg
	 8OU1mQFQOUxvJ+B1Zrz9ZUMXF7pPAJHREpnSBsGTvtR2iuz1qN9TAzM88TYzgA81Hg
	 7NRgBtYcnJpsw==
Date: Fri, 21 Nov 2025 14:18:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] spi: Fix potential uninitialized variable in probe()
Message-ID: <cd3dc38e-72f6-4e83-a67f-266523e686f1@sirena.org.uk>
References: <aSBqhdjiywXq2Aso@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnQOdFs1tKeyDk7h"
Content-Disposition: inline
In-Reply-To: <aSBqhdjiywXq2Aso@stanley.mountain>
X-Cookie: revolutionary, adj.:


--jnQOdFs1tKeyDk7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 04:35:01PM +0300, Dan Carpenter wrote:
> If the device tree is messed up, then potentially the "protocol" string
> could potentially be uninitialized.  Add a check to prevent that.
>=20
> Fixes: 059f545832be ("spi: add support for microchip "soft" spi controlle=
r")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/spi/spi-microchip-core-spi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-micro=
chip-core-spi.c
> index b8738190cdcb..e65036cc62f3 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -320,6 +320,8 @@ static int mchp_corespi_probe(struct platform_device =
*pdev)
>  	 */
>  	ret =3D of_property_read_string(pdev->dev.of_node, "microchip,protocol-=
configuration",
>  				      &protocol);
> +	if (ret)
> +		return ret;
>  	if (strcmp(protocol, "motorola") !=3D 0)
>  		return dev_err_probe(&pdev->dev, -EINVAL,
>  				     "CoreSPI: protocol '%s' not supported by this driver\n",

This should probably also complain about not being able to get the
property, otherwise nobody is going to be able to figure out what's
wrong if we actually hit the error case.

--jnQOdFs1tKeyDk7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkgdMkACgkQJNaLcl1U
h9CPOwf/YH0v9sLikttYK7LcYfsSfi4JzoE78aL6gexf4xUfth8PMXTnDccuX6Lw
G1tSK5LmQD/Z3Lkj7mHVaCULBBAL2HYZDe6fo2Vn3AlCnXdoRXmGYourEO5udgV+
lY5A40R4P2m/4pU0ddUK1Kd+U0uwSDhdQ23uFJpOvgO8lZQjKSMOOWnQUFYCxXoJ
LZe0GLRSbCHazaouPW/k1tebrwRL5M7FtJiBp5t/fkdNMtNuFqtQctjL1wWkLERH
ODl34uRHIwwhEPE+d54sKVhp6r07rAmay/AMQrwuxDrxkd2sPWezLZ0lp94i+zKu
Sk47HAhD8lIADZxJunw6wsqemlV3qw==
=0+bs
-----END PGP SIGNATURE-----

--jnQOdFs1tKeyDk7h--

