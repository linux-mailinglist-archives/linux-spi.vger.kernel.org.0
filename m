Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2E6A1B1D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Feb 2023 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjBXLIG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Feb 2023 06:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBXLHl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Feb 2023 06:07:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059D63DCE
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 03:05:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bt28so6848122wrb.8
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 03:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgF29zQZT6Mg0I7yMWJ8Kre+Ip94phkA6ddsCuyWXd4=;
        b=zHZt8knLcAVP9TSclnGWHNX+MvSUoDiGULLed416VJDnLGz62EDqfe3wjA4AJVyClV
         5NAcXWKiCnLY2yaDgRE5840hjuF0aRlZjpOVqhkdyXKx8NGj9vyHsupEvtBpHAoqPLQM
         3QETTf01lZUM/VVVlNHwqp7cgRGcr7jTb9bhL3W5s8NT6iSyhYh9I6QcCwr35P9vmOaJ
         p3tJ7uhxlFT0CvJJv8KUcgwH5yjq/e1paRVNuOfAVrV0fq5XVccetOYzZYVNmfgbQYxT
         /zFIKSixsBSj2q70fgAminZeHIGJqbTmQ0i3GBetz3MegitnBq/jawmEbuzjHA4KdjiC
         8ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgF29zQZT6Mg0I7yMWJ8Kre+Ip94phkA6ddsCuyWXd4=;
        b=pNdbguQS0SpFahTVjwKh7gqsZROU8kG4LV+kBGPYBEZ3h9oLmR6knZrArKQcWJpnD3
         VkgcKmT/fzOAVDzXPRzu+wKUoyJRLbXGdHAV/7MM1IUt/oG4cmaY4aOISfW51kJe2jqv
         5zfbTy/+Q/acCZVEOc1jAUjgz8Ny0UWWRV2vdBQZcyVnJFZ4pCXWZk+eQhTYlPBOiqoj
         Xh+EkXnE6vGpy2wLzUg/sCye8GG3Zl9hp3or+8nAtlsj4Wj9MiBY4/f2i1PoKSjoa3uK
         Wjb30czcO4H95bhi1j5v+orGs02S0fMhKVHDKV2Sjg8Ac3hcuDXzmF2mMIii8sS0P+G+
         mitQ==
X-Gm-Message-State: AO0yUKWKqJOX+9Kd0InWV0y5D1atvFkNTjW5D6Y1bIsgTKKIhOvnrVxA
        gd9H4dwqJoaXvL9CkCVxGHP6Ow==
X-Google-Smtp-Source: AK7set/ozjobzdF1CavwlVBU4BCMymB7LiZ1oovhQXKxb+EzrcX48k41XMP54N1cfJSdd2fmLP9FTQ==
X-Received: by 2002:adf:fc43:0:b0:2c7:15b6:15b8 with SMTP id e3-20020adffc43000000b002c715b615b8mr3921312wrs.10.1677236749775;
        Fri, 24 Feb 2023 03:05:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b003dc3f3d77e3sm2413448wmk.7.2023.02.24.03.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:05:49 -0800 (PST)
Message-ID: <2098f8c8-0a40-3817-bf47-5b7a2a62f5b9@linaro.org>
Date:   Fri, 24 Feb 2023 12:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/8] spi: s3c24xx: Fix dependencies when FIQ support is
 enabled
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Eddie James <eajames@linux.ibm.com>, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20230221-spi-arch-deps-v1-0-83d1566474cf@kernel.org>
 <20230221-spi-arch-deps-v1-1-83d1566474cf@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221-spi-arch-deps-v1-1-83d1566474cf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/02/2023 18:20, Mark Brown wrote:
> The FIQ APIs aren't exported symbols so can't be used from modules, meaning
> that the s3c24xx driver can only have FIQ support enabled when it's built
> in.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 6fb17efb35f0..d1ee27d55a5f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -862,7 +862,7 @@ config SPI_S3C24XX
>  
>  config SPI_S3C24XX_FIQ
>  	bool "S3C24XX driver with FIQ pseudo-DMA"
> -	depends on SPI_S3C24XX
> +	depends on SPI_S3C24XX=y

The entire SPI_S3C24XX driver is now being dropped (through Arnd's tree)
and should be gone by v6.3-rc1:
c9dcd56feb82 ("spi: remove s3c24xx driver")

The patch is not needed.

Best regards,
Krzysztof

