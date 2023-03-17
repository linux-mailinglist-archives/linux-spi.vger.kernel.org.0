Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1966BE657
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCQKPn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQKPm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 06:15:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF4729A
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 03:15:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd5so18299674edb.7
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679048139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMxlhsoI5OmZHNVTky0T9IOd+zYWSUNkZPFwUSkFUHE=;
        b=YFI5mGN9gbEouxLEkPhp7UPowdYsr4so5wSyvKNaWBZMmsfCd3ZZjz1w8PLkoHfi2N
         iyfx9/eJe1L1sIb5673Bn733ddJR1xKLXagAlGCJAYnu7KNu4x+9jP9Ibtl73Jd7xBHN
         7XVfliXTPQGq8CNQ7gERPCRoZvgvn2hKOaXa5nrJlpLRra8C6ryCu9ryQ7oCZJWbO125
         g2g/L8wm+JYaCU5wYKITIRIYpQXwXQx7+rHcAq67c1OKEsfQslC6uNYuzIG+aPib9ySb
         at+6goxkj8r7lUsEx2Hx/ZgYEnkrmTSeCgqNjtAWpqB2ve5qYfX15Z/GSbzv5RqnYID4
         PmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679048139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMxlhsoI5OmZHNVTky0T9IOd+zYWSUNkZPFwUSkFUHE=;
        b=1FkKhO7MpY6Xy9B0xqS5w/R+parraVHHYqXsIXk4itFNLGdbpIWQyYrRRGmc15/C/Y
         3S1rRpSQ49nTzIPADS0o1g6WQEDO11A0u3t2zjVkFCGPdeB57Zy5tugwqYaNEaRAaxL2
         soaJyNuj0s1mE/F6xAeoiglOOU6pzCEg8oWe2suqHI/5cKdReP81UfEfHr0vjNlAzKEk
         DE+OyY+zBG9zwYWsnLrpv3wqLwn1VSBMUwMZ+EAJnyAAOaiI9+EDqb7soBTsFYsLyBTb
         Ti4a0wYUlpZWtuDmQbs6Vsio/anWog4EOl8FbjyHLHYrvGRNfmCxyszIsSSP1tlv2o7u
         RMGA==
X-Gm-Message-State: AO0yUKXlqpNilh8L2OUpwbkKL3Tivjk8G9sV6ext6Uwq7CAGO1l2bgr6
        yK4VP81Csr1JnlgNeLnAkLX2hQ==
X-Google-Smtp-Source: AK7set/O17zKvyR1K4t2de3oBV2V31uvnI+j0UMcmTfSlcpTL/UKhjvafqUaJw++aRjxsJVN8IV0eQ==
X-Received: by 2002:a17:906:5792:b0:922:7b95:416a with SMTP id k18-20020a170906579200b009227b95416amr12801771ejq.36.1679048139569;
        Fri, 17 Mar 2023 03:15:39 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm803857ejc.29.2023.03.17.03.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 03:15:39 -0700 (PDT)
Message-ID: <fd404d26-55a5-7bae-e773-ea4739995ce4@linaro.org>
Date:   Fri, 17 Mar 2023 10:15:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] spi: atmel-quadspi: Free resources even if runtime
 resume failed in .remove()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
 <20230317084232.142257-3-u.kleine-koenig@pengutronix.de>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230317084232.142257-3-u.kleine-koenig@pengutronix.de>
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
> An early error exit in atmel_qspi_remove() doesn't prevent the device
> unbind. So this results in an spi controller with an unbound parent
> and unmapped register space (because devm_ioremap_resource() is undone).
> So using the remaining spi controller probably results in an oops.
> 
> Instead unregister the controller unconditionally and only skip hardware
> access and clk disable.
> 
> Also add a warning about resume failing and return zero unconditionally.
> The latter has the only effect to suppress a less helpful error message by
> the spi core.
> 
> Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/spi/atmel-quadspi.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 0c6f80ddea57..713a4d6700fd 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -706,18 +706,28 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	spi_unregister_controller(ctrl);
> -	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
> +
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret >= 0) {
> +		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
> +		clk_disable(aq->qspick);
> +		clk_disable(aq->pclk);
> +	} else {
> +		/*
> +		 * atmel_qspi_runtime_{suspend,resume} just disable and enable
> +		 * the two clks respectively. So after resume failed these are
> +		 * off, and we skip hardware access and disabling these clks again.
> +		 */
> +		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
> +	}
> +
> +	clk_unprepare(aq->qspick);
> +	clk_unprepare(aq->pclk);
>  
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
>  
> -	clk_disable_unprepare(aq->qspick);
> -	clk_disable_unprepare(aq->pclk);
>  	return 0;
>  }
>  
