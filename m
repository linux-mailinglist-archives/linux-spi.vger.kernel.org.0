Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D851EC2EF
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFBTjg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 15:39:36 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57156 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTjg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 15:39:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 259968030808;
        Tue,  2 Jun 2020 19:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GjhvlG4R7G07; Tue,  2 Jun 2020 22:39:31 +0300 (MSK)
Date:   Tue, 2 Jun 2020 22:39:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lars Povlsen <lars.povlsen@microchip.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/10] spi: dw: Add support for RX sample delay register
Message-ID: <20200602193931.vl36k3c6uyiaizah@mobilestation>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-3-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513140031.25633-3-lars.povlsen@microchip.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 04:00:23PM +0200, Lars Povlsen wrote:
> This add support for the RX_SAMPLE_DLY register. If enabled in the
> Designware IP, it allows tuning of the rx data signal by means of an
> internal rx sample fifo.
> 
> The register is located at offset 0xf0, and if the option is not
> enabled in the IP, changing the register will have no effect.
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  drivers/spi/spi-dw.c | 7 +++++++
>  drivers/spi/spi-dw.h | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index e572eb34a3c1a..32997f28fa5bb 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -81,6 +81,9 @@ static ssize_t dw_spi_show_regs(struct file *file, char __user *user_buf,
>  			"DMATDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMATDLR));
>  	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>  			"DMARDLR: \t0x%08x\n", dw_readl(dws, DW_SPI_DMARDLR));

> +	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
> +			 "RX_SAMPLE_DLY: \t0x%08x\n",
> +			 dw_readl(dws, DW_SPI_RX_SAMPLE_DLY));

debugfs_reg32 interface is now utilized in the driver to dump the registers
state. So this will have to be converted to just a new entry in the
dw_spi_dbgfs_regs array.

>  	len += scnprintf(buf + len, SPI_REGS_BUFSIZE - len,
>  			"=================================\n");
> 
> @@ -315,6 +318,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>  		spi_set_clk(dws, chip->clk_div);
>  	}
> 

> +	/* Apply RX sample delay, iff requested (nonzero) */

s/iff/if

> +	if (dws->rx_sample_dly)
> +		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, dws->rx_sample_dly);
> +
>  	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
>  	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> 
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 1bf5713e047d3..ed6e47b3f50da 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -31,6 +31,7 @@
>  #define DW_SPI_IDR			0x58
>  #define DW_SPI_VERSION			0x5c
>  #define DW_SPI_DR			0x60
> +#define DW_SPI_RX_SAMPLE_DLY		0xf0
>  #define DW_SPI_CS_OVERRIDE		0xf4
> 
>  /* Bit fields in CTRLR0 */
> @@ -111,6 +112,7 @@ struct dw_spi {
> 
>  	int			cs_override;
>  	u32			reg_io_width;	/* DR I/O width in bytes */

> +	u8			rx_sample_dly;	/* RX fifo tuning (option) */

This doesn't seem like a good place for this parameter. The sample delay is
SPI-slave specific. So as I see it, the parameter should be moved to the
chip_data.

-Sergey

>  	u16			bus_num;
>  	u16			num_cs;		/* supported slave numbers */
>  	void (*set_cs)(struct spi_device *spi, bool enable);
> --
> 2.26.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
