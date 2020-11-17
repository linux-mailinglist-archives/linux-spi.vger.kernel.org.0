Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B62B5E3D
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 12:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgKQL22 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 06:28:28 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:42262 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQL22 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Nov 2020 06:28:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3A926803071C;
        Tue, 17 Nov 2020 11:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3b7RSBy8AN_V; Tue, 17 Nov 2020 14:28:23 +0300 (MSK)
Date:   Tue, 17 Nov 2020 14:28:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-ID: <20201117112823.fwadsn5ld7ovjqun@mobilestation>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VfgdtLxh3uWd-79vEL9bDA0CH2Jiug2g2cJ0R0mQRhW2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VfgdtLxh3uWd-79vEL9bDA0CH2Jiug2g2cJ0R0mQRhW2A@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 17, 2020 at 12:56:44PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2020 at 11:45 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > I've discovered that due to the recent commit 49d7d695ca4b ("spi: dw:
> > Explicitly de-assert CS on SPI transfer completion") a concurrent usage of
> > the spidev devices with different chip-selects causes the "SPI transfer
> > timed out" error.
> 
> I'll read this later...
> 
> > +       mutex_lock(&spi->controller->io_mutex);
> > +
> >         if (spi->controller->setup)
> >                 status = spi->controller->setup(spi);
> >
> >         if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
> >                 status = pm_runtime_get_sync(spi->controller->dev.parent);
> 

> I didn't check what this lock is protecting,

It is used to protect the SPI io operations. So it's locked only
during the SPI memory operations and the SPI-message execution. That's
the time when the core toggles the controller chip-selects by calling
the spi_set_cs() method and the set_cs callback.

> but have you checked all
> PM runtime callbacks if they are not taking the lock. When you call PM
> runtime functions with 'sync' it may include a lot of work, some of
> which may sleep (not a problem for mutex) and may take arbitrary locks
> (might be a deadlock in case of trying the same lock).

Yeah, I understand that. Simple grepping hasn't showed anyone else but
the SPI-core using it. So unless the controllers PM methods also call
spi_setup() or request SPI-transfers, there shouldn't be a deadlock.
Moreover as I can see from the __spi_pump_messages() method the
IO-mutex is locked during the sync-suffixed PM-methods invocation.
AFAICS locking io_mutex around the PM-methods here shouldn't cause
problems. But of course testing it in various platforms/controllers is
always welcome.

-Sergey

> 
> >                 if (status < 0) {
> > +                       mutex_unlock(&spi->controller->io_mutex);
> >                         pm_runtime_put_noidle(spi->controller->dev.parent);
> >                         dev_err(&spi->controller->dev, "Failed to power device: %d\n",
> >                                 status);
> > @@ -3354,6 +3357,8 @@ int spi_setup(struct spi_device *spi)
> >                 spi_set_cs(spi, false);
> >         }
> >
> > +       mutex_unlock(&spi->controller->io_mutex);
> > +
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
