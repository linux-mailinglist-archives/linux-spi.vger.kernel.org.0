Return-Path: <linux-spi+bounces-8786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED80AE9E31
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 15:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484204E02EC
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C92E5404;
	Thu, 26 Jun 2025 13:05:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681842E427A
	for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943159; cv=none; b=OmzSLiqr05nNevhcrJJJXgYmBwilWBrqu6ydYTfPsgPCxpmZTsW6ADb1mM540CCKNeW284iSv+MhbRhiPMVwJnEXrc/NWRODt/G+I0kB20buQBLyvq18VXLweFOtqXBBg/Qwxl/R6CgJVjBiDNeyIH4b9TzIYZbt4vzuC70kwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943159; c=relaxed/simple;
	bh=mg4SwQNbvzeE2sj3wCDg1tjz/VjheXExlZOnS8rGJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTfSdor9s2Eco/nZ+zjCaCvvj/TCUMVCDCoG/P0Q5D2jFVcnQcil6bV31/RVVZa7vaS1bjZKFLkKyxX8fJ93Wh9U3src3kC7Ynp5wtWQcRJUQZ51Ny9KI7r40N6Y9efgLUoiHzkHWa71oWDNOM4TZdKsRWj19CDm90gPxqYFODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardanger.blackshift.org; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardanger.blackshift.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:dea6:32ff:feb1:177a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 55E01678AD1
	for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 12:59:37 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2240C43114C
	for <linux-spi@vger.kernel.org>; Thu, 26 Jun 2025 12:59:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 05D47431147;
	Thu, 26 Jun 2025 12:59:36 +0000 (UTC)
Received: from localhost (hardanger.blackshift.org [local])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTPA id 42c87de3;
	Thu, 26 Jun 2025 12:59:35 +0000 (UTC)
Date: Thu, 26 Jun 2025 14:59:35 +0200
From: Marc Kleine-Budde <frogger@hardanger.blackshift.org>
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
Message-ID: <pulc4xhdpqfseyugxloid6vvjeducuxghfuh7qre67k5v2zie3@wfpiyoyzalmf>
References: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqkdkixsemn3jz2k"
Content-Disposition: inline
In-Reply-To: <20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org>


--wqkdkixsemn3jz2k
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] spi: Raise limit on number of chip selects
MIME-Version: 1.0

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

--wqkdkixsemn3jz2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhdRDQACgkQDHRl3/mQ
kZyyOwf+OXLwobSDwvA5qRpH1KP1AEORA/RtlDzudGtBpnaxtppG+/nc5YI1+icd
/pozE0gF+623mhD2iA/IeNc74OHUHNnDdsHSa6LzHUZfdFjCkcs/lJWBPlMgoyGB
U9Ewsf9Zu/4oCHYRLyxNWQKBwCfQ7EAkxYqryKvDeFh5+jiqFiQecKuv77EnH9c+
Ffa7qk3bWX3Cn4zypT8a0Huih8kNygUP9/MMKylY3gKIMD5bXjsZX96uaXSylllu
Nw8m0NbvkedOpLILA5crJm21gXWZV8IXALy2dvCKq7/9ArHtFgl668G78GDSJ4xb
KdmZ+QRQS2HWOtdZZQYVmG3AGgJMNA==
=TG5b
-----END PGP SIGNATURE-----

--wqkdkixsemn3jz2k--


