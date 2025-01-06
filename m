Return-Path: <linux-spi+bounces-6227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA732A0259B
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 13:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF181616F2
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCD0158DD8;
	Mon,  6 Jan 2025 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzhuI2hK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321C184F;
	Mon,  6 Jan 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166949; cv=none; b=m2XJ8fXwFQfQ07U5Kl+KsseSNrLOQFL/Yw26EvpUW7xZ+10DiO5I79Zs+tMopu5ELvqFLcieoAna3l6jHoZEXKyRLCvutMCF4UlpVXSmqexoCh5LaxqeJNCXs7KhmYf9ZmEUSIUbYLXYyCFvT59pVwGrF1EOwQ704WJh0zuYydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166949; c=relaxed/simple;
	bh=e6r4bgfMSt6jfSpc0BV4h8ov7eRV/zr34+P2Iggsre4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwGqlQXPPZ35LjE/eOGMqCKL4vCIIPLcnvNDCUueIZ7waH/J3vCURXKl2yuE7+2aHhewRMbNaIZrNXdCoQLiW6wUUq9yDXpm2/tBQHw6fZPhGo0PKExPEVVCPZkYz9obnStOGsc+bllhV6ueiViDmmBVbN4U+WH2F9PHCo1QKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzhuI2hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4869AC4CED2;
	Mon,  6 Jan 2025 12:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736166949;
	bh=e6r4bgfMSt6jfSpc0BV4h8ov7eRV/zr34+P2Iggsre4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzhuI2hKZv4kqRyUpVrnaZWJRr5NdjAstnvc3Ab8/4dpEo8ELGFns3C81vjUpyirM
	 NEqR8KrN9Rhk+fRfR1o4oiEEPeWVM5kPeKeTriQpKrsy2L8ghxA58d8IafP2sd4CKa
	 5c13RB73AEXXE5vUrWQDCH/0dcIqU1TMzpjfpJOkDWmBEsOdidPlX3ZkXRI9AN/OpQ
	 Q7LKSybFr7aBwZtNEEfJI4yKNHYKuNw9hSulSB8PoMnB4/9+rDPfypnNJrIZfFzUuR
	 plOXVstRIV2mS2wlJay1dL1lGWHTQ5WL/+133D1uhhBsgFdouj1OCNx52m//+Vst60
	 MtxQQ8ZfBKbpw==
Date: Mon, 6 Jan 2025 12:35:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 1/4] spi: atmel-quadspi: Fix struct atmel_qspi_pcal
 kerneldoc
Message-ID: <d5c8ebdc-942a-4bb1-80e9-6eb78fb4601c@sirena.org.uk>
References: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tt8UwXY8YAkoC5VF"
Content-Disposition: inline
In-Reply-To: <20250104205437.184782-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Do not pick the flowers.


--tt8UwXY8YAkoC5VF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 04, 2025 at 09:54:34PM +0100, Krzysztof Kozlowski wrote:
> Correct the typo in parameter name for 'struct atmel_qspi_pcal'
> kerneldoc and W=1 warnings:

As mentioned in submitting-patches.rst when submitting a patch series
you should supply a cover letter for that patch series which describes
the overall content of the series.  This helps people understand what
they are looking at and how things fit together.

--tt8UwXY8YAkoC5VF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd7zh8ACgkQJNaLcl1U
h9Avpwf/VmDQFYkimEztMucINFgvQmgRU4GtcluUB7aCNYIqxtIWpEd4wbxd7TOs
C9tJkZxCIwnRPQ7++omH9um9XYuwj3z+uHSpnd5PzY9rTrQCggnwvVua9Yuxb1+p
lnVaml6kjoKfLGjtSSAgmFq4qZ1Sye1SEjbgS8AHtFRwg74OEf9vI2ckiPbryAsD
6zwe9px/GoZWWjhRsmgnmFl4ETAkZ3E6lEQ+odG4oUMl8mn39mbz0efxlAbhmM3+
jSgghfYLdRcOyafdshmVdZyteaolzYKKPJaUPr5p3i9Q5D0Vq9tClQ/MLSCX9ymY
Cn9EhGZ9VWnwTh5fHOY3n7z4kpMGcw==
=EKsI
-----END PGP SIGNATURE-----

--tt8UwXY8YAkoC5VF--

