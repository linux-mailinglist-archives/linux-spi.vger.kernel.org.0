Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33BA2A6068
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgKDJSt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 04:18:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:27735 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgKDJSt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Nov 2020 04:18:49 -0500
IronPort-SDR: WoXpQJ/c4O1pQpzBB9+xcxJuT4iS4emhfkHiYY+TNRgWD2EFuG4PZHemLCvOowTJLvYwtgkSxm
 5/I0rzexX5og==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="230815503"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="230815503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 01:18:48 -0800
IronPort-SDR: Qg5NkxJR6Sb2VvuMKumPTpwpKQLAjz/5LF7HgXr00lSx63Czw9RqGNHrtCdlG0jtgfoRkHqQYm
 InIj1Lr7+WXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="396837779"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2020 01:18:48 -0800
Received: from [10.226.38.22] (vramuthx-MOBL1.gar.corp.intel.com [10.226.38.22])
        by linux.intel.com (Postfix) with ESMTP id 5E88C580342;
        Wed,  4 Nov 2020 01:18:45 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v6 2/6] spi: cadence-quadspi: Disable the DAC for Intel
 LGM SoC
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201103160834.mfbasmmlgsptnl5l@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <7551da02-06c6-92d7-3a2b-0199fa026cf7@linux.intel.com>
Date:   Wed, 4 Nov 2020 17:18:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103160834.mfbasmmlgsptnl5l@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

Thank you for the review comments...

On 4/11/2020 12:09 am, Pratyush Yadav wrote:
> On 30/10/20 01:31PM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> On Intel Lightning Mountain(LGM) SoCs QSPI controller do not use
>> Direct Access Controller(DAC).
>>
>> This patch adds a quirk to disable the Direct Access Controller
>> for data transfer instead it uses indirect data transfer.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index d7b10c46fa70..6d6f7c440ece 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -1107,6 +1107,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>>   	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>>   
>>   	cqspi_controller_enable(cqspi, 1);
>> +
>> +	/* Disable direct access controller */
>> +	if (!cqspi->use_direct_mode) {
>> +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>> +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>> +	}
> 
> You did not address my comment here from last time around [0]. Please
> replace this hunk with the one below and test it. Also mention in the
> commit message that the DAC bit resets to 1 so there is no need to
> explicitly set it.
Really sorry for that, I will add the below patch as you have suggested 
and test & confirm , thanks!
> 
> --- 8< ---
> diff --git a/drivers/spi/spi-cadence-quadspi.c
> b/drivers/spi/spi-cadence-quadspi.c
> index d7ad8b198a11..d2c5d448a944 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -2156,10 +2156,12 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>   	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
>   	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
>   
> -	/* Enable Direct Access Controller */
> -	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> -	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> -	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> +	/* Disable Direct Access Controller */
> +	if (!cqspi->use_dac_mode) {
> +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> +	}
>   
>   	cqspi_controller_enable(cqspi, 1);
>   }
> --- >8 ---
> 
> Same disclaimer as last time: not tested at all.
> 
> [0] https://lore.kernel.org/linux-spi/20201022090146.2uj5gfx73dsfumjl@ti.com/
> 
> PS: Please Cc me in the next revision. I missed 3 revisions in between
> because I'm not subscribed to this list. Otherwise I would have sent
> this much sooner :-)
Sure, I will add you in cc, btw last 3 revisions I did only Rob's review 
comments update w.r.t dt_schema.

Regards
Vadivel
> 
>>   }
>>   
>>   static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>> @@ -1388,6 +1395,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
>>   	.quirks = CQSPI_NEEDS_WR_DELAY,
>>   };
>>   
>> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
>> +	.quirks = CQSPI_DISABLE_DAC_MODE,
>> +};
>> +
>>   static const struct of_device_id cqspi_dt_ids[] = {
>>   	{
>>   		.compatible = "cdns,qspi-nor",
>> @@ -1403,6 +1414,7 @@ static const struct of_device_id cqspi_dt_ids[] = {
>>   	},
>>   	{
>>   		.compatible = "intel,lgm-qspi",
>> +		.data = &intel_lgm_qspi,
>>   	},
>>   	{ /* end of table */ }
>>   };
>> -- 
>> 2.11.0
>>
> 
