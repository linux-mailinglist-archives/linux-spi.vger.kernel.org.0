Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4153371F05
	for <lists+linux-spi@lfdr.de>; Mon,  3 May 2021 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhECR46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 May 2021 13:56:58 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:43293 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECR46 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 May 2021 13:56:58 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D76F0100B08E4;
        Mon,  3 May 2021 19:56:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A26DA28CC7; Mon,  3 May 2021 19:56:00 +0200 (CEST)
Date:   Mon, 3 May 2021 19:56:00 +0200
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
Message-ID: <20210503175600.GA3864@wunner.de>
References: <20210426235638.1285530-1-saravanak@google.com>
 <20210503100733.GA8114@wunner.de>
 <CAGETcx8qPg9NUS6BJLEJCZ-2La32_NPeaMf1GDArcWT6tsf_AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8qPg9NUS6BJLEJCZ-2La32_NPeaMf1GDArcWT6tsf_AQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 03, 2021 at 10:21:59AM -0700, Saravana Kannan wrote:
> On Mon, May 3, 2021 at 3:07 AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Apr 26, 2021 at 04:56:38PM -0700, Saravana Kannan wrote:
> > > When an SPI device is unregistered, the spi->controller->cleanup() is
> > > called in the device's release callback. That's wrong for a couple of
> > > reasons:
> > >
> > > 1. spi_dev_put() can be called before spi_add_device() is called. And
> > >    it's spi_add_device() that calls spi_setup(). This will cause clean()
> > >    to get called without the spi device ever being setup.
> >
> > Well, yes, but it's not a big problem in practice so far:
> >
> > I've checked all drivers and there are only four which are affected
> > by this: spi-mpc512x-psc.c spi-pic32.c spi-s3c64xx.c spi-st-ssc4.c
> >
> > They all fiddle with the chipselect GPIO in their ->cleanup hook
> > and the GPIO may not have been requested yet because that happens
> > during ->setup.
> >
> > All the other drivers merely invoke kzalloc() on ->setup and kfree()
> > on ->cleanup.  The order doesn't matter in this case because
> > kfree(NULL) is a no-op.
> 
> That's making a lot of assumptions about drivers not doing certain
> things in the future or making assumptions about the hardware (chip
> select or whatever other configuration that might happen). Totally
> unnecessary and error prone.

I agree, I'm just not happy with the solution presented.

This could be solved by setting a flag in struct spi_device
once ->setup has returned successfully.


> > > 2. There's no guarantee that the controller's driver would be present by
> > >    the time the spi device's release function gets called.
> >
> > How so?  spi_devices are instantiated on ->probe of the controller
> > via spi_register_controller() and destroyed on ->remove via
> > spi_unregister_controller().  I don't see how the controller driver
> > could ever be unavailable, so this point seems moot.
> 
> Just because put_device() is called on a struct device doesn't mean
> it's getting destroyed immediately. The refcount needs to reach zero
> for ->cleanup() to be called eventually. And there's no guarantee that
> by the time the ref count hits zero that your controller driver is
> still around. So, it's not a moot point.

In theory, yes, but concretely, how is that going to happen?

We remove all the things that might be holding a ref on the spi_device
(such as sysfs entries, child devices), so when device_unregister()
is called from spi_unregister_device(), the expectation is really that
that's the last reference being dropped.

In theory it would be possible for some other driver to hold a ref,
but I don't see why it would be doing that.

Perhaps spidev.c makes it possible to keep an spi_device around even
though the controller has been removed, simply by keeping the device
file open from user space.  I'm not sure if that's the case but it's
probably something worth checking.


> > > Fix these issues by simply moving the cleanup from the device release
> > > callback to the actual spi_unregister_device() function.
> >
> > Unfortunately the fix is wrong, it introduces a new problem:
> >
> > > @@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
> > >       if (!spi)
> > >               return;
> > >
> > > +     spi_cleanup(spi);
> > > +
> > >       if (spi->dev.of_node) {
> > >               of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
> > >               of_node_put(spi->dev.of_node);
> >
> > Now you're running ->cleanup before the SPI slave's driver is unbound.
> 
> By "slave" device, you mean struct spi_device, right?

Yes.


> Sorry if I'm mistaken about my understanding of the SPI framework.
> Please explain how that's happening here. The main place
> spi_unregister_device() is getting called from is
> spi_controller_unregister(). If the controller's child/slave
> spi_device's aren't unbound by then, you've got bigger problems even
> without my patch?

Without your patch:

spi_unregister_device()
  device_unregister()
    device_del()
      bus_remove_device()
        device_release_driver() # access to physical SPI device in ->remove()
    put_device()
      kobject_put()
        kref_put()
	  kobject_release()
	    kobject_cleanup()
	      device_release()
	        spidev_release()
		  spi->controller->cleanup() # controller_state freed

With your patch:

spi_unregister_device()
  spi_cleanup()
    spi->controller->cleanup() # controller_state freed
  device_unregister()
    device_del()
      bus_remove_device()
        device_release_driver() # access to physical SPI device in ->remove()

As a case in point, an SPI Ethernet driver I'm familiar with,
drivers/net/ethernet/micrel/ks8851_common.c, performs various
register accesses on driver unbind in ks8851_net_stop().
So on driver unbind, the SPI device still needs to be accessible.

However the controller_state may be necessary to access the device,
so freeing that before unbind is a no-go.

Let me know if this explanation wasn't sufficient.

Thanks,

Lukas
