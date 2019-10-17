Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA4DA5F4
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407894AbfJQHGn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 03:06:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:31336 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390955AbfJQHGn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Oct 2019 03:06:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 00:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="221031393"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2019 00:06:40 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iKzrr-0008G3-03; Thu, 17 Oct 2019 10:06:39 +0300
Date:   Thu, 17 Oct 2019 10:06:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: pxa2xx: Set controller->max_transfer_size in dma
 mode
Message-ID: <20191017070638.GB32742@smile.fi.intel.com>
References: <20191016195721.3714-1-daniel.vetter@ffwll.ch>
 <20191017064426.30814-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191017064426.30814-1-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 17, 2019 at 08:44:26AM +0200, Daniel Vetter wrote:
> In DMA mode we have a maximum transfer size, past that the driver
> falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
> Falling back to PIO for big transfers defeats the point of a dma engine,
> hence set the max transfer size to inform spi clients that they need
> to do something smarter.
> 
> This was uncovered by the drm_mipi_dbi spi panel code, which does
> large spi transfers, but stopped splitting them after:
> 
> commit e143364b4c1774f68e923a5a0bb0fca28ac25888
> Author: Noralf Trønnes <noralf@tronnes.org>
> Date:   Fri Jul 19 17:59:10 2019 +0200
> 
>     drm/tinydrm: Remove tinydrm_spi_max_transfer_size()
> 
> After this commit the code relied on the spi core to split transfers
> into max dma-able blocks, which also papered over the PIO fallback issue.
> 
> Fix this by setting the overall max transfer size to the DMA limit,
> but only when the controller runs in DMA mode.
> 

Thank you, Daniel!

> Fixes: e143364b4c17 ("drm/tinydrm: Remove tinydrm_spi_max_transfer_size()")
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reported-and-tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> --
> v2: Brown paper bag edition, it needs to be a function ...
> ---
>  drivers/spi/spi-pxa2xx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index bb6a14d1ab0f..068c21037679 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1602,6 +1602,11 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
>  	return cs;
>  }
>  
> +static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
> +{
> +	return MAX_DMA_LEN;
> +}
> +
>  static int pxa2xx_spi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1707,6 +1712,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>  		} else {
>  			controller->can_dma = pxa2xx_spi_can_dma;
>  			controller->max_dma_len = MAX_DMA_LEN;
> +			controller->max_transfer_size =
> +				pxa2xx_spi_max_dma_transfer_size;
>  		}
>  	}
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


