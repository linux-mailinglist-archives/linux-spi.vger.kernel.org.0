Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3834E738
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhC3MMJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:12:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15106 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhC3MLv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:11:51 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8pCr3fWkz19JsV;
        Tue, 30 Mar 2021 20:09:44 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:11:39 +0800
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
To:     Fabio Estevam <festevam@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        linux-spi <linux-spi@vger.kernel.org>
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk>
 <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
 <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <bc792674-dca3-8fd7-dc55-3fceb1de4524@huawei.com>
Date:   Tue, 30 Mar 2021 20:11:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/3/30 19:56, Fabio Estevam 写道:
> On Mon, Mar 29, 2021 at 9:54 PM tiantao (H) <tiantao6@huawei.com> wrote:
>
>> Even with of_match_device, there is still a type conversion，as follows
>>
>> spi_data = (struct davinci_spi_of_data *)match->data;
>>
>> Using of_device_get_match_data instead of of_match_device doesn't look
>> like a problem from the code, other spi drivers do the same thing
> What about doing it like this?
thanks.

 From what I have tested, the results are ok. I will send v2 to fix.

make modules M=drivers/spi/
   CC [M]  drivers/spi//spi-davinci.o
drivers/spi//spi-davinci.c: In function ‘spi_davinci_get_pdata’:
drivers/spi//spi-davinci.c:826:11: warning: assignment discards ‘const’ 
qualifier from pointer target type [-Wdiscarded-qualifiers]
   826 |  spi_data = of_device_get_match_data(&pdev->dev);
       |           ^
   MODPOST drivers/spi//Module.symvers

   LD [M]  drivers/spi//spi-davinci.ko

  vim drivers/spi//spi-davinci.c
make modules M=drivers/spi/
   CC [M]  drivers/spi//spi-davinci.o
   MODPOST drivers/spi//Module.symvers
   LD [M]  drivers/spi//spi-davinci.ko
>
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -817,18 +817,13 @@ static int spi_davinci_get_pdata(struct
> platform_device *pdev,
>                          struct davinci_spi *dspi)
>   {
>          struct device_node *node = pdev->dev.of_node;
> -       struct davinci_spi_of_data *spi_data;
> +       const struct davinci_spi_of_data *spi_data;
>          struct davinci_spi_platform_data *pdata;
>          unsigned int num_cs, intr_line = 0;
> -       const struct of_device_id *match;
>
>          pdata = &dspi->pdata;
>
> -       match = of_match_device(davinci_spi_of_match, &pdev->dev);
> -       if (!match)
> -               return -ENODEV;
> -
> -       spi_data = (struct davinci_spi_of_data *)match->data;
> +       spi_data = device_get_match_data(&pdev->dev);
>
>          pdata->version = spi_data->version;
>          pdata->prescaler_limit = spi_data->prescaler_limit;
> .
>

