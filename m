Return-Path: <linux-spi+bounces-11592-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C2C89B7A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F7B4340548
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE17326931;
	Wed, 26 Nov 2025 12:18:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068D26ED5F
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159503; cv=none; b=ftpi5WLHtIsw84RQl0BAglVgCkVu4lO87UAwmRU1gBc0q7X/Dx877ypLYqHDi3o2hcUqksRsNgeby91zuQR01kc1piYgRTS6Qpj/yDsrwkWSE0D5gvUz7XgDtKux5MHW6Cvf3JDY4FTTWdfrEO0mx6a5smGTj5tVTPEMAViwakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159503; c=relaxed/simple;
	bh=vAlUByylf5CqxOC0I1+7OPsdHU9pfWQ32pU6r0KDsgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huMaZqGP15/g5XFL+xovtTvED9mIXPxQN9Qgd8TluPsOyhOnlLU9EoaqFlctkUHiNc4hpUdcB38OYcJtlGHnw9fownFVZe8vrEmrjOnKP9yCQiuz4I0evarLRoMrilbwDxzBE00NXDhY4jFdfFkluVsEVJHfATE4VJDi8VVZTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOETL-0007u2-Dh; Wed, 26 Nov 2025 13:18:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOETL-002bZg-01;
	Wed, 26 Nov 2025 13:18:11 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AB5144A8BC2;
	Wed, 26 Nov 2025 12:18:10 +0000 (UTC)
Date: Wed, 26 Nov 2025 13:18:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Carlos Song <carlos.song@nxp.com>
Cc: broonie@kernel.org, frank.li@nxp.com, hawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Message-ID: <20251126-bulky-mega-beaver-de575c-mkl@pengutronix.de>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-7-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5df52gksb7am3vhl"
Content-Disposition: inline
In-Reply-To: <20251125100618.2159770-7-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--5df52gksb7am3vhl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/6] spi: imx: enable DMA mode for target operation
MIME-Version: 1.0

On 25.11.2025 18:06:18, Carlos Song wrote:
> @@ -1895,10 +1920,16 @@ static int spi_imx_dma_package_transfer(struct sp=
i_imx_data *spi_imx,
>  static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>  				struct spi_transfer *transfer)
>  {
> -	bool word_delay =3D transfer->word_delay.value !=3D 0;
> +	bool word_delay =3D transfer->word_delay.value !=3D 0 && !spi_imx->targ=
et_mode;
>  	int ret;
>  	int i;
>
> +	if (transfer->len > MX53_MAX_TRANSFER_BYTES && spi_imx->target_mode) {
> +		dev_err(spi_imx->dev, "Transaction too big, max size is %d bytes\n",
> +			MX53_MAX_TRANSFER_BYTES);
> +		return -EMSGSIZE;
> +	}

If there is this limitation, this check should go into
spi_imx_can_dma().

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5df52gksb7am3vhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm7/0ACgkQDHRl3/mQ
kZwSxwgAo3CvZ95SVpWaSCshyMvZJ6w2bXoMQtzSgXTCg+abeLF0ICK/dY3phk8H
4GVrJ1LQwsHERHkMui7ufs+gvKFp25Ba7sGif7k9ag0c3Bc4z6T0fPAjWuGH2joM
6WvuuqTnoY1lGKl9s1aclIEx6fG96ll0NsbJ00iqQKk8VvwmjwUt47v+FAnLLmIf
sqFuBsH1Te/qcaMmYqvzbukJjFRJR2Wy+HsiJpOFTt7IASa6M6T/cr4FiF/qhIBa
z+iEj7+841qhFryMV96P8to4Bnh+p/v63mHPoByhCS5622oJKMANjKbhJXWm778C
rGS15gbb2HxMR6lwFULY4zQqi4FS1g==
=VliQ
-----END PGP SIGNATURE-----

--5df52gksb7am3vhl--

