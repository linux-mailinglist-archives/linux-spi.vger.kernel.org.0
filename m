Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC031D117C
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgEMLhA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 07:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgEMLhA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 May 2020 07:37:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3022206D6;
        Wed, 13 May 2020 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589369819;
        bh=esvSPlYfmiYgql73vEjD2+5RucmuA0PgDXZlvBGj+VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXEPmp4wRscmSOpgSsbkHiRIaecmZa09WJ0Kb2AvQ9nCRPGsSR3zseVQTSCYNqsYs
         nkOmpc+jTnaPWyQN/+5rGzQDmrfd+jpCWT/xDkp6bn1eVhnAXSoSK+2TW3/oixy8gP
         w0ifH6+8WJHCTVMQr4Me1LppjfLlROKy01S7ymhs=
Date:   Wed, 13 May 2020 12:36:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] spi: dw: Add Tx/Rx finish wait methods to DMA
Message-ID: <20200513113656.GF4803@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-8-Sergey.Semin@baikalelectronics.ru>
 <20200508173023.GO4820@sirena.org.uk>
 <20200513113555.mjivjk374giopnea@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <20200513113555.mjivjk374giopnea@mobilestation>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 02:35:55PM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 06:30:23PM +0100, Mark Brown wrote:

> > > +	while (dw_spi_dma_tx_busy(dws) && retry--)
> > > +		ndelay(ns);

> > How deep can the FIFO be with this IP - could we end up ndelay()ing for
> > non-trivial amounts of time?

> According to the DW APB SSI db it can be up to 256 transfer words. So the delay
> should be trivial.

Yes, that should be fine.

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6729gACgkQJNaLcl1U
h9AzxQf/bsWYDjXldUBZJ1fmI7RZ7yZW9/NawHY0tDiB5aidn0Qz1+0tYxPDmbhJ
bUrIy7i5rEDV45LCvSLqXmOFAPs7+ic+SqlmIJFT+oHXR57351MKFSdPzc4WIbUT
ZtCF2sUfQZXrk6O++CHGNwaiXkvkPxvdSw3R8AwsjUslTNHhqUH83efqIpCfu0mw
Ttg/Ub0mSxEoALKiJN1T3NEH2B8qYS/J1dHGqoky8/ETQnXGR9NPTxIksgNVr42w
HzXRM9gaXiBGtLAKfQqCwlRHUKqXckccJYfXN1edvFujhaXrfirs85hkEe+5CmMS
OllgnBoTThVcCIvQZ+OAqp1c5UYtmw==
=myKX
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
