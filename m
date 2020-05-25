Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59E81E0F37
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgEYNP4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 09:15:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:28168 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbgEYNP4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 09:15:56 -0400
IronPort-SDR: +PegbDlUi8xRiSB+Zc+89GDiOusU/HbB8ecyyWdNPDQN2cmRdto0zNI/ByEiiiG1j7nyXosij9
 gl/NESRTcDTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 06:15:55 -0700
IronPort-SDR: 8AuQsZxigpi06am9fBxr8UDauehfeYplSb05dVBYRQwCH5MVjdZfPxlhIxbEScPus5E6ANomqc
 BleDHva/IcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="467965450"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 25 May 2020 06:15:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdCxR-008n7M-2w; Mon, 25 May 2020 16:15:57 +0300
Date:   Mon, 25 May 2020 16:15:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 1/3] spi: dw: Fix controller unregister order
Message-ID: <20200525131557.GW1634618@smile.fi.intel.com>
References: <cover.1590408496.git.lukas@wunner.de>
 <3fff8cb8ae44a9893840d0688be15bb88c090a14.1590408496.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fff8cb8ae44a9893840d0688be15bb88c090a14.1590408496.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 02:25:01PM +0200, Lukas Wunner wrote:
> The Designware SPI driver uses devm_spi_register_controller() on bind.
> As a consequence, on unbind, __device_release_driver() first invokes
> dw_spi_remove_host() before unregistering the SPI controller via
> devres_release_all().
> 
> This order is incorrect:  dw_spi_remove_host() shuts down the chip,
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
> steps in dw_spi_remove_host(), e.g. by calling devm_add_action_or_reset()
> on probe.  However that approach would add more LoC to the driver and
> it wouldn't lend itself as well to backporting to stable.

I think it's, unregistering controller first, proper way to quiescence it,
otherwise it can be a surprise transfer started while we are in removal stage.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Fixes: 04f421e7b0b1 ("spi: dw: use managed resources")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v3.14+
> Cc: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/spi/spi-dw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 1edb8cdd11ee..9d6904d30104 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -520,7 +520,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  		}
>  	}
>  
> -	ret = devm_spi_register_controller(dev, master);
> +	ret = spi_register_controller(master);
>  	if (ret) {
>  		dev_err(&master->dev, "problem registering spi master\n");
>  		goto err_dma_exit;
> @@ -544,6 +544,8 @@ void dw_spi_remove_host(struct dw_spi *dws)
>  {
>  	dw_spi_debugfs_remove(dws);
>  
> +	spi_unregister_controller(dws->master);
> +
>  	if (dws->dma_ops && dws->dma_ops->dma_exit)
>  		dws->dma_ops->dma_exit(dws);
>  
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


