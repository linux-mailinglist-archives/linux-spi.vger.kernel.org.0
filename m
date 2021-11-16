Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064A1452ECB
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhKPKRr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 05:17:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:45015 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233981AbhKPKQP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Nov 2021 05:16:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="233903450"
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="233903450"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 02:13:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="586064981"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 02:13:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mmvSd-007Nja-G8;
        Tue, 16 Nov 2021 12:13:07 +0200
Date:   Tue, 16 Nov 2021 12:13:07 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] spi: dw: Define the capabilities in a continuous
 bit-flags set
Message-ID: <YZOEM591s7iulPH1@smile.fi.intel.com>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
 <20211115181917.7521-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115181917.7521-8-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 15, 2021 at 09:19:17PM +0300, Serge Semin wrote:
> Since the DW_SPI_CAP_DWC_HSSI capability has just been replaced with using
> the DW SSI IP-core versions interface, the DW SPI capability flags are now
> represented with a gap. Let's fix it by redefining the DW_SPI_CAP_DFS32
> macro to setting BIT(2) of the capabilities field.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Fine with me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the previous one as of Andy
>   suggested.
> ---
>  drivers/spi/spi-dw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 8334e6b35f89..d5ee5130601e 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -32,7 +32,7 @@
>  /* DW SPI controller capabilities */
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> -#define DW_SPI_CAP_DFS32		BIT(3)
> +#define DW_SPI_CAP_DFS32		BIT(2)
>  
>  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
>  #define DW_SPI_CTRLR0			0x00
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


