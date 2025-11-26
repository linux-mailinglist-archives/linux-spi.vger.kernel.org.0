Return-Path: <linux-spi+bounces-11598-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8591AC89CBB
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2559B4E3246
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECA328276;
	Wed, 26 Nov 2025 12:36:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73F324B12
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160589; cv=none; b=WgAQ8HyNXGCmhJTJXKXr0J32XIrcUYPr2O4uVd8OoUQxsL7qi6q3bbDLycRA24RsQDMcCzcs/PTMQj7JrHTwDtdqJvwPnvPZ99x5n7rNR+ubN+lBm2AIJNk2i3dutgAmC7Ui12bzxPv80DO9VIzM4+BZROONkSThoUupDfWTr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160589; c=relaxed/simple;
	bh=1Ur2l71s3ls7saL1UNBWDtUt9h0IJsTmcc0LubYPVvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfNzM/l5eSQDL8F3MJcaNoflVvd0GnqPtdrA21Hiv6FPs8OYbGPlcEJ9aBwdsNlSf7W8HjKA2PPc22ZEF3mIR0NxTo9AnJcj7Dw/OrP7MwgJHu1BKiDK0kcie0bX70fcdKzQKqnx8OfLCaO9r49ijUbCzlQTRZtBgXBMdd847L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOEkq-0001Oz-VR; Wed, 26 Nov 2025 13:36:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOEkq-002bom-1f;
	Wed, 26 Nov 2025 13:36:16 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C7BB4A8C0F;
	Wed, 26 Nov 2025 12:36:16 +0000 (UTC)
Date: Wed, 26 Nov 2025 13:36:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"hawnguo@kernel.org" <hawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Message-ID: <20251126-refined-fluorescent-kestrel-7d3f9e-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251125-impartial-porcupine-of-courtesy-841990-mkl@pengutronix.de>
 <VI2PR04MB11147F814915ECCB6AE36F0F9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <20251126-colorful-finch-of-joviality-aee641-mkl@pengutronix.de>
 <VI2PR04MB111471DB8E08CC180DA90589FE8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v3dhlxhj7lfehoeh"
Content-Disposition: inline
In-Reply-To: <VI2PR04MB111471DB8E08CC180DA90589FE8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--v3dhlxhj7lfehoeh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
MIME-Version: 1.0

On 26.11.2025 11:17:41, Carlos Song wrote:
>
>
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: Wednesday, November 26, 2025 4:31 PM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: broonie@kernel.org; Frank Li <frank.li@nxp.com>; hawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-spi@vger.kernel.org
> > Subject: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length f=
or ECSPI
> > DMA mode
> >
> > On 26.11.2025 07:42:36, Carlos Song wrote:
> >
> > [...]
> > > For example len is 512 *3 + 511. So first transfer using BURST_LENGTH
> > > =3D 512 bytes(auto update 3 times), DMA transfer len =3D 512 *3, seco=
nd
> > > package BURST_LENGTH =3D 511 bytes, DMA transfer len =3D 511.(If here=
 we
> > > use 512 bytes as BURST_LENGTH, SPI will shift out/in extra bits, it
> > > previous isn't acceptable!)
> >
> > What happens if you keep the Burst Length at 512 and only transfer 511 =
bytes
> > with the DMA engine?
> >
>
> Sorry for missing one question:
> BURST_LENGTH =3D 511, ECSPI will shift out 511 bytes in bus.
> BURST_LENGTH =3D 512, ECSPI will shift out the last one word all bit in 3=
2 bits FIFO.
> So ECSPI will shift out 512 bytes include 8-bits zero bytes in bus.

Why was the tail transfer not needed before your patch?

Is because you configure buswidth to DMA_SLAVE_BUSWIDTH_4_BYTES
unconditionally on !word_delay mode. What happens if you always use
DMA_SLAVE_BUSWIDTH_1_BYTES?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--v3dhlxhj7lfehoeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm9DsACgkQDHRl3/mQ
kZzLeAf4x9KacHJB4mEXTgSoVSrEvq9dfS/QCpmR/IjYApnCNJr8vGzuOAWzUx7B
Ai4MPATpacgHBcz5yrfmRDHHF55ygBQinKGRVakPkr+PO/eCWEDEtDY/307Yxhq1
109CMD3F1KIkRsf1hxhXFudso+ih3tx/e9340vLDmqwBNncgP4b0mxFWSa4wTP9i
9lTPWuXgL0iqhjGCtJ0vWqlAFTinlkyFsFoR+ioRlHuQkHdA9fk9ZSiBIfUitvj6
Ohj8xEJWOpsw7V2IBnadgEuRNMinv5Oc/96uNGypO0dcGe6U75qvNMVSNFvUpV+s
wu1/rmFwRntH6LSQMyI/h3Bmv8P0
=oY1/
-----END PGP SIGNATURE-----

--v3dhlxhj7lfehoeh--

