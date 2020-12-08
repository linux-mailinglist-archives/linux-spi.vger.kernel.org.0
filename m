Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2222D2D84
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgLHOtU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 09:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgLHOtU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Dec 2020 09:49:20 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C8C061749;
        Tue,  8 Dec 2020 06:48:39 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id m12so1857625lfo.7;
        Tue, 08 Dec 2020 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TbXfHgxRABflLP1aC/6ag0TWl+8h0+26/ihPZ9uTfG4=;
        b=DPkyVmkYD3U8jD+HGG+sE+g3Xr2g/0yos9wjbEsIX6f7G8S6/0WQg2U7ZGnb3t7lWz
         Fw1uHnvj//DvybNt6zNicp5Ayxnw2Xfq9zi1+mvji4J5fpB2DutNRNOcwL/ADl6nyLHo
         umR0Rn1QEqrREkrUOGkVTn2WiLFsM+lqgeQTw3SOu9prkJZ0bbjJJ+QLD9N9vX5fiAYZ
         ohUE8AQLku+GeglsYdjMc4C/Y4WxX6c1Hsbf9jmxjQXQOseauw+NiWvMXWK9KyYmdc2s
         7ZzWdpbnh4QWYWH3ofPA3IlMHW3jK+GSQ9TtO8Nh/knjmakm5tNG8GUguFRHPG8Ip5OJ
         yqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TbXfHgxRABflLP1aC/6ag0TWl+8h0+26/ihPZ9uTfG4=;
        b=Jfxsniqa/Te9EDJ1kFfvl589LWIPJahLYma6Os+oht1z4hs5CnseXSvELACDZJwnU1
         df+bEHr8GQMWjiIVkBn/cnWzYWmiqt13Pguwua0Yxvn4QwrLJXyB+HIHqlf2Nxj1RvyE
         HFZs9e9y21kHmVXPUX8UGsJ+H1Bv2k5fSBVV9211c2ikvne8Mnv//xtQypCBrp/9Oq8Q
         B1XyGCvwJMTLSIbmPcC2Hl1EqOurYkMPNPty2wNpusg//aUJDabEiZ2qJtUYQaL3vfgc
         88AYMrbYab3Ms4WYrXLf5HWsNvREvSSNRVA+y3mALxyMi87wsBr8HetB5K21kGFDT+TO
         TqlQ==
X-Gm-Message-State: AOAM5316lSgQArHj1JdhcroOesujNT1zc8HEOyqqpCcJ5gCCIWWXgIFX
        poqmppaIHakL/klnkCrjuXM=
X-Google-Smtp-Source: ABdhPJy3Y9GsHjwafVrirEQqqVcM4uxApG7yx0gtOT23hD3l4ZG9h642ENbAdUhyWVZYBEmVeQK9/A==
X-Received: by 2002:a19:750e:: with SMTP id y14mr10536900lfe.417.1607438918236;
        Tue, 08 Dec 2020 06:48:38 -0800 (PST)
Received: from [192.168.1.101] ([178.176.78.77])
        by smtp.gmail.com with ESMTPSA id i5sm3218451lfl.53.2020.12.08.06.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:48:37 -0800 (PST)
Subject: Re: [PATCH v2 2/4] spi: Add devicetree bindings documentation for
 Loongson SPI
To:     zhangqing <zhangqing@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
 <b97c4d59-3279-f67d-d951-1e9436faa640@gmail.com>
 <20e7dafc-8c67-79e4-e64a-a08e21101678@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <3f5a7d26-e78a-b02e-5fc2-c241547c683d@gmail.com>
Date:   Tue, 8 Dec 2020 17:48:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20e7dafc-8c67-79e4-e64a-a08e21101678@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/8/20 1:47 PM, zhangqing wrote:

>>> Add spi-ls7a binding documentation.
>>>
>>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>> ---
>>>   Documentation/devicetree/bindings/spi/spi-ls7a.txt | 31 ++++++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-ls7a.txt b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>> new file mode 100644
>>> index 0000000..56247b5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
>>> @@ -0,0 +1,31 @@
>>> +Binding for LOONGSON LS7A SPI controller
>>> +
>>> +Required properties:
>>> +- compatible: should be "pci0014,7a0b.0","pci0014,7a0b","pciclass088000","pciclass0880".
>>> +- reg: reference IEEE Std 1275-1994.
>>> +- #address-cells: <1>, as required by generic SPI binding.
>>> +- #size-cells: <0>, also as required by generic SPI binding.
>>> +- #interrupts: No hardware interrupt.
>>
>>    You say it's a required prop, yet yuoe example doesn't have it...
>         I want to emphasize here that LS7A SPI has no hardware interrupts, and DT is not actually used.

   The why document the property at all?

>>> +
>>> +Child nodes as per the generic SPI binding.
>>> +
>>> +Example:
>>> +
>>> +            spi@16,0 {
>>> +                compatible = "pci0014,7a0b.0",
>>> +                        "pci0014,7a0b",
>>> +                        "pciclass088000",
>>> +                        "pciclass0880";
>>> +
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +                reg = <0xb000 0x0 0x0 0x0 0x0>;
>>> +                num-chipselects = <0>;
>>> +                spiflash: s25fl016k@0 {
>>> +                #address-cells = <1>;
>>> +                #size-cells = <1>;
>>
>>    Once more?
>>
>>> +                compatible ="spansion,s25fl016k","jedec,spi-nor";
>>
>>    Once more?
>>
>>> + spi-max-frequency=<50000000>;
>>> +                reg=<0>;
>>
>>    Once more? Did you mean this for a child node?
>        Yes, these are child node attributes, the child node splash is not necessary.

   You should indent the child nodes with 1 more tab...

>>
>>> +                };
>>> +            };
>>
>      Thanks
> 
>      -Qing

MBR, Sergei
