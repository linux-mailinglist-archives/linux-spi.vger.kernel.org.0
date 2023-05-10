Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2B6FDD70
	for <lists+linux-spi@lfdr.de>; Wed, 10 May 2023 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjEJMIN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 May 2023 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjEJMIM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 May 2023 08:08:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9A7D96
        for <linux-spi@vger.kernel.org>; Wed, 10 May 2023 05:08:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96652cb7673so623095866b.0
        for <linux-spi@vger.kernel.org>; Wed, 10 May 2023 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683720487; x=1686312487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N79rnLnBBvifpn/rGywONJKqPsgsUMB/5px3PC0SkJA=;
        b=Evqvcrrv0vlZHKChv7OVRMequxaI02TVQV8IaRj4X+NX5lmgapKKFQHtsCjNUNbtY+
         cb5Epl2tgNebU6v45utxn2CNZzJ+eMzMr2ZfCoVTRbSeHM9uz5+C4e0kilVpZ+jdo9Jy
         h0HVzGeVs0d0fuj8viMJJxDmkAk7VIAWQL7XpBDtoiOIZOmMav8RFMCAR4rtoF+0vml0
         CVf3KJlMk1BuqGT7a7QmuBo5IkHXJqA66By67ZDIWb4EhDEuqvUkuRZsbC+Wy5pB3f2k
         kUMCuBnlimnbkRsv/ZBiM0SIfVHEAjVac0/GUdhiTeJxmFpZPhYKueEa4nM3W1PqITCG
         BOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683720487; x=1686312487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N79rnLnBBvifpn/rGywONJKqPsgsUMB/5px3PC0SkJA=;
        b=LILNVwOuZokXnAInlGNKlVnAFc68oHykM2/ozoqjN2iCu4ZSBbgJZhEOZhOiVd3GXb
         jvm2SJxo1ZV3nyHyQGQF7reiXvRm4rf2uUfwdjJFfKDTopzt+WvnNPR2nWHcFhdl4Tth
         O1HQ1yovqWyF6T7Tm5qQH++XnJFB/Dfgg8vSJ7Kmf0seAOGS31KWa24xSxFVXz17BChz
         vqi0Xf6w0zUoN3/QLb+UatWxTRHPk9LWOOaTF76Kf4mc8IImM9qLHBVW06+YVkjWjrvn
         BPP2dZSxPhk9HrFbJM4lMKVCNH4KPFzGWNO9LEFXF6Hb6shrSIIC2Vf6UN253MMxi7nR
         +l/w==
X-Gm-Message-State: AC+VfDwEVCCfLb2fTToBhzbrRyGW2O1YP6icO3gjEf4AMIK9zIZu0hYT
        75KrCnzo7NtVnWXJ7p2zWJ6eQA==
X-Google-Smtp-Source: ACHHUZ7u0aa8wR9dxWCV3LnMuyxcpEgpuKFHc8KUeQWzoxnJciQDNmuM1yiUkbRpGtwtCgKG5D/oUg==
X-Received: by 2002:a17:906:478a:b0:969:b88c:b8a2 with SMTP id cw10-20020a170906478a00b00969b88cb8a2mr7297470ejc.10.1683720487193;
        Wed, 10 May 2023 05:08:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id d4-20020a170907272400b00965e9b435dfsm2608471ejl.65.2023.05.10.05.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:08:06 -0700 (PDT)
Message-ID: <ffc244d4-74cc-ab82-1479-b8a6671ecbac@linaro.org>
Date:   Wed, 10 May 2023 14:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] spi: s3c64xx: Disable IRQ mode when using DMA
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20230510120245epcas2p2cea91a04ef2fd46f0fa9f22f73c5b2eb@epcas2p2.samsung.com>
 <20230510113942.89994-1-jaewon02.kim@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510113942.89994-1-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/05/2023 13:39, Jaewon Kim wrote:
> Fixing the problem of enabling DMA mode and IRQ mode at the same time.
> In this case, a value of more than 6bits is written to RDY_LVL, it can
> cause an invasion of other registers, potentially leading to SPI
> transfer failure.
> 
> Fixes: 1ee806718d5e ("spi: s3c64xx: support interrupt based pio mode")
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

