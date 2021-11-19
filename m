Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25729456B81
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 09:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhKSITS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 03:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234193AbhKSITR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 03:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637309776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGVjhUmhSKpRkRZVK2VPpn5nare3klvTCl9Wthr4AVc=;
        b=MiHd7+lGzhCgJ3GTTapSCmRP/J2REX/E5/nJcjIaCdy5P44GOdpsF1i6gEZGPB34spdwm2
        L36FEB73NB2kNtI0HEFzZSYfBEQUqf3gUmlJEeVTfGMxYaTplc1WCOr94wY3xgK4nNpwDr
        Fx0V8zG7zIOFEEABvGPi6tASM0+C6Wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-hCAKVu9jNQSsAaSD0fzgBA-1; Fri, 19 Nov 2021 03:16:14 -0500
X-MC-Unique: hCAKVu9jNQSsAaSD0fzgBA-1
Received: by mail-wm1-f70.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso2740457wms.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 00:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dGVjhUmhSKpRkRZVK2VPpn5nare3klvTCl9Wthr4AVc=;
        b=IXonSJ7C5zI8Pf8y5OcIX1JqVXvPKpEP4D7MfliL12kSLggDWlURfRvuUDBN2yNFoC
         Ud4TNtRmofaNeWwsLxRCOpAPZ9gIF6Vrd4HvUqPDkpXnsOrPC7dX0jMGgYrqtFfHPQv0
         S6KYbpFMvIjKOFfPD337HGuZYpGD0TUuesWOj/7jHDFQfFx8lVSPcsahB/Z0Yf8Hkz93
         LTl6U4ObKqdAJxLZSOlNra7d2jJAssIrbukUXTsg+x5guVtiu0pVQcNJi12gQ9W2nzZ9
         4YGiP/2khAiVO/p2/TkilWpY2heFm33Hu5UBT7vHXIWOGZy3ynTmxhLYy9bbKuA0UqRk
         XMtg==
X-Gm-Message-State: AOAM532AQu4mQIHHSQnN3dGJgQUc44/S9WVTjvzODzVUfhjlK5R0p0Qd
        Pn8c+Njhr6zb1q8S6M6uXU06HccKUsCigfHtZHek7lAHg3hQZwKv3GcK8QMS+5Ki+foS3x1tiWT
        qD1Jq2hlEya18an3YwQVY
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr4637185wmq.34.1637309772927;
        Fri, 19 Nov 2021 00:16:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo2XV6Pk/Nz3kbl16d6jJTW64ufiC5kUvq5J0K8M6i2zYcLcY8P63mDySius51uUm3JP3QaA==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr4637150wmq.34.1637309772703;
        Fri, 19 Nov 2021 00:16:12 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z6sm2858429wmp.1.2021.11.19.00.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:16:12 -0800 (PST)
Message-ID: <84b28138-8f10-f3a3-cbe8-878635b4f0d0@redhat.com>
Date:   Fri, 19 Nov 2021 09:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20211118213143.2345041-1-javierm@redhat.com>
 <CAMuHMdVcsfE6TZbu8SJZP7CNKyjwBZdBiN0nDRQCibaGgpLF0g@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVcsfE6TZbu8SJZP7CNKyjwBZdBiN0nDRQCibaGgpLF0g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Geert

On 11/19/21 09:10, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Thu, Nov 18, 2021 at 10:32 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> This doc is fairly outdated and only uses legacy device instantiation
>> terminology. Let us update it and also mention the OF and ACPI device
>> tables, to make easier for users to figure out how should be defined.
>>
>> Also, mention that devices bind could be done in user-space now using
>> the "driver_override" sysfs entry.
>>
>> Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks for your patch!
>

You are welcome!
 
[snip]

>> +
>> +NOTE: it used to be supported to define an SPI device using the "spidev"
>> +      name.  For example as .modalias = "spidev" or compatible = "spidev".
>> +      But this is no longer supported by the Linux kernel and instead a
>> +      real SPI device name as listed in one of the tables should be used.
> 
> This reads as the tables are fixed.
> Perhaps add
> 
>     You are encouraged to add an entry for your SPI device name to
>      one of the tables.
>

Indeed, you are correct. I'll add that too in v2.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

