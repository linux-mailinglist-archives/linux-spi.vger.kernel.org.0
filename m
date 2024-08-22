Return-Path: <linux-spi+bounces-4267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38D295B926
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C5EB21ED2
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E861CC173;
	Thu, 22 Aug 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM6ilSH4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1241CB329;
	Thu, 22 Aug 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338691; cv=none; b=UI/e/ExhPZMb9VY7zElUADTJG0VvH3xGeugcl9LDARWdmiLizTN3xRJgkwtVtDEY79tHVqVC5+UY/lUT7gAtBhvmh4ioBsZ1geJvlqR2sULF+ZpNoliXfeaiDvR+yEeFAJYHL54UQgErr8SWjBs4Q3TM5FAVozNK8yMKLjbSaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338691; c=relaxed/simple;
	bh=Bj+Yrsv0zLoxJiQB3tANzn1xKu5HVSY1AdAXVzJxuO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1nYQ18gJsPHRxxux9gjAasPoiewffRRfRvejdgy7g5ifOUCVaANlJ61V0pw/bkn4oFhqgVhxMhsajHQAOQy3fFQjOOnmFGd36CzTQfL200XsWYyfpgRqCvq0JIB9EeTBR6+BYzAzf+ubSganFraLX5zXTkG071CI+deRBLXpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tM6ilSH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD805C32782;
	Thu, 22 Aug 2024 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724338690;
	bh=Bj+Yrsv0zLoxJiQB3tANzn1xKu5HVSY1AdAXVzJxuO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tM6ilSH4HBJRpOK1zAJJmcsiHCcE5dbLSp11N7aT+RNDIybd0nm+lK5oOzSZhoJrb
	 LW13yqbfvG52RMcGF2Dx3XKUHldPuBmSaRbmLtbhUsGWv4KiPY2mskfWNdSB21Jke8
	 3OuJFcqtdBrg/EueNBG5SPcisUHeioOKP9QJUqcMeB+lZ3eevDHFJigOA2+GyrktVt
	 0+CqqF7iGPTLbAflCUlQJTUR6AKpy6c6C7L3VI7YmrrWBIB+vuMA63K/NaI4BudXEJ
	 TWHTDQ41zdkRNtHN6LLakNLEcWz74EuL9elqikX3pKKXSMU3P74qljf1UVyt9Nf0IF
	 pUUDNGQR6Y0bA==
Date: Thu, 22 Aug 2024 15:58:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] spi: stm32-qspi: Simpify resource lookup
Message-ID: <ZsdR-G9S5nYbQX4s@finisterre.sirena.org.uk>
References: <20240820123707.1788370-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6s/GAhPIkOk69QT9"
Content-Disposition: inline
In-Reply-To: <20240820123707.1788370-1-ruanjinjie@huawei.com>
X-Cookie: You need not be present to win.


--6s/GAhPIkOk69QT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 08:37:07PM +0800, Jinjie Ruan wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.

This breaks boot on the Avenger96 board, it causes a NULL pointer
dereference:

[    2.350480] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000 when read

=2E..

[    2.695787] Call trace:
[    2.695807]  stm32_qspi_probe from platform_probe+0x5c/0xb0
[    2.703914]  platform_probe from really_probe+0xc8/0x2c8
[    2.709284]  really_probe from __driver_probe_device+0x88/0x19c
[    2.715145]  __driver_probe_device from driver_probe_device+0x30/0x104

https://lava.sirena.org.uk/scheduler/job/650792

> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi");
> -	qspi->io_base =3D devm_ioremap_resource(dev, res);
> +	qspi->io_base =3D devm_platform_ioremap_resource_byname(pdev, "qspi");
>  	if (IS_ERR(qspi->io_base))
>  		return PTR_ERR(qspi->io_base);
> =20
>  	qspi->phys_base =3D res->start;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mm");
> -	qspi->mm_base =3D devm_ioremap_resource(dev, res);
> +	qspi->mm_base =3D devm_platform_ioremap_resource_byname(pdev, "qspi_mm"=
);
>  	if (IS_ERR(qspi->mm_base))
>  		return PTR_ERR(qspi->mm_base);

I can't identify any obvious error here, these look like a direct
subsitution - the implementation of devm_platform_ioremap_resource_byname()
looks to be the same as the replaced code and dev is set to &pdev->dev
but I'm seeing the above behaviour.

--6s/GAhPIkOk69QT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHUfcACgkQJNaLcl1U
h9CN8Af8DY4LE/KzrL+ENEN0vrqUzAsXF0kFyjft3xYuOnC0JEMBmrZ6/QtgG2JV
oWwmu82T2kkirx3dgWZn3U6ig9+wTWrdu9mPFPDKzDgl/l7TtO60iojlCNk61c82
O4Ki59eHrRFKOKffBDCREilTuj7zGUSIp8hfc2oPD8JVWQ7ENQ6nTQ0AZJwUmWuA
aEhxVuL9+I+IQ+IeG8fzc6S+AAMpaj142AsB5Rft84YRBPWFmt4wnQuaLpVC4SvW
ftXzNetwjfeTC47eS5B9Ygaslz4pxfxYSVab7VzMSgcBxKl8QBKwXmH+9lSl7yjJ
cMHHn+8fvbJP2MyGPJ33A/l6U3/HEA==
=kpgY
-----END PGP SIGNATURE-----

--6s/GAhPIkOk69QT9--

