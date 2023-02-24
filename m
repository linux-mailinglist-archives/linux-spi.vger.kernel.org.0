Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F186A1B20
	for <lists+linux-spi@lfdr.de>; Fri, 24 Feb 2023 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBXLIY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Feb 2023 06:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBXLH5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Feb 2023 06:07:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D903A658CC
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 03:06:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv11-20020a05600c548b00b003dc52fed235so1493280wmb.1
        for <linux-spi@vger.kernel.org>; Fri, 24 Feb 2023 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8+KG9Lss35AgKsD2deDQdWBiObYp8x3Dj78xnPvays=;
        b=aAxP8dI4CizjnVPw4yDMsMmam7lj+/rbtni62C2JjZbQstomWa8MjvaHCT7aoJOU/i
         1AaNWEWRYJdzbBWnEbkvMLEt6lYqEpduwK03PVwb/kaeAoW/wq5ugWwHo6/80gTfpVle
         Zdt62TWB9XRuMIoYE6i+EW98csU2GpYNC7I0ES5+E3NluDqf/iOHMJZNTXqXVDqMHdax
         TUCXqHuUzu34Dco9MjuMSsvM5ShZDKVQxwjvcZWupDY32kSOBrG0A2mJxF+RwZR4Yi1s
         WdGzocv7idxxSkIayKsTcVEXlbBThIxsVmTS4yV+tu1Z4m5Aikj6ldaB4jlaeamrP1O5
         XT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8+KG9Lss35AgKsD2deDQdWBiObYp8x3Dj78xnPvays=;
        b=sanDzb7XdIFdBQmuS9VNPjJlGyFCGgovnQZSVijhEnWkoHFiuTEZgFX7X5tcU2+1bh
         zMNBHQe1uKaHIjSNbr5yY1CuDeODDQcXVJH+jBtq6AcAXZ8hyR6G904SGvDa5NvtE9r1
         iZo1d6PYU3mZlxUpHlHjs+MlFBOrw2D+i2z2vTJ1bfUnyylx/hVWUF/sTpGWTs7bz2GK
         wxk/fMF/YFMB/GymQgZWG0wPU0VhFguFYUqW9N3FUYnqZYbxNKyU9g5BH+4iI2yw+KmK
         qsVBx7MOUYt78K5y4008KWQSU4EJTtHptFkw7w4zbKOfFWeJSswQHuGAb2E1vOVtlAYP
         UeWg==
X-Gm-Message-State: AO0yUKUj0oZuXXx0vIq/aB9yic4BTtPlDm7IGLUcZX29mt3d1/mPYOhJ
        BNH0hj9MA8HZ0AjnA0ihnriSqsv67s8NmDYp
X-Google-Smtp-Source: AK7set8AWvBa0cdeGbXygVLnihKh6/3KoHN3weKUBnuR20XqxrKBhNWvfsWdlylBAVXEkBzuPeZEMw==
X-Received: by 2002:a05:600c:a694:b0:3df:fa56:7a33 with SMTP id ip20-20020a05600ca69400b003dffa567a33mr12100733wmb.26.1677236784333;
        Fri, 24 Feb 2023 03:06:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4a4f000000b002c7107ce17fsm4288179wrs.3.2023.02.24.03.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:06:24 -0800 (PST)
Message-ID: <6c87fd37-6376-8726-b0be-46422b737dd0@linaro.org>
Date:   Fri, 24 Feb 2023 12:06:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] spi: s3c24xx: Only have compile time references to
 FIQ when building it
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
 <20230221-spi-arch-deps-v1-7-83d1566474cf@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221-spi-arch-deps-v1-7-83d1566474cf@kernel.org>
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
> There is a config option which allows the FIQ code in the s3c24xx driver
> to be disabled but it does not cover the inclusion of the API header or the
> variables added to the driver data. Add some ifdefs protecting these so
> that we can improve build coverage.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-s3c24xx.c | 4 ++++

Similarly to patch #1 and #8 - the driver is being removed.

Best regards,
Krzysztof

