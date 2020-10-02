Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0744F281904
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJBRSy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 13:18:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52172 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRSy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 13:18:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1B787803017F;
        Fri,  2 Oct 2020 17:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PCURxKfZ5pJw; Fri,  2 Oct 2020 20:18:50 +0300 (MSK)
Date:   Fri, 2 Oct 2020 20:18:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/21] spi: dw: Add DWC SSI capability
Message-ID: <20201002171849.jhio6nz6r6jigrf3@mobilestation>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-3-Sergey.Semin@baikalelectronics.ru>
 <20201002101929.GW3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201002101929.GW3956970@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 01:19:29PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2020 at 01:28:10AM +0300, Serge Semin wrote:
> > Currently DWC SSI core is supported by means of setting up the
> > core-specific update_cr0() callback. It isn't suitable for multiple
> > reasons. First of all having exported several methods doing the same thing
> > but for different chips makes the code harder to maintain. Secondly the
> > spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets
> > the private data callback with one of them so to be called by the core
> > driver again. That makes the code logic too complicated. Thirdly using
> > callbacks for just updating the CR0 register is problematic, since in case
> > if the register needed to be updated from different parts of the code,
> > we'd have to create another callback (for instance the SPI device-specific
> > parameters don't need to be calculated each time the SPI transfer is
> > submitted, so it's better to pre-calculate the CR0 data at the SPI-device
> > setup stage).
> > 
> > So keeping all the above in mind let's discard the update_cr0() callbacks,
> > define a generic and static dw_spi_update_cr0() method and create the
> > DW_SPI_CAP_DWC_SSI capability, which when enabled would activate the
> > alternative CR0 register layout.
> > 
> > While at it add the comments to the code path of the normal DW APB SSI
> > controller setup to make the dw_spi_update_cr0() method looking coherent.
> 

> What the point to increase indentation level and produce additional churn?
> Can't you simply leave functions, unexport them, and call in one conditional of
> whatever new function is called?

I forgot to mention that in the commit log, there is another reason why it's
better to create a generic dw_spi_update_cr0() instead of doing what you suggest.
As it will be seen from the following up patches, the dw_spi_update_cr0() function
(to be more precise it's successor, but anyway) will be used from the SPI memory
ops implementation. So if-else-ing here and there isn't a good idea for
maintainability. For the same reason of the maintainability it's better to have a
generic method which reflects all the config peculiarities, so in case of any
changes they would be not be forgotten to be introduced for both DWC SSI and DW
APB SSI parts of the setup procedures. As I see it that overbeats the additional
indentation level drawback.

-Sergey

> 
> I have an impression that split of the series is done in a way that first
> patches in the series are not optimized to what is done in the last patches in
> the series.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
