Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE042AB1BA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 08:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgKIHZr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 02:25:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60668 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHZr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 02:25:47 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A97Pik4044731;
        Mon, 9 Nov 2020 01:25:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604906744;
        bh=wPDzD3wdBhogJ2w34E4sOoZHnHl52AdJRen78Jv9Zv0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EIejFMtZYZfWDgDXcPgme5edtNCh51sq+nTmPv43wT96m7yWEPAlp8shNN7FFlaFi
         xSyyK29PgHS423vVtOQ1Iu9CWJ2sdDifdFVbNwkxOP1ixroKdz+6FQBn5mqzH3cZyX
         v0jc0jKi8b9IR9CfdItu+CFfJ0u5ges37xUew8Os=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A97Pi4L079312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 01:25:44 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 01:25:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 01:25:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A97Ph8Q112252;
        Mon, 9 Nov 2020 01:25:43 -0600
Subject: Re: [PATCH] spi: davinci: Fix use-after-free on unbind
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <40f3a2cf-be25-f4f3-6231-cbd5570b8a64@ti.com>
Date:   Mon, 9 Nov 2020 09:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukas,

On 09/11/2020 0.41, Lukas Wunner wrote:
> davinci_spi_remove() accesses the driver's private data after it's been
> freed with spi_master_put().
> 
> Fix by moving the spi_master_put() to the end of the function.

Thanks for spotting it,

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: fe5fd2540947 ("spi: davinci: Use dma_request_chan() for requesting DMA channel")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org> # v4.7+
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/spi/spi-davinci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 818f2b22875d..7453a1dbbc06 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -1040,13 +1040,13 @@ static int davinci_spi_remove(struct platform_device *pdev)
>  	spi_bitbang_stop(&dspi->bitbang);
>  
>  	clk_disable_unprepare(dspi->clk);
> -	spi_master_put(master);
>  
>  	if (dspi->dma_rx) {
>  		dma_release_channel(dspi->dma_rx);
>  		dma_release_channel(dspi->dma_tx);
>  	}
>  
> +	spi_master_put(master);
>  	return 0;
>  }
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
