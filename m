Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC70257F184
	for <lists+linux-spi@lfdr.de>; Sat, 23 Jul 2022 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiGWUtb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Jul 2022 16:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiGWUtb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Jul 2022 16:49:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306641D300
        for <linux-spi@vger.kernel.org>; Sat, 23 Jul 2022 13:49:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso6944297pjq.1
        for <linux-spi@vger.kernel.org>; Sat, 23 Jul 2022 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sudomaker-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4PnudIAj6MuFcPE4enLHz/xhLEoYtTm/viKNsN2ycOQ=;
        b=RUhsyiy86LH9Fm86MMdX9+B8SK2E9S8eT8i1KfIYzf/FcYPmfwOR1meXyixhSn3pWv
         Fl9H9ITkukRQhP9rlaxmWmzjIMVlMIA/B77ZkT34OAbixPajEDk4E/I358PBE8emWgeN
         +5VAPbl2VPyeXncpjZFS46/SlsM8d08OARVmsBEsYO9WjEv9vCwVecEjPTLr0gtKYhl2
         FfJnDq2ny/F3Gw0sOV9AEwpnaXaMIAO/h3/wxvxi7599MnKcthlj1QltFkdTJaVqSHlr
         poFFq689alMWoAoYcrOCddNIFIhlx7zxrJOEoiPItcsT5ea6vA3TeWIPACcinpGaVzHc
         zj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4PnudIAj6MuFcPE4enLHz/xhLEoYtTm/viKNsN2ycOQ=;
        b=AIu2jDK4q6jeVhAfRBOG/8Ccjgplqi6Avu9LN15fsv2HfkNCj8xvYM8W9413jD6wnV
         Vz1B7cBQG06iJLDftLJfQSU/WlIjJrf43ZyhNLMo61y2zzi/nXDnaffPCgp3BXsmwPe4
         tCgpXGP47Xw3czQt776Qt5dZnKVx7L88+rUPukKFkWHHagcrB1siLI/0Gc2GEJ9RMPlP
         G3MMXTBvELzNw4K5n8bz9rJ1Z83r9fIM525YdNijq1QJP3mvErGN59Ut5dl3IIGZbX6b
         kNapYxTLivl0Avl/Qwdk2vl9kPQP9SmxR9iocJfmuDT8TrJn7/i4Wy/hsDkiQLlQ2tDa
         Q/ZQ==
X-Gm-Message-State: AJIora80bU90Vgqtud1MEPCaQODHlj4XyI3BO5oZi6QMGxEPyRzN30AA
        KruMnVzCq/zqGwfDBhEvPMZg/A==
X-Google-Smtp-Source: AGRyM1sDNnQZWu+UZjw5MifNt4gL7DYaw4qlXqueCC3LFS/ZmtN+HdmjySKcbm4UciQi96Hckb6vDw==
X-Received: by 2002:a17:90b:38c2:b0:1f0:59c0:55c with SMTP id nn2-20020a17090b38c200b001f059c0055cmr6675051pjb.166.1658609369617;
        Sat, 23 Jul 2022 13:49:29 -0700 (PDT)
Received: from [172.16.24.11] ([188.214.106.178])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a3f0800b001ef9479373fsm7974276pjc.4.2022.07.23.13.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 13:49:29 -0700 (PDT)
Message-ID: <b52a8e97-3b8e-c67b-4440-2d7428edb4fa@sudomaker.com>
Date:   Sun, 24 Jul 2022 04:49:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
 <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
 <d1a0dd15-3621-14e9-b931-417cefaab017@linaro.org>
 <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
 <YtxLoPOykLDTzTn9@sirena.org.uk>
 <f05045fa-9ecd-d312-0eaa-5d19498453fc@linaro.org>
From:   Mike Yang <reimu@sudomaker.com>
In-Reply-To: <f05045fa-9ecd-d312-0eaa-5d19498453fc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/24/22 04:07, Krzysztof Kozlowski wrote:
> On 23/07/2022 21:27, Mark Brown wrote:
>> On Sun, Jul 24, 2022 at 02:47:14AM +0800, Mike Yang wrote:
>>> On 7/24/22 01:43, Krzysztof Kozlowski wrote:
>>>> On 23/07/2022 18:50, Zhou Yanjie wrote:
>>
>>>>> No offense, does it really need to be named that way?
>>>>> I can't seem to find documentation with instructions on this :(
>>
>> ...
>>
>>>> All bindings are to follow this rule, so I don't understand why you
>>>> think it is an exception for you?
>>
>>> Zhou didn't ask you to make an exception. They have a valid
>>> point and they're asking why.
>>
>>> You may want to avoid further incidents of this kind by stop
>>> being bossy and actually writing a guideline of naming these
>>> .yaml files and publish it somewhere online.
>>
>> Yeah, I do have to say that I was also completely unaware that
>> there was any enforced convention here.
> 
> Indeed, it's not a enforced pattern. But there are many other
> insignificant ones which we also tend to forget during review, like
> using words "Device Tree bindings" in title or using unnecessary quotes
> around "refs" (also in ID of schema). It's not a big deal, but I ask
> when I notice it.

Good. Thanks for paying attention to these details.


>> Zhou already mentioned he was unable find the naming guidelines of these .yaml files.
>>
>> Apparently you think it's unacceptable for new contributors of a certain subsystem to use existing code as examples, and/or they're responsible for figuring out what's a good example and what's a bad one in the existing codebase.
> 
> It's everywhere in the kernel, what can I say? If you copy existing
> code, you might copy poor code...

Still, it shouldn't be a responsibility of new contributors to determine the quality of an existing piece of code, unless there are clear guidelines (i.e. one should use the new "cs-gpios" attribute in SPI controllers).

> 
>>
>>>
>>> It might never grow to new devices (because they might be different), so
>>> that is not really an argument.
>>
>> It is an argument. A very valid one.
>>
>> "they *might* be different". You may want to get your hands on real hardware and try another word. Or at least read the datasheets instead of believing your imagination.
>>
>> I would enjoy duplicating the st,stm32-spi.yaml into st,stm32{f,h}{0..7}-spi.yaml if I'm bored at a Sunday afternoon.
>>
>>>
>>> All bindings are to follow this rule, so I don't understand why you
>>> think it is an exception for you?
>>
>> Zhou didn't ask you to make an exception. They have a valid point and they're asking why.
> 
> Hm, everyone has the same valid point and such recommendation is to
> everyone, although it is nothing serious.
> 
>> You may want to avoid further incidents of this kind by stop being bossy and actually writing a guideline of naming these .yaml files and publish it somewhere online.
> 
> I did not see any incident here... Process of review includes comments
> and there is nothing bad happening when you receive a comment. No
> incident...


Okay. After careful inspection of the Ingenic datasheets, now I have the conclusion: The Ingenic X1000, X1021, X1500, X1501, X1520, X1600, X1800, X1830, X2000, X2100, X2500 have the same SFC controller.

X1600 has a newer version (let's say v2) of the SFC, and X2000-2500 have v3. Others have the original version (let's say v1). Each new version introduced new features such as arbitrary DMA sizes, and the rest features are the same.


So IMO the name "ingenic,sfc.yaml" is perfectly logical.


Regards,
Mike Yang
