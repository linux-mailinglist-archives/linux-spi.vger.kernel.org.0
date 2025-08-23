Return-Path: <linux-spi+bounces-9630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3FB327A6
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 10:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E741BA0AE9
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38323908B;
	Sat, 23 Aug 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUvHNe/H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64960135A53;
	Sat, 23 Aug 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938098; cv=none; b=f0MzG7Rj8O612vUwgjcK40w24dNRwixOJ3imzJlDs69nHWJvva8C5sYVI1aFzSjf99Rs3PXfLg0tTTjak2P/mVaR5UL8W9+VcxVvLM9Uwfwy1TJrxZ1/c+mzZdbApgftRc+UWEa/Ocx5uSS0xzqrB8DxvtUIJgSpBaA8MFspVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938098; c=relaxed/simple;
	bh=GQDqD9/6QX6CCxhf2faZ/EDoG8gzOseFMn+0Er8QwG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQmLky7CXULX0AGYWFF5fyX5gTkraNTWE9A/8LT8FhF73ldynDimtZbYQDKFM5V2G86/Fmdw6JtJz5ohzbPZ0kfq9TKbI1zpvWJ0bdtVqHcl6fzJ+TX+D15Nyc9Vqhv19Qb0BQ2Ir8jalF8IKca27hXoCHOikRtdEuNgRptkB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUvHNe/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9ABC4CEE7;
	Sat, 23 Aug 2025 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755938098;
	bh=GQDqD9/6QX6CCxhf2faZ/EDoG8gzOseFMn+0Er8QwG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUvHNe/HOHVLa9UdM11MiVD9T2IBoat9Mz0bRNdBioPjL7mktS9SbFqyEt1+H15Mk
	 N4R/uGI9q0yROeSvPKvsAlHmi7l/PPSxgyIjhForN3EwgwRMLwseCzXRjkIT0V9kRS
	 L38ZRMf5Lv0aLvDPseS0SXz5BlGGFogPmP1srr1v3zLVDVioVPV+jq13Sfb//9dCUA
	 POtXbz0ZDEsY+3wFSVg+fdBQh2XlfDooto+SzsUdR47Jzv5Nj3XHGswzgNrP6BiB+B
	 d5BvNMGY20f8HV37uZXss+UsBLatGw0kwXMj4Z1dvFicq0dv4gr0tIeffNq8mlZTtg
	 6FOSnWQM3V4ow==
Date: Sat, 23 Aug 2025 10:34:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/13] spi: airoha: switch back to non-dma mode in the
 case of error
Message-ID: <aKl9LqrRDtrYhSkh@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823001626.3641935-7-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BKP8bCyXEOhRq/Lw"
Content-Disposition: inline
In-Reply-To: <20250823001626.3641935-7-mikhail.kshevetskiy@iopsys.eu>


--BKP8bCyXEOhRq/Lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Current dirmap code does not switch back to non-dma mode in the case of
> error. This is wrong.

Can you please add proper Fixes tag here? Probably to make backport easier,
this patch should be moved before patch 5/13. Anyway:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>=20
> This patch fixes dirmap read/write error path.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/spi-airoha-snfi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index ce4026611e26..3431a9c84679 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -692,13 +692,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_=
mem_dirmap_desc *desc,
> =20
>  	err =3D airoha_snand_nfi_config(as_ctrl);
>  	if (err)
> -		return err;
> +		goto error_dma_mode_off;
> =20
>  	dma_addr =3D dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
>  				  DMA_FROM_DEVICE);
>  	err =3D dma_mapping_error(as_ctrl->dev, dma_addr);
>  	if (err)
> -		return err;
> +		goto error_dma_mode_off;
> =20
>  	/* set dma addr */
>  	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
> @@ -798,6 +798,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_me=
m_dirmap_desc *desc,
>  error_dma_unmap:
>  	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
>  			 DMA_FROM_DEVICE);
> +error_dma_mode_off:
> +	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
>  	return err;
>  }
> =20
> @@ -836,13 +838,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi=
_mem_dirmap_desc *desc,
> =20
>  	err =3D airoha_snand_nfi_config(as_ctrl);
>  	if (err)
> -		return err;
> +		goto error_dma_mode_off;
> =20
>  	dma_addr =3D dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
>  				  DMA_TO_DEVICE);
>  	err =3D dma_mapping_error(as_ctrl->dev, dma_addr);
>  	if (err)
> -		return err;
> +		goto error_dma_mode_off;
> =20
>  	/* set dma addr */
>  	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
> @@ -939,6 +941,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_m=
em_dirmap_desc *desc,
>  error_dma_unmap:
>  	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
>  			 DMA_TO_DEVICE);
> +error_dma_mode_off:
> +	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
>  	return err;
>  }
> =20
> --=20
> 2.50.1
>=20

--BKP8bCyXEOhRq/Lw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKl9KwAKCRA6cBh0uS2t
rIVqAQC9rVH2ZVbpmFmpZvCcg2btW82f2rR1q6+G2F7Uh5TSqAD/aShKTkeVPTKj
Rj0n4uxJ32FwRyYt2JKVrvIk+Aj4xwA=
=E5fX
-----END PGP SIGNATURE-----

--BKP8bCyXEOhRq/Lw--

