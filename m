Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8800371E7F
	for <lists+linux-spi@lfdr.de>; Mon,  3 May 2021 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhECRXc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 May 2021 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhECRXb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 May 2021 13:23:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3386C061761
        for <linux-spi@vger.kernel.org>; Mon,  3 May 2021 10:22:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y2so8486283ybq.13
        for <linux-spi@vger.kernel.org>; Mon, 03 May 2021 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjBwCGka9h3apbjVqlgSifQtNSglR1AQA2/HzLhtPUM=;
        b=bR8o9peF1RKQ0Dlx/F/sLjc3Goo+1BHC9xLpaukIy4ag9B1cGFQ4TI5dqkHJiGZB3r
         3lQ0PgtRwtM3n8ZuFpK61sKagi2TYNsuczok8b8CGPF5X05aJMJ2XwkRWvPX1g4MQbvd
         3oEJ21rsSBVu1V12X3kTYKWTrz+py8RgHdNsQvCpXYdSj23cv0pNJ0pm9iI7G/I2kX/G
         bFWj2Oe8n/a1M8XAJZOw6hrtlcKyMCpQffpfl0ODqg+J1Q9+Y06nYThLjUEnnerZfidq
         d2YObPja7pMBEiE4aW1FJAByqpbrf17S9OwLZdYRe3Dm58Ii7je7wUvhWFfh8mAIIVxV
         RSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjBwCGka9h3apbjVqlgSifQtNSglR1AQA2/HzLhtPUM=;
        b=nA8bKfCYbJ8IgUmAjGlQShbRrt2VFPCh7k2zQDg87yEvHnBUkiqymG9G3WUX8Gc4f0
         84iYL16mxTdGQ0Cw25N2TbtihLwUwF3sAeexwWrzgUoWI6Ac7LBzVF5/GKMPKqWFu/PK
         fsFRwKAXrOddisAH2VdVJtMaw3kIJjfqQ0cDE0foSNfwD/TX3ciKer6q+AbQk8MYKEDH
         VyA7PJAhTKZOHnsHycAyyGHo60CO0ZPdjEQtmtxspfORr5aruZ1BIASOCZMzxr58u5kP
         M1JJgfC5YWTsPy8g+LyCBJCsNmlAQnZfJa4aKwQ+LveIv7nJ2v7dKXgI4Jg9V1EOgb9j
         PDPg==
X-Gm-Message-State: AOAM532sV+N/DY9ONl/NFP8SM4VRXBvHurb+4NeE1mknvTYRGaIGD8s0
        /mcvGgUeNUCw5uw2FAzLIyfuGvo+7dkQ5fUz101pwQ==
X-Google-Smtp-Source: ABdhPJzIrNCXGtuI2f36all1AEtZR951Sw8Cm9eOxHD9qPYSjsZeb+ovKkGr0cYdmlX19Mh9YLr7A9cukRVRZZ22UpY=
X-Received: by 2002:a25:6003:: with SMTP id u3mr29692446ybb.96.1620062555877;
 Mon, 03 May 2021 10:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210426235638.1285530-1-saravanak@google.com> <20210503100733.GA8114@wunner.de>
In-Reply-To: <20210503100733.GA8114@wunner.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 3 May 2021 10:21:59 -0700
Message-ID: <CAGETcx8qPg9NUS6BJLEJCZ-2La32_NPeaMf1GDArcWT6tsf_AQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 3, 2021 at 3:07 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Apr 26, 2021 at 04:56:38PM -0700, Saravana Kannan wrote:
> > When an SPI device is unregistered, the spi->controller->cleanup() is
> > called in the device's release callback. That's wrong for a couple of
> > reasons:
> >
> > 1. spi_dev_put() can be called before spi_add_device() is called. And
> >    it's spi_add_device() that calls spi_setup(). This will cause clean()
> >    to get called without the spi device ever being setup.
>
> Well, yes, but it's not a big problem in practice so far:
>
> I've checked all drivers and there are only four which are affected
> by this: spi-mpc512x-psc.c spi-pic32.c spi-s3c64xx.c spi-st-ssc4.c
>
> They all fiddle with the chipselect GPIO in their ->cleanup hook
> and the GPIO may not have been requested yet because that happens
> during ->setup.
>
> All the other drivers merely invoke kzalloc() on ->setup and kfree()
> on ->cleanup.  The order doesn't matter in this case because
> kfree(NULL) is a no-op.

That's making a lot of assumptions about drivers not doing certain
things in the future or making assumptions about the hardware (chip
select or whatever other configuration that might happen). Totally
unnecessary and error prone.

>
>
> > 2. There's no guarantee that the controller's driver would be present by
> >    the time the spi device's release function gets called.
>
> How so?  spi_devices are instantiated on ->probe of the controller
> via spi_register_controller() and destroyed on ->remove via
> spi_unregister_controller().  I don't see how the controller driver
> could ever be unavailable, so this point seems moot.

Just because put_device() is called on a struct device doesn't mean
it's getting destroyed immediately. The refcount needs to reach zero
for ->cleanup() to be called eventually. And there's no guarantee that
by the time the ref count hits zero that your controller driver is
still around. So, it's not a moot point.

> > Fix these issues by simply moving the cleanup from the device release
> > callback to the actual spi_unregister_device() function.
>
> Unfortunately the fix is wrong, it introduces a new problem:
>
> > @@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
> >       if (!spi)
> >               return;
> >
> > +     spi_cleanup(spi);
> > +
> >       if (spi->dev.of_node) {
> >               of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
> >               of_node_put(spi->dev.of_node);
>
> Now you're running ->cleanup before the SPI slave's driver is unbound.

By "slave" device, you mean struct spi_device, right?

Sorry if I'm mistaken about my understanding of the SPI framework.
Please explain how that's happening here. The main place
spi_unregister_device() is getting called from is
spi_controller_unregister(). If the controller's child/slave
spi_device's aren't unbound by then, you've got bigger problems even
without my patch?

> That's bad, the driver may need to access the physical device on unbound,
> e.g. to quiesce interrupts.  That may not work now because the
> slave's controller_state is gone.
>
> NAK, this needs to be reverted.

Please help me understand how this is broken. It's not clear to me.

-Saravana
