Return-Path: <linux-spi+bounces-3438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A9D90D82A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B4B28356C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAEF4E1A2;
	Tue, 18 Jun 2024 16:06:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF274778B
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726782; cv=none; b=itFOGriLjbaTWcPoI1wjYxsYEb/mJDkZJNNTbTCgOfmCLxunF+7YId1J1GXWHF7fcuWhl2uKhSyCP259Lp8iwMv2tLTsAPL34KNQUfn0gZ14NHlxWY3G+qOWT5EJKQyXwoKn6WZW89hZtnyZPq1Jtg0zehISE1d3+CLWxSm0Mzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726782; c=relaxed/simple;
	bh=H8XHBp9P2ehcQnUd2bYOBT8GSZ3UXNnVgaRcoelNjcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNSMGTjDdjrPthegtl5Jm2ouOysdOkM+eY/DPzI07p2ADQS3bgPW3CrKknTS1+E1j8nIpwsPOo8+9Zw8y0LXB6lCyeZOabF0+i5HxAy5US1GPUJS894D6031DiaivAL98cDcIiVM4TQpwRemWtofsv2Ik7PdnffUkPI4OZSjgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJbLQ-0003C9-49; Tue, 18 Jun 2024 18:06:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJbLP-003GVK-H9; Tue, 18 Jun 2024 18:06:03 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1FC942EB9EE;
	Tue, 18 Jun 2024 16:06:03 +0000 (UTC)
Date: Tue, 18 Jun 2024 18:06:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Stefan Moring <stefan.moring@technolution.nl>, 
	Adam Butcher <adam@jessamine.co.uk>, Benjamin Bigler <benjamin@bigler.one>, 
	Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, 
	Stefan Bigler <linux@bigler.io>, linux-spi@vger.kernel.org, 
	Thorsten Scherer <T.Scherer@eckelmann.de>, Clark Wang <xiaoning.wang@nxp.com>, linux-imx@nxp.com, 
	kernel@pengutronix.de, Sebastian Reichel <sre@kernel.org>, shawnguo@kernel.org, 
	Carlos Song <carlos.song@nxp.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <20240618-prehistoric-amphibian-firefly-a9b2d2-mkl@pengutronix.de>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
 <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
 <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
 <20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de>
 <20240618-mature-private-peccary-29f0b6-mkl@pengutronix.de>
 <cd8d89d3-c304-4eb6-897f-b423e8196ef2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nowtmb2ukpc2l4sg"
Content-Disposition: inline
In-Reply-To: <cd8d89d3-c304-4eb6-897f-b423e8196ef2@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--nowtmb2ukpc2l4sg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mark,

On 18.06.2024 17:02:22, Mark Brown wrote:
> On Tue, Jun 18, 2024 at 05:59:36PM +0200, Marc Kleine-Budde wrote:
>=20
> > This patch (15a6af94a277 ("spi: Increase imx51 ecspi burst length based
> > on transfer length")) is wrong and the 4 fixes on top of it don't
> > finally fix it. I can send a series of 5 reverts, or a manually revert
> > the burst length calculation to the original value in one patch.
>=20
> A single revert should be fine and is probably clearer.

thanks for your quick answer. What about the Fixes-tag? Just the
original patch?

Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on trans=
fer length")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nowtmb2ukpc2l4sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZxsGgACgkQKDiiPnot
vG+rEggAj+mDrz6GY9k/Zso42swFjVmS+6JBJRxu8NhDHYLouktgqkZfNr8Ha638
y1+8Sa292UmMNY3x//BwiVhvmY1UBOXt8hWPxp2GYjIDDxO4c3ZZjMEjU7zeol7Q
GwH+lq7SeLo1BLlRxxtfE5Wlsv5PGBqgvaBMzifNGvPjJszzYDUKUU+Vz0sCTaNT
1Xik/0U3agaJI44592JegUFK7vPYVtRt1/jsHy/u0bm0tkFY9YVcl3H8Z9faIkxY
np/QGE53Echg77AdCFluPWbzsClckDWbyYjSH0P2PBdAeADrqtnO9S/SzfqyiP1w
gg370NIqr84yDvNUO0QTEAa4ku+/mA==
=OcCY
-----END PGP SIGNATURE-----

--nowtmb2ukpc2l4sg--

