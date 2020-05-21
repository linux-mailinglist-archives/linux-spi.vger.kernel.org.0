Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C781DD45F
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEUR3g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 13:29:36 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:39830 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgEUR3g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 13:29:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 01164803087B;
        Thu, 21 May 2020 17:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iY8IGjWiqpLP; Thu, 21 May 2020 20:29:33 +0300 (MSK)
Date:   Thu, 21 May 2020 20:29:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
Message-ID: <20200521172932.e5tcmb2ggsxbrxfz@mobilestation>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
 <20200521121228.aqplh6eftylnys3p@mobilestation>
 <20200521155143.GE4770@sirena.org.uk>
 <20200521155804.qgaaqc23h2nll7r3@mobilestation>
 <CAHp75VcY9HG3=wft9VFWKJD9PG6TiSbmOyjgYZyue+z3PW_eCQ@mail.gmail.com>
 <20200521163904.GF4770@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521163904.GF4770@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 05:39:04PM +0100, Mark Brown wrote:
> On Thu, May 21, 2020 at 07:02:32PM +0300, Andy Shevchenko wrote:
> > On Thu, May 21, 2020 at 6:58 PM Serge Semin
> 
> > > Let's leave the patch as is.
> 
> > Mark, should I send a partial revert afterwards in this case?
> > I'm not fully satisfied with it.
> 
> That might be a suitable way to keep the peace here.  You are clearly
> both much more passionate about this choice than I am.

Fine with me.)

-Sergey
