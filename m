Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA97776CB
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjHJLVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjHJLVm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 07:21:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60582686
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 04:21:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c0290f0a8so112508866b.1
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666497; x=1692271297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1znZslU4qiUcKQ48m1cZOLPkj7/iYr49C2vRBIDTlZM=;
        b=pNLpqRWxkKJ2C0iZ3gpey6ptu2kGjEwYz+4uuN9P7pPr0GfHJ7uYCRJKjAPhSlJ1TI
         9bVzMtADeVu6ZoXtjQxZPakHx39U7QWxqXBLUTbuBwl0oNfHbF6qRcZ4JnliU5DeTdvk
         0MfJC//wylXiGJqrKmkjn7hzH6JmzlLksO8298xqZABgE5dUXNKi0B2jF02oG+nXk2J8
         tjjBHGiTnjdg/VGfQ9s/rKr/8FnwIG6SIhEG7uqELij4x0trbzUOrTSMjP5iKxXLuTIC
         y3u5+YLTNsGDQx4aT4sO1Wu5CCuvSlry+6/fmDrdE5SiIQvISNS2yRKWt+llJybJgnqu
         UhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666497; x=1692271297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1znZslU4qiUcKQ48m1cZOLPkj7/iYr49C2vRBIDTlZM=;
        b=bi+DjhTWls5AvMq/gonbVHx79WN+eyJH9JiouKPC0lL48PoXJ7UIdziPCm//wmdOk1
         ddX/UILQQsAPsvkMP+vqU63hCe7sy5OZ/xFWJ+SzRcudYFG0JButT92mJGZDBu8yKTJ/
         qIi6bhjXvCe4EORp1Ty/TWGAyX8FdYb/APG9WIFGPDzBxZclBBz9QYouNpH/6MGAYyXy
         rt3Sfchq17DqxyiS3xYTkviu1KWuzURO/s2PkKrrBOS9z9qjCKmWcaL+SNaoLM5MeZ4/
         HubGcsQ9hbyi0vbT8ENGaEU4KpEoVOobv6hl3ynBzOJGrFl7PpvnNLSW8a4iwY0R83/m
         H8dA==
X-Gm-Message-State: AOJu0Yxidz3fAQpK2c7AT1NIA0JyKDMHiDO59R2WQD8h/U0PlpPIUir1
        TTMtdP01vtwqd9EHUhkTFKg92A==
X-Google-Smtp-Source: AGHT+IEmAq0x1uM3g5n0GXeEfQtQPS/9vp+IlOK/m2Yd7Jt5aXhLO6iH524iPkbf9djLK7pkOuhyJA==
X-Received: by 2002:a17:907:78d8:b0:992:d013:1132 with SMTP id kv24-20020a17090778d800b00992d0131132mr1636840ejc.1.1691666497357;
        Thu, 10 Aug 2023 04:21:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709064e8500b00993928e4d1bsm791038eju.24.2023.08.10.04.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 04:21:36 -0700 (PDT)
Message-ID: <07e4b703-f130-2f99-6703-4aa6717d7224@linaro.org>
Date:   Thu, 10 Aug 2023 13:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/3] spi: sc18is602: fix
 Wvoid-pointer-to-enum-cast warning
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/08/2023 11:12, Krzysztof Kozlowski wrote:
> 'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   spi-sc18is602.c:269:12: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The "net-next" patch subject prefix is not correct. My mistake.

Best regards,
Krzysztof

