Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8DE1D764A
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgERLL7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 07:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERLL7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 07:11:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9752070A;
        Mon, 18 May 2020 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589800318;
        bh=y5KEPZycp2oqOnuCY3zLjhziAEaTVxgXBZUxJmqtlGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekps8lER8cGxo1U9Ib02aFnop4f+6JvNaLY30v7KoO6Qvs/xi4Cz1Wl4ZKEIDxfRf
         h251C0uVoz8rrgQx3p1G25upPTqRClTJ0fZEpP33zbVSgiz9Q+QbOSQHttgaxm7z3O
         leceqbuxoROcBvu97fh13ryAY53OfNuowzkvsoWY=
Date:   Mon, 18 May 2020 12:11:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200518111156.GD8699@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
 <20200515120111.GV185537@smile.fi.intel.com>
 <20200515121815.GB5066@sirena.org.uk>
 <20200515123702.GA185537@smile.fi.intel.com>
 <20200515124131.GE5066@sirena.org.uk>
 <20200515200250.zjsv5uaftwqcnwud@mobilestation>
 <20200518105130.GC8699@sirena.org.uk>
 <20200518110453.w3ko5a5yzwyr73ir@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <20200518110453.w3ko5a5yzwyr73ir@mobilestation>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 02:04:53PM +0300, Serge Semin wrote:
> On Mon, May 18, 2020 at 11:51:30AM +0100, Mark Brown wrote:

> > > - semantically the xfer argument isn't optional and we can't fetch it that easy
> > >   in the dmaengine completion callbacks.

> > Not sure I follow this.

> I mean is it Ok to call the spi_delay_exec like this: spi_delay_exec(delay, NULL),
> with null passed instead of xfer pointer? Semantically the pointer is required only
> if we'd need to calculate the SPI_DELAY_UNIT_SCK delay, but here we'll need
> USECS and NSECS delays. So at the first glace there is no problem with passed
> NULL instead of xfer. But doing so we'd rely on the semantic peculiarity, which
> may seem a bit hackish.

Yes, that should be fine if you don't specify a SCK delay.  There's no
reason to be looking at that if the delay isn't specified in SCKs.

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7CbXsACgkQJNaLcl1U
h9Bchwf/XyAPpC0qyH8YKkXr5ojOu4mZYFgsks4BSiWD3oihJ+PHPPyadgcyk5Cy
1Da3q89y/hcJIj6G0IBO+VN1/5XqjtuF3KGrac8JysLfV9nphim4QqyrlF91DrZb
6Zx/kpjUVDEfbTi9KOfda0sYHeeU6ccd9/3QdmQS5yRR04lHA+7204ZINBZ+AHPu
F9yZaAfv4OclT57cMEGGHjXs3lY+KmOa8n4TV58MiBm2fMJNlcrAQAK5zSmrvZqN
ZgR87Oi21WPCxRVCz15wj4tuGKg38jUawie1GxD3pu1vf+gfc8DvlcmrKWBxs263
k/W97ew0gHSbfy3VyyhMH+zISqRX8A==
=YKl/
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
