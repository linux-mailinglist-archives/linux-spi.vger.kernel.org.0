Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAED3A3E93
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFKJIM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Jun 2021 05:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhFKJIM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Jun 2021 05:08:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 157D961278;
        Fri, 11 Jun 2021 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623402361;
        bh=V8rwQSPoiZTRk/jjRyvlQpQ1iIHmDQKQlGADOqOkmGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSsqjcdINb99LnurddKz51NDkHxokfj0nSeOELsQ8ON5ZQQ9cwd30j5b74FbN+CDp
         gojDDtF2W8omSjn+/fFTB25cA8p2ONkJcw0olabKA0Bg0PBeQhiqa8nXJ7pAGHRbLh
         3YZznU2rbyCsMisqO38iavqLi4fYfFC5oCyl38V8=
Date:   Fri, 11 Jun 2021 11:05:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 5/6] misc: nxp-ezport: introduce EzPort support
Message-ID: <YMMnd3bBgT8QcuQu@kroah.com>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609151235.48964-6-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 09, 2021 at 05:12:34PM +0200, Sebastian Reichel wrote:
> Add new EzPort support code, which can be used to do
> firmware updates of Kinetis coprocessors. The driver
> is not usable on its own and thus not user selectable.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Why is this a separate module if only 1 driver needs this?  Why not keep
it together until you have a second user?

And this module is not able to be unloaded ever?  Why not?

> +int ezport_flash(struct spi_device *spi, struct gpio_desc *reset, const char *fwname)
> +{
> +	int ret;
> +
> +	ret = ezport_start_programming(spi, reset);
> +	if (ret)
> +		return ret;
> +
> +	ret = ezport_firmware_load(spi, fwname);
> +
> +	ezport_stop_programming(spi, reset);
> +
> +	if (ret)
> +		dev_err(&spi->dev, "Failed to flash firmware: %d\n", ret);

%pe perhaps instead of %d?



> +	else
> +		dev_dbg(&spi->dev, "Finished FW flashing!\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ezport_flash);
> +
> +/**
> + * ezport_verify - verify device firmware
> + * @spi: SPI device for NXP EzPort interface
> + * @reset: the gpio connected to the device reset pin
> + * @fwname: filename of the firmware that should be compared
> + *
> + * Context: can sleep
> + *
> + * Return: 0 on success; negative errno on failure
> + */
> +int ezport_verify(struct spi_device *spi, struct gpio_desc *reset, const char *fwname)
> +{
> +	int ret;
> +
> +	ret = ezport_start_programming(spi, reset);
> +	if (ret)
> +		return ret;
> +
> +	ret = ezport_firmware_verify(spi, fwname);
> +
> +	ezport_stop_programming(spi, reset);
> +
> +	if (ret)
> +		dev_err(&spi->dev, "Failed to verify firmware: %d\n", ret);

Same here, %pe?


> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ezport_verify);
> +
> +MODULE_DESCRIPTION("NXP EzPort protocol support");
> +MODULE_AUTHOR("Sebastian Reichel <sebastian.reichel@collabora.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/nxp-ezport.h b/include/linux/platform_data/nxp-ezport.h
> new file mode 100644
> index 000000000000..b0a2af9c1285
> --- /dev/null
> +++ b/include/linux/platform_data/nxp-ezport.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

This license does NOT match up with the .c file's license.  Why?

thanks,

greg k-h
