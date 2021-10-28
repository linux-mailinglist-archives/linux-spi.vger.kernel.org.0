Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64743DD76
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJ1JNx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJ1JNx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 05:13:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2380BC061570;
        Thu, 28 Oct 2021 02:11:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q16so9547373ljg.3;
        Thu, 28 Oct 2021 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HaFtusB1yeYK1/7m7q8b+ikbAL6j1FjDXfNSnND+K+s=;
        b=CNlzPEP8uc7ZR0GWOjIFHlNlkGQOygo1HWywRgQLrbNjvWHSQUc1QC6atXT/nUUOs+
         3sjpm2BpheifE/FQeL/k49qGTL3C2MKhzMH/VC1geTGMtTjj/yJ3L3HThJavP+im8IT6
         D+D3mtIYQQl8pNli9276ZnrJWSF9MusaAvemGvDYi7Dt1qMDdKFyjIiIhliMCymTdcxy
         PL1Zmi4fH/lzKE9nyWYhIv8CCLFeItEyoGQ6QmS36puPgTYOqfYn/N3uHjBq1Fv7AS/H
         /bQbj8jXlBxWXu0JQ3XEV65t9p1N1cQfCCvmIgx3oX83tcXqyZFdMKIXA4Asy7JvVIhc
         hEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HaFtusB1yeYK1/7m7q8b+ikbAL6j1FjDXfNSnND+K+s=;
        b=3UIPMjBvicqED3vx+8zuPwpKI2BXXN+sCBtYqKptEG0CztfOaZ/br7gn19XnDrG8XG
         DkIobEr7VorCNgYdUBoLEDvaBcCV1tlqnQ12SXM82XK4o442we/y2J4DN001LMezvZed
         qoDy5FsGTOx8RrlxjGY7Zx8JKGpeNzU7bU3MEmEwLWYBCaPNlnYfXLLrwfF5JqoUrcQL
         BpJEYuZWhhkrj/Ua5hEbL4ogDFyFkhYacF1Q+RpLnLOwEuvKg4ldjrcYs8gn8ReQ3FVm
         VJI6D48phPgCaboyYxe69E+bx+8LZ4ZoShmUQCkwACRWD8m1d4CCwRgCMkSlL/WK8FX+
         gFkQ==
X-Gm-Message-State: AOAM530fNsBoHpaSN53AQOLD8tgXbVlBvJD30q704XBg5D/8ikRxSbP3
        IiBqkxe1WLyIn/rpstDp3Qc=
X-Google-Smtp-Source: ABdhPJwvejmxjwMA5o6s6xVgy7YmVtp4cnGquHofMTEAjHPOnw0Wp7qMrUELXqJcrnoC2X5l7Y60Rw==
X-Received: by 2002:a05:651c:a09:: with SMTP id k9mr3283882ljq.442.1635412284082;
        Thu, 28 Oct 2021 02:11:24 -0700 (PDT)
Received: from mobilestation ([95.79.132.211])
        by smtp.gmail.com with ESMTPSA id bn28sm248802ljb.117.2021.10.28.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:11:23 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:11:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/11] spi: dw: Add support for Pensando Elba SoC
