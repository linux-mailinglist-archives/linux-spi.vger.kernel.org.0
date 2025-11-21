Return-Path: <linux-spi+bounces-11461-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8BC7ACEE
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 17:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D9F3A143B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9882FF649;
	Fri, 21 Nov 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUcf/m3z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21F7260B;
	Fri, 21 Nov 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742045; cv=none; b=m3Ozd6cFpgXWD3uhlbz7GfUl7Dka4nsuRyjhKlQCpkKzADHOwSoPx8YbQInz6jJ1NmxyfV8PCUyzmixSMfnf+v9pzG4yuuKp7pRiqNjR9LH1xWY75l3Ihz+ig+y0ZNgQCDzgTCGWXaCWknCYi/kBcOxSPX2pvsWgR1vrQepjqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742045; c=relaxed/simple;
	bh=bPvbITpgxfkzcIC5GsYQKwKsf7bury28D6Ssr8icWf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnES/Vyj6BovlVQJlBdBZlgyiBtNmp8aVhCXCl7oJsbPrMCa9xH0IHuPyu6OUKvZ1vN3V03azKGODCVqk8Kb8UnUWTzsEdnE+6Q3Yk+kyu32Je6pyaZt/orGvL5X+b68QEVs9a40nrNg2aMlf4yxSzwIJP7cX0lRVO+KlWgAOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUcf/m3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50005C4CEF1;
	Fri, 21 Nov 2025 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742044;
	bh=bPvbITpgxfkzcIC5GsYQKwKsf7bury28D6Ssr8icWf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUcf/m3zSdSKse1sx4uITR03GHCzlpqOX9FjXxoLoT014VojDFp9WQKhhDGAfUFlc
	 hLe+8m7JQ0ATr1JvH3R4cLQCr5mBk7f+jtRinMAhgzJwM9LwWD6YJhg2XAfXpLFlm9
	 zT7hgYIj5fBBTxIbd+c4fdFnPUAaleTfprbnASahlqSLxpOVbS2SwULOpie3X8ejvy
	 +p8ul3ErKoZua8N1jQFQrK+JrY5Xm7MCYqzyOpD67c7HlIUTLcl5QKIKMR/BXIpuV3
	 EevUNCw3GjMKvD7NjM3/LsC0DT/2JqjtqoqzOrQN0V4J04i9M060WND1IVv4F3X1ph
	 BJGjf2PI7m2Dw==
Date: Fri, 21 Nov 2025 16:20:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] spi: Fix potential uninitialized variable in probe()
Message-ID: <20251121-apostle-stark-7af8aebfe9c1@spud>
References: <aSBqhdjiywXq2Aso@stanley.mountain>
 <cd3dc38e-72f6-4e83-a67f-266523e686f1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hENh9cIf10+g9oH0"
Content-Disposition: inline
In-Reply-To: <cd3dc38e-72f6-4e83-a67f-266523e686f1@sirena.org.uk>


--hENh9cIf10+g9oH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 02:18:49PM +0000, Mark Brown wrote:
> On Fri, Nov 21, 2025 at 04:35:01PM +0300, Dan Carpenter wrote:
> > If the device tree is messed up, then potentially the "protocol" string
> > could potentially be uninitialized.  Add a check to prevent that.
> >=20
> > Fixes: 059f545832be ("spi: add support for microchip "soft" spi control=
ler")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/spi/spi-microchip-core-spi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-mic=
rochip-core-spi.c
> > index b8738190cdcb..e65036cc62f3 100644
> > --- a/drivers/spi/spi-microchip-core-spi.c
> > +++ b/drivers/spi/spi-microchip-core-spi.c
> > @@ -320,6 +320,8 @@ static int mchp_corespi_probe(struct platform_devic=
e *pdev)
> >  	 */
> >  	ret =3D of_property_read_string(pdev->dev.of_node, "microchip,protoco=
l-configuration",
> >  				      &protocol);
> > +	if (ret)
> > +		return ret;
> >  	if (strcmp(protocol, "motorola") !=3D 0)
> >  		return dev_err_probe(&pdev->dev, -EINVAL,
> >  				     "CoreSPI: protocol '%s' not supported by this driver\n",
>=20
> This should probably also complain about not being able to get the
> property, otherwise nobody is going to be able to figure out what's
> wrong if we actually hit the error case.

The one thing to be careful of is that the property has a default, so
EINVAL needs to be treated differently, so the decision tree is
something like:
if (ret =3D=3D _EINVAL)
	<do nothing>
else if (ret)
	abort complaining about malformed
else if (!motorola)
	abort complaining about unsupported mode
else
	<do nothing>

obviously that can just become two clauses, but you get the idea.




--hENh9cIf10+g9oH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSCRSQAKCRB4tDGHoIJi
0hUDAQCy6DCA2ZtjlIe8Je9fG1esPeTgP2b20jYJUoOZ4kRVjwD/ZKcbjPa6tIg4
VAryRCasKFzt2Ah9eS98kFwOq1Kvkwg=
=gGc7
-----END PGP SIGNATURE-----

--hENh9cIf10+g9oH0--

