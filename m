Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7A109FA9
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKZNzf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:55:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfKZNzf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:55:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQDtQCo038496;
        Tue, 26 Nov 2019 07:55:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574776526;
        bh=9FV2sAVgknfN3arcofI7VcstThGCGrOn8LgD3FMXUUY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J5OU5FHtEiEldWF/yYKmORz95Jxr978D7pvt5ooqHG0r3gjRmRoq1Cd6T8GeWjuSN
         W5B5lZkf+yBti6XwK0ex2XPBiejKP5UfMXbNZXo1UU2RXYQa/BraYTQEyi60UtrIVX
         e89KqkZD1flHleHSyesiThNaG5NoYCY6aEJI3bRk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQDtQRx043203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 07:55:26 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 07:55:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 07:55:26 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQDtO0m066088;
        Tue, 26 Nov 2019 07:55:25 -0600
Subject: Re: [PATCH] spi: pic32: Add a comment in pic32_spi_dma_prep()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20191126135025.mligekonmv2u6dcl@kili.mountain>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <67ddc7f2-c67e-708b-0932-af425db04604@ti.com>
Date:   Tue, 26 Nov 2019 15:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126135025.mligekonmv2u6dcl@kili.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dan,

On 26/11/2019 15.50, Dan Carpenter wrote:
> This code triggers a static checker warning about missed error codes.
> It's slightly tricky that we fall back to PIO so let's silence the
> checker and add a comment for anyone who is confused.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I won't feel offended at all if people don't think it's worth applying
> this patch.
> 
>  drivers/spi/spi-pic32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> index 156961b4ca86..835380ab8bf2 100644
> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -633,8 +633,10 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>  		goto out_err;
>  	}
>  
> -	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
> +	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE)) {
> +		ret = 0;  /* Fall back to PIO if DMA fails. */

The 'ret' is initialized to 0 in the function to handle this.
After looking at the code again I see that pic32_spi_dma_config() does
error prints for failures.

A comment might be enough here if it is even needed.

>  		goto out_err;
> +	}
>  
>  	/* DMA chnls allocated and prepared */
>  	set_bit(PIC32F_DMA_PREP, &pic32s->flags);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
