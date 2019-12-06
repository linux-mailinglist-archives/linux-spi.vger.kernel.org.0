Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE8115515
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLFQYf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 11:24:35 -0500
Received: from muru.com ([72.249.23.125]:44240 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLFQYf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:35 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 379BD8047;
        Fri,  6 Dec 2019 16:25:13 +0000 (UTC)
Date:   Fri, 6 Dec 2019 08:24:31 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
Message-ID: <20191206162431.GF35479@atomide.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206160007.331801-2-jean.pihet@newoldbits.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jean,

* Jean Pihet <jean.pihet@newoldbits.com> [191206 16:01]:
> The QSPI IP is clocked by two clocks:
> - CORE_CLKOUTM4 / 2 (L3) as interface clock,
> - PER_CLKOUTM2 / 4 (L4) as functional clock, which is PER_CLKOUTM2
>   divided by 4, so at 192Mhz / 4 = 48MHz.
> 
> Fix the use of the correct fclk by the driver and fix the frequency
> value so that the divider is correctly programmed to generate the
> desired frequency of QSPI_CLK.

This source clock can be different between the SoC models, the
related fck probably needs to be fixed in the SoC specific dtsi
file.

Currently qspi it's there only in dra7.dtsi, sounds like you
are using it on am3/am4 based on the clock name?

Regards,

Tony

> ---
>  drivers/spi/spi-ti-qspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 3cb65371ae3b..4680dad38ab2 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -79,7 +79,7 @@ struct ti_qspi {
>  
>  #define QSPI_COMPLETION_TIMEOUT		msecs_to_jiffies(2000)
>  
> -#define QSPI_FCLK			192000000
> +#define QSPI_FCLK			48000000
>  
>  /* Clock Control */
>  #define QSPI_CLK_EN			(1 << 31)
> @@ -748,7 +748,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
> +	qspi->fclk = devm_clk_get(&pdev->dev, "dpll_per_m2_div4_ck");
>  	if (IS_ERR(qspi->fclk)) {
>  		ret = PTR_ERR(qspi->fclk);
>  		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
> -- 
> 2.23.0
> 
