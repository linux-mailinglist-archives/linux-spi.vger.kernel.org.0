Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BAF28107B
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgJBKTq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 06:19:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:12504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBKTp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 06:19:45 -0400
IronPort-SDR: AdVlLZiMKm0kHnSaWXmiwIIx/CqUrJeEBCsBI4ghqI2IwPSZeaz6CY7coACwtxD9d+TieKkEyn
 EkSO4NyHWirA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160361951"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="160361951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:19:39 -0700
IronPort-SDR: JzKU2qBOyanjdW8uBoVlr2PxlVB12ruNojyn80r1aEfet1ILnVfNIPOK6lg07k2DYhwafyK0Je
 BnYnHsDjvgcQ==
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="515861578"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:19:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kOI9x-003Pdz-BL; Fri, 02 Oct 2020 13:19:29 +0300
Date:   Fri, 2 Oct 2020 13:19:29 +0300
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
Subject: Re: [PATCH v3 02/21] spi: dw: Add DWC SSI capability
Message-ID: <20201002101929.GW3956970@smile.fi.intel.com>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
 <20201001222829.15977-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001222829.15977-3-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 01:28:10AM +0300, Serge Semin wrote:
> Currently DWC SSI core is supported by means of setting up the
> core-specific update_cr0() callback. It isn't suitable for multiple
> reasons. First of all having exported several methods doing the same thing
> but for different chips makes the code harder to maintain. Secondly the
> spi-dw-core driver exports the methods, then the spi-dw-mmio driver sets
> the private data callback with one of them so to be called by the core
> driver again. That makes the code logic too complicated. Thirdly using
> callbacks for just updating the CR0 register is problematic, since in case
> if the register needed to be updated from different parts of the code,
> we'd have to create another callback (for instance the SPI device-specific
> parameters don't need to be calculated each time the SPI transfer is
> submitted, so it's better to pre-calculate the CR0 data at the SPI-device
> setup stage).
> 
> So keeping all the above in mind let's discard the update_cr0() callbacks,
> define a generic and static dw_spi_update_cr0() method and create the
> DW_SPI_CAP_DWC_SSI capability, which when enabled would activate the
> alternative CR0 register layout.
> 
> While at it add the comments to the code path of the normal DW APB SSI
> controller setup to make the dw_spi_update_cr0() method looking coherent.

What the point to increase indentation level and produce additional churn?
Can't you simply leave functions, unexport them, and call in one conditional of
whatever new function is called?

I have an impression that split of the series is done in a way that first
patches in the series are not optimized to what is done in the last patches in
the series.

-- 
With Best Regards,
Andy Shevchenko


