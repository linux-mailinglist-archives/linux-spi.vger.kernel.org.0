Return-Path: <linux-spi+bounces-2849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A68C5AB1
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 19:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1AF1F22195
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226951802B1;
	Tue, 14 May 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRq3zDXK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCD1791ED;
	Tue, 14 May 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709429; cv=none; b=Z1gbf+6xs1ZgIKNLWHgTU1kg2aFa+NGC39zgJ0OaFWKc8uoL/wrEYyTVHMwh+VpKTI+K5Sb2u0GYEjUBwhBBr2HNppvw9ChAw3cD4wmRt1HpN1G7NBvbbgEDd9+IIkVDiA2G3BEOI9Bpedc+H8Zqj70orAid7IxzUiVnhFoN/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709429; c=relaxed/simple;
	bh=L4rhaJihbyiVB4osf1uPgFvAN8dhp1LCMRxGAjsa0OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk446IOzEEjjnn11vyR7qahJjTrpEXx9PmjV1TrbsQ1/QFbubi1k45xPSiC1crhJ98RAcF6CjwQl+7snsSm5wKMc81V9HNmG8cyk+OisXgHyet1gCcB3ZLDJ9ock60MuWPs9w3FU0k1lWN4324GACBKIvHcPXU8QQVijwzBY29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRq3zDXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2288AC2BD10;
	Tue, 14 May 2024 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709428;
	bh=L4rhaJihbyiVB4osf1uPgFvAN8dhp1LCMRxGAjsa0OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRq3zDXKfziGPndKIghDH2Ny/HCHKekmPcybt/UPF+wnk5uRbW+KxG9BFEUwdr/t5
	 03UcWVvXUHD5aGH4/2k0RLBabcigooyfR24Qoim0iKuoDkMnLWTvKxxI/j9pxKZhDp
	 TE7U4R+A/so3UmFi1JxX78NJlPikPr8Dsqv8G75blcOFXXA9g02Uf2khoZfjjAXwMR
	 yjIua2mNhCB4M53pn+/Vfk7FSG9KUkXisPp3I4rBfamcctKwN8Np8W2nA8DD5pETs1
	 NiXp78pno/+siqfjYqEj2PyXVtNyW+EOQXQ0c+lB/wZUoc1nFCSQKny/CV1/4IplR5
	 F6A3LvquuLlKw==
Date: Tue, 14 May 2024 18:57:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH v2 3/3] spi: spi-microchip-core: Add support for GPIO
 based CS
Message-ID: <20240514-malt-diffuser-2fd207015e72@spud>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
 <20240514104508.938448-4-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y+iyNK1SdnhbDI8k"
Content-Disposition: inline
In-Reply-To: <20240514104508.938448-4-prajna.rajendrakumar@microchip.com>


--Y+iyNK1SdnhbDI8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Prajna, Mark,

On Tue, May 14, 2024 at 11:45:08AM +0100, Prajna Rajendra Kumar wrote:
> The SPI "hard" controller within the PolarFire SoC is capable of
> handling eight CS lines, but only one CS line is wired. Therefore, use
> GPIO descriptors to configure additional CS lines.
>=20
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>

I provided an ack on v1, so here it is again:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

In general you can keep tags between versions, if you intentionally drop
tags you should mention why you dropped them.

> ---
>  drivers/spi/spi-microchip-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip=
-core.c
> index c10de45aa472..6246254e1dff 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -258,6 +258,9 @@ static int mchp_corespi_setup(struct spi_device *spi)
>  	struct mchp_corespi *corespi =3D spi_controller_get_devdata(spi->contro=
ller);
>  	u32 reg;
> =20
> +	if (spi_is_csgpiod(spi))
> +		return 0;

Mark,

This has no users outside of core code, but is < 6 months old. Is using
it in a driver like this okay?

Cheers,
Conor.

> +
>  	/*
>  	 * Active high targets need to be specifically set to their inactive
>  	 * states during probe by adding them to the "control group" & thus
> @@ -516,6 +519,7 @@ static int mchp_corespi_probe(struct platform_device =
*pdev)
> =20
>  	host->num_chipselect =3D num_cs;
>  	host->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +	host->use_gpio_descriptors =3D true;
>  	host->setup =3D mchp_corespi_setup;
>  	host->bits_per_word_mask =3D SPI_BPW_MASK(8);
>  	host->transfer_one =3D mchp_corespi_transfer_one;
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--Y+iyNK1SdnhbDI8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkOl7wAKCRB4tDGHoIJi
0vAbAP4s3UDpCqUDZ7kvX4ikM1pgZrQjOVzd/RDR6106Rr5HdAEAsa9NZW8rS76m
pTMi3kRiV4hfKVd6W17bzh01HOJPtA8=
=Eyq7
-----END PGP SIGNATURE-----

--Y+iyNK1SdnhbDI8k--

