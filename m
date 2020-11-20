Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BD22B9F54
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 01:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgKTAaJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 19:30:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:53116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgKTAaJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 19:30:09 -0500
IronPort-SDR: gxMf7sLixPASL8l/4f8KqsR7PEl2/4uUOkRr6gLpBz71SV3ObsnjiH5xZp/qjmEiF0vHNYVqr9
 Zr3kZuTcxErA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235536802"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235536802"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 16:30:08 -0800
IronPort-SDR: RMQWgMWYdT3LeRaF+AA5gw40c5DR1S77RVuHeW0wP13RKdHWx+sSFJh0s97bH3gqpNcEb/SOs7
 Xf51d2XKhnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="369040577"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2020 16:30:08 -0800
Received: from [10.213.153.3] (vramuthx-MOBL1.gar.corp.intel.com [10.213.153.3])
        by linux.intel.com (Postfix) with ESMTP id 3B85F580409;
        Thu, 19 Nov 2020 16:29:53 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v8 3/6] spi: cadence-quadspi: Add multi-chipselect support
 for Intel LGM SoC
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201119055551.26493-4-vadivel.muruganx.ramuthevar@linux.intel.com>
 <9fc328cc-1f4d-1896-6dde-a107d76e14cb@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <4d0f82a8-f87d-ba75-336f-564d89083732@linux.intel.com>
Date:   Fri, 20 Nov 2020 08:29:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <9fc328cc-1f4d-1896-6dde-a107d76e14cb@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vignesh,

Thank you very much for the review comments...

On 19/11/2020 8:57 pm, Vignesh Raghavendra wrote:
> 
> 
> On 11/19/20 11:25 AM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add multiple chipselect support for Intel LGM SoCs,
>> currently QSPI-NOR and QSPI-NAND supported.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index d12b765e87be..337778f75d5d 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -38,6 +38,7 @@
>>   
>>   /* Capabilities */
>>   #define CQSPI_SUPPORTS_OCTAL		BIT(0)
>> +#define CQSPI_SUPPORTS_MULTI_CHIPSELECT BIT(1)
>>   
>>   struct cqspi_st;
>>   
>> @@ -75,6 +76,7 @@ struct cqspi_st {
>>   	bool			is_decoded_cs;
>>   	u32			fifo_depth;
>>   	u32			fifo_width;
>> +	u32			num_chipselect;
>>   	bool			rclk_en;
>>   	u32			trigger_address;
>>   	u32			wr_delay;
>> @@ -1049,6 +1051,7 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>>   
>>   static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>>   {
>> +	const struct cqspi_driver_platdata *ddata;
> 
> Unused variable?
currently used for this check
if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT) {

next patch will drop it, because the above check to be removed.
> 
>>   	struct device *dev = &cqspi->pdev->dev;
>>   	struct device_node *np = dev->of_node;
>>   
>> @@ -1070,6 +1073,14 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>>   		return -ENXIO;
>>   	}
>>   
>> +	ddata  = of_device_get_match_data(dev);
>> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT) {
> 
> I don't see a need for this flag... Controller by default supports
> multiple CS.
Ok.
> 
>> +		if (of_property_read_u32(np, "num-cs", &cqspi->num_chipselect)) {
>> +			dev_err(dev, "couldn't determine number of cs\n");
>> +			return -ENXIO;
>> +		}
>> +	}
>> +
> 
> 
> Entire hunk can be replaced with:
> 
>          if (of_property_read_u32(np, "num-cs", &cqspi->num_chipselect))
> 		cqspi->num_chipselect = CQSPI_MAX_CHIPSELECT;
Noted, thanks!
> 
> 
>>   	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
>>   
>>   	return 0;
>> @@ -1302,6 +1313,9 @@ static int cqspi_probe(struct platform_device *pdev)
>>   	cqspi->current_cs = -1;
>>   	cqspi->sclk = 0;
>>   
>> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
>> +		master->num_chipselect = cqspi->num_chipselect;
>> +
> 
> And then this becomes:
> 	master->num_chipselect = cqspi->num_chipselect;
Ok, Noted.
> 
>>   	ret = cqspi_setup_flash(cqspi);
>>   	if (ret) {
>>   		dev_err(dev, "failed to setup flash parameters %d\n", ret);
>> @@ -1391,6 +1405,7 @@ static const struct cqspi_driver_platdata am654_ospi = {
>>   };
>>   
>>   static const struct cqspi_driver_platdata intel_lgm_qspi = {
>> +	.hwcaps_mask = CQSPI_SUPPORTS_MULTI_CHIPSELECT,
>>   	.quirks = CQSPI_DISABLE_DAC_MODE,
>>   };
>>   
>>
