Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CC73B2DC
	for <lists+linux-spi@lfdr.de>; Fri, 23 Jun 2023 10:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFWIra (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Jun 2023 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFWIr3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Jun 2023 04:47:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206DC1706
        for <linux-spi@vger.kernel.org>; Fri, 23 Jun 2023 01:47:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9896216338cso28355766b.3
        for <linux-spi@vger.kernel.org>; Fri, 23 Jun 2023 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687510046; x=1690102046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zgp00NlD+EVH0cgqUIzV85S453hqNC2iv1Edy9sWKio=;
        b=xU5KOFnxo/GrPDQOrDfdgMH2IpH1tIVgWoZKoZVkP9Q3bSES3ZsMfA0jxGEdHoWtux
         LHJcH94iEW6Pkordod2i6LBbU+ZMv441nhAYTeGthf5zqx+GrrCLDgKPdedT/TKV96Fd
         EZROA6843YMsm/Dqbj73zJ4swZLAtmVaKlRauotLmuM7mS3BjatMFz+398ElS+IN3COZ
         kRH7tsUkj6o/9Jt33jPf+svoQJsTp+PlfCCLjhjNHhla0LGIuY4cMKCv6PAIdKC4QS/X
         WdAW3+mi1hO8z6R054eWa+7+q89yYcfIiXMJzUxSQX8A2799aUmU/RywU6S9e3ozFuG6
         CNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687510046; x=1690102046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zgp00NlD+EVH0cgqUIzV85S453hqNC2iv1Edy9sWKio=;
        b=evq0aKfH25HSDYgLFY6KnWcFbXppBAwNAgMF6PpAtcdMOHkNUEcAGqJI20EfF3E11V
         ZphlNPse1c/ffpyk8IC4JecRpLlz4UVGy+Hx/k+EG/cVlXsNOJHGNha+A7UN4DKJu1AY
         nt51cbLWRWeFOsmK/ARpCpQGrtXGmXcBLHF+SAHWdA5fVw0ZaCu8LMETB3MhB2KtFO+U
         2KYMe7KtIwVbYYmiAnrj6WnmQ2hzrygog3M+7+DGMD4ZkdLQa0P+sVMjvwPn5XZgLU4Z
         0CYBB1tIW5tJ1o8l+JYebVTmj/3992UXtnZ62/5sF+1THNu9FkzYkTV6fN4k74TgVxdO
         Z8jQ==
X-Gm-Message-State: AC+VfDyZM/Aj7Wt5R86YgMSC2yuv6AmE3imioH6h50XAfiuh0DEJOMZC
        B3jmwwtIgUtCrJv3RQ/dAbQFlw==
X-Google-Smtp-Source: ACHHUZ74UfgKgW2lZIORhVTJoclPhJFygYqnZlPQMpe7e3IX9OqatW8GHOrv6zwhoaYGzCxS3KueqA==
X-Received: by 2002:a17:907:7f9e:b0:987:605c:7c6a with SMTP id qk30-20020a1709077f9e00b00987605c7c6amr20368527ejc.36.1687510046582;
        Fri, 23 Jun 2023 01:47:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906660800b0096f7500502csm5836553ejp.199.2023.06.23.01.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:47:25 -0700 (PDT)
Message-ID: <5bcf1c7a-c5d6-67f6-ac81-b143af748fa6@linaro.org>
Date:   Fri, 23 Jun 2023 10:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: qcom,spi-geni-qcom: Add SPI
 device mode support for GENI based QuPv3
Content-Language: en-US
To:     Praveen Talari <quic_ptalari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
References: <20230622135955.941-1-quic_ptalari@quicinc.com>
 <20230622135955.941-3-quic_ptalari@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622135955.941-3-quic_ptalari@quicinc.com>
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

On 22/06/2023 15:59, Praveen Talari wrote:
> Add a property to configure QUPv3 SE as SPI Device mode.
> 
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
> v2 -> v3:
> - modified commit message to use device mode instead of slave mode
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> index 2e20ca313ec1..5c7d0293bbf7 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> @@ -66,6 +66,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  qcom,slv-ctrl:
> +    description: configure QUPv3 SE as Device mode

There is already property for this. Look at spi-controller.yaml. If it
is not enough, explain WHY.

Best regards,
Krzysztof

