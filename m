Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F284674F68
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jan 2023 09:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjATI0F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Jan 2023 03:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjATI0F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Jan 2023 03:26:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB86C13D
        for <linux-spi@vger.kernel.org>; Fri, 20 Jan 2023 00:26:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j17so3423675wms.0
        for <linux-spi@vger.kernel.org>; Fri, 20 Jan 2023 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTRZvfgys5BMzm7lyZzx3IwyLZCOTcEWGWGvAUBCun4=;
        b=x18X4m58Ubq3+tsZ5sfAsS1lmtZyDd08w0d5HhTMqf3E0diwMxz9Mqpq+bucvaETHn
         eRTVA/rwPys0U5qH5UxUyjhZBWQQ8l7GRb734qtXRE0pwy4NZ32lkndN/X6XsZS3PAa3
         ynwIBUu38PLRm+7E7l0LHFs0Y3/9nIObIIiUs/gCjkKn5mg2kuBTd1z56x0Kl07VL1mc
         zMgaqas7t7HuHoXwkIWtp4ySV4OrhGaZWDRIk2JOzJrLH7pWM7Y7Ax/wb4udgxY05qwf
         RagW5DsO6P+lF5MorXsMCnmoROhTvJ7IM9Mki4C1sLYrrsDzwEEcPFe9nCqhhofX1bd9
         Jeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTRZvfgys5BMzm7lyZzx3IwyLZCOTcEWGWGvAUBCun4=;
        b=uZMH0IKJs9qOq1OO+rqRsQO4No9turGHBblL4wN+bZWp4CmOWUAxiu7Q+jhK5qbfUS
         qy3U3omu8D206vSXvclw2OnqD4UE5e+fGiOlrmVV1mM6XPlHwRM1vvE4h5PXGHAg5VZ9
         A+xxcqM+d6EWk31dZ5YeTXMGgSAclZD+sO1TpRaHckm5OMLcOt+DVXcocyJYbvdRxdMF
         UnY5ltyEutwTn6ctV/6ufET7OLUmr2lKTBsSju3ZcU+VVNGD2xOnHPB2uVsMzDlbSc8e
         xTD533Yudq+In4ukO1YavCGQ9/45VZgwKZ8H8MsuTb2121IC6pSH7es4i3jba7g8tDiw
         2Gag==
X-Gm-Message-State: AFqh2kp0+bXiYm/PUcUxjSqI5NLFSPmefK2+W5Z5Vz0Ivx9XgmDsl5K+
        v5c5zpwuAmjiOUH1lwUK9f8GHQ==
X-Google-Smtp-Source: AMrXdXuBGs2ahzP+zP0qO4mSMKPgoFnX6XiCqs04Cf2aJRXt9rHNIBQbQxnFLrwuJ+Y7N+39Kjt9lw==
X-Received: by 2002:a05:600c:ccf:b0:3db:f34:e9e0 with SMTP id fk15-20020a05600c0ccf00b003db0f34e9e0mr9895613wmb.35.1674203162609;
        Fri, 20 Jan 2023 00:26:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003dafadd2f77sm1664880wms.1.2023.01.20.00.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:26:02 -0800 (PST)
Message-ID: <e31fb866-49c4-1540-6fda-6e86ed7bb33c@linaro.org>
Date:   Fri, 20 Jan 2023 09:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/2] spi: spidev: add new mediatek support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
References: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
 <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com>
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

On 19/01/2023 18:28, Alexandre Mergnat wrote:
> Add the "mediatek,genio" compatible string to support Mediatek
> SPI controller on the genio boards.
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
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

Please, stop adding stuff to the end. It leads to unnecessary conflicts
with simultaneous edits and increases overall entropy.

Best regards,
Krzysztof

