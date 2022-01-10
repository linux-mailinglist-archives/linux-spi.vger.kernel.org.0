Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C0489CC6
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jan 2022 16:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiAJPwM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jan 2022 10:52:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53854
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236597AbiAJPwL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jan 2022 10:52:11 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 51D60402EA
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641829924;
        bh=iUbc2225sHL409tzMmk18pI3oO3B0WnnIcpSV9T1raw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hik+0GV64V+s05F1kroGBoRaLMA0vMjgqjArJgLUS2DRFQiVM9+PwX0JLXb1o8QhY
         02Z8mAg4mBCUtCTmw+CQMk0HTCXlI6i1QUmdg8LOiKKtFEOwdYEAts9T44uyopmzmF
         IU06DamHVfyPt0PA6aa8VSQ99myp+bFPpUFeQ4UbonT9N5gZCBYInc1y4hvEMDvULn
         AMXg/CFnt2AtWZHahjI3cD3+XVVXGSwGkxwJMlNRL5rDs5DZowMWUSVJP/C32dJ9KB
         NFsB79LRFIQwkaCQelWXRD77vRXzQuD8hfOzctelHWi219sByJxRRs6Z2FAuuMlp0K
         bXDG3jwnatJxg==
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso10469943edd.22
        for <linux-spi@vger.kernel.org>; Mon, 10 Jan 2022 07:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iUbc2225sHL409tzMmk18pI3oO3B0WnnIcpSV9T1raw=;
        b=cDApVBgX+KQiCg7zHj7shidogF+vn3vlD6//ameHqpbGJoRkJq4UKu4LKuFhJSCISA
         jhTfkM6/yGe2dYAJUhuJgNBpR9Nva16w76zZ97SZKqgcCDSir3VvEYhy2gRH0QKJ/T9M
         YE3qADrf0gexbHMLf3gkYiznE/adD/gv6iu+LIfWIgPGelXhY4yjECz8VF7AL8WpcEaL
         QePo8YV3HktPHkiDkb0ej/BBT0dk7PcztCeOM6QBMRVem2djRiBctsUMqTRkOgPuToiU
         K65LIjbmvyOoevPoNhj+U9H5ZYH/XDwLwxxgK2H8g0PbXTVykSIXpUhi2j5BUGtZXKkD
         U8cA==
X-Gm-Message-State: AOAM533c5z6A8Ubvp3dHP6qnxsv3wkrSbXDAZwlAVadheg4XuS7a3ynr
        rwDV/fnOiXX2bqDbs+Cm62mPldQ88TzJDGSPTu+tav2DP7cESTnKYvJJ5c5IIz9obUR/IcLOWQU
        7295t620SWRbNVqs24sa1MfEF9IHxK5AsEuIx9A==
X-Received: by 2002:a17:907:7f01:: with SMTP id qf1mr299185ejc.240.1641829923150;
        Mon, 10 Jan 2022 07:52:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypRW2ur8jgGc2HpZV9iQNIl6Dau4WPcjvnjXHXc/TAfUo+6gA72EUObWasGYZBY4yZRyH6Fw==
X-Received: by 2002:a17:907:7f01:: with SMTP id qf1mr299171ejc.240.1641829922925;
        Mon, 10 Jan 2022 07:52:02 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z10sm3786873edb.45.2022.01.10.07.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 07:52:02 -0800 (PST)
Message-ID: <4c92afa7-53e2-0243-e6b5-3e594cc6b2ca@canonical.com>
Date:   Mon, 10 Jan 2022 16:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] spi: dt-bindings: samsung: convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
 <20220102155807.42758-2-krzysztof.kozlowski@canonical.com>
 <YdR6BsyVaBnnFz7x@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YdR6BsyVaBnnFz7x@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/01/2022 17:47, Rob Herring wrote:
> On Sun, Jan 02, 2022 at 04:58:07PM +0100, Krzysztof Kozlowski wrote:
>> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
>> controller bindings to DT schema format
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../devicetree/bindings/spi/samsung,spi.yaml  | 220 ++++++++++++++++++
>>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ----------
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 221 insertions(+), 123 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
>> new file mode 100644
>> index 000000000000..195bfafe05fd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
>> @@ -0,0 +1,220 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/samsung,spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Samsung S3C/S5P/Exynos SoC SPI controller
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> +
>> +description:
>> +  All the SPI controller nodes should be represented in the aliases node using
>> +  the following format 'spi{n}' where n is a unique number for the alias.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - samsung,s3c2443-spi
>> +          - samsung,s3c6410-spi
>> +          - samsung,s5pv210-spi
>> +          - samsung,exynos5433-spi
>> +      - const: samsung,exynos7-spi
>> +        deprecated: true
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  cs-gpios: true
>> +
>> +  dmas:
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  no-cs-readback:
>> +    description:
>> +      The CS line is disconnected, therefore the device should not operate
>> +      based on CS signalling.
>> +    type: boolean
>> +
>> +  num-cs:
>> +    minimum: 1
>> +    maximum: 4
>> +    default: 1
>> +
>> +  samsung,spi-src-clk:
>> +    description:
>> +      If the spi controller includes a internal clock mux to select the clock
>> +      source for the spi bus clock, this property can be used to indicate the
>> +      clock to be used for driving the spi bus clock. If not specified, the
>> +      clock number 0 is used as default.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^.*@[0-9a-f]+$":
>> +    type: object
>> +
>> +    allOf:
>> +      - $ref: spi-peripheral-props.yaml
>> +
>> +    properties:
>> +      controller-data:
>> +        type: object
>> +        additionalProperties: false
>> +
>> +        properties:
>> +          samsung,spi-feedback-delay:
> 
> All this has to go in it's own schema which then needs to be added to 
> spi-peripheral-props.yaml.

