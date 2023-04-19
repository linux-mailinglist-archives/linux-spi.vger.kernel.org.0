Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7F6E74BF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Apr 2023 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjDSIOG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Apr 2023 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjDSIOG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Apr 2023 04:14:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C9138
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 01:14:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id xd13so45542364ejb.4
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681892043; x=1684484043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhQTFUqxL/O6643fDSSoSsETDXYAv4dskz8SOtwED14=;
        b=qm7L/uI38hNO7K25hIzjljA6TS3z+1GhbX80s9u0+gsCU9gjC1yqzZjjZ6IrI8TLj9
         +6tPFvEx4YXyENHA4uSqT1ex09scO3tE9K7gX47/XUxyi2tO3oURSdFmWiU212hAcZWF
         6fLNFS9h7QDXY2fGJQGgGEwKMN1ElDy2x/CWZSHP2CeNSUEacMJvBK+6zi18UZuHp2H0
         mbC3cuSd7nrdW1hU7zfHf71wq4S9lEdLYYmow8f3R8yBeZKy/3fI2gAXNPDD7UDEBQFf
         0Vsg/LPhP8sr3XAhZUraMq8Yek2ee2mF+QiOUxwI2pxvIm6O7psUBSof41456nfrkGul
         7cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892043; x=1684484043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhQTFUqxL/O6643fDSSoSsETDXYAv4dskz8SOtwED14=;
        b=BcQTIek8dCORL0FqfM8PUTuPSjKC897ZZcQa52rAiwjSml4QmfjmVgg1hsHlUyRjql
         6XBIi+Cb1v/GaTaSjELFsdAlZOKtmkInCgLbnYRVZR7darqDmnjWigGUAQi5STNd7pde
         dwpc1jobJ3KgBa50c80bx8/awaAlxa4esdHMh4FtuwEPfCvDNNt4Grby6uk4mhHhwnJ1
         X+b3chHvRNp4s8zCXig1Z5W3O5z3VbdokeGW6ldPLV1Mm3q8TT0aFL8EVUQFa/rowZRi
         j8tvKhDJIrRgLqGdcJqkKQw9tqNMcwnu2VeSzcKxUht0YKoHr/oZAPCf2Jf7i6nBM3ym
         Ip0g==
X-Gm-Message-State: AAQBX9eI6qbrmZj2qHis4Oneh+kk6xOLixAUCMHZmjb/CP83UBE03sk5
        IkPU6ZU93s0j9qgm+mE1krFiLg==
X-Google-Smtp-Source: AKy350b9AjsV58l2IRVNhBCH2Z5PcQLEDPMWjJpw05daiSBTBqGXMNL+pH2zgPhEYJ9tmvxyeb/0tw==
X-Received: by 2002:a17:906:a408:b0:94f:236b:9e3a with SMTP id l8-20020a170906a40800b0094f236b9e3amr1516618ejz.3.1681892042992;
        Wed, 19 Apr 2023 01:14:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id ss2-20020a170907c00200b0094f4b7e2dc5sm5036143ejc.142.2023.04.19.01.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:14:02 -0700 (PDT)
Message-ID: <36f37a18-0022-0368-bf7c-ebdd724b1558@linaro.org>
Date:   Wed, 19 Apr 2023 10:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: add cpu_relax in polling loop
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p43a646bbae5f01e3120331407ad873318@epcas2p4.samsung.com>
 <20230419060639.38853-3-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419060639.38853-3-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/04/2023 08:06, Jaewon Kim wrote:
> Adds cpu_relax() to prevent long busy-wait.

How cpu_relax prevents long waiting?

> There is busy-wait loop to check data transfer completion in polling mode.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 273aa02322d9..886722fb40ea 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -568,6 +568,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
>  
>  	val = msecs_to_loops(ms);
>  	do {
> +		cpu_relax();

Shouldn't this be just readl_poll_timeout()? Or the syntax would be too
complicated?

>  		status = readl(regs + S3C64XX_SPI_STATUS);
>  	} while (RX_FIFO_LVL(status, sdd) < xfer->len && --val);
>  

Best regards,
Krzysztof

