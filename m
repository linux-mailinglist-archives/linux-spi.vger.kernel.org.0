Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34ED4935AB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 08:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351461AbiASHmc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jan 2022 02:42:32 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54968
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351544AbiASHmb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jan 2022 02:42:31 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9B95E3F1E3
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578150;
        bh=L9y/XoAx3alKVtEFBYMi4cpTE+8aqrKt05yVaek7hHM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=h0RNdCoUufNs+hxMF4RW+DGkKwPGjjTP9B1auDjL9hzX55iji6bTSdw421Cw9CFn0
         kIDgOqQQcIk33AcG3vunXiGz13eeqfchMXf9mTKha12Sl741VmTCL47/E7P3jyy780
         oRpg77MFffRc35uvVULOqFutgptqQh3D2S5h0PPmsPnnXJSXpYLiFVjIwfZp5ZEAEm
         MPZK6s7VT3cUzjjoK68Va55ce5ZwN/WONF/fdMiryJVIEuBRg1OKQ1NvctQJ8S9QhO
         Qy9X3fLyjCeRoVQMl6gawzM9FFQRi2thnVhwxF12wLySAlP2ouA7KxOebCSqz/YBh2
         UMdlL0zz68IzA==
Received: by mail-ed1-f71.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso1467193edb.10
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 23:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L9y/XoAx3alKVtEFBYMi4cpTE+8aqrKt05yVaek7hHM=;
        b=ac9oCWmmcsRzBtsk5xFOTG7kzzaVtr9NfYaMQAuS+Uf4XMfMD6jthoj02NQ9AER8tO
         C+iWcQXoABchG7ilqVUCwE0r8hl552GYUaWuz6F4LSWx60XZg80GBpSPZaW0hfUk/JHX
         LWvXVFi/41mjFOKcgDlKMiRKjVnpE754nnxGsKDhjxfBejaYE7Hc/IHCPPbbvNlVJe3R
         XzHCk0+10BWDcBLp4y//6XPZPDGNDlrE+6P59VGtSyte1mPK9m1H7SuyrFvt0HkLTHWm
         2fZx0RCdnzrH+tCQ7g9q9ZsEg0DOzJg0JM+Z3tw45IlL+QrT+ZDbju4u7tRQFA/hEC93
         ygYw==
X-Gm-Message-State: AOAM530vDSr3vDP9T2lit8ImypQvQLcdkHcva7HM4SUHPoFpmlCRiXxA
        OOXL3nWHOHfJY7g/r6ncjE6Nsi3cHD0ndtCdzqyQK3yQ2fyEPNBedZhVPLlmcCDkFna9ckorXga
        d2idSp2c4pzXkBhB71E3EG/3s8y0zQRFcJvxnlA==
X-Received: by 2002:a17:907:7fab:: with SMTP id qk43mr24694922ejc.692.1642578150011;
        Tue, 18 Jan 2022 23:42:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzSj9hUB3m7E2MSMK3BWC3imXfCWYV+H3k7Yq7eNkS4AAxdgYzMQT8BzkrMQ7dF+1eNMpaHQ==
X-Received: by 2002:a17:907:7fab:: with SMTP id qk43mr24694910ejc.692.1642578149815;
        Tue, 18 Jan 2022 23:42:29 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w11sm791712eds.88.2022.01.18.23.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 23:42:29 -0800 (PST)
Message-ID: <0cb6ef1d-a3f9-88ac-597f-bc9b229a795b@canonical.com>
Date:   Wed, 19 Jan 2022 08:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/3 v3] spi: s3c64xx: Delete unused boardfile helpers
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20220118230915.157797-1-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220118230915.157797-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/01/2022 00:09, Linus Walleij wrote:
> The helpers to use SPI host 1 and 2 are unused in the kernel
> and taking up space and maintenance hours. New systems should
> use device tree and not this, so delete the code.
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
>  arch/arm/mach-s3c/Kconfig                 | 12 ----
>  arch/arm/mach-s3c/devs.c                  | 72 -----------------------
>  arch/arm/mach-s3c/setup-spi-s3c64xx.c     |  9 ---
>  arch/arm/mach-s3c/spi-core-s3c24xx.h      |  6 --
>  include/linux/platform_data/spi-s3c64xx.h |  8 ---
>  5 files changed, 107 deletions(-)
> 

Mark, please take it with SPI patch. There should be no conflicts with
Samsung SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
