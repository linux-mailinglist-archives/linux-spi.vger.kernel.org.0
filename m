Return-Path: <linux-spi+bounces-7167-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F8A65248
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10533ACF33
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2823DE85;
	Mon, 17 Mar 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiE1zWrh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC322759C;
	Mon, 17 Mar 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220366; cv=none; b=HBOjmnP6pwblkyoDdo237bfFMGdtlVnfTLj/B+SybYYuBVuL269tv1K6TkcKOkdz7/XDMAR6uKM18u7U8VTNDFIX+UT4aArAicioYBkkdA3UH/J087OrokcEeENqsb1Ac8t3goVekJ+YdTHzQKxQU1aUlxZCbfWMRV0cJ3Pv2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220366; c=relaxed/simple;
	bh=eLH32FMzkPLJk3sk0cW1wEKTH92IZIBRoZQnyhh397g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrwidtuc4Xmo5YCRhO+EP2TAYGgkCl0KNFaG/WIsQAydrslmc2cR6Xro2CO6a2OuOCRqsFHi0vgOu/mlKP5Ti4zsNwl2MXfzhLWlE+qwAMu0u+x1mjmN4LoSltsysxXteSO/VqbP3mi+plzmwPNe6PnV45Ub8lEqKxomNE9DeLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiE1zWrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BC3C4CEE3;
	Mon, 17 Mar 2025 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742220365;
	bh=eLH32FMzkPLJk3sk0cW1wEKTH92IZIBRoZQnyhh397g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiE1zWrhqyJl1WfbXiV9GE0f2l8jjNdUXEvSo9+LKCgY/NBqUGRAL1tmjAVuQYKx/
	 +h66JauWprE0JW4NGqbpfhnvj8/ZzOHaSnnK40zK4TmzakJVVEgMyOcoYB8jBeI5Dl
	 /lZeF0lFXBQ79fATJn0VAtFLYXSPqLtwcEfQx84yCF8OT0Z5h0oCAiEb+Vg7z0yFLz
	 BFk7nVrfT4ml3nYZ9U/cSzrwDhvvwtdhNlu2mIULA/3CbIFC4N8MYeGyRfcqUPy9WY
	 iWq0TFHzThgVb/K889RFCObY4xQfwOQkNN6FlzFn2bjpbOviuJS3XeA37d+TjER7SB
	 vOEjVQf3Jh47A==
Date: Mon, 17 Mar 2025 14:06:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
Subject: Re: [PATCH 01/10] spi: espi_amd: Add AMD eSPI controller driver
 support
Message-ID: <311453e6-c3a0-4976-92aa-e3961485b9ab@sirena.org.uk>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <20250313183440.261872-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+DVoHDKHv2yRx0ee"
Content-Disposition: inline
In-Reply-To: <20250313183440.261872-2-Raju.Rangoju@amd.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--+DVoHDKHv2yRx0ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:04:31AM +0530, Raju Rangoju wrote:

> @@ -159,6 +159,8 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+=3D spi-xtensa-xtfp=
ga.o
>  obj-$(CONFIG_SPI_ZYNQ_QSPI)		+=3D spi-zynq-qspi.o
>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+=3D spi-zynqmp-gqspi.o
>  obj-$(CONFIG_SPI_AMD)			+=3D spi-amd.o
> +obj-$(CONFIG_SPI_AMD_ESPI)		+=3D espi-amd.o
> +espi-amd-objs				:=3D espi-amd-core.o espi-amd-dev.o
> =20

Please keep these files sorted.

> @@ -0,0 +1,883 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD eSPI controller driver

Please make the entire comment block a C++ one to make things look more
consistent.

> + *
> + * Copyright (c) 2025, Advanced Micro Devices, Inc.
> + * All Rights Reserved.

Are you sure?

