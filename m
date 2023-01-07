Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9DA660FF6
	for <lists+linux-spi@lfdr.de>; Sat,  7 Jan 2023 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjAGPcJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Jan 2023 10:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjAGPcI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Jan 2023 10:32:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63142612
        for <linux-spi@vger.kernel.org>; Sat,  7 Jan 2023 07:32:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso3083124wmb.0
        for <linux-spi@vger.kernel.org>; Sat, 07 Jan 2023 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHckjjOEvZSFADImnJ7KXWMu9c8067aGfxjgXUsE4X0=;
        b=XARL9Xw432069q9ug7AmT2ii/721KOOex76uOSQ5Ej91v8uVly0JvVpRHv+l42opvX
         oxLRgOTF6IfaMlvAE5ugFkDsciEL0LMmSkrPTiUueafFX43KPTtMnTAp/s2HnFvT9SRr
         YtF3U/D4hHQ1n7ZdGqeqtC+HD5MSlAiHIfTpTnro953jmyya2xBKkWxQFy/tuERmB7zR
         FpV8aHqVfYlMs5BIrWBX106lF+CSTZ29ieBT76WFbz/Z+bCuuNjToc2ihC8tkxpWcu09
         Zphue/rbHyxsRWyyqafC6IOIEVUE9G4HUjfjnl6FhiFjalXpgeM0BRjb5VoG9MtcY9HP
         vYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHckjjOEvZSFADImnJ7KXWMu9c8067aGfxjgXUsE4X0=;
        b=41CfIqzQaBP2LT3TH9NvS0un6E+A0EUMrcaBvoBHUay2td6A7+1tKWMnSDUgBvLa10
         y9j4aUJIyUpFbboX56takJdaJiX+1zA847OLBieuoG/suRRD9f8/UIjL+uS+/+Cb1fv4
         j6wTSMTA2YEWIXur7W9OnjkAWkKLmUBB0bOSNy9VUsVqRvHoK4THmAvgo7l5rOYJW8FR
         iMx3q1KtOCpzjl3wDLLrEinXsfKnEbukHm6Zy4Y73ixBakuGWXxLsUdnl39lrQhU24hY
         Oa1JTXVtIjlc/1Puw5MKUCCBkW6a2CZC/sWxhxwLrch1wP4J95dWLbSHZ8FhPplg2hIJ
         USuA==
X-Gm-Message-State: AFqh2krZrQ/zknlsH+b+B5H7xgwTO7ERXx2a5clcuRUYydQlkpTkT0Ne
        XvjH6UP91+Ph/p2V7ZacJmyBJlQLvQUO0E51
X-Google-Smtp-Source: AMrXdXvDiGSfEvCPjtCCxt7V6mSTslc3oth6qqA2ZR6xvpY8QqB8opH2ImO7Gq7PgtVhcK4ymxr99g==
X-Received: by 2002:a05:600c:1c27:b0:3cf:a83c:184a with SMTP id j39-20020a05600c1c2700b003cfa83c184amr43073046wms.24.1673105525806;
        Sat, 07 Jan 2023 07:32:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003d99a39b846sm6230720wmg.5.2023.01.07.07.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 07:32:05 -0800 (PST)
Message-ID: <0581eeed-f7d1-caf2-0dba-be14a01d7c05@linaro.org>
Date:   Sat, 7 Jan 2023 16:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/16] dt-bindings: spi: Convert bcm63xx-hsspi bindings to
 json-schema
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
 <20230106200809.330769-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106200809.330769-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/01/2023 21:07, William Zhang wrote:
> This is the preparation for updates on the bcm63xx hsspi driver. Convert
> the text based bindings to json-schema per new dts requirement.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 52 +++++++++++++++++++
>  .../bindings/spi/spi-bcm63xx-hsspi.txt        | 33 ------------
>  2 files changed, 52 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> new file mode 100644
> index 000000000000..45f1417b1213
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6328 High Speed SPI controller
> +
> +maintainers:
> +  - Jonas Gorski <jonas.gorski@gmail.com>
> +

Missing reference to spi-controller.

> +properties:
> +  compatible:
> +    const: brcm,bcm6328-hsspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: spi master reference clock
> +      - description: spi master pll clock
> +
> +  clock-names:
> +    items:
> +      - const: hsspi
> +      - const: pll
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

This is for cases when you have reference to other schema.


Best regards,
Krzysztof

