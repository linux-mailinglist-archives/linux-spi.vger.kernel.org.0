Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEFA281086
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 12:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgJBKXC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 06:23:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:5705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387713AbgJBKXC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 06:23:02 -0400
IronPort-SDR: R84LqjUe8dygnTE1QPefgd6CRjpBvM2PeKaMB5lz8rcZ/u8JaB7RjXoCD0SKn7faOMGLLCp9+/
 XIqoKqY42ipg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="247700969"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="247700969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:22:55 -0700
IronPort-SDR: gc//VJbE0gXFXC9iZeT5d9vfmSS9TAnFq+YaJMKFshIM52b4RJRIAmDwHEbQTf3HluOptSNk/4
 ifRNt9L3eTAA==
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="352331635"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:22:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kOID8-003PgX-7y; Fri, 02 Oct 2020 13:22:46 +0300
Date:   Fri, 2 Oct 2020 13:22:46 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/21] spi: dw: Detach SPI device specific CR0 config
 method
Message-ID: <20201002102246.GX3956970@smile.fi.intel.com>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001222829.15977-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 01:28:11AM +0300, Serge Semin wrote:
> Indeed there is no point in detecting the SPI peripheral device parameters
> and initializing the CR0 register fields each time an SPI transfer is
> executed. Instead let's define a dedicated CR0 chip-data member, which
> will be initialized in accordance with the SPI device settings at the
> moment of setting it up.
> 
> By doing so we'll finally make the SPI device chip_data serving as it's
> supposed to - to preserve the SPI device specific DW SPI configuration.
> See spi-fsl-dspi.c, spi-pl022.c, spi-pxa2xx.c drivers for example of the
> way the chip data is utilized.

> +static void dw_spi_update_cr0(struct dw_spi *dws, struct spi_device *spi,
> +			      struct spi_transfer *transfer)

Yep, why not to place this in previous patch exactly here?

> +	/*
> +	 * Update CR0 data each time the setup callback is invoked since
> +	 * the device parameters could have been changed, for instance, by
> +	 * the MMC SPI driver or something else.
> +	 */
> +	chip->cr0 = dw_spi_get_cr0(dws, spi);

I would rather name it prepare or alike. 'get' assumes getting value or
something like that.

-- 
With Best Regards,
Andy Shevchenko


