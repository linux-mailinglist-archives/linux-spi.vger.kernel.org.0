Return-Path: <linux-spi+bounces-2466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059958AE349
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708821F222B1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 11:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043C6CDCC;
	Tue, 23 Apr 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSbJVLKh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18144629E6;
	Tue, 23 Apr 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870168; cv=none; b=e7D/22qX9rqLjEdGxwCyhKPFOa1HtFohiLENH1l4RBvdJ9DFj/XOm+PbcVoOv/JwMpCNr4eLEVKEd9R/9A9niK8ZXlJrbwXgGTqWrIxsYvMsMbmH76T75PohdQ6/GeiIuKb94zE0f8iylnQy6nNAZboPRVGptoWjGcLNuzFUVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870168; c=relaxed/simple;
	bh=xcoXCfxvjhF/nt99C36t2OZFcpIv/FKcNysmEtnwDvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZeyNXzyEZXQBtwZKq3HEp8CaKYv6cQq/6C9kS67t326VugGNza2E1wtjkenHNr3ZttPqKRNyNBl05PYBfUA8I7yEbgaJ8hCQbMTuim7qhuBgKwBkR1fdIJGgfZ7nDILHCUJQLiXpHXEWOLNpUh+UuMoT3RASmTNLd0uAH2DtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSbJVLKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1C5C2BD11;
	Tue, 23 Apr 2024 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713870167;
	bh=xcoXCfxvjhF/nt99C36t2OZFcpIv/FKcNysmEtnwDvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSbJVLKh8Uj6dmhnRaVQnM5hF52PSr/qRHgmiq8AMzPQ7Tdu5vQBby+HEq9hTLtPx
	 zcuqvGiJa+qld2UUxNsNHUYFW4p7QMLxNiNg+rdV2lRmvBxXtYScPc+yjjlHiX1CL4
	 A+NPe2rNoooyCBosf81BtwywAlak7Wh2opf3W4xQYSUhk0xM6DPrac7R4CYH+jb+cw
	 EdB9JDAfIbj+3DZrHZR93k/hH/BOsAKT0E97q4VJy5dSBQDKRGp9nqRdxB+XFUJrJH
	 rcd3cndf8VzrOayXRnbcO27lHiVP4vEsDC8hc9+SdHd5EtDbG5UlmjyVSb/3nlkCw1
	 pVBREtla9pLtA==
Date: Tue, 23 Apr 2024 13:02:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com
Subject: Re: [PATCH v3 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <ZieVU8UVSI4-W0m9@lore-desk>
References: <cover.1713866770.git.lorenzo@kernel.org>
 <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
 <d0e2918f-893a-4442-bdbf-36e95ffcd4d7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xD3+S2z4fj3w0Tzy"
Content-Disposition: inline
In-Reply-To: <d0e2918f-893a-4442-bdbf-36e95ffcd4d7@collabora.com>


--xD3+S2z4fj3w0Tzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Il 23/04/24 12:16, Lorenzo Bianconi ha scritto:

[...]
> > +
> > +	err =3D airoha_snand_nfi_config(as_ctrl);
> > +	if (err)
> > +		return err;
> > +
> > +	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
> > +				   as_dev->buf_len, DMA_BIDIRECTIONAL);
> > +	mb();
>=20
> Are you sure you need this memory barrier here?
>=20
> P.S.: Just in case... any other write or read will anyway add a barrier ;=
-)
>=20

ack, I will fix it in v4.

> > +
> > +	/* set dma addr */
> > +	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
> > +			   as_dev->dma_addr);
> > +	if (err)
> > +		return err;
> > +
>=20
> ..snip..
>=20
> > +
> > +static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *d=
esc,
> > +					 u64 offs, size_t len, const void *buf)
> > +{
> > +	struct spi_device *spi =3D desc->mem->spi;
> > +	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
> > +	struct spi_mem_op *op =3D &desc->info.op_tmpl;
> > +	struct airoha_snand_ctrl *as_ctrl;
> > +	u32 wr_mode, val;
> > +	int err;
> > +
> > +	as_ctrl =3D spi_controller_get_devdata(spi->controller);
> > +	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	dma_sync_single_for_cpu(as_ctrl->dev, as_dev->dma_addr,
> > +				as_dev->buf_len, DMA_BIDIRECTIONAL);
> > +	memcpy(as_dev->txrx_buf + offs, buf, len);
> > +	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
> > +				   as_dev->buf_len, DMA_BIDIRECTIONAL);
> > +	mb();
> > +
> > +	err =3D airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D airoha_snand_nfi_config(as_ctrl);
> > +	if (err)
> > +		return err;
> > +
> > +	if (op->cmd.opcode =3D=3D SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
> > +	    op->cmd.opcode =3D=3D SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
> > +		wr_mode =3D 2;
>=20
> I'm mostly sure that this '2' is supposed to be BIT(1) instead

ack, I will fix it in v4.

>=20
> > +	else
> > +		wr_mode =3D 0;
> > +
> > +	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
> > +			   as_dev->dma_addr);
> > +	if (err)
> > +		return err;
> > +
> > +	val =3D as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
> > +	val =3D FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
>=20
> val =3D FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
>                  as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
>=20
> Being this 100 cols eventually, you wouldn't even need two lines - but
> if you don't want to go 100, it's still more readable (imo) like this,
> even if in two lines.

