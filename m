Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8224971774C
	for <lists+linux-spi@lfdr.de>; Wed, 31 May 2023 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjEaG53 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 May 2023 02:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjEaG52 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 May 2023 02:57:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C889124
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 23:57:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so5206999a12.2
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685516232; x=1688108232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zT4hWvO+05+c9BNBT9jLKJhOVWpxKJ0fJ2bZlxyHp3w=;
        b=fMFgfFRH2oKpRqT2ngwoG7OVNjzftGze+7bCsyKX8BPD9bFqofDMAUVPCoEnQHK7YZ
         P9GIyQhfD38i4+ZCGDARXcEYm6X5cRIC4tL5T+qbNbkgeShDMzkTLWzr9oYDt0+f+JWl
         lHzDF1iYCMCPrdpof6K5qUxlFGUwcFYF/GLZO65/NMu6OKwhNzWz1cd/d8wdE+j3pUOz
         lMePApuIuf6d/zdItcp1XEsmzrxB6T6pgzjGopOR1xlFS+ZkuKGA7bsqaJpY4Q6LL23f
         uvstk79rsZFVpgFpPX5fCbzRB2qe6jaDE4E+ZywGX9/CsaInpvUDHcLgwfmb322vcwZg
         ruCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685516232; x=1688108232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zT4hWvO+05+c9BNBT9jLKJhOVWpxKJ0fJ2bZlxyHp3w=;
        b=We3gCEpcspi+g+MrrB+9B9AGfI+PkFm7UaIXWxyM3fJm6ziJ66ZmL1wRIA368VTVGJ
         6okvI8AFHASb+XfFG48CVGo8xBHrLH+u3kFUS/lfCWgA1e7q1y2FezICIwIeviE3Wi2O
         zNG7iGrH5jh8wQuFhVfxYEuMx/uXVwkW4ht48SJSMZs4+t/MGlL7WdNcCimEYAVmY8Zt
         HEsDPgpM961TOVkZiBRZyARvKjn32B2oEJw/xrAvgZHIZ4FzfXCAXu1XwlVH/pmUmPGt
         zdRT1LxM8dgcgajj5kK/kA13lxBJs49J11NIrolPtkom412wzUCztbT+puJqsljSc8N3
         dlyw==
X-Gm-Message-State: AC+VfDxBHi6dbRl5sC2v332Ia3F1zf8o4UNc2+5dQpDpqzRYOETZr8Zj
        h8CTEpj/43y75MbEXfEs1gARzg==
X-Google-Smtp-Source: ACHHUZ5x5SACtt0xW0b6cmpAiNLg6lb938Dymx8uZU0YcrSBw25hfhVk5P/RfqzyOE7B6a2bNngPfw==
X-Received: by 2002:aa7:d591:0:b0:514:c43e:3881 with SMTP id r17-20020aa7d591000000b00514c43e3881mr277960edq.35.1685516232672;
        Tue, 30 May 2023 23:57:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c617000000b005147503a238sm5308899edq.17.2023.05.30.23.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 23:57:12 -0700 (PDT)
Message-ID: <367c3d26-b406-9ddc-e0ca-717994ed1c4a@linaro.org>
Date:   Wed, 31 May 2023 08:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] dt-bindings: restrict node name suffixes
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530-banister-luxurious-d33a5d289749@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530-banister-luxurious-d33a5d289749@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/05/2023 19:11, Conor Dooley wrote:
> On Tue, May 30, 2023 at 04:48:44PM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Tree-wide cleanup of DTS node name suffixes "-N", e.g. "pwm-5", so we allow
>> only decimal numbers.  In few cases narrow the pattern to also disallow
>> multiple suffixes, e.g. "pwm-5-5".
> 
> I figure there'll be quite a bit of stuff to fix up afterwards?
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Quick grep shown zero fixes needed.

Best regards,
Krzysztof

