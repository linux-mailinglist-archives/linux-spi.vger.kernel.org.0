Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A66BE622
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCQKBO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQKBN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 06:01:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919C279AF
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 03:01:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so18217457edd.5
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679047270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2nhjjo7tcKILjrQzaikOAKnmd9OWK7HwdJYpqohx3g=;
        b=Ye7AlacCwmb3eaSbfs3IZVL3HM0wDroj2uelbQenQV76blazg+LuJWmgBuDXdvV2s4
         dlpMcgb6W3WR7YIofDKbYqfktctGLXcWTc0xzZX5i8eAnW70QDQ4wzMFTVWwGS+Yl1KK
         C+Q1Lwn5/r1RRjoY6qk41w0nI2npwPu7LEvU/As0tRUMG/Ob3ptkqepEBZ7BmZR3C83L
         gpO0wMItzenkNmM++VRTFSRQ4EigmpEl8KkOF6DMJ+M3XoertPeLActqm49KDaEaQx7l
         EhgcZ/2w6mJk1I2bJs5oYb0iLmg9+13jhlrmGvR3dcAyfhff/sFqF4/1c39RvvIOcQbv
         h9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679047270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2nhjjo7tcKILjrQzaikOAKnmd9OWK7HwdJYpqohx3g=;
        b=JMfm6OuiOxOXFOnuDWq8jeq8UYsndKVo+v08uCC/mC+W/rAggURG/xD2mIGD8g3Sbl
         X0oMoN4RbMgUaLYkxrzlUZOoLbrywDVrouuYc78KGDlYPkaIaGORINgqpm6QglCMTgwT
         t5bLxVKg0Ks/DMdKJaHKWk7HhdD2NyT9l+vsXJJdpFaNxL4vgbJeNf41xNKavuxhI+id
         CGxccAwuUqmfPb013pe97dIEJ+z6ac/umpvwiXbp5PszFc8+uMlvNZkYHsdckdlxGTrW
         uXt4k2uJo67RrAKFqzocqmdi3WyrUUhYWVXNAFNn+f3ZiaBzKdQrJyeniegHuRExOXH7
         ijsQ==
X-Gm-Message-State: AO0yUKWV34PE+zMkwtjvJS+VgRg6hxEc1xMipotbBjaQyY//7nioqr0P
        3D9HBmHc1VLLNSuM9v9NMZlFfg==
X-Google-Smtp-Source: AK7set/LY/QMrH4Egv6LSRGAXi9MO9m70nJan/bE1VYw36NDrHHIQ8/WHyGl5Zp/PoVZAQMcFenZKA==
X-Received: by 2002:a17:906:8393:b0:8ae:f73e:233f with SMTP id p19-20020a170906839300b008aef73e233fmr14841263ejx.32.1679047270651;
        Fri, 17 Mar 2023 03:01:10 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090690c500b0093188e8d478sm785657ejw.103.2023.03.17.03.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 03:01:10 -0700 (PDT)
Message-ID: <f8dd7926-3394-ff51-ad64-bfcb2f906029@linaro.org>
Date:   Fri, 17 Mar 2023 10:01:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] spi: atmel-quadspi: Don't leak clk enable count in pm
 resume
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
 <20230317084232.142257-2-u.kleine-koenig@pengutronix.de>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230317084232.142257-2-u.kleine-koenig@pengutronix.de>
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
> The pm resume call is supposed to enable two clocks. If the second enable
> fails the callback reports failure but doesn't undo the first enable.
> 
> So call clk_disable() for the first clock when clk_enable() for the second
> one fails.
> 
> Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/spi/atmel-quadspi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index f4632cb07495..0c6f80ddea57 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -786,7 +786,11 @@ static int __maybe_unused atmel_qspi_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	return clk_enable(aq->qspick);
> +	ret = clk_enable(aq->qspick);
> +	if (ret)
> +		clk_disable(aq->pclk);
> +
> +	return ret;
>  }
>  
>  static const struct dev_pm_ops __maybe_unused atmel_qspi_pm_ops = {
