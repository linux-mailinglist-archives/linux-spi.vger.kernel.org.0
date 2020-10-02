Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211A728108A
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBKY7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 06:24:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:18469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJBKY7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 06:24:59 -0400
IronPort-SDR: jd6KA0dtsfYl2gFNyn7LTppSlQCy/Vj3+jEbcyEbyVG3uRY39hsQhfMfyZkfseai74bBQj6eBo
 BNn16g2RFr1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="224574311"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="224574311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:24:53 -0700
IronPort-SDR: cvPO6Dln90oEmE8FVxe90ZjMXh+ldvSeD4RSw528/WCozuFm2q2UFsGrTJy3lFQgRKusks+o8W
 usMR+Gq8Ka5A==
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="416399919"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:24:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kOIF2-003Phw-54; Fri, 02 Oct 2020 13:24:44 +0300
Date:   Fri, 2 Oct 2020 13:24:44 +0300
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
Subject: Re: [PATCH v3 00/21] spi: dw: Add full Baikal-T1 SPI Controllers
 support
Message-ID: <20201002102444.GY3956970@smile.fi.intel.com>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 02, 2020 at 01:28:08AM +0300, Serge Semin wrote:
> Originally I intended to merge a dedicated Baikal-T1 System Boot SPI
> Controller driver into the kernel and leave the DW APB SSI driver
> untouched. But after a long discussion (see the link at the bottom of the
> letter) Mark and Andy persuaded me to integrate what we developed there
> into the DW APB SSI core driver to be useful for another controllers,
> which may have got the same peculiarities/problems as ours:
> - No IRQ.
> - No DMA.
> - No GPIO CS, so a native CS is utilized.
> - small Tx/Rx FIFO depth.
> - Automatic CS assertion/de-assertion.
> - Slow system bus.
> All of them have been fixed in the framework of this patchset in some
> extent at least for the SPI memory operations. As I expected it wasn't
> that easy and the integration took that many patches as you can see from
> the subject. Though some of them are mere cleanups or weakly related with
> the subject fixes, but we just couldn't leave the code as is at some
> places since we were working with the DW APB SSI driver anyway. Here is
> what we did to fix the original DW APB SSI driver, to make it less messy.

Maybe it's time to put your name into MAINTAINERS for this driver?


-- 
With Best Regards,
Andy Shevchenko


