Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5821DEBB2
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgEVPWp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 11:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgEVPWo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 11:22:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6712054F;
        Fri, 22 May 2020 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590160963;
        bh=MMSmt+qYR9drLnxHce8Ry8LIx3FSk/xxE5Ta8UzagXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8g53iNeyEdE0ohX81JBwKeBzrW0/TjYPXRhZSTk7ZHd7SkhtyxYzOBTXh69PaKF+
         QCt1TeKaDnRF/Lm5Og6NPRiq0Rdk5Wb7q2QSbzUcKcX2NK7lYEL/pccNoxvrzOoX45
         /P+hqn92r16BozLUp1h9Egi63kCkKFXfr2lPPFYw=
Date:   Fri, 22 May 2020 16:22:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Alan Cox <alan@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200522152241.GK5801@sirena.org.uk>
References: <20200522115235.rt3ay7lveimrgooa@mobilestation>
 <20200522121221.GA1634618@smile.fi.intel.com>
 <20200522121820.GG5801@sirena.org.uk>
 <20200522123427.GD1634618@smile.fi.intel.com>
 <20200522124406.co7gmteojfsooerc@mobilestation>
 <20200522131013.GH5801@sirena.org.uk>
 <20200522132742.taf2ixfjpyd5u3dt@mobilestation>
 <20200522140025.bmd6bhpjjk5msvsm@mobilestation>
 <20200522143639.GG1634618@smile.fi.intel.com>
 <20200522144542.brhibh453wid2d6v@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <20200522144542.brhibh453wid2d6v@mobilestation>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 05:45:42PM +0300, Serge Semin wrote:
> On Fri, May 22, 2020 at 05:36:39PM +0300, Andy Shevchenko wrote:

> > My point is: let's warn and see if anybody comes with a bug report. We will
> > solve an issue when it appears.

> In my environment the stack trace happened (strictly speaking it has been a
> BUG() invoked due to the sleep_range() called within the tasklet) when SPI bus
> had been enabled to work with !8MHz! clock. It's quite normal bus speed.
> So we'll get the bug report pretty soon.)

Right, that definitely needs to be fixed then - 8MHz is indeed a totally
normal clock rate for SPI so people will hit it.  I guess if there's a
noticable performance hit to defer to thread then we could implement
both and look at how long the delay is going to be to decide which to
use, that's annoyingly complicated though so if the overhead is small
enough we could just not bother.

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7H7kAACgkQJNaLcl1U
h9B6Kgf/QkMYmBdVYxKlZ5TKL+hL0E4I7igNofk1QV1k9b5qAbVEpBw0bQOyDb0c
XGkJFC+Ow7XjhFaGyTc7Ay4BXbUQdO3+Oi+OG11yN6x0YdRBcds5qJPEj2uuWQZV
1+qhlWYx8xJHNzuMo3MYi3ylIpi7jFe8Wrk2p9EBk5RvNP0LUv1nfRaPKiEToZm0
w6R+gPOW8mFWniwmXgd0fUiDWsaStPuYl8Nf2h1yqgrwUW/1/xH9Wey+1ImpOxqU
Jxy4BMrcYvZpxRvOlDt3NmgZhavC7/COFrnnlEOjAaN4B0iFhHPCElbQhj8AkQ/M
GmH3wFqGIB8Lydgs9cBhaouUI0sVrA==
=Bjdn
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
