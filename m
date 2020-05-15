Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF1F1D4D90
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgEOMSS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgEOMSS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:18:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 314F620657;
        Fri, 15 May 2020 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589545097;
        bh=9Dg/geS2WY+PUCSchXgvzv5fjHqTZmz9+jvLFZU/CVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQQTEjckxGY/W83cT10BNBZpSDTjsBfPUY2FAR25YZH/9JWCBOUPJQJwtg6k5cO8B
         9swqCX90fbexiEfXNmj5VBA6MMcXdsKYCU1I8XywHW4ZlrXOYjz9tXZJYJlZuFIJUV
         9KFNoM4hPDFlo8tos+IBi17ssR511l4fBOSAByxE=
Date:   Fri, 15 May 2020 13:18:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200515121815.GB5066@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
 <20200515120111.GV185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20200515120111.GV185537@smile.fi.intel.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 03:01:11PM +0300, Andy Shevchenko wrote:

> General question, doesn't spi core provides us some helpers like
> spi_delay_exec()?

Well, nobody wrote one.  It's also a bit tricky to handle given that
often you're checking some controller specific things while a FIFO in
the IP drains/fills, though nothing insurmountable.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+iIYACgkQJNaLcl1U
h9Ai9gf+L810S4G5FCw8xL+m5zD7ORCJcMsd3SyOTjWilDCVqE0lho+9a9VgkUGX
tXDOyyVkifm7oAFMOZRSyO5AtoP6TT8+YqWhtBeXshAkp3SESd5prUL6RcRyoYOi
g3LGxYtMxOOs+qXjBzWgv/XVANdxtzIEnFvuXdZyMKernn0/O430Wu8L0KQVTwlG
379zc5OSsqCCGpYXFFmPFZnUxuDZMQCLwIQXH5YAK5nuNm5OxaAdTL3yGvm8z2Kd
0HiCxfIEoDkoE3yPE9nRRs9AYrzIBjVFho63Llc4i06PEEkOaxpTJR5cWAxsHsQz
vbar6grUb1yOarmWFEoQnNo3tdWTQg==
=oiQY
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
