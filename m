Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6E34E75E
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhC3MSH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 08:18:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15042 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhC3MRs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 08:17:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8pL22p13zPms3;
        Tue, 30 Mar 2021 20:15:06 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 20:17:34 +0800
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
To:     Fabio Estevam <festevam@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        linux-spi <linux-spi@vger.kernel.org>
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
 <20210329152157.GB5166@sirena.org.uk>
 <67027863-b52d-ad32-6e17-af5c1d284216@huawei.com>
 <CAOMZO5ArUtHLREuWqKxSrh-SzYtaduWg9gQZqTFjXj9uEkzn9g@mail.gmail.com>
 <bc792674-dca3-8fd7-dc55-3fceb1de4524@huawei.com>
 <CAOMZO5Ad5L-y9YTiOantOWow_CPaeGnNMjf8hM_-eH4ShMQS7A@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <5fe4177c-8e12-2b1a-163f-6619cf05cccb@huawei.com>
Date:   Tue, 30 Mar 2021 20:17:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5Ad5L-y9YTiOantOWow_CPaeGnNMjf8hM_-eH4ShMQS7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


在 2021/3/30 20:15, Fabio Estevam 写道:
> On Tue, Mar 30, 2021 at 9:12 AM tiantao (H) <tiantao6@huawei.com> wrote:
>
>>   From what I have tested, the results are ok. I will send v2 to fix.
>>
>> make modules M=drivers/spi/
>>     CC [M]  drivers/spi//spi-davinci.o
>> drivers/spi//spi-davinci.c: In function ‘spi_davinci_get_pdata’:
>> drivers/spi//spi-davinci.c:826:11: warning: assignment discards ‘const’
>> qualifier from pointer target type [-Wdiscarded-qualifiers]
>>     826 |  spi_data = of_device_get_match_data(&pdev->dev);
Yes, I added the const as you suggested and there is no more warning
> This warning does not appear if you apply the patch I suggested.
> .
>

