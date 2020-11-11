Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B0F2AF0AD
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKMdo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 07:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgKKMdo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 07:33:44 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B128D20709;
        Wed, 11 Nov 2020 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605098023;
        bh=ZYiBC0YrninJE98s5Zgaav4ZW54I6qKZUYUtc6gbFsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsnCrTS2BqQQc9PWMPmbtfDDirkacuqed7ivpqsXBk7QJBOChsvBxIDxn4mpmzTc8
         ItNH1tAFYDFydDP/RO1cYyq2P3wzbtF/QF4rPwqkSPxVSGNUSnj1qxtzqGKGRFDMrq
         6qh+y9ofPbC1yRguibnDZPm0Wr1908/ygDhqxRYo=
Date:   Wed, 11 Nov 2020 12:33:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
Message-ID: <20201111123327.GB4847@sirena.org.uk>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
X-Cookie: I'm not available for comment..
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2020 at 02:05:19AM +0100, Linus Walleij wrote:
> On Mon, Nov 9, 2020 at 3:41 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> > I don't disagree. Fact is that after the imx cspi bus driver was converted
> > to gpio descriptors, most spi client drivers broke. It would be great if this
> > could be fixed. Any method that the community can find a consensus on,
> > would be great :)

> I think your patch is the quick fix.

> I would say that anything that has:

> spi->mode = ...

> is essentially broken.

This is not clear to me, most of these settings are things that are
constant for the device so it's not clear that they should be being set
by the device tree in the first place.  The idea that the chip select
might be being inverted like it is by this whole gpiolib/DT/new binding
thing is breaking expectations too.

> The core sets up vital things in .mode from e.g. device tree in
> of_spi_parse_dt():

>         /* Mode (clock phase/polarity/etc.) */
>         if (of_property_read_bool(nc, "spi-cpha"))
>                 spi->mode |= SPI_CPHA;
>         if (of_property_read_bool(nc, "spi-cpol"))
>                 spi->mode |= SPI_CPOL;
>         if (of_property_read_bool(nc, "spi-3wire"))
>                 spi->mode |= SPI_3WIRE;
>         if (of_property_read_bool(nc, "spi-lsb-first"))
>                 spi->mode |= SPI_LSB_FIRST;
>         if (of_property_read_bool(nc, "spi-cs-high"))
>                 spi->mode |= SPI_CS_HIGH;

> All this gets overwritten and ignored when a client just assigns mode
> like that. Not just SPI_CS_HIGH. I doubt things are different
> with ACPI.

OTOH most of these are things the device driver should just get right
without needing any input from DT, there's a few where there's plausible
options (eg, you can imagine pin strap configuration for 3 wire mode)
so generally it's not clear how many of these make sense for anything
other than spidev.  This binding all predates my involvement so I don't
know the thought process here.

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+r2hYACgkQJNaLcl1U
h9DTWgf+MQUdmL9lgsVd+Jaqdv+8dJmFHJArfbBVRKXrwDvdWXk4clNSEeuiL+7+
0Tvp/X0/Z5Dsue2uKmfAqkrgluuXRd8vR3fkrKNRrwIPafh0ohWbQz/DheSw7h2A
CfL5A5Hhn8lNH5RvcAKWQW52YWd9N4jWPqW9t8XAd/ENPtNBVNg2SLBD508KjCL3
vT8XF8/gr77mwrQzWzPEE/SSYcYov+49jPVuyQlqzYAt3Mt8NIoX4QdRYVj2/VSt
SCg70Cq0xZPcM9JUsz5ZVQpkrhG66vK7qjAWbvzPZk/vp/DuR2uuY0hKzEflw+W+
aGPBzJTNTN31uQQ97MSlkeRpwJTeRg==
=e49X
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
