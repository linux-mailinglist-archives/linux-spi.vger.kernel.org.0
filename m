Return-Path: <linux-spi+bounces-924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF684387E
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jan 2024 09:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8754CB239DE
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jan 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23E4CB4B;
	Wed, 31 Jan 2024 08:07:49 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A205D739
	for <linux-spi@vger.kernel.org>; Wed, 31 Jan 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688469; cv=none; b=IBvbEo+Sz+y4k0cbsQlFxCLG5wdXN7qOJphRaSY8AuSWUYXOhWNZT0RzG+GH2w6OOq7v2w1VW0iX6sWBWIsF5y13zZFXvSn62Vcx0FjSS/5xPoFvtemMMKWZ9/s4Csz6h3LMX5AMvKmVKze/Frd6xuC3savJMLarWHtv2E4tU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688469; c=relaxed/simple;
	bh=mpQ2yk8vlL1Ow2oWexsgjLGbBsMevUBpkOhm40k+FyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC5aoiNhBOOkPZ0XO968SHoUWsPig3tb7FARC7YFXoH9sL00/lvjwB7HWNcrWCxiEI8PWhWe4R3Ebq8bCiGi6HT8rIZJ1IdZs5GLROEQmSQ+TrpQODZ7veMzsZWomUi3f1Bztyg1tAgeCfku75fNxqm9jDyTfhqexFepkKp/PYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rV5d7-00051u-4x; Wed, 31 Jan 2024 09:07:33 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rV5d5-003aNh-Si; Wed, 31 Jan 2024 09:07:31 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 806CE281F2C;
	Wed, 31 Jan 2024 08:07:31 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:07:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: carlos.song@nxp.com
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, linux-imx@nxp.com, benjamin@bigler.one, stefanmoring@gmail.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: fix the burst length at DMA mode and CPU mode
Message-ID: <20240131-chant-reoccur-7d63ba3f02cf-mkl@pengutronix.de>
References: <20240131024623.329240-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtfsgbyo4qbif4eb"
Content-Disposition: inline
In-Reply-To: <20240131024623.329240-1-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--jtfsgbyo4qbif4eb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.01.2024 10:46:23, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>=20
> For DMA mode, the bus width of the DMA is equal to the size of data
> word, so burst length should be configured as bits per word.
>=20
> For CPU mode, because of the spi transfer len is in byte, so burst
> length should be configured as bits per byte * spi_imx->count.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when=
 using dma")
> Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of =
assuming 8-bits")
> ---
>  drivers/spi/spi-imx.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 546cdce525fc..b4ade2d53fef 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -54,7 +54,7 @@ MODULE_PARM_DESC(polling_limit_us,
>  #define MX51_ECSPI_CTRL_MAX_BURST	512
>  /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
>  #define MX53_MAX_TRANSFER_BYTES		512
> -
> +#define BITS_PER_BYTE	8

That's already defined in linux/bits.h

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jtfsgbyo4qbif4eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmW5/8AACgkQvlAcSiqK
BOg1OAf/bUwQbbRLPxGg97y5z77Tf6W/qHPq+joFq6yuMrDO9mU5tJ9EJN76U3as
WkhlAJYUFNUJacnFrq5AykxMzJwolQvob2QX/68Mlkw0ufIfEbKzjHG1pnVCB7sw
LzjuYM58Rg+WItRZmvUtGXrH/harMcIPIJb3wVdGfZjjYlWYcgo/JmUFiULB0ZkG
9XfopZNHEn+vagex8ezqhoBnbAQkw4BnNSgw3vEs4iBlNzGXUqq4Gf5hW3gtTVpW
4f+tzeM1AwgLAclVSMEn1wxt3BApukBHPtOqDxIztAOZKb1Se4dx2BSXZ3JTlNP1
W5MJe6yLwaxgYsYpChX+SgdqVZ+eBA==
=R5St
-----END PGP SIGNATURE-----

--jtfsgbyo4qbif4eb--

