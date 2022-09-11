Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89A5B4F10
	for <lists+linux-spi@lfdr.de>; Sun, 11 Sep 2022 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiIKNdU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 11 Sep 2022 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIKNdT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 11 Sep 2022 09:33:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E42D1D9
        for <linux-spi@vger.kernel.org>; Sun, 11 Sep 2022 06:33:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l12so7617600ljg.9
        for <linux-spi@vger.kernel.org>; Sun, 11 Sep 2022 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1sv+9GxZvTQ6143OU1z3a5G2/CCtID2mF5c13ibNQWk=;
        b=r4ivx5eUaC7hZcbI49hnJCtaTwlnzOAksk2x6q5NpjBXXyPnSbEKAo4qgQPEMQNGut
         Wh8iWJ84mLw+M0eURiyatCIrakY3JPIkiJQLpYQrr2z8XPIfs25m6iJ/rWJf3yhRUD1l
         HxixAOJ0nw+zWo0LpeacuEf2EMlGbDab76MT+RVS5ezYXWMb19ojwpCMGwY5skCEARXt
         eDZoMjE1Ql0mYpBfnHjVhW0Ed2KuNWGufSL38U8pceJjYsemya6xxEIj3EnxIE/fDH3c
         oA5+Ua1WEutIscLTz9YKEJLGaLy5qN+rTwxY7vX/mMu345C/ihDH7MRX9dR/VQ58txpI
         CqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1sv+9GxZvTQ6143OU1z3a5G2/CCtID2mF5c13ibNQWk=;
        b=uwOIHT7/W4UY057d+WpwXrYpSUICxDrTplyK/P2qpZE4looKtwbv5nrZ1fcIdXBBd6
         m7eHRRp5SacWqabkqj7cIkysUiBeZs5p+4IvvpDXtzn9BMgOAll7Jj0R0w8Vnp3Uhpez
         mT2Rohsf+bp+sTqBDRjG/bHF8O1hYrkI1fBXfxorYWYo5LFllwD4u4JXlmJa3pj5sNuI
         Dijm+2fBJwcWaKP6IDjVQsENHL5LZPbkgFEp+JdQCxqT0SAgfArjmL7DmsedNKz0c7Hn
         U5RJXCR0ukni7Oo1ln0ZmV/OeEC5UnjVdmol5P0xl95nLzfiNdKcfK5GaqtSPG/3/hWv
         JShw==
X-Gm-Message-State: ACgBeo1WQglb1bQC4vz/mtSrf3SmFrzGtX8s+q1RXnxcMZQ+e4VO1zJ8
        0eJ/WI62hbujydQbFj1bbZ7wmQ==
X-Google-Smtp-Source: AA6agR5Tp89RJwNg77XkaWI6yk1Ms0Wp2i4w7/5dpQXI9Ww266DQD8DU98lSjmZiJz5yPRHVlZZDXA==
X-Received: by 2002:a2e:7201:0:b0:26b:dd49:721b with SMTP id n1-20020a2e7201000000b0026bdd49721bmr4383261ljc.509.1662903196477;
        Sun, 11 Sep 2022 06:33:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b15-20020a2eb90f000000b00261e7244887sm653164ljb.60.2022.09.11.06.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:33:15 -0700 (PDT)
Message-ID: <94a1dbec-c59a-5feb-3df3-6f4fb90eefe1@linaro.org>
Date:   Sun, 11 Sep 2022 15:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] dt-bindings: spi: rockchip: add power-domains property
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <64d03f6e-c578-3155-e3fb-53dbe53573eb@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <64d03f6e-c578-3155-e3fb-53dbe53573eb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/09/2022 20:56, Johan Jonker wrote:
> The Rockchip rk3399 TRM mentions that pd_sdioaudio includes
> sdio, spi, i2s and spdif. Add a power-domains property to
> reduce notifications with spi-rockchip.yaml.

Drop the last sentence - there are no notifications. Just write bindings
to match reality (hardware).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
