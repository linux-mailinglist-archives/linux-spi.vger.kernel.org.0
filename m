Return-Path: <linux-spi+bounces-5630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0509BCE80
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB02B220C5
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783C1D7E35;
	Tue,  5 Nov 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSc7j3I5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310651D6DA3;
	Tue,  5 Nov 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815146; cv=none; b=p0z9Yfmedr9B3lIO5xYhY3fqNxvgfyKr6uaCKNOcb05gWyBgdbCoVaWZAE6/Hu5vPxIqmeXamzG7+OjD2pYqnkxIUnhusWIpiswiuZBHGyp0xnFQtVbGSsQle8Acr39QvjQ0CFcVdP8ik5TuQCcbV9EprRmVt9Vw6W3fJyTLDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815146; c=relaxed/simple;
	bh=CvID57YmT4JMAq1iUTs3WtirP/sKV5Z6AefJvN/SSYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dph3Sm+CkY2aa2aZwZzvb3WQQJJjUsF86ySsVrnTSXKIHxywyQG6/V52k8HNTMILLJSykMMGPmSbckFznYQ0G8Wv/r3YBMpMNVv+uBs8B9LG8S7liALImSEEuAbgevaPZGgtSiz482LwOua0dUD3erls0qG7a+5aKx/NP6sesrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSc7j3I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB48CC4CECF;
	Tue,  5 Nov 2024 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730815145;
	bh=CvID57YmT4JMAq1iUTs3WtirP/sKV5Z6AefJvN/SSYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSc7j3I52dEaIwkDTn4ibAs0yL+sm1AUrdjsS5Foqi9CmitafJ0rmhkf8jgCLxDXv
	 JLp2feUIvpp46K7GRII8y6DO1tvcztO0PFZdYUO5QMD3JD+SLVUz8OV0x0Z9jVBf+f
	 dmc3hj4qkNab24foZVua9aC+kSzagud5ic/jNuGnRdZoG7bdTbZcIf8P4Z3GRHHPmX
	 XfakUYr4UNG+yHNjgD6pu0ezdfKWFokPuu9x/Ww3WifZ6ghk4OhXiM7HuHM1BsulUx
	 w8a8iXOrjgTucQAuuy+8372ySxPYNQ7IvnRIDd4kLjMwMmySgyIhaa/qX+/TgU8PbQ
	 KYmLvcj2Zt7WQ==
Date: Tue, 5 Nov 2024 13:59:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick Chan <towinchenmi@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: spi: apple,spi: Add binding for
 Apple SPI controllers
Message-ID: <722dbc29-3d37-4043-a0c1-f99ac1ceaa80@sirena.org.uk>
References: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
 <20241105-asahi-spi-v4-1-d9734f089fc9@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D7mzdCilsziPoams"
Content-Disposition: inline
In-Reply-To: <20241105-asahi-spi-v4-1-d9734f089fc9@jannau.net>
X-Cookie: I'll be Grateful when they're Dead.


--D7mzdCilsziPoams
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 09:08:29AM +0100, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
>=20
> The Apple SPI controller is present in SoCs such as the M1 (t8103) and
> M1 Pro/Max (t600x). This controller uses one IRQ and one clock, and
> doesn't need any special properties, so the binding is trivial.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--D7mzdCilsziPoams
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcqJKMACgkQJNaLcl1U
h9Clfgf+Pd2KCID4TdGn0iOZF2Js93e/8eeKynPSfYIathQZJzS1VgjiVV/2A4ed
Pu2SpxxqQG93EebMnNm6MA+c9kR2ser/EC5Ty/9erPPkdFXPwiXIo260oxsdqmXz
oJXob3jksOe5Zr+1jCksNjlpviRHrhToRqcJPPoLV5wWbmW20Uz9FAPKH/aMje7U
QgLKNoIAISZGl2eKjjARFFIKmjtHxUQgbgmUTAncnGulmjlqFm3TWenZCFx7Scpf
Ep5+910xQiNSfnQNmNGBPO+O6/VHRicXGUm7nWrCSAaghmOwdVDT231ELjxfY+Fm
EXjZTcdv82Xqb6t4/J3wrJsgTBSqQw==
=iEeU
-----END PGP SIGNATURE-----

--D7mzdCilsziPoams--

