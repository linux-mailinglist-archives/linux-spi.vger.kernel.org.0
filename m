Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B084F0AEB
	for <lists+linux-spi@lfdr.de>; Sun,  3 Apr 2022 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbiDCPvp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 3 Apr 2022 11:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiDCPvp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 3 Apr 2022 11:51:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30B3389E
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 08:49:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n6so1203835ejc.13
        for <linux-spi@vger.kernel.org>; Sun, 03 Apr 2022 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nl7mx8m7EnlbDwYYwvHzo6XZQrrQmR8xseakEJu/ApQ=;
        b=MAqUTVvxlESuAw6otRHcDSI7aSiMb/pzHxYyyc8ocwlSKeZ0QbusTy+3VVAT4PMjjZ
         r35T4x1/aKMCNukK3w5y4OjNLkM0JGY1j+bYY3bZiDiQBTONI3EcfWOlbKrHIEqQEpQm
         PulMplT17U+A4s8Q+qHr5FI/pw98uxA0mwdUGTLc3nomLuZLeeHl7TX+K04794pLORF+
         OHiLPHqoQ8zeryorwhj0pYSbudxizi0JyQik9ge8WsZmBPAgYW679WPOg3T1LhmTKCAq
         CiZapoJ1nG8IcKCUzTyQJocZdDtPgCWWrBCInKFEIy1voIhcjpOjGk3xCcCwsX+n1NoL
         GiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nl7mx8m7EnlbDwYYwvHzo6XZQrrQmR8xseakEJu/ApQ=;
        b=0uAxznARjgnu8YgNJnd/VRYmkRvOwqOrgXKsBrTlefRvpjloYRdMpGUqVVjWsq20BE
         PfawlGsvWPbJgSZqBVAA9bqwTdrsnGwMx41vKDi0GWRFjsd6pYS+NWJsXlCR2GICVUQZ
         Hqn1c1kxsx4YGl10pvK5aaRaXGU2mz9tWwjAEn0xPeORiRycXBp7UdC/JYSlbOmFYH+L
         em5A+ax0EGu0uYIDVHl6CI/XSiZuu+dgEGNUBrKvbHGzy0BYYkQ4U1M+VEYrathMM+S4
         tLqeqgQ5nluqU/HAkWQU7WnmYb6LxTAfPcEJDqopTKeSII7bn623L7VD0e+uh7lshgNT
         rtxw==
X-Gm-Message-State: AOAM533IxGpWJUeoFgHD7WZZeN1GbipWoED41/WR46YQWvssVhVmteNG
        DWy6IzoKEWRFAvourhpqVjbDgg==
X-Google-Smtp-Source: ABdhPJx3rcnv1yKUNSctVm5332uQ8CUzIarsgEIAO55wHKNgl2rFifkjJnDT+yD+tVwKZKX0hGsBGA==
X-Received: by 2002:a17:907:6d0a:b0:6db:f0f8:6528 with SMTP id sa10-20020a1709076d0a00b006dbf0f86528mr7426771ejc.466.1649000989905;
        Sun, 03 Apr 2022 08:49:49 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b006daa26de2fbsm3313742ejc.153.2022.04.03.08.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 08:49:49 -0700 (PDT)
Message-ID: <06ef6b4b-c8e8-549b-54be-9eecf59a7757@linaro.org>
Date:   Sun, 3 Apr 2022 17:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] dt-bindings: spi: add binding doc for spi-mtk-snfi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
References: <20220403131154.1267887-1-gch981213@gmail.com>
 <20220403131154.1267887-4-gch981213@gmail.com>
 <817dda10-39db-adfc-376d-a3d5e037937e@linaro.org>
 <CAJsYDVKYsz7c2yVe7TmPu_7kvBDXTih4+cceLsay2YJm21YntA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJsYDVKYsz7c2yVe7TmPu_7kvBDXTih4+cceLsay2YJm21YntA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03/04/2022 17:45, Chuanhong Guo wrote:
> Hi!
> 
> On Sun, Apr 3, 2022 at 11:37 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> [...]
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt7622-snand
>>> +      - mediatek,mt7629-snand
>>
>> One blank line, please.
> 
> I'll fix this in the next version.
> 
>>
>>> +  reg:
>>> +    items:
>>> +      - description: core registers
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description: NFI interrupt
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: clock used for the controller
>>> +      - description: clock used for the SPI bus
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: nfi_clk
>>> +      - const: pad_clk
>>> +
>>> +  ecc-engine:
>>
>> The nand-chip.yaml defines a nand-ecc-engine, so how about using that
>> one? I know mtk-nand.txt uses ecc-engine, but for new schema better to
>> use properties from existing YAML.
> 
> The ecc-engine code is shared between mtk_nand.c and this driver, and
> the property name is defined in the shared part. I left it as-is so that
> existing dt for mtk_nand doesn't break.

This can be easily fixed with:
	np = of_parse_phandle(of_node, "nand-ecc-engine", 0);
	if (!np) {
		/* Backwards compatible */
		np = of_parse_phandle(of_node, "ecc-engine", 0);
	}

I would like to avoid having one property in generic NAND schema and
keep adding something slightly different everywhere else.

Best regards,
Krzysztof
