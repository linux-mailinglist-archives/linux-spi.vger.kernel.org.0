Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A91D78D7
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgERMnP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 08:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgERMnP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 08:43:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C1E20674;
        Mon, 18 May 2020 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589805795;
        bh=1JZLry2PUegFM/l1H92CD7cKZOjtP39iyTkAp0FBJaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cV+jHkG2z8E9jTCW1ntbDqk46eqMjVxLyyvcNGW0rEPV+B9MMM1h9UHyRBdGXqF25
         /KOzSTNKjYKDeXEQlGoRi4EPqnQV/ADFCuzVTJZ31I7wrM7AnVvHp09nS2WhMjtg3o
         ORJZGnRyU8DV3qQxNo2a9N/+RvEKTWsOyRcj8egY=
Date:   Mon, 18 May 2020 13:43:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/19] spi: dw: Use DMA max burst to set the request
 thresholds
Message-ID: <20200518124312.GF8699@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-11-Sergey.Semin@baikalelectronics.ru>
 <20200515143842.GG1634618@smile.fi.intel.com>
 <20200516200133.wmaqnfjbr7234fzo@mobilestation>
 <20200518110343.GY1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <20200518110343.GY1634618@smile.fi.intel.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 02:03:43PM +0300, Andy Shevchenko wrote:
> On Sat, May 16, 2020 at 11:01:33PM +0300, Serge Semin wrote:

> > Though if v3 is required I'll group these members together.

> From what I see v3 is what Mark and me are waiting for. Mark, are we on the
> same page here?

I loose track of what's going on with this specific patch, sorry - it's
patch 10 in the series so there's a good chance it has dependencies on
some of the earlier changes anyway.

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Cgt8ACgkQJNaLcl1U
h9BaIwf/c47rPAJvBpcr8a/g6QrXgZlVY7AC2NAP+vI8mWBTUyQTI6Vr0gbsyWIY
bi3KxMa/82i/bl9Vk7C4QEdXISENK0ARCtQ2K26ki/zMSp9ILaL8dYdSOQ4SLCse
g/5XUQcQQRljj9dujtlDtgPWZV09QWYiNPzAPzNVEa2uXdNc0eFS1yJzw+35puXD
p9n2nd6N5VJagIvPj9E/kPzLYcXkh1S3ooQOj2UUWE0iOIZOhlnY34Kt5nUbI/mR
V6EnZEPlTbrVWNDJ5eGDzmtljrFhNojtbN/wQQqK2IJPECw0POmgVOR3FGh6Boox
61dlLkz/OYgVuaebXcEvos8+gHh5CQ==
=MUZo
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
