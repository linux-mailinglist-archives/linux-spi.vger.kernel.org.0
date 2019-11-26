Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C77109F50
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKZNdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:33:38 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37772 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKZNdh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:33:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQDXXAN062927;
        Tue, 26 Nov 2019 07:33:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574775213;
        bh=DRsfZZ6XxQvqf/xSgtMmnHMX+745vZT7+ND48cUNXMk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vNjH5q2DbLqsff8qsEDKy15E+CVMtFU/gV5jj6UOBxkp+Nci+8ed5acrM4HF4RxA9
         CS+TqdDgsIi+yBORzaCTY19XIkpg+Z80lXI+erZtudA134gIIVw1YRMAUrI8Jrexqn
         r3FBwWN3UJ+ZW+BgBldUyTsCJGBuLyPjfc8UPVCE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQDXXIr007781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 07:33:33 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 07:33:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 07:33:32 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQDXUsT025115;
        Tue, 26 Nov 2019 07:33:31 -0600
Subject: Re: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <75428132-6ff4-b4c4-466d-6cc0e12f4250@ti.com>
Date:   Tue, 26 Nov 2019 15:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 26/11/2019 14.23, Dan Carpenter wrote:
> We accidentally return success on this error path.
> 
> Fixes: eb7e6dc6d9ff ("spi: pic32: Retire dma_request_slave_channel_compat()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/spi/spi-pic32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> index 156961b4ca86..93fb95073522 100644
> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -633,7 +633,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>  		goto out_err;
>  	}
>  
> -	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
> +	ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	if (ret)
>  		goto out_err;

I have intentionally left it like this to fall back to PIO mode in case
of an error as the original implementation did.

With commit eb7e6dc6d9ff the driver _only_ handles the -EPROBE_DEFER, in
all other cases it falls back to PIO mode.

>  
>  	/* DMA chnls allocated and prepared */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
