Return-Path: <linux-spi+bounces-4607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E796BA77
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB721F22964
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A51CFEDD;
	Wed,  4 Sep 2024 11:21:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1ED1D0499
	for <linux-spi@vger.kernel.org>; Wed,  4 Sep 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448863; cv=none; b=MEIQPBQd+YKJBJtLqwGjSS/NbKkzYPLxFLsbfzBpQZxXb1JKkNpweZOcmtfFnX2f7I+55LtCdnepX/TPBHasnpvAspg1SlUiCkPpnQ6iN3J7uQ/vo5BWAy4E9z1mdallJgUosfKXputZBM4zbKfpBI1QC9V9FVGdIR0PMa6qzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448863; c=relaxed/simple;
	bh=TftL3iSBmRYXaP1isB4MihdnO9S9c/Serawns1g+mEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn0lNdkEoDyMsTeyZLGeaCzSaEhWajJuM/19nkZ+41EhLNj3a/QopXtqRWbn5ous774KOW0NkD0Lk8+ymdPMVNuyEPmqHH0yUxY7Q0FvpS0vU2cSaObhrp4eHp40Ug7jwZrjvSWDLREeM5RlPZPTXSKNhVlZHqnO/x1y4vlIlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slo41-00024s-Dq; Wed, 04 Sep 2024 13:20:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slo40-005RJT-Un; Wed, 04 Sep 2024 13:20:40 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 79257332619;
	Wed, 04 Sep 2024 11:20:40 +0000 (UTC)
Date: Wed, 4 Sep 2024 13:20:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, devicetree@vger.kernel.org, singh.kuldeep87k@gmail.com, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	kernel@pengutronix.de, hs@denx.de, festevam@gmail.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] spi: nxp-fspi: remove the imx8mp compatible string
Message-ID: <20240904-free-chowchow-of-endeavor-9c3f8b-mkl@pengutronix.de>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
 <20240904111727.1834935-3-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqyfxuqjctwfsa3a"
Content-Disposition: inline
In-Reply-To: <20240904111727.1834935-3-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--fqyfxuqjctwfsa3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 19:17:23, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> According to imx8mp RM, the fspi is compatible with the fspi on
> imx8mm. So remove this redundant imx8mp compatible string here.
>=20
> Fixes: 0467a97367d4 ("spi: fspi: enable fspi driver for on imx8mp")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index fd1816befcd8..da110188bfed 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -1286,7 +1286,6 @@ static int nxp_fspi_resume(struct device *dev)
>  static const struct of_device_id nxp_fspi_dt_ids[] =3D {
>  	{ .compatible =3D "nxp,lx2160a-fspi", .data =3D (void *)&lx2160a_data, =
},
>  	{ .compatible =3D "nxp,imx8mm-fspi", .data =3D (void *)&imx8mm_data, },
> -	{ .compatible =3D "nxp,imx8mp-fspi", .data =3D (void *)&imx8mm_data, },

I think this breaks old DT with new driver, doesn't it?

>  	{ .compatible =3D "nxp,imx8qxp-fspi", .data =3D (void *)&imx8qxp_data, =
},
>  	{ .compatible =3D "nxp,imx8dxl-fspi", .data =3D (void *)&imx8dxl_data, =
},
>  	{ /* sentinel */ }

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fqyfxuqjctwfsa3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYQoQACgkQKDiiPnot
vG/lkwf/U0AwRwCtRAjI/wFFBk3Pwcp0wSfCBNraW/3ZQ6e5J07JIhVh6lUbLcdO
SpJcVczbyhIrtVbLp3qczodFMNVN0SplPUrTlQs9pvRDdLTIhDEoDzmjalJFG+rZ
nXfTWgTF58UQdv2ya6k/xrs/SyislM6bGGdyWAX/+tyURXAJe2tt+cjTPCfgpEEW
PSTviaGoGKlFkwi3OKQ0UYtxBIJE0wV2r2YMQOzXaaqVqZ0K9Hh6bDo0tpRo//O7
srlfOyH9LsQaN3TnVxzoRSA7z5RqDvetWU2rBto6JdjS0nbI5otGgbOtmLGlhCAJ
v2hxFKgdk6Gkx7moLTLvXuDWXbIXxQ==
=Ejr1
-----END PGP SIGNATURE-----

--fqyfxuqjctwfsa3a--

