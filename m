Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279A52B92F5
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 14:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKSM5W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 07:57:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39736 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKSM5T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 07:57:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJCvD9f062375;
        Thu, 19 Nov 2020 06:57:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605790633;
        bh=xiRtA5FYZ6iAiUYGUphkNw2hMyqBTr+KLMd36v13y7Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MQ7px4nOSErv2I9cBLM6Ga1RHWEY3S2VPhjwv43HkmF5GGYVH1OUfWzhCHoCImxE1
         cdmxDSgY3bMH7uiOrIup5BZ4M/u8/udRZ10oZwtD/0JxHLNMWBMGuAjNzCs9p4kHuL
         9JZ2wSFbRkIqgE7xd/vtmUuTuVxWRkeEOsTQCfWE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJCvDjE054676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 06:57:13 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 06:57:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 06:57:12 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJCv9G6120288;
        Thu, 19 Nov 2020 06:57:10 -0600
Subject: Re: [PATCH v8 3/6] spi: cadence-quadspi: Add multi-chipselect support
 for Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <p.yadav@ti.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201119055551.26493-4-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9fc328cc-1f4d-1896-6dde-a107d76e14cb@ti.com>
Date:   Thu, 19 Nov 2020 18:27:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119055551.26493-4-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 11/19/20 11:25 AM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add multiple chipselect support for Intel LGM SoCs,
> currently QSPI-NOR and QSPI-NAND supported.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index d12b765e87be..337778f75d5d 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -38,6 +38,7 @@
>  
>  /* Capabilities */
>  #define CQSPI_SUPPORTS_OCTAL		BIT(0)
> +#define CQSPI_SUPPORTS_MULTI_CHIPSELECT BIT(1)
>  
>  struct cqspi_st;
>  
> @@ -75,6 +76,7 @@ struct cqspi_st {
>  	bool			is_decoded_cs;
>  	u32			fifo_depth;
>  	u32			fifo_width;
> +	u32			num_chipselect;
>  	bool			rclk_en;
>  	u32			trigger_address;
>  	u32			wr_delay;
> @@ -1049,6 +1051,7 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>  
>  static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>  {
> +	const struct cqspi_driver_platdata *ddata;

Unused variable?

>  	struct device *dev = &cqspi->pdev->dev;
>  	struct device_node *np = dev->of_node;
>  
> @@ -1070,6 +1073,14 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>  		return -ENXIO;
>  	}
>  
> +	ddata  = of_device_get_match_data(dev);
> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT) {

I don't see a need for this flag... Controller by default supports
multiple CS.

> +		if (of_property_read_u32(np, "num-cs", &cqspi->num_chipselect)) {
> +			dev_err(dev, "couldn't determine number of cs\n");
> +			return -ENXIO;
> +		}
> +	}
> +


Entire hunk can be replaced with:

        if (of_property_read_u32(np, "num-cs", &cqspi->num_chipselect))
		cqspi->num_chipselect = CQSPI_MAX_CHIPSELECT;


>  	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
>  
>  	return 0;
> @@ -1302,6 +1313,9 @@ static int cqspi_probe(struct platform_device *pdev)
>  	cqspi->current_cs = -1;
>  	cqspi->sclk = 0;
>  
> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
> +		master->num_chipselect = cqspi->num_chipselect;
> +

And then this becomes:
	master->num_chipselect = cqspi->num_chipselect;

>  	ret = cqspi_setup_flash(cqspi);
>  	if (ret) {
>  		dev_err(dev, "failed to setup flash parameters %d\n", ret);
> @@ -1391,6 +1405,7 @@ static const struct cqspi_driver_platdata am654_ospi = {
>  };
>  
>  static const struct cqspi_driver_platdata intel_lgm_qspi = {
> +	.hwcaps_mask = CQSPI_SUPPORTS_MULTI_CHIPSELECT,
>  	.quirks = CQSPI_DISABLE_DAC_MODE,
>  };
>  
> 
