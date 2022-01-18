Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36806492363
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiARJ5Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 04:57:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43522
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233538AbiARJ5P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 04:57:15 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA0173F1E1
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642499829;
        bh=MFO8uJDAvBhLowCeOE4JP5TX6QErB5JH8USU7be5UeE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gn3YbZIGRooMwHrL9/n/44CimydkUw+K8B8ptA/n60IN2XuUBvrw6G6ZuKvEHpX8j
         TjJ+LJrVqyd2E1sPrwU0Ai6ZIIr73tB0A3kUNLYXcUfa0ecOItQzdhF101MPapC61A
         b9AcC8Tvq0sxO4xD9DGOeY17c/gKEMNMsm4S+DczR7rRY4eib5mCi7TTa9yaQR9gbS
         MK6lN9gH+Z6nW8yoq5l4xdEJNFShfOmccfQfc7NdG0FiLVERfea9jtiDvww2cbRg6R
         RBgujPkzGA8kVC78tX2bBrm+qviAle4A0r21+ckn0UPFRjqbQRinqvz4p04C8cDXuu
         gx9gJ6Vs7qO/Q==
Received: by mail-ed1-f70.google.com with SMTP id ej6-20020a056402368600b00402b6f12c3fso5081797edb.8
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 01:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MFO8uJDAvBhLowCeOE4JP5TX6QErB5JH8USU7be5UeE=;
        b=MHEsGe73zBHFo32mqtYtmUMqj1QQ7loVXiIUdXXr20OQUQYo3cYhgZ2mfapZ2UaLXM
         khW14zzXzaXspQJNHRS48bNozLf/w0pw+p/K5zCp30j7avgeioyhNs4SNvnv8f4aeNJf
         +VpYi7w29vBC86eDuYlqe1iXvgh0hcWYr0badSj+LbghX1hi1o7qq3/nC9lVimkFJqpp
         ytwEOFnfnUCQvFp7DcjcLoHVt8dQ3spIvhbHgBdeSyX3jQuypBkEi/8uQEHkTO5bBK/J
         MBXFZxsQImD/mO0pQL5A2LkKobztT8rhSkEkTjdQ0exS4XfenbhAQ6hsQg71Rt3F94KB
         7Zfw==
X-Gm-Message-State: AOAM533roH2Z2VuBlIkYWx2UPU+UKAEYtQn1LBO+VnRha07paeg4+Vog
        FgeAzdzHWGhayhy0v8TFxS7YWnVwu5JZpMVUgzRKVKIY4iZlIiDvAIfIv84kSC7UjLU5kP7hicY
        vL3GsOTfbrwusr2RaAx71uirA0qHZ2iLz3S1e0w==
X-Received: by 2002:a05:6402:4487:: with SMTP id er7mr22619879edb.80.1642499829411;
        Tue, 18 Jan 2022 01:57:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw82bMu0Ox8GmWEm0lEqeltlKhMHgQUplgcxOT7MOfUNw7zdvb0xlBkR22QRB6PDiK4TTVE8Q==
X-Received: by 2002:a05:6402:4487:: with SMTP id er7mr22619872edb.80.1642499829224;
        Tue, 18 Jan 2022 01:57:09 -0800 (PST)
Received: from [192.168.0.41] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id j13sm6913874edw.89.2022.01.18.01.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 01:57:08 -0800 (PST)
Message-ID: <eeafdcd4-3527-f18e-e92c-0544bf2a83e8@canonical.com>
Date:   Tue, 18 Jan 2022 10:57:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] spi: s3c64xx: Convert to use GPIO descriptors
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20220118023303.104419-1-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118023303.104419-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18/01/2022 03:33, Linus Walleij wrote:
> Convert the S3C64xx SPI host to use GPIO descriptors.
> 
> In the process we tear out some unused code in the machine,
> such as the unused config options for SPI controller 1 and
> 2. New systems should use the device tree boot to enable these
> SPI hosts.
> 
> We drop the ability to pass a custom pin config function
> to the device while registering since nothing was using this.
> 
> Provide GPIO descriptor tables for the one user with CS
> 0 and 1.
> 
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-s3c/Kconfig                 | 12 ----
>  arch/arm/mach-s3c/devs.c                  | 77 +----------------------
>  arch/arm/mach-s3c/mach-crag6410-module.c  | 13 ----
>  arch/arm/mach-s3c/mach-crag6410.c         | 13 +++-
>  arch/arm/mach-s3c/setup-spi-s3c64xx.c     |  9 ---
>  arch/arm/mach-s3c/spi-core-s3c24xx.h      |  6 --
>  drivers/spi/spi-s3c64xx.c                 | 50 ++++-----------
>  include/linux/platform_data/spi-s3c64xx.h | 16 +----
>  8 files changed, 27 insertions(+), 169 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
> index 25606e668cf9..1899fc3f44fd 100644
> --- a/arch/arm/mach-s3c/Kconfig
> +++ b/arch/arm/mach-s3c/Kconfig
> @@ -191,18 +191,6 @@ config S3C64XX_DEV_SPI0
>  	  Compile in platform device definitions for S3C64XX's type
>  	  SPI controller 0
>  
> -config S3C64XX_DEV_SPI1
> -	bool
> -	help
> -	  Compile in platform device definitions for S3C64XX's type
> -	  SPI controller 1
> -
> -config S3C64XX_DEV_SPI2
> -	bool
> -	help
> -	  Compile in platform device definitions for S3C64XX's type
> -	  SPI controller 2
> -
>  config SAMSUNG_DEV_TS
>  	bool
>  	help

Looks good to me, but I would prefer to split the dead code removal
(S3C64XX_DEV_SPI1 and S3C64XX_DEV_SPI2) from actual conversion. Such
split should be doable and would make it much easier to see actual
conversion.


Best regards,
Krzysztof
