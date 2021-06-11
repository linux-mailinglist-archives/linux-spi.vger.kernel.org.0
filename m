Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665443A3E9B
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFKJJG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 05:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhFKJJG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Jun 2021 05:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8F5613C8;
        Fri, 11 Jun 2021 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623402415;
        bh=Ukkj3ecfse5HyDd+JTtcMdhPVZqAw36h2hTQO7WHmj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAC722NPNQSfrmzUkCzqd7ok5AOnRyWbwW56p88DTAxDZ8Us9DPro56+F2/9HY4tn
         MnH/8FawcR8w40sKWlJWKO9Jxho3IcENSaId0zRXGOSVLgLhA866Tt7E3kXWx92LDa
         S5VXqceTLVTrxzwkMa5Z5+mlumsEIbLP8CPMZLHM=
Date:   Fri, 11 Jun 2021 11:06:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/6] spi: add ancillary device support
Message-ID: <YMMnrYbuwe4z/s3h@kroah.com>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609151235.48964-2-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 09, 2021 at 05:12:30PM +0200, Sebastian Reichel wrote:
> Introduce support for ancillary devices, similar to existing
> implementation for I2C. This is useful for devices having
> multiple chip-selects, for example some microcontrollers
> provide a normal SPI interface and a flashing SPI interface.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/spi/spi.c       | 139 +++++++++++++++++++++++++++++++---------
>  include/linux/spi/spi.h |   2 +
>  2 files changed, 109 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ba425b9c7700..7fdf224262b1 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -558,49 +558,23 @@ static int spi_dev_check(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -/**
> - * spi_add_device - Add spi_device allocated with spi_alloc_device
> - * @spi: spi_device to register
> - *
> - * Companion function to spi_alloc_device.  Devices allocated with
> - * spi_alloc_device can be added onto the spi bus with this function.
> - *
> - * Return: 0 on success; negative errno on failure
> - */
> -int spi_add_device(struct spi_device *spi)
> +static int __spi_add_device(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
>  	int status;
>  
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi->chip_select >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
> -			ctlr->num_chipselect);
> -		return -EINVAL;
> -	}
> -
> -	/* Set the bus ID string */
> -	spi_dev_set_name(spi);
> -
> -	/* We need to make sure there's no other device with this
> -	 * chipselect **BEFORE** we call setup(), else we'll trash
> -	 * its configuration.  Lock against concurrent add() calls.
> -	 */
> -	mutex_lock(&spi_add_lock);
> -
>  	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
>  	if (status) {
>  		dev_err(dev, "chipselect %d already in use\n",
>  				spi->chip_select);
> -		goto done;
> +		return status;
>  	}
>  
>  	/* Controller may unregister concurrently */
>  	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
>  	    !device_is_registered(&ctlr->dev)) {
> -		status = -ENODEV;
> -		goto done;
> +		return -ENODEV;
>  	}
>  
>  	/* Descriptors take precedence */
> @@ -617,7 +591,7 @@ int spi_add_device(struct spi_device *spi)
>  	if (status < 0) {
>  		dev_err(dev, "can't setup %s, status %d\n",
>  				dev_name(&spi->dev), status);
> -		goto done;
> +		return status;
>  	}
>  
>  	/* Device may be bound to an active driver when this returns */
> @@ -628,12 +602,64 @@ int spi_add_device(struct spi_device *spi)
>  	else
>  		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
>  
> -done:
> +	return status;
> +}
> +
> +/**
> + * spi_add_device - Add spi_device allocated with spi_alloc_device
> + * @spi: spi_device to register
> + *
> + * Companion function to spi_alloc_device.  Devices allocated with
> + * spi_alloc_device can be added onto the spi bus with this function.
> + *
> + * Return: 0 on success; negative errno on failure
> + */
> +int spi_add_device(struct spi_device *spi)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	struct device *dev = ctlr->dev.parent;
> +	int status;
> +
> +	/* Chipselects are numbered 0..max; validate. */
> +	if (spi->chip_select >= ctlr->num_chipselect) {
> +		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
> +			ctlr->num_chipselect);
> +		return -EINVAL;
> +	}
> +
> +	/* Set the bus ID string */
> +	spi_dev_set_name(spi);
> +
> +	/* We need to make sure there's no other device with this
> +	 * chipselect **BEFORE** we call setup(), else we'll trash
> +	 * its configuration.  Lock against concurrent add() calls.
> +	 */
> +	mutex_lock(&spi_add_lock);
> +	status = __spi_add_device(spi);
>  	mutex_unlock(&spi_add_lock);
>  	return status;
>  }
>  EXPORT_SYMBOL_GPL(spi_add_device);
>  
> +static int spi_add_device_locked(struct spi_device *spi)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	struct device *dev = ctlr->dev.parent;
> +
> +	/* Chipselects are numbered 0..max; validate. */
> +	if (spi->chip_select >= ctlr->num_chipselect) {
> +		dev_err(dev, "cs%d >= max %d\n", spi->chip_select,
> +			ctlr->num_chipselect);
> +		return -EINVAL;
> +	}
> +
> +	/* Set the bus ID string */
> +	spi_dev_set_name(spi);
> +
> +	WARN_ON(!mutex_is_locked(&spi_add_lock));

So you just rebooted a machine that has panic-on-warn set.  Not nice.

If this really can happen, test for it and recover, do not reboot
devices.

If this really can never happen, why are you testing for it?

thanks,

greg k-h
