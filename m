Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23ED9281CAC
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 22:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJBUMa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 16:12:30 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52614 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJBUMa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 16:12:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 171BA803017F;
        Fri,  2 Oct 2020 20:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j4oElvGK0yI3; Fri,  2 Oct 2020 23:12:22 +0300 (MSK)
Date:   Fri, 2 Oct 2020 23:12:21 +0300
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
Subject: Re: [PATCH v3 02/21] spi: dw: Add DWC SSI capability
Message-ID: <20201002201221.vaevfnyteu26pyol@mobilestation>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-3-Sergey.Semin@baikalelectronics.ru>
 <20201002101929.GW3956970@smile.fi.intel.com>
 <20201002171849.jhio6nz6r6jigrf3@mobilestation>
 <CAHp75Vd7KS+sGT=1aZLJXzQi+L3wZ1430dj1TmE=u3PUHoDz7Q@mail.gmail.com>
 <20201002194609.4l7fifu2kkxtrszo@mobilestation>
 <20201002200829.belx73ez3n4hympp@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201002200829.belx73ez3n4hympp@mobilestation>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 11:08:29PM +0300, Serge Semin wrote:
> On Fri, Oct 02, 2020 at 10:46:09PM +0300, Serge Semin wrote:
> > On Fri, Oct 02, 2020 at 09:26:07PM +0300, Andy Shevchenko wrote:
> > > On Fri, Oct 2, 2020 at 8:18 PM Serge Semin
> > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > On Fri, Oct 02, 2020 at 01:19:29PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Oct 02, 2020 at 01:28:10AM +0300, Serge Semin wrote:
> > > > > > Currently DWC SSI core is supported by means of setting up the
> > > > > > core-specific update_cr0() callback. It isn't suitable for multiple
> > > > > > reasons. First of all having exported several methods doing the same thing
> > > > > > but for different chips makes the code harder to maintain. Secondly the
> > > > > > spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets
> > > > > > the private data callback with one of them so to be called by the core
> > > > > > driver again. That makes the code logic too complicated. Thirdly using
> > > > > > callbacks for just updating the CR0 register is problematic, since in case
> > > > > > if the register needed to be updated from different parts of the code,
> > > > > > we'd have to create another callback (for instance the SPI device-specific
> > > > > > parameters don't need to be calculated each time the SPI transfer is
> > > > > > submitted, so it's better to pre-calculate the CR0 data at the SPI-device
> > > > > > setup stage).
> > > > > >
> > > > > > So keeping all the above in mind let's discard the update_cr0() callbacks,
> > > > > > define a generic and static dw_spi_update_cr0() method and create the
> > > > > > DW_SPI_CAP_DWC_SSI capability, which when enabled would activate the
> > > > > > alternative CR0 register layout.
> > > > > >
> > > > > > While at it add the comments to the code path of the normal DW APB SSI
> > > > > > controller setup to make the dw_spi_update_cr0() method looking coherent.
> > > > >
> > > >
> > > > > What the point to increase indentation level and produce additional churn?
> > > > > Can't you simply leave functions, unexport them, and call in one conditional of
> > > > > whatever new function is called?
> > > >
> > > > I forgot to mention that in the commit log, there is another reason why it's
> > > > better to create a generic dw_spi_update_cr0() instead of doing what you suggest.
> > > > As it will be seen from the following up patches, the dw_spi_update_cr0() function
> > > > (to be more precise it's successor, but anyway) will be used from the SPI memory
> > > > ops implementation. So if-else-ing here and there isn't a good idea for
> > > > maintainability. For the same reason of the maintainability it's better to have a
> > > > generic method which reflects all the config peculiarities, so in case of any
> > > > changes they would be not be forgotten to be introduced for both DWC SSI and DW
> > > > APB SSI parts of the setup procedures. As I see it that overbeats the additional
> > > > indentation level drawback.
> > > 
> > 
> > > What I meant is to leave functions as is and call them under conditional
> > > 
> > > if ()
> > >  call one
> > > else
> > >  call another
> > 
> > Yeah, I understood what you meant. What you suggest would be a better solution
> > if I needed to call the dw_spi_update_cr0() method just from a single place of
> > the driver (but in that case I wouldn't need to replace the callback-based
> > approach with the Capabilities-based one at all). The thing is that the
> > dw_spi_update_cr0() will be also called from the SPI memory exec_op() callback
> > (see patch "[PATCH v3 17/21] spi: dw: Add memory operations support" and the
> > method dw_spi_update_config() invocation) in the same way as it is called from
> > the SPI core transfer-one callback. Following your suggestion I would have to
> > implement the same "if () call one else call another" pattern there too. Copying
> > it here and there would be a weak design from the maintainability point of view
> > and from the coding style too. Much better is to create a generic
> > dw_spi_update_cr0() (later in this patchset it will be renamed to
> > dw_spi_update_config()...), which would work for both DWC SSI and DW APB SSI by
> > embedding the "if (is_CAP) call one else call another" into the method itself as
> > I suggested in this patch.
> 
> Oh, and the same "if-else" pattern would need to be either left in the
> dw_spi_get_cr0()/dw_spi_prepare_cr0() or added around the dw_spi_prepare_cr0()

* I meant dw_spi_update_cr0() here...

-Sergey

> method invocation with creating two versions of it. So no, I'd stick with the
> design I suggested in this patch: just two "if-else"s and the generic versions
> of the dw_spi_prepare_cr0() and dw_spi_update_cr0() functions.
> 
> -Sergey
> 
> > 
> > -Sergey
> > 
> > > 
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
