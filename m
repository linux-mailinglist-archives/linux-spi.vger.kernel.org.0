Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA9C1CB837
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHTXW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:23:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:4583 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTXW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 15:23:22 -0400
IronPort-SDR: nUEWvKeS3JiCq5263IrrP/w9YK7hYoMh2nZ8Igm193I0yX+YFg+hRE3xmCojyrBmGRiXb+Fppq
 36kCQhobjHEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:23:22 -0700
IronPort-SDR: YBGQ2qrMBTesT4Bt1+Pp0hKYceuBkdo2goqmHCLg1MR8iBMQOLxRoyW8j/nNbEFXkmDo+F10yQ
 8koC5HBDH51w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="285577444"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 12:23:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8ab-005T6G-GW; Fri, 08 May 2020 22:23:17 +0300
Date:   Fri, 8 May 2020 22:23:17 +0300
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
        devicetree@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "wuxu.wu" <wuxu.wu@huawei.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/17] spi: dw: Add DMA support to the DW SPI MMIO driver
Message-ID: <20200508192317.GU185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132943.9826-15-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 08, 2020 at 04:29:39PM +0300, Serge Semin wrote:
> Since the common code in the spi-dw-dma.c driver is ready to be used
> by the MMIO driver, we just need to initialize the DW SPI private data
> fields with Tx/Rx DMA channel handlers and setup the DW SPI DMA
> callbacks. This commit introduces such alterations to the DW SPI
> DMA/MMIO code. A dedicated DW SPI MMIO DMA initializer performs the
> DMA channels request from the parental device (which is supposed to be
> a DW SPI platform device). Then it checks whether the retrieved DW DMA
> channels support LLP. If they don't currently we print a warning, that
> further DMA usage may be finished with DW SPI inbound FIFO overflow
> (nothing else we can do about it at the moment). Finally the DW SPI
> MMIO DMA initializer sets the DMA-inited flag.
> 
> Currently the DMA will be initialized only for a generic DW SPI MMIO
> device declared with "snps,dw-apb-ssi" compatible string if SPI_DW_DMA
> kernel config is enabled.

Already in spi/for-next (see for generic suffix in spi-dw-mid.c).

-- 
With Best Regards,
Andy Shevchenko


