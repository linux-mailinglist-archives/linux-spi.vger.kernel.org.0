Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAC2BEFA5
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfIZKc5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 06:32:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42249 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfIZKc5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 06:32:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so1521406otd.9;
        Thu, 26 Sep 2019 03:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Duz8utOpoc6VMlyYaWVHB4Tg3adc/eRlD/32GNIC7s0=;
        b=OFNo/O2bthgg0+b0Dtv8you9xaVad2Vut1q62ZQMpDmngRWZnGZ8LbWmaVguP+Cgat
         z58ePQC8y9qVXQN9VPd6qoLLOF8HMPJtQOI619UZ514u1B/1KPTHj6rdUq9SX1RQQACx
         MMaOT2M5KiBsrn4VAgNCwcWnwMHInNTavpV+uial7xEIG6suX6XhegnY9G6HnZEc3jPN
         +zNrpMcEJaC+0GXpJ1Dkn/FeYiVynyBtAuEIxQYOeKnIkg8L8zy+MvrRMi36C2P5WhC3
         XNOsQC9BAL9lpgjUNfBKSztgG7MyxJ8cQ+5T7s+9dMJWtqJX1m4QRnepSbzKBaIifaSk
         rGcQ==
X-Gm-Message-State: APjAAAUX45YOykrfEoMQ8W8s7NWySGMEEbbNLRlVvT/2ypPlF6DYtLI8
        DUDJJvr5m3FtxtIgaT5qcUbsrGXC49dSae7o9ub5E+0e
X-Google-Smtp-Source: APXvYqy3txWFOW1H11XB3TMykWXT5VFCVtbTgG3+kKHhRTyVLKOzIpcvggmlKjhEFtHbKq7dTs+8lhQbaC+m2BXszCY=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr2070947oti.39.1569493976623;
 Thu, 26 Sep 2019 03:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com> <20190926121438.655f1f10@jawa>
In-Reply-To: <20190926121438.655f1f10@jawa>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 12:32:45 +0200
Message-ID: <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver is released
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukasz,

On Thu, Sep 26, 2019 at 12:14 PM Lukasz Majewski <lukma@denx.de> wrote:
> > Static analysis with Coverity has detected an potential dereference
> > of a free'd object with commit:
> >
> > commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
> > Author: Lukasz Majewski <lukma@denx.de>
> > Date:   Wed Sep 25 11:11:42 2019 +0200
> >
> >     spi: Add call to spi_slave_abort() function when spidev driver is
> > released
> >
> > In spidev_release() in drivers/spi/spidev.c the analysis is as
> > follows:
> >
> > 600static int spidev_release(struct inode *inode, struct file *filp)
> > 601{
> > 602        struct spidev_data      *spidev;
> > 603
> > 604        mutex_lock(&device_list_lock);
> >
> >    1. alias: Assigning: spidev = filp->private_data. Now both point to
> > the same storage.
> >
> > 605        spidev = filp->private_data;
> > 606        filp->private_data = NULL;
> > 607
> > 608        /* last close? */
> > 609        spidev->users--;
> >
> >    2. Condition !spidev->users, taking true branch.
> >
> > 610        if (!spidev->users) {
> > 611                int             dofree;
> > 612
> > 613                kfree(spidev->tx_buffer);
> > 614                spidev->tx_buffer = NULL;
> > 615
> > 616                kfree(spidev->rx_buffer);
> > 617                spidev->rx_buffer = NULL;
> > 618
> > 619                spin_lock_irq(&spidev->spi_lock);
> >
> >    3. Condition spidev->spi, taking false branch.
> >
> > 620                if (spidev->spi)
> > 621                        spidev->speed_hz =
> > spidev->spi->max_speed_hz; 622
> > 623                /* ... after we unbound from the underlying
> > device? */
> >
> >    4. Condition spidev->spi == NULL, taking true branch.
> >
> > 624                dofree = (spidev->spi == NULL);
> > 625                spin_unlock_irq(&spidev->spi_lock);
> > 626
> >
> >    5. Condition dofree, taking true branch.
> >
> > 627                if (dofree)
> >
> >    6. freed_arg: kfree frees spidev.
> >
> > 628                        kfree(spidev);
> > 629        }
> > 630#ifdef CONFIG_SPI_SLAVE
> >
> >    CID 89726 (#1 of 1): Read from pointer after free (USE_AFTER_FREE)
> > 7. deref_after_free: Dereferencing freed pointer spidev.
> >
> > 631        spi_slave_abort(spidev->spi);
> > 632#endif
> > 633        mutex_unlock(&device_list_lock);
> > 634
> > 635        return 0;
> > 636}
> >
> > The call to spi_slave_abort() on spidev is reading an earlier kfree'd
> > spidev.
>
> Thanks for spotting this issue - indeed there is a possibility to use
> spidev after being kfree'd.

Worse, this makes me realize spidev->spi may be a NULL pointer, which
will be dereferenced by spi_slave_abort(), so caching it before the
call to kfree() won't work.

> However, Geert (CC'ed) had some questions about placement of this
> function call, so I will wait with providing fix until he replies.

Seems like this needs more thought...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
