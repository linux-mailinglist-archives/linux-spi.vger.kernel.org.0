Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876BC1EC267
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFBTKj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 15:10:39 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57056 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBTKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 15:10:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E897C8030835;
        Tue,  2 Jun 2020 19:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IvgS6PU79JwH; Tue,  2 Jun 2020 22:10:27 +0300 (MSK)
Date:   Tue, 2 Jun 2020 22:10:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lars Povlsen <lars.povlsen@microchip.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 01/10] spi: dw: Add support for polled operation via no
 IRQ specified in DT
Message-ID: <20200602191025.ywo77nslrgswh6sw@mobilestation>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513140031.25633-2-lars.povlsen@microchip.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 04:00:22PM +0200, Lars Povlsen wrote:
> With this change a SPI controller can be added without having a IRQ
> associated, and causing all transfers to be polled. For SPI controllers
> without DMA, this can significantly improve performance by less
> interrupt handling overhead.
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  drivers/spi/spi-dw.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 31e3f866d11a7..e572eb34a3c1a 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -19,6 +19,8 @@
>  #include <linux/debugfs.h>
>  #endif
> 

> +#define VALID_IRQ(i) (i >= 0)

Mark and Andy are right. It is a good candidate to be in a generic IRQ-related
code as Anyd suggested:

> > drivers/rtc/rtc-cmos.c:95:#define is_valid_irq(n)               ((n) > 0)
> > Candidate to be in include/linux/irq.h ?

So if you feel like to author additional useful patch integrated into the
kernel, this one is a good chance for it.

> +
>  /* Slave spi_dev related */
>  struct chip_data {
>  	u8 tmode;		/* TR/TO/RO/EEPROM */
> @@ -359,7 +361,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  			spi_enable_chip(dws, 1);
>  			return ret;
>  		}
> -	} else if (!chip->poll_mode) {
> +	} else if (!chip->poll_mode && VALID_IRQ(dws->irq)) {
>  		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
>  		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
> 
> @@ -379,7 +381,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  			return ret;
>  	}
> 
> -	if (chip->poll_mode)
> +	if (chip->poll_mode || !VALID_IRQ(dws->irq))
>  		return poll_transfer(dws);

Please note. The chip->poll and the poll_transfer() methods've been discarded
from the driver, since commit 1ceb09717e98 ("spi: dw: remove cs_control and
poll_mode members from chip_data"). So you gonna have to get the
poll_transfer-like method back.

-Sergey

> 
>  	return 1;
> @@ -487,11 +489,13 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
> 
>  	spi_controller_set_devdata(master, dws);
> 
> -	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
> -			  master);
> -	if (ret < 0) {
> -		dev_err(dev, "can not get IRQ\n");
> -		goto err_free_master;
> +	if (VALID_IRQ(dws->irq)) {
> +		ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
> +				  dev_name(dev), master);
> +		if (ret < 0) {
> +			dev_err(dev, "can not get IRQ\n");
> +			goto err_free_master;
> +		}
>  	}
> 
>  	master->use_gpio_descriptors = true;
> @@ -539,7 +543,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (dws->dma_ops && dws->dma_ops->dma_exit)
>  		dws->dma_ops->dma_exit(dws);
>  	spi_enable_chip(dws, 0);
> -	free_irq(dws->irq, master);
> +	if (VALID_IRQ(dws->irq))
> +		free_irq(dws->irq, master);
>  err_free_master:
>  	spi_controller_put(master);
>  	return ret;
> --
> 2.26.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
