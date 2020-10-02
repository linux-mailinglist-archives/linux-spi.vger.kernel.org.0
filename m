Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE7281C5E
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgJBT43 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 15:56:29 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52542 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBT43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 15:56:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E6316803017E;
        Fri,  2 Oct 2020 19:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6YRMgoMFRauJ; Fri,  2 Oct 2020 22:56:26 +0300 (MSK)
Date:   Fri, 2 Oct 2020 22:56:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/21] spi: dw: Detach SPI device specific CR0 config
 method
Message-ID: <20201002195625.6lzutebffvpfgz54@mobilestation>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-4-Sergey.Semin@baikalelectronics.ru>
 <20201002102246.GX3956970@smile.fi.intel.com>
 <20201002174725.rpwdgfo6xzxafqhs@mobilestation>
 <CAHp75VeO9NGAU_zH99wqS9F9mXANNWaep=j_Pi6YAz_hsCxR2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VeO9NGAU_zH99wqS9F9mXANNWaep=j_Pi6YAz_hsCxR2g@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 09:24:55PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 2, 2020 at 8:47 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> > On Fri, Oct 02, 2020 at 01:22:46PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 02, 2020 at 01:28:11AM +0300, Serge Semin wrote:
> 
> > > > +   /*
> > > > +    * Update CR0 data each time the setup callback is invoked since
> > > > +    * the device parameters could have been changed, for instance, by
> > > > +    * the MMC SPI driver or something else.
> > > > +    */
> > > > +   chip->cr0 = dw_spi_get_cr0(dws, spi);
> > >
> >
> > > I would rather name it prepare or alike. 'get' assumes getting value or
> > > something like that.
> >
> > This seems reasonable. What verb do you think would be better: prepare,
> > calc, assemble, construct, make, compute, collect, compose, form, compile, etc ?
> > Personally prepare or calc or assemble are the best candidates. What do you
> > think?
> 

> prepare is good enough if you agree on it.

Ok. "prepare" it is then.

-Sergey

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
