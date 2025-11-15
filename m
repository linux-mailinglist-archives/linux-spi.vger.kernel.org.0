Return-Path: <linux-spi+bounces-11235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB58C6084F
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 17:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4919351DC1
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D326E6F5;
	Sat, 15 Nov 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM0DL6WI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBADD515;
	Sat, 15 Nov 2025 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763222484; cv=none; b=ctk/k84IroZKI+4UH8wf5xZMC40IHlzvNCyP6YZJ+BzuACLem62RNchAPNxAaSnlqoIbrTeeWEM9ipz23TGpTeJ+0AjsifINrlC6wKPm/hpdWoLDUpgSmyfHc4SxqALZGuSapj4wMDAvhdWO0vREniUdf0J56jSFmqqBh8AKFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763222484; c=relaxed/simple;
	bh=aL2drUjldjMwfOWSXiuQaZYAafjyhHSOp1Hy4vQYSSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM/YolpiCKWKi2d1dklAX6Fzoq4XRoobKlHnMbUJlMFzklA70ZwRRjqbmS/GpPofUUWgavlXU/Q4FEwozcxPgpvdg0Try8+iCXGaummbgAXjpterkExmvu+J4wa0CjlF2bBW++Sy250oZG3U+fXffNp4+BdRvPZnV/IbVoIUpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM0DL6WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83865C4CEF7;
	Sat, 15 Nov 2025 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763222484;
	bh=aL2drUjldjMwfOWSXiuQaZYAafjyhHSOp1Hy4vQYSSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jM0DL6WInt/lvzvDDb/SeVzLxDQcGUoVyjrmPprDnwOJcHgUeXTQeM1DbouIs1wio
	 hL2dng5a3gWtUklyuINPSrCuFJssjoDICPIXqncLAmA45aVRNFzkcv8pz6PsBHo5O3
	 RTvwAg3YVypK9v9Hj6ZSeY/haCkaGo7nA936PZlZ3jn0mRKHFKgl4KU0wHao80Eyg3
	 +vCHetJv6gQEkD+J9wH3VI/+JjpVMAVaxW/U7vrTjDIHnv11GimYMabQsuTWWIkY1o
	 71vk2Q2808sG4g4DYyjruinMlmexgA19YoSo6rvS7JkeiGSYCnEiLLTw+PvQFAU1N3
	 nR9+9uaucaA0w==
Date: Sat, 15 Nov 2025 17:01:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH 1/3] spi: airoha-snfi: en7523: workaround flash damaging
 if UART_TXD was short to GND
Message-ID: <aRijz3wMTGdmy2tq@lore-rh-laptop>
References: <20251114233431.1920015-1-mikhail.kshevetskiy@iopsys.eu>
 <20251114233431.1920015-2-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EKzBAkeZKZ1ooe9j"
Content-Disposition: inline
In-Reply-To: <20251114233431.1920015-2-mikhail.kshevetskiy@iopsys.eu>


--EKzBAkeZKZ1ooe9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> We found that some serial console may pull TX line to GROUND during board
> boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
> to booting in RESERVED boot mode.
>=20
> It was found that some flashes operates incorrectly in RESERVED mode.
> Micron and Skyhigh flashes are definitely affected by the issue,
> Winbond flashes are NOT affected.
>=20
> Details:
> --------
> DMA reading of odd pages on affected flashes operates incorrectly. Page
> reading offset (start of the page) on hardware level is replaced by 0x10.
> Thus results in incorrect data reading. Usage of UBI make things even
> worse. Any attempt to access UBI leads to ubi damaging. As result OS load=
ing
> becomes impossible.
>=20
> Non-DMA reading is OK.
>=20
> This patch detects booting in reserved mode, turn off DMA and print big
> fat warning.
>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/spi-airoha-snfi.c | 40 ++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index 8408aee9c06e..0e84a9addfa5 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_=
snand_mem_ops =3D {
>  	.dirmap_write =3D airoha_snand_dirmap_write,
>  };
> =20
> +static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops =
=3D {
> +	.supports_op =3D airoha_snand_supports_op,
> +	.exec_op =3D airoha_snand_exec_op,
> +};
> +
>  static int airoha_snand_setup(struct spi_device *spi)
>  {
>  	struct airoha_snand_ctrl *as_ctrl;
> @@ -1058,7 +1063,8 @@ static int airoha_snand_probe(struct platform_devic=
e *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct spi_controller *ctrl;
>  	void __iomem *base;
> -	int err;
> +	int err, dma_enabled;

here you can use bool for dma_enable:

	bool dma_enable =3D true;

> +	u32 sfc_strap;
> =20
>  	ctrl =3D devm_spi_alloc_host(dev, sizeof(*as_ctrl));
>  	if (!ctrl)
> @@ -1092,12 +1098,36 @@ static int airoha_snand_probe(struct platform_dev=
ice *pdev)
>  		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
>  				     "unable to get spi clk\n");
> =20
> -	err =3D dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> -	if (err)
> -		return err;
> +	dma_enabled =3D 1;
> +	if (device_is_compatible(dev, "airoha,en7523-snand")) {
> +		err =3D regmap_read(as_ctrl->regmap_ctrl,
> +				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
> +		if (err)
> +			return err;
> +
> +		if (!(sfc_strap & 0x04)) {
> +			dma_enabled =3D 0;

			dma_enable =3D false;

> +			dev_warn(dev,
> +				"=3D=3D=3D WARNING =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n"

you do not need to add "WARNING here".

> +				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
> +				"This mode is known for incorrect DMA reading of some flashes.\n"
> +				"Usage of DMA for flash operations will be disabled to prevent data\=
n"
> +				"damage. Unplug your serial console and power cycle the board\n"
> +				"to boot with full performance.\n"
> +				"=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +		}
> +	}
> +
> +	if (dma_enabled) {
> +		err =3D dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
> +		if (err)
> +			return err;
> +	}
> =20
>  	ctrl->num_chipselect =3D 2;
> -	ctrl->mem_ops =3D &airoha_snand_mem_ops;
> +	ctrl->mem_ops =3D dma_enabled ?
> +				&airoha_snand_mem_ops :
> +				&airoha_snand_nodma_mem_ops;

nit: no need to add a new-line here:

	ctrl->mem_ops =3D dma_enabled ? &airoha_snand_mem_ops
				    : &airoha_snand_nodma_mem_ops;


Regards,
Lorenzo

>  	ctrl->bits_per_word_mask =3D SPI_BPW_MASK(8);
>  	ctrl->mode_bits =3D SPI_RX_DUAL;
>  	ctrl->setup =3D airoha_snand_setup;
> --=20
> 2.51.0
>=20

--EKzBAkeZKZ1ooe9j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRijzAAKCRA6cBh0uS2t
rPpqAQCeg58jE6lmb6Y9qpYRoRN3SrKAtGS9xzuVhgfpBcZdmQEAlXeQDN+GWzjQ
94j4LASAucndNW9KD6ss5bbbiaMR6wk=
=fAZF
-----END PGP SIGNATURE-----

--EKzBAkeZKZ1ooe9j--

