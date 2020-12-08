Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58D42D2C6D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgLHN5b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 08:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbgLHN5b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 08:57:31 -0500
Date:   Tue, 8 Dec 2020 13:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607435810;
        bh=r+SNDjdn1cT+19+hYK3dnLdSKkvOwWFHhZnR6xbs9b4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEU6PrMiyN6gfVyUTtAY/XV2HMYTkelCmMBqubxCwtCpAQAXVCG2GqWZbATIlW1y2
         tYPwqdXR4ap+x8XbgCT43+vW/isxYFykdEpPinmVsfsfREURAaps9sNPy96G+H88QX
         JGqWUy0BAE97QyipEjxygtNvXYrAnIEKnJt3YKVTyQXUuY9hb3dTuQ3MmlTv9LdLQl
         00/IOFheqyhRmQROS2saMaboz9xGgievUiZj06fHP26iRGYOaeJGwydys5T8cKaY3c
         x2HYpR0PK94eVx/oxF6XP7HVMawe59nIAK3TuDa0W6SHrad7J3i9IWqKbpTSpN9Bs4
         4CyXFYa/9oGkg==
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
Subject: Re: [PATCH v2 1/4] spi: LS7A: Add Loongson LS7A SPI controller
 driver support
Message-ID: <20201208135644.GC6686@sirena.org.uk>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 03:44:24PM +0800, Qing Zhang wrote:

> v2:
> - keep Kconfig and Makefile sorted
> - make the entire comment a C++ one so things look more intentional

You say this but...

> +++ b/drivers/spi/spi-ls7a.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Loongson LS7A SPI Controller driver
> + *
> + * Copyright (C) 2020 Loongson Technology Corporation Limited
> + */

=2E..this is still a mix of C and C++ comments?

> +static int set_cs(struct ls7a_spi *ls7a_spi, struct spi_device  *spi, in=
t val)
> +{
> +	int cs =3D ls7a_spi_read_reg(ls7a_spi, SFCS) & ~(0x11 << spi->chip_sele=
ct);
> +
> +	if (spi->mode  & SPI_CS_HIGH)
> +		val =3D !val;
> +	ls7a_spi_write_reg(ls7a_spi, SFCS,
> +		(val ? (0x11 << spi->chip_select):(0x1 << spi->chip_select)) | cs);
> +
> +	return 0;
> +}

Why not just expose this to the core and let it handle things? =20

Please also write normal conditional statements to improve legibility.
There's quite a lot of coding style issues in this with things like
missing spaces=20

> +	if (t) {
> +		hz =3D t->speed_hz;
> +		if (!hz)
> +			hz =3D spi->max_speed_hz;
> +	} else
> +		hz =3D spi->max_speed_hz;

If one branch of the conditional has braces please use them on both to
improve legibility.

> +static int  ls7a_spi_transfer_one_message(struct spi_master *master,
> +                                         struct spi_message *m)

I don't understand why the driver is implementing transfer_one_message()
- it looks like this is just open coding the standard loop that the
framework provides and should just be using transfer_one().

> +		r =3D ls7a_spi_write_read(spi, t);
> +		if (r < 0) {
> +			status =3D r;
> +			goto error;
> +			}

The indentation here isn't following the kernel coding style.

> +	master =3D spi_alloc_master(&pdev->dev, sizeof(struct ls7a_spi));
> +	if (!master)
> +		return -ENOMEM;

Why not use devm_ here?

> +	ret =3D devm_spi_register_master(dev, master);
> +	if (ret)
> +		goto err_free_master;

The driver uses devm_spi_register_master() here but...

> +static void ls7a_spi_pci_remove(struct pci_dev *pdev)
> +{
> +	struct spi_master *master =3D pci_get_drvdata(pdev);
> +	struct ls7a_spi *spi;
> +
> +	spi =3D spi_master_get_devdata(master);
> +	if (!spi)
> +		return;
> +
> +	pci_release_regions(pdev);

=2E..releases the PCI regions in the remove() function before the SPI
controller is freed so the controller could still be active.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PhhsACgkQJNaLcl1U
h9DApAf9FL27ZdJ5EY5dvTCrBunyvu4kKI1aW2smyMKHDqAMCdh/Bx13j76pLcJN
o3fc67vf4TtI4B8m1IExFSXuZLDlERimQplJSh1eG5KYm+em4ryKK1fDHM6+Rdl0
kpu946yiVUJ7hF8zFyJof1dgiwrWY7hOsmbhPi3fGCFDqQpx3Pi9+tmUUVj9YgCa
5ZyVOZH5q88ShNcmCkAvZbK9/9f/nYB9+t6575rvbQlCH6pbGcwoEGuqJ/V0IsFS
PKqJiP/X9/f5rfb0SNe2HNV6WExewivMg2YnUOEldPNh2NNGx4o2VJaLOPlm9iTz
8pjE5qTLBCCQeROluQCMEwm2cPf0EQ==
=xEfq
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