> +static int amd_espi_check_error_status(struct amd_espi *amd_espi, u32 st=
atus)
> +{
> +	int ret =3D CB_SUCCESS;
> +
> +	if (!(status & ESPI_DNCMD_INT)) {
> +		ret =3D  ESPI_DNCMD_INT;
> +		dev_err(amd_espi->dev, "eSPI downstream command completion failure\n");
> +	} else if (status & ESPI_BUS_ERR_INT) {
> +		ret =3D ESPI_BUS_ERR_INT;
> +		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_BUS_TIMING]);

Can we really only have one error flagged at once?  The whole
espi_error_codes thing also seems like unneeded complexity and fagility,
this function is the only place they're used and there's nothing
ensuring that the defines for indexing into the array have anything to
do with the strings in there.

> +int amd_espi_set_iomode(struct amd_espi *amd_espi, u32 *slave_config, u3=
2 *ctrlr_config,
> +			u8 io_mode)
> +{
> +	struct espi_master *master =3D amd_espi->master;

There's a lot of outdated terminology like this in the driver - while
sometimes it's unavoidable due to the register map it's better to use
more modern terms like controller and device when it's just pure
software things.

> +	ret =3D amd_espi_get_config(amd_espi, ESPI_SLAVE_PERIPH_CFG, &slave_con=
fig);
> +	if (ret !=3D CB_SUCCESS)
> +		return ret;
> +
> +	/* Check if PC is already enabled */
> +	if (slave_config & ESPI_SLAVE_CHANNEL_ENABLE)
> +		return CB_SUCCESS;

Is there any great reason to use these non-standard CB_ return codes?

> +static int amd_espi_suspend(struct device *dev)
> +{
> +	return 0;
> +}

Remove empty functions, if they can safely be empty the functions will
be optional.

> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EOPNOTSUPP;
> +
> +	amd_espi->io_remap_addr =3D devm_ioremap_resource(dev, res);

dev_platform_get_and_ioremap_resource().

> +	amd_espi_control_reg_init(amd_espi);
> +	ret =3D amd_espi_init_slave(amd_espi);
> +	if (ret !=3D CB_SUCCESS)
> +		goto espidev_free;
> +
> +	dev_info(dev, "AMD ESPI device initialization completed\n");

This is just noise, remove it.

> +
> +	return 0;
> +
> +espidev_free:
> +	amd_espi_device_remove(amd_espi);
> +	return ret;

This will return your non-standard error codes to generic code.

> +static void amd_espi_remove(struct platform_device *pdev)
> +{
> +	struct amd_espi *amd_espi =3D platform_get_drvdata(pdev);
> +
> +	amd_espi_device_remove(amd_espi);
> +}

There's no need for this wrapper function, there's exactly one place we
can call remove from.

> +static int amd_espi_open(struct inode *inode, struct file *filp)
> +{
> +	struct amd_espi *espi;
> +	int status =3D -ENXIO;
> +
> +	guard(mutex)(&device_list_lock);

Whatever this userspace ABI is for it should be added in a separate
patch, most likely it shouldn't be here at all and standard interfaces
should be used.  Currently it doesn't seem to actually do anything.

--+DVoHDKHv2yRx0ee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYLEgACgkQJNaLcl1U
h9CQMgf+MuVrwpP5VDKerTkKoiMKm4AAh2qTI5SqWPThMS4Y2va74wQv7nj7hc1z
UtwNZbixn/Ku7IkeIiDN3QZTNetPH6cijzDdhpDj2KXYl0K/MJ4XVbF7FhMn7JAr
G+nuQsZ6TCaL0IZfDSD86zyHTMUyI3SZQqNwEQzKskS+VkBVk4ZhXexjaGlL1y/Y
B58kpzdoTrXYC46To67Fq59XoJ7L2wVVysC56tYarYgZlQZxfb46hXzJG44qk+q5
h1RhdAGqkR/hcQhOg5+q72hI2Ogcu01PQmJdjNAXu2JBmZUTLo10yMaOQgyAuGva
Wh9OIW1bMKvDPfIl8gh7eQa0hQ/1tg==
=iHhC
-----END PGP SIGNATURE-----

--+DVoHDKHv2yRx0ee--

