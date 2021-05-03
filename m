Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8C37135A
	for <lists+linux-spi@lfdr.de>; Mon,  3 May 2021 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhECKIb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 May 2021 06:08:31 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:49815 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhECKIb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 May 2021 06:08:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id E3FF030014809;
        Mon,  3 May 2021 12:07:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D5F1010C8F; Mon,  3 May 2021 12:07:33 +0200 (CEST)
Date:   Mon, 3 May 2021 12:07:33 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Fix spi device unregister flow
Message-ID: <20210503100733.GA8114@wunner.de>
References: <20210426235638.1285530-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426235638.1285530-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Apr 26, 2021 at 04:56:38PM -0700, Saravana Kannan wrote:
> When an SPI device is unregistered, the spi->controller->cleanup() is
> called in the device's release callback. That's wrong for a couple of
> reasons:
> 
> 1. spi_dev_put() can be called before spi_add_device() is called. And
>    it's spi_add_device() that calls spi_setup(). This will cause clean()
>    to get called without the spi device ever being setup.

Well, yes, but it's not a big problem in practice so far:

I've checked all drivers and there are only four which are affected
by this: spi-mpc512x-psc.c spi-pic32.c spi-s3c64xx.c spi-st-ssc4.c

They all fiddle with the chipselect GPIO in their ->cleanup hook
and the GPIO may not have been requested yet because that happens
during ->setup.

All the other drivers merely invoke kzalloc() on ->setup and kfree()
on ->cleanup.  The order doesn't matter in this case because
kfree(NULL) is a no-op.


> 2. There's no guarantee that the controller's driver would be present by
>    the time the spi device's release function gets called.

How so?  spi_devices are instantiated on ->probe of the controller
via spi_register_controller() and destroyed on ->remove via
spi_unregister_controller().  I don't see how the controller driver
could ever be unavailable, so this point seems moot.


> Fix these issues by simply moving the cleanup from the device release
> callback to the actual spi_unregister_device() function.

Unfortunately the fix is wrong, it introduces a new problem:

> @@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
>  	if (!spi)
>  		return;
>  
> +	spi_cleanup(spi);
> +
>  	if (spi->dev.of_node) {
>  		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
>  		of_node_put(spi->dev.of_node);

Now you're running ->cleanup before the SPI slave's driver is unbound.
That's bad, the driver may need to access the physical device on unbound,
e.g. to quiesce interrupts.  That may not work now because the
slave's controller_state is gone.

NAK, this needs to be reverted.

Thanks,

Lukas
