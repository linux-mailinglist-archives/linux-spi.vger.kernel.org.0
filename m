Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449D1785AC8
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjHWOfq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHWOfq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 10:35:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F5E54
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 07:35:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50078eba7afso5994549e87.0
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692801340; x=1693406140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2TgiqCmPSnILANt5GZ18rswgB/K69rSR8VLR5YONDs=;
        b=RVzW2IYkj05E1QurcVWCK8Xr7hoWpAOpq6CNlM5mHjUNjLSfNyKWHfrrFTfD9jQ3sy
         eDWbgQ442RcyjicydLE6/q60tWpJdy6owEAJS82xvbIcbBMG5mL58fFkQ2ll1I6CDNZk
         sy57Jl1xt9HL9jEtz8CEZQj7WMl/hyN2A+zsuaCdZqYXcjp81CxeZbRcdAYxDsGZ/QXS
         kSenj8ixe68J2WE8rMsSlvpz33p80M3zhzSMOE/X5uDBSnWHA9seXSpGOUV4gvZnTFxZ
         Yv0Aegrg6xvVhrq6m+Gl4RABhOtV9dWhz9ongXNlT9GqtGbxTGyhdc9vo0S9nFxBcNYJ
         nYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801340; x=1693406140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2TgiqCmPSnILANt5GZ18rswgB/K69rSR8VLR5YONDs=;
        b=iIVZueoGN4vusDtveQedmTKRG+ThaX1Dd6ctCmmfBDKhVFZkOc/S7b5gY54qV65KWk
         sjgVm55OnMD0rXgKiugmEG3nB1iTuPPiN3FZzwHUUPStn5Vt2enAV+xKQhCOMci3PAN4
         mKR+huOEiB97GP+LLYx98khboSXuVBHXvUNjED/l3uoyDHGl/745gN1qmkTl5sAU2Nxe
         V0IYC+3WMQCIHCLQ94/bLOx6f0d2/NZxe5r72UO6kUjf018x21sR/5v6JHtF3iJJvUKK
         E2NXBWAv+PCyzUf3jNoWY7L8CvRwGwhDAUoiNv7GdIyc/foW70BXLIKcGY9VdzY8skph
         5Kgg==
X-Gm-Message-State: AOJu0YyhvWciW6edfaFCSeg437qR6DOQLEsl99MziItWPZ1PJj2yvPQ/
        p2dibd9zzl+e4sgA8c+ChJmSg/VjjZjGaQ==
X-Google-Smtp-Source: AGHT+IFj+DCY0sY2R0WBzy7d65Q9hoRnlsbk7tAiZi/tGbFHUyZQZNNjWy+pVOAk7a3V21jYp3uHGg==
X-Received: by 2002:ac2:5f6a:0:b0:4fd:d517:fbd8 with SMTP id c10-20020ac25f6a000000b004fdd517fbd8mr8210729lfc.9.1692801340064;
        Wed, 23 Aug 2023 07:35:40 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d11-20020ac244cb000000b005009b4d5c14sm59710lfm.265.2023.08.23.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:35:39 -0700 (PDT)
Date:   Wed, 23 Aug 2023 17:35:35 +0300
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
        yuenn@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH -next v2 11/25] spi: dw-bt1: Use helper function
 devm_clk_get_enabled()
Message-ID: <xxosi2ymo7otqyfbmjlubezzedqw6ulwwhdmbdjbto7yaqw673@q673weupq67y>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
 <20230823133938.1359106-12-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823133938.1359106-12-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 23, 2023 at 09:39:24PM +0800, Li Zetao wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it is
> no longer necessary to unprepare and disable the clocks explicitly.
> 

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Just for the record, the tags order is normally supposed to reflect a
patch route. Even though AFAICS it's explicitly defined for the Sob
tags only (see Documentation/process/submitting-patches.rst), but
almost all kernel developers apply that rule to all the tags. See the
kernel git log as the brightest example. So your Sob tag should have
been kept first, then either my Ab or Jonathan' Rb tags.

-Serge(y)

> ---
> v1 -> v2: None
> 
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
