Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF276B80E1
	for <lists+linux-spi@lfdr.de>; Mon, 13 Mar 2023 19:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCMSlK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Mar 2023 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCMSlI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Mar 2023 14:41:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0369A1A94A
        for <linux-spi@vger.kernel.org>; Mon, 13 Mar 2023 11:40:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd5so18682997edb.7
        for <linux-spi@vger.kernel.org>; Mon, 13 Mar 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678732787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zExCwPnErlKajEOP0iCBdbzhLSrwamo47isrOodA8E=;
        b=uIeD7q3LNKkRWYZ9x8e/DAt+K6iRlUftQBydBEx4UHpvBDJR0suSy6kKS6TldE9c34
         SmKeIpWFcWo2C4Q8oCZBpXd9MrPJICfDSlUXHnSWoW9QBQCzXO5kW1+Rc0/OzP7YdHjr
         YpKt/FL3vDjk59/IKcM3Hjl0tBFQXWnZfqUBKEkQplyCg9nu7co6+ODh1oOaxYAjiqhu
         oVN62b79jjOSFMcBGMCdjJVHqf4qucXnYktTu9HEOlEs5cv3IKf2DHByIFn2kf4CFeMG
         rqUkBqFdPK7U7r5Tw10fD7v2Zb+cJdcd3N7no0lHMaGkFh8m+9+A3aLpKVdabeeaNxqM
         ZFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678732787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zExCwPnErlKajEOP0iCBdbzhLSrwamo47isrOodA8E=;
        b=Jqapwu4XkApdC5xqDzcaO+d6ckq3SmeIRvUQAzYxgd9kY4ue5Ux6Yrty2JKtrBPKEF
         2yC60r91Oexpi7mTpTDj4ztLiAVfRwOot0q32NbhmhqaXsjh5qiay72xUMVzLAhq8esC
         imFMe3RoWrcEJyQZ0y64Ejk1GsLjvahGd1mymEgHo8lv9KIkBSvAgsZz1njjAQajMm3f
         m+H1itROJQmOLRNOmveE14togYnPuGpPECUzq2Muom4/WZuhonscE39AaCKcizh/NOyO
         yJ7bdswtXCm5eoONa05Ji+9IV0AMC+M9Ur7hUK2b90eFE5lrMj/MG9ztu7L4wRt5+Xsr
         skUQ==
X-Gm-Message-State: AO0yUKUhDrTc1LkYv2OrMbzHhOE2l/+X2+msrHXCLFd7FY01WrTN+kKo
        bHONUx8FYU/83304VhdAieMHew==
X-Google-Smtp-Source: AK7set81xBbnSqYRHnX0F1ox3kM2TNm7ygVSDDdDqZIaM3C2UJ2RgnK9MzZ5m7B9CkB5dN74bv4LDw==
X-Received: by 2002:a17:906:178f:b0:878:72d0:2817 with SMTP id t15-20020a170906178f00b0087872d02817mr33528937eje.29.1678732787544;
        Mon, 13 Mar 2023 11:39:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:69db:4882:d071:27c4? ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id c37-20020a509fa8000000b004fb17f10326sm133916edf.10.2023.03.13.11.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 11:39:47 -0700 (PDT)
Message-ID: <08e98d1d-e79b-fe7e-0d59-827f72277fc5@linaro.org>
Date:   Mon, 13 Mar 2023 19:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/16] spi: armada-3700: Drop of_match_ptr for ID table
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230310222857.315629-1-krzysztof.kozlowski@linaro.org>
 <7a65d775-cf07-4393-8b10-2cef4d5266ab@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7a65d775-cf07-4393-8b10-2cef4d5266ab@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/03/2023 14:55, Mark Brown wrote:
> On Fri, Mar 10, 2023 at 11:28:42PM +0100, Krzysztof Kozlowski wrote:
>> The driver can match only via the DT table so the table should be always
>> used and the of_match_ptr does not have any sense (this also allows ACPI
>> matching via PRP0001, even though it is not relevant here).
>>
>>   drivers/spi/spi-armada-3700.c:807:34: error: ‘a3700_spi_dt_ids’ defined but not used [-Werror=unused-const-variable=]
> 
> It would be much better to fix of_match_ptr() and/or the module stuff
> that also references the match table here.

Why? The recommendation is in general not to use of_match_ptr, because
there are little benefits but it disables matching via PRP0001. Jonathan
in parallel thread explicitly said of_match_ptr should disappear and he
is not accepting any new code with it. And in general he is right.

https://lore.kernel.org/all/20230311183534.1d0dfd64@jic23-huawei/

and earlier:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=444f5f854b35

Best regards,
Krzysztof

