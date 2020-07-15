Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A42216F6
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGOVYr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 17:24:47 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53619 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVYq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 17:24:46 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 43E79E0003;
        Wed, 15 Jul 2020 21:24:44 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:24:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 12/14] spi: spi-at91-usart: Make use of the defined
 'struct of_device_id'
Message-ID: <20200715212443.GC23553@piout.net>
References: <20200715150632.409077-1-lee.jones@linaro.org>
 <20200715150632.409077-13-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715150632.409077-13-lee.jones@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lee,

On 15/07/2020 16:06:30+0100, Lee Jones wrote:
> It's there so why not use it.
> 

Is that the correct resolution? Isn't the proper thing to do simply
removing at91_usart_spi_dt_ids as the only way it will ever be probed is
through drivers/mfd/at91-usart.c and I would think matching the driver
name is enough.

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
>  684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/spi/spi-at91-usart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index 88033422a42ae..d47a20be43ccd 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -692,6 +692,7 @@ static struct platform_driver at91_usart_spi_driver = {
>  	.driver = {
>  		.name = "at91_usart_spi",
>  		.pm = &at91_usart_spi_pm_ops,
> +		.of_match_table = at91_usart_spi_dt_ids,
>  	},
>  	.probe = at91_usart_spi_probe,
>  	.remove = at91_usart_spi_remove,
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
