Return-Path: <linux-spi+bounces-2808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF108C25F1
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202152851D3
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD72312C48F;
	Fri, 10 May 2024 13:40:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E412C47E
	for <linux-spi@vger.kernel.org>; Fri, 10 May 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348421; cv=none; b=YQzbDt0TLodshk8JoJn8HosIVtIxu75IRj6689cOu95hzRydbHMLvBJtglWHHN/9CzFCp0iGyJljgvD0t1h+2t5f2dxq4XNdlujYjCnj1GBN+ZMB2DvvvGKjzOiygiKnCYsMsLIt1OCvDdaNTrYIpaVLeJznAPCBDP2GF1LgxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348421; c=relaxed/simple;
	bh=oulGCoHFnCj/NET3N1OyxsppTrm7YHHc7XXE9G23JwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edP1R3wOYtpT2AtGx3cHQgqdfmqrPMaxcVQH6GgLkTj4CuiAvuzDhBe7LnDZF1octFlChD3rk3cv2kIateP/QJqf9fQ10V+qUj/iz4SIWQ419AjAk+ONyVurEqbsx9mrcfq/WQlJY4hrGUJDYDPQjMu0fqmARNXlLcV16ftB8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5QTt-0006O7-VZ; Fri, 10 May 2024 15:40:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5QTs-000du8-MP; Fri, 10 May 2024 15:40:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5QTs-0022bE-1v;
	Fri, 10 May 2024 15:40:12 +0200
Date: Fri, 10 May 2024 15:40:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: imx@lists.linux.dev, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Shawn Guo <shawnguo@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25, 35, 50, 51, 53}
 cspi devices
Message-ID: <pof7t5skj6w7to75kynjtck5hh5whc2zm3k3cd3nsz6ogthxi3@2a6at3s4lfpy>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
 <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
 <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cibc4wntmwtix5p"
Content-Disposition: inline
In-Reply-To: <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--3cibc4wntmwtix5p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, May 10, 2024 at 02:32:56PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, May 08, 2024 at 03:44:53PM +0200, Martin Kaiser wrote:
> > Thus wrote Uwe Kleine-K=F6nig (u.kleine-koenig@pengutronix.de):
> > > While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it w=
as
> > > claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
> > > device trees don't add DMA channels. The Reference manuals of i.MX31 =
and
> > > i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
> > > check the others.)
> >=20
> > If I'm not mistaken, the imx25 reference manual
> >=20
> > https://www.nxp.com/docs/en/reference-manual/IMX25RM.pdf
> >=20
> > does say that CSPI has DMA support. Section 18.1.1 (Features) lists DMA=
 as one
> > of the features. There's also DMA events (section 3) for CSPI-1/2/3 RX,=
 TX.
>=20
> Oh indeed. I don't know what made me claim that DMA isn't mentioned in
> the reference manual. Maybe I looked at the i2c chapter.
>=20
> I now did:
>=20
> diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp=
/imx/imx25.dtsi
> index 4a85684deff8..710b28a41bae 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
> @@ -190,6 +190,8 @@ spi1: spi@43fa4000 {
>  				reg =3D <0x43fa4000 0x4000>;
>  				clocks =3D <&clks 78>, <&clks 78>;
>  				clock-names =3D "ipg", "per";
> +				dmas =3D <&sdma 8 1 0>, <&sdma 9 1 0>;
> +				dma-names =3D "rx", "tx";
>  				interrupts =3D <14>;
>  				status =3D "disabled";
>  			};
> @@ -229,6 +231,8 @@ spi3: spi@50004000 {
>  				interrupts =3D <0>;
>  				clocks =3D <&clks 80>, <&clks 80>;
>  				clock-names =3D "ipg", "per";
> +				dmas =3D <&sdma 34 1 0>, <&sdma 35 1 0>;
> +				dma-names =3D "rx", "tx";
>  				status =3D "disabled";
>  			};
> =20
> @@ -257,6 +261,8 @@ spi2: spi@50010000 {
>  				reg =3D <0x50010000 0x4000>;
>  				clocks =3D <&clks 79>, <&clks 79>;
>  				clock-names =3D "ipg", "per";
> +				dmas =3D <&sdma 6 1 0>, <&sdma 7 1 0>;
> +				dma-names =3D "rx", "tx";
>  				interrupts =3D <13>;
>  				status =3D "disabled";
>  			};

Additionally to the above I now did:

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c3e5cee18bea..74da1a965a0d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1428,12 +1428,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data =
*spi_imx,
 	if (ret)
 		goto dma_failure_no_start;
=20
-	if (!spi_imx->devtype_data->setup_wml) {
-		dev_err(spi_imx->dev, "No setup_wml()?\n");
-		ret =3D -EINVAL;
-		goto dma_failure_no_start;
+	if (spi_imx->devtype_data->setup_wml) {
+		spi_imx->devtype_data->setup_wml(spi_imx);
 	}
-	spi_imx->devtype_data->setup_wml(spi_imx);
=20
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured


because there is no .setup_wml() callback for i.MX25 in
imx31_cspi_devtype_data and the DMA register is already setup in
mx31_prepare_transfer(). Without this change DMA isn't used.

However this breaks SPI transfers, when I try to read out an MRAM I get:

	root@ecu02:~ hexdump -C /dev/mtd4
	[   71.813807] spi_imx 43fa4000.spi: I/O Error in DMA TX
	[   71.819173] spi-nor spi0.2: SPI transfer failed: -110
	[   71.829129] spi_master spi0: failed to transfer one message from queue
	[   71.843962] spi_master spi0: noqueue transfer failed

So it would indeed be interesting if you ever managed to use DMA on
i.MX25.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3cibc4wntmwtix5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY+I7sACgkQj4D7WH0S
/k6HzQf/S67lzT4YmTJ9q3bqWfTgirvFBobySdM5Hxwdywi4mo8KmvWV0fXV6L3Z
NvecRd4zYPI9X/y8BgX9tHYCcI2JEqKFL4fBs0thrOGMXXOqytvkWvXEm6y/coXA
pNauGY+kcgcFp2TDepyBZO0F7Ob6b0Lqtm54gpKBf7hfLZu3pa6GUodfa+f2xRz4
WvSqFPLdIlTcroKRkHNiH/j8VXN8C2dHxciqFka64BemOOG5cvORjsFvWIPn59nt
QjRt48BgIflUUHqM14yHZRHWd0ONx+WrLdZZUrdX4st7dOz7kD9E3OMzFefTxt+B
OA47B43hZksnSJvQI/tjwUsFx07wJw==
=So2r
-----END PGP SIGNATURE-----

--3cibc4wntmwtix5p--

