Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF3456BB5
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 09:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhKSIfl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 03:35:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234448AbhKSIfj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 03:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637310758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUuoKjixLQkWOo6/knJS/yxc8h9J4lm72RKU4yaFvIo=;
        b=Xabz9mgqvP74P493gyQgW2rKc/kINxkVhNIfRQGaV78KLGI/7bcoSsET2CjEdO/lSGax6T
        zJ9zQORSoGy9Mq/PRfyStKrc92uYJvGZ+3V4MVgHI/+2s/wZozMYt07GXTDxH/2GBPmLel
        +pVntc1BryEHM46pPSOjxZVKQEI2FI4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-_XiPLJkROeKXl0kSD_lq4w-1; Fri, 19 Nov 2021 03:32:35 -0500
X-MC-Unique: _XiPLJkROeKXl0kSD_lq4w-1
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so4372072wms.8
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 00:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUuoKjixLQkWOo6/knJS/yxc8h9J4lm72RKU4yaFvIo=;
        b=2DN9J46qJHYuvYA8rrwDUj8FxnkXjuTOzZkCjZU442dKOarQZZJ1hX2boCQqVVCqlR
         sGKZTZ9GnCQkejV/coAC6J6XnqZWkG+ZErFVd96sG/a36FDA8F9n6Y2BKC6G1wNGrwlG
         wewO2TLoH47+9ILUHw2Xa2Q+wGxfSGLXzVNmyysIWdSDdVBNfQBIzxBnvSY33WzGNImf
         rnjq8VUuQuU+E1zaEohAZ6nsZpaIwtuQVpLEE7oUlGZav48v9MB5zMInbXu1xRHWHHWs
         ksS8mSiClknTsaSI/qodLkYpSGcRrifvttgVjs50PIC+YU1bGHf9q9LdHSNaenxMaX7u
         N0xQ==
X-Gm-Message-State: AOAM531Kdp5yOL6XFMlflV0cENYZqnAH3mr+vVylh5onZBrEGm7QSvQY
        1Gk67EwFsl0Kpsyuem8gYYlr6mz4e+vLFIxa16Uylzftpz2WrAZ/YbvbYMzrICwwZmQRCpiZeZu
        xBM209tEveXBp1fKddLXv
X-Received: by 2002:a05:600c:2156:: with SMTP id v22mr4877446wml.159.1637310753860;
        Fri, 19 Nov 2021 00:32:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+6a7rxjlIR8+FNOMhZH5MUe8GhJzMMes1/fzoti38R1czb1GyITps3evRL1yExeB1HLGWNA==
X-Received: by 2002:a05:600c:2156:: with SMTP id v22mr4877410wml.159.1637310753625;
        Fri, 19 Nov 2021 00:32:33 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n184sm10977123wme.2.2021.11.19.00.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:32:33 -0800 (PST)
Message-ID: <9b41eb05-a095-39af-8b76-a73fa2532e92@redhat.com>
Date:   Fri, 19 Nov 2021 09:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
 <YZaZpx7cudaAEGIP@sirena.org.uk>
 <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
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

On 11/19/21 08:40, Uwe Kleine-König wrote:

[snip]

> 
> It affects c) only if the device tree has a device with compatible =
> "spidev". For such a device the history is:
>
>   - Before 956b200a846e ("spi: spidev: Warn loudly if instantiated from
>     DT as "spidev"") in v4.1-rc1:
>     Just bound silently
> 
>   - After 956b200a846e up to 6840615f85f6 ("spi: spidev: Add SPI ID
>     table") in v5.15-rc6:
>     The device was automatically bound with a warning
> 
>   - After 6840615f85f6:
>     The device doesn't bind automatically, when using driver_override
>     you get a warning.
> 
>   - With the proposed patch:
>     The device cannot be bound even using driver_override
>

My understanding is that there's an agreement that using "spidev" as the
specific compatible string is something that should not be supported.
 
> Not this affects also devices that use
> 
> 	compatible = "myvender,devicename", "spidev";
> 

This is indeed a corner case and I'm less sure what the kernel should do
about it. I just learned now that of_device_is_compatible() return value
is not a boolean but instead a "score":

https://elixir.bootlin.com/linux/latest/source/drivers/of/base.c#L455

I wonder if we could add another helper that returns the index instead,
and do: of_device_is_compatible_index(spi->dev.of_node, "spidev") == 0

Another option is to add an of_device_is_compatible_specific() helper.

Or just consider DT nodes with a general "spidev" compatible string to
also not be valid. I would lean towards this one I think.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

