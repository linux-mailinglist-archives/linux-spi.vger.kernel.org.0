Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A32269FB8
	for <lists+linux-spi@lfdr.de>; Tue, 15 Sep 2020 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIOH0y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Sep 2020 03:26:54 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:29438 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgIOHZl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Sep 2020 03:25:41 -0400
IronPort-SDR: CZiMlWV/XtMaYOtiY6ZJas5PO0e/LnuGvvnOWuZxToU8HRKKB0tzCU1Auo84032ouTlA6goC8k
 Yedx3VCmcV2iG24KvM0ySK7rnQ252yUXOr3AACRKK1tCfCt7JrsI/yjY4vzte8yjh+IGok58Us
 mTqcOXQo47AipanYMLifQzLwoU3bkZLwZxj7EzhfAQraY8VtEstw1W1Cbn/FTQc/TytMVcBsaI
 X2zJOsfKHzYYMAltjNrlvcv+OAoTmwLs3Fn0gesHnm4QQ3bgp4YtrGRu2IArVb8vqJcunetbZh
 JrY=
X-IronPort-AV: E=Sophos;i="5.76,429,1592863200"; 
   d="scan'208";a="13862190"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Sep 2020 09:25:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 15 Sep 2020 09:25:36 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 15 Sep 2020 09:25:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600154736; x=1631690736;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fdIMBHG6e52E2T8qNjQcYeu/39DrrrbAgxcL8f4w8ws=;
  b=KbxfHmyBgvDhCiAkO8qUT5N5PxcPybSp6DhMIsvmsE3IsBbpSXe3b2B4
   qgjA/ogV0SHuxgcUG6dXTZNyN+QM/AA5I7SBVBTdD/tMv2Wp+W7Cch0yq
   tI2PDiaCIv254W0ZPihTTXjgwlr3xsq3+kOPnbRlZi/sU1+S+1YRvczpw
   HxciF69OYq2WRlnqvzQ8/Z1+ywwAUAF90e74oIPlp9RDUBfVa5b2HGiUn
   U+FAvouJSAOpVBo2BrZnrYlrtstHAcGFjLlgBw4sHXFRdaUbL/6XhHonn
   nB2EjD1N2Szk3uwNNP5AO8HqEWiiageHvQ1RZ1Z7H1Plbp18E9nbzGRdl
   g==;
IronPort-SDR: OeuSuQTgzCXX0M7pnMKHbtg3SwFO8qkL/gqacn7ZExR5Hi6iNRHL1nMKpF2evz0NAgIc9c6CQp
 NxtRCNQG9F3g598RPMmnFY7v3wendYRa+8Do1zh+2c3cmMu9mq4A7tD0xik4RdqiTAjl96ahIS
 +w1zJpl9CZ7zQgve6z92tsGo4BBQxlsmnYuY3X9CuDbqIXK9HR4veCJOEKa8fBq66ZEXTWF81b
 8jhmXiHVDrxwtT6/lsI/cibvWF1AG0ugg6lc1l6y17oMyM/CudiGGG+m4NlRvlxcjMG1DUZ8EL
 YrA=
X-IronPort-AV: E=Sophos;i="5.76,429,1592863200"; 
   d="scan'208";a="13862189"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Sep 2020 09:25:36 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id BEF3D280070;
        Tue, 15 Sep 2020 09:25:36 +0200 (CEST)
Message-ID: <6cc6fef0694438a744faee5185f70c67cb939be2.camel@ew.tq-group.com>
Subject: Re: [PATCH] spi: imx: Fix the number of chipselects count
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-spi@vger.kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com, broonie@kernel.org
Date:   Tue, 15 Sep 2020 09:25:34 +0200
In-Reply-To: <20200913141937.11588-1-festevam@gmail.com>
References: <20200913141937.11588-1-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 2020-09-13 at 11:19 -0300, Fabio Estevam wrote:
> On an imx6q-sabresd board, which has one single GPIO chipselect used
> for SPI, the SPI core now reports that it has 3 chipselects.
> 
> This happens since commit 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert
> to
> GPIO descriptors"), which assigned master->num_chipselect as 3 when
> 'num-cs' is absent.
> 
> However, 'num-cs' property is not used in any in-tree devicetree,
> leading
> to an incorrect count of chipselects.
> 
> Fix the number of chipselects count by only assigning
> master->num_chipselect in the unlikely case when the "cs-gpios"
> property
> is absent.
> 
> Print a warning in this case, since using native chipselects in
> several i.MX SoCs is known to be problematic.
> 
> While at it, use 4 as the maximum number of native chip-select
> supported
> by this controller.
> 
> Fixes: 8cdcd8aeee281 ("spi: imx/fsl-lpspi: Convert to GPIO
> descriptors")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Hello Fabio,

thanks for your patch. I had thought about doing something similiar,
but ultimately decided to go with the simpler patch I submitted as
"spi-imx: remove num-cs support, set num_chipselect to 4" for two
reasons:

- none of the other SPI drivers care about the number of cs-gpios when
setting num_chipselect
- AFAICT, using GPIO CS only for some indices, and native ones for the
rest should work fine; as I understand it now, there is no reason to
make num_chpselect smaller than the number of native CS (so the
'num_chipselect = max(num_chipselect, number of cs-gpios)' in the SPI
core is working as intended)

For these reasons I believe that my proposed patch is more in line with
the usual way to handle num_chipselect (adding a warning still seems
like a good idea.)


FWIW, I've researched for which usecases we use the native CS of i.MX
SoCs:

As you write, the native CS of these SPI controllers is problematic for
most usecases - it seems to me that CS is not asserted across the read
and write portions of what is supposed a single transaction.

However, there are ADCs that do not need a command, but will start
sending data as soon as CS is asserted. For this kind of communication,
the native CS works fine, and may actually be preferable for latency-
critical applications, as locking is required to set GPIOs on the i.MX
platform.

Kind regards,
Matthias




> ---
>  drivers/spi/spi-imx.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 197f60632072..968c868cf17f 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -13,6 +13,7 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -1581,7 +1582,7 @@ static int spi_imx_probe(struct platform_device
> *pdev)
>  	const struct spi_imx_devtype_data *devtype_data = of_id ?
> of_id->data :
>  		(struct spi_imx_devtype_data *)pdev->id_entry-
> >driver_data;
>  	bool slave_mode;
> -	u32 val;
> +	int num_cs_gpios;
>  
>  	slave_mode = devtype_data->has_slavemode &&
>  			of_property_read_bool(np, "spi-slave");
> @@ -1613,16 +1614,12 @@ static int spi_imx_probe(struct
> platform_device *pdev)
>  
>  	spi_imx->devtype_data = devtype_data;
>  
> -	/*
> -	 * Get number of chip selects from device properties. This can
> be
> -	 * coming from device tree or boardfiles, if it is not defined,
> -	 * a default value of 3 chip selects will be used, as all the
> legacy
> -	 * board files have <= 3 chip selects.
> -	 */
> -	if (!device_property_read_u32(&pdev->dev, "num-cs", &val))
> -		master->num_chipselect = val;
> -	else
> -		master->num_chipselect = 3;
> +	num_cs_gpios = gpiod_count(&pdev->dev, "cs");
> +	if ((num_cs_gpios == 0) || (num_cs_gpios == -ENOENT)) {
> +		dev_warn(&pdev->dev,
> +			 "cs-gpios not found. Using native chipselect
> with this SPI controller is known to be problematic\n");
> +		master->num_chipselect = 4;
> +	}
>  
>  	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
>  	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;

