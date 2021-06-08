Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAED23A0749
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 00:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFHWsX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 18:48:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51817 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhFHWsW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 18:48:22 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3C52C240002;
        Tue,  8 Jun 2021 22:46:25 +0000 (UTC)
Date:   Wed, 9 Jun 2021 00:46:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zpershuai <zpershuai@gmail.com>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: =?iso-8859-1?Q?spi-at91-u?=
 =?iso-8859-1?Q?sart=3A=A0Fix_wron?= =?iso-8859-1?Q?g?= goto jump label when
 spi_alloc_master() returns error.
Message-ID: <YL/zQK7BbBZb/6Kh@piout.net>
References: <1623165248-24038-1-git-send-email-zpershuai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1623165248-24038-1-git-send-email-zpershuai@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/06/2021 23:14:07+0800, zpershuai wrote:
> When spi_alloc_master() returns null pointer, it’s no need to use
> spi_master_put() to release the memory, although spi_master_put()
> function has null pointer checks.
> 
> Signed-off-by: zpershuai <zpershuai@gmail.com>
> ---
>  drivers/spi/spi-at91-usart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index 8c83526..c8136dc 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -533,8 +533,10 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
>  
>  	ret = -ENOMEM;
>  	controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
> -	if (!controller)
> -		goto at91_usart_spi_probe_fail;
> +	if (!controller) {
> +		dev_err(&pdev->dev, "Error allocating SPI controller\n");
> +		return -ENOMEM;
> +	}

size before this patch:
   text	   data	    bss	    dec	    hex	filename
   3659	    112	      0	   3771	    ebb	drivers/spi/spi-at91-usart.o

size after:
   text	   data	    bss	    dec	    hex	filename
   3671	    112	      0	   3783	    ec7	drivers/spi/spi-at91-usart.o

Please avoid adding useless error strings in the kernel. This will never
fail and if for some reason this fails an error message would already be
printed anyway.

Strings take space on the storage, increase boot time and RAM usage.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
