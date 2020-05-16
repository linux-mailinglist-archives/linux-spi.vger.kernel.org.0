Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46E01D6182
	for <lists+linux-spi@lfdr.de>; Sat, 16 May 2020 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgEPOGd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 May 2020 10:06:33 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40236 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgEPOGd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 May 2020 10:06:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B8B9C8030809;
        Sat, 16 May 2020 14:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kzvn8ktOIz_p; Sat, 16 May 2020 17:06:28 +0300 (MSK)
Date:   Sat, 16 May 2020 17:06:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/19] spi: dw: Enable interrupts in accordance with
 DMA xfer mode
Message-ID: <20200516140627.zwigqoz335lhkxns@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-6-Sergey.Semin@baikalelectronics.ru>
 <20200515122700.GY185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515122700.GY185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 03:27:00PM +0300, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 01:47:44PM +0300, Serge Semin wrote:
> > It's pointless to track the Tx overrun interrupts if Rx-only SPI
> > transfer is issued. Similarly there is no need in handling the Rx
> > overrun/underrun interrupts if Tx-only SPI transfer is executed.
> > So lets unmask the interrupts only if corresponding SPI
> > transactions are implied.
> 
> My comments below.
> 
> > Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> > Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Allison Randal <allison@lohutok.net>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-mips@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> 
> I think you really need to revisit Cc list in all patches (DT people hardly
> interested in this one, though ones where properties are being used might be
> point of interest).
> 
> ...
> 
> >  	/* Set the interrupt mask */
> > -	spi_umask_intr(dws, SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI);
> > +	spi_umask_intr(dws, imr);
> 

> Can we rather do like this
> 
> 	/* Set the interrupt mask */
> 	if (xfer->tx_buf)
> 		imr |= SPI_INT_TXOI;
> 	if (xfer->rx_buf)
> 		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
> 	spi_umask_intr(dws, imr);
> 
> ?
> 
> (First block sets DMA, second one IRQ)

I'd rather leave it as is.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
