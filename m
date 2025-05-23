Return-Path: <linux-spi+bounces-8269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B27AC21DA
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF3F5060E1
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633D22A7E4;
	Fri, 23 May 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxHPdvBe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28F183CC3;
	Fri, 23 May 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999015; cv=none; b=F4ItIiXyuTiSDiM24whb+lReqMdk+YIeIQ9p61hcvBQoFhM6b1qQRMlRT6JMET10Moz+9MoVegyzwlAk8uMd5a5h2qbIutAKVErGL15rtEbVTjQ5qQgl+9opexzqOicxMkYmpomvWEDrvyNw2lVtQWwMGq0xfi5fyh6vsus8VIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999015; c=relaxed/simple;
	bh=B/LXczBMwATATQAdxc5lRKz9Xr6ZFT04LNvWjtBMxkU=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=DdmMwdQqfQBFZ6TaPG69Ups87T5Ks43qwi0XOzLB98p+2QGtVCN4Gqv5zWcydpLlmRt8cvi45MBG4cqkQ4cIpM1/31IxNifmIZl4fRCegmKj+xYuETDQLpRi8TV/A9FbO0ytPMfqDHT+IDJ6vUBXUaDk8efO9a/GSIHynzI04/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxHPdvBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFBDC4CEE9;
	Fri, 23 May 2025 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747999014;
	bh=B/LXczBMwATATQAdxc5lRKz9Xr6ZFT04LNvWjtBMxkU=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=cxHPdvBe2B7S2ZMSHJgNTjL3niskBzJjgW2RKIktdRkiXOOXsgYaVYgz/y8IfZFJg
	 cpxIfXGjW1+p0BGT7XheLQnrlcgVyvIlwio4KdPxhCG7ECnZklvNOlabzR2uYDx2jZ
	 5ual7045iX2BvdMF88W8VIvAnIdoxr9nlned5tW8wAkgSEi7ESnw96okwxP2ZjOtfX
	 Tg8+4lEjUlcOOu835mjBeq7Z3rJ+BVwFhHBf0YW+t539i9z/ACoqPxvo+/Li216m9c
	 WWxB/Fyv8COc5sDmwWX0aMsTxW5R5Rim1sj9aSchy5nHOXCV49CXnbJIDnTh22flsl
	 OnO+m062AH1Gg==
Content-Type: multipart/signed;
 boundary=a4437fa9bafb8d487087985596b0399ee9f18bc31a0f1c2284c38ec0a1e9;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 23 May 2025 13:16:50 +0200
Message-Id: <DA3HXNN7HTD2.2NUKORU5V6CS2@kernel.org>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <sophgo@lists.linux.dev>, <linux-spi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <dlan@gentoo.org>, <ziyao@disroot.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Zixian Zeng" <sycamoremoon376@gmail.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Chen Wang"
 <unicorn_wang@outlook.com>, "Inochi Amaoto" <inochiama@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Longbin Li" <looong.bin@gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
X-Mailer: aerc 0.16.0
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
 <20250523-sfg-spifmc-v1-2-4cf16cf3fd2a@gmail.com>
In-Reply-To: <20250523-sfg-spifmc-v1-2-4cf16cf3fd2a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--a4437fa9bafb8d487087985596b0399ee9f18bc31a0f1c2284c38ec0a1e9
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> Add GD25LB512ME SPI-NOR flash information

Please have a look at [1].

This flash supports SFDP, do you really need a new entry in the
flashdb? Could you try without it?

In any case, could you please dump the SFDP see [1], too.

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html

> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigad=
evice.c
> index ef1edd0add70e6ca501620798a779d621d6bb00d..223b2f598ecd651ce8df6789d=
fbaf938c534f94f 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -33,6 +33,15 @@ static const struct spi_nor_fixups gd25q256_fixups =3D=
 {
>  	.post_bfpt =3D gd25q256_post_bfpt,
>  };
> =20
> +static void gd25lb512me_default_init(struct spi_nor *nor)
> +{
> +	nor->params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;

Should be automatically set, by SFDP.

> +}
> +
> +static const struct spi_nor_fixups gd25lb512me_fixups =3D {
> +	.default_init =3D gd25lb512me_default_init,
> +};
> +
>  static const struct flash_info gigadevice_nor_parts[] =3D {
>  	{
>  		.id =3D SNOR_ID(0xc8, 0x40, 0x15),
> @@ -82,6 +91,14 @@ static const struct flash_info gigadevice_nor_parts[] =
=3D {
>  		.size =3D SZ_16M,
>  		.flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +	}, {
> +		.id =3D SNOR_ID(0xc8, 0x67, 0x1a),
> +		.name =3D "gd25lb512me",

No name,

> +		.size =3D SZ_64M,
> +		.flags =3D SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
> +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_QUAD_READ,
No, no_sfdp_flags, as this flash supports SFDP.

> +		.fixups =3D &gd25lb512me_fixups,
> +		.fixup_flags =3D SPI_NOR_4B_OPCODES,
>  	},
>  };
> =20

-michael

--a4437fa9bafb8d487087985596b0399ee9f18bc31a0f1c2284c38ec0a1e9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaDBZIxIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hOXgGA5IPK+ocEhmNsajncGUWdZqEDgOAiOPNY
CQW2nV3PFOOnnsYFRw7BDqyotkT0/9LqAYDBeTthHnuuXXJT8EiGX7W7fi4j+3e8
tqMR/EiYNuB4aDB+iAsc1btzQhSq0gwCl/E=
=Cu9o
-----END PGP SIGNATURE-----

--a4437fa9bafb8d487087985596b0399ee9f18bc31a0f1c2284c38ec0a1e9--

