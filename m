Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA91D7C9C
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgERPTu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 11:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgERPTu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 11:19:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1018B206D4;
        Mon, 18 May 2020 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589815189;
        bh=i/uWrEbUQkMdJDqHKyqNBwxmclbKqwRE5K2Wh7sf3lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t//bgbOQF9M1/ae3klRD3yxL1s9QbAkBG0BDAyMMgG8u0T7F6ku9A3ZPEPbEbnHUn
         dQkx7u0efp+QbCYfjXcwyNKBkgEPCNdwAtHe7bPX5Fybgy1OVDEVN3HweiXKgjaTHk
         zSqjweZIDonDMPVvJ9OsrFxSO+0zupzkCzFfuWGc=
Date:   Mon, 18 May 2020 16:19:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200518151946.GH8699@sirena.org.uk>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
 <20200510002039.hwahqasnnceowskz@mobilestation>
 <20200511212506.GA23852@sirena.org.uk>
 <20200518000542.ohtpem3lo2pbixbu@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Content-Disposition: inline
In-Reply-To: <20200518000542.ohtpem3lo2pbixbu@mobilestation>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 03:05:42AM +0300, Serge Semin wrote:
> On Mon, May 11, 2020 at 10:25:06PM +0100, Mark Brown wrote:

> > Yes, some flags should work here - the issue was that at least some
> > controllers may end up trying to do multiple SPI operations for one
> > spi-mem thing which will break if the chip select doesn't get changed to
> > correspond with what's going on.

> Ok. New SPI flag it is then. It will be something like this:
> + #define SPI_CONTROLLER_FLASH_SS		BIT(6)

I'd rather use CS than SS (it's more common in the code).

> So, what do you think?

Should be fine, controllers that have an issue implementing just
shouldn't set the flag.

> > > > It's not clear to me that this hardware actually supports spi_mem in
> > > > hardware?

> > > SPI-mem operations are implemented by means of the EEPROM-read and Tx=
-only
> > > modes of the controller.

> > Sure, but those seem like normal SPI-level things rather than cases
> > where the hardware understands that it has a flash attached and is doing
> > flash specific things.

> No, hardware can't detect whether the flash is attached. This must be def=
ined by
> the platform, like based on the DT sub-nodes.

This isn't about autodetection, it's about the abstraction level the
hardware is operating on - some hardware is able to generate flash
operations by itself (possibly with some help programming the opcodes
that are needed by a given flash), some hardware just works at the
bytestream level.

> > A very common case for this stuff is that
> > controllers have acceleration blocks for read and fall back on normal
> > SPI for writes and erases, that sounds like what's going on here.
>=20
> Well, yeah, they do provide some acceleration. EEPROM-read provides autom=
atic
> write-cmd-dummy-data-then-read operations. But in this case the only thin=
g we
> have to push into the SPI Tx FIFO is command and dummy bytes. The read op=
eration

So it's a write then read but you have to program the write each time?

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Cp5IACgkQJNaLcl1U
h9CR+Qf9Ev6BSwOliLPeSLEND0J+GE/EF79DjdkufAO8e0ZfgAdIei5Jv7llRtTz
ncbHQRBfSbB688/lo5AxDfB8StOMxBbCSLjxss4hLNNyaJio4JsaMLR0HwVKlUFz
xg0KSY2wlhn4sveDiMldv69WVXzQMWI+Lq7Anjvjjaqb4IFU9JPNJtnJl5HOsUZE
XrflFyIycmMwS21PAHWlDoG6NLnQ3P6Ko2BkwlbsJZh8dhcxUc8tdQGcTd2OoeeE
BLXSqaEMqBrEFf3p9vJ7iDOy33fH6iNwVF05Z3E/Zz5080k9bLzqJtpViHS9NDp2
hfwjgB8qPJdtkJIagGX/nSbXgACk0Q==
=Vs/w
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
