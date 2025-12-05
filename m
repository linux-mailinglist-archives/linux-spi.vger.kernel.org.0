Return-Path: <linux-spi+bounces-11790-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6893BCA7C24
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 843DB303EF4F
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3D3346B1;
	Fri,  5 Dec 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msSxg+Sh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95316313E05;
	Fri,  5 Dec 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764941124; cv=none; b=BbQZlXByuuMj3ygX5ejFyJUFhc+WlWCNOjVTKlwn2OumzZ5rVgxjfJ8myBKJsXE34tt8iFKArAIG630QxMix0zFTLNgTMBxXRmAkLLOy9bRPBjDSyX4IB448+qfQF3EaPrguBUFU0sljlz0u5pKrTQ9i+cq0qUvDcCxN8bt8Hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764941124; c=relaxed/simple;
	bh=k15g6omoORvIkmmpzdJ/KExTMdtWwJtcGru/rtCHo8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnpfIZ2X4k7K5wISOfAcnSt3SXu7AI+DIib2UwJ/isoRn9AiFpmb1MeBL6GXSEcPK0dzXWE5pM2mHSVSFw99qa9j1r/CQkARwIjLKLAW5iIUFXGqWCMeGK6V+C+KaZbCFYTDtLhR9fSFGGsVXR3mxy7YqgYliWrE9UVhz49pBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msSxg+Sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC7BC4CEF1;
	Fri,  5 Dec 2025 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764941124;
	bh=k15g6omoORvIkmmpzdJ/KExTMdtWwJtcGru/rtCHo8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msSxg+Sh3s52tLmi84hsRhzouyREnxdBFWaTGLtrNAMpeMcrbNx5nklgWPeMOnkfL
	 SDZvERLNs/Ue+P0jAq1Kox7cW3QVkNmccOLVNa9D7+5M06xnantdKDKCQCSw3YsDWC
	 /wU52R5LO16wZ3XfT7950b/RLx/TKOM910RZSlTvxuEkCsaA3zY+/CgrJWE6Er6HFB
	 F4a6j3tf8HT4bPA69iffgQKpMTbKxOQiUKPQhm0vkbPIpvlqF+ylECgTC8e40ngoLS
	 iMkNqauYkgbj/x3XhjupofMOU7CL7bqIQtOwZnw9E0TUszRpuzDOeVS61zJgitBT/y
	 Ou4pZp4UR2bCQ==
Date: Fri, 5 Dec 2025 13:25:19 +0000
From: Mark Brown <broonie@kernel.org>
To: "Dutta, Anurag" <a-dutta@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YOtKDi9dRF82ncv4"
Content-Disposition: inline
In-Reply-To: <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
X-Cookie: My EARS are GONE!!


--YOtKDi9dRF82ncv4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2025 at 06:28:06PM +0530, Dutta, Anurag wrote:

> Hi Mark and Nishanth The below seems to work for me on j721e. Let me know
> your thoughts.

> Also, the error actually comes from :

> if (cqspi->use_direct_mode) {
> =A0 =A0 ret =3D cqspi_request_mmap_dma(cqspi);
> =A0 =A0 if (ret =3D=3D -EPROBE_DEFER)
> =A0 =A0 goto probe_setup_failed;
> }

> And not from flash_setup().

Great, thanks for confirming.  We should probably ensure that has some
logging...

> @@ -2024,7 +2024,7 @@ static int cqspi_probe(struct platform_device *pdev)
> =A0probe_reset_failed:
> =A0 =A0 =A0 =A0 if (cqspi->is_jh7110)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cqspi_jh7110_disable_clk(pdev, cqspi);
> -=A0 =A0 =A0 =A0clk_disable_unprepare(cqspi->clk);
> +=A0 =A0 =A0 =A0pm_runtime_force_suspend(dev);
> =A0probe_clk_failed:

The trouble with that is that in the !CONFIG_PM case
pm_runtime_force_suspend() is defined as:

  static inline int pm_runtime_force_suspend(struct device *dev) { return 0=
; }

so we'll leak the clock enable.  If we could just require runtime PM
this would be an awful lot easier to deal with.

--YOtKDi9dRF82ncv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmky3T4ACgkQJNaLcl1U
h9Bofwf/bl7gJf5DQqi4ZSGw8kJJsQp77hHkUOG0Qzh/6xPXGZlgAZheq0cC4n70
C/7hHjDQW0JPI11eKX8kBeDphYx2O/xkj8s2vx8jNgDCd/dgiI4/ze1dsa4fn0TP
WzWB8LbjpkX0Kl5mUw8Ncxpm/TEFqsrZhvpdhYCO9iJjwlC6KcWzvMQLwXAs6Car
OPOSWbVW9uI5FCRxg/kvTtsTnN1UGpWJ/ZRW1jbnFyPKjnTlMssALbKaAypo3Sb5
I3ZNevNaGYUjUq+Lw5nTv/AbEwksBZCA0GqBVd+RKRaXk/x0vYK9j8kuqiqCW5iQ
P/ppAqAyD+p4XI8pFRMDvXILmXOY1Q==
=y5Yg
-----END PGP SIGNATURE-----

--YOtKDi9dRF82ncv4--

