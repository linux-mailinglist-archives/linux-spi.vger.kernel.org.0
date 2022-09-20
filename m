Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB15BE6CC
	for <lists+linux-spi@lfdr.de>; Tue, 20 Sep 2022 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiITNOQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Sep 2022 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITNOP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Sep 2022 09:14:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2B41D14
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:14:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so3751696lfr.2
        for <linux-spi@vger.kernel.org>; Tue, 20 Sep 2022 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oL59tr0awWBMQQ7MdT2iu2TE2VI5gvERY5RGWQ8WM3s=;
        b=mxz6GZ8cWdxNnHmr/C1CcStr5TApW9qzxYTgMGid4Zo7bKDcg6WqEg7/GamNbbCmGv
         M08DtbmL+wfAFiXvUpm0c/T9mJaSppe2IhkV+UAyoQaq8rW02A7Salcst/NT/ORlE8KH
         oepMZqQKc/gDKxormGyS4Q7l/1bv1VezZ95PTi9SpDFTyN+Sz+XYsAyYE8EXPnyRLUlY
         dJsA2/4UrQzhLNiAL6E3OrwRvWVU8L2IzH8ZLEjos9QaCjiBIWVN2sF/9EL9hGtw5YXO
         YFtkgms2kCWWc0lVvbFMIBVpjwcJ+hg3m7pPu0hwEQS9ijqQs3Pg8wfarGZx1OfnrO4g
         Ihsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oL59tr0awWBMQQ7MdT2iu2TE2VI5gvERY5RGWQ8WM3s=;
        b=CzJq0/GQnACuUVNZ4QQxBjIgS/ODT2EuaLGgCuVPb9mDY6UQIKButSXt3riD5AkJ6R
         53Fzk843GcjEWhb7m7D0UTZQLyuQf2l4cm6khKK+ikDJLE5gXYxEEI+zhd2mgCVGzV8S
         JT/yS9wvdHoxrabC242rvC+2CUZ4ZruuNw2/dZpuEzhG0f3B4zPW/rltJ0QuDDgXbg7r
         xux4p3svOntelghJywNcXb4V4sJ1Z0HopiDQCTrPX96EmdKD3/V/93X1yqx5PJC7Kwbw
         hscGD2Kfff17VI2BvH2o77xEv7pcXtj7XWp6eVTNeHX+kbRHIB1Cnvsn5w6ZX6xO+e1T
         Zbxw==
X-Gm-Message-State: ACrzQf1asrcRmOqiQLsCBbDbVoZKD3KoDgAZUb/6xBkQL4yHZ73h7Np4
        qJuYsnkmprSULt1aWibmVYecLVlP4nQ64w==
X-Google-Smtp-Source: AMsMyM6DYc81W/XjXllCftr3DA7y4IpZoBSQ0ex+EM68SsyRvAyesVM4UZsc5I9Y5NJ0r1MxjDu0UQ==
X-Received: by 2002:a05:6512:b1d:b0:49f:59da:c706 with SMTP id w29-20020a0565120b1d00b0049f59dac706mr6486162lfu.668.1663679650218;
        Tue, 20 Sep 2022 06:14:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a056512210300b00497aa190523sm304670lfr.248.2022.09.20.06.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:14:09 -0700 (PDT)
Message-ID: <89f06b43-6852-7b5b-f2c8-e53f353985db@linaro.org>
Date:   Tue, 20 Sep 2022 15:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] spi: s3c24xx: Switch to use devm_spi_alloc_master()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Cc:     broonie@kernel.org
References: <20220920114901.2683267-1-yangyingliang@huawei.com>
 <c3aaa5f5-327f-569c-4032-fe72e5dc5fbd@linaro.org>
 <c5802076-7fca-e470-c10d-21b3d5acdce4@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c5802076-7fca-e470-c10d-21b3d5acdce4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/09/2022 15:05, Yang Yingliang wrote:
> Hi,
> 
> On 2022/9/20 20:57, Krzysztof Kozlowski wrote:
>> On 20/09/2022 13:49, Yang Yingliang wrote:
>>> Switch to use devm_spi_alloc_master() to simpify error path.
>>>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> One more comment - the patch was not properly addressed.
>>
>> Use scripts/get_maintainers.pl to CC all maintainers and relevant
>> mailing lists.
> Do I need to resend it with CC all maintainers ?
> 

Resend? No. You need to send new version, with fix I asked for, Ccing
all necessary people and mailing lists.

Best regards,
Krzysztof
