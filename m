Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF62809C0
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgJAVzt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 17:55:49 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47816 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAVzs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 17:55:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id BCEF3803016F;
        Thu,  1 Oct 2020 21:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2OTFGBUMBGex; Fri,  2 Oct 2020 00:55:40 +0300 (MSK)
Date:   Fri, 2 Oct 2020 00:55:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/21] spi: dw: Add DWC SSI capability
Message-ID: <20201001215532.uxyc77nqehnwsfk5@mobilestation>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
 <20200930185545.29959-3-Sergey.Semin@baikalelectronics.ru>
 <20201001215105.GA6618@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001215105.GA6618@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 01, 2020 at 10:51:05PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2020 at 09:55:26PM +0300, Serge Semin wrote:
> > Currently DWC SSI core is supported by means of setting up the
> > core-specific update_cr0() callback. It isn't suitable for multiple
> > reasons. First of all having exported several methods doing the same thing
> > but for different chips makes the code harder to maintain. Secondly the
> > spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets
> 

> This doesn't build with current code in an x86 defconfig, please check
> and resend (looks like you forgot to update dw-pci):
> 
> mnt/kernel/drivers/spi/spi-dw-pci.c: In function 'spi_mid_init':
> /mnt/kernel/drivers/spi/spi-dw-pci.c:52:5: error: 'struct dw_spi' has no member named 'update_cr0'
>   dws->update_cr0 = dw_spi_update_cr0;
>      ^~
> /mnt/kernel/drivers/spi/spi-dw-pci.c:52:20: error: 'dw_spi_update_cr0' undeclared (first use in this function); did you mean 'dw_spi_set_cs'?
>   dws->update_cr0 = dw_spi_update_cr0;
>                     ^~~~~~~~~~~~~~~~~
>                     dw_spi_set_cs
> /mnt/kernel/drivers/spi/spi-dw-pci.c:52:20: note: each undeclared identifier is reported only once for each function it appears in
> /mnt/kernel/drivers/spi/spi-dw-pci.c: In function 'spi_generic_init':
> /mnt/kernel/drivers/spi/spi-dw-pci.c:62:5: error: 'struct dw_spi' has no member named 'update_cr0'
>   dws->update_cr0 = dw_spi_update_cr0;
>      ^~
> /mnt/kernel/drivers/spi/spi-dw-pci.c:62:20: error: 'dw_spi_update_cr0' undeclared (first use in this function); did you mean 'dw_spi_set_cs'?
>   dws->update_cr0 = dw_spi_update_cr0;
>                     ^~~~~~~~~~~~~~~~~
>                     dw_spi_set_cs
> make[3]: *** [/mnt/kernel/scripts/Makefile.build:283: drivers/spi/spi-dw-pci.o] Error 1
> make[2]: *** [/mnt/kernel/scripts/Makefile.build:500: drivers/spi] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/Makefile:1788: drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:185: __sub-make] Error 2

Oh, thanks for noticing this. I'll fix it straight away and resend. Sorry for
the inconvenience.

-Sergey
