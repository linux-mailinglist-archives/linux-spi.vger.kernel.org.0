Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5047B15A4CB
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2020 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgBLJa4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Feb 2020 04:30:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:30171 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgBLJa4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 12 Feb 2020 04:30:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 01:30:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="233735616"
Received: from mylly.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 12 Feb 2020 01:30:52 -0800
Subject: Re:
To:     Rajat Jain <rajatja@google.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>, rajatxjain@gmail.com,
        evgreen@google.com, shobhit.srivastava@intel.com,
        porselvan.muthukrishnan@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200211223400.107604-1-rajatja@google.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <b3397374-0cb8-cf6c-0555-34541a1c108c@linux.intel.com>
Date:   Wed, 12 Feb 2020 11:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211223400.107604-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

+ Andy

On 2/12/20 12:34 AM, Rajat Jain wrote:
> From: Evan Green <evgreen@chromium.org>
> 
> Date: Wed, 29 Jan 2020 13:54:16 -0800
> Subject: [PATCH] spi: pxa2xx: Add CS control clock quirk
> 
This patch subject is missing from mail subject.

> In some circumstances on Intel LPSS controllers, toggling the LPSS
> CS control register doesn't actually cause the CS line to toggle.
> This seems to be failure of dynamic clock gating that occurs after
> going through a suspend/resume transition, where the controller
> is sent through a reset transition. This ruins SPI transactions
> that either rely on delay_usecs, or toggle the CS line without
> sending data.
> 
> Whenever CS is toggled, momentarily set the clock gating register
> to "Force On" to poke the controller into acting on CS.
> 
Could you share the test case how to trigger this? What's the platform 
here? I'd like to check does this reproduce on other Intel LPSS 
platforms so is there need to add quirk for them too.

> Signed-off-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>   drivers/spi/spi-pxa2xx.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 4c7a71f0fb3e..2e318158fca9 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -70,6 +70,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
>   #define LPSS_CAPS_CS_EN_SHIFT			9
>   #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
>   
> +#define LPSS_PRIV_CLOCK_GATE 0x38
> +#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK 0x3
> +#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON 0x3
> +
>   struct lpss_config {
>   	/* LPSS offset from drv_data->ioaddr */
>   	unsigned offset;
> @@ -86,6 +90,8 @@ struct lpss_config {
>   	unsigned cs_sel_shift;
>   	unsigned cs_sel_mask;
>   	unsigned cs_num;
> +	/* Quirks */
> +	unsigned cs_clk_stays_gated : 1;
>   };
>   
>   /* Keep these sorted with enum pxa_ssp_type */
> @@ -156,6 +162,7 @@ static const struct lpss_config lpss_platforms[] = {
>   		.tx_threshold_hi = 56,
>   		.cs_sel_shift = 8,
>   		.cs_sel_mask = 3 << 8,
> +		.cs_clk_stays_gated = true,
>   	},
>   };
>   
> @@ -383,6 +390,22 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
>   	else
>   		value |= LPSS_CS_CONTROL_CS_HIGH;
>   	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
> +	if (config->cs_clk_stays_gated) {
> +		u32 clkgate;
> +
> +		/*
> +		 * Changing CS alone when dynamic clock gating is on won't
> +		 * actually flip CS at that time. This ruins SPI transfers
> +		 * that specify delays, or have no data. Toggle the clock mode
> +		 * to force on briefly to poke the CS pin to move.
> +		 */
> +		clkgate = __lpss_ssp_read_priv(drv_data, LPSS_PRIV_CLOCK_GATE);
> +		value = (clkgate & ~LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK) |
> +			LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON;
> +
> +		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, value);
> +		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, clkgate);
> +	}
>   }
>   
I wonder is it enough to have this quick toggling only or is time or 
actually number of clock cycles dependent? Now there is no delay between 
but I'm thinking if it needs certain number cycles does this still work 
when using low ssp_clk rates similar than in commit d0283eb2dbc1 ("spi: 
pxa2xx: Add output control for multiple Intel LPSS chip selects").

I'm thinking can this be done only once after resume and may other LPSS 
blocks need the same? I.e. should this be done in drivers/mfd/intel-lpss.c?

Jarkko
