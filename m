Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64255C974
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiF0Jih (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiF0Jie (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 05:38:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA0635F
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:38:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb34so17832634ejc.11
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WmPX2C6ydtzsulgNUACIhoIyzrpbFjtqlAVmc9Cb5Y0=;
        b=aehFofxjFQo/7cMNGFiQRHj1heiLQezTlyS2q5e0mcfPdcje6SDmN3OCD323zd5l6G
         t4lNY8etAzjRwW+2k6WCNDhfobk6SjYlW1eBbXaVQnfVUgwBiAlqI4ThZx/eFDrzGGg3
         fOfodhamDL2iguL5s5Hog2nZIQgq+Llz1Wzmz6NvZ2yfzQMSHj3QmS5msOsdRNT0BfMn
         d0qze/kh9RW3HE2gg+o583cSUUhTW+6t+aJpWigvwALMUs4IxzimBWH3TIXVzOGIbohp
         YnRCG25UorinNbTJVOwYRqwgkEUY/4exne6JyBvPianPxCt48I9Ym/j9ivFAlBdQbfK8
         51rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WmPX2C6ydtzsulgNUACIhoIyzrpbFjtqlAVmc9Cb5Y0=;
        b=XxQcwCu78tozSd763HobxKJuuQHOUbzKhFJl6xR3qLYM3Vzui0VAOPPqt2cyQ6v3rX
         Ii9YJBlAheu9T2rkdg1XsW19BCN/XH1qS8JFVdDcRiTs4yxSJq2y1j4eGBDdvPgoi/2t
         TKY2d+8gWGUylQh8OsUjigCySZq97QW8Ezr2McozpWeOT14lH58tAjauterbYTcKJGCL
         MjTHBP/YeNF/sfkzYHx/8AGgegnONL+LgYajeBe1S6c4QPYr26SbMYy+6MWoFPoGqwJE
         wR3qVC1JuTf1HX8oJh+Pas09nGb/i0Dkmmciqjl893N1YK/p24dt5Fc8s/P76m+S07Gf
         pkwg==
X-Gm-Message-State: AJIora/z5Y6XOxU/IgO5uu142RwY2AfQsw8n+fQc0mxFSYb2x+PCjZrP
        IrR4YlWbXBTb69vVY1Iqz45uQA==
X-Google-Smtp-Source: AGRyM1sHkr1iOyFTh+U+1JlBUYNRakdWvy7dUV8jcw5eVFRDCLL0jT9Werrdh+jycbhYMlt0agE/+w==
X-Received: by 2002:a17:906:77c8:b0:722:e753:fbbe with SMTP id m8-20020a17090677c800b00722e753fbbemr11400735ejn.692.1656322711506;
        Mon, 27 Jun 2022 02:38:31 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m2-20020a50ef02000000b00435a997303bsm7142057eds.71.2022.06.27.02.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 02:38:30 -0700 (PDT)
Message-ID: <984a7287-16e5-8f46-9ea7-fa17623f26dd@linaro.org>
Date:   Mon, 27 Jun 2022 11:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] spi: s3c64xx: support loopback mode
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220627064707.138883-1-chanho61.park@samsung.com>
 <CGME20220627064931epcas2p3052d80fd448aed36b9414e7733c251f5@epcas2p3.samsung.com>
 <20220627064707.138883-3-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627064707.138883-3-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/06/2022 08:47, Chanho Park wrote:
> Modern exynos SoCs can support self loopback mode via setting BIT(3) of
> MODE_CFG register. Previous SoCs don't have the bit so we need to add
> has_loopback field in the s3c64xx_spi_port_config. Exynos Auto v9 SoC
> has the bit and it will define the field to "true".
> When it is set, SPI_LOOP mode will be marked.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
