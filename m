Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5856AC4B6
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCFPXB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 10:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCFPW7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 10:22:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019A526E
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 07:22:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s20so13193425lfb.11
        for <linux-spi@vger.kernel.org>; Mon, 06 Mar 2023 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bw6fMGXZuAwOCff0YkItqzVo6z8j3Qf85Wm3dxbs5HY=;
        b=VvqFcduTFSKly59/XmSq7jpBdxJ3XfFxaC7IKmoGmrtMAEM0DrUBqPZjrnReNJ7i2u
         pzkZIaApaCj6P9kRCOfnQXAlK9MvEG5aGSyu5C7DnvlsESmkW63l4ayymFZByHseUlhc
         9WgV/SJycgsoZnoEmbcwGxJiVrG/YFTey/f4+esE9hyREeB3GZunPabjbznsCNLOImqS
         771APPmajBwcTewEzu5ceocEgdILPJWs+qI98SlMIfc485H9l5dwwAciHVdMBuUODyd+
         UU9O+rb1BKzQuu6cLoCHBKYmxwlqBDrflfjj4FxCcNSBBUBB5JYW9P/TkryYDb0hyvtT
         9Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bw6fMGXZuAwOCff0YkItqzVo6z8j3Qf85Wm3dxbs5HY=;
        b=jDz5oWzJ3MUn7XhgtfTvBt4VSt+zlcsFn1HSFWs+JrTRPo71piqsm8viTDsYX7+EJI
         KWxaQFgbUO+Ej2kOVRYIkhteFBGZkF8HYQ9X1igdnO7eGi9yRBqw1DmdAaRKb6axgCAz
         1/SP9SNhxPlU2j7psHfskxNGDMgmJegf8I35smyxg5P5Jf1Nw0p5BzS0iLQmUAAFdjPy
         3SPrUtkQEYkCQ4DVKv3C+tbyNOUUoyTJaDgXJsINZVo7piobGinn90ABFGsYoC9UTa0P
         +ezBvRl8+Z7+evGRCXzDJG8tLwTMxM7T2JILiTN2LNGkyJB2g5ogdjjnU8tbcIY7GB05
         3Nag==
X-Gm-Message-State: AO0yUKXFCEtP9YgBLG235nlSipowX4UT21TwT4H1faGfDf24VqnaKoGX
        lrE45Pst6lPHUMOH2hEYkG7r1XtTmE4=
X-Google-Smtp-Source: AK7set+K5+Z5TpNmaGY3DSNtOF/Xc4jMYFGo1J22hPTOWpsRACCJGU0TpDbCzGwGbGesdRqU/avdxg==
X-Received: by 2002:a19:7405:0:b0:4e1:7d1c:85ce with SMTP id v5-20020a197405000000b004e17d1c85cemr2807107lfe.27.1678116176675;
        Mon, 06 Mar 2023 07:22:56 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id l8-20020a19c208000000b004db3890cb53sm1688847lfc.223.2023.03.06.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:22:55 -0800 (PST)
Date:   Mon, 6 Mar 2023 18:22:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 21/87] spi: dw-bt1: Convert to platform remove callback
 returning void
Message-ID: <20230306152253.6a5yk6t2fbezv73w@mobilestation>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-22-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303172041.2103336-22-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 03, 2023 at 06:19:35PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/spi/spi-dw-bt1.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index 3fb89dee595e..5e1c01822967 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -308,7 +308,7 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int dw_spi_bt1_remove(struct platform_device *pdev)
> +static void dw_spi_bt1_remove(struct platform_device *pdev)
>  {
>  	struct dw_spi_bt1 *dwsbt1 = platform_get_drvdata(pdev);
>  
> @@ -317,8 +317,6 @@ static int dw_spi_bt1_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  
>  	clk_disable_unprepare(dwsbt1->clk);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id dw_spi_bt1_of_match[] = {
> @@ -330,7 +328,7 @@ MODULE_DEVICE_TABLE(of, dw_spi_bt1_of_match);
>  
>  static struct platform_driver dw_spi_bt1_driver = {
>  	.probe	= dw_spi_bt1_probe,
> -	.remove	= dw_spi_bt1_remove,
> +	.remove_new = dw_spi_bt1_remove,
>  	.driver	= {
>  		.name		= "bt1-sys-ssi",
>  		.of_match_table	= dw_spi_bt1_of_match,
> -- 
> 2.39.1
> 
