Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79645116A5B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 10:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIJ7a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 04:59:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54768 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJ7a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 04:59:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99xPom093424;
        Mon, 9 Dec 2019 03:59:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575885565;
        bh=CSBSig8vjO8cxClf/2rRLSow9AcW4rCfkiivSJtNLEU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wtRlDfX4KBqjXQKni3npFkCev+2QOMCnkEC80DcJNkbQrIso8wb0lMrm1XWYIYadf
         YZ0vjJfIkjW8p0jELQKb50CpgkOHCC83Q9m6+O490WVC9JFo6ez7mqRaJmXPMwbdTu
         gYUGhGZ7FzwQB/0HB99uLHT+KZ1DGSYAtKfqXfSo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99xPjd063974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:59:25 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:59:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:59:25 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99xMTs113365;
        Mon, 9 Dec 2019 03:59:23 -0600
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
To:     Jean Pihet <jean.pihet@newoldbits.com>,
        Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <451986b2-e4f2-8bb6-fea1-65328b855223@ti.com>
Date:   Mon, 9 Dec 2019 15:29:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206160007.331801-2-jean.pihet@newoldbits.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 06/12/19 9:30 pm, Jean Pihet wrote:
> The QSPI IP is clocked by two clocks:
> - CORE_CLKOUTM4 / 2 (L3) as interface clock,
> - PER_CLKOUTM2 / 4 (L4) as functional clock, which is PER_CLKOUTM2
>   divided by 4, so at 192Mhz / 4 = 48MHz.
> 
> Fix the use of the correct fclk by the driver and fix the frequency
> value so that the divider is correctly programmed to generate the
> desired frequency of QSPI_CLK.
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

This macro is unused and should be dropped.

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
> 

-- 
Regards
Vignesh
