Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843101E859D
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2Rry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:47:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:50328 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2Rry (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 13:47:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9FE718030772;
        Fri, 29 May 2020 17:47:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sa_1CdlC5E-r; Fri, 29 May 2020 20:47:51 +0300 (MSK)
Date:   Fri, 29 May 2020 20:47:50 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Feng Tang <feng.tang@intel.com>, <devicetree@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-mips@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
Subject: Re: [PATCH v6 00/16] spi: dw: Add generic DW DMA controller support
Message-ID: <20200529174750.wi3q27rxcsbpikoy@mobilestation>
References: <20200529131205.31838-1-Sergey.Semin@baikalelectronics.ru>
 <159077271266.17043.13820488074564153429.b4-ty@kernel.org>
 <20200529172642.hcnvyzv2ocizsvpy@mobilestation>
 <20200529174312.GU1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200529174312.GU1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 29, 2020 at 08:43:12PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 08:26:42PM +0300, Serge Semin wrote:
> > On Fri, May 29, 2020 at 06:18:32PM +0100, Mark Brown wrote:
> > > On Fri, 29 May 2020 16:11:49 +0300, Serge Semin wrote:
> > > > Baikal-T1 SoC provides a DW DMA controller to perform low-speed peripherals
> > > > Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> > > > APB SSI devices embedded into the SoC. Currently the DMA-based transfers
> > > > are supported by the DW APB SPI driver only as a middle layer code for
> > > > Intel MID/Elkhart PCI devices. Seeing the same code can be used for normal
> > > > platform DMAC device we introduced a set of patches to fix it within this
> > > > series.
> 
> > As you can see it has been acked by Rob. So you can also merge it into your
> > repo. Though It has to be rebased first due to the Dinh Nguyen patches
> > recently merged in. Do you want me to do the rebasing?
> 
> I guess now you need to rebase it, because as I see the Dinh's patches are in
> the tree as well as yours.

Right. That's what I am doing at the moment.)

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
