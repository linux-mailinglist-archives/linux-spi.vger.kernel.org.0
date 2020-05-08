Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91721CB397
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHPmS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 11:42:18 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43588 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPmS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 11:42:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5471580307C1;
        Fri,  8 May 2020 15:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tlhirnE3egQ7; Fri,  8 May 2020 18:42:12 +0300 (MSK)
Date:   Fri, 8 May 2020 18:42:10 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
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
Message-ID: <20200508154210.r2pp5asadalvf6ij@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VdtzdX-sOvq2cZdXqGUmU=0rdzQW_USGD_q0D59pUMTWg@mail.gmail.com>
 <20200508101541.e3yxaocuilaiyutg@mobilestation>
 <20200508102210.GC4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508102210.GC4820@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 11:22:10AM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 01:15:41PM +0300, Serge Semin wrote:
> > On Fri, May 08, 2020 at 01:03:11PM +0300, Andy Shevchenko wrote:
> 
> > > > slave device. Taking into account the peculiarities of the controller
> > > > registers and physically mapped SPI flash access, very limited resources
> > > > and seeing the normal usecase of the controller is to access an external
> > > > SPI-nor flash, we decided to create a dedicated SPI driver for it.
> 
> > > It seems a lot of code.
> > > Why can't you use spi-dw-mmio.c et al.?
> 
> > I said above why. Even though the registers set is similar It's too specific
> > to be integrated into the generic DW SSI driver.
> 
> Can you be more specific about the issues?  From what you wrote it
> sounded like the main thing was chip select handling.

I thought it would be obvious from the patch itself. I've thoroughly described all
the issues there. Here in cover-letter it's a summary of the main ones.
Anyway here are all collected at once:

1) Registers mapping. The DW SSI registers are shifted by 0x100 with
respect to the MMIO region start. The lowest 0x100 registers are
responsible for the Baikal-T1 Boot Controller settings. There aren't much
of them there though. Our code is interested only in a flag, which switches
an accessibility of the DW APB SSI registers and direct SPI flash mapping.
And this switchability is a reason of another peculiarity (see the next
item for details).

2) SPI flash direct mapping. SPI flash direct mapping and DW APB SSI registers
are mutual exclusive, so only one of them can be enabled at a time. In
order to use the dirmap we have to switch the RDA bit off in the Boot
Controller setup register. If DW APB SSI registers need to be accessed the
RDA bit should be set. For this reason we have to make sure that dirmap
operations, SPI operations and SPI-mem-ops operations are exclusive, since
some of them need to interact with the DW APB SSI registers, while another
the directly mapped SPI flash MMIO (currently ctlr->io_mutex is responsible
for this).

3) A specific access to MMIO (concerning directly mapped SPI flash MMIO).
The SoC interconnect is designed in a way so we can't use any instruction to
read/write from/to the MMIO space. It has to be done by lw/sw with
dword-aligned address passed. Though in this driver we only use a read
operation from the directly mapped SPI flash memory.

4) No direct handling of the CS. Though this is an issue of all DW SSI
controllers, here with very small FIFO and no DMA/IRQ supported it mandates to
workaround any preemption/interruption during a non-GPIO-CS-based transfer.
For the same reason the driver doesn't support normal spi-messages based
interface if no GPIO-CS supplied. In addition since FIFO is too small and most
of our platforms don't have GPIO-CS support we had to create the SPI-mem-ops
instead of generic SPI-callback.

5) MMIO access race condition. As I described in the in-code comment it's a
very tricky race happening during concurrent access from different cores to the
APB bus. Due to this if SPI interface is working high frequency like
12.5 - 25 MHz and there is some another code working with APB bus on another
core, the SPI data pushing function might not keep up with filling small FIFO
(8 bytes) on time, since the APB bus has got just 50 MHz frequency. Due to
this I had artificially limit the SPI bus frequency if there is more than one
CPU in the system.

6) A single CS. It's normally connected to an external SPI flash so the
driver is equipped with mem-ops and dirmap out of the box. BTW normal
SPI-operations are in fact unneeded on all the platforms currently
equipped with Baikal-T1 because all of them have got SPI flash attached to
this interface, and most likely it will be like in new platforms too.

7) No interrupts. Yes, this is another peculiarity. Since this DW APB core
is a part of the boot controller it just don't need IRQs. Boot controller
is responsible for the code loading from SPI flash. It has got a dedicated
RTL which provide a transparent access to the flash just by reading from a
corresponding MMIO range (see the SPI flash direct mapping described above).

8) No DMA. Yeah, and DMA isn't supported for the same reason.

I am pretty sure I have forgotten something. Anyway it has been much easier
to create a new driver instead of integrating all of these into a generic
one. Integrating something like this in the current DW APB SSI driver would
mean to have it completely overwritten (refactored if you want) which would
bring us to a new driver anyway. I don't think it would be good to
complicate the generic driver with so many peculiar things scattered around
the code with various hooks or ifdef, especially seeing the current code has
already become a bit messy.

> 
> > > > The driver provides callbacks for native messages-based SPI interface,
> > > > SPI-memory and direct mapping read operations. Due to not having any
> > > > asynchronous signaling interface provided by the core we have no choice
> 
> What do you mean by "asynchronous signaling interface provided by the
> core" here?

By asynchronous signalling I meant DMA and IRQ. Non of them provided by the
controller.

-Sergey

