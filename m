Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC598215BAE
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgGFQSP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 12:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbgGFQSP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Jul 2020 12:18:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E0D20708;
        Mon,  6 Jul 2020 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594052294;
        bh=e7QX1v2cZu5ZSZ15ZN3H645wikiq3nLGGb5SNS7ZpVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVu585+GkPv60Zfg3OgrPeismhWCEmPD1eHfRJC52g2F8CVXSXM4YQD5Tp6yvCajY
         gcEi6IYMnPDOt7TwqAM0QSIKs30A7PqlbslStHTbMgEhEjHvsxlebpH1K6g2sRX1f+
         /kh+85Hj20dV1uTkVUJsE/Rx8e4ZoYp7N6bq27JE=
Date:   Mon, 6 Jul 2020 17:18:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
Message-ID: <20200706161810.GB6176@sirena.org.uk>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
X-Cookie: You will be married within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2020 at 11:22:43AM +0200, Adrian Fiergolski wrote:

Please don't send new patches in reply to old threads, it buries them
and can be confusing.

> The implementation is transparent for the SPI devices and doesn't require
> their modifications. It is based on a virtual SPI device (spi-daisy_chain)
> and defines two required device tree properties ('spi-daisy-chain-len' and
> 'spi-daisy-chain-noop') and one optional

It would really help to have an example of how a client device will use
this, right now it's a bit hard to follow.  Overall it feels like this
should be better abstracted, right now there's lots of ifdefs throughout
the code which make things unclear and also seem like they're going to
be fragile long term since realistically very few systems will be using
this.  Perhaps this needs to be a library for devices that can daisy
chain?  It does feel like the instances should be aware of each other
since half the point with building the hardware like this is that it
enables operations on multiple devices to happen in sync.

There are also pervasive coding style issues which are really
distracting.

>  drivers/spi/spi-daisy_chain.c       | 428 ++++++++++++++++++++++++++++

Please use - and _ consistently.

> @@ -55,6 +55,14 @@ config SPI_MEM
>  	  This extension is meant to simplify interaction with SPI memories
>  	  by providing a high-level interface to send memory-like commands.
> =20
> +config SPI_DAISY_CHAIN
> +	bool "SPI daisy chain support"
> +	depends on OF

Please keep Makefile and Kconfig sorted.

> +++ b/drivers/spi/spi-daisy_chain.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * A driver handling the SPI daisy chaines.

Please make the entire comment block a C++ to make things look more
intentional.

> +	int rc;
> +
> +	//the device is not part of a daisy-chain
> +	if (spi->daisy_chain_devs =3D=3D NULL)

Coding style for the comment here and throughout the code.  If your code
doesn't visually resemble the normal coding style for the code base
you're working on then that is a bit of a red flag when reviewing.

> +	if (!list_is_singular(&message->transfers)) {
> +		dev_err(&spi->dev,
> +			"Mutliple transfer segments are not support when on daisy chain");
> +		return -EINVAL;
> +	}

That seems excessively restrictive?

> +			//check if frequency is not being changed
> +			if (tr->speed_hz && tr->speed_hz !=3D spi->max_speed_hz) {
> +				dev_err(&spi->dev,
> +					"Change of SPI frequency not supported when on daisy chain");
> +				return -EINVAL;
> +			}

Again this seems unreasonably restrictive, especially given the above
single transfer restriction which means the speed can't change during a
message?

> +			if (tr->len =3D=3D spi_chain_dev->no_operation.len) {
> +				tr->bits_per_word =3D spi_chain_dev->no_operation
> +							    .bits_per_word;
> +				tr->cs_change =3D 0;
> +
> +				list_add_tail(&tr->transfer_list,
> +					      &message->transfers);
> +			}
> +			//daisy chain operation has different than regular length
> +			else {

Coding style on both the if () and placement of the comment.

> +				//copy tx buffer
> +				if (tr->tx_buf) {
> +					ntr->tx_buf =3D
> +						kmalloc(ntr->len, GFP_KERNEL);
> +					if (!ntr->tx_buf) {
> +						rc =3D -ENOMEM;
> +						goto err_out;
> +					}

Why is this not a kmemdup()?

> +					//The daisy-chain padding is assumed to be right-justified,
> +					//so unused tx bits are transferred first
> +					memcpy((void *)((char *)ntr->tx_buf +
> +							ntr->len - tr->len),
> +					       tr->tx_buf, tr->len);

These casts shouldn't be needed, especially the cast to void * - if you
need to cast to void * something bad is most likely happening.  Simiar
issues apply in other places where you're casting.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8DTsEACgkQJNaLcl1U
h9A9GQf+PnOeur2uHEHqKLk/2qRct2ot5asMktV8CLeWeWzdKCdWgbdjYkhhT+Vn
MTgjEf3xIGVMHoJGta1bFx/F/Uos/EqJAUmaXOAY2wRhzMzXFotc8i+obilvAwXf
cgk32FTSOiwg14PuGjndRlvcfmSuZeiqeCucaRdPMxkqMQ9LT0x0aGVHGetrlPFI
qiP1kgtM0Q0l91etZ2d1twBvrxya2xusRjVDYQV5wupfxwuIC+s/aTA/i30VRHQr
LoD4CO/uQaCtrF9v+QtOUcXJ906F/hi28J593t7GAe1EwE5/cpxK8xtoCrwfzDQ1
sAjXQ9mNPAi88WfggVX+655ocGylKA==
=/5Y1
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
