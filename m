Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10251DE663
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEVMK1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 08:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgEVMK1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 08:10:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCBC1206B6;
        Fri, 22 May 2020 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590149426;
        bh=aufZzBD7Gw/v2swOuf1OCpTS5RYlgSRutuUkeLXiZeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czuDiZrj7IKWDF/adL7VANFiTb1yzMSATquFQbyNe/XCdWlMhqVIopa9YXAFdob4S
         HCLFVPiAgDp1/gSJ7GjAd4c7yYKBUydzFu5U5SSqVMvhZKApMasgjPoXKSWWp4Kuw3
         JlBLMWOqHiktSqzZ8OKnILWAHdRoScQnQgNr2Gd0=
Date:   Fri, 22 May 2020 13:10:23 +0100
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
Message-ID: <20200522121023.GF5801@sirena.org.uk>
References: <20200522000806.7381-1-Sergey.Semin@baikalelectronics.ru>
 <20200522000806.7381-2-Sergey.Semin@baikalelectronics.ru>
 <20200522111340.GX1634618@smile.fi.intel.com>
 <20200522115235.rt3ay7lveimrgooa@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <20200522115235.rt3ay7lveimrgooa@mobilestation>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 02:52:35PM +0300, Serge Semin wrote:
> On Fri, May 22, 2020 at 02:13:40PM +0300, Andy Shevchenko wrote:

> > > Changelog v4:
> > > - Get back ndelay() method to wait for an SPI transfer completion.
> > >   spi_delay_exec() isn't suitable for the atomic context.

> > OTOH we may teach spi_delay_exec() to perform atomic sleeps.

> Please, see it's implementation. It does atomic delay when the delay value
> is less than 10us. But selectively gets to the usleep_range() if value is
> greater than that.

Yes, I hadn't realised this was in atomic context - _delay_exec() is
just not safe to use there, it'll swich to a sleeping delay if the time
is long enough.

> > > +	while (dw_spi_dma_tx_busy(dws) && retry--)
> > > +		ndelay(ns);

> > I might be mistaken, but I think I told that this one misses to keep power
> > management in mind.

> Here we already in nearly atomic context due to the callback executed in the
> tasklet. What power management could be during a tasklet execution? Again we
> can't call sleeping methods in here. What do you suggest in substitution?

You'd typically have a cpu_relax() in there as well as the ndelay().

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7HwS8ACgkQJNaLcl1U
h9CGaQf/ZFMdDhx8q5YswqW+2cIMQm9/zZ2xo8rLHef+jPJnVHe/BZZQQNy63vtw
7wE/Px9IiuEC+zzKbAz/qQqi1kosVIAnsns64msGZ+F5Dcj9p5+cLQJOu5WS4yLS
eZ7GezzFyw0JHzR+oyPQ5EaMxxwNQ4SBG6wK5M0brwZvlZ7H9IAf7K5+MVDX6vwy
YCjc8mJJr9l/vtTlGwKUfHaHsm9oJovKUOdNgcRbKNIKzk98ywEG4VwGSJVI4He2
8d47yar+eja+L5owuX232dDfQ1LLEzF4ZhfUzx6bGc3yRXIMO40wTjrUvysemOt3
vWnxU3eXo/LKZuxRk7VDeN3loHsqRw==
=PIxq
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
