Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78804223D91
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgGQOCV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 10:02:21 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50907 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQOCV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 10:02:21 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C50FF1BF20D;
        Fri, 17 Jul 2020 14:02:18 +0000 (UTC)
Date:   Fri, 17 Jul 2020 16:02:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 12/14] spi: spi-at91-usart: Remove unused OF table
 'struct of_device_id'
Message-ID: <20200717140218.GR3428@piout.net>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
 <20200717135424.2442271-13-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717135424.2442271-13-lee.jones@linaro.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/07/2020 14:54:22+0100, Lee Jones wrote:
> The only way this driver can be probed by MFD via its parent device.
> 
> No other reference to 'microchip,at91sam9g45-usart-spi' exists in the kernel.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/spi/spi-at91-usart.c:684:34: warning: ‘at91_usart_spi_dt_ids’ defined but not used [-Wunused-const-variable=]
>  684 | static const struct of_device_id at91_usart_spi_dt_ids[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/spi/spi-at91-usart.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index 88033422a42ae..8c8352625d232 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -681,13 +681,6 @@ static const struct dev_pm_ops at91_usart_spi_pm_ops = {
>  			   at91_usart_spi_runtime_resume, NULL)
>  };
>  
> -static const struct of_device_id at91_usart_spi_dt_ids[] = {
> -	{ .compatible = "microchip,at91sam9g45-usart-spi"},
> -	{ /* sentinel */}
> -};
> -
> -MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
> -
>  static struct platform_driver at91_usart_spi_driver = {
>  	.driver = {
>  		.name = "at91_usart_spi",
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
