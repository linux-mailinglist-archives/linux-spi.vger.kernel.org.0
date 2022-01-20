Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6366349485F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jan 2022 08:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiATHjA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jan 2022 02:39:00 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44578
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237923AbiATHi7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jan 2022 02:38:59 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A6E2E40018
        for <linux-spi@vger.kernel.org>; Thu, 20 Jan 2022 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642664338;
        bh=0gpNGAIZUvaAFCEEngb7bqQ3pJf9wcbsyhNpAPF2548=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=XDgIUFlRZI/o9sDflzEk4Xrp6v/rMJxIRceDNP2yS/qTXe62maCGQOHc7uayKmt3P
         L9dOI2IBG7xLCxWxRenLYxQn7LpK5DOUYuHsb6+SdYMHY69xw4Sx9qLU9T7thoEvnO
         4z9MLT4F/3DHbQZmRHcwmh42RNOPyMyC3rBGwo14Mjeh5qRsThrk2RtnPYc1BFo6HX
         rYY0Ept8mXzHUzR+549UzWA38XBH/9EUatLrbKKwCcNJIYOxERncX7hpIgzh2EVS4X
         lIwsxO2HgsrFiCn4huZ3S3rxVsaNKzfGYxW0wd70va+VHAZJt1yw3vEswb8EkaeNZp
         TfQ5xumYxlgbw==
Received: by mail-ed1-f70.google.com with SMTP id bm21-20020a0564020b1500b00402c34373f9so5116591edb.2
        for <linux-spi@vger.kernel.org>; Wed, 19 Jan 2022 23:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0gpNGAIZUvaAFCEEngb7bqQ3pJf9wcbsyhNpAPF2548=;
        b=su2M4KskhuB4/8PihQid2NhtLT/JJKRvfxRojUmvEHe4Xyz4veZ7oEv1cD+Ijo+0OE
         QTm7s4K+IDuVlTT2GyCs+aRaGh33o0UVpnayLRTssGu77emb2m+z5R+barota2Crj/Zu
         ThftY3mBfUizT37piSCNmJvIcrw0ZfakTBrxbkuRAsItnb3BetTn8gb8BmsUDutHSfOs
         mFaeb6Y6HvBlEstavSZqPlmwNvFfsVOjX7fRS+VJoyjo6la++4MWaTdmSsYcpqR98bKh
         aA0/aKQdU+hr6WYg2uWx4rvBwdgooeI0OKLVJoTD8BHaIpoWdrrMTtI8rZgJJdtur8BY
         HZ6Q==
X-Gm-Message-State: AOAM531E1ZnV6epQcKzzrn9HPHDvUDa1gfrPbaGGz8lzCTZkny5mfHdJ
        DjGQ/YWQXj0dhLlhdYh1wjOYcXhpRgd8Bmw56ahu9kMivA6XVvLchfPqumQHuLpYkJp7a/SQYf4
        E3+vqkuJ7Ce2uSo4HeRKW8Rp1sI5E5Hafc+OuoA==
X-Received: by 2002:a17:907:7254:: with SMTP id ds20mr15521209ejc.465.1642664338300;
        Wed, 19 Jan 2022 23:38:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKs2IK5wcPycxUw3JnhBFe57akhy4R0/FDvMPVQp5/0cA2GrReDFnA7GWJ6xzUOYSwTIiIdg==
X-Received: by 2002:a17:907:7254:: with SMTP id ds20mr15521189ejc.465.1642664338042;
        Wed, 19 Jan 2022 23:38:58 -0800 (PST)
Received: from [192.168.0.45] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id c1sm628611ejs.29.2022.01.19.23.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 23:38:57 -0800 (PST)
Message-ID: <5d16420a-4852-ab29-59d0-b100feeb2862@canonical.com>
Date:   Thu, 20 Jan 2022 08:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 5/5] spi: s3c64xx: allow controller-data to be optional
Content-Language: en-US
To:     Andi Shyti <andi@etezian.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>
References: <20220119201005.13145-1-krzysztof.kozlowski@canonical.com>
 <20220119201005.13145-6-krzysztof.kozlowski@canonical.com>
 <Yeh6x6U3tA7y5gvF@jack.zhora.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <Yeh6x6U3tA7y5gvF@jack.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/01/2022 21:55, Andi Shyti wrote:
> Hi Krzysztof,
> 
> On Wed, Jan 19, 2022 at 09:10:05PM +0100, Krzysztof Kozlowski wrote:
>> The Samsung SoC SPI driver requires to provide controller-data node
>> for each of SPI peripheral device nodes.  Make this controller-data node
>> optional, so DTS could be simpler.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 8755cd85e83c..769d958a2f86 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -796,16 +796,14 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> -	data_np = of_get_child_by_name(slave_np, "controller-data");
>> -	if (!data_np) {
>> -		dev_err(&spi->dev, "child node 'controller-data' not found\n");
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> -
>>  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
>> -	if (!cs) {
>> -		of_node_put(data_np);
>> +	if (!cs)
>>  		return ERR_PTR(-ENOMEM);
>> +
>> +	data_np = of_get_child_by_name(slave_np, "controller-data");
>> +	if (!data_np) {
>> +		dev_info(&spi->dev, "child node 'controller-data' not found, using defaults\n");
> 
> "not found" sounds like an error; I would just write something
> like "feedback delay set to '0' dfault", you also tell that the
> default value is '0'.

Sure, I will rewrite the message.


Best regards,
Krzysztof
