Return-Path: <linux-spi+bounces-9087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323BDB0006E
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FED3BB1B7
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319CA2E5413;
	Thu, 10 Jul 2025 11:19:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F512E5411
	for <linux-spi@vger.kernel.org>; Thu, 10 Jul 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146368; cv=none; b=G+Il8ASoIFLNZ/YOyvaxC+xS+C2BtmxhmBYoc7DnPzTuKqkF+fGfjOxW+KYwF1Uaxc1gqqI1qoUzAdpP/RTU3924IvB0LZGQQpGBcRvT2a1sZpGGtmWXFBsH6+l3a1GZkrQqaQr+q2D4W5ENtupgH3LOUF1tzXbbLaG2ZRoumIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146368; c=relaxed/simple;
	bh=hVTlkkYVx+zgA49YUqsyk8/rtWGefGbrJCH+hDheQ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uomaFT0JXjPWilyBpcqV3w0bRZIXSykyoBeoEwWMTK8tm+aLJzAHeAEgUD6+5UZhBZuqcCgeDdkfxCQDUhMHk+3Z5lVgDsMGTyYIgxemUbct6BTwuziuC6R70LQeJg+obR0NmHq2zP6QkdtoP5o+KTrUeM3WXCMcOI/e2zYbDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uZpIq-0005DU-Ed; Thu, 10 Jul 2025 13:19:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uZpIp-007k5r-1e;
	Thu, 10 Jul 2025 13:18:59 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1FC5843AC8F;
	Wed, 09 Jul 2025 08:24:21 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:24:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Hohn, Torben" <Torben.Hohn@bruker.com>
Cc: Mark Brown <broonie@kernel.org>, 
	"amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux@roeck-us.net" <linux@roeck-us.net>
Subject: Re: AW: [PATCH v2] spi: Raise limit on number of chip selects
Message-ID: <20250709-bronze-duck-from-valhalla-118ef8-mkl@pengutronix.de>
References: <FR4P281MB343441EB901D3DD286B923D6837AA@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
 <aF553GU_btT81_b_@finisterre.sirena.org.uk>
 <FR4P281MB34343BD0D260C127866768298346A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4dwjh3fdds6dhj7"
Content-Disposition: inline
In-Reply-To: <FR4P281MB34343BD0D260C127866768298346A@FR4P281MB3434.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--h4dwjh3fdds6dhj7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH v2] spi: Raise limit on number of chip selects
MIME-Version: 1.0

On 07.07.2025 07:30:29, Hohn, Torben wrote:
> > > +#define SPI_CS_CNT_MAX 16
> >
> > > If this is increased to 24 now, we need to carry another patch on top=
 of mainline again once we add another Chipselect
> > > into our FPGA, or into the next iteration of our hardware. We would r=
eally prefer that a Kconfig value is used.
> > > We have handed a patch to pengutronix, because they can send proper e=
mails.
>=20
> > > In the IIO framework there is a Konfig Value for something similar:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/include/linux/iio/trigger.h#n74
> >
> > This doesn't really work, we're supposed to support single kernel image
> > so putting per platform configuration in Kconfig ends up being at best a
> > usability problem.  At some point it's better to just bite the bullet
> > and make things dynamic.
>=20
> After looking a bit more throughly at the code, i dont think it is
> necessary to make this dynamic. The Value at hand is actually the
> number of Chipselects a Device might have and not the the maximum
> number of Chipselects a Controller might have.

I think it's both. The struct spi_controller uses SPI_CS_CNT_MAX:

| struct spi_controller {
[...]
| 	s8				last_cs[SPI_CS_CNT_MAX];
| 	u32				last_cs_index_mask : SPI_CS_CNT_MAX;

See discussion
https://lore.kernel.org/all/49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org=
=2Euk/
for more details.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h4dwjh3fdds6dhj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhuJzEACgkQDHRl3/mQ
kZydUAgAhEyAcO60yhvP3araIxC+QDMZSly0OhyOr8hpJY6kEJMy95PrFkfzo1Hm
0FNGlmsXLqU9Rv5LL9+Yn1gP9Junz8rbm0pyDMaWcoeBh4QP0x+uzShklahuHGtb
PciVyOop48TNiJhK6X4Y8ocUeYTPccbwSw4DuHy6NqCJoQ/+3gJJ9Dosj/mYiA1f
PoBdVBKmO90l9NwKmXrizZNKllztaQK/rPr1nEXYzhsIRDQJvWY+34tQj1YNfa+p
xGaG2D1iimEHX560E/tbGK/dam4C3QljNXOpcYCxBz5u33hrT5JC2mbOGIMhpRzv
qK139hd75GaYPijSm4j2YN0rIg6g8A==
=iiZz
-----END PGP SIGNATURE-----

--h4dwjh3fdds6dhj7--

