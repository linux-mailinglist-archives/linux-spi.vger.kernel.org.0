Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF6495D04
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349709AbiAUJmt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 04:42:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4436 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUJmt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 04:42:49 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JgDqT4Y6xz67yhj;
        Fri, 21 Jan 2022 17:39:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 10:42:47 +0100
Received: from localhost (10.47.75.29) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 21 Jan
 2022 09:42:46 +0000
Date:   Fri, 21 Jan 2022 09:42:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: pxa2xx_spi: Convert to use GPIO descriptors
Message-ID: <20220121094243.0000651f@Huawei.com>
In-Reply-To: <20220121012014.287288-1-linus.walleij@linaro.org>
References: <20220121012014.287288-1-linus.walleij@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.29]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Jan 2022 02:20:14 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This converts the PXA2xx SPI driver to use GPIO descriptors
> exclusively to retrieve GPIO chip select lines.
> 
> The device tree and ACPI paths of the driver already use
> descriptors, hence ->use_gpio_descriptors is already set and
> this codepath is well tested.
> 
> Convert all the PXA boards providing chip select GPIOs as
> platform data and drop the old GPIO chipselect handling in
> favor of the core managing it exclusively.
> 
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/spi/pxa2xx.rst   |  3 --
>  arch/arm/mach-pxa/corgi.c      | 26 +++++++---------
>  arch/arm/mach-pxa/hx4700.c     | 10 +++++-
>  arch/arm/mach-pxa/icontrol.c   | 26 +++++++++++++---
>  arch/arm/mach-pxa/littleton.c  | 10 +++++-
>  arch/arm/mach-pxa/magician.c   | 12 +++++--
>  arch/arm/mach-pxa/poodle.c     | 14 ++++++---
>  arch/arm/mach-pxa/spitz.c      | 26 +++++++---------
>  arch/arm/mach-pxa/stargate2.c  | 21 +++++++++++--
>  arch/arm/mach-pxa/z2.c         | 20 ++++++++++--
>  drivers/spi/spi-pxa2xx.c       | 57 ----------------------------------
>  include/linux/spi/pxa2xx_spi.h |  1 -
>  12 files changed, 117 insertions(+), 109 deletions(-)
> 

...

> diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
> index 8ca02ec1d44c..650043023006 100644
> --- a/arch/arm/mach-pxa/stargate2.c
> +++ b/arch/arm/mach-pxa/stargate2.c
> @@ -346,6 +346,23 @@ static struct pxa2xx_spi_controller pxa_ssp_master_2_info = {
>  	.num_chipselect = 1,
>  };
>  
> +static struct gpiod_lookup_table pxa_ssp1_gpio_table = {
> +	.dev_id = "pxa2xx-spi.1",
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-pxa", 24, "cs", 0, GPIO_ACTIVE_LOW),
> +		{ },
> +	},
> +};
> +
> +static struct gpiod_lookup_table pxa_ssp3_gpio_table = {
> +	.dev_id = "pxa2xx-spi.3",
> +	.table = {
> +		GPIO_LOOKUP_IDX("gpio-pxa", 39, "cs", 0, GPIO_ACTIVE_LOW),
> +		{ },
> +	},
> +};
> +

Nitpick, one line will do.

As a side note I have a patch outstanding (from May 2021) to drop
stargate2/imote2 on basis that I strongly suspect I'm the only person
who still has access to hardware and I've not booted one for a few years.

https://lore.kernel.org/all/20210523163606.1966355-1-jic23@kernel.org/
Patch still applies cleanly.

In meantime for stargate2/imote2 (same file)  Should both patches go in
the merge conflict will be very obvious ;)

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +
>  /* An upcoming kernel change will scrap SFRM usage so these
>   * drivers have been moved to use GPIOs */
>  static struct pxa2xx_spi_chip staccel_chip_info = {
> @@ -353,7 +370,6 @@ static struct pxa2xx_spi_chip staccel_chip_info = {
>  	.rx_threshold = 8,
>  	.dma_burst_size = 8,
>  	.timeout = 235,
> -	.gpio_cs = 24,
>  };
>  
>  static struct pxa2xx_spi_chip cc2420_info = {
> @@ -361,7 +377,6 @@ static struct pxa2xx_spi_chip cc2420_info = {
>  	.rx_threshold = 8,
>  	.dma_burst_size = 8,
>  	.timeout = 235,
> -	.gpio_cs = 39,
>  };
>  
>  static struct spi_board_info spi_board_info[] __initdata = {
> @@ -410,6 +425,8 @@ static void __init imote2_stargate2_init(void)
>  	pxa_set_btuart_info(NULL);
>  	pxa_set_stuart_info(NULL);
>  
> +	gpiod_add_lookup_table(&pxa_ssp1_gpio_table);
> +	gpiod_add_lookup_table(&pxa_ssp3_gpio_table);
>  	pxa2xx_set_spi_info(1, &pxa_ssp_master_0_info);
>  	pxa2xx_set_spi_info(2, &pxa_ssp_master_1_info);
>  	pxa2xx_set_spi_info(3, &pxa_ssp_master_2_info);
