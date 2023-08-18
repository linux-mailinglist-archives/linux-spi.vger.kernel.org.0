Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74EA780A97
	for <lists+linux-spi@lfdr.de>; Fri, 18 Aug 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbjHRK6r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Aug 2023 06:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjHRK6V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Aug 2023 06:58:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED32121
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 03:58:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so1042411e87.2
        for <linux-spi@vger.kernel.org>; Fri, 18 Aug 2023 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692356298; x=1692961098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIiLOySwC7HWFuICPpJX+pzYMiC9Cysl84ZB3jNAYgQ=;
        b=IvMZDSsurGIzDz3hT3ukjr9oH01mbggLmf3Fl4ymNjMqhM1rBCjhc6485lc6PwYViu
         bGuh8eGYSrRW4CXBgfdz7hbuDMy40ooypuA7DRvHF9RspfXKMakY+OABoaQhNCs1GMqX
         j8mGVVSEAoSFFuijAFJsRSzdyXe3XQnvnhU83OwRvjpQ/3rmzjuR8ePcGvm2W/nPBzbn
         rY1Oxq0xGntalUa8uHdiVXmsHZE9vChWNO0B7PMwwytGt1ieVlDsCf1nfiimSHA1U3CX
         yP2qXF9SEqwZZUf0Cd8gbKRKcDInfghPp3MfieHn/fjfTHt1KAYonGXt0qWkkCfWoVq9
         wJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692356298; x=1692961098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIiLOySwC7HWFuICPpJX+pzYMiC9Cysl84ZB3jNAYgQ=;
        b=hCs1OVhkP1Pf6vJC7gzzovChvfBUbrm7pYInI2Xx0FjwGzTQl5VIunT2hGrnan/yhb
         dXpQbnW3ICPuSICAZj5FtQPc1Gi/OFWUGATNOg9WBsME0j4lXrux2Q3lRTBkSgxGJSUs
         9389Mzr3JaZwe4kIrAIh8V7rtl7yW6s8WVLy7jrIEq6qFG4nmz5+HgChZeK/Q4rYDECN
         67uzIdES2I1m1+JQBeHiL8hC5yqQgKEVbsgDiTRccytD2qjrDZnDF73obPKuZzZ+C70i
         cazHm3cn7GOU2IaFnOgHscU0WjKbWNLeUS0wZ0Th62Tu++8TBmRPB8EeD8BSCqXO87+R
         i2FQ==
X-Gm-Message-State: AOJu0YyVHzzLD80HULXGU0HmKz5fxYLRV1cpIj2X0VFR1zGTac16KUfh
        4s8+rweMZqBx7IWFgnzhyecDoA==
X-Google-Smtp-Source: AGHT+IFijhOr7TxIHoybvKoUL1I3PQrdwbRIHlcD16kPD2eaynRivURkz7e8nQwwDKJLlGq/MV+dag==
X-Received: by 2002:a05:6512:3154:b0:4ff:95c:e158 with SMTP id s20-20020a056512315400b004ff095ce158mr1140284lfi.64.1692356297715;
        Fri, 18 Aug 2023 03:58:17 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709064f8a00b00992eabc0ad8sm1036848eju.42.2023.08.18.03.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 03:58:17 -0700 (PDT)
Message-ID: <bf923f94-298e-0daf-18ce-b8f66490b511@linaro.org>
Date:   Fri, 18 Aug 2023 12:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH -next 17/24] spi: s3c64xx: switch to use modern name
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org, lukas@wunner.de,
        Andi Shyti <andi.shyti@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
 <20230816094013.1275068-18-yangyingliang@huawei.com>
 <CAMuHMdWM2ZenmJan31vXrc_=uu9_uYTaXw+ccj7TUv3FtYBOmQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWM2ZenmJan31vXrc_=uu9_uYTaXw+ccj7TUv3FtYBOmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/08/2023 12:27, Geert Uytterhoeven wrote:
> Hi Yang,
> 
> CC Andi, Krzysztof, Alim
> 
> On Wed, Aug 16, 2023 at 11:43 AM Yang Yingliang
> <yangyingliang@huawei.com> wrote:
>> Change legacy name master/slave to modern name host/target or controller.
>>
>> No functional changed.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -38,7 +38,7 @@
>>
>>  #define S3C64XX_SPI_CH_HS_EN           (1<<6)  /* High Speed Enable */
>>  #define S3C64XX_SPI_CH_SW_RST          (1<<5)
>> -#define S3C64XX_SPI_CH_SLAVE           (1<<4)
>> +#define S3C64XX_SPI_CH_TARGET          (1<<4)
> 
> I assume the register bit name comes straight from the hardware
> documentation, so you cannot just change it without making future
> maintenance harder.

Yep. SLAVE is term from datasheet. Code is easier to read/maintain with
old name.

Best regards,
Krzysztof

