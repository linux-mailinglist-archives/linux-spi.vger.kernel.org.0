Return-Path: <linux-spi+bounces-9151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ABB0C9C3
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428133BD23D
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FD2E1C54;
	Mon, 21 Jul 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7diNgsZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C72E11D6;
	Mon, 21 Jul 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119287; cv=none; b=m4unM7xlfGzT06qCjN241mVhmqFu91QONVihSgOBLg+hwnq7Mrrp2C8szeAS6boijoZKpALr7IG7BsOyKVX7EPsnIpVgGz5eTKJMxEYkALYm/T/ihEedImih8EfAfwkJ9szvYuLrAe3TwfWa+0p8d1XDGPwq1n0fsOqK7/xkOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119287; c=relaxed/simple;
	bh=V/CfjxoEsKYCsa9Ewp5zLHqhCdlau2qmxdYvbksj8K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC2ARtHexC83OO3nxP2EXq2U6asVCa0nW5oCyk1Ujl1b2riINBkGCUHnQzq4Lpch3C20b/C+E9ajVrkJF4YYASxVKqyWMgmksmke+UNHHV6BvTL8BguT8xQY2nQF8GGnRLFzqZetw5wQn94jtAYRBC1W3f4meNcyWLyO2UGU364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7diNgsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A63C4CEF4;
	Mon, 21 Jul 2025 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753119287;
	bh=V/CfjxoEsKYCsa9Ewp5zLHqhCdlau2qmxdYvbksj8K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7diNgsZycI8nmdD1vqsLiLyvQW4lt3MSDPn42taIptUhJV3ffM3zqJMHttjZt3+u
	 nf/A/8luOCJRRFowuIDDdn4zdPBS4hZCv7Dg36XjWDsep4ZWov6Bb0mfT6rRrAO2p1
	 ThFPJkv20FUbw64XzqcdkXHnqHS5TxSD5Mhf+jWb88c4EqzT5eoeyCYQKn20KvcdjK
	 uMJjuz95HD3IgiWDH/iJwmir+eEq8QOnIk0ipej8m2x9s58y6wZ75f4sM0HshkuRuz
	 P4DzghlEEyXQXYqBOFFB3oGozWRnXFKZg7DKgBG69At9457gttbA237nC9+z8yjgHk
	 MeAaOKAPZ9JxQ==
Date: Mon, 21 Jul 2025 18:34:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, Heiko Schocher <hs@denx.de>,
	linux-kernel@vger.kernel.org,
	Andrei Lalaev <andrey.lalaev@gmail.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v1 0/3] spidev: introduce trivial abb sensor
 device
Message-ID: <2a99b64a-b6d4-46de-acb1-8a9328b7d5f6@sirena.org.uk>
References: <20250719063355.73111-1-hs@denx.de>
 <175311337130.327079.7374455187420344577.b4-ty@kernel.org>
 <d677ecd9-42d6-43fe-8fe1-a5afd4d270e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WCNX58Rd1dpGFNKG"
Content-Disposition: inline
In-Reply-To: <d677ecd9-42d6-43fe-8fe1-a5afd4d270e2@kernel.org>
X-Cookie: Microwaves frizz your heir.


--WCNX58Rd1dpGFNKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2025 at 06:24:55PM +0200, Krzysztof Kozlowski wrote:
> On 21/07/2025 17:56, Mark Brown wrote:

> > [1/3] dt-bindings: trivial-devices: Document ABB sensors
> >       commit: aad2f87cbcab56b322109d26d7b11842a09df91f
> > [2/3] spi: spidev: Add an entry for the ABB spi sensors
> >       commit: d60f7cab7c04944a79af16caa43c141e780a59c6

> That's unexpected, Mark. Patches received two objections/comments and I
> don't think discussion was resolved.

Oh, sorry - I'd missed those (possibly due to only being CCed on part of
the series).  I guess I'll drop this then.

--WCNX58Rd1dpGFNKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh+ei8ACgkQJNaLcl1U
h9Ce3wf7Bhl+JzqbBICKswFFhvnGdkCuL1QR2PvMdJB/QjSKKq/6JpkPEt53OxqO
tBQJYCf6QNpcc+HJqlVumz4r4cwpyp8SXuwmwaxihthqVYRcCyiLA1d/RHFIJ9n9
CyAl/gGjzncNxEIe3trDjSvAzTjGadbAaqmLN54jvS0KPnWfK2S9lzr7r9mkRfqr
m6iikZoind5xRzssX5XFuiCmMxI3wY9StJ4LocjQB2GPD/aWOtNnIQFBUFiaAE4u
376S1CX9/m5tthTqMtLfHRICcz4nAFULDsfYmBPq638I5ZguqDiXhz0JoioTP+ka
SiTSXqIh1a/YSdVXjWkgt6fEzQV0Hw==
=Xbls
-----END PGP SIGNATURE-----

--WCNX58Rd1dpGFNKG--

