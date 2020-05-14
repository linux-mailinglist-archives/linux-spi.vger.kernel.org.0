Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BBE1D309B
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgENNEO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 09:04:14 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:58910 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENNEO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 09:04:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4DA46803087B;
        Thu, 14 May 2020 13:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1H7tDBhNpUNg; Thu, 14 May 2020 16:04:08 +0300 (MSK)
Date:   Thu, 14 May 2020 16:04:07 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no
 IRQ specified in DT
Message-ID: <20200514130407.guyk3r4ltjvszy5s@mobilestation>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-2-lars.povlsen@microchip.com>
 <20200513142050.GH4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513142050.GH4803@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark

On Wed, May 13, 2020 at 03:20:50PM +0100, Mark Brown wrote:
> On Wed, May 13, 2020 at 04:00:22PM +0200, Lars Povlsen wrote:
> > With this change a SPI controller can be added without having a IRQ
> > associated, and causing all transfers to be polled. For SPI controllers
> > without DMA, this can significantly improve performance by less
> > interrupt handling overhead.
> 
> This overlaps substantially with some work that Serge Semin (CCed) has
> in progress, please coordinate with him.

Thanks for copying me these mails. I haven't been Cc'ed in the series and
hasn't been subscribed to the SPI mailing list, so I would have definitely
missed that.

I would like to coordinate my efforts with Lars. I'll have the patchset reviewed
soon in addition providing my comments/suggestions of how to make it useful for
both mine and Lars solution.

One thing I can tell about the mem_ops he implemented, is that they aren't
mem_ops, but dirmap (as you remember it's also implemented in my code, but with
alignment specific), and the exec_mem_op partly consists of a code, which belong
to the supports_op() callback. The rest of my comments will be inlined in the
patches.

-Sergey
