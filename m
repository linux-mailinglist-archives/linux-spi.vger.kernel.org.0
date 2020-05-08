Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD061CA83E
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHKWN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 06:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgEHKWN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 06:22:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2DBA208D6;
        Fri,  8 May 2020 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588933332;
        bh=0zdzBynO1wxpltbyCDGMW3LJkzChWsD2F3DXAG0KVvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1LorngV4QwrEbOgNnfaULvNuCzhPnLImq+CL9GgvYjaScTv/v1pQTz7r67TRzncGC
         wnJoT6sRoiyLNpqXUsZhDchHJZhmOrP9iYVSr4QGjPFiXMC9pKtsJLpWVNmXG/oO6d
         mOSP6xhcQ5fR9Zdxi+tbEjHDtt1EygyINhUb5aEo=
Date:   Fri, 8 May 2020 11:22:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200508102210.GC4820@sirena.org.uk>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VdtzdX-sOvq2cZdXqGUmU=0rdzQW_USGD_q0D59pUMTWg@mail.gmail.com>
 <20200508101541.e3yxaocuilaiyutg@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <20200508101541.e3yxaocuilaiyutg@mobilestation>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 01:15:41PM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 01:03:11PM +0300, Andy Shevchenko wrote:

> > > slave device. Taking into account the peculiarities of the controller
> > > registers and physically mapped SPI flash access, very limited resources
> > > and seeing the normal usecase of the controller is to access an external
> > > SPI-nor flash, we decided to create a dedicated SPI driver for it.

> > It seems a lot of code.
> > Why can't you use spi-dw-mmio.c et al.?

> I said above why. Even though the registers set is similar It's too specific
> to be integrated into the generic DW SSI driver.

Can you be more specific about the issues?  From what you wrote it
sounded like the main thing was chip select handling.

> > > The driver provides callbacks for native messages-based SPI interface,
> > > SPI-memory and direct mapping read operations. Due to not having any
> > > asynchronous signaling interface provided by the core we have no choice

What do you mean by "asynchronous signaling interface provided by the
core" here?

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61MtEACgkQJNaLcl1U
h9BbBAf+Jl9EnhQJquSLhnymjo26KCwHkpt/NEN6OKsKTLYfqL6Emy6SUPmqzpdM
AUxNE0209CAMHG/ThduAVeKtICEoc5aek/HHkit5GcPze80sUzY2xRTLvNtVFp2S
DcYhPtO+n422dQo/pp4T7LOBp+9o/oLkw3laGi8PL2zqGu7JOMOaEt8Zxsr1V5OV
UrtTzdDW6ztfatRY/p1Re4Uy+pDS6fPEgfHKxImaZSeoLSbhLc07y3R6QOtChd+p
Kk3L9eoLS90IjB9xTHjgASfmLKE+15kuoRfH0w3bU3ldRRUVlfckYXxKklZBVRO4
KnZnpFoa6wjOYpoPbHLv5cpFOXKpPw==
=5r9D
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
