Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273D33727FB
	for <lists+linux-spi@lfdr.de>; Tue,  4 May 2021 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhEDJTJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 May 2021 05:19:09 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:51487 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhEDJTJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 May 2021 05:19:09 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4A2472800BD97;
        Tue,  4 May 2021 11:17:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 397F82CCEE; Tue,  4 May 2021 11:17:54 +0200 (CEST)
Date:   Tue, 4 May 2021 11:17:54 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
Message-ID: <20210504091754.GA22045@wunner.de>
References: <20210426235638.1285530-1-saravanak@google.com>
 <20210503100733.GA8114@wunner.de>
 <CAGETcx8qPg9NUS6BJLEJCZ-2La32_NPeaMf1GDArcWT6tsf_AQ@mail.gmail.com>
 <20210503175600.GA3864@wunner.de>
 <CAGETcx_Z9kjzjTaNUBgKNte8UZcT5HJ5tjkmRmFqddy78Nj9Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_Z9kjzjTaNUBgKNte8UZcT5HJ5tjkmRmFqddy78Nj9Qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 03, 2021 at 11:15:50AM -0700, Saravana Kannan wrote:
> On Mon, May 3, 2021 at 10:56 AM Lukas Wunner <lukas@wunner.de> wrote:
> > Without your patch:
> >
> > spi_unregister_device()
> >   device_unregister()
> >     device_del()
> >       bus_remove_device()
> >         device_release_driver() # access to physical SPI device in ->remove()
> >     put_device()
> >       kobject_put()
> >         kref_put()
> >           kobject_release()
> >             kobject_cleanup()
> >               device_release()
> >                 spidev_release()
> >                   spi->controller->cleanup() # controller_state freed
> >
> > With your patch:
> >
> > spi_unregister_device()
> >   spi_cleanup()
> >     spi->controller->cleanup() # controller_state freed
> >   device_unregister()
> >     device_del()
> >       bus_remove_device()
> >         device_release_driver() # access to physical SPI device in ->remove()
[...]
> So, it looks like the fix is simple. We just need to move
> spi_cleanup() to the bottom of spi_unregister_device(). I'll send a
> patch for that rather than reverting this and bringing back the other
> bugs.

That would result in a use-after-free if the call to device_unregister()
indeed releases the last ref to the spi_device (which I'd expect is
usually the case).

However, something like this might work (in spi_unregister_device()):

	device_del(&spi->dev);
	spi_cleanup(spi);
	put_device(&spi->dev);

Thanks,

Lukas