Message-ID: <20211028091121.3ncs4lqfck47edo4@mobilestation>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-11-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-11-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 24, 2021 at 06:51:55PM -0700, Brad Larson wrote:
> The Pensando Elba SoC includes a DW apb_ssi v4 controller
> with device specific chip-select control.  The Elba SoC
> provides four chip-selects where the native DW IP supports
> two chip-selects.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Changelog:
> - Changed the implementation to use existing dw_spi_set_cs() and
>   integrated Elba specific CS control into spi-dw-mmio.c.  The
>   native designware support is for two chip-selects while Elba
>   provides 4 chip-selects.  Instead of adding a new file for
>   this support in gpio-elba-spics.c the support is in one
>   file (spi-dw-mmio.c).
> 
>  drivers/spi/spi-dw-mmio.c | 85 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 3379720cfcb8..fe7b595fe33d 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -53,6 +53,24 @@ struct dw_spi_mscc {
>  	void __iomem        *spi_mst; /* Not sparx5 */
>  };
>  
> +struct dw_spi_elba {
> +	struct regmap *regmap;
> +	unsigned int reg;
> +};
> +
> +/*

> + * Elba SoC does not use ssi, pin override is used for cs 0,1 and
> + * gpios for cs 2,3 as defined in the device tree.

I believe GPIO-based CS is the platform-property rather than the SoC
one. It's up to the board designers which GPIOs to use as a custom
chip-select signal. Thus it would be better to discard the comment
regarding the GPIOs here.

> + *
> + * cs:  |       1               0
> + * bit: |---3-------2-------1-------0
> + *      |  cs1   cs1_ovr   cs0   cs0_ovr
> + */
> +#define ELBA_SPICS_SHIFT(cs)		(2 * (cs))
> +#define ELBA_SPICS_MASK(cs)		(0x3 << ELBA_SPICS_SHIFT(cs))
> +#define ELBA_SPICS_SET(cs, val)	\
> +			((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
> +
>  /*
>   * The Designware SPI controller (referred to as master in the documentation)
>   * automatically deasserts chip select when the tx fifo is empty. The chip
> @@ -237,6 +255,72 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void elba_spics_set_cs(struct dw_spi_elba *dwselba, int cs, int enable)
> +{
> +	regmap_update_bits(dwselba->regmap, dwselba->reg, ELBA_SPICS_MASK(cs),
> +			   ELBA_SPICS_SET(cs, enable));
> +}
> +
> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
> +	struct dw_spi_elba *dwselba = dwsmmio->priv;
> +	u8 cs = spi->chip_select;
> +
> +	if (cs < 2) {
> +		/* overridden native chip-select */
> +		elba_spics_set_cs(dwselba, spi->chip_select, enable);
> +	}
> +
> +	/*
> +	 * The DW SPI controller needs a native CS bit selected to start

> +	 * the serial engine, and we have fewer native CSs than we need, so
                                  ^
                                  + "the platform may have ..."

> +	 * use CS0 always.
> +	 */
> +	spi->chip_select = 0;
> +	dw_spi_set_cs(spi, enable);
> +	spi->chip_select = cs;

Is it correct to think that the DW SSI output CS signals are
multiplexed between the native DW SSI CS logic and the logic
implemented in the ELBA SPICS syscon? Thus by setting "csX_ovr" in the
ELBA_SPICS CSR do you get to switch between the DW SSI SER logic and
the signal level selected by the "csX" field of that register?

* Most likely I already asked this question in v2 but it was long time
ago, so it's better to clarify things over.

> +}
> +
> +static int dw_spi_elba_init(struct platform_device *pdev,
> +			    struct dw_spi_mmio *dwsmmio)
> +{
> +	struct of_phandle_args args;
> +	struct dw_spi_elba *dwselba;
> +	struct regmap *regmap;
> +	int rc;
> +

> +	rc = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +			"pensando,spics", 1, 0, &args);
> +	if (rc) {
> +		dev_err(&pdev->dev, "could not find pensando,spics\n");
> +		return rc;
> +	}
> +
> +	regmap = syscon_node_to_regmap(args.np);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "could not map pensando,spics\n");
> +		return PTR_ERR(regmap);
> +	}

There is a good wrapper for this: syscon_regmap_lookup_by_phandle_args() .

The property name isn't well descriptive in the syscon-related
part. Could you add something like:
"pensando,elba-syscon-spics"/"pensando,syscon-spics"?

-Sergey

> +
> +	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
> +	if (!dwselba)
> +		return -ENOMEM;
> +
> +	dwselba->regmap = regmap;
> +	dwselba->reg = args.args[0];
> +
> +	/* deassert cs */
> +	elba_spics_set_cs(dwselba, 0, 1);
> +	elba_spics_set_cs(dwselba, 1, 1);
> +
> +	dwsmmio->priv = dwselba;
> +	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> +
> +	return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>  	int (*init_func)(struct platform_device *pdev,
> @@ -351,6 +435,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
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
