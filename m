Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473132B81F1
	for <lists+linux-spi@lfdr.de>; Wed, 18 Nov 2020 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgKRQ3j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Nov 2020 11:29:39 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:51306 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgKRQ3j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Nov 2020 11:29:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id F071A8030809;
        Wed, 18 Nov 2020 16:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qaudjfTZt0c0; Wed, 18 Nov 2020 19:29:33 +0300 (MSK)
Date:   Wed, 18 Nov 2020 19:29:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-ID: <20201118162931.sdpofyw74yyr5n5z@mobilestation>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
 <20201118131604.GC4827@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201118131604.GC4827@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 18, 2020 at 01:16:04PM +0000, Mark Brown wrote:
> On Tue, Nov 17, 2020 at 12:45:17PM +0300, Serge Semin wrote:
> 
> > method being called at the same time. In particular in calling the
> > spi_set_cs(false) while there is an SPI-transfer being executed. In my
> > case due to the commit cited above all CSs get to be switched off by
> > calling the spi_setup() for /dev/spidev0.1 while there is an concurrent
> > SPI-transfer execution performed on /dev/spidev0.0. Of course a situation
> > of the spi_setup() being called while there is an SPI-transfer being
> > executed for two different SPI peripheral devices of the same controller
> > may happen not only for the spidev driver, but for instance for MMC SPI +
> > some another device, or spi_setup() being called from an SPI-peripheral
> > probe method while some other device has already been probed and is being
> > used by a corresponding driver...
> 
> It's documented that a driver's spi_setup() operation is supposed to
> support being able to be called concurrently with other transfers, see
> spi-summary.rst.
> 
> > Of course I could have provided a fix affecting the DW APB SSI driver
> > only, for instance, by creating a mutual exclusive access to the set_cs
> > callback and setting/clearing only the bit responsible for the
> > corresponding chip-select. But after a short research I've discovered that
> > the problem most likely affects a lot of the other drivers:
> 
> Yeah, problems with it are very common as the documentation has noted
> since forever.  IIRC there was some problem triggered by trying to force
> it to be serialised but I can't remember what it was.

Does it mean nack for this patch from you? So you suggest to fix the controller
driver instead, right? If so the best solution would be to just lock the
IO mutex in the set_cs callback of the DW APB SSI driver...

-Sergey

