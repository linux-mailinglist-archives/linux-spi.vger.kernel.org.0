Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B667044C6DC
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 19:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKJSpi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 13:45:38 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50912 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSph (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 13:45:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AAIgmSt010504;
        Wed, 10 Nov 2021 12:42:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636569768;
        bh=20xiynZ1X3msxg/XvoGGOO3+AYxPfmrR9XazGsyvlR0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IJB4q1oCSJgkAVNnpIM0spujLm+M1z0cMUpuAqyh/BcrL+M8XiLZS8yf0h9XFemPG
         ZxHZcwFXPwsC5NGM8ujtHavijLIBl44wDzf4Y14BRWd/0CyH5TGfy1d+NvpeCR7vMw
         6eIfZrkKNoT4HH/mEABhTNfEh/3fHw/oubv0Te/Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AAIgm26020127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Nov 2021 12:42:48 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 10
 Nov 2021 12:42:48 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 10 Nov 2021 12:42:48 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AAIglmW084083;
        Wed, 10 Nov 2021 12:42:47 -0600
Date:   Thu, 11 Nov 2021 00:12:46 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     <broonie@kernel.org>, <a-nandan@ti.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: fix write completion support
Message-ID: <20211110184246.zermc35sgyzpjedd@ti.com>
References: <20211108200854.3616121-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211108200854.3616121-1-dinguyen@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/11/21 02:08PM, Dinh Nguyen wrote:
> Some versions of the Cadence QSPI controller does not have the write
> completion register implemented(CQSPI_REG_WR_COMPLETION_CTRL). On the
> Intel SoCFPGA platform the CQSPI_REG_WR_COMPLETION_CTRL register is
> not configured.
> 
> Add a quirk to not write to the CQSPI_REG_WR_COMPLETION_CTRL register.
> 
> Fixes: 9cb2ff111712 ("spi: cadence-quadspi: Disable Auto-HW polling)
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 8b3d268ac63c..b808c94641fa 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -37,6 +37,7 @@
>  #define CQSPI_NEEDS_WR_DELAY		BIT(0)
>  #define CQSPI_DISABLE_DAC_MODE		BIT(1)
>  #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
> +#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
>  
>  /* Capabilities */
>  #define CQSPI_SUPPORTS_OCTAL		BIT(0)
> @@ -86,6 +87,7 @@ struct cqspi_st {
>  	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>  	bool			use_dma_read;
>  	u32			pd_dev_id;
> +	bool			wr_completion;

We have a bunch of bools lying around in this struct: is_decoded_cs, 
rclk_en, use_direct_mode, use_dma_read, and now wr_completion. It is 
probably worth it to use bitfields and save some memory.

Anyway, I don't consider this a blocker. So either way,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

>  };
>  
>  struct cqspi_driver_platdata {
> @@ -996,9 +998,11 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
>  	 * polling on the controller's side. spinand and spi-nor will take
>  	 * care of polling the status register.
>  	 */
> -	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> -	reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
> -	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +	if (cqspi->wr_completion) {
> +		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
> +		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +	}
>  
>  	reg = readl(reg_base + CQSPI_REG_SIZE);
>  	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
> @@ -1736,6 +1740,10 @@ static int cqspi_probe(struct platform_device *pdev)
>  
>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>  	master->max_speed_hz = cqspi->master_ref_clk_hz;
> +
> +	/* write completion is supported by default */
> +	cqspi->wr_completion = true;
> +
>  	ddata  = of_device_get_match_data(dev);
>  	if (ddata) {
>  		if (ddata->quirks & CQSPI_NEEDS_WR_DELAY)
> @@ -1747,6 +1755,8 @@ static int cqspi_probe(struct platform_device *pdev)
>  			cqspi->use_direct_mode = true;
>  		if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
>  			cqspi->use_dma_read = true;
> +		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
> +			cqspi->wr_completion = false;
>  
>  		if (of_device_is_compatible(pdev->dev.of_node,
>  					    "xlnx,versal-ospi-1.0"))
> @@ -1859,6 +1869,10 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
>  	.quirks = CQSPI_DISABLE_DAC_MODE,
>  };
>  
> +static const struct cqspi_driver_platdata socfpga_qspi = {
> +	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
> +};
> +
>  static const struct cqspi_driver_platdata versal_ospi = {
>  	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
>  	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA,
> @@ -1887,6 +1901,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>  		.compatible = "xlnx,versal-ospi-1.0",
>  		.data = (void *)&versal_ospi,
>  	},
> +	{
> +		.compatible = "intel,socfpga-qspi",
> +		.data = (void *)&socfpga_qspi,
> +	},
>  	{ /* end of table */ }
>  };
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
