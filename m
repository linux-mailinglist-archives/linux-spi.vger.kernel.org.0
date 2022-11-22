Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92665633F1E
	for <lists+linux-spi@lfdr.de>; Tue, 22 Nov 2022 15:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiKVOkI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Nov 2022 09:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVOkC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Nov 2022 09:40:02 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088026B220
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 06:40:02 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v8so10330276qkg.12
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 06:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+FOvmh9any63aYhENKhboGoqz/opZ018HM9vaw+jdI=;
        b=cpTx+k/SZXpl9JQ2gcxIrpXW8vRmNKQ3ZfQF/zjqBRjejrDZk+eH6Y3IkhLYrVAkpb
         SHiDixdnTwKmjW12p5FyxM+z/xRAta0CNLoNxpdU6IipeatwOwU8am4A/OShMysWb8Iw
         HV4MwxzB+xnXUiYKDaysvIT5gIg7frHQCYq9xGay7YVkidK5Vk2GBXw3/T3Q9qSKzJ+/
         +HomYovzAaPOdymfZpoNJfQAjoCDPE+WB+VbvJwJXw1FNwG/ML6fCr9zmUHAOvc/5KBT
         OrySSgTIb3yWchkiIuqlcNvMsX7KVdQrG1s9rINuuMAJUQKmroLdv6HA9fbh4xdu37c2
         kWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+FOvmh9any63aYhENKhboGoqz/opZ018HM9vaw+jdI=;
        b=3H3++vFw0MdsIFHEnf6S8OVsX4z60Uqkq3aJxF0Y6WpDErDbqV9ZjDyGwg3wa/lqmt
         6rxeAx4IsEFKu/lVHJM6P7GginKdI1Swt2NQ3QfQZ2mbfdzW21WRDqGQxizQSEdStZwW
         Akj7gdbk7SvstzHTPenZyJN7hkHyR72sFTIktWIH2Hu2Y3Z/ZmAjIKMNHHa1wTRGrEgn
         4NDBpe7nml9fRHmG8o3fzvCXsxfBr3s1LkCNDJmyLj2h3P2WZbVknwSLtqVHdq5ERtX+
         2WjGXEPevIuFo0revzrcMtnjGW2vhdh/qLxnKPa2mjD2Ju36J/yBn6nqyZejDJSRmK5b
         2Qqg==
X-Gm-Message-State: ANoB5pkiXS9rbnS9IZwSceTC33avXXK3224ptHFgaCFvmYIiUYVRp1vP
        mfuvAdlmyg/0Z6Jaoz871NhD9e5TmlaK8PM3
X-Google-Smtp-Source: AA0mqf5iDK5qbBVOILYXOAk81ayd7By/mJ/oBweezU2BtZ/l2P/MxStHda36kiQGXr0l8u9mNfY65Q==
X-Received: by 2002:a37:8203:0:b0:6fa:3b1b:9c80 with SMTP id e3-20020a378203000000b006fa3b1b9c80mr20815276qkd.722.1669128000841;
        Tue, 22 Nov 2022 06:40:00 -0800 (PST)
Received: from [192.168.1.187] (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id y10-20020a05620a25ca00b006f9f714cb6asm10162084qko.50.2022.11.22.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:40:00 -0800 (PST)
Message-ID: <5c736870-9333-f7a0-5197-98c187a7e5f5@timesys.com>
Date:   Tue, 22 Nov 2022 09:39:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] spi: cadence-quadspi: Properly pass buswidth through to
 underlying SPI subsystem via buswidth_override_bits instead of mode_bits.
Content-Language: en-US
Cc:     "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221122133551.91536-1-nathan.morrison@timesys.com>
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
In-Reply-To: <20221122133551.91536-1-nathan.morrison@timesys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Please disregard.  This isn't quite right.  I'll resubmit a better patch

On 11/22/22 08:35, Nathan Barrett-Morrison wrote:
> While trying to enable Octal SPI mode, it was observed that
> SPI_RX_OCTAL/SPI_TX_OCTAL were not propagating into the spi_device
> spi->mode setting.  This was causing the SPI device to always
> operate in 1x mode instead of the desired 8x mode.
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 447230547945..c92a95bdaa05 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1589,7 +1589,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "spi_alloc_master failed\n");
>  		return -ENOMEM;
>  	}
> -	master->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
> +	master->buswidth_override_bits = SPI_RX_QUAD | SPI_RX_DUAL;
>  	master->mem_ops = &cqspi_mem_ops;
>  	master->mem_caps = &cqspi_mem_caps;
>  	master->dev.of_node = pdev->dev.of_node;
> @@ -1686,7 +1686,7 @@ static int cqspi_probe(struct platform_device *pdev)
>  			cqspi->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC,
>  						cqspi->master_ref_clk_hz);
>  		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
> -			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
> +			master->buswidth_override_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
>  		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>  			cqspi->use_direct_mode = true;
>  		if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
