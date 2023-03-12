Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B56B6B9A
	for <lists+linux-spi@lfdr.de>; Sun, 12 Mar 2023 21:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCLU6Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Mar 2023 16:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjCLU6U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Mar 2023 16:58:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A0144A1
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 13:58:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k10so40950464edk.13
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20W8M2TdEhNy7aTngidW3iiHvYf5XABL/NJb+wNETK0=;
        b=I02JLnAeOEVaZGRIcfS1UM3P7RFH2leQ9zMuXN0HLdN6J02MDaQ42e2WEap6Oag1/S
         rlVO9nY9zT/MfLkpF0/zzHMTskhAY5n0MEzIvuXptYExJZwIBcfo8uIGEjspnYq8L8W1
         1bNl1jJFWQGbH0/NbsXk+vJxYlaLdXjiaW+CskmXjzFyoXihJqmi8K0T9sMOfj4omYz9
         amkplJ5I8OPoIKAyD1IxHN4jlSh/FFSrvm2gNtQBi6NGRjZVOAaVHEb8b2qQXCjGzmKD
         xe2+NPZSr0NP/WmauDsYzCJGX2MXyEfJG/P+GZ8rq9QyyPuX1a4Dqs//a7XG1UbqZ6uD
         IyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20W8M2TdEhNy7aTngidW3iiHvYf5XABL/NJb+wNETK0=;
        b=W47wRJEzxcvsJQxFo6LINoMC38I3F0Gy+ytQMS5LeqExqiRSaD+edrewDITjKVMlzJ
         Lvmsd0Q2rOQKS4yh2Qd8nt7GYEDA7lqcBDoEhEIw7uDjFaJyT/BXOI4YgEnDjPnqJS9Y
         /r7sK4hZM61wDnIjiH7WlB5HjZ3OToQhdHon23khiVcbjLLzjKJF+Xvq92dVrmhqEnx9
         zrF89jPMA88gbWqN9wociFQBND6JXfTYbzqIyC25jSyWAkOr4jbOdzADVVrAQCV49X0J
         jLHVrowT6TSpGQNmm3GsDZRXEQBaOcUL1ZuFJD62BRDqBaikFB70ecTC3Dh6xPx8K4Nz
         +s/A==
X-Gm-Message-State: AO0yUKXJlIxYfaYAlHQ9BwAZDkl4XavL2LtA+u3ZOrzRUk25VDfQk7lB
        FWDdtiut6VCWcjO3AKguh2DT/Q==
X-Google-Smtp-Source: AK7set8XaKUkz6qbzkBRl5y1qtqalHLBAv3RLKmkgmCfyFwnymmDsiDYn1Y3sC5kXO3E2WOOjEkW4w==
X-Received: by 2002:a17:907:a04:b0:8af:370b:da59 with SMTP id bb4-20020a1709070a0400b008af370bda59mr45390936ejc.17.1678654697314;
        Sun, 12 Mar 2023 13:58:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b008d68d018153sm2597511ejb.23.2023.03.12.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:58:16 -0700 (PDT)
Message-ID: <92b4970a-f904-884b-f0fe-0ab8f024210c@linaro.org>
Date:   Sun, 12 Mar 2023 21:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 05/15] dt-bindings: soc: amd: amd,pensando-elba-ctrl:
 Add Pensando SoC Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230312004445.15913-1-blarson@amd.com>
 <20230312004445.15913-6-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312004445.15913-6-blarson@amd.com>
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

On 12/03/2023 01:44, Brad Larson wrote:
> Support the AMD Pensando Elba SoC Controller which is a SPI connected
> device providing a miscellaneous set of essential board control/status
> registers.  This device is present in all Pensando SoC based designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> v11 changes:
> - Fixed the compatible which should have stayed as 'amd,pensando-elba-ctrl',
>   the commit message, and the filename
> - Reference spi-peripheral-props
> - Delete spi-max-frequency 
> - Remove num-cs from example


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

