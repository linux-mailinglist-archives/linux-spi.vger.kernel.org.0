Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BAE295642
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 04:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507572AbgJVCHq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 22:07:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:7489 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507025AbgJVCHq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Oct 2020 22:07:46 -0400
IronPort-SDR: w7uap/fTX9ws2o1FQLZJt7oNmz1XWyrym1R4uaaGnELTR36HWA3Nkm4r19qGbN6CJFS+ItHySK
 HlmAI4REuJMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="167557880"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="167557880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 19:07:42 -0700
IronPort-SDR: AhmB8mT2CfwnXoz8BMLs52OwWNUXqx66zq865hXXlcPIQ7iZTFxXJxoHMG/QnOwh2DPBW9J4S5
 O68MyADpNCcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="348554873"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2020 19:07:42 -0700
Received: from [10.226.38.26] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.26])
        by linux.intel.com (Postfix) with ESMTP id 057725804BB;
        Wed, 21 Oct 2020 19:07:38 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 3/6] spi: cadence-quadspi: Add multi-chipselect support
 for Intel LGM SoC
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-4-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021151329.t24cli4rnk6esttm@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <6c26b5ce-6a48-ec4a-6427-f2bf0da33ef7@linux.intel.com>
Date:   Thu, 22 Oct 2020 10:07:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201021151329.t24cli4rnk6esttm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

On 21/10/2020 11:13 pm, Pratyush Yadav wrote:
> Hi,
> 
> On 21/10/20 10:55AM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add multiple chipselect support for Intel LGM SoCs,
>> currently QSPI-NOR and QSPI-NAND supported.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 3d017b484114..3bf6d3697631 100644
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
>> @@ -1070,6 +1072,14 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
>>   		return -ENXIO;
>>   	}
>>   
>> +	if (!cqspi->use_direct_mode) {
> 
> Shouldn't this be guarded by CQSPI_SUPPORTS_MULTI_CHIPSELECT instead of
> cqspi->use_direct_mode?
Yes, we can use CQSPI_SUPPORTS_MULTI_CHIPSELECT instead of 
cqspi->use_direct_mode
> 
> Also, cqspi->use_direct_mode would always be false here because
> cqspi_of_get_pdata() is called before we set it...
Good catch, thanks!

Regards
Vadivel
> 
>> +		if (of_property_read_u32(np, "num-chipselect",
>> +					 &cqspi->num_chipselect)) {
>> +			dev_err(dev, "couldn't determine number of cs\n");
>> +			return -ENXIO;
> 
> ... so even if someone doesn't want to use multiple chip selects they
> would have to specify this property or the probe will fail, which is the
> case on J721E EVM for example.
> 
>> +		}
>> +	}
>> +
>>   	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
>>   
>>   	return 0;
>> @@ -1307,6 +1317,9 @@ static int cqspi_probe(struct platform_device *pdev)
>>   	cqspi->current_cs = -1;
>>   	cqspi->sclk = 0;
>>   
>> +	if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT)
>> +		master->num_chipselect = cqspi->num_chipselect;
>> +
>>   	ret = cqspi_setup_flash(cqspi);
>>   	if (ret) {
>>   		dev_err(dev, "failed to setup flash parameters %d\n", ret);
>> @@ -1396,6 +1409,7 @@ static const struct cqspi_driver_platdata am654_ospi = {
>>   };
>>   
>>   static const struct cqspi_driver_platdata intel_lgm_qspi = {
>> +	.hwcaps_mask = CQSPI_SUPPORTS_MULTI_CHIPSELECT,
>>   	.quirks = CQSPI_DISABLE_DAC_MODE,
>>   };
>>   
>> -- 
>> 2.11.0
>>
> 
