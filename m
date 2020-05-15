Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E441D56D9
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEOQzq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEOQzq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 12:55:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED80206C0;
        Fri, 15 May 2020 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589561745;
        bh=0/7iM39p9XwrUUVm7bhTJrs/zPCmSekTi8cTWkQq95k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJxxCaWVqeouHtl3c7wPbjtaVN3NZPYpeGzbOR/+Hb4qan6cL/xVL8Tj0yv0EX0uq
         XjnP8p57YVI7qyawia6bsVg5jwq/aYURaMonNxezMNzoX8L/dlvTapzBjUyJ2wwsUV
         I2/XAjUIzgyM6tRb5P5mpbPNJxEAeAn+4/ui3+tI=
Date:   Fri, 15 May 2020 17:55:42 +0100
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
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Clement Leger <cleger@kalray.eu>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/19] spi: dw: Fix Rx-only DMA transfers
Message-ID: <20200515165542.GK5066@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-13-Sergey.Semin@baikalelectronics.ru>
 <20200515144050.GI1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline
In-Reply-To: <20200515144050.GI1634618@smile.fi.intel.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 05:40:50PM +0300, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 01:47:51PM +0300, Serge Semin wrote:
> > Tx-only DMA transfers are working perfectly fine since in this case
> > the code just ignores the Rx FIFO overflow interrupts. But it turns
> > out the SPI Rx-only transfers are broken since nothing pushing any
> > data to the shift registers, so the Rx FIFO is left empty and the
> > SPI core subsystems just returns a timeout error. Since DW DMAC
> > driver doesn't support something like cyclic write operations of
> > a single byte to a device register, the only way to support the
> > Rx-only SPI transfers is to fake it by using a dummy Tx-buffer.
> > This is what we intend to fix in this commit by setting the
> > SPI_CONTROLLER_MUST_TX flag for DMA-capable platform.

> I'm fine with this if Mark considers this right thing to do.
> So, conditionally
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yes, this is good - it's quite a common issue that controllers have and
the main reason the flag exists is to provide a standard fix for it.

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+yY0ACgkQJNaLcl1U
h9CAAAf/VoOquW8qpM2Mev4sXK326Cw9c9Y5irgLR/QgbJE/PtM5OLNFb6l19Loa
Ouj1JDOLwnqmwSknOUhfnYW7q9gJk9ON/t1JQ1gFajn42r8UismqAHhCl6jx/paS
o7h1JZic1BYcg+QOdqpRCXjKVnC1DLKKU39uL2ENJgVjp7cS5kDNkjmQItrbwChg
WZJOcew5M0AhOdtPrlzOO9Z7JzxTvsMZ0Tcugqx9crZV27gBiqW6B+N7K/UniL9k
UWCv/zKfTp04dnihvEm3damKRpjHexESoivXysUc6u6ZjB1ev64wOvHozmb0lA8C
z7rEhPsy3j1h9SYIMLJMYDuNFU3/iA==
=KJzl
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
