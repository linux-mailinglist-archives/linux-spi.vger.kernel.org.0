Return-Path: <linux-spi+bounces-3389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ACF90592D
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832FB28188A
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18ED181BAB;
	Wed, 12 Jun 2024 16:52:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AA181D1F
	for <linux-spi@vger.kernel.org>; Wed, 12 Jun 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211164; cv=none; b=b8aLlfPEELwUaYvuDU5pniRnBuakpFoBDYTNo0B6gNRBXNr+NHD+AbVM1Y04teT7SXOpkOGjCW1CihFsPdhW0pbjKyEGY9h90A4VSne+UQ3dVvwR4r0dAAZmV+MiY5zPVUnLyZNKSsMNx27PYP0aHtl3C1xMhtF9OWFtOW1ySJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211164; c=relaxed/simple;
	bh=uAiX4vziFX7jtIcADU3LI/J5oThlcDG2ciZj+ddJkog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW+YE9CuFdjxE/6fS+QbH6yIo+vJApymtK2k3uAW0NjLoMla9Xs1k3EPhf5mUIl/yi690JcEbvWHGGCAzx497IYIN63P8HBWUzHopVeCwtIg7pMsXNwRr/hYZ05579UGNEbS5WkSZzzuneIEthvAK2RH+wSauJQpmaMYBjwUOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sHRCz-0005n3-K9; Wed, 12 Jun 2024 18:52:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sHRCx-001pcP-Ja; Wed, 12 Jun 2024 18:52:23 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 425F92E6BE8;
	Wed, 12 Jun 2024 16:52:23 +0000 (UTC)
Date: Wed, 12 Jun 2024 18:52:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: u.kleine-koenig@baylibre.com, imx@lists.linux.dev, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Fabio Estevam <festevam@gmail.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, T.Scherer@eckelmann.de
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25, 35, 50, 51, 53}
 cspi devices
Message-ID: <20240612-rebel-thick-chital-2f7bfa-mkl@pengutronix.de>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
 <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
 <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
 <pof7t5skj6w7to75kynjtck5hh5whc2zm3k3cd3nsz6ogthxi3@2a6at3s4lfpy>
 <ZkDq73W7MuyQ4RLj@akranes.kaiser.cx>
 <ZkUMWWcEpLvE3b-J@akranes.kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxsipimtf3kfdepm"
Content-Disposition: inline
In-Reply-To: <ZkUMWWcEpLvE3b-J@akranes.kaiser.cx>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--cxsipimtf3kfdepm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On 15.05.2024 21:26:17, Martin Kaiser wrote:
> Thus wrote Martin Kaiser (martin@kaiser.cx):
>=20
> > > However this breaks SPI transfers, when I try to read out an MRAM I g=
et:
>=20
> > > 	root@ecu02:~ hexdump -C /dev/mtd4
> > > 	[   71.813807] spi_imx 43fa4000.spi: I/O Error in DMA TX
> > > 	[   71.819173] spi-nor spi0.2: SPI transfer failed: -110
> > > 	[   71.829129] spi_master spi0: failed to transfer one message from =
queue
> > > 	[   71.843962] spi_master spi0: noqueue transfer failed
>=20
> > > So it would indeed be interesting if you ever managed to use DMA on
> > > i.MX25.
>=20
> > I believe so. Looking into my notes from 2016 (when I last tried this),=
 I got
> > the -110 error when the SMC bit in CONREG wasn't set. But this should n=
ow be
> > done in mx31_prepare_transfer if DMA is used...
>=20
> > I'll try to set up a test some time next week.
>=20
> I can now reproduce the dma tx error. My test board uses a dummy spidev d=
evice
> on cspi1 and configures loopback on the cspi1 controller (disabling loopb=
ack
> makes no difference).
>=20
> I'm relatively sure that this setup did work back in 2016/17.
>=20
> Commit 24bb244e02a6 ("ARM: i.MX25: globally disable supervisor protect") =
was
> required before any DMA transfers started working on imx25. As far as I c=
an
> see, this code is still present.
>=20
> I'll look into this a bit more as time permits.

have you found the time to look into this?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cxsipimtf3kfdepm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZp0kMACgkQKDiiPnot
vG+GKAf9FClioR4pbkwEx6f7nHZNau7vbhg4nEEixN8db2/cAchElv5rJEVcDLud
byvLT6f6yetML5ZXur6Cyw6xUsmzL4fGTJ6qNhCwcjsIYCkVt5cXAIYf3eQ3Qvce
RdckwX5ezOwXDVdo6ifvkguWli61xXoXKQ6FjuX1tXmYLLDlYAn9bkdRz8teNjFM
phCUvdbTa1Hz44zY9PbakdSOYYG6VcPI/hFC+G8tLRh7tVJslQzzSvQgu1JI+Yaa
PRpi2Q6Y3irYfHTTAZ0u187OgHl9lnur7E9UWi3E1TKVdi3kCTrKrPUuZNAOYE5e
FGgRMHhRyx9hp7G+XsNsZ+CW4cphpw==
=8dHx
-----END PGP SIGNATURE-----

--cxsipimtf3kfdepm--

