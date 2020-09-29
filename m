Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452F027DC30
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 00:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgI2WnI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Sep 2020 18:43:08 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:37140 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgI2WnI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Sep 2020 18:43:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5E6698030719;
        Tue, 29 Sep 2020 22:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AsX_kHAlHXIb; Wed, 30 Sep 2020 01:43:04 +0300 (MSK)
Date:   Wed, 30 Sep 2020 01:43:03 +0300
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
Subject: Re: [PATCH 00/30] spi: dw: Add full Baikal-T1 SPI Controllers support
Message-ID: <20200929224303.65awobe5dzwc2p4f@mobilestation>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
 <20200929144351.GH4799@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200929144351.GH4799@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark

On Tue, Sep 29, 2020 at 03:43:51PM +0100, Mark Brown wrote:
> On Sun, Sep 20, 2020 at 02:28:44PM +0300, Serge Semin wrote:
> 
> > First two patches are just cleanups to simplify the DW APB SSI device
> > initialization a bit. We suggest to discard the IRQ threshold macro as
> > unused and use a ternary operator to initialize the set_cs callback
> > instead of assigning-and-updating it.
> 
> > Then we've discovered that the n_bytes field of the driver private data is
> > used by the DW APB SSI IRQ handler, which requires it to be initialized
> 

> This is a *huge* patch series which is a bit unweildy to review
> (especially given the other 10+ patch series you sent at the same time),

Yeah, sorry about the bulky series. If most of the changes have been more
complicated than that, less inter-dependent and less directed to having the code
prepared for the main alterations I would have definitely split them up in
different series. But the biggest part of the patchset is just a preparation
before adding the mem-ops, poll-based transfers and Baikal-T1 SPI support. So
having them submitted without the main part of the patchset would be just weird.

The other 10+ patches were sent months ago. I've just resent them with minor
alterations to get more attention.) Anyway since they concern an absolutely
different functionality (DW APB SSI DMA driver) of course I've delivered them in
the framework of the different patchset.

> once you start getting over 10 patches it's time to pay attention to
> series length and the fact that you're outlining a bunch of tangentially
> related areas which could have been split out easily enough.  It is much
> better to send smaller sets of patches at once, or if you're sending a
> lot then to split them into smaller serieses.  This will tend to make
> the review more approachable which will in turn tend to make things go
> faster, people are much more likely to put off going through a huge
> series.

I see you have already merged in the first nine patches. So would you like me
to split the rest of them up into two series or it would be ok to resend (if
required) them as one series seeing it's not that bulky anymore?

-Sergey
