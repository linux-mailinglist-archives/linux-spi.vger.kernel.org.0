Return-Path: <linux-spi+bounces-1334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF3853A8D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 20:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33BB1F254AD
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F761171A5;
	Tue, 13 Feb 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0ih62s2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD811712
	for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851316; cv=none; b=LwWX4j2MHJzTNHok6g0l8aiqCtCAzJkyUk17WBumlDoj5aGI0ymzp+oaJir+HhRbG8sm5WI/GfhYd3kyG8TKrwSnjfU9yFMCdUksrGvm6FrTZFV9rkWyXCfItF2o6MNjZXz9Rqmr7VhxFT0gjL2Eg5H3zz5aKxuw1eEsAcb9MqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851316; c=relaxed/simple;
	bh=d84tNa6PiNDmq0addd28SpcWvAqHbZWZYQ5/XB/jpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzOJ5KJYjdxz39jvH3Z/T4ouPV0A34Vl95+cIMhCY1cun2+Lmt3+GjCPiY6whKCVEkfFjGRsF37y2bQtsquXmzMqwZURkEN+Z13KbvykDeTYyjWIRhpHYyCRdGCgZ5geAuhDIzfG3ONC6pLTEtsdJ/4csJB0lH3J8zOYlHZeKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0ih62s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75095C433C7;
	Tue, 13 Feb 2024 19:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707851315;
	bh=d84tNa6PiNDmq0addd28SpcWvAqHbZWZYQ5/XB/jpfc=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=K0ih62s22vYS2c4uHYJBEpZvvuD9ll0UQWzo5fhWT2bJ7DPqtVVWWrIZJsCnWjlh2
	 DwhXcrEFzTktTEgMsy2zxVhQBKvcOGMoAA6TOMECTP502KYVvAACWfJ04nWeGe50AW
	 0EMBkGoIKu3N3uYUJaSAIgqSOl1a4j7wSQfLSHcpMkwjd8iSr+71PIgNkwgZmkfQ2R
	 tdLmJr1CIM3mDtoDFWIgkz3QU64BZacuQKn5NYPic+3n5bQRA8IBG7cTeS3/GLRPDq
	 8z+ddJtCiC3co1PU+/WAkC7Ee/Ue01GknxXgS6n4Vhw8+y50O3pkYsoJT0gLuLVPvF
	 GBmPTs7YYMrRA==
Date: Tue, 13 Feb 2024 19:08:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Brad Larson <blarson@amd.com>
Cc: soc@kernel.org, linux-spi@vger.kernel.org, arnd@arndb.de
Subject: Re: SPI device driver with userspace interface
Message-ID: <c059f722-d7bc-4d37-866d-e0cfc2beb3bd@sirena.org.uk>
References: <20240213190435.23645-1-blarson@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JafmufAC8Du2TNPZ"
Content-Disposition: inline
In-Reply-To: <20240213190435.23645-1-blarson@amd.com>
X-Cookie: Does not include installation.


--JafmufAC8Du2TNPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2024 at 11:04:35AM -0800, Brad Larson wrote:

> The desired CS0, CS1 and CS3 interfaces are /dev/penctrl.0,
> /dev/penctrl.1, and /dev/penctrl.3.  This is very similar
> to the spidev.c driver which is considered inappropriate for
> production.  CS2 is matched to a Lattice spi to i2c driver to

spidev is absolutely fine for production, what is not OK is listing
it directly in the DT.  Your DT should describe the hardware, then if
spidev is the most appropriate driver to bind to the device then an
appropriate compatible should be added to spidev.  See all the existing
examples of doing this in the driver.

--JafmufAC8Du2TNPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLvi4ACgkQJNaLcl1U
h9CIMQf/T4F46fTxuns4FCl9rxcxOk3kQ/XjQgQNdHyCuXs809nmnufujW5oKWCf
a5Opr4lmpUzQKtDBpmmqsJ39OKpnhHtAA6Sz2CwkpcI6rvk6f8oNtAP6giJWwoUI
sR7QKX1a0iXYeKuu+kVt1WgAJOxvopcqVqNh17s9BiJBrxtEv/S5TrC/1luLKBDq
WDVfXub7OTMYdMNX3MgA3c9MtX9iqGnCMTxUTniYoqKYVF907IgS2xBk/lgoFC40
8DOjEDv7GUUCsq3L4Sp+xxdbsqPFcKHJXq0InP6Ud0oAS4Kvu0PcpCqH31j4A7M2
mHP6/sTywJvDo6P8IIjjWjVuDAHsYg==
=99y1
-----END PGP SIGNATURE-----

--JafmufAC8Du2TNPZ--

