Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D666C29564D
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 04:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894952AbgJVCRy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 22:17:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:19105 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442800AbgJVCRy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Oct 2020 22:17:54 -0400
IronPort-SDR: 2nh844w4xAPv0UGpuE/QtdD5jJGa75IVU/FS7RgrWvg/oNpMAOOBlH8GfCQkHlQO1i21Q+SHYk
 fUCQMbT3+c8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="231651826"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="231651826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 19:17:51 -0700
IronPort-SDR: K+dzbx3ct3rrSAH7iPiqTS2LpzfE5HCLFq/NOrDOBJOlf5XZsaO2nQLbzF2mgf/48Vl1hNG5+9
 BYz368NaWP/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="316570789"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2020 19:17:51 -0700
Received: from [10.226.38.26] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.26])
        by linux.intel.com (Postfix) with ESMTP id 4A01F5804BB;
        Wed, 21 Oct 2020 19:17:48 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 2/6] spi: cadence-quadspi: Disable the DAC for Intel
 LGM SoC
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021140015.3ldwk4az5nlzhnvr@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <a36fbe94-0cf2-eb42-3000-be4c055802b6@linux.intel.com>
Date:   Thu, 22 Oct 2020 10:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201021140015.3ldwk4az5nlzhnvr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

On 21/10/2020 11:17 pm, Pratyush Yadav wrote:
> Hi,
> 
> On 21/10/20 10:55AM, Ramuthevar,Vadivel MuruganX wrote:
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
>> index d7b10c46fa70..3d017b484114 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -1106,6 +1106,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>>   	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>>   	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>>   
>> +	/* Disable direct access controller */
>> +	if (!cqspi->use_direct_mode) {
>> +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>> +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>> +	}
>> +
> 
> Do you really need to disable the DAC controller? cqspi_read() and
> cqspi_write() already check for cqspi->use_direct_mode and avoid using
> direct mode if it is false. While I don't think it would do any harm I'm
> curious what prompted you to do this instead of just setting the quirk
> like cdns_qspi does.
> 
> Anyway, if you do insist on doing it, it does not make any sense to set
> a bit and then unset it immediately after. The datasheet I have says
> this bit resets to 1 so the block above the code you added should be
> removed.
Thank you for your review comments..
yes, we need this patch to disable DAC for our SoC to avoid any 
conflicts in future as well since Intel LGM SoC doesn't support DAC at all.

Regards
Vadivel
> 
>>   	cqspi_controller_enable(cqspi, 1);
>>   }
>>   
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
> 
