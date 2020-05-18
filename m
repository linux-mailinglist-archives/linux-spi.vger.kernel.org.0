Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744911D89E8
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgERVRe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 17:17:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:50230 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgERVRe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 17:17:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2EBCD8030807;
        Mon, 18 May 2020 21:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i3GN_NL9uKnD; Tue, 19 May 2020 00:17:29 +0300 (MSK)
Date:   Tue, 19 May 2020 00:17:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200518211727.jrzo6tn7slqzxoyl@mobilestation>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
 <20200508113751.GD4820@sirena.org.uk>
 <20200510002039.hwahqasnnceowskz@mobilestation>
 <20200511212506.GA23852@sirena.org.uk>
 <20200518000542.ohtpem3lo2pbixbu@mobilestation>
 <20200518151946.GH8699@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200518151946.GH8699@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 18, 2020 at 04:19:47PM +0100, Mark Brown wrote:
> On Mon, May 18, 2020 at 03:05:42AM +0300, Serge Semin wrote:
> > On Mon, May 11, 2020 at 10:25:06PM +0100, Mark Brown wrote:
> 
> > > Yes, some flags should work here - the issue was that at least some
> > > controllers may end up trying to do multiple SPI operations for one
> > > spi-mem thing which will break if the chip select doesn't get changed to
> > > correspond with what's going on.
> 
> > Ok. New SPI flag it is then. It will be something like this:
> > + #define SPI_CONTROLLER_FLASH_SS		BIT(6)
> 
> I'd rather use CS than SS (it's more common in the code).

Ok.

> 
> > So, what do you think?
> 
> Should be fine, controllers that have an issue implementing just
> shouldn't set the flag.

Yes, exactly what I intended.

> 
> > > > > It's not clear to me that this hardware actually supports spi_mem in
> > > > > hardware?
> 
> > > > SPI-mem operations are implemented by means of the EEPROM-read and Tx-only
> > > > modes of the controller.
> 
> > > Sure, but those seem like normal SPI-level things rather than cases
> > > where the hardware understands that it has a flash attached and is doing
> > > flash specific things.
> 
> > No, hardware can't detect whether the flash is attached. This must be defined by
> > the platform, like based on the DT sub-nodes.
> 
> This isn't about autodetection, it's about the abstraction level the
> hardware is operating on - some hardware is able to generate flash
> operations by itself (possibly with some help programming the opcodes
> that are needed by a given flash), some hardware just works at the
> bytestream level.
> 
> > > A very common case for this stuff is that
> > > controllers have acceleration blocks for read and fall back on normal
> > > SPI for writes and erases, that sounds like what's going on here.
> > 
> > Well, yeah, they do provide some acceleration. EEPROM-read provides automatic
> > write-cmd-dummy-data-then-read operations. But in this case the only thing we
> > have to push into the SPI Tx FIFO is command and dummy bytes. The read operation
> 
> So it's a write then read but you have to program the write each time?

Here is what we need to do to perform the EEPROM-read operation:
1) Enable EEPROM-read mode.
2) Initialize a corresponding registers with a number of SPI transfer words
   (with bits-per-word taken into account) to read.
3) Push opcode + address + dummy bytes into the Tx FIFO. When it's done and
   the Tx FIFO is empty, the controller will proceed with read operations by
   pushing zeros (or ones, don't remember what level it's by default) to MOSI
   and pulling data from MISO into the RX FIFO.
4) Keep up with getting data from the Rx FIFO so one wouldn't get overflown.

Regarding programming write each time. Well, it's up to the driver implementation.
If opcode, address, dummy bytes and number of words to read are the same as before,
then re-programming isn't required.

-Sergey
