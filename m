Return-Path: <linux-spi+bounces-7241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD0A6A372
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 11:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1633B9756
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDABD215783;
	Thu, 20 Mar 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kGM6LjAQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258CD213E78;
	Thu, 20 Mar 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466043; cv=none; b=F44kmRPju1KarI6qHfUXePJGB1TQTva1Rev5P2NjEvHdAUNfIf2C3HbARlc5ejge68SCh8J56lQg4Qb+60UC2dXMBE4ipWmgoFhJofZ3NfXBMFxXBXDDHx81JnXc5JFw3mB3jsdNXTHTo1urXessfMKIPHgVK7Elh9BaEdsNLic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466043; c=relaxed/simple;
	bh=yBCsYOVE7AT2oYGlWBsDG7Zxgx+jh1YRne+Nj/HKJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b19c1m/slQiWUiixijUNVqSjthw9dWeT8h1HA9/cri+IdjQxk7KNp5Q9Yb7GCRf9nKlJO+g87tf9UpQYfz+rC6HZ6Vtyd/fFi1XJfoCFVQsLvKfZE5hMiclXAy6NE/BNFG4fqL3yEWigYFolvXDviIUst27soR8SE3XSqZX7cRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kGM6LjAQ; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=DqDIP5URxHBbU7xo7G+yo2Ah9fSiO+S3KlhCrFB+gWM=; b=kGM6LjAQHidYvv+RmkeYAMZQXA
	bWJ3stQJHTvQ+5FzkDeLLedfYg50wvVs7zJcDxUu3xnhQnXl7fLEy6sh4KSetsxlLK34dAQ5TGSbo
	p1uB6teVnGc082ro/KvQrJy10MvbkJphUfs8UFLb/7o91IAD0Za6GGlterEQ4lZWovjwTo44exwJq
	DkbTO9A18Z/Ykqg+v80KKGWtHH3JDsG7+E1Rh6RJxNC0gVJT+HpQNyz8pPpWGCJbYlaOjkPKyImbY
	egb/yNu8Y2PeW6Zp/g1VB/YF9Bl1YPgINQKSYuZfyXd8gzN9Y10bGH0T43yCLzMiUWKYLNZ0vnZbg
	ssj/7hTw==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1tvCrQ-00BNjk-NZ; Thu, 20 Mar 2025 10:10:48 +0000
Date: Thu, 20 Mar 2025 11:10:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitrii Osipenko <dmitry.osipenko@collabora.com>, Urja <urja@urja.dev>, 
	Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
Subject: SPI transfers in atomic context [Was: Re: [PATCH v1 1/1] mfd: rk8xx:
 Fix shutdown handler]
Message-ID: <sg5kgo5qjqyzfyk5nyjbkpgvbx6sfb7agc67ch6wsdq3etrsbf@h6xbtfs45k4w>
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <20240801131823.GB1019230@google.com>
 <ih7hiojzuvqzpyipj66mgu5pmcderltabim7s5dnfzm6qpztbh@jqkst5tfw5ra>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="whhetjwkeqmqacim"
Content-Disposition: inline
In-Reply-To: <ih7hiojzuvqzpyipj66mgu5pmcderltabim7s5dnfzm6qpztbh@jqkst5tfw5ra>


--whhetjwkeqmqacim
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: SPI transfers in atomic context [Was: Re: [PATCH v1 1/1] mfd: rk8xx:
 Fix shutdown handler]
MIME-Version: 1.0

Hi,

On Thu, Aug 01, 2024 at 05:22:24PM +0200, Sebastian Reichel wrote:
> On Thu, Aug 01, 2024 at 02:18:23PM GMT, Lee Jones wrote:
> > > +	/*
> > > +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
> > > +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
> > > +	 * handler, so we are using the prepare handler as a workaround.
> > > +	 * This should be removed once the Rockchip SPI driver has been
> > > +	 * adapted.
> > > +	 */
> >=20
> > So why not just adapt the SPI driver now?
>=20
> This patch is simple and thus can easily be backported, so that the
> Acer Chromebook shutdown is fixed in the stable kernels. SPI based
> rkxx has been using SYS_OFF_MODE_POWER_OFF_PREPARE from the start,
> so it's not a regression.
>=20
> As far as I could see the SPI framework does not have something
> comparable to the I2C .xfer_atomic handler. So fixing up the
> Rockchip SPI driver probably involves creating some SPI core
> helpers. I'm not yet sure about the best way to deal with this.
> But I guess it will be better not having to backport all of the
> requires changes to stable.
>=20
> In any case I think the next step in this direction is discussing
> how to handle this in general for SPI.
>=20
> > What's the bet that if accepted, this hack is still here in 5 years tim=
e?
>=20
> Even if I don't work on this now, I would expect somebody to have
> issues with broken shutdown on RK3588 boards before 5 years are
> over :)

I'd like to have power-off working on Qnap TS-433 in the next Debian
stable. With my Debian Kernel hat on I'd say cherry-picking such a
commit (if it's in mainline) is acceptable. Backporting a major
extension to the spi framework isn't.

So: Expectation confirmed! And while I agree that hacks are not nice,
I prefer a hack now over a machine that doesn't shut down properly over
the next five years (if Lee's expectation is also correct).

Can we maybe go forward and do both? Accept this hack patch now and work
on spi to make atomic xfers possible?

Mark, are there concerns from your side?=20
Wolfram, are there things you would recommend to do differently in spi
than what you have in i2c?

Best regards
Uwe

--whhetjwkeqmqacim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfb6aQACgkQj4D7WH0S
/k4lVAgApKR/SmJy+eGu8P1FQH4+6mX1fHsmZUxzeXY41MV39695K+4iGZFvDggc
knS/G5Vv8Q2nVucvZFCWY7HejNsG8Z7VdMijGpxl/cfVccwXHeJZy8Pwzo8+lmtn
TXNTVYAhO5tEP/90mkx4sZLWn2rtrkniRGQEEb1XGBfRZi1WFwY8zVrTSY7GPPST
QyC0tju6/9IC/vWvCMIirPXdj1dfPR9hBVdZc26roBQ/mrcUgqN7FhV8g9hbNuAB
U38RZbhrm6lqfCyzl6nwO0BUgigcEdVxNi3DAbNdIeXCEBL1MFb++bDrq3Ep6BDQ
kSSQoR/oxxHxoviZhQkceHHsh8SHdw==
=hNBd
-----END PGP SIGNATURE-----

--whhetjwkeqmqacim--

