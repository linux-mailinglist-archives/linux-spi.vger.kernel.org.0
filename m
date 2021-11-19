Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE032456B6E
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 09:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhKSIR5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 03:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233858AbhKSIRz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 03:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637309693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JV1cZENXMXZyinTiwhaccj/QSmI5uZhTY4+XUIIsZA=;
        b=Rimm5xwVW3n2icdkUxwVVzZxSywxWsP4V1YyUAcjFvmDANLY2we9iZ9p6DvUixLCQq3+wB
        5rrw07EswitGEtL8r9zOaHR1rTrFE9c8aYdFS4sFy//F42BF8yncSXJFDzj0OsR5JzZUDo
        CTPzjZ0zkGU+j46eyauBZmKebHMGppI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-l0Q3aS06N2qzxyWUNHrWZw-1; Fri, 19 Nov 2021 03:14:50 -0500
X-MC-Unique: l0Q3aS06N2qzxyWUNHrWZw-1
Received: by mail-wm1-f70.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so2952778wma.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 00:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7JV1cZENXMXZyinTiwhaccj/QSmI5uZhTY4+XUIIsZA=;
        b=DM8pdWLl/HCxyZcVBGJ/uLU6fCOZKJrbaFvk3qCBSsg3KcFglnwlM67Jp+a3XFDwNi
         gbDqnyEZEn2rYGSpEBDCHVW3ah6dsH/YywDjNaPFnSGbDD6evGxA8yPtvJMXgCu4GKYJ
         D+LeJVpXMcusQNicwrG5s1c9TB9trnBoM68g9HtX/xH0ZuPJ2qYByMwQV2HBIQTtqPX8
         NfVtn5uqO/SXkKGNBmZ9bGuy6BAqkq98vDKhe0rSO9FQcrnGBTUPssfSWOr+RbJCzmfq
         iXeKOIozwwfTljAvbRXdkeEQlOZi99pkKoQidI+mg2uLTXRcaRby+Efx0UHDQxP56TbT
         yqIA==
X-Gm-Message-State: AOAM533p5MOJ2JLtR0C1yD+2xLLmxmuoRPWvRjVTua+VD530dPELaxdd
        wFTkpBibBbwjKPB+Zp8hJHtsLvwy3idHbTWJJnaI16G7TNNXs3/KZINX+ivA/+AG286si2zzSvi
        A2sE9ylhKcGXG3SHIHDNI
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr4450013wmh.60.1637309688856;
        Fri, 19 Nov 2021 00:14:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBlU4knLHloWUN5sSN3Ii1JoA342TzkqpYsfz9O9L8KdAkj6d0ZgiszUYl8BUt84AvBN/z1w==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr4449995wmh.60.1637309688629;
        Fri, 19 Nov 2021 00:14:48 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg14sm2669635wmb.5.2021.11.19.00.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:14:48 -0800 (PST)
Message-ID: <f6349482-2f65-277d-afa7-9fb47e89221b@redhat.com>
Date:   Fri, 19 Nov 2021 09:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20211118213143.2345041-1-javierm@redhat.com>
 <20211119074529.cvi5zldkuofl4nl5@pengutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211119074529.cvi5zldkuofl4nl5@pengutronix.de>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Uwe,

Thanks for your feedback.

On 11/19/21 08:45, Uwe Kleine-König wrote:
> On Thu, Nov 18, 2021 at 10:31:43PM +0100, Javier Martinez Canillas wrote:

[snip]

>> +
>>  Set up the other device characteristics (bits per word, SPI clocking,
>>  chipselect polarity, etc) as usual, so you won't always need to override
>>  them later.
>>  
>> -(Sysfs also supports userspace driven binding/unbinding of drivers to
>> -devices.  That mechanism might be supported here in the future.)
>> +Sysfs also supports userspace driven binding/unbinding of drivers to
>> +devices.  The mechanism works by writing to the device "driver_overrride"
>> +entry.  For example:
> 
> I'd write here:
> 
> 	Sysfs also supports userspace driven binding/unbinding of
> 	drivers to devices that don't bind automatically using one of
> 	the tables above. To make the spidev driver bind to such a
> 	device, use:
>

Agreed, that looks much nicer.
 
>> +
>> +    echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
>> +    echo spiB.C > /sys/bus/spi/drivers/spidev/bind
>>  
>>  When you do that, the sysfs node for the SPI device will include a child
>>  device node with a "dev" attribute that will be understood by udev or mdev.
> 
> What is "that" here? (Maybe this refers to "Set up the other device
> characteristics [...] as usual"? Is the effect still accurate?
>

My understanding is that "that" refers to: define an register a spi_board_info
with .modalias = "$chipname" to bind the device with the spidev driver.

Since the "dev" attribute will AFAIK contain the MAJOR:MINOR numbers for the
character device in /dev. This is the reason why I left this paragraph after
the explanation of the device <--> driver binding logic.

But probably while being there I should make that paragraph more clear too ?

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

