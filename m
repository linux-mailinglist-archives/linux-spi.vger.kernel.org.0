Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB31728156
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jun 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjFHN0v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Jun 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjFHN0t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Jun 2023 09:26:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC3173A
        for <linux-spi@vger.kernel.org>; Thu,  8 Jun 2023 06:26:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so1071519a12.2
        for <linux-spi@vger.kernel.org>; Thu, 08 Jun 2023 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686230806; x=1688822806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzWlAY0Wmvknnc3spmuP+VktzOnlDk3j1gTYnrGy5j0=;
        b=KOSqDLQoTv/GSUjQvSPW820R/w3aStZVHnoyaRmnOMIn18NbF/f78tTmqw8QL1v2gP
         5p3vfHbdDZUYDa/sGYQgaSa4D2v5dmxAxgqDVmJDASA5JaqL5mBih3pArZSNG62L0haJ
         HpRqFxZqUm4Xu6X8+olsiXkoaNECQbO6kJqZDfSCMyFtsWhYLLN0aEh6/Hqt5ZukESTc
         Ys5Xj1Gpt4Ci75Pfqc+sxDngrt6RBrEfIaBgC0PfuPUAmpn0wlDAlsYHTt6tzAHkb0lB
         bbn6E716hESmNIjeTU1TqQ2qY1dpBEqtt3dERKj2nK38QtbZdY8iUPU+ibhBt0ASjMGx
         Sp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230806; x=1688822806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzWlAY0Wmvknnc3spmuP+VktzOnlDk3j1gTYnrGy5j0=;
        b=UPSMGYF5zwz92IkkBfzJOZR1VBFV6vnfxmkvRgjPcOhddLMP3lYq8K103O3uov5RnF
         VM97WFF2cX/GI3I8/I9oiMDTVqKtUJtbCHrec5CDC4DnHte3ESHNoS8V6mtC/8ZHrB/X
         qxg1/mLKIJPLrceUmnv/74eQ6e1brQBhhvJjaPNE5RsdudaK1Me9mzAW6KButSTjeOzB
         n8c4QaQvYzsi1VIDAsOjgjuwNpkb6PVTd2xEGYAn4Bhlw1eiCrKReg0vkBXQAo2SCV8j
         V6GB45fOuFtgW21bodFNrbMro+YVUcjr80sbpgFR2e7MvJB7y/KnrfeURm8oE36pAZ4T
         L21A==
X-Gm-Message-State: AC+VfDwdoyOZclPZybX5JH0Ue5DnZ3Lr+4zYol4qUC9a6BvgZev1endL
        WVWsay7KVD+/XZVznPYI6EMsiQ==
X-Google-Smtp-Source: ACHHUZ7ne7JCY+VYzIO80nsZqHqRhnjE92GFb4pNM5AvSXrdGrAEanBKKnmEo+GRnqtD/ReuVDxz7A==
X-Received: by 2002:a17:907:16a5:b0:978:6be4:7efb with SMTP id hc37-20020a17090716a500b009786be47efbmr9925080ejc.7.1686230806449;
        Thu, 08 Jun 2023 06:26:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id dv26-20020a170906b81a00b00977cc84975fsm704390ejb.72.2023.06.08.06.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:26:46 -0700 (PDT)
Message-ID: <657f8d19-de83-8be6-4a9d-5f13b1df7383@linaro.org>
Date:   Thu, 8 Jun 2023 15:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
 <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
 <11ca2b90-544d-18c2-fb15-7909ca60507f@linaro.org>
 <f6d4ecb5-e9df-346e-4aab-772fd01689c8@loongson.cn>
 <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
 <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/06/2023 14:10, zhuyinbo wrote:
> 
> 
> 在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
>> On 08/06/2023 13:42, zhuyinbo wrote:
>>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>> @@ -16,6 +16,7 @@ properties:
>>>      compatible:
>>>        enum:
>>>          - loongson,ls2k1000-spi
>>> +      - loongson,ls2k0500-spi
>>
>> Aren't they compatible?
>>
> 
> 
> Are you saying that the spi driver is compatible with 2k0500 ?

Didn't you say this through 11 previous revisions?

> Yes.  and the 2k1000 spi hardware was same with 2k0500 common type spi
> hardware.
> 
> but afterwards, it may be necessary to implement a clock drvier for
> 2k0500, because the spi driver was use "devm_clk_get_optional()" to
> get clock and not use "of_property_read_u32(np, "clock-frequency",
> &clk)",  But this seems to have nothing to do with bindings.
>

Best regards,
Krzysztof

