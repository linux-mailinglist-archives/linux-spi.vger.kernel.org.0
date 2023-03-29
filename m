Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD27C6CD408
	for <lists+linux-spi@lfdr.de>; Wed, 29 Mar 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC2IHz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Mar 2023 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC2IHy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Mar 2023 04:07:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785933A86
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 01:07:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t14so15201174ljd.5
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KifxtcvbarKwRyuhr/Ufg1uKerUmicIF2vvptJLaYI=;
        b=ZXyHG4l1WqIzWxT8epXnTXnuCvJZXDvD+/2fWHMq2KM5Z0Vd5HWIgmlEoMbvNAjtbc
         A24d/WV0DRlI0ER+hwAHxQEeezwJTQk6dhdJAdpiYUxBPRL2zC9myFyO00wPrp1CoNVx
         w5p265Awmjeqln/IV/u2IJeFCgE27v7CnJJEWWyM4WJAXBrHZHUkmI7NiQsPPRteBFO3
         qO/h8XmwwQKHnRPASg3Y+RfTu6AWHhtxXrSwzLhFlyPhTMLv+JzBVL4hvc99O9eOOhMA
         q1xTMYmCHP2+xnmXj/gnPM52A87Nbg4h8yWXD+uEeQLHF509zZ2TXRA8PeZDTSG8L+jJ
         AbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KifxtcvbarKwRyuhr/Ufg1uKerUmicIF2vvptJLaYI=;
        b=npx2Nva0KUbj7AhIr4GuuO7TDiaOj83LENQccTlYVFNhWKCVSDjII6smumpL+uVpXD
         GHrqTtFuRZX9wg2/0aPg7PKxhodfT+ROXEaVNkdCmSS1OSgHVWvwoGfJkr/BVNLDP3CR
         29UmvVwoNLTQn9lHeLwzq53QbUp7Vvtp3aTYEavxuUTGO48yVUp7/fOtDXc/mAUeCjjT
         /55D7WTEMqJKcbFp0K+3uhBonz3zwevOfMB+wlbq8VjOnR7jUSnHoRW/zQI6Qf6MKDo6
         Q2Lx41oemeDtTLjhxhy20uGcl4wsRQXXUgCtVysR3rzZyHMgE2uOPrEHJF7++Uc3hb4Z
         F+8Q==
X-Gm-Message-State: AAQBX9dRcpnqIo2NecfSiGuRsTHOG1TaUnplQFHXNm7hnLzgZvs77IXr
        N8kp36D7pQllPouIwSm+XlSiHA==
X-Google-Smtp-Source: AKy350bMTcCNWTcZWOOrCYdOk1J64lvJehoM/rLLd6gzi5zzF4F09iNN1/n6D4V7bZFsYSBKVEFn0g==
X-Received: by 2002:a05:651c:446:b0:29c:88a7:9a96 with SMTP id g6-20020a05651c044600b0029c88a79a96mr6212076ljg.46.1680077270753;
        Wed, 29 Mar 2023 01:07:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e95d6000000b0029bfcbeac09sm4513572ljh.41.2023.03.29.01.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:07:50 -0700 (PDT)
Message-ID: <e9b1b899-9f19-0abd-8e20-fc486bf28b17@linaro.org>
Date:   Wed, 29 Mar 2023 10:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/2] spi: loongson: add bus driver for the loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328113536.ldxpvx3hibezcqtb@intel.intel>
 <253f3bf2-a193-69da-79ef-c3771d677478@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <253f3bf2-a193-69da-79ef-c3771d677478@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/03/2023 13:53, zhuyinbo wrote:
> 
> 
> 在 2023/3/28 下午7:35, Andi Shyti 写道:
>> Hi Yinbo,
>>
>> before submitting the patches for review... can you please run
>> checkpatch.pl on them?
> yes, I had used checkpatch.pl to check and no any errors and warnings.
> 
> user@user-pc:~/workspace/test/code/www.kernel.org/linux$ 
> ./scripts/checkpatch.pl *.patch
> -----------------------
> 0000-cover-letter.patch
> -----------------------
> total: 0 errors, 0 warnings, 0 lines checked
> 
> 0000-cover-letter.patch has no obvious style problems and is ready for 
> submission.
> -------------------------------------------
> 0001-dt-bindings-spi-add-loongson-spi.patch
> -------------------------------------------
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> total: 0 errors, 0 warnings, 55 lines checked
> 
> 0001-dt-bindings-spi-add-loongson-spi.patch has no obvious style 
> problems and is ready for submission.
> ---------------------------------------------------------------
> 0002-spi-loongson-add-bus-driver-for-the-loongson-spi-con.patch
> ---------------------------------------------------------------
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'
> Traceback (most recent call last):
>    File "scripts/spdxcheck.py", line 6, in <module>
>      from ply import lex, yacc
> ModuleNotFoundError: No module named 'ply'

You have errors here... Fix your setup for spdx check.

Best regards,
Krzysztof

