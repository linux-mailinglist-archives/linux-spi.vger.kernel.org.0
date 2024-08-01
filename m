Return-Path: <linux-spi+bounces-4120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032A944F08
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364A51F219ED
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3B13B7B3;
	Thu,  1 Aug 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rUfvYyZs"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C113B5AF;
	Thu,  1 Aug 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525749; cv=none; b=LVXluBh8jefw0dDq67qYzglHiPZCDCXUFl4fiQ2szLrbmjV7YsGFvFL/7LcKwUF2NI0jDwgGUFbAl7NafZOYspnDtR663buqOCf0Enf5ll6gndCmbWAXMGA/txv3OSpY7cErnMQrEDTNq/yS7rfhCkVz6oOOTjODMc0Zoov1gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525749; c=relaxed/simple;
	bh=zWV9fwEvLkpA9pAeJ3oXXYHMJLMCa0NehNRH5O/nh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaXE+O7IXUppGctMtziI1JAPJz5x+SPfAQUq9HJ4Oowqf9ixfyBkcg3UKWJGzBLP/+ZEcOgbl310AXeD/gGS4mWQtSjETzRssmi8z/HiO5FWrFLa3z998vexMEmQPy2fpiGOwAZskokpTC2QedzgL9oMQ5zuxhhORvc7syfG67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rUfvYyZs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722525744;
	bh=zWV9fwEvLkpA9pAeJ3oXXYHMJLMCa0NehNRH5O/nh8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUfvYyZsOxApkTth73GusmRQGJN5JbQZgYt/0D1/aWxoQ3Nt+bKxILAE34nC8yFxW
	 YrmqkM9sIUv152l8ePXuya1qxFIQvHalvOAPjyC3T/Tls0ckcaS/BzS+gH1mDnaQoN
	 JhFeoA4PyVB7brI689Ndzi7PU0gQQbzoo6ERWQgq0iNIALzmegacW2yM6k3msYRnCl
	 1FZbjC25KfTJvt/xIQL/8oPgoa1i31vTnX+DH6SoWNlz0B8ypmS0FtfDtScp6peiOD
	 Rbtuu+0FRrvFBH2ZTefICx0CtY55HwS3Vw8Ur+FFWByq3Hm9VBvNY4TeCP5vcpugM2
	 bxmGdQFEG1GXA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C6BF73782167;
	Thu,  1 Aug 2024 15:22:24 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 70DF5106097C; Thu, 01 Aug 2024 17:22:24 +0200 (CEST)
Date: Thu, 1 Aug 2024 17:22:24 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lee Jones <lee@kernel.org>
Cc: Dmitrii Osipenko <dmitry.osipenko@collabora.com>, 
	Mark Brown <broonie@kernel.org>, Urja <urja@urja.dev>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: rk8xx: Fix shutdown handler
Message-ID: <ih7hiojzuvqzpyipj66mgu5pmcderltabim7s5dnfzm6qpztbh@jqkst5tfw5ra>
References: <20240730180903.81688-1-sebastian.reichel@collabora.com>
 <20240801131823.GB1019230@google.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ij2xz22fzghfnfr"
Content-Disposition: inline
In-Reply-To: <20240801131823.GB1019230@google.com>


--5ij2xz22fzghfnfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Thu, Aug 01, 2024 at 02:18:23PM GMT, Lee Jones wrote:
> > +	/*
> > +	 * Currently the Rockchip SPI driver always sleeps when doing SPI
> > +	 * transfers. This is not allowed in the SYS_OFF_MODE_POWER_OFF
> > +	 * handler, so we are using the prepare handler as a workaround.
> > +	 * This should be removed once the Rockchip SPI driver has been
> > +	 * adapted.
> > +	 */
>=20
> So why not just adapt the SPI driver now?

This patch is simple and thus can easily be backported, so that the
Acer Chromebook shutdown is fixed in the stable kernels. SPI based
rkxx has been using SYS_OFF_MODE_POWER_OFF_PREPARE from the start,
so it's not a regression.

As far as I could see the SPI framework does not have something
comparable to the I2C .xfer_atomic handler. So fixing up the
Rockchip SPI driver probably involves creating some SPI core
helpers. I'm not yet sure about the best way to deal with this.
But I guess it will be better not having to backport all of the
requires changes to stable.

In any case I think the next step in this direction is discussing
how to handle this in general for SPI.

> What's the bet that if accepted, this hack is still here in 5 years time?

Even if I don't work on this now, I would expect somebody to have
issues with broken shutdown on RK3588 boards before 5 years are
over :)

Greetings,

-- Sebastian

--5ij2xz22fzghfnfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmarqCsACgkQ2O7X88g7
+prvRA//QpziJs2zje1Qs5sT0QdiKwVULJnHSVmN2UsJp8Nw8PlCA7Mroafv8j9l
rrWa+8tAEtNgwOrjqKJQRt3wDg5kIK/w1MOJ+JN1Du+miRL1Wa8c2TB51E8dLjZC
gFPg5jZMcqon5+36cDEOn7x8nNv5rZyWcYf6PKtdtz1/88KhFPX55J9uX7rR9WGR
hRci+TllwouFpCAXe5CI2TSUWE69Bma3hrzpuFC8iqTesC6K42qqaV74JkuKMRLx
uoJ3zwBMChMZsrPjf8sFQpl/DQc3/kGOJsf19QjvYa+IOyDYUAWsxDDURyyifiXG
dQhXNyWe93tXKtqwqO1aQ9n/faqMvfN22mpUM/9/XRy7E9OZ62x4pW7CgspIDRUD
DN5CntPyOdGOAvY0v87PwwGo17LMH5BHP/TycsCAjBV1Euld8JAwK5VXBdZehYs0
Wf3TJ32Vu6dNugbXthA5p+l+auW8cFw9mYujAo5N++ao0VoVRYh8XdzUj6EcuYDn
v38wN8S8nzqoH9qgrjsopJ5e936s7uw5soeLnjtHPZmXxopFaXo82ky1MUBLeQeW
1gjeYMSqwicmW/XruQy5mm+8SCzI95d9l9GiJXavEmyBWBC1R2J1cory+m2KOvEZ
IZACNzdWQwXOyjzKtG0wLkxqB+6UsNg2NUebLYUO5div78AcDnQ=
=6MRC
-----END PGP SIGNATURE-----

--5ij2xz22fzghfnfr--

