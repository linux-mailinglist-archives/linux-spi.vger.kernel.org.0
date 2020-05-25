Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252A1E0F29
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403779AbgEYNMo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 09:12:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:4845 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403767AbgEYNMo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 09:12:44 -0400
IronPort-SDR: Vy+NCln4HXPvAoz3KjmCZmyb109NlspLxJUt6KbGT6J1/y2aSxkbEMOWWOXPpvjmlxfvvazHkI
 zwtKmEJ25rMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 06:12:43 -0700
IronPort-SDR: 6fieyb1ORDhQKM3rPw4NumDwGq8u1w3R/Jfbxrz0KA59YSZMvwjicjMQ5RMj+Mddkr0wJrwbb7
 U5v5budt/RLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="290867343"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 06:12:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdCuK-008n51-6c; Mon, 25 May 2020 16:12:44 +0300
Date:   Mon, 25 May 2020 16:12:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 3/3] spi: pxa2xx: Fix runtime PM ref imbalance on probe
 error
Message-ID: <20200525131244.GV1634618@smile.fi.intel.com>
References: <cover.1590408496.git.lukas@wunner.de>
 <58b2ac6942ca1f91aaeeafe512144bc5343e1d84.1590408496.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b2ac6942ca1f91aaeeafe512144bc5343e1d84.1590408496.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 02:25:03PM +0200, Lukas Wunner wrote:
> The PXA2xx SPI driver releases a runtime PM ref in the probe error path
> even though it hasn't acquired a ref earlier.
> 
> Apparently commit e2b714afee32 ("spi: pxa2xx: Disable runtime PM if
> controller registration fails") sought to copy-paste the invocation of
> pm_runtime_disable() from pxa2xx_spi_remove(), but erroneously copied
> the call to pm_runtime_put_noidle() as well.  Drop it.

Looks like correct fix to me.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Fixes: e2b714afee32 ("spi: pxa2xx: Disable runtime PM if controller registration fails")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.17+
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 2ecf0d8cd9f7..6721910e5f2a 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1894,7 +1894,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>  	return status;
>  
>  out_error_pm_runtime_enabled:
> -	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
>  out_error_clock_enabled:
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


