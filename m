Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0936615EE
	for <lists+linux-spi@lfdr.de>; Sun,  8 Jan 2023 15:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjAHOwu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Jan 2023 09:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjAHOwb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Jan 2023 09:52:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6FB1E4
        for <linux-spi@vger.kernel.org>; Sun,  8 Jan 2023 06:52:29 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso4676399wmq.1
        for <linux-spi@vger.kernel.org>; Sun, 08 Jan 2023 06:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTPm22szfEgP2USzyDubKCBhEisV4thL30XHBSbnE2g=;
        b=Id63Ng+QurBcI5owy8mPHWunVXGkmUQKEDc5nhp9256GKznn/qgp8RNp9fzaopQGTs
         Lw5KN58+w6J+sZEY1wXxX/zkBn4RYxm4lKD2fP8itRn14HgWLrcpZcanfVNYrAApuj4t
         Nj6+sWwoR2WoUJAP844/sOU7g6qAYEeftDcHOrYwYL02qDJgyqsEq0lzYktWrSxhIHIX
         iy+4MXBBXu5PuO7XqE651g+PIAFUSZD/dB3tj41ORUJah4k/UHQmXbEACaIAHqbvgGHP
         YarnGy7EeSSCjwsCspIaDwhJbr8pEDoPvVON8uCR/OXK64HYI18OA2w4nYTYfAGwIJDm
         IIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTPm22szfEgP2USzyDubKCBhEisV4thL30XHBSbnE2g=;
        b=yn+kbYiHuoBrlDC3F6Ww0MwcLoSIvRq8XfZdz1WS4d3yz72E5zGIwM6GwjDfiR49uf
         AZtqVyz/XWulnn+a2UDTnma9aBqB3BAWE+OTKrT/f+T/Z+Rl8Kkdgj4mBqGLKkMgabU3
         90K0E67hmdGZlYXD36i27skgnyOfjT4Jp9jOUuEocgdSd8lb7dpSYeD4qrTNHPOk8lJI
         ZVgoizsm7rF060u00+HjRecMtqZCSHItxkJCy2WLKVA4K30nF4Rj8a3Ysn+N8FE1x6Ih
         9Ui+Oo5ONLAqCIDuSwTq2DiC6YYH5e7zhlDKtGoEUAX5sCuF7oawTErjQawLkhbdeDlQ
         4Dyw==
X-Gm-Message-State: AFqh2kq0SnPv4cUefa3frUbKkSCA1c+cGvkU4KL9wS8v/D7rtZuPDx9V
        ozQDQYA7FqMfgYMOQKd8V79WEQ==
X-Google-Smtp-Source: AMrXdXsdekKuhU814b0ntj6vl2m5cp1iTya2rl8g8E9ks0gbmjFTyaS1duJ3r70lPhq8NWJP+2BeMg==
X-Received: by 2002:a05:600c:3b29:b0:3cf:d18e:528b with SMTP id m41-20020a05600c3b2900b003cfd18e528bmr44997779wms.39.1673189547794;
        Sun, 08 Jan 2023 06:52:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003d9b87296a9sm14057028wmo.25.2023.01.08.06.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 06:52:27 -0800 (PST)
Message-ID: <dc23b376-6f1a-21d9-5d26-2ccde563fb34@linaro.org>
Date:   Sun, 8 Jan 2023 15:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/16] dt-bindings: spi: Add spi peripheral specific
 property
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-4-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106200809.330769-4-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/01/2023 21:07, William Zhang wrote:
> brcm,no-clk-gate is a Broadcom Broadband HS SPI controller specific
> property for certain SPI device such as Broadcom ISI voice daughtercard
> to work properly. It disables the clock gating feature when the chip
> select is deasserted for any device that wants to keep the clock
> running.


> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index ead2cccf658f..f85d777c7b67 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -108,5 +108,6 @@ allOf:
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
>    - $ref: samsung,spi-peripheral-props.yaml#
>    - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
> +  - $ref: brcm,bcm63xx-hsspi-peripheral-props.yaml#

Don't break the order.

Best regards,
Krzysztof

