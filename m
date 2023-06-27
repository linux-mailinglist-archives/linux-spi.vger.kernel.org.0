Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFD73FCFD
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jun 2023 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjF0Nj2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jun 2023 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjF0Nj1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jun 2023 09:39:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64832D5B
        for <linux-spi@vger.kernel.org>; Tue, 27 Jun 2023 06:39:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991f956fb5aso159817966b.0
        for <linux-spi@vger.kernel.org>; Tue, 27 Jun 2023 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687873163; x=1690465163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2HnWTfaDhyrvrN7IFESFvW8yOVuG/8fkShyZlJdY1o=;
        b=Z9whTEuxXKPkLsRfaRcCcbEafRicrFHWLk9nws32cYhEkiq7Um/8t8RxYwVyZ8BMsR
         AfAEi6GqPszTI3hIscpXmrvEapft8HEcY/2QqtRQ6LLsl/iGfThtiwEn9tMRi9QTqRaX
         dKUgXlJkjxaeaS10JpADUjSqt3ctvUxBAnFBve3Umjz48R92rOPVVHKvn5Oi95EP7PQN
         7ey1+U0ZD81REJ9H3SBYXJuh0V4Gu0QUCnfn8BcpF6PKJ401Df/3EePF5PRY/M2yEZlP
         bKZUx5ElvhGaqgwLEBwDhvXoT4KVZAFAw40KklkP/nu2tIYR15WgNKXYuZrRraIpAXGY
         7YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873163; x=1690465163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2HnWTfaDhyrvrN7IFESFvW8yOVuG/8fkShyZlJdY1o=;
        b=gKmmv1/q1T+gCoukDSj8HsTGVFAviKjcHA772XSzKncKvvM3rFiVrQh2s+KKKj6sh3
         Jpf9kg58Yr4DI8Bgbjp8z6KhujitHoddLyBNkRllcPGPHTtFGeh9n9ufSYpALPf2JPK9
         WFniFZryNftHVdkC4MjPcFPl4yZEkkpGK/nZ4orLoOrGQ6kMpD6v9neFnISllyCHa8pN
         quLjMXbg5evpx9Dc7eARhKMlfMo/FPJ5pxeBTXojYAtJb1K26TOxpd6MgYeqphDx4fiq
         2U1YSXAcpmJAX1pcts8i2pcKorG3eJU61PZ5P8GsBCYjbpAT94EQ0TSIWOqn3zz6ofVB
         4mGA==
X-Gm-Message-State: AC+VfDx8X5PzW/yOrjFhV4XLX8W7taNRZET9aJaDGDQRDAjSX8zv3OYX
        +oVVQ7+fqi92xRRh51V89+DOjw==
X-Google-Smtp-Source: ACHHUZ5ldtIaI4rcBReseOqa364qcf9nr7plIe4j3DJCtNy46I6HS7F9UeXE7WhP2SxTtqfs+fX4dw==
X-Received: by 2002:a17:906:eecb:b0:958:4c75:705e with SMTP id wu11-20020a170906eecb00b009584c75705emr24138869ejb.17.1687873163190;
        Tue, 27 Jun 2023 06:39:23 -0700 (PDT)
Received: from [10.230.170.72] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906088500b0098963eb0c3dsm4552560eje.26.2023.06.27.06.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:39:22 -0700 (PDT)
Message-ID: <0815474b-a8fa-f486-fc6e-a85df88ed9b9@linaro.org>
Date:   Tue, 27 Jun 2023 15:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] spi: stm32: disable device mode with st,stm32f4-spi
 compatible
Content-Language: en-US
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230627123906.147029-1-valentin.caron@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627123906.147029-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/06/2023 14:39, Valentin Caron wrote:
> STM32 SPI driver is not capable to handle device mode with stm32f4 soc.
> Stop probing if this case happens, and print an error with involved
> compatible.
> 

...

>  
>  static const struct of_device_id stm32_spi_of_match[] = {
> @@ -1798,8 +1802,16 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	bool device_mode;
>  	int ret;
> +	const char *compatible =
> +		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev)->compatible;

The goal was to replace it, so drop it.

> +	const struct stm32_spi_cfg *cfg = (const struct stm32_spi_cfg *)

Why do you need the cast? To drop the const? Are you sure it is really
needed?

> +		of_device_get_match_data(&pdev->dev);
Best regards,
Krzysztof

