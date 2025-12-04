Return-Path: <linux-spi+bounces-11768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A4CA4B22
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 18:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F29230E92FB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680A26C384;
	Thu,  4 Dec 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe9yvKUX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15221507F;
	Thu,  4 Dec 2025 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867956; cv=none; b=GnD2gwoHa0Km+RXLT52D4OnoOAUp9eSIxWZg8VYQJ0mnP/eymPL44h4Q9YZ+PBCjEy/rsMwPkC17wwd3wGMUDkUnZ6uc8RLaIP0LdePVEoRYz7n11UUq/GV7OTxoEs55Q4IUqkGDgjXNbqJ/gS0FipfBrRB9+Mf2h56ytxpYbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867956; c=relaxed/simple;
	bh=TvORNphsC1c5Aq/BY7GRcMwtQ4k2sYc2o4kxGWaoGBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjz0HsGB4LjMh3mX5J5V0lP1gS7NMCZpJw8jwA6tDsgUIsxLSFsqGwTsaN7hpZdArpmtlY8TtHS0MfWzkC8z7Z6UN9AttwegCHZ0hkcO+jSGMJJOX56E2/Er09b7agYHMppmU8JYA5KHr057UgIx0sE0N5hPRGdj7ijmCGG/q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe9yvKUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59F4C4CEFB;
	Thu,  4 Dec 2025 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764867956;
	bh=TvORNphsC1c5Aq/BY7GRcMwtQ4k2sYc2o4kxGWaoGBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe9yvKUX9SPk3oOApKS4+kHAxZABRHKaqgKDpXYUtJ1BclFTZlbKswI02UBGExoYC
	 iSCOINQPbw3T2tu2P7ekQCQDokl4M5zIP48KwjDLI6BVlfRBSF2DAJ7sttOBs+YUWc
	 5OYBrLFz5OMFTj4D/AJhvliVJPb2WjFqCK+1omdETDmLp3I/Cjf6hNP8sh1F1SvgBD
	 LIVZhJ3W9QKsIImTauRz0J2cjvI8cK86EA7cbnrMqm6rqJl2iIzTEHqVboRdwXXD5S
	 FLtVVDBM5Y8PFxK8UUVXhcU+7v62CMugAND7S6f+RrePTRzk3LTjAF0b16o2jJhQ04
	 RBdwJur9jEkWg==
Date: Thu, 4 Dec 2025 17:05:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Anurag Dutta <a-dutta@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f98h2X3enVdTZ7fq"
Content-Disposition: inline
In-Reply-To: <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
X-Cookie: volcano, n.:


--f98h2X3enVdTZ7fq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 03:11:26PM +0000, Mark Brown wrote:
> On Thu, Dec 04, 2025 at 08:05:30AM -0600, Nishanth Menon wrote:

> > The clock is already turned off by the runtime-PM suspend callback, so =
an
> > extra clk_disable*_unprepare() is only correct when runtime-PM support =
is
> > not in use.

> Right, I'm pretty sure that's where the extra disable is coming from.
> The pm_runtime_set_active() further up the function is looking rather
> suspect here.

qspi_setup_flash() is just reading DT data, it's not actually
interacting with the hardware at all, so I think we can sidestep the
immediate issue by just moving it to where we parse the DT for the
controller.  It's not fixing the actual issue with the missing/extra
clock reference but it does get us back to where we were:

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index af6d050da1c8..bdbeef05cd72 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1845,6 +1845,12 @@ static int cqspi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
=20
+	ret =3D cqspi_setup_flash(cqspi);
+	if (ret) {
+		dev_err(dev, "failed to setup flash parameters %d\n", ret);
+		return ret;
+	}
+
 	/* Obtain QSPI clock. */
 	cqspi->clk =3D devm_clk_get(dev, NULL);
 	if (IS_ERR(cqspi->clk)) {
@@ -1988,12 +1994,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_get_noresume(dev);
 	}
=20
-	ret =3D cqspi_setup_flash(cqspi);
-	if (ret) {
-		dev_err(dev, "failed to setup flash parameters %d\n", ret);
-		goto probe_setup_failed;
-	}
-
 	host->num_chipselect =3D cqspi->num_chipselect;
=20
 	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))

I'll send this out later assuming nothing blows up in my CI and nobody
else notices an issue.

--f98h2X3enVdTZ7fq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxv28ACgkQJNaLcl1U
h9AXiAf9FcP/rd25aN2FCs5DOlIRfrIUKrjgm1w3OSlXtZqNRFqVUmP3NuqAyWlZ
GUiGAp0LRxCYAANvSVroZhb0uKO/76P97/F/nihHaYtt8NNku259MybNxl4ieMZA
DanHmuCmEkE/QKk/y9rNY6ckWKNKjpugwwgrZRptoKW9sUegT3CIQchg8k18LcIF
RCwqlHPf/1m32q3o0j9Qax8PWCEw8MW7JHVZ7kizMlkysQFkPiMsN36HIQ+/mVYQ
a+eqHlMjQy62F51JPQ4f09tmLmwdICAGKbGSic9tDejm/2/KPbpxB1tVjrOj6AYM
RjNYtQDaHkq57ORHYC5wOi1B5veBAw==
=eplb
-----END PGP SIGNATURE-----

--f98h2X3enVdTZ7fq--