OK

> 
>> +            description: |
>> +              The sampling phase shift to be applied on the miso line (to account
>> +              for any lag in the miso line). Valid values:
>> +               - 0: No phase shift.
>> +               - 1: 90 degree phase shift sampling.
>> +               - 2: 180 degree phase shift sampling.
>> +               - 3: 270 degree phase shift sampling.
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            enum: [0, 1, 2, 3]
>> +
>> +        required:
>> +          - samsung,spi-feedback-delay
>> +
>> +    required:
>> +      - controller-data
> 
> Not really great that this is required and there's not some default that 
> works.

I can make it optional with new kernel. I'll send a follow up patch for
this.

> 
>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - dmas
>> +  - dma-names
>> +  - interrupts
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: samsung,exynos5433-spi
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
>> +          maxItems: 3
>> +        clock-names:
>> +          items:
>> +            - const: spi
>> +            - enum:
>> +                - spi_busclk0
>> +                - spi_busclk1
>> +                - spi_busclk2
>> +                - spi_busclk3
>> +            - const: spi_ioclk
>> +    else:
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +        clock-names:
>> +          items:
>> +            - const: spi
>> +            - enum:
>> +                - spi_busclk0
>> +                - spi_busclk1
>> +                - spi_busclk2
>> +                - spi_busclk3
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/exynos5433.h>
>> +    #include <dt-bindings/clock/samsung,s2mps11.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    spi@14d30000 {
>> +        compatible = "samsung,exynos5433-spi";
>> +        reg = <0x14d30000 0x100>;
>> +        interrupts = <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
>> +        dmas = <&pdma0 11>, <&pdma0 10>;
>> +        dma-names = "tx", "rx";
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clocks = <&cmu_peric CLK_PCLK_SPI1>,
>> +                 <&cmu_peric CLK_SCLK_SPI1>,
>> +                 <&cmu_peric CLK_SCLK_IOCLK_SPI1>;
>> +        clock-names = "spi",
>> +                      "spi_busclk0",
>> +                      "spi_ioclk";
>> +        samsung,spi-src-clk = <0>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&spi1_bus>;
>> +        num-cs = <1>;
>> +
>> +        cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
>> +        status = "okay";
> 
> Don't need 'status' in examples.

Sure

> 
>> +        audio-codec@0 {
>> +            compatible = "wlf,wm5110";
>> +            reg = <0x0>;
>> +            spi-max-frequency = <20000000>;
>> +            interrupt-parent = <&gpa0>;
>> +            interrupts = <4 IRQ_TYPE_NONE>;
>> +            clocks = <&pmu_system_controller 0>,
>> +                     <&s2mps13_osc S2MPS11_CLK_BT>;
>> +            clock-names = "mclk1", "mclk2";
>> +
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            interrupt-controller;
>> +            #interrupt-cells = <2>;
>> +
>> +            wlf,micd-detect-debounce = <300>;
>> +            wlf,micd-bias-start-time = <0x1>;
>> +            wlf,micd-rate = <0x7>;
>> +            wlf,micd-dbtime = <0x2>;
>> +            wlf,micd-force-micbias;
>> +            wlf,micd-configs = <0x0 1 0>;
>> +            wlf,hpdet-channel = <1>;
>> +            wlf,gpsw = <0x1>;
>> +            wlf,inmode = <2 0 2 0>;
>> +
>> +            wlf,reset = <&gpc0 7 GPIO_ACTIVE_HIGH>;
>> +            wlf,ldoena = <&gpf0 0 GPIO_ACTIVE_HIGH>;
>> +
>> +            /* core supplies */
>> +            AVDD-supply = <&ldo18_reg>;
>> +            DBVDD1-supply = <&ldo18_reg>;
>> +            CPVDD-supply = <&ldo18_reg>;
>> +            DBVDD2-supply = <&ldo18_reg>;
>> +            DBVDD3-supply = <&ldo18_reg>;
>> +            SPKVDDL-supply = <&ldo18_reg>;
>> +            SPKVDDR-supply = <&ldo18_reg>;
>> +
>> +            controller-data {
> 
> The schema didn't get checked since spi-peripheral-props.yaml isn't 
> yet in my tree, but I'd expect this to be a warning. If not its schema 
> needs to be a bit stricter. The schema for "wlf,wm5110" will need to 
> reference spi-peripheral-props.yaml. (Actually, all SPI peripheral 
> device schemas will need a reference in theory, but really we only care 
> for devices used with controllers with extra properties). 

I did not see any warnings. I'll modify the wm5110.


Best regards,
Krzysztof
