Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A601294FA3
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444104AbgJUPNx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 11:13:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35062 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443906AbgJUPNx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Oct 2020 11:13:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09LFDVs8113882;
        Wed, 21 Oct 2020 10:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603293211;
        bh=3wSeAduo54FZJAeg21M6ZmUHKkp0796GqW6JPL5m2s8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aIktxFzxQ69nNQVzokofgflbN7y2X1rCHTocosMVZmGXQgsfRkd4cOcJ24/KOHJpj
         zvlJXJQHsNoXjh6lQC9XYiNmr/jVupeotNVmULAphUfG5dwV2uE6uLm0Bo4HVZ7Cuw
         CjGOES18Me0eyqjy3cqPTxSkMr9TrFLokBT1RiZM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09LFDVbV089314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 10:13:31 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 21
 Oct 2020 10:13:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 21 Oct 2020 10:13:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09LFDU9o122395;
        Wed, 21 Oct 2020 10:13:30 -0500
Date:   Wed, 21 Oct 2020 20:43:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     <vigneshr@ti.com>, <tudor.ambarus@microchip.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <simon.k.r.goldschmidt@gmail.com>, <dinguyen@kernel.org>,
        <richard@nod.at>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
Subject: Re: [PATCH v2 3/6] spi: cadence-quadspi: Add multi-chipselect
 support for Intel LGM SoC
Message-ID: <20201021151329.t24cli4rnk6esttm@ti.com>
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-4-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201021025507.51001-4-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 21/10/20 10:55AM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add multiple chipselect support for Intel LGM SoCs,
> currently QSPI-NOR and QSPI-NAND supported.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 3d017b484114..3bf6d3697631 100644
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
> @@ -1070,6 +1072,14 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>  		return -ENXIO;
>  	}
>  
> +	if (!cqspi->use_direct_mode) {

Shouldn't this be guarded by CQSPI_SUPPORTS_MULTI_CHIPSELECT instead of 
cqspi->use_direct_mode?

Also, cqspi->use_direct_mode would always be false here because 
cqspi_of_get_pdata() is called before we set it...

> +		if (of_property_read_u32(np, "num-chipselect",
> +					 &cqspi->num_chipselect)) {
> +			dev_err(dev, "couldn't determine number of cs\n");
> +			return -ENXIO;

... so even if someone doesn't want to use multiple chip selects they 
would have to specify this property or the probe will fail, which is the 
case on J721E EVM for example.

> +		}
> +	}
> +
>  	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
>  
>  	return 0;
> @@ -1307,6 +1317,9 @@ static int cqspi_probe(struct platform_device *pdev)
>  	cqspi->current_cs = -1;
>  	cqspi->sclk = 0;
>  
> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
> +		master->num_chipselect = cqspi->num_chipselect;
> +
>  	ret = cqspi_setup_flash(cqspi);
>  	if (ret) {
>  		dev_err(dev, "failed to setup flash parameters %d\n", ret);
> @@ -1396,6 +1409,7 @@ static const struct cqspi_driver_platdata am654_ospi = {
>  };
>  
>  static const struct cqspi_driver_platdata intel_lgm_qspi = {
> +	.hwcaps_mask = CQSPI_SUPPORTS_MULTI_CHIPSELECT,
>  	.quirks = CQSPI_DISABLE_DAC_MODE,
>  };
>  
> -- 
> 2.11.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
