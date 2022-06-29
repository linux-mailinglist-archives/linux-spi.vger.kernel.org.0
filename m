Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5D55FBAF
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiF2JTc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiF2JTc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 05:19:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A24369E0
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 02:19:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ej4so21303204edb.7
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=owp2sKpOvZLelw+J7uoupyFiJ/5VI7r+UIGpCWr6KDM=;
        b=Ja32fG6hA1Xk14bswf5jxwDw5I3IUOyEzphOyI0UMmMNSH5k4HmoGffQJpVnExxUL9
         B6B+/dk2yvniR2xiZrxGikeCOS1+ThIaKFWX6N6YuaWFHin1mnkfYMj78Vq4FhNF/Laj
         Jn6t1UahZZU/KGHy4lc53aGrQodz01a01rjb4WXyC7gOCuuvjZwE4PzXWWg9yM+Mm9wX
         eX+VKEUAYVwLNzzo/mUTJvksmaWpBAN9iqSQ8PLigMhFDdDnrmALTeWiTut7kiccXoPK
         5LStDVl22Jsv+i6sn+W9m7rUQWkdSWNZtZaOBWIAR4hmRmLTOUjtI+8vNvG+fgazkyB4
         a8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=owp2sKpOvZLelw+J7uoupyFiJ/5VI7r+UIGpCWr6KDM=;
        b=33Z46F/74AprtcdnE49tmPT+VcfKCxWF/fR2cbJs8m4VMqEUfSZqW00zoBogbdL39+
         aHnD/AZTn2rO8pmBksxsCqDi2Ph2PFl+i2DCHWwyF4PHoEXH7K7WztKxRNI+HzydHNmf
         ujN7ahGdh8QDZ14gG8lQQLoIazCGJSc15QcpfhLsIlwr9eApuewbvRF2B6u+hE1H7MdT
         N+VDSkH8lWAQAtYsS9rr48SoCJ4XW6BVi3CygxKq+lKVwKZKGrprDA3GrAQ8VI9LqX6k
         OdckqziG/TltCUMvqfPEhbN6jG6izMnVoSiG9Vk1xC1/CGC2Myxniz/Gk6YL264uzNkx
         NUGg==
X-Gm-Message-State: AJIora80QLhg77rZd4VTPvpoWiAHAS9ojTbcUVb/Y1PqrhP+DMGE95Md
        HhS8K+wnE3tZYeUHnAx6aYycSQ==
X-Google-Smtp-Source: AGRyM1uKnAZkB/DxDxKRkat8hrZpbm+OcAgU7aRZNF9rRAEBkxOgdV6PlFEgHSSa3ylaKpJ+5+Xafg==
X-Received: by 2002:a05:6402:520c:b0:435:af40:8dc6 with SMTP id s12-20020a056402520c00b00435af408dc6mr2907592edd.343.1656494368874;
        Wed, 29 Jun 2022 02:19:28 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709061e9300b00726f520bba0sm1093923ejj.216.2022.06.29.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:19:28 -0700 (PDT)
Message-ID: <218135d6-b9f8-d1e8-453f-d7715387ff32@linaro.org>
Date:   Wed, 29 Jun 2022 11:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/4] spi: s3c64xx: add spi port configuration for
 Exynos Auto v9 SoC
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220628044222.152794-1-chanho61.park@samsung.com>
 <CGME20220628044432epcas2p2e2b4c0d52f11c0bf543c537e819224bc@epcas2p2.samsung.com>
 <20220628044222.152794-5-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628044222.152794-5-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/06/2022 06:42, Chanho Park wrote:
> Add exynosautov9 spi port configuration. It supports up to 12 spis so
> MAX_SPI_PORTS should be increased from 6 to 12.
> It has DIV_4 as the default internal clock divider and an internal
> loopback mode to run a loopback test.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
