Return-Path: <linux-spi+bounces-9627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CCCB32789
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFF81BC5004
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB421019C;
	Sat, 23 Aug 2025 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t90gH+3h"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E451A5BB1;
	Sat, 23 Aug 2025 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936263; cv=none; b=oVPWex2JuBVjm4KHdUFQZe6Nn6vEHmm4zzOcHAQ4WQpYTl8xT+gQ9JPt29NZQb0gRx2UGrcptsZ59g8TunkoyFeJbWjArcuz9RoC9qb8V6wQDHprYSj7ZMm9czNCcap6NwXDveQPqXNC8jBF76y4kwahJDfD+38qrab5M7txL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936263; c=relaxed/simple;
	bh=G+/OUbMjRjtJ1O+gXrVBKFF97ndR0d3t/eZa2Y6qmhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILs+W3nqa5btdoxr5+T1IUyIgX8BGlRBgtepFx6d7snItaLaUFi61EhRTGERn05ZCo5C5kcq79tFmDdQQ5MeQ0dy56wI3zgLTwHQezsT0F75rQSZunIEtwMMgThNEekIe2oD2PRlSPlO3euBDbiv4LALuv8c+VzxvYF1gWvTQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t90gH+3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF4C4CEE7;
	Sat, 23 Aug 2025 08:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755936263;
	bh=G+/OUbMjRjtJ1O+gXrVBKFF97ndR0d3t/eZa2Y6qmhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t90gH+3hoMY/CvsA6myg9IfjKSLYRDiavSi2Oad1Np+0HfzFG+PBoABOSZne/+OR7
	 0Li6poNEV/s00yeRKXrL1o4edJmZShyhOCh3+my/hGh/uuJM2NvDmrdGNClRHaE5xt
	 ZmOFKH0zdGmu5ZUJZQiUhHM0Hdqz8I1bywoXvmfGdR636JieasLNmyELUHwroqrOcn
	 z9ZJh53rqEmBZbVcn8TdKAdQNqLiF+9N37ZlbU5vCxz15zgxpHFQvMXXAUjkPhBtuQ
	 sfiFKEi8c5E57AfYmibJWTaria+qazsQFzwwKsH3b8Uc2BErZoX7e3IlWWLecW0s5i
	 CQqqC3K2YcqKw==
Date: Sat, 23 Aug 2025 10:04:19 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 01/13] spi: airoha: return an error for continuous
 mode dirmap creation cases
Message-ID: <aKl2Awfe4CIV2O44@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-2-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IsRgQG7emvDuB06q"
Content-Disposition: inline
In-Reply-To: <20250823001626.3641935-2-mikhail.kshevetskiy@iopsys.eu>


--IsRgQG7emvDuB06q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This driver can accelerate single page operations only, thus
> continuous reading mode should not be used.
>=20
> Continuous reading will use sizes up to the size of one erase block.
> This size is much larger than the size of single flash page. Use this
> difference to identify continuous reading and return an error.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

I guess here we need to add the proper Fixes tag:

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")

> ---
>  drivers/spi/spi-airoha-snfi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index dbe640986825..043a03cd90a1 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem=
_dirmap_desc *desc)
>  	if (desc->info.offset + desc->info.length > U32_MAX)
>  		return -EINVAL;
> =20
> +	/* continuous reading is not supported */
> +	if (desc->info.length > SPI_NAND_CACHE_SIZE)
> +		return -E2BIG;
> +
>  	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
>  		return -EOPNOTSUPP;
> =20
> --=20
> 2.50.1
>=20

--IsRgQG7emvDuB06q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKl2AAAKCRA6cBh0uS2t
rFmPAP4wEbp3RP2BlAiOqtIlSxliBwk5YgWRY2Lrl4Q+hJS/+QD/QK/uStPNob1E
lJW0noeR0NSGRRFK7R5EqNwGP22jbgU=
=FuF8
-----END PGP SIGNATURE-----

--IsRgQG7emvDuB06q--

