Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28E1D00DC
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgELV0y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 17:26:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:55108 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgELV0y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 17:26:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 2AEE9803080B;
        Tue, 12 May 2020 21:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 91xGUihf2XO6; Wed, 13 May 2020 00:26:51 +0300 (MSK)
Date:   Wed, 13 May 2020 00:26:50 +0300
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
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/17] spi: dw: Cleanup generic DW DMA code namings
Message-ID: <20200512212650.bmq5i3mrl5mydcvz@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-5-Sergey.Semin@baikalelectronics.ru>
 <20200508194324.GA185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508194324.GA185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 10:43:24PM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2020 at 04:29:29PM +0300, Serge Semin wrote:
> > Since from now the former Intel MID platform layer will be used
> > as a generic DW SPI DMA module, lets alter the internal methods
> > naming to be DMA-related instead of having the "mid_" prefix. In
> > addition the DW PCI-DMA specific methods and structures should
> > be named with pci-suffexes, since we'll implement the DW MMIO DMA
> > specific functions and objects soon.
> 
> I think we rather leave Intel Medfield things alone.  And I think I did this already in spi/for-next in less invasive way.

The naming is horrible in that module. Since it's going to be a generic DMA
driver the prefixes should be correspondingly fixed. Currently they are a bit
random.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
