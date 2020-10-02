Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DFF281A0A
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 19:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgJBRrb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 13:47:31 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52228 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBRra (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 13:47:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 21549803017E;
        Fri,  2 Oct 2020 17:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mPHAd0rBnzBP; Fri,  2 Oct 2020 20:47:26 +0300 (MSK)
Date:   Fri, 2 Oct 2020 20:47:26 +0300
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
Subject: Re: [PATCH v3 03/21] spi: dw: Detach SPI device specific CR0 config
 method
Message-ID: <20201002174725.rpwdgfo6xzxafqhs@mobilestation>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-4-Sergey.Semin@baikalelectronics.ru>
 <20201002102246.GX3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201002102246.GX3956970@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 01:22:46PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2020 at 01:28:11AM +0300, Serge Semin wrote:
> > Indeed there is no point in detecting the SPI peripheral device parameters
> > and initializing the CR0 register fields each time an SPI transfer is
> > executed. Instead let's define a dedicated CR0 chip-data member, which
> > will be initialized in accordance with the SPI device settings at the
> > moment of setting it up.
> > 
> > By doing so we'll finally make the SPI device chip_data serving as it's
> > supposed to - to preserve the SPI device specific DW SPI configuration.
> > See spi-fsl-dspi.c, spi-pl022.c, spi-pxa2xx.c drivers for example of the
> > way the chip data is utilized.
> 
> > +static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
> > +			      struct spi_transfer *transfer)
> 

> Yep, why not to place this in previous patch exactly here?

The previous patch is about introducing the DWC SSI capability. This one is
about splitting the functionality up.

> 
> > +	/*
> > +	 * Update CR0 data each time the setup callback is invoked since
> > +	 * the device parameters could have been changed, for instance, by
> > +	 * the MMC SPI driver or something else.
> > +	 */
> > +	chip->cr0 = dw_spi_get_cr0(dws, spi);
> 

> I would rather name it prepare or alike. 'get' assumes getting value or
> something like that.

This seems reasonable. What verb do you think would be better: prepare,
calc, assemble, construct, make, compute, collect, compose, form, compile, etc ?
Personally prepare or calc or assemble are the best candidates. What do you
think?

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
