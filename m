Return-Path: <linux-spi+bounces-10816-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42FC04A54
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1420435978C
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CB2989B0;
	Fri, 24 Oct 2025 07:12:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEB29E10B
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289974; cv=none; b=pgIPLY/QF+NGRuYsH63qK48SjF3H1H932rkIPaC4qm7ic/wA7xIinpzWHERjXVLWYwcYWaWfSpu6s2/+8CJsk4w7ML+fo+6g/eW78dWnd9E/n4fbVzXoblr0mcPWsmGwQ7U1eihxgSMZdxBjfwpPfMAtIAswsXAS//0frxdrOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289974; c=relaxed/simple;
	bh=x+SrvoaJE8H2ESFi99ZCo6TW6oglHEeZWoMpElqTKqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW08xKwo0bdBeL9srsiY/ydOHDJKYOwEZ4zDD7hiiYdBYbiwfrMEtAovMnNYkL8FZF3FBRMihMnDoSTx7x7ewLJcA9mY2FD4nOXWzoadYD9EVv9isu9TR2fIjdKSXuHhZvLD2dc44bp4enhs+CtNjZa3CPocHZZ/7CpaLtaHBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vCByY-0005JQ-SP; Fri, 24 Oct 2025 09:12:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vCByY-005BdX-1J;
	Fri, 24 Oct 2025 09:12:38 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1041448E766;
	Fri, 24 Oct 2025 07:12:38 +0000 (UTC)
Date: Fri, 24 Oct 2025 09:12:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: carlos.song@nxp.com
Cc: frank.li@nxp.com, broonie@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: add 16/32 bits per word support for target mode
Message-ID: <20251024-berserk-stirring-copperhead-3783be-mkl@pengutronix.de>
References: <20251024054952.408393-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r54bjczvnfs4avxi"
Content-Disposition: inline
In-Reply-To: <20251024054952.408393-1-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--r54bjczvnfs4avxi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: imx: add 16/32 bits per word support for target mode
MIME-Version: 1.0

On 24.10.2025 13:49:52, carlos.song@nxp.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> Now for ECSPI only support 8 bits per word in target mode.
> Enable 16/32 bits per word support for spi-imx target mode.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 155ddeb8fcd4..4ffee6c5d5c4 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data =
*spi_imx)
> =20
>  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
>  {
> -	u32 val =3D ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> +	u32 val =3D readl(spi_imx->base + MXC_CSPIRXDATA);
> =20
> +	if (spi_imx->bits_per_word <=3D 8)
> +		val =3D be32_to_cpu(val);
> +	else if (spi_imx->bits_per_word <=3D 16)
> +		val =3D (val << 16) | (val >> 16);

You can use swahw32() here and below.

>  	if (spi_imx->rx_buf) {
>  		int n_bytes =3D spi_imx->target_burst % sizeof(val);
> =20
> @@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct spi_imx_dat=
a *spi_imx)
>  	if (spi_imx->tx_buf) {
>  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
>  		       spi_imx->tx_buf, n_bytes);
> +		if (spi_imx->bits_per_word <=3D 8)
> +			val =3D cpu_to_be32(val);
> +		else if (spi_imx->bits_per_word <=3D 16)
> +			val =3D (val << 16) | (val >> 16);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r54bjczvnfs4avxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmj7JuAACgkQDHRl3/mQ
kZywGAf9EpnxKyFm5zj7bBWinIhgEplzFTJ/FDZo4dWMpa7KbrErAahd0sf0RQrF
BsYkuTMSHcJXJM1K3CEjMEE2ncXu88IRBysNvUD4Y0upyBYB4i8Agrlskcj51FKa
XuCFiyQqrAcHMgCBb0BrmL2t0Rkgu12TsUXWrqkANVSGVU5040XYwGVwNdlWOITX
9Rt9t5BP6Z8NPbdBt/1El4A/gspDIwmVzBVHR5TWFEwvSgtr8aU6v4AGkK0NoTtN
3kIYfHPkcA+CuFoeDdFi3lmWBu2XgV8+hEulBub/q5cKq0NBP9MvTzx1JXJ0i3MI
AN/MSFZDKRiNhAI0gzPa6bu/B49fxA==
=hn10
-----END PGP SIGNATURE-----

--r54bjczvnfs4avxi--

