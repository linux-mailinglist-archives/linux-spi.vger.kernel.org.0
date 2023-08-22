Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CD784257
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjHVNtB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHVNtA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:49:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264118B
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:48:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so72108841fa.2
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692712137; x=1693316937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNjqlZSCnM+mXT6XhXZc25PujLvyxaAxxA/29D6t0s4=;
        b=r3O0lTrs/KF6oORMGhJW5zWh1M/62kCIBSY5Z6aAefdvq5klJwZfIsn1qaOMh+1Vj/
         GZQ0PGKIc2afwD1FYgzJitUuUEEtc1TYQAbEqMwWsV7ky+RwewBra9WlPN8+1ZGts7tG
         I5OHkCWg3b9yKseq2IMq3s0J+U6ZWHZq9NZlfYyvO9pwesPQV1SI1GK5WSVfhcGVyUmB
         R7pVhbxwCCSjahJmpLKdc5nkniYYw/QYLodxF6GscBzgvmk1racMwEDvLZuHeFphpT28
         VNknmCBjlYwcVryQX2bR05VtM3LiDKeYhz6nt51g3MTZ9kKexziuiO5fO+8VVmmwp00h
         sJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712137; x=1693316937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNjqlZSCnM+mXT6XhXZc25PujLvyxaAxxA/29D6t0s4=;
        b=jknEF8dolQc2tyL/0Si+COMjsGgFbbpANZ2ogLpc7Vblqja+5g/pmc2ECA9ILlYTjK
         hJjLZVmpwRlS4c1QUJtWfhg0Yy6MzBXCFjuTLznVK8KzAxGCFsHvHua9OX24+O7JhnxP
         S5UxDqTmkDq3jZ4Gjmrnzlw5S6vZMRP44VJMc+I73Jaf+0q+x2ki1I5v9hiBii2x0WqK
         AUm5mzi1ko8nI/Bo70kUCtx1u71DmUHEzJotfMF5bLWkfUS3R6gMcvRxkVOSz5D7ZHny
         Unozitav5KXVNTITCBZhvjzrOZrju8MkJI+l92Vh9tSNGcgpFHmmrEnO2xcS7wU0zGgo
         E2Tg==
X-Gm-Message-State: AOJu0Ywzg69cTWTfSc9n4wyTfmPUlJnEJYJVtMKtPWStuajYKFFkGxeJ
        CGCiDJ6pYpf7qC+DzPUPlpQ=
X-Google-Smtp-Source: AGHT+IFihF3LNptCC53uVWoB/jzGuMUDG0z8kyH5P7DgnkKOe5f0uDFLvmrkswwLW8XSS39t+jRvkg==
X-Received: by 2002:a2e:8091:0:b0:2b9:55c9:c228 with SMTP id i17-20020a2e8091000000b002b955c9c228mr6800491ljg.27.1692712136740;
        Tue, 22 Aug 2023 06:48:56 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z16-20020a2e8410000000b002b9cd2d0d39sm2740953ljg.28.2023.08.22.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:48:56 -0700 (PDT)
Date:   Tue, 22 Aug 2023 16:48:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     broonie@kernel.org, chin-ting_kuo@aspeedtech.com, clg@kaod.org,
        joel@jms.id.au, andrew@aj.id.au, florian.fainelli@broadcom.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, olteanv@gmail.com,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, heiko@sntech.de,
        linux-spi@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH -next 11/25] spi: dw-bt1: Use helper function
 devm_clk_get_enabled()
Message-ID: <i2bjbilyzg22xas2zpuumnsb4rolv2tkb4vhx2kyryizf2775b@764f3gk56ttn>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230822131237.1022815-12-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822131237.1022815-12-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 22, 2023 at 09:12:23PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

LGTM. Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/spi/spi-dw-bt1.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index 5e1c01822967..5391bcac305c 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -269,43 +269,32 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
>  
>  	dws->paddr = mem->start;
>  
> -	dwsbt1->clk = devm_clk_get(&pdev->dev, NULL);
> +	dwsbt1->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dwsbt1->clk))
>  		return PTR_ERR(dwsbt1->clk);
>  
> -	ret = clk_prepare_enable(dwsbt1->clk);
> -	if (ret)
> -		return ret;
> -
>  	dws->bus_num = pdev->id;
>  	dws->reg_io_width = 4;
>  	dws->max_freq = clk_get_rate(dwsbt1->clk);
> -	if (!dws->max_freq) {
> -		ret = -EINVAL;
> -		goto err_disable_clk;
> -	}
> +	if (!dws->max_freq)
> +		return -EINVAL;
>  
>  	init_func = device_get_match_data(&pdev->dev);
>  	ret = init_func(pdev, dwsbt1);
>  	if (ret)
> -		goto err_disable_clk;
> +		return ret;
>  
>  	pm_runtime_enable(&pdev->dev);
>  
>  	ret = dw_spi_add_host(&pdev->dev, dws);
>  	if (ret) {
>  		pm_runtime_disable(&pdev->dev);
> -		goto err_disable_clk;
> +		return ret;
>  	}
>  
>  	platform_set_drvdata(pdev, dwsbt1);
>  
>  	return 0;
> -
> -err_disable_clk:
> -	clk_disable_unprepare(dwsbt1->clk);
> -
> -	return ret;
>  }
>  
>  static void dw_spi_bt1_remove(struct platform_device *pdev)
> @@ -315,8 +304,6 @@ static void dw_spi_bt1_remove(struct platform_device *pdev)
>  	dw_spi_remove_host(&dwsbt1->dws);
>  
>  	pm_runtime_disable(&pdev->dev);
> -
> -	clk_disable_unprepare(dwsbt1->clk);
>  }
>  
>  static const struct of_device_id dw_spi_bt1_of_match[] = {
> -- 
> 2.34.1
> 