I prefer to be below 79 columns, so I will go for the 2 lines :)
I will fix it in v4.

>=20
> > +	err =3D regmap_update_bits(as_ctrl->regmap_nfi,
> > +				 REG_SPI_NFI_SNF_MISC_CTL2,
> > +				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
> > +			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
> > +				      op->cmd.opcode));
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
> > +			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
> > +	if (err)
> > +		return err;
> > +
>=20
> ..snip..
>=20
> > +
> > +#define SPI_NAND_CACHE_SIZE	(4096 + 256)
>=20
> #include <linux/sizes.h>      <--- at the beginning
>=20
> #define SPI_NAND_CACHE_SIZE (SZ_4K + SZ_256)
>=20
> ...there are macros for that, might as well use them, right? :-)

ack, I will fix it in v4.
>=20
> > +
> > +static int airoha_snand_setup(struct spi_device *spi)
> > +{
> > +	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
> > +	struct airoha_snand_ctrl *as_ctrl;
> > +
> > +	as_dev =3D kzalloc(sizeof(*as_dev), GFP_KERNEL);
> > +	if (!as_dev)
> > +		return -ENOMEM;
> > +
> > +	spi_set_ctldata(spi, as_dev);
> > +	as_dev->data_need_update =3D true;
> > +
> > +	/* prepare device buffer */
> > +	as_dev->buf_len =3D SPI_NAND_CACHE_SIZE;
> > +	as_dev->txrx_buf =3D kzalloc(as_dev->buf_len, GFP_KERNEL);
> > +	if (!as_dev->txrx_buf)
> > +		goto error_dev_free;
> > +
> > +	as_ctrl =3D spi_controller_get_devdata(spi->controller);
> > +	as_dev->dma_addr =3D dma_map_single(as_ctrl->dev, as_dev->txrx_buf,
> > +					  as_dev->buf_len, DMA_BIDIRECTIONAL);
> > +	if (dma_mapping_error(as_ctrl->dev, as_dev->dma_addr))
> > +		goto error_buf_free;
> > +
> > +	return 0;
> > +
> > +error_buf_free:
> > +	kfree(as_dev->txrx_buf);
> > +error_dev_free:
> > +	kfree(as_dev);
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static void airoha_snand_cleanup(struct spi_device *spi)
> > +{
> > +	struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);
> > +	struct airoha_snand_ctrl *as_ctrl;
> > +
> > +	as_ctrl =3D spi_controller_get_devdata(spi->controller);
> > +	dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
> > +			 as_dev->buf_len, DMA_BIDIRECTIONAL);
> > +	kfree(as_dev->txrx_buf);
> > +
> > +	spi_set_ctldata(spi, NULL);
> > +}
> > +
> > +static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
> > +{
> > +	u32 val, sec_size, sec_num;
> > +	int err;
> > +
> > +	err =3D regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_CON, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	sec_num =3D FIELD_GET(SPI_NFI_SEC_NUM, val);
> > +
> > +	err =3D regmap_read(as_ctrl->regmap_nfi,
> > +			  REG_SPI_NFI_SECCUS_SIZE, &val);
> > +	if (err)
> > +		return err;
> > +
> > +	sec_size =3D FIELD_GET(SPI_NFI_CUS_SEC_SIZE, val);
> > +
> > +	/* init default value */
> > +	as_ctrl->nfi_cfg.sec_size =3D sec_size;
> > +	as_ctrl->nfi_cfg.sec_num =3D sec_num;
> > +	as_ctrl->nfi_cfg.page_size =3D rounddown(sec_size * sec_num, 1024);
> > +	as_ctrl->nfi_cfg.spare_size =3D 16;
> > +
> > +	err =3D airoha_snand_nfi_init(as_ctrl);
> > +	if (err)
> > +		return err;
> > +
> > +	return airoha_snand_nfi_config(as_ctrl);
> > +}
> > +
> > +static const struct regmap_config spi_ctrl_regmap_config =3D {
> > +	.name		=3D "ctrl",
> > +	.reg_bits	=3D 32,
> > +	.val_bits	=3D 32,
> > +	.reg_stride	=3D 4,
> > +	.max_register	=3D REG_SPI_CTRL_NFI2SPI_EN,
> > +};
> > +
> > +static const struct regmap_config spi_nfi_regmap_config =3D {
> > +	.name		=3D "nfi",
> > +	.reg_bits	=3D 32,
> > +	.val_bits	=3D 32,
> > +	.reg_stride	=3D 4,
> > +	.max_register	=3D REG_SPI_NFI_SNF_NFI_CNFG,
> > +};
> > +
> > +static const struct of_device_id airoha_snand_ids[] =3D {
> > +	{ .compatible	=3D "airoha,en7581-snand" },
> > +	{ }
>=20
> { /* sentinel */ }
>=20
> ...please!

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> > +};
> > +MODULE_DEVICE_TABLE(of, airoha_snand_ids);
> > +
>=20
> Cheers,
> Angelo
>=20
>=20

--xD3+S2z4fj3w0Tzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZieVUwAKCRA6cBh0uS2t
rMlJAQCAA0+G7cCKcpjsbeX0WvsK1X8kHUgDSLBZ4G6h/gAU4gD/THAvOlgJLEuK
oKNUWuU34P1Usit4/OYjafXu6lSnrQM=
=/jLX
-----END PGP SIGNATURE-----

--xD3+S2z4fj3w0Tzy--

