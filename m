Return-Path: <linux-spi+bounces-6741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3BBA2F86E
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C437B188A5F1
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3119DF8D;
	Mon, 10 Feb 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFy0G6We"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49218D63E
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215218; cv=none; b=uoCMAUiv141VFg4bLFhI0BffUj77kSEzP16YlDy/oZYcwhF9Zuu7NtJurTynQFNbLALkot5W3CenVteQvlJri6hHruByiAT25fsnAaGLx7i4MVULbBBvpo0tQLasSVn+BrzubZPz0E9n+eD1howSRrfUToCEE1YHibb6uZkJqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215218; c=relaxed/simple;
	bh=EeKFgu42O6KVGzu0XF/yGq+UfBQqg6sHdK6sWPgAjko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3KhayKYy9NWuwnM6tySyfvW23/XW4nvhMSJELKYz+LscczZTV+jvMqheZOVZ0UmvLyfKx8dxMbNDmXLqr3vQKu+xj6oBCL4ZnWWFp1ImOFzwgfHFlrOaA0n3yGdrCM54XgH2zA0kr8/AQwI1AIit6txr46dogzbEzyQY2QvxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFy0G6We; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A32CC4CEE4;
	Mon, 10 Feb 2025 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739215217;
	bh=EeKFgu42O6KVGzu0XF/yGq+UfBQqg6sHdK6sWPgAjko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFy0G6WexPAO6HUW26i3CLQvVGmbhDHg78AOJBV5vtHVJhDkcQ00JFQGI//zDsF/b
	 5qSKrAt2mbvgYX0X6N39EnFaP930/QsBAJ/xAYn2ev3AiBn7HRD7CTbuO9HEPyv3+k
	 HSsifaKxfnL5LnMgso4mIMDeg8tJvH/d+G/pa+ELbp9TTrhL/76vHTDOSfj9jKQ6tp
	 uP4vnHKFid3GiEi4pB0WB65DxAWZgNlgfPKgdtvlrIfSzrtkR4ZZGCKQjvWM8hzPwT
	 Slebd9wHRgNFTwLahvEQU1KLotSdJjW1dP4RLmczteGgY9jLCFBpWm/yIHzV30qiTC
	 Wddb08eEuL8eg==
Date: Mon, 10 Feb 2025 19:20:13 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-spi <linux-spi@vger.kernel.org>
Subject: Re: Fwd: [PATCH for-6.14 v4 1/2] pm: runtime: Add new devm functions
Message-ID: <5918150a-e2b0-4597-8290-8769b1a1daff@sirena.org.uk>
References: <20250210111008.248929-2-csokas.bence@prolan.hu>
 <a5998b5f-f03b-4d9d-8e23-a7d688406371@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8ylVYsWJ10yMiNVV"
Content-Disposition: inline
In-Reply-To: <a5998b5f-f03b-4d9d-8e23-a7d688406371@prolan.hu>
X-Cookie: A beer delayed is a beer denied.


--8ylVYsWJ10yMiNVV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 07:56:07PM +0100, Cs=F3k=E1s Bence wrote:

> This is the PM side of the series. As you can see, it just adds two
> functions in the style of the already-existing `devm_pm_runtime_enable()`.

That might indeed be trivial enough for a fix - let me know whenever the
PM people have reviewed it.

--8ylVYsWJ10yMiNVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeqUW0ACgkQJNaLcl1U
h9CDqwf/dx/aAJMx6M2HVBgmXLPKJAEyx4k5hfVWAbSqzSc1kzvOuQDZ6qJvvfCl
RBiS4Kqj7mj2SZjPaKEVr4nt9yOBWPK0u4MHRNPhGcZIUKYHBOxd+pVSVg3UC76X
2UCHNTywAh2qRAxuG0/VoIgiPO3iyYGcg/OA8FoD8LXRn4wRDBhy/IoPo2sqMWKy
vEevV8BzN/5ax6a4HN/99KLz7i9HpOEpwOYUVkNBH0Y04CUl/vQUFobfaQvpcfyK
6Ru7QakJEICHyS2Cxso3ynv3V5maINCs63M0LrbBBGVmNO4d1TBrXG8UjL+1S3RS
phQtSGje2H+UdikTToMd7/SqZHsp9w==
=8zqj
-----END PGP SIGNATURE-----

--8ylVYsWJ10yMiNVV--

