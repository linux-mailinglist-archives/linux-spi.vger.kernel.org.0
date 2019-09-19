Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1620CB7FF5
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2019 19:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbfISRY6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Sep 2019 13:24:58 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40747 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388938AbfISRY6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Sep 2019 13:24:58 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8870BC0003;
        Thu, 19 Sep 2019 17:24:55 +0000 (UTC)
Date:   Thu, 19 Sep 2019 19:24:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Remove AVR32 leftover
Message-ID: <20190919172453.GA21254@piout.net>
References: <20190919154034.7489-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919154034.7489-1-gregory.clement@bootlin.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/09/2019 17:40:34+0200, Gregory CLEMENT wrote:
> AV32 support has been from the kernel a few release ago, but there was
AVR32 and  missing word^

> still some specific macro for this architecture in this driver. Lets
> remove it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/spi/spi-atmel.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index bb94f5927819..de1e1861a70c 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -222,37 +222,13 @@
>  	  | SPI_BF(name, value))
>  
>  /* Register access macros */
> -#ifdef CONFIG_AVR32
> -#define spi_readl(port, reg) \
> -	__raw_readl((port)->regs + SPI_##reg)
> -#define spi_writel(port, reg, value) \
> -	__raw_writel((value), (port)->regs + SPI_##reg)
> -
> -#define spi_readw(port, reg) \
> -	__raw_readw((port)->regs + SPI_##reg)
> -#define spi_writew(port, reg, value) \
> -	__raw_writew((value), (port)->regs + SPI_##reg)
> -
> -#define spi_readb(port, reg) \
> -	__raw_readb((port)->regs + SPI_##reg)
> -#define spi_writeb(port, reg, value) \
> -	__raw_writeb((value), (port)->regs + SPI_##reg)
> -#else
>  #define spi_readl(port, reg) \
>  	readl_relaxed((port)->regs + SPI_##reg)
>  #define spi_writel(port, reg, value) \
>  	writel_relaxed((value), (port)->regs + SPI_##reg)
> -
> -#define spi_readw(port, reg) \
> -	readw_relaxed((port)->regs + SPI_##reg)
>  #define spi_writew(port, reg, value) \
>  	writew_relaxed((value), (port)->regs + SPI_##reg)
>  
> -#define spi_readb(port, reg) \
> -	readb_relaxed((port)->regs + SPI_##reg)
> -#define spi_writeb(port, reg, value) \
> -	writeb_relaxed((value), (port)->regs + SPI_##reg)
> -#endif
>  /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
>   * cache operations; better heuristics consider wordsize and bitrate.
>   */
> -- 
> 2.23.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
