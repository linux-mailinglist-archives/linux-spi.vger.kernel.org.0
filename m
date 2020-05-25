Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6B1E0F50
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 15:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbgEYNVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 09:21:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:64866 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbgEYNVo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 09:21:44 -0400
IronPort-SDR: 88LOIFg7/AW2qRVMbCLOIxeoPXctGCWvhu4rPIf/JckNLm6SFXMAoYTCz00O4Asi0x5I1a5ROZ
 +lCoz+zmHBzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 06:21:43 -0700
IronPort-SDR: lAmQCS1ajFGIFB/ggIJ5+sv4g+wrtZstBjemSpKaIgRXV2fE0DdS0VKfYW8yB4783om77p9EEu
 1hz2Yolmg4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="467966375"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 25 May 2020 06:21:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdD31-008nAh-3s; Mon, 25 May 2020 16:21:43 +0300
Date:   Mon, 25 May 2020 16:21:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
Message-ID: <20200525132143.GX1634618@smile.fi.intel.com>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 02:25:02PM +0200, Lukas Wunner wrote:
> The PXA2xx SPI driver uses devm_spi_register_controller() on bind.
> As a consequence, on unbind, __device_release_driver() first invokes
> pxa2xx_spi_remove() before unregistering the SPI controller via
> devres_release_all().
> 
> This order is incorrect:  pxa2xx_spi_remove() disables the chip,
> rendering the SPI bus inaccessible even though the SPI controller is
> still registered.  When the SPI controller is subsequently unregistered,
> it unbinds all its slave devices.  Because their drivers cannot access
> the SPI bus, e.g. to quiesce interrupts, the slave devices may be left
> in an improper state.
> 
> As a rule, devm_spi_register_controller() must not be used if the
> ->remove() hook performs teardown steps which shall be performed after
> unregistering the controller and specifically after unbinding of slaves.
> 
> Fix by reverting to the non-devm variant of spi_register_controller().
> 
> An alternative approach would be to use device-managed functions for all
> steps in pxa2xx_spi_remove(), e.g. by calling devm_add_action_or_reset()
> on probe.  However that approach would add more LoC to the driver and
> it wouldn't lend itself as well to backporting to stable.

I think it's, unregistering controller first, proper way to quiescence it,
otherwise it can be a surprise transfer started while we are in removal stage.

Yes, there are still some bugs in state machine and remove ordering, but
perhaps they can be fixed separately.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tsuchiya Yuto, I'm going to apply this series as preparatory to my WIP patch in
topic/spi/reload branch in my kernel tree on GitHub, so, it would be possible
to see if this + my patch fixes crashes on removal. Though, please test this
separately from my stuff to clarify if it fixes or not issue you have seen.

> 
> The improper use of devm_spi_register_controller() was introduced in 2013
> by commit a807fcd090d6 ("spi: pxa2xx: use devm_spi_register_master()"),
> but all earlier versions of the driver going back to 2006 were likewise
> broken because they invoked spi_unregister_master() at the end of
> pxa2xx_spi_remove(), rather than at the beginning.
> 
> Fixes: e0c9905e87ac ("[PATCH] SPI: add PXA2xx SSP SPI Driver")

I'm not sure it's a good idea to mix devm_*() with so old patch, though I
understand your point. Let's leave it up to Mark to decide what would be
correct commit reference here.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206403#c1
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.17+
> Cc: Tsuchiya Yuto <kitakar@gmail.com>
> ---
>  drivers/spi/spi-pxa2xx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 20dcbd35611a..2ecf0d8cd9f7 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1885,7 +1885,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>  
>  	/* Register with the SPI framework */
>  	platform_set_drvdata(pdev, drv_data);
> -	status = devm_spi_register_controller(&pdev->dev, controller);
> +	status = spi_register_controller(controller);
>  	if (status != 0) {
>  		dev_err(&pdev->dev, "problem registering spi controller\n");
>  		goto out_error_pm_runtime_enabled;
> @@ -1917,6 +1917,8 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  
> +	spi_unregister_controller(drv_data->controller);
> +
>  	/* Disable the SSP at the peripheral and SOC level */
>  	pxa2xx_spi_write(drv_data, SSCR0, 0);
>  	clk_disable_unprepare(ssp->clk);
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


