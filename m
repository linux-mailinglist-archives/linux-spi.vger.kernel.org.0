Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7B747CBE
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 08:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGEGAK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 02:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGEGAJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 02:00:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD0C10C3
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 23:00:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so7111926a12.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Jul 2023 23:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688536805; x=1691128805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lg4p70yBEKgSpD1cT2YGaKlK1TI1DMTxkPYru7t7pjo=;
        b=JuxdT/xEit4IrqGeHlnyYjKmGmvgAzwPA8szxaSJH3EZcEWwW63T44Zc6/atD6SZSi
         OHBv//7Ewd32S3ndKkXVvv1U81h/6FDKWuKhz9E+VHS0Yx0Ubstgg3xT7IuJxr5DLfQ/
         +Y9WBvvo46+zTP4dmeFiih5GUAD+tGqaTA9cwBhlS5YhmHgci/emfftL3DCoHUhRaHFo
         nbvT1yD4uC9SPhEGcPcsR99OcyBwYSVxCz+PlpodlKeuhew8rvdUVl5L4Kbvb2TZopri
         4DcwPfXRWwC4l35FCWKhfZg70GjOlvVeaFYDjB8AQhR2Oh+rajLl5L6dXXbcFzPVSNqf
         lBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688536805; x=1691128805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lg4p70yBEKgSpD1cT2YGaKlK1TI1DMTxkPYru7t7pjo=;
        b=bReg0zku5O2c14cZbTd2lS6ZxSoB69AQZXp13Kcm8qFgxpv/b0PB+h/L5H8byvg13L
         xKkSqcNT/ML1ZJuhFY8Ck7q7wsOY5eZvgKHRvJzd+BxxgT02t46npGGpd3WvnOFflCjL
         UCk5GnKdh539P6ixu/nG/+OyfE+r+Pw0KNMyMHCq9PGWlGGvPkohRkpxY2wFaoAanbwQ
         Ks/t+rVhJMNX/5hIyjkqUjwNo8vFTFDpgq0uavvyLy6h5gBxa7fONK81Tpu1/uIl2GCa
         zjQnLGF2Y7h3eLY20EJ6biqxoUXlgXRXEwjXSzHjUuolrHrg6mUMuoEMQOsQ4dHnKzqB
         fhUg==
X-Gm-Message-State: ABy/qLZwwZWbhjSvhRwjSFdP2oF58LH9BHxVS4kuOdoc9hG7QwUHP7Fk
        LbjcnF7kgZ3ijJ3BeX110oyWaw==
X-Google-Smtp-Source: APBJJlHovpZJ6c+S3ijS7SQT3N5tbS5WFllsIv8PWnLvlpcF+jgm5rZjp5jo94AHu/4D3FFDZ5JmTA==
X-Received: by 2002:a17:906:a38b:b0:991:f207:411e with SMTP id k11-20020a170906a38b00b00991f207411emr10107006ejz.69.1688536804831;
        Tue, 04 Jul 2023 23:00:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090666d900b00982842ea98bsm14071542ejp.195.2023.07.04.23.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:00:04 -0700 (PDT)
Message-ID: <afcf67e3-a017-b747-a0cf-284a87a8d24a@linaro.org>
Date:   Wed, 5 Jul 2023 08:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v1 1/2] dt-binding: spi: constrain minItems of clocks and
 clock-names
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-2-william.qiu@starfivetech.com>
 <1b65e8d1-d5e1-0d6b-1248-d9683be44db8@linaro.org>
 <c5027d42-b9be-090d-bd43-86c9b1448c99@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5027d42-b9be-090d-bd43-86c9b1448c99@starfivetech.com>
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

On 05/07/2023 05:37, William Qiu wrote:
>>> ---
>>>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 11 ++++++++---
>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>>> index 91e540a92faf..42bb34c39971 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>>> @@ -11,6 +11,7 @@ maintainers:
>>>
>>>  allOf:
>>>    - $ref: spi-controller.yaml#
>>> +  - $ref: /schemas/arm/primecell.yaml#
>>
>> This looks unrelated, so keep it as separate commit with its own rationale.
>>
> Because "arm,primecell-periphid"  is need in JH7110 SoC, so I added them in
> one commit, so do I need to put them in two commit?

You need to provide rationale why this is needed. I would assume this is
needed for every primecell, not only JH7110, right?



Best regards,
Krzysztof

