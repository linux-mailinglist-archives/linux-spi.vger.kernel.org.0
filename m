Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC95109F4C
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKZNcL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:32:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37660 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfKZNcL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:32:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQDVuHh062670;
        Tue, 26 Nov 2019 07:31:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574775116;
        bh=aB8dMS4glO2iKv+TYQUqIobZIxXGw0yJP8pe0O1E38I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MqW/n0BssIUO1P+gSPw23sgh2yF+jGG+6o8pJyqbQflYyDlOMY4SURGT6WEAmb1TQ
         gicWVWNC/IcQeT/NqjBZoD8ZRV8I6Phk21lLLF/PVeHN0RJNviohnk7rrbVdnddsRK
         pvR0J6Sqziz+weq8enGUaaJDAWubB9MIU/YTV0jg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAQDVuAc005096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 07:31:56 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 07:31:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 07:31:56 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQDVskL022175;
        Tue, 26 Nov 2019 07:31:55 -0600
Subject: Re: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
 <CAMuHMdX52phf_dSQh3vK8QGJtvmUwDiY_0f6d7xAJ_xF2vKNfg@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
Date:   Tue, 26 Nov 2019 15:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX52phf_dSQh3vK8QGJtvmUwDiY_0f6d7xAJ_xF2vKNfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 26/11/2019 15.27, Geert Uytterhoeven wrote:
> Hi Dan,
> 
> On Tue, Nov 26, 2019 at 1:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> We accidentally return success on this error path.
>>
>> Fixes: eb7e6dc6d9ff ("spi: pic32: Retire dma_request_slave_channel_compat()")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/spi/spi-pic32.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
>> index 156961b4ca86..93fb95073522 100644
>> --- a/drivers/spi/spi-pic32.c
>> +++ b/drivers/spi/spi-pic32.c
>> @@ -633,7 +633,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>>                 goto out_err;
>>         }
>>
>> -       if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
>> +       ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
>> +       if (ret)
>>                 goto out_err;
> 
> This used to be non-fatal, as DMA was optional, cfr. the comment:
> 
>         /* optional DMA support */
>         ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
>         if (ret)
>                 goto err_bailout;
> 
> However, as of the aforementioned commit, DMA is no longer optional,
> and probe will fail instead of falling back to PIO on DMA init failure...

It is still optional. It only handles deferred probing. If the DMA
request fails then it returns 0 and the driver falls back to PIO.

And this is why I have not changed the pic32_spi_dma_config() error
handling.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
