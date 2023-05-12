Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A9700B81
	for <lists+linux-spi@lfdr.de>; Fri, 12 May 2023 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbjELPZ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 May 2023 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbjELPZ5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 May 2023 11:25:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020E10DF
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 08:25:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so17845646a12.1
        for <linux-spi@vger.kernel.org>; Fri, 12 May 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683905154; x=1686497154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tAvOql5lp6FWkpzgWQiK30SNN35QkWi8X6zAAtYsbE=;
        b=evUjakgZfiWHOeaGTxTvfwse8uA7XL2gV7DSxc6/YHDPwIZl9h7joIgg5+ImdcVlHJ
         fjWqIG7H3/sjSQsQ7t1gM5Hub04ClnfGFAaVoYXpNUQI7u/H9G+Fi7bzsO7Go4cy5T4L
         0Czmo/a7u4d6cG2iPg1iT5UX3DtQezAD51OF21qH9ae5xIRttV0uN8WO+7yNAUP8ncrH
         qJoWmqK9TDkZq5JsM9TC4GwylZtD/8H1Ml7c7hwcPu/ayDsACxOrU6uEF71ZoajKP/C4
         ka22BMTKAmKmwVokU68coV0y6EK15f8XkZDstTj/HBoOwy4VGXHL9nACxplBZHIq64lO
         Gcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905154; x=1686497154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tAvOql5lp6FWkpzgWQiK30SNN35QkWi8X6zAAtYsbE=;
        b=cS38LRpi9LNLhPBjfRjqvQd0zTBYgRdYEiuIZhj8sSRL/48478KdNZdpYcLJA6TAPL
         icaLNgKRTAOKVqBBX1hd40A4JttQ5HHHbu45cLY/D0jZnaPnEaNjZ3dCtnqJfCMRcylm
         8hWOvQKIjvW9Xh5LgtNG+egOdl9UhTREar7SMUVzx5HcS1uOr/5Lrm30Q/2ZTg7LM0H5
         0BRTWnd/DTGeVX25j7EgUkHBRYhK98rwy/j/rADf/tm2LEwxvMnMxRjc8YgitnD8wwdM
         2H85nPUWB75BCpDkD/HfHz83xIJJrU6KZ633RV6lm70Zgj5z6rDc5Olymnz6gQVS387Y
         6Ouw==
X-Gm-Message-State: AC+VfDzhET6YLvykOeBeVY83r29szK6DYpyI7zMpmUBdNczeVRaWlnz2
        0kcagDAB7LWezEs0zVwf0h9abQ==
X-Google-Smtp-Source: ACHHUZ6VLH5TEFcmhdJSIdLisEJz4f2jKiPaq4t5hSh2saBPH6sCMNzCPOVC3ciAXYocEELNXOGVhg==
X-Received: by 2002:a05:6402:1a48:b0:50c:d5d:c960 with SMTP id bf8-20020a0564021a4800b0050c0d5dc960mr20446684edb.38.1683905154708;
        Fri, 12 May 2023 08:25:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7d38e000000b0050c0d651fb1sm4031539edq.75.2023.05.12.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:25:54 -0700 (PDT)
Message-ID: <5969fe82-69cd-34d6-edd1-d16ea741d9cb@linaro.org>
Date:   Fri, 12 May 2023 17:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/05/2023 14:28, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for

...

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2

Hm, are you sure? Who is the consumer/user of this interrupt controller?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  clocks:


Best regards,
Krzysztof

