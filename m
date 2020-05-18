Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB511D7597
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgERKve (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 06:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgERKvd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 06:51:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FDD20709;
        Mon, 18 May 2020 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589799092;
        bh=i2AfCj4ub0nWHT5gvxlriwr/KZpF7Frnuv84NlUoeIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKMJa/Hx0SNrxKGqgTQ+Z9yf/QSzQjzYKzJN6tuA0sNMQnphFHnjikn4i5L9UfHZF
         7vlBITv1hxqfiEfgiBzei9qanx1g+j0AjtIRUvbQE+qDI7r4bkBuYAfb6FGDfXUskm
         R1PKD1ecMSRxeO25BvVq5/Q43gEvpe6VC/jxTDSA=
Date:   Mon, 18 May 2020 11:51:30 +0100
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
Message-ID: <20200518105130.GC8699@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-3-Sergey.Semin@baikalelectronics.ru>
 <20200515120111.GV185537@smile.fi.intel.com>
 <20200515121815.GB5066@sirena.org.uk>
 <20200515123702.GA185537@smile.fi.intel.com>
 <20200515124131.GE5066@sirena.org.uk>
 <20200515200250.zjsv5uaftwqcnwud@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20200515200250.zjsv5uaftwqcnwud@mobilestation>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 11:02:50PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 01:41:31PM +0100, Mark Brown wrote:

> > I guess we could, though it's really there because for historical
> > reasons we've got a bunch of different ways of specifying delays from
> > client drivers rather than for the executing a delay where you've
> > already got a good idea of the length of the delay.

> A beauty of spi_delay_exec() is that it provides a selective delay. I mean it
> checks the delay value and selects an appropriate delay method like ndelay,
> udelay and so on. That's the only reason I'd use it here. But It has got a few
> drawbacks:

Right, usually you'd have a good ideal how long the delay is and
therefore just be able to go directly for an appropraite delay function.

> - timeout value has type u16. It's too small to keep nanoseconds.

That could be increased, though obviously if you have a bigger delay you
can specify it in usecs instead.

> - semantically the xfer argument isn't optional and we can't fetch it that easy
>   in the dmaengine completion callbacks.

Not sure I follow this.

> So if there were an alternative method like _spi_transfer_delay_ns() I'd use it.
> Otherwise we'd need to locally implement the selective delay. Unless you know
> another alternative, which does it. If you don't and there isn't one then in
> order to not over-complicate a simple delay-loop code I'd simply leave the
> ndelay() here.

Not that I'm aware of.

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7CaLEACgkQJNaLcl1U
h9B7Rwf/fqp1qjsvXr4x+k4pnHTXLydq+YVuk7I9jH54/CjiUyAFORKPQPBqaALA
o6T8iks8/NsBl2RwCYddysTdSVb4H5vYD2GBjlvSWZgyLlnANzuES+mq6Ux8ZX/W
FFlNgWpZY+bCBolXL53+0/j2wiVxYqRXsMPF05P3a8wphYDZE565WWTbTA9IQ5pX
aLUW05PQcGuvQdgVF9SM89ftk/3YLnQJCmtUMwdpkuUzDLhlMVhw7FR9l2iClAXF
GH9175wDMI2UIB4XnuAj2IvniurtxU0RevqsBsQmTvOiT1sPmGRLiuLCacJOjDzf
vkOwB9Ol0wriQ8KeFaGhKbSu0rFZew==
=E8fH
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
