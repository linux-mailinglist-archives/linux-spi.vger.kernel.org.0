Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820D420A7FE
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jun 2020 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbgFYWIS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 18:08:18 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57230 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391337AbgFYWIS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jun 2020 18:08:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1A37F8040A7B;
        Thu, 25 Jun 2020 22:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iQhhX2D5d7Tk; Fri, 26 Jun 2020 01:08:09 +0300 (MSK)
Date:   Fri, 26 Jun 2020 01:08:08 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: [RFC] spi: dw: Test the last revision of the DMA module
Message-ID: <20200625220808.hac4egxalgn3pcqk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Andy.
  
Have you tested the recent revision of the DW APB SSI driver with DMA
enabled? I am particularly concerned about the next fix in the driver:

> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -346,8 +375,8 @@ static int dw_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
>  {
>       u16 imr = 0, dma_ctrl = 0;
>  
> -     dw_writel(dws, DW_SPI_DMARDLR, RX_BURST_LEVEL - 1);
> -     dw_writel(dws, DW_SPI_DMATDLR, TX_BURST_LEVEL);
> +     dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
> +     dw_writel(dws, DW_SPI_DMATDLR, dws->fifo_len - dws->txburst);
>  
>       if (xfer->tx_buf) {
>               dma_ctrl |= SPI_DMA_TDMAE;

Generally speaking it must work (even DW APB SSI/DMA databook suggests to have
such DMATDLR setting), but in our case of a relatively slow DMA engine (it's
clocked with just twice higher frequency with respect to the max SPI bus
speed) sometimes SPI Rx FIFO gets overflown when SPI bus is configured to work
with maximum speed (there are multiple reasons why this happens, but generally
speaking all of them matter only due to the relatively slow DMA engine). The
problem is fixed by reducing a value written into the DMATDLR register.

I am wondering whether you've tested the last revision of the driver and it
worked for your version of the DW APB SSI + DW DMAC IPs. AFAIU DMA engine on
your devices is faster than on ours and has LLPs supported. So if you haven't
noticed any problem in the recent driver, then I'll send a fixup for our version
of the DW APB SSI block only (I'll have to introduce a new compatible string).
Otherwise I could get back a setting of dws->txburst into the DW_SPI_DMATDLR
register, which isn't that optimal as the current DMATDLR setting
of (fifo_len - txburst), but at least will make things working for all DMAs.

-Sergey
