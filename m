Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50F11CB561
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEHRHi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 13:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgEHRHi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 13:07:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4CC2083B;
        Fri,  8 May 2020 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588957657;
        bh=gFrMAqNENiqsLuPP+ou0xff1gNs2mwSrUOEUDm/fTOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kX/2yeg05jcKk+oVnZzlPwEc9jZ/nTz/aPemBJqejITzrT5lwkP62pRO9vzU3HjgN
         +B/Iqt5YJ4Bu/Da0PiCBkcIVGIRraMpmFLrk2d1csggYueTfBvjpnn5Z85jCijRxOG
         pXLz2DCR+cF7tmQ1h8zwoXl7iVRbTE5DK6BoKKYY=
Date:   Fri, 8 May 2020 18:07:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Message-ID: <20200508170733.GL4820@sirena.org.uk>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VdtzdX-sOvq2cZdXqGUmU=0rdzQW_USGD_q0D59pUMTWg@mail.gmail.com>
 <20200508101541.e3yxaocuilaiyutg@mobilestation>
 <20200508102210.GC4820@sirena.org.uk>
 <20200508154210.r2pp5asadalvf6ij@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
In-Reply-To: <20200508154210.r2pp5asadalvf6ij@mobilestation>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 06:42:10PM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 11:22:10AM +0100, Mark Brown wrote:

> > Can you be more specific about the issues?  From what you wrote it
> > sounded like the main thing was chip select handling.

> I thought it would be obvious from the patch itself. I've thoroughly described all
> the issues there. Here in cover-letter it's a summary of the main ones.

Bear in mind that the patch is a stand alone thing, there's not a copy
of the existing driver sitting with it and the stylistic changes make
comparisons even less obvious.

> 1) Registers mapping. The DW SSI registers are shifted by 0x100 with
> respect to the MMIO region start. The lowest 0x100 registers are
> responsible for the Baikal-T1 Boot Controller settings. There aren't much
> of them there though. Our code is interested only in a flag, which switches
> an accessibility of the DW APB SSI registers and direct SPI flash mapping.
> And this switchability is a reason of another peculiarity (see the next
> item for details).

That seems fairly easy to address, for example with a subdevice or
indirecting through ops for I/O that could add on an offset (what a
subdevice would end up accomplishing really).

> 2) SPI flash direct mapping. SPI flash direct mapping and DW APB SSI registers
> are mutual exclusive, so only one of them can be enabled at a time. In
> order to use the dirmap we have to switch the RDA bit off in the Boot
> Controller setup register. If DW APB SSI registers need to be accessed the
> RDA bit should be set. For this reason we have to make sure that dirmap
> operations, SPI operations and SPI-mem-ops operations are exclusive, since
> some of them need to interact with the DW APB SSI registers, while another

This exclusivity requirement is pretty standard for these flash memory
map controllers, the framework should ensure you don't get any overlap
between memory mapped and regular interactions.

> the directly mapped SPI flash MMIO (currently ctlr->io_mutex is responsible
> for this).

It only seemed to be referenced in the debugfs code?

> 3) A specific access to MMIO (concerning directly mapped SPI flash MMIO).
> The SoC interconnect is designed in a way so we can't use any instruction to
> read/write from/to the MMIO space. It has to be done by lw/sw with
> dword-aligned address passed. Though in this driver we only use a read
> operation from the directly mapped SPI flash memory.

That's a custom IP block for your systems so that'd be a separate
operation no matter what.

> 4) No direct handling of the CS. Though this is an issue of all DW SSI
> controllers, here with very small FIFO and no DMA/IRQ supported it mandates to
> workaround any preemption/interruption during a non-GPIO-CS-based transfer.
> For the same reason the driver doesn't support normal spi-messages based

As I said when reviewing the driver I think all you need here is support
in the core for linearizing messages into a single transfer and then
what you're left with is what should be a fairly small quirk for running
with interrupts disabled if there's no DMA or interrupts.  I'd expect
both bits of that to benefit some other users too, there's definitely
other controllers that have problems with automated chip select
handling but happen to get away with it a lot of the time.

> interface if no GPIO-CS supplied. In addition since FIFO is too small and most
> of our platforms don't have GPIO-CS support we had to create the SPI-mem-ops
> instead of generic SPI-callback.

As I also said in reviewing the driver that's just not a good idea
anyway, there is no way a driver should be open coding things like that
and there are much better ways to support this.  This is only there
because the driver isn't able to cope with normal messages, it's better
to solve that problem and use the generic flash code than to emulate the
generic flash code here.

In both these cases it looks like the majority of the reason the driver
is different is that you're trying to solve problems in the driver
without changing the core, some things are a lot easier to handle
further up the stack.

> 5) MMIO access race condition. As I described in the in-code comment it's a
> very tricky race happening during concurrent access from different cores to the
> APB bus. Due to this if SPI interface is working high frequency like

This looks like it should be a fairly small quirk?

> I am pretty sure I have forgotten something. Anyway it has been much easier
> to create a new driver instead of integrating all of these into a generic
> one. Integrating something like this in the current DW APB SSI driver would
> mean to have it completely overwritten (refactored if you want) which would
> bring us to a new driver anyway. I don't think it would be good to
> complicate the generic driver with so many peculiar things scattered around
> the code with various hooks or ifdef, especially seeing the current code has
> already become a bit messy.

It really does sound like other than the bits I don't think should be
implemented on a per-driver level these differences are relatively
small.

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61kdQACgkQJNaLcl1U
h9BK0Qf/XnNZ8iZshg/MisGBW5otVRjj/VHOY47GKBd8cBJFzqRzBItBC+FY9LTa
M27kfFmD5PL6uQkyKLcMO6bT4fQfId97DgK6wFZTzD92iHA2HlDxplJfde+x7FYz
MiW/SgJrKOiTjz7sDs3awuB3CcyEe9AdDtgxCaxiTe40MDhmIdYclRoxyZmTMpBi
qFGmeBrGi6jUKiFTdeHu/hmaVa9du2/VaBZxsPicEJl21O2aLHcw5cCQHFiBFqgw
fAaT2/gKAHlSQ9rJLXIr0kxMupFoP5ugVDgxGAqnhlrqLXeEvhaAcPmM6poRVkmO
ETdt5doSEWB8225kqpKrDEBQUIlStQ==
=ZZx2
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--
