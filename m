Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECF37B46A
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 05:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELDRx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 23:17:53 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51860 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELDRx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 23:17:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UYbG6OP_1620789403;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UYbG6OP_1620789403)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 11:16:44 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v2 1/1] spi: Assume GPIO CS active high in ACPI case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
References: <20210511140912.30757-1-andriy.shevchenko@linux.intel.com>
Message-ID: <b1f1539d-2e7c-a56b-9a04-2a85637f0a01@linux.alibaba.com>
Date:   Wed, 12 May 2021 11:16:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210511140912.30757-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/5/11 下午10:09, Andy Shevchenko 写道:
> Currently GPIO CS handling, when descriptors are in use, doesn't
> take into consideration that in ACPI case the default polarity
> is Active High and can't be altered. Instead we have to use the
> per-chip definition provided by SPISerialBus() resource.
>
> Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
> Cc: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Cc: Jay Fang <f.fangjian@huawei.com>
> Cc: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> ---
> v2: refactor to avoid ternary (Mark, Sven), dropped comment changes (Mark)
>   drivers/spi/spi.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index cd40421b8f55..36ee33514b40 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -820,15 +820,29 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>   
>   	if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
>   		if (!(spi->mode & SPI_NO_CS)) {
> -			if (spi->cs_gpiod)
> -				/* polarity handled by gpiolib */
> -				gpiod_set_value_cansleep(spi->cs_gpiod, activate);
> -			else
> +			if (spi->cs_gpiod) {
> +				/*
> +				 * Historically ACPI has no means of the GPIO polarity and
> +				 * thus the SPISerialBus() resource defines it on the per-chip
> +				 * basis. In order to avoid a chain of negations, the GPIO
> +				 * polarity is considered being Active High. Even for the cases
> +				 * when _DSD() is involved (in the updated versions of ACPI)
> +				 * the GPIO CS polarity must be defined Active High to avoid
> +				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
> +				 * into account.
> +				 */
> +				if (has_acpi_companion(&spi->dev))
> +					gpiod_set_value_cansleep(spi->cs_gpiod, !enable);

it worked and code changed minimally,  before ACPI & OF keeps no same 
rules,  this patch is ok!

> +				else
> +					/* Polarity handled by GPIO library */
> +					gpiod_set_value_cansleep(spi->cs_gpiod, activate);
> +			} else {
>   				/*
>   				 * invert the enable line, as active low is
>   				 * default for SPI.
>   				 */
>   				gpio_set_value_cansleep(spi->cs_gpio, !enable);
> +			}
>   		}
>   		/* Some SPI masters need both GPIO CS & slave_select */
>   		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&

-- 
Best Regards!
Xin Hao

