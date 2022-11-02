Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E31615DF3
	for <lists+linux-spi@lfdr.de>; Wed,  2 Nov 2022 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKBIi2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Nov 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiKBIi1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Nov 2022 04:38:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904552793A
        for <linux-spi@vger.kernel.org>; Wed,  2 Nov 2022 01:38:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so23427763wrb.4
        for <linux-spi@vger.kernel.org>; Wed, 02 Nov 2022 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BvT9kf5BTtKmq09LqoceItJYkcPyXkCgbgmlD1552lI=;
        b=CcuR7qmEPZxsqCFuS6zPktbtXA0halB9mU6/SoDaivOMcMMZ8WMLVqr82rijeKB0Xt
         JqDzZnK3eo3bmYccYJHvCNiutAG7MipVJ62vyY7lBlbFtR8DWKShXS3I7aSaUN9fX5gi
         VU7lzgAwUTWwRN1cYe9+jIfz1b83yoXyxsjBjrW0utw0Mah5Zue6zIL600uY+l+hiCmT
         xMUAbljSH+k0oYL+FmM/kA9tH+dNIKxhmv82PZixy/ERhN9GHE0mveBv2QBK0MQUGiMp
         IfFo0MeRugLLakc/3ZP1hXWwnIBanWoND0RgU1WKMjUOY9pEZvFg+ZsInkE9p9HV98fB
         U7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvT9kf5BTtKmq09LqoceItJYkcPyXkCgbgmlD1552lI=;
        b=NYings613uvDiZWtCcICrvVStbCAe8BEY6Egiccn7xpzn1nkRUuemgVov6BfS+hLfS
         TLHg5+hIixDHrP92/eAD0bvoXC5eI9mrflWbzpk9nXT0oUfSVRI0TTTqOkDHH5vjE6PG
         rBZ5/m/jTWI38hPqSasJ5LTv1BJ7a/EryJIpXvkS4AAsP7qx1uV1V+jZDIej/qC8MTGZ
         F+wH3xxDEiuZ7q8q+3PeHz1cUz9Wl/LIfZrGZ8nVoVPuFGBf9LZmXvN+gvEhrZTyz5lw
         dkwZRsnNNNZO/46KzzSFrejXRAk/Ovv050VKp+Fj1Nd/Qjiw1IxNdItr7IGzM87t3Bb/
         /bNw==
X-Gm-Message-State: ACrzQf3TTCidrUwLduxQbR7YLPucJ+mBdeRtugzEuYqoDa6TLqXprFzy
        ptnWTPdEGq3mQWUwjsWfsevlNA==
X-Google-Smtp-Source: AMsMyM5xffb8Gbv/LZqtSakj2Eo0F4VehH3Lv16f+r2sDSsxwZp3bHD+76DIeqSa+hXeqcXkUS0hgg==
X-Received: by 2002:adf:f58e:0:b0:236:a8b2:373 with SMTP id f14-20020adff58e000000b00236a8b20373mr14480463wro.575.1667378297124;
        Wed, 02 Nov 2022 01:38:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4? ([2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4])
        by smtp.gmail.com with ESMTPSA id x21-20020a1c7c15000000b003b492753826sm1218514wmc.43.2022.11.02.01.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 01:38:16 -0700 (PDT)
Message-ID: <59f1364c-2ee3-d4f2-9291-a8af9eeed81b@linaro.org>
Date:   Wed, 2 Nov 2022 09:38:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] spi: meson-spicc: fix do_div build error on non-arm64
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <20221027-b4-spicc-burst-delay-fix-v1-0-5a6e9a88e54c@linaro.org>
 <CAFBinCCx-8u_VNjNtjivgwp3aOc8cUppxstwzzLL1oGLtS6tZA@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCCx-8u_VNjNtjivgwp3aOc8cUppxstwzzLL1oGLtS6tZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/11/2022 20:13, Martin Blumenstingl wrote:
> On Thu, Oct 27, 2022 at 2:11 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> This fixes :
>> error: passing argument 1 of '__div64_32' from incompatible pointer type
>>
>> By passing an uint64_t as first variable to do_div().
>>
>> Fixes: 04694e50020b ("spi: meson-spicc: move wait completion in driver to take bursts delay in account")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> and also:
> Reported-by: kernel test robot <lkp@intel.com>

Thanks,
Seems To: Mark is somehow missing, will resend with it.

Neil
