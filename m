Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C863505E5
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhCaSAa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhCaSAX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Mar 2021 14:00:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68507C061574;
        Wed, 31 Mar 2021 11:00:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d13so9401433lfg.7;
        Wed, 31 Mar 2021 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Q9oxhnKEAurSYSJEH9M9Sm61COtmi4Ok3DH92mW23E=;
        b=h2lTTlH/+QWKj7wZpU0g5C99CDE6tQqaQ5ztaODdS8rmC29fLr6Zzr0goXM/KHuhl2
         SyVQ7j0mH5NIPXKNx6/lMvjcpwv9brWlhMmZCkgWeEPXfzylyXH7h+bqw3mni+t4PMl0
         fG5AJpoRqAasJFzkXcgOcKut8TxjqccYSPsxyw53RBMo0IElOIw/QV3nDuf5TnFw0BLL
         jpK+4Tfixv6ijT1wIiBcEBuTco47NCIs2vvcz6cNgSBarbfQG1U0PtXcScq8AWk0Jq3c
         TWrxaGq+WkHSH6yozer04Gx2dLaam2idQPQ5uzQ67bZ//KQJXqJid6tuQYIipJCBxGzH
         ijYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Q9oxhnKEAurSYSJEH9M9Sm61COtmi4Ok3DH92mW23E=;
        b=d2317/cLyDk/FScYCr60ImsEEGY1vLEGHdTyLgjFOfQxoaLLyo2s+Mgm436EQq3Kep
         QGlMJ/A8w9QN3NmIdys9MWRbRHY0g4FxBuUVp7Itv77VD5KRii8vU2caz9ph10zEFTjV
         NwwVZaf7qpu8xkxme9vcf1J8A+PwfZWI+mVJfKNuYRjIIwVuJJ+YvERXxuevkJF3ghwj
         ZfvRAe/Ykd1YRWolZbo3v6Rz2wIKYoP7yMUCosfc7wVgKfvQqPOiom+otTeq4qWI0HXr
         xu/UafPoc3638QPf4yjmGTeSWr/9CtTA5rGK9jCt3BQnNTzfLql8/FcRp6J3Y2fzJC7Q
         WIgg==
X-Gm-Message-State: AOAM531NN/zMFqDVZ4IJZZFV23YwYCRrBTjvFtNfuzjNcnnuiuPp8YRO
        7qnQHqPTxXBIpUfsIL+lmA8=
X-Google-Smtp-Source: ABdhPJyx4lAT+sVVFl5m4Yt0LNsve3Yt3vkYiD3cRMaY6C0bvxtOaE1jK6wf74B0uUteMcXor6j0Kg==
X-Received: by 2002:a19:e0d:: with SMTP id 13mr2907573lfo.549.1617213620975;
        Wed, 31 Mar 2021 11:00:20 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id q8sm292564lfc.223.2021.03.31.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 11:00:20 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:00:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
Message-ID: <20210331180018.jir2vusuf3sbare5@mobilestation>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-4-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-4-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 28, 2021 at 06:59:28PM -0700, Brad Larson wrote:
> The Pensando Elba SoC uses a GPIO based chip select
> for two DW SPI busses with each bus having two
> chip selects.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/spi/spi-dw-mmio.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 17c06039a74d..c323a5ceecb8 100644
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
> @@ -237,6 +237,31 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +

> +	if (!enable) {

Please, be more attentive to the review-comments given to you before
resending a new patchset. One more time. This version of set_cs won't
work for Active-high CS. Each SPI controller working with GPIO-based
chip-select is marked as supporting that feature. So your DW
SPI controller won't be able to work correctly with SPI-devices
activated by active-high chip-select signal. Note default
dw_spi_set_cs() callback supports that.

-Sergey

> +		/*
> +		 * Using a GPIO-based chip-select, the DW SPI
> +		 * controller still needs its own CS bit selected
> +		 * to start the serial engine.  On Elba the specific
> +		 * CS doesn't matter to start the serial engine,
> +		 * so using CS0.
> +		 */
> +		dw_writel(dws, DW_SPI_SER, BIT(0));
> +	} else {
> +		dw_writel(dws, DW_SPI_SER, 0);
> +	}
> +}
> +
> +static int dw_spi_elba_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -351,6 +376,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> +	{ .compatible = "pensando,elba-spi", .data = dw_spi_elba_init},
>  	{ /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> -- 
> 2.17.1
> 
