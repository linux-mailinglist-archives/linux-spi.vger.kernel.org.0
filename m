Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69F23465F
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgGaM75 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 08:59:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60806 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgGaM75 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jul 2020 08:59:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A80588040A69;
        Fri, 31 Jul 2020 12:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8HSGj1xyjX_I; Fri, 31 Jul 2020 15:59:55 +0300 (MSK)
Date:   Fri, 31 Jul 2020 15:59:54 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Feng Tang <feng.tang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] spi: dw-dma: Add max SG entries burst capability
 support
Message-ID: <20200731125954.jeeqmccnknqllwxh@mobilestation>
References: <20200731075953.14416-1-Sergey.Semin@baikalelectronics.ru>
 <20200731092612.GK3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200731092612.GK3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 31, 2020 at 12:26:12PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 31, 2020 at 10:59:45AM +0300, Serge Semin wrote:
> 
> ...
> 
> > Note since the DMA-engine subsystem in kernel 5.8-rcX doesn't have the
> > max_sg_burst capability supported, this series is intended to be applied
> > only after the "next"-branch of the DMA-engine repository is merged into
> > the mainline repo. Alternatively the series could be merged in through the
> > DMA-engine repo.
> 

> This needs to be thought through...

There is nothing to think about: either Mark completes review/accepts the series
and Vinod agrees to merge it in through the DMA-engine repo, or we'll have to
wait until the next merge window is closed and then merge the series in
traditionally through the SPI repo.

-Sergey

> 
> I gave some simple comments (and on top just try not to modify the same lines
> inside one series two or more times, e.g. ret = func() -> return func() -> ret
> = func() in one case).
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
