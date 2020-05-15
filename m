Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6A1D4D11
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgEOLvx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 07:51:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:16270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgEOLvx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 07:51:53 -0400
IronPort-SDR: RcUnhiy93GDKfk3mR8+XGUcUlUFXfwvE4TcQcU2qzd3nx5++VLP+bcTW+Vvak8dD4IimkAEMKX
 FrvUAv3Ila6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 04:51:52 -0700
IronPort-SDR: 042pc2NGEgzvIuFUXXH0dKWeFDRG+rGacAhxCGg+YExy5368QwdOxq+sPPkxAuBo15Mq1QROhS
 hTW6BbpLJmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="252362213"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2020 04:51:48 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZYsZ-006qo3-AS; Fri, 15 May 2020 14:51:51 +0300
Date:   Fri, 15 May 2020 14:51:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
        linux-mips@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/19] dt-bindings: spi: dw: Add Tx/Rx DMA properties
Message-ID: <20200515115151.GU185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-2-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 01:47:40PM +0300, Serge Semin wrote:
> Since commit 22d48ad7bfac ("spi: dw: Add Elkhart Lake PSE DMA support")
> the spi-dw-mid.c module supports a platform DMA engine handling the DW APB
> SSI controller requests. Lets alter the DW SPI bindings file to accept the
> Rx and Tx DMA line specifiers.

I'm wondering if these properties are implied by the SPI generic one?
(forgive me if I'm not understanding all DT schema relations)

Per se looks good.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gareth Williams <gareth.williams.jx@renesas.com>
> Cc: linux-mips@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Revert the order of the DT changes: first add the DMA channels support,
>   then perform the binding file conversion.
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> index 7a4702edf896..020e3168ee41 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> @@ -23,6 +23,8 @@ Optional properties:
>  - num-cs : The number of chipselects. If omitted, this will default to 4.
>  - reg-io-width : The I/O register width (in bytes) implemented by this
>    device.  Supported values are 2 or 4 (the default).
> +- dmas : Phandle + identifiers of Tx and Rx DMA channels.
> +- dma-names : Contains the names of the DMA channels. Must be "tx" and "rx".
>  
>  Child nodes as per the generic SPI binding.
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


