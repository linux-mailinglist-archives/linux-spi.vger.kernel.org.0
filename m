Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA04935AD
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 08:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbiASHm4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 02:42:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54994
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351526AbiASHm4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 02:42:56 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0DF2A3F1E3
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578175;
        bh=mobfvpRkY9BTXvz2dBYlaHUJOSiUxXxS0pbTEQukDr0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=OiwzY1nkpB4WHSvmsV47/wIxpTsX9OJrP8cJn6OOki+mZoMRKDJVYuL00oeFskwI0
         wOmxpCr6R0YXqpNAkViu3YiVx/nS/Nly3FjTsueVqwitr1aStDBeLkuhC6RAwDiiNS
         mn4ci6VNnNWYC872LEV3WYNMiV9dDGx/rl7s+X1yiKk5J7Yn7OgLKTY4Rj0WMzKNgG
         ZbEgJ7C/+TasnWxjVXsFaIc63ez7To4kAneXTXyGTJWSkDorYQxzpPq2qSQFq+tDbM
         C5Lf0hfWR/lrVWuKJfRcJ03Tabqmot+ptHaD/D544BIPU2BCArg0dPrXw1EbGn0kOl
         5RM7N3tWV/9yg==
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso315383edb.5
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 23:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mobfvpRkY9BTXvz2dBYlaHUJOSiUxXxS0pbTEQukDr0=;
        b=Zinha8nRooL1Z9daCXtD1m+EA1PT1oQIAmiza14DjmNNOjqrFABNsaV9VhUTUUY5wj
         wQWVX3ClVrBoWnZ/KhrWCQuVeWLfR0+WeMRmA3wrQC4PJCvsLMNrz6wuqxSatk+L8lsM
         W6JG9PmpTgQ6U9z9TGBq0mKnIWcip6KELJiHinOnVObY+FEaZrBmXqPkqVRa+zOJPGvv
         sQf9vCLrWoOdJ09SL8r/tHp/mUHNydjt6RHA7jRDb/SSUSzB+QQ5JzQokUpA9h7m5UnG
         0tptM99RHsdzLZr+sG4iLg2og6P69wxw1cGrBahs6y2C7cQWVKS8KzL8lUdSL4CGrUoj
         x5WA==
X-Gm-Message-State: AOAM532A3J7VQWKPZQPpOV1HFKWbvi4dH175BCEKjQp3prWdyrkDa3S0
        jTPAI00qWFBreA34QOFg7B+XfCsMnprF/L7YclDY5fn93I5kK+dPRbfxJAhub3rWj6w/Jp2EZ1U
        YWCm8d9L9mFOqfUYZpXTMj5utzYf4nn1vkf7/WA==
X-Received: by 2002:a17:906:1e09:: with SMTP id g9mr22773279ejj.37.1642578174784;
        Tue, 18 Jan 2022 23:42:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyVB8e3NpTCHAbBG19K9xGl2wiaX9fPzOn3eaI23ml+9C110AHTUlc8a4fsM8/nZDOu3Et3Q==
X-Received: by 2002:a17:906:1e09:: with SMTP id g9mr22773273ejj.37.1642578174594;
        Tue, 18 Jan 2022 23:42:54 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id x1sm6213922eju.18.2022.01.18.23.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 23:42:54 -0800 (PST)
Message-ID: <47891d3a-11fe-ea2a-b2ac-296a51a86a02@canonical.com>
Date:   Wed, 19 Jan 2022 08:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/3 v3] spi: s3c64xx: Drop custom gpio setup argument
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20220118230915.157797-1-linus.walleij@linaro.org>
 <20220118230915.157797-2-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118230915.157797-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/01/2022 00:09, Linus Walleij wrote:
> The SPI0 platform population function was taking a custom
> gpio setup callback but the only user pass NULL as
> argument so drop this argument.
> 
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - No changes
> ChangeLog v1->v2:
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
