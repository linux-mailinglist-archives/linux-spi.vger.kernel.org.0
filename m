Return-Path: <linux-spi+bounces-6272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE2A07DDB
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582253A5BC1
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D8221DBD;
	Thu,  9 Jan 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXPXiH4d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5750221DA3;
	Thu,  9 Jan 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440891; cv=none; b=IuF1yc8alcuLbAJmyepGNpz1ZllmGX4HJOcGXkkRDiibxlI4T36q1aZHe4ALjbjREfgIRNI5k2kBvuSNeuWK7QTZhbNeHSBBATRBaAcxsUBzWtsf8VnKQlUcs8uaatBltTAgl05mMx8Q3qbut5It9jwcmFgG0YRhS4q7PyE0j3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440891; c=relaxed/simple;
	bh=Pc8D12fz097vam6BOa2bLEZlROyGS0YXUsOJItiSWzA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJUvF6DYpWMRDJW0slRZZ+HZbMj/APeOHCchNNN5cSsUPUD6jYUeehlkuu25cySSrI40+ioASYtiNW7P6arWQ9Z8+qwdSPLOF8A/r8T96fMDOCfkvtVEG6eYmRxSWJ6o/mmYa31TJ5ts7fMW02gRA9onuxhoB3GWlIQOTekOCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXPXiH4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F1CC4CED2;
	Thu,  9 Jan 2025 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440891;
	bh=Pc8D12fz097vam6BOa2bLEZlROyGS0YXUsOJItiSWzA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=OXPXiH4dSwOix47DVg2CmSpZyEGxsVFEZRziGMccvL1OhNA/OcsXc61PmM+0Q5hke
	 fkoZfd9zwtW1VIWMgSpOUPzpckevoHv0qiANaEHX5ekxdw6teP8zOwyZg+c5DvIGjT
	 pN1UUV6LtLjDnZN4jSMFxmVd5wLhkhVLYqXdMBMzPni4GFbh2SqX64ejU4IdluF0Jm
	 R7r4lJE5HLS6O5P7/XZyDGKfqGr/LmkyYGw68RGHwb6tl9PVOCjorndULQEXQDtPvT
	 gq9XqtvbdpilYjEvSb/ei9MX1HxZlQhDxlS5/0cUr6e37k/QjsWsh50jzfSA2xt9tg
	 rLFMSbkyheRYw==
Date: Thu, 9 Jan 2025 16:41:26 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH v3 2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI
Message-ID: <1ee2ad6b-0880-4cde-85d7-dc7371cbbd8e@sirena.org.uk>
References: <20241128174316.3209354-1-csokas.bence@prolan.hu>
 <20241128174316.3209354-3-csokas.bence@prolan.hu>
 <20250109-carat-festivity-5f088e1add3c@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2HD0WHIUxspiNUHT"
Content-Disposition: inline
In-Reply-To: <20250109-carat-festivity-5f088e1add3c@thorsis.com>
X-Cookie: I'll be Grateful when they're Dead.


--2HD0WHIUxspiNUHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2025 at 05:27:58PM +0100, Alexander Dahl wrote:
> Hello Bence,
>=20
> I had another round of intense looking at the code, this time I
> focused on pm_runtime handling.  Although I just learned about the
> basic concepts, I think the ported patch has some mistakes.  I'll

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--2HD0WHIUxspiNUHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd//DUACgkQJNaLcl1U
h9Dlowf/V77B8p5vMXPelljSMYFZLdf5H8msJFki55MJyDQ5NFoKoiCNj95FYBfb
7FjF4H3Adaf5PtpPI/saagNuhC2qqLg36S75VEAcqxDRYk8dyO2oi3Y6dG75xKue
sOqsuVMJQBUHnQx7OVWgqhzyMDjyMmEz7MA0rmL/Bq0+wsdOFmg55BonDD8bPIyn
ykzdY4VKDg9Z+QAUwHQw63cac8XXdpxOz9pooqninaebWa2U5B1phXL2NeBCJj1o
IH7UaK5QMAsb2aDXdVgJ+P/yvnECQhaw9mgrQAHgKBeMKNyhXNaz0o2RX34bKj+S
bKf2eibWHNHyI2HgN87Frfp5S7KCsw==
=+3aC
-----END PGP SIGNATURE-----

--2HD0WHIUxspiNUHT--

