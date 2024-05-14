Return-Path: <linux-spi+bounces-2840-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8F8C4E28
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37910B227FB
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0E23774;
	Tue, 14 May 2024 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5GvxS3j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6E2C182;
	Tue, 14 May 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676679; cv=none; b=SNYiugb1NYBMrzcWb8+eDtsZASi0yRH1knTm1kTrHX0xQmRDwcKLRcW6R0IBJqcYqCaFh5WJAWt/Yk3delDwahfg5MgY7x5pQjGs3QAWIeNy+4vcGmAvyZmNI2ZUlba4WHfN6o14whw0ymtiJqWtv+7UsCRD/wlVaZDjyJmr6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676679; c=relaxed/simple;
	bh=dl9xK7NMauuyzjNTNgcvu+mipCW/bKmup0pxO3DFFko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVpVEGezdCqfcb9SWSlZ/q7agZ2U0DM+hfryIK0jRmM7bIi6sV4IvDP3c4yGlfglSyS4hI1Y92M7PIPE2sV6nsCLcADe38sQcXxFLcjOMgn9OFXWvg42eHOO81YXPx8k5xbzteTuZWRAO2QWh5Z6mrmSApzpQZ42reUcsQhUF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5GvxS3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404FDC4DE12;
	Tue, 14 May 2024 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715676679;
	bh=dl9xK7NMauuyzjNTNgcvu+mipCW/bKmup0pxO3DFFko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5GvxS3jvoInC+tPo/qJ0nW9Vfq+0oFTT9NxWgMVjQe7Eg7l7j7LhFr/hZoaTzRkb
	 btxK7WRl+TeQ/wXm4no7rFxrNOZUvcB9xjsxbspOar/rmGFNVdxIGt9BSuNOvOdqUv
	 BTrrDdIF+5tzbB7hZ4hiDj4G0abLOyaa4hycmSWCblITved3A0NU6bwl94YL41izYP
	 biDE0e8kAzLsT+Pco/2Ehkf+AV2NtFKpiE+bY/ulT3xBXKQ5UE4ZmZIIZ7XpY+hx6l
	 77a0v/YTVuEgKPOkr2bN9OY0Gtsp0Ao9SeItld0fCG6kC7Usb59mFyzrZD1rLfECOB
	 Zr1B5vboceM4g==
Date: Tue, 14 May 2024 09:51:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH v2] spi: stm32: enable controller before asserting CS
Message-ID: <32d2be34-07e5-4f99-bd31-12aeb9bdce09@sirena.org.uk>
References: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
 <39033ed7-3e57-4339-80b4-fc8919e26aa7@pengutronix.de>
 <ZkJBqSbJakye6BBc@dell-precision-5540>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qd3XkgjD6LiVNaV5"
Content-Disposition: inline
In-Reply-To: <ZkJBqSbJakye6BBc@dell-precision-5540>
X-Cookie: In the war of wits, he's unarmed.


--Qd3XkgjD6LiVNaV5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:36:57PM -0400, Ben Wolsieffer wrote:
> On Mon, May 13, 2024 at 10:29:49AM +0200, Leonard G=F6hrs wrote:

> > Reverting this commit fixes the issue for me. It may be some time before
> > I get around to investigating the issue in detail, so I thought I should
> > ask if anyone else has already noticed this as well.

> Sorry about that; it looks like the STM32H7/MP platforms require the
> controller to be enabled later. I agree that it should be reverted and
> I'll try to think of another approach.

Can one of you please send a patch with the revert and a changelog
explaining the issue?

> The STM32H7/MP devices are significantly different from the F4/7
> devices, which makes it difficult to change shared code without causing
> problems like this. I wonder if it might be better to split the F4/7
> support into a separate driver. This would duplicate a bit of code,
> namely the initialization in probe, the baud rate divider calculation
> and the SPI mode config, but would make testing easier and get rid of
> the indirection that handles the different register offsets and field
> masks on each platform. The code for actually transcieving data and
> handling IRQs is already platform specific.

That might make sense.

--Qd3XkgjD6LiVNaV5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZDJgEACgkQJNaLcl1U
h9AzgwgAgs2oYQ4OnaMxz5ePCOZWtN8efc/rTzOMHKcGBE5yg1KaEr5ZsAB+m+nm
uE6aHtctR6iZkebjfWUjAPCTCIxSBMOqZZcDvJpAz6Vyg4knJCWuwd9ZJNW+/7xr
CeDdED9zn9UC92dYCaP0f6v9P4O/DPsoKf/A4OnhH/4AF+umWPAdRi06BQThEhDM
yljfm3v4Odbuf1YadUqsNgb9Kd5iHwL9lhjTWImT+KjNhT4h7xKX9K33c1STBy9F
mKgOkzHnTJt+f7whV+hSQkP549BZxql15/PXADZOytyC+D/n66YXx2WZKcWITA/E
61OwRBpdr3KpqxnnzwnzB5LLeCnRQQ==
=wxj6
-----END PGP SIGNATURE-----

--Qd3XkgjD6LiVNaV5--

