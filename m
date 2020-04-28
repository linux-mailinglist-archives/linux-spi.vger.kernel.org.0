Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA28A1BC0EA
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgD1OOv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 10:14:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:59849 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgD1OOu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 10:14:50 -0400
IronPort-SDR: LLcMwZjGyzTvoMbcz8Yfbr/pGk8dbxhv8ppinSi76U29XoFTg5e1KAM7L0YR0Rdxa5+gj+YSlB
 lhtU9MvoMrng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 07:14:50 -0700
IronPort-SDR: p91jQfLvoy5gFXMynjK2xfww/QM1aHbNBf/AbnH1flOme0Ro77zKsxpiEx5vPV17XlPHmN9jzH
 c2rrz2y3Xkqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="459245444"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 28 Apr 2020 07:14:46 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jTR0b-003ZOj-Uc; Tue, 28 Apr 2020 17:14:49 +0300
Date:   Tue, 28 Apr 2020 17:14:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/7] spi: dw: Add support for Intel Keem Bay SPI
Message-ID: <20200428141449.GV185537@smile.fi.intel.com>
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Apr 22, 2020 at 10:11:35PM +0800, Wan Ahmad Zainie wrote:
> This patchset adds support for DesignWare DWC_ssi. This soft IP
> is an AMBA version 2.0-compliant AHB slave device. Existing driver
> already supports the older APB version.
> 
> Intel Keem Bay SPI controller is using this IP. This patchset is
> tested on Keem Bay evaluation module board.

Rob, can we get your Ack if everything is okay, please?

I have more patches coming to this driver and I would not like to delay this
series to be applied.

> 
> Changes since v1:
> - Rework the third patch based on Rob's feedback.
> 
> 
> Wan Ahmad Zainie (7):
>   spi: dw: Fix typo in few registers name
>   spi: dw: Add update_cr0() callback to update CTRLR0
>   dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
>   dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare
>     DWC_ssi
>   spi: dw: Add support for DesignWare DWC_ssi
>   dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
>   spi: dw: Add support for Intel Keem Bay SPI
> 
>  .../bindings/spi/snps,dw-apb-ssi.txt          |  41 ------
>  .../bindings/spi/snps,dw-apb-ssi.yaml         |  72 ++++++++++
>  drivers/spi/spi-dw-mid.c                      |   4 +
>  drivers/spi/spi-dw-mmio.c                     |  57 +++++++-
>  drivers/spi/spi-dw.c                          | 125 +++++++++++++-----
>  drivers/spi/spi-dw.h                          |  25 +++-
>  6 files changed, 243 insertions(+), 81 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


