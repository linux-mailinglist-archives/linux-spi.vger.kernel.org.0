Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD74587959
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiHBIwb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiHBIw3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 04:52:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB6C4D82F
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 01:52:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d14so9106667lfl.13
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=knT0ECinn/m6w2BEuz2/Sg/bTHX6+lrKrNl6z+F0e74=;
        b=ccVwjvd4MzC8RU+3ZPKszG62Ts0L1PPfZ91GiS7jv/pOLh7SZ1+i3fv4h2W4a6M6S8
         H+nkkTfdw9+5W9p32NvgK33+ZkWrEFvPbJX0f8aCuGOzjW5jJ3E6GBlKCpm/9NMGnhdj
         eQ7CJL9iv27XMVrlpQRWErq0Aai6r4NR5eDfvlc7bnlllHoxfU4t/I7+HB7IKZACJej8
         OElb2muP3n8EC6KhzXAVpgVrd4S5q7UxnPWp3n/NeKxbjaKSJjZn2vGcYBwhtFkwDAr0
         r2+MZhiSZ3hHrnHwnpmaoz+qMN4pr3pYdt4aIWQky25a7DG1oi4n1H2qpjlzfwd0Nqcg
         HuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=knT0ECinn/m6w2BEuz2/Sg/bTHX6+lrKrNl6z+F0e74=;
        b=FOrVGbxlV8ktxS3iVtl5PNBps+DNTJVPy+eug8hGGgVaKd7Xcduzk88qRiT8WY6BOE
         PvrwL5HXVuoPXMPxej3GpAYiy875lP9BpuYDq4gPsJutd5AUTCqJ28tZLAYj+tCsZGkc
         n2WNXTAHJOwmAUaQgKbx462dJs12dvfBlnJV9DLuvIE2st7HapXbqzqg2DnU3Uap/2GV
         dCIsPcu4zwyHTbm8taidTICmWg+FAp9+O2Da0B9FLEYjhoIMjNy7v8mQjRjee4WXSpNB
         7/anMuVQWPdYKLx5YHh1u+sIMcBlwKI0WFDrHfbQbQGKqTeaSy7UMAAKNWOwxKrUCX/8
         DMMw==
X-Gm-Message-State: AJIora/l+SMKUwN2b2PWL8tDyJRljIpMYcA/qD27aPXRFBF49cnEGP8y
        JsqqQhFd4tBKCwILKtNcHK3fRw==
X-Google-Smtp-Source: AA6agR62WlBSkrJORHTxm7aZgTL1dgsS21XScJ7YMpkdZCsbnU764vazbV48+eOTpfzvf0SowIXRiw==
X-Received: by 2002:a05:6512:260e:b0:47d:ae43:62b3 with SMTP id bt14-20020a056512260e00b0047dae4362b3mr7890313lfb.77.1659430346950;
        Tue, 02 Aug 2022 01:52:26 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id g3-20020a2eb0c3000000b0025e5fd96bf6sm93509ljl.15.2022.08.02.01.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:52:26 -0700 (PDT)
Message-ID: <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
Date:   Tue, 2 Aug 2022 10:52:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801094255.664548-2-nagasuresh.relli@microchip.com>
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

On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:
> Add compatible string for Microchip CoreQSPI controller.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> ---
>  .../devicetree/bindings/spi/microchip,mpfs-spi.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> index 7326c0a28d16..b65f4e070796 100644
> --- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> @@ -14,9 +14,13 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - microchip,mpfs-spi
> -      - microchip,mpfs-qspi
> +    oneOf:
> +      - description: Microchip's Polarfire SoC SPI controller.
> +        const: microchip,mpfs-spi
> +      - description: Microchip's Polarfire SoC QSPI controller.

Useless descriptions - they repeat compatible. Just keep it as enum and
skip descriptions. What value do they bring?

> +        const: microchip,mpfs-qspi
> +      - description: Microchip's FPGA QSPI controller.
> +        const: microchip,coreqspi-rtl-v2

Best regards,
Krzysztof
