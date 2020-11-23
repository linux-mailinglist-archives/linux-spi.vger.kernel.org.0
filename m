Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF52C09B9
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 14:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbgKWNKs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 08:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732718AbgKWNKr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 08:10:47 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1DA20782;
        Mon, 23 Nov 2020 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606137046;
        bh=IK8iGoBaaPTZaTeG35tJXRdHCQ/+tEeL55PsyX83ECs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khzvEGIuZBik9TXnF5/42sz0ds1J1ypvdVO9AKoxkwv4PiBafMg6dXtsclzd5TAiW
         N9O/v4JBRkJTn9qT8BpjpVsTewGIEXb2pRyfBk2ga08KgcxJMmKjicpf6p2pG03/Sy
         TPK4drnlyONXMNRHa1Ev+smrdTvRnWosC7JagZFQ=
Date:   Mon, 23 Nov 2020 13:10:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/3] spi: Loongson: Add Loongson 3A+7A SPI controller
 driver support
Message-ID: <20201123131023.GC6322@sirena.org.uk>
References: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 05:19:06PM +0800, Qing Zhang wrote:

> This module is integrated into the Loongson-3A SoC and the LS7A bridge ch=
ip.

It looks like this needs quite a bit of update to fit into the SPI
subsystem properly, fortunately most of that is cutting code out of the
driver so you can use core features so it shouldn't be too bad.  There's
also a bunch of pretty minor stylistic issues none of which look too
difficult to address.

> @@ -968,6 +968,12 @@ config SPI_AMD
>  	help
>  	  Enables SPI controller driver for AMD SoC.
> =20
> +config SPI_LOONGSON
> +        tristate "Loongson SPI Controller Support"

Please keep Kconfig and Makefile sorted.

> +        depends on CPU_LOONGSON32 || CPU_LOONGSON64

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Loongson3A+7A SPI driver
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +#include <linux/pci.h>
> +#include <linux/of.h>
> +/*define spi register */
> +#define	SPCR	0x00

Missing blank line.

> +#define	SPSR	0x01
> +#define FIFO	0x02

This indentation is unclear, also all these defines could use some
namespacing to avoid collisions with anything that gets defined in a
header.

> +	hz  =3D t ? t->speed_hz : spi->max_speed_hz;
> +
> +	if (!hz)
> +		hz =3D spi->max_speed_hz;

Please write normal conditional statements to improve legibility, and
note that the core will ensure that the transfer always has a speed set.

> +	if ((hz && loongson_spi->hz !=3D hz) || ((spi->mode ^ loongson_spi->mod=
e) & (SPI_CPOL | SPI_CPHA))) {

Please try to keep your lines less than 80 columns (there's not a hard
limit here but it helps legibility).

> +		bit =3D fls(div) - 1;
> +		if ((1<<bit) =3D=3D div)

1 << bit

> +static int loongson_spi_setup(struct spi_device *spi)
> +{
> +	struct loongson_spi *loongson_spi;
> +
> +	loongson_spi =3D spi_master_get_devdata(spi->master);
> +	if (spi->bits_per_word % 8)
> +		return -EINVAL;
> +
> +	if (spi->chip_select >=3D spi->master->num_chipselect)
> +		return -EINVAL;
> +
> +	loongson_spi_update_state(loongson_spi, spi, NULL);

> +	set_cs(loongson_spi, spi, 1);

The setup() operation shouldn't configure the physical controller state
unless there are separate configuration registers per chip select -
another device could be active when setup() is called.


> +static int loongson_spi_write_read_8bit(struct spi_device *spi,
> +		const u8 **tx_buf, u8 **rx_buf, unsigned int num)
> +{
> +	struct loongson_spi *loongson_spi;
> +	loongson_spi =3D spi_master_get_devdata(spi->master);
> +
> +	if (tx_buf && *tx_buf) {
> +		loongson_spi_write_reg(loongson_spi, FIFO, *((*tx_buf)++));
> +		while ((loongson_spi_read_reg(loongson_spi, SPSR) & 0x1) =3D=3D 1);
> +        } else {
> +		loongson_spi_write_reg(loongson_spi, FIFO, 0);
> +		while ((loongson_spi_read_reg(loongson_spi, SPSR) & 0x1) =3D=3D 1);
> +        }

The indentation is messed up here, looks like you have some kind of
tab/space confusion.

> +	count =3D xfer->len;
> +
> +	do {
> +		if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
> +			goto out;

This is the only caller of _write_read_8bit(), may sa well inline it?

> +static inline int set_cs(struct loongson_spi *loongson_spi, struct spi_d=
evice  *spi, int val)

Why is this static inline?  This should be an operation provided to the
SPI core.

> +{
> +	int cs =3D loongson_spi_read_reg(loongson_spi, SFCS) & ~(0x11 << spi->c=
hip_select);
> +
> +        if (spi->mode  & SPI_CS_HIGH)
> +		val =3D !val;
> +	loongson_spi_write_reg(loongson_spi, SFCS,
> +                        (val ? (0x11 << spi->chip_select):(0x1 << spi->c=
hip_select)) | cs);

There's mult

> +static void loongson_spi_work(struct work_struct *work)
> +{

Drivers shouldn't be open coding a message queue, implement
transfer_one_message() and let the core handle it for you.

> +static const struct of_device_id loongson_spi_id_table[] =3D {
> +	{ .compatible =3D "loongson,loongson-spi", },
> +	{ },
> +};

This is introducing a new DT binding, there should also be a new binding
document added.

> +static int loongson_spi_pci_register(struct pci_dev *pdev,
> +		const struct pci_device_id *ent)
> +{
> +	int ret;
> +	unsigned char v8;

I would expect the PCI device to be a separate module with a dependency
on PCI, I'm kind of surprised that this builds on !PCI systems but I
guess it's possible there's stubs.

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+7tL4ACgkQJNaLcl1U
h9Dp6wf+LS5rzWonzfdI46UmU1mp1V9cDVLM3skheEP4YYLevRPl1G2Sz27sqMuN
dIZZcGnaQ2285+0FPe1o+dudIYoWWUhVsSbftToxet3WxfWFre01QZTXiS0H1lOJ
FWCb0cgJhc5nLj9SPJeXEUvtgqcLEjWfnOgAknpfdsE7kvHEkZ0kEd8Hzac4oAyC
t3RIVuMJInTwNTf/l6qY1h3WjTrrz9gq9Z5oIomXOhTFXGEL8O2hNhSzmXtVrE8J
PeEJcwe3aQbV34qnNbxTT+hgPlwTcEis0/KeAbaSFsv5R+OS4mwW+za8iJ67B0gN
5BIWFNplE8NF/5LdgCQdoaWPpHqRTA==
=j5jz
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
