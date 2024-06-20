Return-Path: <linux-spi+bounces-3500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF0910368
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE13281A82
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E571AC236;
	Thu, 20 Jun 2024 11:51:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FD1ABCB6
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884272; cv=none; b=SD4YEuC2EidP7u3tYl3vdQNAbVdGO+yhDZt+wNURGEMiF4W8m7g/9Cw3qOe3TjRpRtUzCQ5SaEsakNhyho7xkENVRwcRoODN1CjYHsUsSyZOugKIWXCfPDR7Jwj0t1XEfS1bb4K+Fwa6tP8KnVP/vyTINpx7rGAemgwsrcCTNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884272; c=relaxed/simple;
	bh=CIGmQ+V0M295n9K+gwrHgo2V+yDH/y7k/cpu+XtVVUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0hbLH1CISiyUfL9TcgKbFS5H0GQ2KVSZsHuvyWUFvDqDTlWFCO1+KtkCVBIwCRa6CscKupN/yyA80u234OF+hcbmu5aDBDasueVDspo1iCQMBbWrP96D99SF1hlwN0JcMUy4IpLHiu7RBKVllNZvCtwNSWKgMKeFNDF1xm6g38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGJY-0002IH-PJ; Thu, 20 Jun 2024 13:50:52 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGJY-003h1L-5Y; Thu, 20 Jun 2024 13:50:52 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BECBD2ED977;
	Thu, 20 Jun 2024 11:50:51 +0000 (UTC)
Date: Thu, 20 Jun 2024 13:50:51 +0200
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
Message-ID: <20240620-positive-industrious-tiger-b09d1e-mkl@pengutronix.de>
References: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
 <171888201712.41294.3998570181399309379.b4-ty@kernel.org>
 <20240620-annoying-elated-lobster-240aed-mkl@pengutronix.de>
 <63e0b99d-d47c-4645-bf83-fb671f28d57f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3x7ithjlu3aaazns"
Content-Disposition: inline
In-Reply-To: <63e0b99d-d47c-4645-bf83-fb671f28d57f@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--3x7ithjlu3aaazns
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2024 12:47:14, Mark Brown wrote:
> On Thu, Jun 20, 2024 at 01:43:29PM +0200, Marc Kleine-Budde wrote:
>=20
> > As this is a fix of a regression, can you pick this for v6.10, too.
>=20
> It is applied for v6.10.

Thanks a lot,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3x7ithjlu3aaazns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ0F5kACgkQKDiiPnot
vG+SoAf9FggSpDf/WcsiSEhV95WrFkOLSvn+VBHOJJ5/RtFsKMabSKYOeADRcVEl
KVkb0SEEzbmX5nV/+RZoZDtIlYDiG9bX17LFnQ+yqNoao5Gy6JnraxRLSfV3pwzm
RMBuYc1Bx8Se36D8DtBe4e/sqDshxGclrXLleFuxFjbF0KrXT5HRVckDXkUUqEG6
B6S57ElyETojw4oNqrweaFGPGUYu6ZKoW0wwZgxte7rdSNks3Y8sn4Z1GCTpEArH
Qal9V1mze0MHtJKlTUS8IpOJgoahMBDiU7TcmXclbp7ky87eXHOLDvx6z1jh9bTw
QDCOkic0moCRk4vu+QagV84SkHrRBA==
=Fczp
-----END PGP SIGNATURE-----

--3x7ithjlu3aaazns--

