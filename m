Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2C1D4DA1
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEOM1D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 08:27:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:40579 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgEOM1D (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 08:27:03 -0400
IronPort-SDR: flDwKY2DWv+i+mlTCT3Az2dSlh4eBlkJLH1GkE1pM7Br0bR4FDmOjSLZz1RuxbvVQ0dILVnpqW
 nuQ/V8sn1Kig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 05:27:02 -0700
IronPort-SDR: wJORXsmnW7wF7NWU+mlHtKfhqd/8eoCv4nbBmAKprDpHBHY8vdrxEH5ZNSH6bW46w2gGCXFmfp
 JrYP2WY3DncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="298423782"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2020 05:26:58 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZZQa-006r78-F8; Fri, 15 May 2020 15:27:00 +0300
Date:   Fri, 15 May 2020 15:27:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/19] spi: dw: Enable interrupts in accordance with
 DMA xfer mode
Message-ID: <20200515122700.GY185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:44PM +0300, Serge Semin wrote:
> It's pointless to track the Tx overrun interrupts if Rx-only SPI
> transfer is issued. Similarly there is no need in handling the Rx
> overrun/underrun interrupts if Tx-only SPI transfer is executed.
> So lets unmask the interrupts only if corresponding SPI
> transactions are implied.

My comments below.

> Co-developed-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org

I think you really need to revisit Cc list in all patches (DT people hardly
interested in this one, though ones where properties are being used might be
point of interest).

...

>  	/* Set the interrupt mask */
> -	spi_umask_intr(dws, SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI);
> +	spi_umask_intr(dws, imr);

Can we rather do like this

	/* Set the interrupt mask */
	if (xfer->tx_buf)
		imr |= SPI_INT_TXOI;
	if (xfer->rx_buf)
		imr |= SPI_INT_RXUI | SPI_INT_RXOI;
	spi_umask_intr(dws, imr);

?

(First block sets DMA, second one IRQ)

-- 
With Best Regards,
Andy Shevchenko


