Return-Path: <linux-spi+bounces-11831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D23CAFA3A
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E07293008555
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6D1EE7C6;
	Tue,  9 Dec 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMvNMIBE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56518DB35;
	Tue,  9 Dec 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765276236; cv=none; b=FKMzcE2Tm1paYQFwvfR+/r40TEfyu0Zmo0WDxDDxdZhekrPUB1mqWiCz4ftrZkdn678AFMS+qaXwo1WVeDV7A1vEEvY75eeY/FfdCc8qO2PD4rUo4ZNFA0ire8SiCdKcdC2dRtZIikU4V2kjXul26XYYaCcjUGFavNNAlO+boeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765276236; c=relaxed/simple;
	bh=2O1lO8RaQHH8AUqxcU0VC7ms5Uf8CBesGTSI+sXGE/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVxAvuEBrtTenMy3kdbUgr0Sd/5TR/9luu9wqa03HD+0eb+vh5phFxOQtfSY/CV61mo0uyzGJw3ji9X6Lxg6s0DnWEQJRz4s53qjFTlNfznMkyBppg8N5WAvqZXxoGaaHrXUtpQj1BCHU5wiv4RRHCX1PX4RYpBPH/M8xLDBxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMvNMIBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038DEC4CEF5;
	Tue,  9 Dec 2025 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765276236;
	bh=2O1lO8RaQHH8AUqxcU0VC7ms5Uf8CBesGTSI+sXGE/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMvNMIBECdF9OKo2lM7q3VSmSI9raekugGCr4IMGKuqWCLSv692HwTHbZzMve1gnM
	 csQbYxINwoWQRGWZNdjAdNwOmbjdRvdKecpEPb50/PL5HOLP7U7zuz1G6hV1NQbz7Z
	 PuBvIBAABl6Ltebraqaw0f1GiPZ9OSTXmGg1dA4SuB/6JR1BYj+K6znpOYowoHEDud
	 ZNQNXkIQf/BkH62yEXuyoPfIwfmWZOZV3Q8sPnot+9FItojqe+GefCqgTwf95j1ogB
	 jq++9Pdxf2bcU5bnPx+thyCL0cOgTa8yUdvvSeH9v4norVjWaoskG+ebE+HnwI19Cf
	 FfKG7uUmIaxrg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 830DC1ACB951; Tue, 09 Dec 2025 10:30:29 +0000 (GMT)
Date: Tue, 9 Dec 2025 19:30:29 +0900
From: Mark Brown <broonie@kernel.org>
To: "Dutta, Anurag" <a-dutta@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Gujulan Elango, Hari Prasath" <gehariprasath@ti.com>,
	"Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <aTf6RRAveRdVnWQZ@sirena.co.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
 <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
 <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
 <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EfM4AL38KKkP89t4"
Content-Disposition: inline
In-Reply-To: <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com>
X-Cookie: It's clever, but is it art?


--EfM4AL38KKkP89t4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2025 at 03:22:43PM +0530, Dutta, Anurag wrote:
> On 09-12-2025 11:13, Dutta, Anurag wrote:

> Another solution :

> diff --git a/drivers/spi/spi-cadence-quadspi.c
> b/drivers/spi/spi-cadence-quadspi.c
> index af6d050da1c8..4d298b945f09 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -2024,7 +2024,11 @@ static int cqspi_probe(struct platform_device *pde=
v)
> =A0probe_reset_failed:
> =A0 =A0 =A0 =A0 if (cqspi->is_jh7110)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cqspi_jh7110_disable_clk(pdev, cqspi);
> -=A0 =A0 =A0 =A0clk_disable_unprepare(cqspi->clk);
> +
> +=A0 =A0 =A0 =A0if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)=
)) {
> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pm_runtime_get_sync(&pdev->dev) >=3D =
0)
> +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable_unprepare(cqs=
pi->clk);
> +=A0 =A0 =A0 =A0}

> pm_runtime_get_sync() will increment the usage count thereby preventing f=
rom
> runtime_suspend()
> getting invoked, thereby preventing double clock_disable()
>=20
> This will work for !CONFIG_PM as well because pm_runtime_get_sync() will
> return 1 then.
> and the runtime_suspend() is never going to be invoked.

I think we want this, possibly using pm_runtime_force_resume() instead
(not 100% sure on that one, glancing at the documentation there might be
issues though it feels like the intent of what we're doing here).  Can
you send a patch please?

--EfM4AL38KKkP89t4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk3+kQACgkQJNaLcl1U
h9ChoAf+Nu0YvtmDE9dT6b6dWMRLQqugy3gmp1TtstBUDAaHlkQI/2uV7emxNM0L
SYehkH7knybaFnJuE+qxy17H2t2frMZnDJQN1qU1ZocspiAwSNb6nqqfuI91KAAO
Q4gpvfj0QIAalxSMcgDBAbEmHG5OOTxR4FQKtNArLOKGrf18o9nyRBboDzIt9I5k
VpRD7JOrRkZnq1TFj64HcCFSLSJo2+h7Aiae0MVxreqgKZUm7QF1J6377uGzEuZI
sMubRC8u3G4vuUatGujD9wUg1zEtozr3E+mbn34fBdgE7DWoQOeW5KWet0e4g3JA
Ah4juzdymqC8Lkl0pYaSXUsVSbKJtg==
=ggd1
-----END PGP SIGNATURE-----

--EfM4AL38KKkP89t4--

