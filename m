Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE550376D
	for <lists+linux-spi@lfdr.de>; Sat, 16 Apr 2022 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiDPPvx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 Apr 2022 11:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPPvw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 Apr 2022 11:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAE8F5D1AE
        for <linux-spi@vger.kernel.org>; Sat, 16 Apr 2022 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650124158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6tJt5xi4j/95RjrkCYGghk3+Qa3IFPUrOmUFpGR2eM=;
        b=hAuLnFkEh3VGwhOdTOgQ1yVyAUAtNp0H7YI9DAzyKoerSdLoSktG9sDHZn01lhMFOs5KHB
        ToJAgLXr5U6BoC0i7MCQ2uTEk3OtJqM5jcjWcFpNuOVS6W80B+m2P2A8nDsPIKUEQrvruc
        evTIUUUXGB/8RmtdOMeSJcl35yMQ84Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-IVNADgBAPWqG6LWQk4lqSg-1; Sat, 16 Apr 2022 11:49:17 -0400
X-MC-Unique: IVNADgBAPWqG6LWQk4lqSg-1
Received: by mail-qt1-f200.google.com with SMTP id bb32-20020a05622a1b2000b002f1f41e6caeso904273qtb.19
        for <linux-spi@vger.kernel.org>; Sat, 16 Apr 2022 08:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T6tJt5xi4j/95RjrkCYGghk3+Qa3IFPUrOmUFpGR2eM=;
        b=n51sQuu1fk/zf+7ljUiN554awmJHZz8VOW6AvAwpgyRpad8eQ1gSDPlQn1YogPpF/J
         q9PzYDXSchWTPpfmxbxdGd8tlXdjqRyuoknPzty8+A0lbIsIyoty8L0WxhR+3BA6ZlJQ
         b/tn4xYhGZI+uosSgcpo8dpSUTyVhkInHQR8xEEHWhrxA+g/qZFgHC7KzxKoS4UrSalF
         Ua3ZbQ+92AC4Bt3jkPZepzMxwRYUazpJzw648QSByuAU92Egodhvl1xohp4tItp0CXR0
         lKe8OF38QQhvgEPV8OtVytIllmPMkB7skiAbKcaxjjE+d7HU3TzVXUu/ST3Ap7lQOTJz
         F4lQ==
X-Gm-Message-State: AOAM533Jlojfg6WuM52FIx8Numf+e/fUEzGXDDe1rrHknLJW47IWIbfi
        cmLT13o6poH39ebQZp0ewu1Ddsz/7mEnzIwv7UfNZpQLQxxFzXMMIYv4x60p7pskMrIIeNJPWhJ
        nPqYR3wKEhqf9vufufF99
X-Received: by 2002:a37:510:0:b0:69e:8868:c691 with SMTP id 16-20020a370510000000b0069e8868c691mr231639qkf.731.1650124157112;
        Sat, 16 Apr 2022 08:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7eBSX9BoYG86DDTIzi+DQA4SCrsjCtidPwA9Fiv/mUYye57Js4SZZMzHh5S5PV6hbXJnvKQ==
X-Received: by 2002:a37:510:0:b0:69e:8868:c691 with SMTP id 16-20020a370510000000b0069e8868c691mr231634qkf.731.1650124156904;
        Sat, 16 Apr 2022 08:49:16 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i62-20020a37b841000000b0069c10d27571sm3935699qkf.70.2022.04.16.08.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 08:49:16 -0700 (PDT)
Subject: Re: [PATCH] spi: remove spin_lock_irq in the irq procress
To:     =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>,
        "lh.kuo" <lh.kuo@sunplus.com>, nathan@kernel.org
References: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
 <fdb1e0a6-62f9-c0a3-c1db-8857087701a1@redhat.com>
 <CAGcXWkzZex-XTEoq8H5mc+3Y2BH=cphdpH-815Y+TAq812K=8g@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d8cddce3-c353-e8e9-9221-84eed6d28b69@redhat.com>
Date:   Sat, 16 Apr 2022 08:49:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAGcXWkzZex-XTEoq8H5mc+3Y2BH=cphdpH-815Y+TAq812K=8g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/14/22 6:16 AM, 郭力豪 wrote:
> Hi Tom :
>
>      This SPI driver only handles one transfer at a time.
> That's why locks are not needed.

Please add this statement to the commit log.

In a commit log, not only do I look for what was changed but also why 
the change was made.

Tom

>
>
> Li-hao Kuo
>
> Tom Rix <trix@redhat.com> 於 2022年4月13日 週三 下午7:45寫道：
>>
>> On 4/12/22 6:38 PM, Li-hao Kuo wrote:
>>> - remove spin_lock_irq and spin_unlock_irq in the irq funciton
>> function
>>
>> I was expecting a statement on why is the lock is not needed.
>>
>> Could you add one ?
>>
>> Tom
>>
>>> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
>>> ---
>>>    drivers/spi/spi-sunplus-sp7021.c | 4 +---
>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
>>> index f989f7b..120623c 100644
>>> --- a/drivers/spi/spi-sunplus-sp7021.c
>>> +++ b/drivers/spi/spi-sunplus-sp7021.c
>>> @@ -199,8 +199,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
>>>        if (tx_len == 0 && total_len == 0)
>>>                return IRQ_NONE;
>>>
>>> -     spin_lock_irq(&pspim->lock);
>>> -
>>>        rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
>>>        if (fd_status & SP7021_RX_FULL_FLAG)
>>>                rx_cnt = pspim->data_unit;
>>> @@ -239,7 +237,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
>>>
>>>        if (isrdone)
>>>                complete(&pspim->isr_done);
>>> -     spin_unlock_irq(&pspim->lock);
>>> +
>>>        return IRQ_HANDLED;
>>>    }
>>>

