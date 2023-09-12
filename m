Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40279D285
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjILNkp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjILNko (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 09:40:44 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086210CE;
        Tue, 12 Sep 2023 06:40:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CDeamg012449;
        Tue, 12 Sep 2023 08:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694526036;
        bh=Wk+Rj9eTKsEanRhRmjksM6Jgov7RfycUoTBOPUqt2xU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ETQ8Xue2GgtF/6xdtavkn025Mk4KZjAdxlWu2W3sfM9FCrkforOuasiGsLYJEOFbY
         gvBLPmvHIlh70wOQJLN1+OpVkwZCg5XPfFNzaxDd65+q9K3qcbNFRw6VjOE7xUs99Q
         c+CHK8+O9vMUDwM84495zgMjGW3syfBugQtwaTeo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CDeaV7004659
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Sep 2023 08:40:36 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 08:40:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 08:40:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CDeZuD018397;
        Tue, 12 Sep 2023 08:40:35 -0500
Date:   Tue, 12 Sep 2023 19:10:34 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <t-kristo@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix hardcoded reference clock
Message-ID: <20230912134034.hkciu5wqiuci6hga@dhruva>
References: <20230912100328.31813-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912100328.31813-1-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sep 12, 2023 at 15:33:28 +0530, Vaishnav Achath wrote:
> A hardcoded reference clock of 48 MHz is used to calculate the
> clock divisor values, but the reference clock frequency can be
> different across devices and can be configured which can cause
> a mismatch between the reported frequency and actual SPI clock
> frequency observed. Fix this by fetching the clock rate from
> the clock provider and falling back to hardcoded reference only
> if the clock is not supplied.
> 
> Fixes: 2cd7d393f461 ("arm64: dts: ti: k3-am654: Add McSPI DT nodes")
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> Blamed commit is the first device where the default reference clock was
> different from the hardcoded value.
> Tested on TDA4VM SK (6.6.0-rc1-next-20230911)

Would be good to have some logs too next time, to share how it was tested.

> 
>  drivers/spi/spi-omap2-mcspi.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index e5cd82eb9e54..6ec45fd0e904 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -125,8 +125,10 @@ struct omap2_mcspi {
>  	struct omap2_mcspi_dma	*dma_channels;
>  	struct device		*dev;
>  	struct omap2_mcspi_regs ctx;
> +	struct clk		*clk;

I dislike naming an obj after it's struct, can we come up with some
other name?

>  	int			fifo_depth;
>  	bool			slave_aborted;
> +	unsigned int		ref_clk_hz;

Do you want to make it u32 here? or...

>  	unsigned int		pin_dir:1;
>  	size_t			max_xfer_len;
>  };
> @@ -880,12 +882,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  	return count - c;
>  }
>  
> -static u32 omap2_mcspi_calc_divisor(u32 speed_hz)
> +static u32 omap2_mcspi_calc_divisor(u32 speed_hz, u32 ref_clk_hz)

unsigned int ref_clk_hz here?

>  {
>  	u32 div;
>  
>  	for (div = 0; div < 15; div++)
> -		if (speed_hz >= (OMAP2_MCSPI_MAX_FREQ >> div))
> +		if (speed_hz >= (ref_clk_hz >> div))
>  			return div;
>  
>  	return 15;
> @@ -897,7 +899,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
>  {
>  	struct omap2_mcspi_cs *cs = spi->controller_state;
>  	struct omap2_mcspi *mcspi;
> -	u32 l = 0, clkd = 0, div, extclk = 0, clkg = 0;
> +	u32 ref_clk_hz, l = 0, clkd = 0, div, extclk = 0, clkg = 0;

here as well, your ref_clk_hz is u32 but below you're making it mcspi->ref_clk_hz
which is an unsigned int?

I know it's not a deal breaker, however not a big fan of mixing fixed
types and types that the compiler may decide.

>  	u8 word_len = spi->bits_per_word;
>  	u32 speed_hz = spi->max_speed_hz;
>  
> @@ -911,14 +913,15 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
>  	if (t && t->speed_hz)
>  		speed_hz = t->speed_hz;
>  
> -	speed_hz = min_t(u32, speed_hz, OMAP2_MCSPI_MAX_FREQ);
> -	if (speed_hz < (OMAP2_MCSPI_MAX_FREQ / OMAP2_MCSPI_MAX_DIVIDER)) {
> -		clkd = omap2_mcspi_calc_divisor(speed_hz);
> -		speed_hz = OMAP2_MCSPI_MAX_FREQ >> clkd;
> +	ref_clk_hz = mcspi->ref_clk_hz;
> +	speed_hz = min_t(u32, speed_hz, ref_clk_hz);
> +	if (speed_hz < (ref_clk_hz / OMAP2_MCSPI_MAX_DIVIDER)) {
> +		clkd = omap2_mcspi_calc_divisor(speed_hz, ref_clk_hz);
> +		speed_hz = ref_clk_hz >> clkd;
>  		clkg = 0;
>  	} else {
> -		div = (OMAP2_MCSPI_MAX_FREQ + speed_hz - 1) / speed_hz;
> -		speed_hz = OMAP2_MCSPI_MAX_FREQ / div;
> +		div = (ref_clk_hz + speed_hz - 1) / speed_hz;
> +		speed_hz = ref_clk_hz / div;
>  		clkd = (div - 1) & 0xf;
>  		extclk = (div - 1) >> 4;
>  		clkg = OMAP2_MCSPI_CHCONF_CLKG;
> @@ -1448,8 +1451,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  	master->cleanup = omap2_mcspi_cleanup;
>  	master->slave_abort = omap2_mcspi_slave_abort;
>  	master->dev.of_node = node;
> -	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
> -	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
>  	master->use_gpio_descriptors = true;
>  
>  	platform_set_drvdata(pdev, master);
> @@ -1519,6 +1520,14 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>  		goto free_master;
>  	}
>  
> +	mcspi->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
> +	if (mcspi->clk)
> +		mcspi->ref_clk_hz = clk_get_rate(mcspi->clk);
> +	else
> +		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
> +	master->max_speed_hz = mcspi->ref_clk_hz;
> +	master->min_speed_hz = mcspi->ref_clk_hz >> 15;
> +
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_enable(&pdev->dev);
> -- 
> 2.17.1
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
