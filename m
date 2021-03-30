Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E279B34E7CC
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhC3MsE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:48:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14965 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhC3MsB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:48:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8q1b4fnPzyN48;
        Tue, 30 Mar 2021 20:45:55 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:47:50 +0800
Subject: Re: [PATCH v2] spi: davinci: Use of_device_get_match_data() helper
To:     Fabio Estevam <festevam@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <1617107474-46079-1-git-send-email-tiantao6@hisilicon.com>
 <CAOMZO5A8r8LuV_GOvi3=rdABFgWuC3ho=h2B4FwWB_Y-WCXUTg@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <37cc380a-4df3-44b9-9d93-903a80617f77@huawei.com>
Date:   Tue, 30 Mar 2021 20:47:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5A8r8LuV_GOvi3=rdABFgWuC3ho=h2B4FwWB_Y-WCXUTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/3/30 20:36, Fabio Estevam 写道:
> On Tue, Mar 30, 2021 at 9:30 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
>> -       match = of_match_device(davinci_spi_of_match, &pdev->dev);
>> -       if (!match)
>> +       spi_data = of_device_get_match_data(&pdev->dev);
>> +       if (!spi_data)
> No need to check against NULL here because all compatible strings
> provide .data and DT is the only mechanism to probe.
>
> Also, this could be device_get_match_data().
> .

What about doing it like this?

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c

index 7453a1d..e114e6fe 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -817,18 +817,13 @@ static int spi_davinci_get_pdata(struct 
platform_device *pdev,
                         struct davinci_spi *dspi)
  {
         struct device_node *node = pdev->dev.of_node;
-       struct davinci_spi_of_data *spi_data;
+       const struct davinci_spi_of_data *spi_data;
         struct davinci_spi_platform_data *pdata;
         unsigned int num_cs, intr_line = 0;
-       const struct of_device_id *match;

         pdata = &dspi->pdata;

-       match = of_match_device(davinci_spi_of_match, &pdev->dev);
-       if (!match)
-               return -ENODEV;
-
-       spi_data = (struct davinci_spi_of_data *)match->data;
+       spi_data = device_get_match_data(&pdev->dev);

         pdata->version = spi_data->version;
         pdata->prescaler_limit = spi_data->prescaler_limit;


