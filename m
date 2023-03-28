Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE416CC5B1
	for <lists+linux-spi@lfdr.de>; Tue, 28 Mar 2023 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjC1PQe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Mar 2023 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjC1PQP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Mar 2023 11:16:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47325113DC
        for <linux-spi@vger.kernel.org>; Tue, 28 Mar 2023 08:15:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1048962wmo.0
        for <linux-spi@vger.kernel.org>; Tue, 28 Mar 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680016493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiMcWrRifwEUskuyIQFulIGS7kWqc1dpRYsMeE3Bnt8=;
        b=lkLswlCp30qWwFIoG0VhbwpbY4a6zCPS1qSMwqwqeiFFRzUZmaUPXzqNBgLn9KbnZA
         EjRMoSidmm0G1ZqXLco7qoaIeAGtEqy9CzCmGT113ZV9pZlOZXo3Q4EQCvl5QeTp1+07
         kEIka5g6iNZos2U6DbuOOzeSxbQ/cJ+Ymvhn4t6dwcq9C/hnxbYylLgrMYJp0a4BoA9y
         E8vCYfeNd7p3wsnJmXtnAPbXhT/qlhRza6jRb6elaW6Yp0GEpqkFB2A/bwALWysQ5g6S
         Q6c0Hr9njtIXFUbe4cyCN9r+vmJFm9YuhFp7Q/rjIsMdNApQtZJ3QRPehh/ts8+0ft+2
         zzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiMcWrRifwEUskuyIQFulIGS7kWqc1dpRYsMeE3Bnt8=;
        b=QieItx+lcICnUlejndrsof+65EZZQYZaaAn3PW9+yk6KQpQ7dKi1N9bBUqqhsaX0Rk
         bwWWA7+O3a2Dh5Xx+8ry7u+KU0AxtljvC8AZr2T2KnP8guXOMqbjBD0qNrIrb7ko+FMx
         Ym9wXOJq5a4F40mPA3lZ5zzyNAF/2tw8qY8nzcFwCSUg8pufHKDMWkmB56dh/xZP/qoz
         rGm4BBj7zLbK5PF6oFvPfJXA0k3kjR8Ti4SrLrgeAe17X7McLHET0ahIKm9F48teu880
         R+3GcDBg6gdG8hIl3r4FF0HSARQh7OkdcYXO7Ryt0OoohiSaRoJu01Kms8A7wZtW1AKH
         IDdQ==
X-Gm-Message-State: AO0yUKUHhY3vhqgwcD1wuwgBUJAi+hqJjYahQd8eZ6hlVZfv6MnUCA/Z
        fMtN/4j499MJ945aMqFhLlNgetN4oNcOKqulD/Dfyw==
X-Google-Smtp-Source: AK7set95wY5EE0YNtfyvHTheORBSmDzHYguznEV+XEbkUnM0uVPMSwFMBcmsjKdakudAhAOmOYBvCQ==
X-Received: by 2002:a7b:ce08:0:b0:3da:1f6a:7b36 with SMTP id m8-20020a7bce08000000b003da1f6a7b36mr12456491wmc.0.1680016493494;
        Tue, 28 Mar 2023 08:14:53 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003ef62deb830sm11354391wml.25.2023.03.28.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:14:53 -0700 (PDT)
Message-ID: <48f1ee32-a030-8188-3a9d-612888b9678f@linaro.org>
Date:   Tue, 28 Mar 2023 16:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] spi: rockchip-sfc: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328062118.86336-1-yang.lee@linux.alibaba.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230328062118.86336-1-yang.lee@linux.alibaba.com>
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



On 3/28/23 07:21, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/spi/spi-rockchip-sfc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

If I were you I would make a single patch addressing all the drivers
from SPI as this is a single logical change. You get extra points as you
avoid polluting the log.

> 
> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
> index 4fabd2e0439f..6830ecaa270b 100644
> --- a/drivers/spi/spi-rockchip-sfc.c
> +++ b/drivers/spi/spi-rockchip-sfc.c
> @@ -576,8 +576,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
>  	sfc = spi_master_get_devdata(master);
>  	sfc->dev = dev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sfc->regbase = devm_ioremap_resource(dev, res);
> +	sfc->regbase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);

No, you better use devm_platform_ioremap_resource() as res is not used
afterwards. You'll get rid of the local variable too.

>  	if (IS_ERR(sfc->regbase))
>  		return PTR_ERR(sfc->regbase);
>  
