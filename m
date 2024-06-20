Return-Path: <linux-spi+bounces-3498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB170910340
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F89A1F225A8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B71AB536;
	Thu, 20 Jun 2024 11:43:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116B1AB526
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883836; cv=none; b=nkjg2ZjT95rG2O27+eIYkQUJ7mhadAW/qP8AowjU0293N5AJzBNbd4HmU2vCbqD5nM6jFbJBIqHHsOwubnAG8rFMiCujdfPrW30o8GfFB5zplgcNAdtBY2Wht/7AUlHddE5uZur9cnm0OSV0NDT42EcieFxENsCAOVvImRlZLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883836; c=relaxed/simple;
	bh=MuI/bMp3EYAUT0LT/n3nJoDpRdWXQD5HU0ihbdp0HL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjnJ1Qnn5q3BFiaRH3e0E5f5qcO8eeEwDraTF729mgERsyt+rm8dDVFa4NRqmM1USTBA0qgleCgjIk/rBvY/6/8UKjJ+vBvcIMLVtcawxsEWP+yNdJ3u9ipesOjkimg+vISS5rDzfAuWfm670loiXrPJUDH90ooRSwuA9Ub9o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGCS-0001gx-08; Thu, 20 Jun 2024 13:43:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGCQ-003gwZ-Ec; Thu, 20 Jun 2024 13:43:30 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0DA472ED952;
	Thu, 20 Jun 2024 11:43:30 +0000 (UTC)
Date: Thu, 20 Jun 2024 13:43:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Stefan Moring <stefan.moring@technolution.nl>, Benjamin Bigler <benjamin@bigler.one>, 
	Carlos Song <carlos.song@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Adam Butcher <adam@jessamine.co.uk>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan Bigler <linux@bigler.io>, 
	Sebastian Reichel <sre@kernel.org>, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH] spi: spi-imx: imx51: revert burst length calculation
 back to bits_per_word
Message-ID: <20240620-annoying-elated-lobster-240aed-mkl@pengutronix.de>
References: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
 <171888201712.41294.3998570181399309379.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3dy6e4qflgqi4zjm"
Content-Disposition: inline
In-Reply-To: <171888201712.41294.3998570181399309379.b4-ty@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--3dy6e4qflgqi4zjm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2024 12:13:37, Mark Brown wrote:
> On Tue, 18 Jun 2024 19:34:18 +0200, Marc Kleine-Budde wrote:
> > The patch 15a6af94a277 ("spi: Increase imx51 ecspi burst length based
> > on transfer length") increased the burst length calculation in
> > mx51_ecspi_prepare_transfer() to be based on the transfer length.
> >=20
> > This breaks HW CS + SPI_CS_WORD support which was added in
> > 6e95b23a5b2d ("spi: imx: Implement support for CS_WORD") and transfers
> > with bits-per-word !=3D 8, 16, 32.
> >=20
> > [...]
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt

As this is a fix of a regression, can you pick this for v6.10, too.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3dy6e4qflgqi4zjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ0Fd0ACgkQKDiiPnot
vG+PXgf9HuBbJMlycZ4WpwRZateV2Ts8izzu8MZTpJ2Plx76EBBhZ6+5EGQATdHN
uO59XAlu0dTp/auA/h0eGZdg9ANz6L5rUcDhAV1Bd1AlqAeaDXxmwhQvzz2UnARC
Bq3hnpklRBwlUhBVuUlAuCIUUxHeUgeqjk1TAW9s9iCUZmD3o/J/CCygvcx7LiBr
O/A5cxwGoO40OONFPBY9lXjp5619P6JeRFocOvAZf9JHxPhdBhrdcig9b4GMULjI
S/fXD4MF55JT39tKuC/EUK+btnhHFduCLSsMUcK2Z++7s7XdJuyviF3ybxtfMI7H
MonLd/QJXiWsQH/3/I2jBUS7cb0hwQ==
=PtNw
-----END PGP SIGNATURE-----

--3dy6e4qflgqi4zjm--

