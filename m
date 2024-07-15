Return-Path: <linux-spi+bounces-3863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2FE93166B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 16:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE321C212BB
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C318EA8A;
	Mon, 15 Jul 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6nkg9qQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40B18E776;
	Mon, 15 Jul 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052638; cv=none; b=AT7Y/4n2LTApeb1uIcAmcLAT4dlzMpT0Ee6p1Z9szaQ2POIIVzepmE5aX3VYeOGC/4mFbJ5y2/P231K4358UgJCCvpZHo6f7CFwgjyrjFQfxxKFD/KEj2hZaEp9x5n1UVgojC/j/2yDe5mRjKyhkVJNmICtAYDFD31aHOaq+DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052638; c=relaxed/simple;
	bh=olow0BFwsofgK5zMXcEkC02aSVJLuFhI+3UN5hLhZbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVQ9oCq/0HgFIzak4LdU8DZJKiJYOqivbvX7pWt1CXnNC0CCDLBECLOpbMwye+/EMXjO6DXpBu8BPFpMCmHNdrPi09j8YWWx+9zT+OPLRsw+6bl+0gUezxxmPyqbxgD0s7Dn1Av/5jelnXq/O6HB64GVOgGHRWDoPyDfV+VfyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6nkg9qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5661C4AF0D;
	Mon, 15 Jul 2024 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721052637;
	bh=olow0BFwsofgK5zMXcEkC02aSVJLuFhI+3UN5hLhZbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6nkg9qQ1qyzLO8UJ1TKgtzdGwLTnDPOF7mez/qUL1fMabHD0vWnP15XsTD0qDTFH
	 /aZ11FReOCFBR1XB2wESgZS3lDTj+sgA0DS63yTAhHH/snJg3prJihHFcOFqMAqg50
	 yXW9ioo+ejWCqEmWg/j+lGJ/jbTE32XFf+divVGJe7NlizMBPRSK5+1Sj1FdfKqzFH
	 +ZdtSR3Ss6X7K7lGdVYim3LB5Jbm5j04aa1BkAl/rTasEWrMgZnhxhBFkym2El6E22
	 xktxCee+9X3JeWYdqVNqjveHhRAnWk7bP9BKXKCvSYrYylHgSz1mExkMWtYKRKvbGX
	 bhHu7BQ2uCijw==
Date: Mon, 15 Jul 2024 15:10:33 +0100
From: Mark Brown <broonie@kernel.org>
To: egyszeregy@freemail.hu
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: add "generic-spidev" for compatible string
Message-ID: <31758947-5570-4b20-94e5-52ea77f4f4e3@sirena.org.uk>
References: <20240714202303.164-1-egyszeregy@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="70snDaXDuhKzGHBb"
Content-Disposition: inline
In-Reply-To: <20240714202303.164-1-egyszeregy@freemail.hu>
X-Cookie: You'll be sorry...


--70snDaXDuhKzGHBb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 10:23:03PM +0200, egyszeregy@freemail.hu wrote:
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>=20
> Spidev is a not an ASIC, IC or Sensor specific driver.
> It is better to use a simple and generic compatible
> string instead of many dummy vendor/product names
> which are all just fake.

> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>  drivers/spi/spidev.c | 2 ++
>  1 file changed, 2 insertions(+)

No, as previously and repeatedly discussed the DT describes the
hardware, not the software that happens to be used to control that
hardware.

You also need to document any new bindings.

--70snDaXDuhKzGHBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaVLdkACgkQJNaLcl1U
h9BeSwf/fZp74bgyyqjAcmrHp6z6se+MwYDEsLmt/pfRv1f+Xg5jcOFV2PxK99AQ
tssZfLPM91/VJboVG1/fpv27U9bafK4+VsN29tBhnTqsPGvwsLCWPLHbn9/IW/GL
KnUnAuU+EkI3NdQcumWR4l8Hx1NB2miHEMRoN9uuAxofCoduhrF1pRo+EvVvrlqT
dleAt5ettcOYjk2uey2UYKXcMfnTc4OyyUhXl/m9DJe96JUiISDT5exWAzNwEAYN
6tHxtocrcAgQz1hTkuMKbXsiQMY78TLK009FEkdC3DJMoGy6HZ5h+oA6lpUxSwr1
xGQ87Yw3CvgDUGRCygLmAF0BOgmUdw==
=fBNy
-----END PGP SIGNATURE-----

--70snDaXDuhKzGHBb--

