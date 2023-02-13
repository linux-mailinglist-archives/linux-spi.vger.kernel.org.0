Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08B6942DD
	for <lists+linux-spi@lfdr.de>; Mon, 13 Feb 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBMKbW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Feb 2023 05:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBMKbV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Feb 2023 05:31:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1AEDBE3
        for <linux-spi@vger.kernel.org>; Mon, 13 Feb 2023 02:31:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a2so11618689wrd.6
        for <linux-spi@vger.kernel.org>; Mon, 13 Feb 2023 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSJxkHq1/+KN60z3aJ0f+o2Ykzd3sm8k0tBtf9FSMJE=;
        b=CKd+sBizFSNQ1+ZIn8g6A0LAK470iKiLyeyeQpcnR6bzhPWIgu4B4zYI6bwjso9iMF
         59mLEggSJYwJu/3t4b+5j6AZOZi/rh4PLHhDtgoJHJuFNFxE8dkQadBrt2q0bXyjVxeQ
         79GpyYWKP+lhozeZyc7wv9WrBdJQb98YyWBo1SH7gO1FxqxACC/cTStZBZWt9IemEqdi
         O/wLNSqinUtHEOTsoQoRjZ2s7uP1Wm52008X0Zf/80QR77a4p+p7WGVeeKyEP6sLLJS4
         y0K2Ax41Ml4Qj/VUaLt+rGOqzg5JzYi1SwixeiIE6+znKZrMoQKhsqTAbLO7GbVWC+Em
         rIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSJxkHq1/+KN60z3aJ0f+o2Ykzd3sm8k0tBtf9FSMJE=;
        b=w5r647sY4p+/Rzc2xKuUjnpNsOf1y5dOXwUfSYWud04B5KtfvrktllikyFj5a3LKiR
         hysOPr/YCCH0AqztLMNGl6oQ3BlKD2ROX/rJFEcgZlOaUmQNZ5i0A2c7mBxKW5O4Dt0J
         kCq/SGeT+IWb2zyQgqMiytOYUlOk+sbONtPqiYbKNc0UPeBdBHspRDYL7+1MViypK/3K
         ZCduWIwSrkidnpaXIYBHNcBgl1biIcrIsGtFSrQ11ezfiiBP5hjW4naOnSm93/EGmfqx
         rCLtUy2Eqs2gMSBHEy3roXKehRw8xvwZCdi9MGWdh2yHAOpxz9YSMooMjrIm2krXdHdg
         CDdA==
X-Gm-Message-State: AO0yUKUodGruhvvrdkJkUSncSlJffxPTMfFIzPIRemqcUrYtzcS3StAH
        JDLJwppuxMlq1UEPinfgxie+zQ==
X-Google-Smtp-Source: AK7set9j8KS4QQXEBoxZeDdEun+TnHWrN4d/TE+6xf2nqPRJUfN3Q/ADAMTx/jhK15FJvkzIt1BY5w==
X-Received: by 2002:a05:6000:1d2:b0:2bf:b661:87d9 with SMTP id t18-20020a05600001d200b002bfb66187d9mr19719073wrx.50.1676284278636;
        Mon, 13 Feb 2023 02:31:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p3-20020adff203000000b002c3f6d7d5fesm10261929wro.44.2023.02.13.02.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:31:18 -0800 (PST)
Message-ID: <7bc0971f-86c4-2fb7-2b47-6bee93c02921@linaro.org>
Date:   Mon, 13 Feb 2023 11:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: spi: conversion of spi-st-ssc into DT schema
 YAML
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230210101403.14609-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210101403.14609-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 10/02/2023 11:14, Alain Volmat wrote:
> File st,ssc-spi.yaml replaces spi-st-ssc.txt for the
> ST Microelectronics SSC SPI driver.

subject: spi: dt-bindings: spi-st-ssc: convert to DT schema

YAML is redundant, "conversion" of too long

> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../devicetree/bindings/spi/spi-st-ssc.txt    | 40 ------------
>  .../devicetree/bindings/spi/st,ssc-spi.yaml   | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 62 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-st-ssc.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-st-ssc.txt b/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
> deleted file mode 100644
> index 1bdc4709e474..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -STMicroelectronics SSC (SPI) Controller
> ----------------------------------------
> -
> -Required properties:
> -- compatible	: "st,comms-ssc4-spi"
> -- reg		: Offset and length of the device's register set
> -- interrupts	: The interrupt specifier
> -- clock-names	: Must contain "ssc"
> -- clocks	: Must contain an entry for each name in clock-names
> -		    See ../clk/*
> -- pinctrl-names	: Uses "default", can use "sleep" if provided
> -		    See ../pinctrl/pinctrl-bindings.txt
> -
> -Optional properties:
> -- cs-gpios	: List of GPIO chip selects
> -		    See ../spi/spi-bus.txt
> -
> -Child nodes represent devices on the SPI bus
> -  See ../spi/spi-bus.txt
> -
> -Example:
> -	spi@9840000 {
> -		compatible	= "st,comms-ssc4-spi";
> -		reg		= <0x9840000 0x110>;
> -		interrupts	= <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks		= <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> -		clock-names	= "ssc";
> -		pinctrl-0	= <&pinctrl_spi0_default>;
> -		pinctrl-names	= "default";
> -		cs-gpios	= <&pio17 5 0>;
> -		#address-cells	= <1>;
> -		#size-cells	= <0>;
> -
> -		st95hf@0{
> -			compatible		= "st,st95hf";
> -			reg			= <0>;
> -			spi-max-frequency	= <1000000>;
> -			interrupts		= <2 IRQ_TYPE_EDGE_FALLING>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/st,ssc-spi.yaml b/Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
> new file mode 100644
> index 000000000000..496118df3a1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/st,ssc-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics SSC SPI Controller
> +
> +description: |
> +  The STMicroelectronics SSC SPI controller can be found on STi platforms
> +  and it used to communicate with external devices using the
> +  Serial Peripheral Interface.
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    const: st,comms-ssc4-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: ssc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stih407-clks.h>
> +    spi@9840000 {
> +      compatible        = "st,comms-ssc4-spi";
> +      reg               = <0x9840000 0x110>;
> +      interrupts	= <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks		= <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +      clock-names	= "ssc";
> +      pinctrl-0         = <&pinctrl_spi0_default>;
> +      pinctrl-names	= "default";
> +      #address-cells	= <1>;
> +      #size-cells	= <0>;

Messed coding style. Only one space before =.


Best regards,
Krzysztof

