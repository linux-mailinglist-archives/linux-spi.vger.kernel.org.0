Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E363BAEB
	for <lists+linux-spi@lfdr.de>; Tue, 29 Nov 2022 08:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK2HsE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Nov 2022 02:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiK2Hr6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Nov 2022 02:47:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAAB51C2F
        for <linux-spi@vger.kernel.org>; Mon, 28 Nov 2022 23:47:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so21231510lfk.0
        for <linux-spi@vger.kernel.org>; Mon, 28 Nov 2022 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etxMVrTTVJSTddGDgARHAHEO1RrGD5Hs7SuIw9ap/3I=;
        b=rJ2CHbAyVDgULRTpj4MDVg2dwBK1HADystIZFbvhbTYoLIME+/tt+UNXjiftguq7ib
         w244K+6QPoVERfMg79BoElJO38d82eLScZZat5sFVE49snZOfOK2/+f0fnJIKBPDeYwr
         FMbKUIjfcevvcaBgXAKIO3MbRsFR3P6ZtMV7rNa9PIY4woHjOWMCcZuqv4pX0tOMHtUg
         i6K9FHqMYrX/NmhNXcCLLkLhSjNQEx5ifmowHQHPkWFrl7Bjgf4qKioahqfbJwtbyu+O
         kUj+dvJ58qD1SX7rLqgkoUAxuWicMcWgz3BzKtCsL8WBGDD+0gJi4HnxuReDXO62n9lO
         ykmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etxMVrTTVJSTddGDgARHAHEO1RrGD5Hs7SuIw9ap/3I=;
        b=sN/LrrTYHQtICBM/qrRNA0N18Ul28NHN4652EGj87WvBQHF4ny00Y3528xjmTZQe1e
         A3LyRHKPeMUO9WLX2J8A7F2UUFK20q1ZzfR+sS3rWc6k+yyZTIioAb2kW4jcRoJYn0rH
         V0zDi3OaDGCo3glRAB94JuMZDkuv/bJtkYDE9yE6YpVkxLO/tqzW3yfIblaITt2LQr+V
         xi5V1W68nN0YVz3xaghWkAzbfX6lVSuS8a+h/xilasAOQE/bMS8y/ap/D21FUy/Bv0QX
         kwAzDa9EN4Ps0EyWAu+i8h8s+lWmuvwJdstIP2bFT7soygqOC0sjYRVMF1kxuEd7ztBt
         bcYQ==
X-Gm-Message-State: ANoB5pkfmhVLa7hT627jSJlPLDpasZhqu6JqIM+qDezUo05a+2Ndh0Ck
        2umVhwEKtqP9C4M3KGfbXzTMww==
X-Google-Smtp-Source: AA0mqf67TcbUg0koPs/HiroxNXgbbcwrSRcrk/nihBw0w3MO/AQgLVDwdMtZH+S68ivSZKmzzQx01Q==
X-Received: by 2002:a19:ae18:0:b0:4aa:c879:5bc with SMTP id f24-20020a19ae18000000b004aac87905bcmr12172113lfc.498.1669708074608;
        Mon, 28 Nov 2022 23:47:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k16-20020a0565123d9000b0049e9122bd1bsm2080686lfv.164.2022.11.28.23.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:47:54 -0800 (PST)
Message-ID: <e512b7fd-3404-3c2d-dbf6-dc66ee662a06@linaro.org>
Date:   Tue, 29 Nov 2022 08:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/9] dt-bindings: spi: mtk-snfi: add mt7986 IC snfi
 bindings
Content-Language: en-US
To:     =?UTF-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-6-xiangsheng.hou@mediatek.com>
 <8b8e4b23-a3bc-7e3d-199a-e8f591d05d71@linaro.org>
 <5f76482d33933c19e191ea618f8622cd0660597f.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5f76482d33933c19e191ea618f8622cd0660597f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/11/2022 03:50, Xiangsheng Hou (侯祥胜) wrote:
> Hi Krzysztof,
> 
> On Mon, 2022-11-28 at 10:00 +0100, Krzysztof Kozlowski wrote:
>> On 28/11/2022 03:06, Xiangsheng Hou wrote:
>>> 1. add mt7986 IC bindings
>>
>> Subject: drop second, redundant "bindings".
> Will be fixed in next series.
> 
>>>    clocks:
>>> +    minItems: 2
>>>      items:
>>>        - description: clock used for the controller
>>>        - description: clock used for the SPI bus
>>> +      - description: clock used for the AHB bus dma bus, this
>>> depends on
>>> +                     hardware design, so this is optional.
>>
>> Optional for which variants? For all of them?
> It`s only needed for the item 3 nfi_hclk. Is it proper with this
> description or any other suggestion.

I understand third clock is optional. For which variants/compatibles it
is optional? Add allOf:if:then restricting it.

Best regards,
Krzysztof

