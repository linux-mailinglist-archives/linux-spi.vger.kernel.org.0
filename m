Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AACD109F74
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfKZNqL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:46:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40970 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfKZNqL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:46:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAQDk34O017666;
        Tue, 26 Nov 2019 07:46:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574775963;
        bh=tcGmR7FHquGuH+UhJBePSCyxqDDGpowYiZOU/+I+P3k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rX7ZHa0diEtitAlGJVmperSVl8L0LW2rceDvOtdrQiMgvPSsAFJDMT5tiPQWECW6P
         NopsGT0rBQKiuLpizTXagFQlrnmrp/eCCsHA4NhWJMewE9/1ddi3YO95hL40uz7NCR
         p3PNmeBKcjr16DDeh5xNfff1veWrpH0XicEhh/X0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQDk3JP031103;
        Tue, 26 Nov 2019 07:46:03 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 07:46:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 07:46:02 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAQDk1dJ019464;
        Tue, 26 Nov 2019 07:46:01 -0600
Subject: Re: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
 <CAMuHMdX52phf_dSQh3vK8QGJtvmUwDiY_0f6d7xAJ_xF2vKNfg@mail.gmail.com>
 <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
 <CAMuHMdWrvi9gv1QNwqhQV8cxgK9ecGnaC5LRxvLba5uUJLedrA@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c71a7703-7a30-b79f-43bb-a1448c298c69@ti.com>
Date:   Tue, 26 Nov 2019 15:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWrvi9gv1QNwqhQV8cxgK9ecGnaC5LRxvLba5uUJLedrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geet,

On 26/11/2019 15.38, Geert Uytterhoeven wrote:
> Hi Péter,
> 
> On Tue, Nov 26, 2019 at 2:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 26/11/2019 15.27, Geert Uytterhoeven wrote:
>>> On Tue, Nov 26, 2019 at 1:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>> We accidentally return success on this error path.
>>>>
>>>> Fixes: eb7e6dc6d9ff ("spi: pic32: Retire dma_request_slave_channel_compat()")
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> ---
>>>>  drivers/spi/spi-pic32.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
>>>> index 156961b4ca86..93fb95073522 100644
>>>> --- a/drivers/spi/spi-pic32.c
>>>> +++ b/drivers/spi/spi-pic32.c
>>>> @@ -633,7 +633,8 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
>>>>                 goto out_err;
>>>>         }
>>>>
>>>> -       if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
>>>> +       ret = pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE);
>>>> +       if (ret)
>>>>                 goto out_err;
>>>
>>> This used to be non-fatal, as DMA was optional, cfr. the comment:
>>>
>>>         /* optional DMA support */
>>>         ret = pic32_spi_dma_prep(pic32s, &pdev->dev);
>>>         if (ret)
>>>                 goto err_bailout;
>>>
>>> However, as of the aforementioned commit, DMA is no longer optional,
>>> and probe will fail instead of falling back to PIO on DMA init failure...
>>
>> It is still optional. It only handles deferred probing. If the DMA
>> request fails then it returns 0 and the driver falls back to PIO.
> 
> Oops, I missed that ret is only set to a non-zero value in case of
> probe deferral.
> 
> Sorry for that, seen too many broken patches today ;-)

You made me double check the patch to make sure I'm not contributing to
the broken patch count ;)

>> And this is why I have not changed the pic32_spi_dma_config() error
>> handling.
> 
> Right. So Dan's patch is wrong, as it makes this a hard failure, preventing
> fallback to PIO.

It is unlikely that it would fail, but probably it worth considering to
add a warning in case it happens.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
