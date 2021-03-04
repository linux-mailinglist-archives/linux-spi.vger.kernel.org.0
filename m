Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25A32CD1A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 07:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhCDGpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 01:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbhCDGpR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 01:45:17 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5A3C061574;
        Wed,  3 Mar 2021 22:44:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u18so18311977ljd.3;
        Wed, 03 Mar 2021 22:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5dPNy/fWUlSOC24Di7+vnxbeD5VbGpIQk9p1aWlyy6Y=;
        b=B+36IKDutQlaSTLSRwDQk7mlCQQvnvswJ72hNIJSI/QcUrFTyxhPVELjisK4A94UkS
         giIcHkUX/XoRY1tFS8rARf4+OPuykhuGqY2iBngTHjFRg7z+veyaN+YT9o8M8YTQVCGg
         fBOO6g+0ACwDdGAp+WnPTcm9pVhptZ34kH9inrBcp/1i6TJa2tSV8t5IRF/hBHRq9Bdf
         Vulko/veRZo7C9vNa6GhW5DHdF+1dJiFjuNvlC6/hIqHce3hPUqnFXboE89cA/jrP7eb
         Iss9BZyfDWjbl2Ns6ZDNn+uMu6Do+iPpAEG2tHgaRvJhPH1IsVreXqR7nFtdms+ZuEZp
         26kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dPNy/fWUlSOC24Di7+vnxbeD5VbGpIQk9p1aWlyy6Y=;
        b=tgl3iplLaB2rGbk0cg5AIVEslkd8Q5Rktueo5nz+gEcsVIfsUAmTzjLurt23+U5JS+
         dL0ViZqYjmH2LB6H4rLWE1AKfJNmt8uYgZ8gfJRR9xmomUE2KQkyYIONtP+z/utGJqO0
         3WDzLxPsaQXpGo3VuhcRg7XSVd8V+AGP9jDU0qsjv/izcn/5a4eLoikMh8Gbdzm3dJA1
         kRMasBiiu+b3lhGHA3S9ZoL63B+yoOwm7WcKsuqRxT+OIvlrVHxYMbIJVfQ++KVn28Ob
         8CmgnGWy5r6j5UWUbkM6AHJp0KzAiimZQQTr5N613+peXQdyhsTVpGAagjHPm2ScNc1v
         u+lw==
X-Gm-Message-State: AOAM532ih5aXG7c+oOzCyLUNhalS5+73ncD9u6pnU53u1NZQjnY2fT+G
        AggpC08lLcK3fzDL+R1KB4E=
X-Google-Smtp-Source: ABdhPJzV1HBtHmReuq2K6OSZOnFhY7SteJrDtkacYg724y7AqJ6DEZTRHBlDHO9Ip2lQWLbRxzbbaA==
X-Received: by 2002:a2e:8114:: with SMTP id d20mr1468091ljg.83.1614840275562;
        Wed, 03 Mar 2021 22:44:35 -0800 (PST)
Received: from mobilestation ([95.79.88.254])
        by smtp.gmail.com with ESMTPSA id p21sm3173217lfu.227.2021.03.03.22.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 22:44:35 -0800 (PST)
Date:   Thu, 4 Mar 2021 09:44:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] spi: dw: Add support for Pensando Elba SoC SPI
Message-ID: <20210304064433.vqyqg3byedvc4quz@mobilestation>
References: <20210304034141.7062-1-brad@pensando.io>
 <20210304034141.7062-4-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304034141.7062-4-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Brad.
Thanks for the patch. See my comments below.

On Wed, Mar 03, 2021 at 07:41:36PM -0800, Brad Larson wrote:
> The Pensando Elba SoC uses a GPIO based chip select
> for two DW SPI busses with each bus having two
> chip selects.

I see a contradiction here. Normally GPIO-based chip-select is a
property of a platform, but not a SoC/CPU/MCU/etc. Most of the time
SoC SPI interfaces still get to have native CS pins, while at some
platform configurations (like in case of DW APB SPI, which doesn't
provide a way to directly toggle its native CSs) it's easier or even
safer to use GPIOs as CS signals. Of course theoretically a SoC could
be synthesized so it doesn't have native CS output pins, but only some
virtual internal CS flags, but I've never seen such. Anyway according
to the custom CS method below it's not your case because you still
provide support for SPI-devices handled by native CS (else branch in
the if (spi->cs_gpiod) {} else {} statement).

> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/spi/spi-dw-mmio.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 17c06039a74d..417bd2125c07 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -56,7 +56,7 @@ struct dw_spi_mscc {
>  /*
>   * The Designware SPI controller (referred to as master in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
> - * selects then needs to be either driven as GPIOs or, for the first 4 using the
> + * selects then needs to be either driven as GPIOs or, for the first 4 using
>   * the SPI boot controller registers. the final chip select is an OR gate
>   * between the Designware SPI controller and the SPI boot controller.
>   */
> @@ -237,6 +237,38 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>
  
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +
> +	if (!enable) {
> +		if (spi->cs_gpiod) {
> +			/*
> +			 * Using a GPIO-based chip-select, the DW SPI
> +			 * controller still needs its own CS bit selected
> +			 * to start the serial engine.  On Elba the specific
> +			 * CS doesn't matter, so use CS0.
> +			 */
> +			dw_writel(dws, DW_SPI_SER, BIT(0));
> +		} else {
> +			/*
> +			 * Using the intrinsic DW chip-select; set the
> +			 * appropriate CS.
> +			 */
> +			dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
> +		}
> -	} else
  +	} else {
> +		dw_writel(dws, DW_SPI_SER, 0);
  +	} /* See [1] */
> +}

The custom CS-method above doesn't look much different from the
dw_spi_set_cs() method defined in the spi-dw-core.o driver, except
having at least two problems:
1) It assumes that "enable" argument means the CS-enabling flag, while
in fact it's the CS-level which depending on the SPI_CS_HIGH flag
set/cleared will be 1/0 respectively if CS is supposed to be enabled.
That aspect has already been fixed in the dw_spi_set_cs() method.
2) The method enables CS[0] if GPIO-CS is used for a particular SPI
device. That will cause problems for a GPIO/native CS intermixed case
of having for instance one SPI-device connected to native CS[0] and
another one - to a GPIO. So trying to communicate with the second SPI
device you'll end up having the native CS[0] activated too thus
having an SPI transfer sent to two SPI-device at the same time.
Of course that's not what you'd want.

Anyway I don't really see why you even need a custom CS method here. A
generic method dw_spi_set_cs() shall work for your SPI interface.
If I am wrong, please explain why. Did you try the generic CS method
on your platform?

[1] Placing Braces and Spaces. Chapter 3). Documentation/process/coding-style.rst

> +
> +static int dw_spi_elba_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -351,6 +383,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},

> +	{ .compatible = "pensando,elba-spi", .data = dw_spi_elba_init },

If you agree with me and remove the custom CS-method defined above in
this patch, then all you'll need is just to add "pensando,elba-spi" here
with generic init-callback set - dw_spi_dw_apb_init.

Finally defining new compatible string requires the bindings update.
In the framework of DW APB SPI interface they are defined in:
Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
So you need to have that DT-schema accordingly altered.

The bindings note concerns the rest of the updates in your patchset too.

-Sergey

>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.17.1
> 
