Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8B6568B3
	for <lists+linux-spi@lfdr.de>; Tue, 27 Dec 2022 10:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiL0JG4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Dec 2022 04:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiL0JGx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Dec 2022 04:06:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC56588
        for <linux-spi@vger.kernel.org>; Tue, 27 Dec 2022 01:06:51 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f34so18787554lfv.10
        for <linux-spi@vger.kernel.org>; Tue, 27 Dec 2022 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wgi2g1n+nHbhC11kGT7UTTZnfTwUqhX8cOYNVdVe7V4=;
        b=ClgKJTw7Bl1MJuZRI2HiZuLxT12iHsCqWSjsVVeX3rxiZs1D/Gn9scVdPi+/1yPL1R
         1WrifslyTd0mTUXpqEgdVpAlvre9OhKExBdsih4pp36ofbQplLhQ/+sC09j+WY/dsLo8
         ziglLCPyVN+HzBm0v+CyXJJcH6WIN8eQLO+W+3hJtz6oWkWvyLsuq/CQtBZSnMfApMJg
         l3zofTkWFudPF7ee8VCQHnlzFjVRVWkWN7OvQx/kw0fTCTMieS1jCgboKO7gtWWSaXLs
         LXQ1wAOxVdrVAg9p64mlvxixNn5dPOf+9b4b+Okmb9jTjy8pdc/pbVpq03bun23rFKmy
         ZgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgi2g1n+nHbhC11kGT7UTTZnfTwUqhX8cOYNVdVe7V4=;
        b=r1MGNW//HkCtVUMPEGyAhh+X0dAEfRTk/VVg30+rZSSa7WuLhn4M8Xq8fLdN3arMyX
         ogW1F6paNHjsUbE+2zpw7r9NyNCd9172JpyU4dGh9Olv9rCyJu8Qdxtw+qY6I8fCoDN0
         pcEpP/auTBcVAkZSfa4HC6j6TYZAA/xOQsEu6Zh1udwyhRWpWml0U7aCptl2qh1tQHKp
         JcN4rkapcpiDI4IFVfzqA5loc9E0mBIzF0hjCFGNENqP+KW7EL7L9hpT39r4orrQjZqE
         cCN/WhUgL16UOlWtKqocEFpav/0japT/Hs+rIAGrQYnZ+fRg+zmIk5lcSLtAGz2l5aGr
         vKQA==
X-Gm-Message-State: AFqh2kr3vOo0uxhL/0XHA3Oksp6w44Zwf1br780DwVHQue3rxAn3T2Ui
        XxVCNmhWjKg4NZtT+hfelp6zTA==
X-Google-Smtp-Source: AMrXdXu1DnHOT4QXJVWjYcj4KtoF8psUezFfIbrl97/RFTeb/sMUQipRBAEYDiflVCFEvtZSvjhcVw==
X-Received: by 2002:a05:6512:169e:b0:4ca:fa2d:2686 with SMTP id bu30-20020a056512169e00b004cafa2d2686mr3993709lfb.35.1672132008806;
        Tue, 27 Dec 2022 01:06:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z5-20020ac24f85000000b004b5480edf67sm2162766lfs.36.2022.12.27.01.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:06:48 -0800 (PST)
Message-ID: <2d62f33e-69d4-064c-f226-2d38396f0e9e@linaro.org>
Date:   Tue, 27 Dec 2022 10:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] memory: renesas-rpc-if: Rebind fixes and misc
 cleanups
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1669213027.git.geert+renesas@glider.be>
 <167213158107.15520.15699943919910529014.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167213158107.15520.15699943919910529014.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/12/2022 09:59, Krzysztof Kozlowski wrote:
> On Wed, 23 Nov 2022 15:41:16 +0100, Geert Uytterhoeven wrote:
>> 	Hi all,
>>
>> The Renesas RPC-IF provides either HyperFlash or SPI host access.
>> To handle this, three drivers are used:
>>   1. The RPC-IF core diver,
>>   2. An HyperFlash child driver,
>>   3. An SPI child driver.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/6] memory: renesas-rpc-if: Split-off private data from struct rpcif
>       https://git.kernel.org/krzk/linux-mem-ctrl/c/f8fa9cb3fb16e06514fec0bac58996015dedc453

Missing checkpatch. I corrected now:
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1>
("<title line>")' - ie: 'Fixes: ca7d8b980b67 ("memory: add Renesas
RPC-IF driver")'


Best regards,
Krzysztof

