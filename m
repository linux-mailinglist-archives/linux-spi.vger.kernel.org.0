Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB158059A
	for <lists+linux-spi@lfdr.de>; Mon, 25 Jul 2022 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiGYU3r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Jul 2022 16:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiGYU3q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Jul 2022 16:29:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D64B22285
        for <linux-spi@vger.kernel.org>; Mon, 25 Jul 2022 13:29:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m12so18698113lfj.4
        for <linux-spi@vger.kernel.org>; Mon, 25 Jul 2022 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b4+zrHydncSnGE8NzMR4jfY6BqFnB6mPYhQPBEGmp+4=;
        b=vuV4gzEXUyKzE3RrbAcYXdJpyb6GtSn899V1rBjnjTjVzITMoIyUWVTF3eeKsx1gAm
         teVs3DU+iJyaaIJoWl6G2cSz4mTJtxS2bpAQxAAbyH6W9EBNLc2YKp1NYMsSvfEvl1Nw
         VA9u6s81AhaHWD7kLv3cPMbWRTuBeyB58FHUHJUf9twXDgsfIamkEXautM33e0uhtJDm
         GX1VtaMoTfZf+D7ZE35Rj5cWAfNRCth0dazBmDK8vZn33mkc3jkUWLtHpVCoWt1eBxYo
         BVyovkHQNxsbuSRHiNAlKdX9DWvd7+oB39aBNM9cWGdj0eWlzOgK/6iBs1UUx477jiPG
         tvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b4+zrHydncSnGE8NzMR4jfY6BqFnB6mPYhQPBEGmp+4=;
        b=Hyu/WUx3MuLu7rLl348GkRWH7SqV+1VCeClT0nifgJWF5M1RF6ZYCZ3F6J9GuJL9Vy
         bDSxm0OLKGPQVn7wFz97v/w+afcyqnBs2lsKQt0gufSrUT+BU0a7w18SbR08DWSgxdlR
         clNNEiiqApoCz6M9Mptm14SpriIb2EmPt0GJvRKppvOMUEGyWoxt+nQ6XhcV26dZAlDH
         BrcAeWItbUmq0R0+TMVKWm6DD4ToTRaXpvUKNJjR8zfrL21yZe1H33R3/JkdTfta0Zpx
         7HBF+4kUpit2xXpw60Z7TjMH6l/HuxtBeE3IEpzKLV8yh+mUlttw0LPAeEctqATuXHIu
         /InA==
X-Gm-Message-State: AJIora8EAP54v4RvyIElP6Nv8vXN8WtOKzl9Eb8W+hVjTfj4Gf8OlBg3
        k03uDpwK+DLT5Ro8TQ1VM77ExA==
X-Google-Smtp-Source: AGRyM1t7ckEhCnEiqOR0EzJEDxOVbbtd5X+MdkJqJwBraQR7j+TWjzxErv7tMQ71wjc4uX91+CX2ZA==
X-Received: by 2002:a05:6512:218c:b0:48a:1e1e:7b59 with SMTP id b12-20020a056512218c00b0048a1e1e7b59mr5044957lft.580.1658780983896;
        Mon, 25 Jul 2022 13:29:43 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea447000000b0025d715bc088sm2907615ljn.0.2022.07.25.13.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:29:43 -0700 (PDT)
Message-ID: <ad56dc32-e696-3c16-17cc-28e8d24c36dc@linaro.org>
Date:   Mon, 25 Jul 2022 22:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220725201322.41810-1-nick.hawkins@hpe.com>
 <20220725201322.41810-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725201322.41810-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25/07/2022 22:13, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
