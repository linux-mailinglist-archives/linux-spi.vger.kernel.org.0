Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CE42A3EBB
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 09:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCISG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 03:18:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7039 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgKCISG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 03:18:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQN2K2pzVzhfb3;
        Tue,  3 Nov 2020 16:18:01 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 16:18:01 +0800
Subject: Re: [PATCH v2] spi: mt7621: fix missing clk_disable_unprepare() on
 error in mt7621_spi_probe
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201103074912.195576-1-miaoqinglang@huawei.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <18289705-1025-2851-d24c-91a8da4910e1@huawei.com>
Date:   Tue, 3 Nov 2020 16:18:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201103074912.195576-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



ÔÚ 2020/11/3 15:49, Qinglang Miao Ð´µÀ:
> Fix the missing clk_disable_unprepare() before return
> from mt7621_spi_probe in the error handling case.
> 
> Fixes: cbd66c626e16 ("spi: mt7621: Move SPI driver out of staging")
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   drivers/spi/spi-mt7621.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
> index 2c3b7a2a1..2cdae7994 100644
> --- a/drivers/spi/spi-mt7621.c
> +++ b/drivers/spi/spi-mt7621.c
> @@ -353,6 +353,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	master = spi_alloc_master(&pdev->dev, sizeof(*rs));
>   	if (!master) {
>   		dev_info(&pdev->dev, "master allocation failed\n");
> +		clk_disable_unprepare(clk);
>   		return -ENOMEM;
>   	}
>   
> @@ -377,6 +378,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
>   	ret = device_reset(&pdev->dev);
>   	if (ret) {
>   		dev_err(&pdev->dev, "SPI reset failed!\n");
> +		clk_disable_unprepare(clk);
>   		return ret;
>   	}
>   
> 
Hi Mark and Matthias,

I made a careless mistake for adding v2 as subject-prefix, this patch is 
the base version actually.

Sorry about that.

Thanks.
