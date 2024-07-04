Return-Path: <linux-spi+bounces-3749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1F927A6D
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 17:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56750282631
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20211AE859;
	Thu,  4 Jul 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHkiM143"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAA1BC23
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107954; cv=none; b=ANq7WPh/m5s4Uzn5ZWZum5XDGxcFA6jFp2J7RqW7zl0tgErDvvh12Qu2ECzeg84ZRwpaRW6M7K44dvulXQe6OvRajYZpBSUSPAtIvWffcRhA3+bsR5Ccmtf0/KAB0lBdxwh/LyinJaXKVCb0+O1gdPMA2aEOw5vb8IxxDq02cJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107954; c=relaxed/simple;
	bh=luWisUEsdRLk3tKuvWhJ4TGnZbIxpiSFNJR15AF1sAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCsF0krXN+RfMVpeKWcVVOdbp37c9umfEKHHgpJuPtj/m2n0mm0z3XWkbrBBMwqKdV6lVgTN7KXdFRXdh7Cdu2uts8Gat9D1wkEVtgC4A7h2003cT+VgSP2tFFy8iUAVIPFqudVewGWb0+47V3C+NsO9O0GJ6LffLvEHvtgOLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHkiM143; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33771C3277B;
	Thu,  4 Jul 2024 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720107954;
	bh=luWisUEsdRLk3tKuvWhJ4TGnZbIxpiSFNJR15AF1sAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHkiM143fHT37F75Iz7OngvheZFMJuL7ae7iRK4F9ZUTYLhhTIlAnOucZj9WVBmLZ
	 YOqRtRMK4PNeaW0XqucsUfKLzuv/dg1H0xXWq5+1ciTmcYX7fSyz5zyGkQS8BJwPw8
	 AVHQrckscLeCJAKhGpgu8GQxsLCGccow8y4VL6Bj7eFu0V6ZVvkGC0BN3byHpBoeeG
	 DaxFDGeSfBlGJwr0Zuw0E6gI+SEYJYgnPnKRDK180p8Xq9TdTm+CruDE9kPuLOiNH5
	 DMhsJJ15aOHRVky7gyDewKoKZoaY29Te6yqoZvIDpUd3dKl9nY8rEoYChUZHLFHsGG
	 L1ngqJ/smEGqw==
Date: Thu, 4 Jul 2024 16:45:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-spi@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/4] spi: xcomm: add gpiochip support
Message-ID: <5e72252f-09c6-44c8-9f69-a6f8228da980@sirena.org.uk>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
 <20240704-dev-spi-xcomm-gpiochip-v1-1-653db6fbef36@analog.com>
 <3ca36d0d-581c-4e24-9466-fb30a3a22d71@sirena.org.uk>
 <76970371e32a30b774fd6d12fc38e8355d950ca7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ydKlh+QfcWcgROak"
Content-Disposition: inline
In-Reply-To: <76970371e32a30b774fd6d12fc38e8355d950ca7.camel@gmail.com>
X-Cookie: Today is what happened to yesterday.


--ydKlh+QfcWcgROak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 04:00:15PM +0200, Nuno S=E1 wrote:
> On Thu, 2024-07-04 at 14:53 +0100, Mark Brown wrote:
> > On Thu, Jul 04, 2024 at 03:49:12PM +0200, Nuno Sa wrote:
> >=20
> > > +static int spi_xcomm_gpio_get_value(struct gpio_chip *chip, unsigned=
 int
> > > offset)
> > > +{
> > > +	struct spi_xcomm *spi_xcomm =3D gpiochip_get_data(chip);
> > > +
> > > +	return spi_xcomm->gpio_val;
> > > +}

> > It seems like the hardware doesn't support input at all so should there
> > even be a get operation?=A0 gpiolib appears to cope fine with omitting =
it.

> Just following recommendations :)

> https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/gpio/driv=
er.h#L336

That comment is for get_direction(), not get().

--ydKlh+QfcWcgROak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaGw60ACgkQJNaLcl1U
h9DUgAf9FisIpShMBUWHFM26R2zI4YAoY0bLb+LQ0AwwTh7rsbCcOib8ZIGb3+H9
AMnkel2E9vgwI52hAE+ZfN4DW8ZkAch9Z8E4zA+qvn1DvCvoRyTmSjfWRtZLXOQF
ztc+jOzI3RjZyGK0AIMZTsWG2j1eIGiTHaa8Qh7b3u6GD8sFjSdObEgGrs9iJ6RB
XzLzo7k0fLWGj2GvU2w1+EGYzcQ80Akyk5/3LU256rohaIJbynyLX3mct6q7H3nq
myL+PJZaB1pwE0bK0e7JQPJJW8uKOf5mGu98kdBG2kXmacnAy+FUe5nls56co+Yu
qBgkRmdhZB+BvrOnIu+HCsF/6P8yVQ==
=Nlps
-----END PGP SIGNATURE-----

--ydKlh+QfcWcgROak--

