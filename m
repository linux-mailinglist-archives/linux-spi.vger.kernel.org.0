Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2820655FE4A
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiF2LN0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 07:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiF2LN0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 07:13:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21D227FEE
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 04:13:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id cw10so31889747ejb.3
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WTJzaDemVNa9GYFB/sPvmJvxvrpUgdWnsJ/tNPCGDvI=;
        b=vYTJfO9pcIBdilCwjej+17FriFRXXILl/9U5HAxSf9Sg1OQTL2U0W7KOjUpeg5dzkA
         ebX/b5msKkNZ/rXK4DJUrcLdCM/LIcKKAQEcEA9lzVTbpasbvL761Ga5hBbsoz50UTPV
         T/FyXiqQJLfNeGHWzask1bkSyU/aZr24FoezFcpXqTt+a1F+WkeR+//UxrjS7ugsnoQh
         Aa/iQ7elkxvyDlhZzOwSnbkqy22H+OZf7S3x4J/XLJQtpBQgGd1J1xJxnX05Yfs6VL5B
         ETFjbgrTaBZFPlGdDAdZvl8oCA/dTMr/P38Gfx/lZsjilUdG0y9I0VYG36Mk4ZPzuOxb
         pDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WTJzaDemVNa9GYFB/sPvmJvxvrpUgdWnsJ/tNPCGDvI=;
        b=rLVqzBk9b+I0ASQ6x4E0I0B5KSvLbHO3c2TKYdfyvP4GjaM/RyGBVSNIDUJr9a7ES7
         LOfU0zTL/REJCJTqpt/xoZfveDPiQ0vNFq5QqDqWPwgI9D5uIhKJlBcrfxPVgOlOrdOw
         NOPvf3TDVtNa7dVNgO63YGpAPKKl+t3WQd7di1S09mY4DGClIMIIIHi4yozH6fdEkOyi
         zCvYoZ9Oy2OM9XAgDm/jINU4z+CqU2iHsHHd44T9yaYz2w/ZFYEmB5g8+ZFsmJzOyRjI
         rj+GrvI2GMuK3baIW61IKC4NkDxMkZqbWkWXYtyGo7076njRtuU/WTXB4T4yin4ebkiH
         mosw==
X-Gm-Message-State: AJIora9GeZ6dZ8j8AZtoOEd469FzZc6coo3wna4d7Td6coWCr3AoiYkM
        jCL4f/p9c9fexx/kGuGXoZOL8g==
X-Google-Smtp-Source: AGRyM1uW38gvajhhxsuhUb91ole75s+h/dmDc/2trxOPZMZLAK6PPPdZmiJVFjWfLKR3uiRlamReMw==
X-Received: by 2002:a17:906:58d5:b0:722:fc0b:305a with SMTP id e21-20020a17090658d500b00722fc0b305amr2707332ejs.251.1656501203540;
        Wed, 29 Jun 2022 04:13:23 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ci3-20020a170906c34300b00722ea7a7aeesm7576041ejb.51.2022.06.29.04.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:13:22 -0700 (PDT)
Message-ID: <e2d6a3ee-e0d4-07d8-d74a-d06b3e917fd6@linaro.org>
Date:   Wed, 29 Jun 2022 13:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220629102304.65712-1-chanho61.park@samsung.com>
 <CGME20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd@epcas2p4.samsung.com>
 <20220629102304.65712-3-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629102304.65712-3-chanho61.park@samsung.com>
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

On 29/06/2022 12:23, Chanho Park wrote:
> Modern exynos SoCs such as Exynos Auto v9 have different internal clock
> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> value to existing s3c64xx_spi_port_config.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
