Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD36CD2E9
	for <lists+linux-spi@lfdr.de>; Wed, 29 Mar 2023 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC2HYd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Mar 2023 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjC2HYR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Mar 2023 03:24:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D93C1D
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 00:24:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p34so8271731wms.3
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680074652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJp2+W37XxsAR/L6gGNJ3ZD77wku21AF7kwE0n4c81Q=;
        b=lncXY2Fu/NQVZPrp9FfpHHADHD8T2yjdWoYJtL3Ksx8jTjZ0iUo93eI7kMYBGTfgZr
         nFDNmtdF4F9LQuvRC1KHbvi15E4RqpdDHUA5As/kMPWKu7WEKixGKfoE6RrdXKazfbya
         xPnzAiJghsYWQsWhYxpeLh/Qgz7wt55VpzbOouL/XtLLz3F0XCCTmKsOfM8u4L0PXYvW
         lpszWhw+ISvZmyDSyNMNbJWsNoIPWmmnW1IgwEpisNj5VRLsgMucSYw2bN0LmDk+SM8y
         /yUs37sLZwyhW/c1D5HhnbbLmHPAkUhGpDsU3BIvFi+bSW91hU33Qws/xuoemVuNcvIX
         W07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJp2+W37XxsAR/L6gGNJ3ZD77wku21AF7kwE0n4c81Q=;
        b=Cccqjdo/eDn5UjROt/W1Ay0Pyom8e8rBdFczPIXoXigATXHOG6CaXyAtmbJGFjScn9
         xGaoFqFfqxImYlOumpIdL6EU8vBfPPvGXElAUvLx3pF7/aPIvYMFZ/B9RD7xSkjzOk+n
         P0aDY07BR2eHGeHira1itbr/KKffT/QiYVTTk70A0NP4O4D5DvC7a3y/9/HPUiniw8P8
         Sf+ARhIR7SIJ0lwq8l+1WJvNSG1pWPdpK4NaXVpq/LyFmGMQhQobvT31DsiNw0x4PzO6
         jeLVdqf55qjELWGMff3d8eFky5GKL4lAhdpv/hjOFUxSJMhFHSDp/11IguhcMUpFWJ2U
         WFJg==
X-Gm-Message-State: AAQBX9d6YQtqasJw4WBbBIE97dFirIJO25dclk7Mk2ndrnDBGyC3x20Y
        tAfmpaSN75FxsPpHrIOW362Gf2FybuavkdLyOiPXMg==
X-Google-Smtp-Source: AKy350Y9eJHsBt9yYeOW4vaIiBR0qmrFdBShLK6Q0MVPxomqT1AP3as8a/i3/dZXLUVlLEdjMFOJtw==
X-Received: by 2002:a05:600c:244:b0:3ef:76dc:4b92 with SMTP id 4-20020a05600c024400b003ef76dc4b92mr3755411wmj.28.1680074652535;
        Wed, 29 Mar 2023 00:24:12 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id n18-20020a1c7212000000b003eafc47eb09sm1153882wmc.43.2023.03.29.00.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:24:12 -0700 (PDT)
Message-ID: <4df2d9a2-a2f3-e4a8-edfa-4efc441624c2@linaro.org>
Date:   Wed, 29 Mar 2023 08:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next v2] spi: rockchip-sfc: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230329062450.58924-1-yang.lee@linux.alibaba.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230329062450.58924-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/29/23 07:24, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I still prefer a single patch per subsystem, but Mark is going to decide:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> 
> change in v2:
> --According to Tudor's suggestion, use devm_platform_ioremap_resource() and
>   get rid of the local variable too.
> 
>  drivers/spi/spi-rockchip-sfc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
> index 4fabd2e0439f..b370aade11b4 100644
> --- a/drivers/spi/spi-rockchip-sfc.c
> +++ b/drivers/spi/spi-rockchip-sfc.c
> @@ -558,7 +558,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct spi_master *master;
> -	struct resource *res;
>  	struct rockchip_sfc *sfc;
>  	int ret;
>  
> @@ -576,8 +575,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
>  	sfc = spi_master_get_devdata(master);
>  	sfc->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sfc->regbase = devm_ioremap_resource(dev, res);
> +	sfc->regbase = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sfc->regbase))
>  		return PTR_ERR(sfc->regbase);
>  
