Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455BB673F48
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjASQtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Jan 2023 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjASQtp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Jan 2023 11:49:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106E6A4C
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 08:49:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r30so2448807wrr.10
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1zYb7kTowDyYx4WO/wHDGvEDrmcG3mzHWa0V5K3+9c=;
        b=lk9VF/k3N2YcpqkT+LXNcaEu3bDxQaXHwfn+32c1jO0Lc2lPSDAji7akMbW0yEDVuw
         VvZy4QgPNST/ik+Nkfyy7CPT1DS3JOi34Ds9JlCrp0pasUjsVe1kif8bdz61e+yR0TUB
         ub3BCnRA1i0jW0zkkNL43p4Ec+wYOBR/l1XUrDaShiyHLrp3zbsLh2K+YZ/ETVPNgIiF
         2MOHuScvhKHQSDNceND3TAI8M6JW4M9eLzd2Ghcqw1Op+4LnRvHWt8+7NSy+ifKwqumR
         hyjTusbBS7a7Tqs+raFdvSAm3MFfMhIKeBm98x4QbeSY1qErjQSafBNjq/exVL23o/cw
         nM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1zYb7kTowDyYx4WO/wHDGvEDrmcG3mzHWa0V5K3+9c=;
        b=q9NvE0FvNc3twnR0jOv5gCq6P5uiMJhFW2LLTxZ/xdt+D/PKrrI+tGkMM340slbBLg
         8dpQrQQ8cBWn7deesWxJ4aQZ7C9j0qV89T2UICdqPWwrP1mc7RjVN4+VKqZUlli699JZ
         CfPMLbvhlvQdfomhiy/D2mEhFosqP2Jb6/DWsun64qLWfdKu+/w+wXOOVN+seEDywUPn
         JNyMUdf/kI0N6GTZHwFC1yIQ22R2AlV8qY1f71U95dIhUOE+ml/KQlT92OCcl63VliVW
         ilKco+WLQVrge9GE2AeZ4MWfRrAbyHiK5ELWsWeNIRfZe7XV61b9SskmHesYra3Z6v5I
         9iCg==
X-Gm-Message-State: AFqh2koXzv4CiTjkiuPHP/IHc9K/VmGWVJFDTeB35KuJfEpJxnff4H+m
        nLbeEDBNDfJr6N3ipuZgqUa2+g==
X-Google-Smtp-Source: AMrXdXsQtuxwxOCAddUUeO6nawc0o3nR3p8GWKNtjVSi5vMi2XTjtWlqS/S3ALjcyut0AvOObTlpQg==
X-Received: by 2002:a5d:56c2:0:b0:2be:5370:d797 with SMTP id m2-20020a5d56c2000000b002be5370d797mr131488wrw.14.1674146982818;
        Thu, 19 Jan 2023 08:49:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002423620d356sm14001708wrr.35.2023.01.19.08.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:49:42 -0800 (PST)
Message-ID: <60766c7b-abb2-3afb-aa16-0e1385b88a73@linaro.org>
Date:   Thu, 19 Jan 2023 17:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
 <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
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

On 19/01/2023 17:28, Alexandre Mergnat wrote:
> Add the "mediatek,genio" compatible string to support Mediatek
> SPI controller on the genio boards.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/spi/spidev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 6313e7d0cdf8..e23b825b8d30 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -702,6 +702,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
>  	{ .name = "m53cpld" },
>  	{ .name = "spi-petra" },
>  	{ .name = "spi-authenta" },
> +	{ .name = "genio" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
> @@ -728,6 +729,7 @@ static const struct of_device_id spidev_dt_ids[] = {
>  	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
>  	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
>  	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
> +	{ .compatible = "mediatek,genio", .data = &spidev_of_check },

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

