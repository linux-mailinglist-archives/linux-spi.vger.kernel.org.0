Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671A5E9CC8
	for <lists+linux-spi@lfdr.de>; Mon, 26 Sep 2022 11:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiIZJCF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 05:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiIZJBh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 05:01:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4281D3F1ED
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 02:01:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k10so9779688lfm.4
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1YIkQh6EoBkOuxOCzgI3t385pFWOcemUGZ5titnY28I=;
        b=mNnIdQUAvC8xMLnw6y7rxl4Q0Xe4xkNX229EecK1KJhgEGEelhvP+ssi5124OO6C97
         4BvLvcYr/Vtk77T0LacYX7TAXWz8URQF4wU+23TyMboIr0PSvddcEr6Hsc9np1cH8LoK
         SEXVjzKvNbxhJEWKaCNfCJvcn6w++Dqq28CvNUgM+Zs/kCL/kvIpoB2fCP6YSa6gKz2c
         Ijz3fRbf7CeczLcgqYSjUeKgyv5YpRjRqUDWln47Y9IW5gVgFjEiZyiqH4+Amxq1aRfB
         l0ufNKsC2vv4hyUMJu3V1c3+D+Fvut+x9rMz8OIFsrMSkKlKv/w50UH0SPCf5FxjsHvo
         urrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1YIkQh6EoBkOuxOCzgI3t385pFWOcemUGZ5titnY28I=;
        b=6HzucvDDulA+yb165za2MG4pKJZNCR7th7Jo7AYimSiVJtwdBAPk3pObEv7jQBSoBj
         NZ+JDDqGyNjtnaS9ZeXhsjWvKhH2ic6glwd1cNXy3ADCwJxeDnZXCFYAlZC/BB3x2Z+5
         wAN0FQbLJPPH1+oqwhgrUXzTZGrQPz4SULVHE8oBNl1aPgSdXCXWwUeiRViyeD0fQXwm
         FHz3WTztOlUsdNw1GE9N7HtaxvMwKvfGsdr/M3tnqNZZ8SuBnSmJZh+1C8iBmWwxrGkk
         x+i/t5s6fiFjyuxzAHZh4u7M6dklbRPC5NPzj/aMO3h+67PKzlQx8At5SI1/4qnDG4hE
         bdmQ==
X-Gm-Message-State: ACrzQf333x/IdBhpQtlapXF2QpaQhu7hd3NjJAWYTNUNvVVj+xIhJsUN
        90T/TLyly2bNvcGtQLUFgE6pCQ==
X-Google-Smtp-Source: AMsMyM4NMCbfNca19c+S2SFzmkji42Sj5zUFCNk62dA4ymhkBx29a6yBnY2hmEpbVNjyPJRM9fe4pg==
X-Received: by 2002:a05:6512:3e17:b0:49d:9fd5:da61 with SMTP id i23-20020a0565123e1700b0049d9fd5da61mr9029683lfv.270.1664182893504;
        Mon, 26 Sep 2022 02:01:33 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm2469120lfq.207.2022.09.26.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 02:01:32 -0700 (PDT)
Message-ID: <8c16fdda-6cc7-998b-882c-f52bd9813aaa@linaro.org>
Date:   Mon, 26 Sep 2022 11:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RESEND PATCH v3 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add
 support for Xilinx Versal QSPI
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     akumarma@amd.com, git@amd.com, michal.simek@xilinx.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        amit.kumar-mahapatra@amd.com
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
 <20220926063327.20753-7-amit.kumar-mahapatra@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926063327.20753-7-amit.kumar-mahapatra@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26/09/2022 08:33, Amit Kumar Mahapatra wrote:
> Add new compatible to support QSPI controller on Xilinx Versal SoCs.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

This is still not fixed.

> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index fafde1c06be6..5ed651084896 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -14,7 +14,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: xlnx,zynqmp-qspi-1.0
> +    enum:
> +      - xlnx,versal-qspi-1.0
> +      - xlnx,zynqmp-qspi-1.0

With fixed subject:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

