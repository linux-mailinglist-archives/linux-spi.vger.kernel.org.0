Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBEA492555
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 13:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiARMCu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 07:02:50 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53282
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238285AbiARMCu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 07:02:50 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 18F623F323
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642507369;
        bh=Ql5o5btca7TixCCJyaZ5PmuuPXE/PMkoelxyDyHmTek=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eG4Qf1I7Lum4cDbOgZZG5Fmgyuw8kdccCsHPnfzWk54z74i6+ynP/SrAgLzcUimtF
         Jbumsnp0agfE0Yhgvse0uriL0+ruXNY5P0n+SLWQ9gT37voqNRq/E+V6aTylzgVTcN
         PZlSXIao54V8fP6CbvLn+YNsacLuPxi/zMPchRfaryAv6XI6e15/s3XVwYP7MOYW/D
         BU2+bUqyi9RSQBg6K7mJVfQCL3yTPDKwvFCb2jVatKsFxdy0tysffH9IuoLpF94YGk
         m8tdspn6B+Cg5lJZbitg6q0Z6bqv9NSRE8R9B3RxJwEQ4Z3bqAHHcIkjCxsO+NHgRk
         vWh1rITMsJOJw==
Received: by mail-ed1-f72.google.com with SMTP id bs4-20020a056402304400b004032af6b7ebso3531929edb.16
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 04:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ql5o5btca7TixCCJyaZ5PmuuPXE/PMkoelxyDyHmTek=;
        b=fzC9ZTYdY6wLK/1bxSwAsBq2i1IF2uJMtU9/XtN/OaIclFIBc4jEMEa2GRVsZaEo/t
         IeEySYgvGklYE7moY+83e1NevCn8uRdHKJdy9oz0s7f9PBOfJ5bbwJjcdhMKKqSrK6mh
         97PAfjvfsKHCaqc7QxA4UGq+9MVZ/3ceTSS404JpOdmSr1VhDiKaZ9FhLddkykBOyQHD
         RvIHrc68ocRcLg9IWmWWmTOqRHIwKXID380TBqc/cO/ETfCQ5AQ7Gw6dsUB5joggVjEQ
         kZfHi2gInd/SMqd4LYffHa7jrEyIHnYHkQ1P0VBixvLxovz5riI2y77CpUgGAxVq8Tgs
         uIjg==
X-Gm-Message-State: AOAM530/0Ebxi79mvdWZkkbYLLo7aHNImzRuoHwk3Z1aB0sIAEKXtf09
        RAK+KnETfreVCPgOHy7SL8VXcEjmosnM/rAoGBVJTjqXt+KjE3oPS4AI5ja1N+6xDtkK4I6VgCp
        vWrDlzL+/6l3W/FhnIhFmB6xsc30Dw10k7IE1fw==
X-Received: by 2002:a17:907:97c8:: with SMTP id js8mr7881015ejc.204.1642507368860;
        Tue, 18 Jan 2022 04:02:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwacinpKUaMirkbH8G+vfVFL4LbqvlkHQiVfnNzpT2tQNau8eAn3SRNodkGspyp69k0iQbWBQ==
X-Received: by 2002:a17:907:97c8:: with SMTP id js8mr7881003ejc.204.1642507368668;
        Tue, 18 Jan 2022 04:02:48 -0800 (PST)
Received: from [192.168.0.41] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z6sm7090894edb.58.2022.01.18.04.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 04:02:48 -0800 (PST)
Message-ID: <da169a51-d779-0c0b-8836-dc8776186d4c@canonical.com>
Date:   Tue, 18 Jan 2022 13:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/3 v2] spi: s3c64xx: Drop custom gpio setup argument
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20220118110928.120640-1-linus.walleij@linaro.org>
 <20220118110928.120640-2-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118110928.120640-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18/01/2022 12:09, Linus Walleij wrote:
> The SPI0 platform population function was taking a custom
> gpio setup callback but the only user pass NULL as
> argument so drop this argument.
> 
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1-v2:
> - Split out to separate patch
> ---
>  arch/arm/mach-s3c/devs.c                  | 5 ++---
>  arch/arm/mach-s3c/mach-crag6410.c         | 2 +-
>  include/linux/platform_data/spi-s3c64xx.h | 4 +---
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
