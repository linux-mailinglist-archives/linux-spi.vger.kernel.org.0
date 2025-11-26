Return-Path: <linux-spi+bounces-11566-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F19C8895E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C033AF8AC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D2314D3B;
	Wed, 26 Nov 2025 08:12:11 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45A2D4B6D
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144731; cv=none; b=BDDalFn6i0JDlIL5cS28yY6KlrrQb72LuZVuXwtKpW/XDF+ZQJikaFIHBNpZyqQInLVpvr3m5C/uAYSNav3diogzpK1jRK/Bpsps2+QujsmjZyZz5OWa9IgO3rzWQM4K2CQcEtDZf7iZNfD63Jd0RSoUdsSiu/uD545Q+cZ7/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144731; c=relaxed/simple;
	bh=hyrL8lZ0QFBIp6u+vuY25oTYbPuaXu1pzPynQw5CwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j//AP+aJVP9Ycu27zq5hZ/usp+zWjwN4IsAsCaEct/omQMI8mAAjzLPMyzB1+ZzLwal7+Xbk/668VVkbFkfYf1xqtR68/yTJOLqcTN7ukq0FA58FWG7hhTAppVMzRxQhrk771DrOOfQDYLcftBDDIuYYF05nwC21W2vme7Eaj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOAd3-0002rl-DL; Wed, 26 Nov 2025 09:11:57 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOAd2-002Z6r-34;
	Wed, 26 Nov 2025 09:11:56 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 934EF4A8744;
	Wed, 26 Nov 2025 08:11:56 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:11:56 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, frank.li@nxp.com, hawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Message-ID: <20251126-defiant-swift-of-domination-afa2c9-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xakqceqe3dflkps"
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-6-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--2xakqceqe3dflkps
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
MIME-Version: 1.0

On 25.11.2025 18:06:17, Carlos Song wrote:
> +static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
> +				struct spi_transfer *transfer)
> +{
> +	bool word_delay =3D transfer->word_delay.value !=3D 0;
> +	int ret;
> +	int i;
> +
> +	ret =3D spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
> +	if (ret < 0) {
> +		transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> +		dev_err(spi_imx->dev, "DMA data prepare fail\n");
> +		goto fallback_pio;
> +	}
> +
> +	spi_imx->rx_offset =3D 0;
> +
> +	/* Each dma_package performs a separate DMA transfer once */
> +	for (i =3D 0; i < spi_imx->dma_package_num; i++) {
> +		ret =3D spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
> +		if (ret < 0) {
> +			transfer->error |=3D SPI_TRANS_FAIL_NO_START;
> +			dev_err(spi_imx->dev, "DMA map fail\n");
> +			break;
> +		}
> +
> +		/* Update the CTRL register BL field */
> +		writel(spi_imx->dma_data[i].cmd_word, spi_imx->base + MX51_ECSPI_CTRL);
> +
> +		ret =3D spi_imx_dma_package_transfer(spi_imx, &spi_imx->dma_data[i],
> +						   transfer, word_delay);
> +
> +		/* Whether the dma transmission is successful or not, dma unmap is nec=
essary */
> +		spi_imx_dma_unmap(spi_imx, &spi_imx->dma_data[i]);
> +
> +		if (ret < 0) {
> +			dev_dbg(spi_imx->dev, "DMA %d transfer not really finish\n", i);
> +			break;
> +		}
> +	}
> +
> +	for (int j =3D 0; j < spi_imx->dma_package_num; j++) {
> +		kfree(spi_imx->dma_data[j].dma_tx_buf);
> +		kfree(spi_imx->dma_data[j].dma_rx_buf);
> +	}
> +	kfree(spi_imx->dma_data);
> +
> +fallback_pio:
> +	/* If no any dma package data is transferred, fallback to PIO mode tran=
sfer */
> +	if ((transfer->error & SPI_TRANS_FAIL_NO_START) && i !=3D 0)
> +		transfer->error &=3D !SPI_TRANS_FAIL_NO_START;
                                   ^
this doesn't look correct, you probably want to use a "~", right?

Marc


--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2xakqceqe3dflkps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkmtkkACgkQDHRl3/mQ
kZwc4Af/TNDPHIaoFGGl6ukBcKwe8NM2ZOe/tGDo2HCK+tEBzyKnR/UMtPbCOOts
ZbjuXQ0I3FXFZ80z0XyTiZJIlyLnVI74JGUIIPLdsryOBBmeELwu6BN99f5FZ5qa
x0uG2iyheamGFhetK3zt8F2DObqtEGQJ7JUEVBowUnNNk5wJoLHWYAzLu2qwtOWg
ffAd70VNxPoudzUoTvB87+Aa9mB6MIw2I58WgPP3sUuxDiA8rK+Lj/W2qfYwqynH
vifXpU/gvihUDPS01sKBLg6otQlel2d/ZHHErwemrz11TFgQKuHGz8I4tmZdtn5B
OH4pou7EUL69TVMsJaL2e/xFecR3dQ==
=X/RP
-----END PGP SIGNATURE-----

--2xakqceqe3dflkps--

