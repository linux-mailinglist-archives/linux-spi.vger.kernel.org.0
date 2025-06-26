Return-Path: <linux-spi+bounces-8787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB30AE9E57
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 15:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056E61C4288C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6B2E5410;
	Thu, 26 Jun 2025 13:13:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29082E54BC
	for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943581; cv=none; b=GkKCQ7L4WQ1CxrcFjdxg0c0BI5hF/TINABipHvbEvNpkBFAgBb2OV8uX5brGKAw6WJjEc4guYUEDkV1TAxcp5PvGLBURfbmZpLaUTE07pRj9YYYB2oV/gmwq1HzFpx9aEgP4z4WJSxaGKnTSYH51DRuELD8Z7qapYlFxG/YYUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943581; c=relaxed/simple;
	bh=UakOI/WvFkgeH35/JbanD0jEC3cwT/gOCqsa2NorhOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUKv5JvfNqIxJX6u0NjPfPXIEea/Tkdoq3HwQwa9cAWzGmauRXxpuY3ZwGEvbKNDSit3xLsHMJ5S1ukKgKhCroduks8+mPEYWEIDmKHhc6MSGFSDW03jJra9/hc+Eede5uJeu3tlYn9dhUwf3Zp8zoyEWvpPXKaLjOfBpbAmJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uUmPI-00079D-S2; Thu, 26 Jun 2025 15:12:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uUmPI-005SFg-0h;
	Thu, 26 Jun 2025 15:12:48 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE551431176;
	Thu, 26 Jun 2025 13:12:47 +0000 (UTC)
Date: Thu, 26 Jun 2025 15:12:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
Message-ID: <20250626-practical-heavenly-pony-af7296-mkl@pengutronix.de>
References: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="exd2capfccwaslk5"
Content-Disposition: inline
In-Reply-To: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--exd2capfccwaslk5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
MIME-Version: 1.0

(sorry my mail setup had a glitch in my previous mail)

On 24.01.2024 13:24:24, Mark Brown wrote:
> As reported by Guenter the limit we've got on the number of chip selects =
is
> set too low for some systems, raise the limit. We should really remove the
> hard coded limit but this is needed as a fix so let's do the simple thing
> and raise the limit for now.

We currently have a use case for 24 chip selects.

> Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Raise the limit further, the highest I've seen thus far is 12.
> - Link to v1: https://lore.kernel.org/r/20240122-spi-multi-cs-max-v1-1-a7=
e98cd5f6c7@kernel.org
> ---
>  include/linux/spi/spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 471fe2ff9066..600fbd5daf68 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -21,7 +21,7 @@
>  #include <uapi/linux/spi/spi.h>
> =20
>  /* Max no. of CS supported per spi device */
> -#define SPI_CS_CNT_MAX 4
> +#define SPI_CS_CNT_MAX 16

Just further increase the limit to 24? Add a Kconfig symbol?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--exd2capfccwaslk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhdR0wACgkQDHRl3/mQ
kZy41Af9HwbbqTmrPAMa/9ziw5fz9I7Hw8XSOK6Mm/qDudl/8K+aqecCP8zL2j6a
P/YjPQFYFh/HLUTL8XXbDI7bcn1vMZwSTM/1cHD0hkBEaLSeiXRvqkNasePuW8ia
kwnX5TuBWUFQEqAxfPiJ8TsGLVsyDTEgeSFGxj4ha0eQfNWlXSnYQoCNbasrwXRe
dioG4QY7Y8PJIk77PcvA1HWFCfSPhEe3r+ryweOSGELsq42nlVOMO0uhMyenkF4O
pVV5WliQEQ2egocNvKLzuJGH9hKH3GJrOqrO99IJYpNRDdlxgGAJ9c/vm5MR6Z0S
fvCuWaZ/o6Wjn47rVHIj8fLH6/BDmQ==
=3Xka
-----END PGP SIGNATURE-----

--exd2capfccwaslk5--

