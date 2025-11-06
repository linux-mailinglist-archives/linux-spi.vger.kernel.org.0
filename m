Return-Path: <linux-spi+bounces-11083-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF77C3B390
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F342422D1D
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFB32C934;
	Thu,  6 Nov 2025 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWUZ48jJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6732E2EF9
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434907; cv=none; b=cDkkrwsqaRXO3VemfNKGjU2BYjd7i8t6SITls0kBvRBCKdGnq+okTPwWI/seEiDzQEwqFJ3ryu+oqZhYq7A23Kq4psDO7AbyiHBsjSeVS0hVT8BGRjSytWSx+BvPvKni5e0KYTysQ8jlat/so7T+6cU6HQV8WEG1LfkeZ6e4MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434907; c=relaxed/simple;
	bh=eREqIh47FjyxdXiDBXlcOZmr0ZsfYDTacf21mKkOxEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Utejo5G0CH2OzGDBVVK6eEjK7rw7rMn++Ygcg76kW8Ls8DReYm0Uriw6G7S3Nvd2DW+JVODa+qp2IoYNwneT5+4hkauNCpei3WR/H4A7RFgn22siSY21YZlHQYRXbPkGNi4EC74QqoTxbVGLJoHtkmLasi8rN70eBtJjALxXD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWUZ48jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AF4C116D0;
	Thu,  6 Nov 2025 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762434904;
	bh=eREqIh47FjyxdXiDBXlcOZmr0ZsfYDTacf21mKkOxEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWUZ48jJHpcwk7FVUr+isUKEstw3ifj/zYzIuxdC2KBwLpqgoXJhCIE+geqlsnN0o
	 1WJbJnbYKJ/hymM1iXrRLBLaQL7jChUkMOCtDN8E/HzgiNrCmAtMQbYXnxS/cZsrPd
	 oJpYp/blaC1iXvZQiHSOx/dyF0sT5sF5iQ6ck2wJeoEfQnJ4HOKMpXEuOGVA6GITI1
	 yB/uzOQa/J/McHO69rxs7N88fDOTdRZMgMGeKhRQ66k0zo7+DqnRmRT8kQkssDRsef
	 ecm25T7aUkBV/1PlJ0s175GzbUs6pOZCGAOSpVU4FCw4Ung1swLgR0fd7G1DNvXDeC
	 eNPCmz3cv+H4g==
Date: Thu, 6 Nov 2025 13:15:00 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?wWx2YXJvIEcuIE0u?= <alvaro.gamez@hazent.com>
Cc: linux-spi@vger.kernel.org, Ricardo Ribalda Delgado <ribalda@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] spi: xilinx: increase number of retries before declaring
 stall
Message-ID: <aQyfVAmcS-WUS7RC@finisterre.sirena.org.uk>
References: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlgbTo70SWUtbVoE"
Content-Disposition: inline
In-Reply-To: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
X-Cookie: Absence makes the heart grow frantic.


--qlgbTo70SWUtbVoE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 01:14:04PM +0100, =C1lvaro G. M. wrote:
> SPI devices using a (relative) slow frequency need a larger time.
>=20
> For instance, microblaze running at 83.25MHz and performing a
> 3 bytes transaction using a 10MHz/16 =3D 625kHz needed this stall
> value increased to at least 20. The SPI device is quite slow, but
> also is the microblaze, so set this value to 32 to give it even
> more margin.

This doesn't apply against current code, please check and resend.

--qlgbTo70SWUtbVoE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkMn1MACgkQJNaLcl1U
h9BScQf/bQ4EKp8EgdfMs7aqvY2UsXWaCFjUk0ONxOBtNY8IEZZ70lr7mMqIn3xu
3olwXrvKVroRMAkxZfGyrH9toSEHTx4uWvfo/Dl0LBAwddm5p2aS9MwOKBaE1Uh/
4rHZHE+QSDDtSK7ZWy/QewOWC43oiftHzLqV/UogHB32u3M8OZhX+L+xxCHq5kVY
YD1hrh0EYt6p5thUhE+xoxBJNEEBr4+ooqEl0SQrKVc0rOugWXp6a0AvtazJti1W
AqXn6p6Et7y02UtpywArcRdloq5U9OwOyc/qrxyODgovCqGIlT13lCgdosDYbkUL
ZHBcXoWAP/if1ogNz6+Fu3KdpI6p+w==
=M4D0
-----END PGP SIGNATURE-----

--qlgbTo70SWUtbVoE--

