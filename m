Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9693C8602
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhGNOZV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 10:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232037AbhGNOZU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Jul 2021 10:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626272548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+PCijAFK+zc4yebc2+Chhr3mPpRnKROJHkGBmiJexA=;
        b=drHhmKcSRRcWtBfVvub5RD/V5t4H78xPxT4oe7uNPFK3epUhxZ8ICLkjpDGYBsPe3CF3DP
        wvoX010/d0IIWY40vsy1gGqb0fy8QJUoh883IjfMvzG9XH/qFO8HBeNH4uMdztyh73NQad
        rPRmco8QIQlgusUyYClxuoTw+RGD0fc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-krEGBo8cPhmztlKjj8ksnQ-1; Wed, 14 Jul 2021 10:22:25 -0400
X-MC-Unique: krEGBo8cPhmztlKjj8ksnQ-1
Received: by mail-qt1-f197.google.com with SMTP id t6-20020ac80dc60000b029024e988e8277so1980068qti.23
        for <linux-spi@vger.kernel.org>; Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M+PCijAFK+zc4yebc2+Chhr3mPpRnKROJHkGBmiJexA=;
        b=nB0pbKS7K9NPRmwGkKfo/DJo6Xcret9TJoAWr2/m+RciPuI9RlI2joyQT0tbPqMvTb
         E0yWeC+1QBqQNqAA6gNjT9jIvVL+bZIn2VpLus8BT8MvNw6KDEP66+3weLZPd0KbQz8W
         Uzy97eInxmx57+AQeJ0m1kVgjW7/Nkn3CJLCc0fRxutMlAPTtX4OP4XZe8q3h0dcNmOR
         m5czLMxff12n3hp2ACbf41maRajkQThPdNFCFPCWL0FwY9a5wkob4ILoxvNj9jniJmhE
         +kyGh6hTvp0DQcPsuDYbD5lZvtNuZiRWYwqYiejkoWHsej3GrE6Dxfku8HKGvxMBj18o
         pzSQ==
X-Gm-Message-State: AOAM533dXuOaszDLpP3LPsvxaiDPuJ2UhV4DJADXi2FYWXuCifAWeNhl
        20xUEV98U4jiPwnZB2pub/6viVA+Obw7jU7TtjvZv+e4BrQrDqv5mgZFfWs9GYFj28mDAFWKakp
        73XFonGg5KWeim7FjnXsIW75bf552YSzEqDQsJ0M531H6BzdZ1oskrNqV7bMHgMNvemU=
X-Received: by 2002:a37:cd0:: with SMTP id 199mr10167170qkm.69.1626272545252;
        Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIl4qQxdtL1RBVqFykTv9nwuH3HGdWbTZY5hynMAyEJAyRrYZKgBknquu9Xi3Ou9JMvCGkcA==
X-Received: by 2002:a37:cd0:: with SMTP id 199mr10167145qkm.69.1626272545038;
        Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f12sm1102779qke.37.2021.07.14.07.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 07:22:24 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] spi: spi-altera-dfl: support n5010 feature
 revision
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-3-martin@geanix.com>
 <d6250f86-db93-bcc2-d46e-6dba30976cc4@redhat.com>
 <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <99abfd17-4307-0b88-32a3-c80f61da587b@redhat.com>
Date:   Wed, 14 Jul 2021 07:22:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 7/14/21 4:33 AM, Martin Hundebøll wrote:
>
>
> On 06/07/2021 16.56, Tom Rix wrote:
>>> diff --git a/drivers/spi/spi-altera-dfl.c 
>>> b/drivers/spi/spi-altera-dfl.c
>>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>>> --- a/drivers/spi/spi-altera-dfl.c
>>> +++ b/drivers/spi/spi-altera-dfl.c
>>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>>       .chip_select = 0,
>>>   };
>>> +static struct spi_board_info m10_n5010_bmc_info = {
>>> +    .modalias = "m10-n5010",
>>> +    .max_speed_hz = 12500000,
>>> +    .bus_num = 0,
>>> +    .chip_select = 0,
>>> +};
>>
>> Other then the modalias, this is exactly the same as m10_bmc_info.
>>
>> Why not set platform_data?
>
> So like this?
>
> +static struct spi_board_info m10_n5010_bmc_info = {
> +    .platform_data = "m10-n5010",
> +    .max_speed_hz = 12500000,
> +    .bus_num = 0,
> +    .chip_select = 0,
> +};
>
> I don't see how that should improve the situation, but we might allocate
> the board info on the stack and set modalias dynamically instead?

No, I mean that instead of have two *bmc_info's generalize the existing one.

This could be done by using the as yet unused platform_data field to 
hold the identity as a bit/enum in an int.

Tom

>
> // Martin
>

