Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE25BE680
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiITM4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiITM4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 08:56:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA162BF
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 05:56:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f14so3637218lfg.5
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gojgNlS3cpxKBOBJCF7ocTpY8nwD7vwn2Kxe4l3/sSU=;
        b=suSrWQol026EB82sn4bepiN4KWAT+IeKlv+a0j1jKu9vCtEDWf4mws2S+xFRt/oYeq
         WHHMCizTTxKf+MhofUgEJGva/Qb01Bf9aiv8S6arvoc5XsaS6Lz/J9dky3HR5dQ44vYf
         i/9vsk8EI2kK1sIU8piVlmK3ys8XLtuRqFsfbnxbHZEtdm0w5yfSUcz9M19MEAGgJeIW
         WHZivklTurWEwC7Y6v6pqO0uQ27elLIVoD455FRRNfH2HBCVQKe9o0Ao0WLmIrdgAUed
         uQfAm15fUVo3ifxlmWQd7topKcwq54X0UFVZb6dbmhWsJnutz8D0kAESpZJlEIPbq2w5
         IeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gojgNlS3cpxKBOBJCF7ocTpY8nwD7vwn2Kxe4l3/sSU=;
        b=k35XjPhw0ut/fRjpniyPD7bwjsy+tRTz+nyW2vBUbQFX2ruKefkirPuZ0a0O+N63hA
         lJE2UKtFmXkEzMekse2rz4oQB9pV4AxCQ/36ncUnYWEoNu1oRRz0ONYgoEpm/qOEPO69
         vbTz79i7SKLyo9PJLwr+ceguyifjP1aABYq5DKBUnE3LsAbHaeKiT/eF28u3KHddBg3l
         LOO/trrWtGWE0GqclS7bhohiRpOPPlbOXnaNeEt8qAOTNw3zF3S9S5C6thpITNLZJMG6
         Itl6JTlxCjghmBiDZOwqV72yx6ubgFZkASYAr86Lgvj6xEa04hQtoh+kzZvZKkr9byZS
         HswA==
X-Gm-Message-State: ACrzQf1BmkZJR3pKCCwpCwxMeXcojHT6SG4uw0FLQ8XjPJj9FLTwEcv/
        njhzKS4AL1SNjJfSDuXCrNmFGA==
X-Google-Smtp-Source: AMsMyM6C1NuFbsujkn3Etoc7iFL78OJfmP66HqXgLYXPaYGhV08YsNqrIQwmTHaPB0KMm7l5Z0NxSA==
X-Received: by 2002:ac2:4463:0:b0:499:5802:8ea9 with SMTP id y3-20020ac24463000000b0049958028ea9mr7611111lfl.344.1663678591478;
        Tue, 20 Sep 2022 05:56:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v18-20020a05651203b200b00492c463526dsm300747lfp.186.2022.09.20.05.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:56:31 -0700 (PDT)
Message-ID: <48ee33f7-7eb9-25bf-74b5-27a89f92fb82@linaro.org>
Date:   Tue, 20 Sep 2022 14:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] spi: s3c24xx: Switch to use devm_spi_alloc_master()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     broonie@kernel.org
References: <20220920114901.2683267-1-yangyingliang@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920114901.2683267-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/09/2022 13:49, Yang Yingliang wrote:
(...)

>  
>  	s3c24xx_spi_initialsetup(hw);
> @@ -531,17 +525,11 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
>  	err = spi_bitbang_start(&hw->bitbang);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to register SPI master\n");
> -		goto err_register;
> +		clk_disable(hw->clk);
> +		return err;
>  	}
>  
>  	return 0;
> -
> - err_register:
> -	clk_disable(hw->clk);

This label and error handling should rather stay.


Best regards,
Krzysztof
