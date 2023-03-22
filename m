Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020F86C5083
	for <lists+linux-spi@lfdr.de>; Wed, 22 Mar 2023 17:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCVQZj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCVQZi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 12:25:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB6E4DBF4
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 09:25:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so75255666ede.8
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679502334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sr/j+3cgxhM/KwgZTgpDYZTgFfI9GXlmQ/zkQE90CIw=;
        b=DnfWqPzonQ3weXJMufSIJ/VihFVfOy9/L/LsGefrAXYKMpiQSxjIcg3WNspyJtCx5g
         qOB3MX03pwwXyIorvs6eQ2NUPntoug7U5TqkYrbXLu8vYdp1uw4cCo/vLufkoGb6+UDr
         qt4AWE33l5Axb5tiRamp1bOexP4LJ057foVO13gQcQnEYOepeusmY+YRktiCTJ+UvMWT
         iFFmrsabL5S6QtQi6Ng/8kgCzV3FmkvjkmnO81TtzyjbhzbKGikGaKqyr6yUOC388PKy
         GKWRCABXhpl0rUA2BLzBua147+Vys8ZepByB1w40o37GlR60Q5m/VkKNCgHaAmA3SjJk
         FHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr/j+3cgxhM/KwgZTgpDYZTgFfI9GXlmQ/zkQE90CIw=;
        b=c/RyfMS9eoKDZNDsieTERoUlQipWmYOlYAo46QmpSe9jyHRci3GaD1kAIy2uBXDVfD
         SzPu3FmOIg/OYrE6gi5r1dVqoIfF3TCpNn7NvLFLxfu7rcVzHsFaEZlUSEM6ujkvNYQ7
         hADAOj0ZjbJRf9BB5F6JC0N1SeNP0UtrtKe5ucAhm7AIbGUVVNE78fkLWLFA1FDeRZNY
         6VNs4AILOf0P1mm3gWWrEfS2sDplMwRigyIRqcXuDfO2mpKRyuZ5uEOAYmaq/YmVmGnj
         ccj0nTxZacXjiVYPYAXeS5x05QL6RmdUEF0D0dpFvvs+zRpG2oUokxWBgIL408YVXHDE
         42LQ==
X-Gm-Message-State: AO0yUKUh75VDeXl+n5EqntBw28H2VUdpy8y7O8KQsrkZ7cHYkjptK2ps
        6s0mAuvwhIkP/VX0fs+glEIF/A==
X-Google-Smtp-Source: AK7set9wGnyFe5XaKDU4cr/JttOVQwkZpPZ2A7mTqYQgkHG7Gr2iKP4b2JK7K+TnSFBBJB3q9BxgKg==
X-Received: by 2002:a05:6402:1762:b0:4af:70a5:560b with SMTP id da2-20020a056402176200b004af70a5560bmr3025768edb.9.1679502334017;
        Wed, 22 Mar 2023 09:25:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm7924722edj.91.2023.03.22.09.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:25:33 -0700 (PDT)
Message-ID: <21bc1f94-35f8-42b1-f04b-86a5b4c03675@linaro.org>
Date:   Wed, 22 Mar 2023 17:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add binding for meson-spifc-a1
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
 <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322150458.783901-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/03/2023 16:04, Martin Kurbanov wrote:
> Add YAML devicetree binding for Amlogic Meson A113L (A1 family)
> SPIFC Driver.

Subject: drop second/last, redundant "binding for". The "dt-bindings"
prefix is already stating that these are bindings.

> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a1-clkc.h>
> +    spi@fd000400 {
> +          compatible = "amlogic,meson-a1-spifc";

Use 4 spaces for example indentation.

Best regards,
Krzysztof

