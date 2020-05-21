Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424B61DDB09
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 01:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgEUXdd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 19:33:33 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41044 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgEUXdd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 19:33:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C74088030809;
        Thu, 21 May 2020 23:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mzndbVe0uaYh; Fri, 22 May 2020 02:33:29 +0300 (MSK)
Date:   Fri, 22 May 2020 02:33:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Linus Walleij <linus.walleij@stericsson.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clement Leger <cleger@kalray.eu>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200521233327.o5siot6dyftgz7gu@mobilestation>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521012206.14472-2-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Mark, Andy,

On Thu, May 21, 2020 at 04:21:51AM +0300, Serge Semin wrote:
>  

[nip]

> +static void dw_spi_dma_calc_delay(struct dw_spi *dws, u32 nents,
> +				  struct spi_delay *delay)
> +{
> +	unsigned long ns, us;
> +
> +	ns = (NSEC_PER_SEC / spi_get_clk(dws)) * nents * dws->n_bytes *
> +	     BITS_PER_BYTE;
> +
> +	if (ns <= NSEC_PER_USEC) {
> +		delay->unit = SPI_DELAY_UNIT_NSECS;
> +		delay->value = ns;
> +	} else {
> +		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
> +		delay->unit = SPI_DELAY_UNIT_USECS;
> +		delay->value = clamp_val(us, 0, USHRT_MAX);
> +	}
> +}
> +
> +static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
> +{
> +	return !(dw_readl(dws, DW_SPI_SR) & SR_TF_EMPT);
> +}
> +
> +static void dw_spi_dma_wait_tx_done(struct dw_spi *dws)
> +{
> +	int retry = WAIT_RETRIES;
> +	struct spi_delay delay;
> +	u32 nents;
> +
> +	nents = dw_readl(dws, DW_SPI_TXFLR);
> +	dw_spi_dma_calc_delay(dws, nents, &delay);
> +
> +	while (dw_spi_dma_tx_busy(dws) && retry--)

> +		spi_delay_exec(&delay, NULL);

I've just discovered using spi_delay_exec() wasn't a good idea here. Look at the
call stack:
dw_dma_tasklet() -> dwc_scan_descriptors() -> dwc_descriptor_complete() ->
dw_spi_dma_tx_done() -> spi_delay_exec() -> usleep_range() -> ...

So tasklet is calling a sleeping function.((( I've absolutely forgotten to check
the context the DMA completion function is called with. We'll have to manually
select either ndelay or udelay here and nothing else. Since basically both
functions represent an atomic context and most of the platforms ndelay fallsback to
udelay, I'll get the ndelay back to the wait functions. I'll resend a patchset
shortly.

-Sergey
