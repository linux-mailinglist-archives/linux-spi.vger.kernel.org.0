Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B490785A43
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 16:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjHWOUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHWOUV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 10:20:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D2E47
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 07:20:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50078eba7afso5966029e87.0
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692800417; x=1693405217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhfwjT4tlvrzpnKCjflm2Sl+ahwu3aFmaWxJvLIkO98=;
        b=VWsAu4zctYB4Hj/BaIyGIeHN/WvcmeJ/TP2QJwdpFBduBe0n2TqhZyfZtLBY5a19IU
         JJbacgfTX7UUbBIvmR5AM/98hrPGlJh5mNQjrhPJzkNuDJqRuLHpSXJpmGfSNMtSqoXQ
         tWNAHKYmpkPTfZuBWQsIMmFPP4gpVQm1jWNtcL/NCJ+KdhkAEV+3NHCXnyKFuQi4Jb9b
         G9PQEMPPEZeG9A/gduv2m7TC8UG4POhqqRy1ecmOu6wcIEUVChopMYhCWugbOa/IzEKL
         rHQs3bfRDGRKIHmpIdxO3aJ20/h0c2cNzM/nTl8hd/hBAfXmxyh5lYQcnAvvfcL8Hlle
         ZSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800417; x=1693405217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhfwjT4tlvrzpnKCjflm2Sl+ahwu3aFmaWxJvLIkO98=;
        b=PLNUzAGYpLDWRVyT8UbLhu6GHgr27hKHvz1+qeJgrw4PLDFYx3NksSa/OIIOGCd9Oe
         oxyOs0NQKspXXEKzTb2OQTShAaqkNxarKhj7+MnMWbJ2TUCVGs8POsc67Nfyi1gJai/5
         UC7cg/Gp8g6A+a5svpoUU0zfHrvHy/Hsqaxa+UQZWct55D0USzbiYHDdglZ2+my7XQpU
         t22v+P3znqdypgSR9AExJt0pltVFbQN/xmwReYw8Cp656ZN+r8EmUWxC/bW5IClg/YPc
         bM8KJ7QO4Wf/uQvsHHpX6pafahvamoYeAv8w/ukNdk16CVxCm0FE3dr8GbsThrfm4jyV
         3V+w==
X-Gm-Message-State: AOJu0YzNw2JItptcGih/mtEo3mzBAD5igCJUQyFMuB8948mn52fTwZ1R
        00DujWVc9LoL4nZWlYksc8Y=
X-Google-Smtp-Source: AGHT+IEGS4rOzzVhq/5nNxTOyLpTJO6FicNda11SZK9keATWBdGhEq2mwTZDRVciIV7jhQm6tMni+w==
X-Received: by 2002:a05:6512:312b:b0:4fd:c884:51fc with SMTP id p11-20020a056512312b00b004fdc88451fcmr8129845lfd.58.1692800416942;
        Wed, 23 Aug 2023 07:20:16 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w15-20020ac254af000000b004f85d80ca64sm1551281lfk.221.2023.08.23.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:20:16 -0700 (PDT)
Date:   Wed, 23 Aug 2023 17:20:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     andrew@aj.id.au, angelogioacchino.delregno@collabora.com,
        avifishman70@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        benjaminfair@google.com, broonie@kernel.org,
        chin-ting_kuo@aspeedtech.com, clg@kaod.org,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        florian.fainelli@broadcom.com, heiko@sntech.de,
        jbrunet@baylibre.com, joel@jms.id.au, khilman@baylibre.com,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        martin.blumenstingl@googlemail.com, matthias.bgg@gmail.com,
        neil.armstrong@linaro.org, olteanv@gmail.com,
        openbmc@lists.ozlabs.org, rjui@broadcom.com, sbranden@broadcom.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com
Subject: Re: [PATCH -next v2 12/25] spi: dw-mmio: Use helper function
 devm_clk_get_*()
Message-ID: <pflv2canelmm3ea7zpqgxrzj3s7cl56crpdbupkgqlabfnasjj@dkfyiubao2gj>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
 <20230823133938.1359106-13-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823133938.1359106-13-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 23, 2023 at 09:39:25PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly. Also,
> devm_clk_get_optional() and clk_prepare_enable() can now be replaced by
> devm_clk_get_optional_enabled(). Moreover, the lable "out_clk" no longer
> makes sense, rename it to "out_reset".
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> v1 -> v2: Return directly instead of calling reset_control_deassert()
> before the reset control handler has been requested. And use the
> "out_reset" label instead of "out" before calling pm_runtime_enable().

LGTM. Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
>  drivers/spi/spi-dw-mmio.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 805264c9c65c..46801189a651 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -340,29 +340,20 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	if (dws->irq < 0)
>  		return dws->irq; /* -ENXIO */
>  
> -	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
> +	dwsmmio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dwsmmio->clk))
>  		return PTR_ERR(dwsmmio->clk);
> -	ret = clk_prepare_enable(dwsmmio->clk);
> -	if (ret)
> -		return ret;
>  
>  	/* Optional clock needed to access the registers */
> -	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
> -	if (IS_ERR(dwsmmio->pclk)) {
> -		ret = PTR_ERR(dwsmmio->pclk);
> -		goto out_clk;
> -	}
> -	ret = clk_prepare_enable(dwsmmio->pclk);
> -	if (ret)
> -		goto out_clk;
> +	dwsmmio->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
> +	if (IS_ERR(dwsmmio->pclk))
> +		return PTR_ERR(dwsmmio->pclk);
>  
>  	/* find an optional reset controller */
>  	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
> -	if (IS_ERR(dwsmmio->rstc)) {
> -		ret = PTR_ERR(dwsmmio->rstc);
> -		goto out_clk;
> -	}
> +	if (IS_ERR(dwsmmio->rstc))
> +		return PTR_ERR(dwsmmio->rstc);
> +
>  	reset_control_deassert(dwsmmio->rstc);
>  
>  	dws->bus_num = pdev->id;
> @@ -383,7 +374,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	if (init_func) {
>  		ret = init_func(pdev, dwsmmio);
>  		if (ret)
> -			goto out;
> +			goto out_reset;
>  	}
>  
>  	pm_runtime_enable(&pdev->dev);
> @@ -397,9 +388,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  
>  out:
>  	pm_runtime_disable(&pdev->dev);
> -	clk_disable_unprepare(dwsmmio->pclk);
> -out_clk:
> -	clk_disable_unprepare(dwsmmio->clk);
> +out_reset:
>  	reset_control_assert(dwsmmio->rstc);
>  
>  	return ret;
> @@ -411,8 +400,6 @@ static void dw_spi_mmio_remove(struct platform_device *pdev)
>  
>  	dw_spi_remove_host(&dwsmmio->dws);
>  	pm_runtime_disable(&pdev->dev);
> -	clk_disable_unprepare(dwsmmio->pclk);
> -	clk_disable_unprepare(dwsmmio->clk);
>  	reset_control_assert(dwsmmio->rstc);
>  }
>  
> -- 
> 2.34.1
> 
