Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2586BE658
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 11:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCQKQI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQKQH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 06:16:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C8729A
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 03:16:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so18289142edb.9
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679048164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NY8YHqPz986MFS0KqAfWpnYQvF7v5lAfpebf9mJmBI=;
        b=CyyXr17SNy5D9rdc8blvoWO86BCsJ7YyjoZlLVwoR21bN/TUjk/J3D1OFbsXOGgCLj
         4GhVoTfp/PeHbI8JJMtjTsx9iAEx32kxzIX7FJvGLQEy2AO5+rk9jkD373ttH8ToSe7K
         48rhU7kP7MG1wLqT5+S94xAzh9rBw82OSeQB+N+hQvgb7H5LtLACswTrYvleU+urEgIi
         /i33p/nl04N2PpcIbktAV5auvVa2GQCMPnzyoBljLk8V/pddMp/7c45Ir6DChx8CSzjs
         sr3rmJhKfKBSihHBBRoFaCdkwjhD5IeD5vnm3a5bqLo0y8UYw4ulWWvewOSXbD/cQTgh
         8WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679048164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NY8YHqPz986MFS0KqAfWpnYQvF7v5lAfpebf9mJmBI=;
        b=0jRrBZ7liEJ55JC2zgGq3wYM33JcazmjFbc+RK8/ljlCtMcrhCziiCjHrWRneOf5cO
         SO08qet/VlAE1if9lnoZF9FTi1V+vMbQJ3AWr5l3Gl4GGQhXcx0qr7pii0s4yj5dYBXU
         pDsVdedHudqb5Q3+VFQiXouKkil39TXGFRVgx6ORKbKxUydGEM5A+OJmDbkf/tTTbd/L
         /zrZQuGm2SKlYENFICtXsLe0LYlDVA9i578g6hiwzabE+ozrKlcjQAsKYfZBzOqVEgaO
         MfBzXnJsr9y/ZAvbn5Cepb83BigVnzFe+lKtMmqI0XpHN8hAvktHGyhsJaEHcwK49mwH
         iyQg==
X-Gm-Message-State: AO0yUKXkQGo2vo8o0zvKa2Utw07jBwiT2ZcJA2RfTWzewb2623IXefCx
        +182LqngkaM0HAsT5s5cR4LCGw==
X-Google-Smtp-Source: AK7set/fYDrwJV6ncCwxMgdVPIYbPXMsvtCuzOOFpfy7SCFsQ2x14CfDTm4WEfck/CIMso8C1RqI3w==
X-Received: by 2002:a17:906:4ed2:b0:931:baf:259 with SMTP id i18-20020a1709064ed200b009310baf0259mr4669388ejv.63.1679048164643;
        Fri, 17 Mar 2023 03:16:04 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906924500b0092be625d981sm802177ejx.91.2023.03.17.03.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 03:16:04 -0700 (PDT)
Message-ID: <3b47ed4d-e8e2-5743-3e2b-1d2e1336fa82@linaro.org>
Date:   Fri, 17 Mar 2023 10:16:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] spi: atmel-quadspi: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
 <20230317084232.142257-4-u.kleine-koenig@pengutronix.de>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230317084232.142257-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/17/23 08:42, Uwe Kleine-König wrote:
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
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/spi/atmel-quadspi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 713a4d6700fd..3d1252566134 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -700,7 +700,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int atmel_qspi_remove(struct platform_device *pdev)
> +static void atmel_qspi_remove(struct platform_device *pdev)
>  {
>  	struct spi_controller *ctrl = platform_get_drvdata(pdev);
>  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
> @@ -727,8 +727,6 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> -
> -	return 0;
>  }
>  
>  static int __maybe_unused atmel_qspi_suspend(struct device *dev)
> @@ -837,7 +835,7 @@ static struct platform_driver atmel_qspi_driver = {
>  		.pm	= pm_ptr(&atmel_qspi_pm_ops),
>  	},
>  	.probe		= atmel_qspi_probe,
> -	.remove		= atmel_qspi_remove,
> +	.remove_new	= atmel_qspi_remove,
>  };
>  module_platform_driver(atmel_qspi_driver);
>  
