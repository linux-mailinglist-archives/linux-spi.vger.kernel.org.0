Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E831CFF53
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgELUef (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:34:35 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:54948 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELUee (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:34:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9E5288030807;
        Tue, 12 May 2020 20:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fc4IUkLdqnm6; Tue, 12 May 2020 23:34:31 +0300 (MSK)
Date:   Tue, 12 May 2020 23:34:30 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] spi: dw: Add generic DW DMA controller support
Message-ID: <20200512203430.mohmki5nrmayzppr@mobilestation>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508173609.GQ4820@sirena.org.uk>
 <20200508191617.GR185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508191617.GR185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 10:16:17PM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2020 at 06:36:09PM +0100, Mark Brown wrote:
> > On Fri, May 08, 2020 at 04:29:25PM +0300, Serge Semin wrote:
> > > Baikal-T1 SoC provides DW DMA controller to perform low-speed peripherals
> > > Mem-to-Dev and Dev-to-Mem transaction. This is also applicable to the DW
> > > APB SSI devices embedded into the SoC. Currently this type DMA device is
> > 
> > This basically all looks good to me (without any hardware specific
> > knowledge), I had a few comments but they were mostly procedural ones -
> > mainly getting these bug fixes you've done merged as such.  Nice work.
> 
> Agree that is nice work!
> Though, can you please give us chance to review next version of the series and test on our hardware?
> 
> Serge, I think you should base it on spi/for-next rather than vanilla.

Yeah, seeing there are potentially merge-conflict changes in the for-next
branch I have to do the rebase. Will be done in v2.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
