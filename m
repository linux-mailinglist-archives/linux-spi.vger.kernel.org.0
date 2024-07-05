Return-Path: <linux-spi+bounces-3769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B92928D22
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873CE28501D
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7F144D3F;
	Fri,  5 Jul 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDCK5Frb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC1A955;
	Fri,  5 Jul 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201313; cv=none; b=GGW1bibKWu2ipPj9P1OuaC8OPOab5DDP2x9aXHYqXwcypY5AO1Q3UikdMRyD6guNPXZYfl2CPl2jGZM7DG0R/jxmet2J4WaRysyXIBa8YZbCHK84D9wmQltauoX4U3MjYs2E8HeY3LLwZ/P9yPVuUaQ/sdjZwv8+FigLN8dGaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201313; c=relaxed/simple;
	bh=8I1iPCnWsXy1kaAQNNh1PQHJzwUcwb7b8lCO9perBF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U07YHUr/+1W2U3wUTeFFDWFptLpOnxxz4/JuV1Z5snd7Vitygl4YCr4gxWicrReKepDwFCumgHPZR4d0qs5P/Upp6n/2bViufJ2JXkJFntbew+g3cv1aym+OsuAZwCTsPBspFCXURnUFzyS5SBeNOztAULORt9ysV4EdhkLyboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDCK5Frb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D91C116B1;
	Fri,  5 Jul 2024 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720201313;
	bh=8I1iPCnWsXy1kaAQNNh1PQHJzwUcwb7b8lCO9perBF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDCK5FrbwNFFKKktxaZrRFvk4tGWB2IQkgWr645YgwnjbQ2EEn91+ItzdDIuuoBNX
	 srLDzlClhbyrQvmbr3mQvwQgxlrRTM59ocwE0PqmB3gC2hKu0iNAHGQgUkHFBF7cOr
	 FzARkoAsHmCyEAlXs0eMBRm9HaYrIedATWwa3fkJhD8E7Sjbi+OClB84i7v50KYprA
	 gAOvQoKZd9gEcgA0GyaIOfyi5Uyr4ACqKg3T5m38pvQ1BMZjYxIv6agI1t7hSJ2o+6
	 QH1EW6x7LdU2UTKlshBSqBxS89rIjggejHtx8jHPUnhqqn1bZV4K1psQ8SPPx2D30h
	 IG19eh+c2eZPQ==
Date: Fri, 5 Jul 2024 18:41:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: add ch341a usb2spi driver
Message-ID: <aa3c79a0-ecbc-4f12-b540-6570350a7909@sirena.org.uk>
References: <20240705145138.5827-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YJkcTQnyOknOQtkM"
Content-Disposition: inline
In-Reply-To: <20240705145138.5827-1-jth@kernel.org>
X-Cookie: Look ere ye leap.


--YJkcTQnyOknOQtkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 04:51:37PM +0200, Johannes Thumshirn wrote:

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1198,6 +1198,12 @@ config SPI_AMD
>  	help
>  	  Enables SPI controller driver for AMD SoC.
> =20
> +config SPI_CH341
> +	tristate "CH341 USB2SPI adapter"
> +	depends on SPI_MASTER && USB
> +	help
> +	  Enables the SPI controller on the CH341a USB to serial chip
> +
>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #

Like the comment says please keep these files sorted (I appreciate
there's some things been missed).

> +++ b/drivers/spi/spi-ch341.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * QiHeng Electronics ch341a USB-to-SPI adapter driver
> + *
> + * Copyright (C) 2024 Johannes Thumshirn <jth@kernel.org>

Please make the entire comment block a C++ one so things look clearer.

> +static void ch341_set_cs(struct spi_device *spi, bool is_high)
> +{
> +	struct ch341_spi_dev *ch341 =3D
> +		spi_controller_get_devdata(spi->controller);
> +
> +	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
> +	ch341->tx_buf[0] =3D CH341A_CMD_UIO_STREAM;
> +	ch341->tx_buf[1] =3D CH341A_CMD_UIO_STM_OUT | (is_high ? 0x36 : 0x37);
> +
> +	if (is_high) {
> +		ch341->tx_buf[2] =3D CH341A_CMD_UIO_STM_DIR | 0x3f;
> +		ch341->tx_buf[3] =3D CH341A_CMD_UIO_STM_END;
> +	} else {
> +		ch341->tx_buf[2] =3D CH341A_CMD_UIO_STM_END;
> +	}
> +
> +	(void)usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf,
> +			   (is_high ? 4 : 3), NULL, CH341_DEFAULT_TIMEOUT);

The cast to void here is very suspicious, what's it doing?

> +static int ch341_config_stream(struct ch341_spi_dev *ch341, int speed)
> +{
> +	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
> +	ch341->tx_buf[0] =3D CH341A_CMD_I2C_STREAM;
> +	ch341->tx_buf[1] =3D CH341A_CMD_I2C_STM_SET | (speed & 0x7);
> +	ch341->tx_buf[2] =3D CH341A_CMD_I2C_STM_END;
> +
> +	return usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, 3,
> +			    NULL, CH341_DEFAULT_TIMEOUT);

No validation of speed?

--YJkcTQnyOknOQtkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaIMFwACgkQJNaLcl1U
h9Cwtgf7BMvZA7w/tsfTnVO2+yjWpaXeiRMisoqiU/aW8wohRiR+lVBAd0TXmGiH
oOQhQFWRBEDwb6DO7sIMbdHeSG8gK8LOX/GPZ+561P8dmqTZ1l1t3vNSqJIil2WS
I3CeLtXN4iU2UDsX6s/8tHWYQ20wUm/msDYyKP+Vp/nL7DYsqUAYJdEn+dOwOBCZ
w4Be4ku31rwCRj/g0vTImlXkI4I7OrEdF10J4NDzcjA8JIrzuznm0wP0PK08qEhk
yjeueew/He1k/a4oYbr/DNINJCDwDu8GsqXdKjwGwu57YBhIxeFd2joXLe8NjVYg
/Pj/CzD0tYCcRbXPnP7t+pbv7LdSfA==
=BHxi
-----END PGP SIGNATURE-----

--YJkcTQnyOknOQtkM--

