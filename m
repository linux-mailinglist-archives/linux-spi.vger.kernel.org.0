Return-Path: <linux-spi+bounces-11573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F565C88B77
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C237350747
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D92D63E8;
	Wed, 26 Nov 2025 08:45:08 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D702C15A5
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146708; cv=none; b=G1Fn7kGang6oWQ4OMVEkZcqfCw8VlUHA4CLrsaHnWFuHk7lXAoCJx8yH7Hfxmqanx43pRIW4x1iv6o4+e1KHvyaFhqkykxq+Hn05F3WqijVlEAbBnw9OOeVVaeabkHUP82wmyH0kmA7ftj86MiKwbMWDPD/XHpv12mCYy/rewGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146708; c=relaxed/simple;
	bh=tNRxnsT+m1q/Cckn8HtKlA00mImLVMgBEcq4KgpwUB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNA+UTpfDB58K76yFSCY5LeTNATd55eTofQ2fMLb8f8MvH0AAjfJVMftBNpXC/MTqlhRxZGFmwiUYt7j1EENdymIgx6Ivvn1omOZ2sHtH6xfOXrR3ltdN/zFR5m38h0Fk1UZrGFF8XW1ByAW0IEo9gWdgBElTZv7CF8jsg5RgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOB8w-0006Ex-UC; Wed, 26 Nov 2025 09:44:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOB8w-002ZUP-24;
	Wed, 26 Nov 2025 09:44:54 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4BBEA4A87B2;
	Wed, 26 Nov 2025 08:44:54 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:44:53 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length
 for ECSPI DMA mode
Message-ID: <20251126-aloof-stalwart-worm-343112-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-invisible-almond-bee-86a27d-mkl@pengutronix.de>
 <VI2PR04MB1114788C5ADCB9D42399D12C1E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpjpsnbozts7gelo"
Content-Disposition: inline
In-Reply-To: <VI2PR04MB1114788C5ADCB9D42399D12C1E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--lpjpsnbozts7gelo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length
 for ECSPI DMA mode
MIME-Version: 1.0

On 26.11.2025 08:34:18, Carlos Song wrote:
> > On 25.11.2025 18:06:17, Carlos Song wrote:
> > > +static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
> > > +				struct spi_transfer *transfer)
> > > +{
> > > +	bool word_delay =3D transfer->word_delay.value !=3D 0;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	ret =3D spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
> > > +	if (ret < 0) {
> > > +		transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> > > +		dev_err(spi_imx->dev, "DMA data prepare fail\n");
> > > +		goto fallback_pio;
> > > +	}
> > > +
> > > +	spi_imx->rx_offset =3D 0;
> > > +
> > > +	/* Each dma_package performs a separate DMA transfer once */
> > > +	for (i =3D 0; i < spi_imx->dma_package_num; i++) {
> > > +		ret =3D spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
> > > +		if (ret < 0) {
> > > +			transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> >
> > What about:
> >
> > if (i =3D=3D 0)
> >         transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> >
> > instead of removing the later?
>
> 	for (i =3D 0; i < spi_imx->dma_package_num; i++) {
> 		ret =3D spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
> 		if (ret < 0) {
> 			if (I =3D=3D 0)
                            ^ i
> 				transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> 			dev_err(spi_imx->dev, "DMA map fail\n");
> 			break;
> 		}
> ...
> -	/* If no any dma package data is transferred, fallback to PIO mode tran=
sfer */
> -	if ((transfer->error & SPI_TRANS_FAIL_NO_START) && i !=3D 0)
> -		transfer->error &=3D !SPI_TRANS_FAIL_NO_START;
>
> 	return ret;
>
> Just like this? I accept this. I can fix this in V2

Yes, with the fixed typo.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lpjpsnbozts7gelo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkmvgIACgkQDHRl3/mQ
kZzAvAgArvXzrutjT/izZ7sdLJgRn2brxxdTsRIw5MxG8cSN6QHYKhE4ADZ8ZU0I
UHPcxx5UbhoxLC/nEnzjYS4l48XGBq66gxtkTBSff01akyulQeAHT9FeS97f2hIE
lNH+SUqzeMtm94s1FysvscYnaYJgR7X/Gl7zT9/Nx6abM2gLL9NdqWEmFg1jfKdp
nGqJlcW13MIjrQHwG4Cf8oa4Yc6K6iPfv5HaryQ/V43mnlpUtmZ2WkbDxlak5zTe
X0ORcy/w2DeRjzXkvdlBV31kUZCpZbjJn6ZhPTXR+VpRDzUzurD5JJfmOmt3kBXp
Aig2qZuQQ5x71CbySJajSzNmYJvqQw==
=eUsF
-----END PGP SIGNATURE-----

--lpjpsnbozts7gelo--

