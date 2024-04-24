Return-Path: <linux-spi+bounces-2481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F68B06ED
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4433AB21615
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F51591E7;
	Wed, 24 Apr 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiDwIAW3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E281E898;
	Wed, 24 Apr 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953222; cv=none; b=ueJEToqHhuTyx+3xCB94crGGKVGq6vQXJCkD+46J1kR7C7F+6fT65OpgPShy/wrqq1+2Ctxd+Itr28Pah/qxxNk3U3gfH/SqVPXkQ8Wb7RNXLPxBCOnDT+fvI5Dn7upizJa/rC7LZpKJsBi8dJh6SCOqhqXYMs1jk8lpVk8u6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953222; c=relaxed/simple;
	bh=lcprqEVEzW3iu3ocOkKV3ohOpSAojzCuNBtk3GbwxFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcek/pyS617H6PrkUoIU4dzI/YCIUjE5CNC0gi4VzAUyc6b4D/V6SS8pyu7JHeks/Pg5+nud6OZq4QJalXb/kYLpeaoIo25JZtaZuRvFv3OqbIlEU6i3FlQh+juZpPVF8Q4jtIfK9cyMf5BwkfuBtsfABKnxuOry7Ev/Uo3JWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiDwIAW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0942FC32781;
	Wed, 24 Apr 2024 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713953221;
	bh=lcprqEVEzW3iu3ocOkKV3ohOpSAojzCuNBtk3GbwxFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiDwIAW3tE6sA1oRSiud+8iWoo/KBNgCpXJgpgJ8QM+O1/s5fueVGzKydSBxk2503
	 dGVNZfsWqTM+q0d5ASq+8xrU3EaYWIjCkCiTeYuKPCjlEcC3CClVBkvPwwLwvnwITI
	 zHS/LdpfNCOZXDgGlLo2gEy+7fR2cLLo+Mx+2CgiEKoSxspfm2IlXLDnvUCLDspbuc
	 SacgsPff7Ng2yFl2oPxDJgzqVBEaFK9AAAVQAjM8+EFkzn6UXv8B8lIQD4pIaLSoYq
	 E2aBZZTtEsKS1cFP04dandOsDjS9EmyiZZZOvWGDxOt43/3Abt7mNTMu/9Z8NklS0I
	 /ocoGs0s1Jibw==
Date: Wed, 24 Apr 2024 12:06:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 3/3] spi: airoha: add SPI-NAND Flash controller driver
Message-ID: <ZijZwXCHbaSEyAQL@lore-desk>
References: <cover.1713866770.git.lorenzo@kernel.org>
 <497dc9dad823fcd1403ed62ba164dd7d70f31f90.1713866770.git.lorenzo@kernel.org>
 <ZihJfcmjoJZwLofz@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umOIcdKBm4RR8aek"
Content-Disposition: inline
In-Reply-To: <ZihJfcmjoJZwLofz@surfacebook.localdomain>


--umOIcdKBm4RR8aek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Tue, Apr 23, 2024 at 12:16:37PM +0200, Lorenzo Bianconi kirjoitti:
> > Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> > found on Airoha ARM SoCs.
>=20
> ...
>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/init.h>
> > +#include <linux/iopoll.h>
>=20
> > +#include <linux/kernel.h>
>=20
> Make sure you are using exact headers you need, this one seems "proxy" an=
d not
> really in use here.
>=20
> (Quite likely you wanted minmax.h, types.h, and possible others.)

ack, I will fix it.

>=20
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/spi-mem.h>
>=20
> ...
>=20
> > +#define SPI_NFI_ALL_IRQ_EN			(SPI_NFI_RD_DONE_EN | \
> > +						 SPI_NFI_WR_DONE_EN | \
> > +						 SPI_NFI_RST_DONE_EN | \
> > +						 SPI_NFI_ERASE_DONE_EN | \
> > +						 SPI_NFI_BUSY_RETURN_EN | \
> > +						 SPI_NFI_ACCESS_LOCK_EN | \
> > +						 SPI_NFI_AHB_DONE_EN)
>=20
> What about writing this as
>=20
> #define SPI_NFI_ALL_IRQ_EN					\
> 	(SPI_NFI_RD_DONE_EN | SPI_NFI_WR_DONE_EN |		\
> 	 SPI_NFI_RST_DONE_EN | SPI_NFI_ERASE_DONE_EN |		\
> 	 SPI_NFI_BUSY_RETURN_EN | SPI_NFI_ACCESS_LOCK_EN |	\
> 	 SPI_NFI_AHB_DONE_EN)
>=20
> ?

no strong opinion about it, I will fix it.

>=20
> ...
>=20
> > +enum airoha_snand_mode {
> > +	SPI_MODE_AUTO,
> > +	SPI_MODE_MANUAL,
> > +	SPI_MODE_DMA,
> > +	SPI_MODE_NO
>=20
> Is _NO a termination entry? Meaning there always be only 3 modes no matter
> what. If not, leave the trailing comma as it helps to reduce a burden in =
case
> this list will be expanded.

I think we can get rid of it

>=20
> > +};
>=20
> ...
>=20
> > +struct airoha_snand_dev {
> > +	size_t buf_len;
> > +
> > +	u8 *txrx_buf;
> > +	dma_addr_t dma_addr;
> > +
> > +	bool data_need_update;
> > +	u64 cur_page_num;
> > +};
>=20
> Most likely `pahole` shows better layout to save a few bytes in some case=
s.

