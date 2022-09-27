Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A595EBEC5
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiI0JhD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiI0Jgx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 05:36:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D61B3B31
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 02:36:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so14104778wrm.2
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=o2YL47wkdNCtbQ/cDyQshFBYktZxHSBc3e+Im99MsKQ=;
        b=VOp1y0rIEFjW9MzzuluhjxgZIEMdat46QCY8sGRhrgJzo1NMRmb4BMl8L0wXZors0S
         f3lzBllNMQZ309rJbWYY7Q2sK+PCUb+zRbQIQPfjWbn5iaLGTrlAlnspt5fQYqeck1Fx
         AMgqE3gykkMsA1ME1JLAEXAPO0zchz3q2OOSBSMciSEGgTC6D5YkVb/L8pimqSzohK8P
         ZNlyOQTO4iy3bLeidV3Rck5y8OgieLRlnEt5P6NUlH2hpdR8noLM4XsIWA+l3S7++ik8
         +g/n0YQGwqGiCuopypTiKRT0Sdl2CS5XPCLZ6aL60IQVr4qhGlTupyp77QZR5V5TqAOO
         CLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o2YL47wkdNCtbQ/cDyQshFBYktZxHSBc3e+Im99MsKQ=;
        b=17pLgKJOmKrrjTsJ1/ldjBu7K7daDFWdl15CnqVrubdv9CcnYMAOo1jvI4ivuhw4q9
         uIFMpLUm4bb2ED1a9qunTDUc+hZ2Mtw3WZuPy/B7e0EjLxIBciHfUSMpZ4IOy9NcFIUz
         17n6vBb+fsd5lAOs4g4r/jvurj8shTgNz1BOqY4tNcljtbEpswy6XeS8b+qxNBIoYWCK
         djtiGQac7Z307lu+V2DOpjlsN9Vpl8vWKly/+ua2R5MDw8bbff5EbzjsVbNutiAUHKF8
         ZJaE/lRU+gvDuVFlhixYNLBl1csRKZ5+YVaR4keHHEupp4uIYr6Xb7O+puvdGpEq4y39
         ivHw==
X-Gm-Message-State: ACrzQf0XOxKHu6rSLrgKA4pEQUzE3n6BWHUMrROzidLAkYoKR/nkZXZU
        JGg6q1Ko6V/J/Z2sQ5qMKhhFF99IBR8OzA==
X-Google-Smtp-Source: AMsMyM7Z6EJ4pOi9kImED9VR+cCZ/gatMSptyvxq7YIinwEiZ7IsL4xOVqZV9NhmTQrkuyrlZwqg0Q==
X-Received: by 2002:adf:e309:0:b0:22c:c332:9af7 with SMTP id b9-20020adfe309000000b0022cc3329af7mr157623wrj.217.1664271410890;
        Tue, 27 Sep 2022 02:36:50 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id g2-20020adff402000000b0022860e8ae7csm1314875wro.77.2022.09.27.02.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:36:50 -0700 (PDT)
Message-ID: <d1039404-b8db-c32c-d508-32a77a348744@baylibre.com>
Date:   Tue, 27 Sep 2022 11:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK
 line when idle
Content-Language: en-US
To:     neil.armstrong@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com
References: <20220809172017.215412-1-aouledameur@baylibre.com>
 <09081275-be9c-9d0c-856b-ed2df8fc0b13@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <09081275-be9c-9d0c-856b-ed2df8fc0b13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Neil,

On 9/27/22 10:30, Neil Armstrong wrote:
> Hi Amjad,
>
> On 09/08/2022 19:20, Amjad Ouled-Ameur wrote:
>> Between SPI transactions, all SPI pins are in HiZ state. When using 
>> the SS
>> signal from the SPICC controller it's not an issue because when the
>> transaction resumes all pins come back to the right state at the same 
>> time
>> as SS.
>>
>> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
>> state change and SPI pins state change from idle, you can have a 
>> missing or
>> spurious clock transition.
>>
>> Set a bias on the clock depending on the clock polarity requested 
>> before CS
>> goes active, by passing a special "idle-low" and "idle-high" pinctrl 
>> state
>> and setting the right state at a start of a message.
>>
>> Amjad Ouled-Ameur (2):
>>    spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI
>>      signal states
>>    spi: meson-spicc: Use pinctrl to drive CLK line when idle
>>
>>   .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 15 +++++++
>>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    | 14 +++++++
>>   drivers/spi/spi-meson-spicc.c                 | 39 ++++++++++++++++++-
>>   3 files changed, 67 insertions(+), 1 deletion(-)
>>
>
> Will you send a v2 with comments adresses ?

Planning to send it soon, thank you for the review.

Regards,

Amjad

