Return-Path: <linux-spi+bounces-8660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B850FADF0BE
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95853A6763
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7C2EE96F;
	Wed, 18 Jun 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDmqv8OH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D12EE962;
	Wed, 18 Jun 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259332; cv=none; b=hOEATeVpVVkem5Czt0zpPsdS7M6WZ5g1udjItObuWOHxBa4UrK7tM3P2Vk/hCAeVcFBBspbhZsxW2BeEeqh/6q5AzvjX+APtXmtllpdKKRHXuAoBclaprOHazrhOICrTHVzp/B+SN/+vBgpMX03X6O/ZQgIb3sM/84AaOIsVMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259332; c=relaxed/simple;
	bh=X7QMCBMIwOTwFm94q45BeJ4PoCWomPFcgOijpd3TPE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCTc2T2rWOTFOPGdS9rK+uEN+3baBG+XPFXEeNoUEsT6uFqv14a+7iBFaAEHjkw4Uan1Afrt726EDTTwCJtRPxPI707eGDyaqi7XkMCc3t6vWnmdtlJRLEXaSXsHrebP5brCJZ5ZZX4/XHrh7RCPMzlYB6u1n5jmXoN6kW/mDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDmqv8OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF21BC4CEE7;
	Wed, 18 Jun 2025 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750259331;
	bh=X7QMCBMIwOTwFm94q45BeJ4PoCWomPFcgOijpd3TPE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDmqv8OHYq+Gwia71auzXNmq1OAzja/cYi0tkehA6GbSdTRqpbTX6HSo5cVYJwlnH
	 aSqLv1UKlIHTM3zZVuMzrp/JoXR4DOgft2e/sMB18aie0Z1PZMr52ZAgOqUb+7p+mJ
	 XFJrfeDI9O5UiZp5er1lXMCScU0PM+c7YFKL/2HQepK9MDsvzzc2A7bhCefGAUy3ZV
	 0XJ/mUb7ZigYYjvdfu1lf56C3IsW9vtOJeBiGB5p42Cm/B1vFTQvGiT5hsqIpISvKL
	 rWVq86VoQgrXsI4DH0IhzGQse7Fsd3Ha9stce54Z1tjdnu7n1pk7hRNK57Y7zLeu5R
	 1IPSoEkxzPKxQ==
Date: Wed, 18 Jun 2025 16:08:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/16] spi: falcon: mark falcon_sflash_xfer() as static
Message-ID: <f81ec27e-8c3a-4998-a31c-dcb4453bbe0c@sirena.org.uk>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
 <OSBPR01MB16705BE87E549B6210CD6BCABC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tGm6mU2I4HqfE/Y5"
Content-Disposition: inline
In-Reply-To: <OSBPR01MB16705BE87E549B6210CD6BCABC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Cookie: This bag is recyclable.


--tGm6mU2I4HqfE/Y5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:53:29PM +0800, Shiji Yang wrote:
> Fix the following missing-prototypes build warning:
>=20
> drivers/spi/spi-falcon.c:97:5: error: no previous prototype for 'falcon_s=
flash_xfer' [-Werror=3Dmissing-prototypes]
>    97 | int falcon_sflash_xfer(struct spi_device *spi, struct spi_transfe=
r *t,
>       |     ^~~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

I believe there's no actual dependency on the rest of the series?  In
general it is better not to mix patches for different subsystems in a
single series unless there's some interaction between them, it just
means people get more mail and makes it a bit less clear how things
should be applied.

--tGm6mU2I4HqfE/Y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhS1n4ACgkQJNaLcl1U
h9CUGgf/VMiIz8Es9j48Ut1l7gBNpiIGWt379JGiZA4QIu7uAeyzPthqI8mCaKe/
dyShCUmCfpYIPO4QrTR7z/bOAjFfscEHJMpEZGyxpjvkMpTQdr5FWWoD+hPOpNZa
ogvrN/6wNZ8djo8fSfi3LWJ+XDvYuhq54gz5xtoKP19xUpxlWylALYZFXQWQKOdG
NociOy6DfKysiO7KFvDSjARptxZJsjGAoz1VqBqQKJON7sClpLbXNTTgZ1XtY3MM
VhVV0tGgOdMokW0D4fg+++kh+q4/i26KNVw5NYcc97ML3SlGgnflbAWylvPOuZnv
l4bnvcnOVFBDtIvGacfW5LtzqM1IRQ==
=HjUo
-----END PGP SIGNATURE-----

--tGm6mU2I4HqfE/Y5--

