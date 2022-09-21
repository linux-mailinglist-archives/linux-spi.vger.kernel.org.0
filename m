Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91795BF81D
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIUHrK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 03:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIUHrJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 03:47:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491175CE0;
        Wed, 21 Sep 2022 00:47:08 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXVn538dmzHpl9;
        Wed, 21 Sep 2022 15:44:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 15:46:34 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 15:46:33 +0800
Subject: Re: [PATCH] spi: omap2-mcspi: Fix probe so driver works again
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <Yyq8Q/kd301wVzg8@kili>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <06f57122-f173-1d80-0854-26f21cd90a83@huawei.com>
Date:   Wed, 21 Sep 2022 15:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yyq8Q/kd301wVzg8@kili>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dan,

On 2022/9/21 15:24, Dan Carpenter wrote:
> This condition was accidentally changed from "if (status < 0)" to
> "if (status)".  The platform_get_irq() function returns non-zero
> positive values on success so, unfortunately, the driver could not be
> used.  Change the condition back to how it was.
>
> Fixes: f4ca8c88c2c7 ("spi: omap2-mcspi: Switch to use dev_err_probe() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Sorry, if you recieve this twice.  There is a bug in the msmtp program
> so the first email I send every day is lost and I think this was my
> first email.  Resending.
>
>   drivers/spi/spi-omap2-mcspi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 80e79f3aa0c4..6ba9b0d7710b 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1509,7 +1509,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>   	}
>   
>   	status = platform_get_irq(pdev, 0);
> -	if (status) {
> +	if (status < 0) {
>   		dev_err_probe(&pdev->dev, status, "no irq resource found\n");
>   		goto free_master;
>   	}

Good catch !

I made a mistake in my patch, thanks for fixing this.

Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>