ack, I think we can swap data_need_update and cur_page_num.

>=20
> ...
>=20
> > +struct airoha_snand_ctrl {
> > +	struct device *dev;
> > +	struct regmap *regmap_ctrl;
> > +	struct regmap *regmap_nfi;
> > +	struct clk *spi_clk;
> > +
> > +	struct {
> > +		size_t page_size;
> > +		size_t sec_size;
>=20
> > +		unsigned char sec_num;
> > +		unsigned char spare_size;
>=20
> Hmm... Why not u8 for both of these?

ack, I will fix it.

>=20
> > +	} nfi_cfg;
> > +};
>=20
> ...
>=20
> > +static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, =
u8 cmd,
> > +				   const u8 *data, int len)
> > +{
> > +	int i =3D 0;
> > +
> > +	while (i < len) {
>=20
> Seems nothing prevents you from using for-loop here as well.

ack, I will fix it.

>=20
> > +		int data_len =3D min(len, MAX_TRANSFER_SIZE);
> > +		int err;
> > +
> > +		err =3D airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
> > +		if (err)
> > +			return err;
> > +
> > +		err =3D airoha_snand_write_data_to_fifo(as_ctrl, &data[i],
> > +						      data_len);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		i +=3D data_len;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u=
8 *data,
> > +				  int len)
>=20
> As per above.

ack, I will fix it.

>=20
> ...
>=20
> > +	/* addr part */
> > +	for (i =3D 0; i < op->addr.nbytes; i++) {
> > +		u8 cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> > +
> > +		data =3D op->addr.val >> ((op->addr.nbytes - i - 1) * 8);
>=20
> Seems like you wanted to have always the same endianess and hence can be =
done
> outside the loop via cpu_to_xxx()?

sorry, I did not get what you mean here, data value relies on the loop
iteration.

>=20
> > +		err =3D airoha_snand_write_data(as_ctrl, cmd, &data,
> > +					      sizeof(data));
> > +		if (err)
> > +			return err;
> > +	}
>=20
> ...
>=20
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
>=20
> Why not utilising cleanup.h? (__free(), no_free_ptr(), etc)

I guess we can just allocate as_dev and as_dev->txrx_buf with devm_kzalloc()
here, agree?

>=20
> > +	return -EINVAL;
> > +}
>=20
> ...
>=20
> > +	err =3D regmap_read(as_ctrl->regmap_nfi,
> > +			  REG_SPI_NFI_SECCUS_SIZE, &val);
>=20
> One line?

ack, I will fix it.

>=20
> > +	if (err)
> > +		return err;
>=20
> ...
>=20
> > +	as_ctrl->nfi_cfg.page_size =3D rounddown(sec_size * sec_num, 1024);
>=20
> round_down() is optimised for power-of-2.
> You would need to include math.h IIRC.

ack, I will fix it.
>=20
> ...
>=20
> > +	as_ctrl->regmap_ctrl =3D devm_regmap_init_mmio(&pdev->dev, base,
> > +						     &spi_ctrl_regmap_config);
>=20
> With help of
>=20
> 	struct device *dev =3D &pdev->dev;
>=20
> at the top of the function the entire code will become neater.

ack, I will fix it.

>=20
> > +	if (IS_ERR(as_ctrl->regmap_ctrl)) {
> > +		dev_err(&pdev->dev, "failed to init spi ctrl regmap: %ld\n",
> > +			PTR_ERR(as_ctrl->regmap_ctrl));
> > +		return PTR_ERR(as_ctrl->regmap_ctrl);
>=20
> 		return dev_err_probe(...);
>=20
> > +	}
>=20
> ...
>=20
> > +		dev_err(&pdev->dev, "failed to init spi nfi regmap: %ld\n",
> > +			PTR_ERR(as_ctrl->regmap_nfi));
> > +		return PTR_ERR(as_ctrl->regmap_nfi);
>=20
> 		return dev_err_probe(...);
>=20
> ...
>=20
> > +		dev_err(&pdev->dev, "unable to get spi clk");
> > +		return PTR_ERR(as_ctrl->spi_clk);
>=20
> Ditto.
>=20
> ...
>=20
> > +
>=20
> Unneeded blank line.

ack, I will fix it.

Regards,
Lorenzo

>=20
> > +module_platform_driver(airoha_snand_driver);
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20
>=20

--umOIcdKBm4RR8aek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZijZwQAKCRA6cBh0uS2t
rHuXAQDBO0OWmHJYmGuZQJc7/PNZ3Bwja96sdFB6PkKcaUmzjgEAmOezyM5O4C1n
ApVbBms5kmd1DFdgaiixkbwMePckygI=
=HM0W
-----END PGP SIGNATURE-----

--umOIcdKBm4RR8aek--

