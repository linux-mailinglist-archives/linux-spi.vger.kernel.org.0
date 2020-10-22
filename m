Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D2295B7E
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509440AbgJVJOc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Oct 2020 05:14:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:34304 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508281AbgJVJOc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Oct 2020 05:14:32 -0400
IronPort-SDR: xC+LWgQ59J7DmlsKA1pICCKA18sKhpxbw97jXKckllOe8jJyKt2JVvXLqNiEuBQ1CjLDTRjJb/
 MWVfF0TMFnYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="164005336"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="164005336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 02:14:31 -0700
IronPort-SDR: oyD1QRGbc/YYHydWWAjFxpY9aEQYJ9mLI6yoH85k2vUgijv8/hC0Rq8wS7y3691eqlj923MXsR
 ST2/YjlWGCJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="423063617"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2020 02:14:31 -0700
Received: from [10.226.38.26] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.26])
        by linux.intel.com (Postfix) with ESMTP id 3773058080F;
        Thu, 22 Oct 2020 02:14:27 -0700 (PDT)
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
 <a36fbe94-0cf2-eb42-3000-be4c055802b6@linux.intel.com>
 <20201022090146.2uj5gfx73dsfumjl@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <7f3e4c9c-6d6d-eb02-d999-0758c1a3d638@linux.intel.com>
Date:   Thu, 22 Oct 2020 17:14:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022090146.2uj5gfx73dsfumjl@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 22/10/2020 5:01 pm, Pratyush Yadav wrote:
> On 22/10/20 10:17AM, Ramuthevar, Vadivel MuruganX wrote:
>> Hi Pratyush,
>>
>> On 21/10/2020 11:17 pm, Pratyush Yadav wrote:
>>> Hi,
>>>
>>> On 21/10/20 10:55AM, Ramuthevar,Vadivel MuruganX wrote:
>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>
>>>> On Intel Lightning Mountain(LGM) SoCs QSPI controller do not use
>>>> Direct Access Controller(DAC).
>>>>
>>>> This patch adds a quirk to disable the Direct Access Controller
>>>> for data transfer instead it uses indirect data transfer.
>>>>
>>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>> ---
>>>>    drivers/spi/spi-cadence-quadspi.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>>>> index d7b10c46fa70..3d017b484114 100644
>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>> @@ -1106,6 +1106,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>>>>    	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>>>>    	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>>>> +	/* Disable direct access controller */
>>>> +	if (!cqspi->use_direct_mode) {
>>>> +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>>>> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>>>> +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>>>> +	}
>>>> +
>>>
>>> Do you really need to disable the DAC controller? cqspi_read() and
>>> cqspi_write() already check for cqspi->use_direct_mode and avoid using
>>> direct mode if it is false. While I don't think it would do any harm I'm
>>> curious what prompted you to do this instead of just setting the quirk
>>> like cdns_qspi does.
>>>
>>> Anyway, if you do insist on doing it, it does not make any sense to set
>>> a bit and then unset it immediately after. The datasheet I have says
>>> this bit resets to 1 so the block above the code you added should be
>>> removed.
>> Thank you for your review comments..
>> yes, we need this patch to disable DAC for our SoC to avoid any conflicts in
>> future as well since Intel LGM SoC doesn't support DAC at all.
> 
> I'm not sure you got my point here.
Got your point, thanks!
  I understand that LGM SoCs don't
> support DAC. I'm not arguing if this _patch_ is needed. I'm arguing if
> this _hunk_ is needed.
Needed, my previous patches added DAC disabled in cqspi_read() and 
cqspi_write() function then Vignesh suggested me to move 
cqspi_controller_init() function part so I have add it now.

you are saying that add hunk at the end of cqspi_controller_init().
that's also okay for me, anyhow DAC should be disabled at any case.

Regards
Vadivel
  Does DAC mode need to be explicitly disabled
> here? Why will the check in cqspi_read() and cqspi_write() not be
> enough?
> 
> My other point is that if you absolutely need to disable DAC mode, then
> instead of the code you have added, it would make more sense to do
> something like below in cqspi_controller_init(). Because the bit resets
> to 1 so the block of code to enable it is useless [0].
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
> Disclaimer: not tested at all.
> 
> [0] Git blames Vignesh for that block of code added in a27f2eaf2b27.
> Vignesh, was this simply an oversight or was there any real reason to
> set the bit?
>   
>> Regards
>> Vadivel
>>>
>>>>    	cqspi_controller_enable(cqspi, 1);
>>>>    }
>>>> @@ -1388,6 +1395,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
>>>>    	.quirks = CQSPI_NEEDS_WR_DELAY,
>>>>    };
>>>> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
>>>> +	.quirks = CQSPI_DISABLE_DAC_MODE,
>>>> +};
>>>> +
>>>>    static const struct of_device_id cqspi_dt_ids[] = {
>>>>    	{
>>>>    		.compatible = "cdns,qspi-nor",
>>>> @@ -1403,6 +1414,7 @@ static const struct of_device_id cqspi_dt_ids[] = {
>>>>    	},
>>>>    	{
>>>>    		.compatible = "intel,lgm-qspi",
>>>> +		.data = &intel_lgm_qspi,
>>>>    	},
>>>>    	{ /* end of table */ }
>>>>    };
>>>
> 
