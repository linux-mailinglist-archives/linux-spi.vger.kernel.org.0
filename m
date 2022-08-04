Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6403B589B1B
	for <lists+linux-spi@lfdr.de>; Thu,  4 Aug 2022 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiHDLfw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Aug 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiHDLfv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Aug 2022 07:35:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEED39BB9
        for <linux-spi@vger.kernel.org>; Thu,  4 Aug 2022 04:35:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r14so21859854ljp.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Aug 2022 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=0q1bitm4M5CudI85IbH4G9Zd55yJ1C186Y4eCrrx0yk=;
        b=gT4YYAZ9xSgLdp5459oAq+PFI0Za7+SPTzB+jRk4icnwjEWiZQRFCYVYCVZ0Te6uuJ
         /oWSpie++3gem9IxnvVf9gpT8tExhkgJhbYFB0hxGfBKLp15iWaC1iIiqp+UcUHV3fZR
         djWOdJJz0XX4llpBqv1KSz9aHn6gJUbB2pWoDtcfT/D0iWcSmpxH6ScoQDQFgeM7MSg6
         Ngi09PncKwCgCAKO4PWy9eBqPCtnJKM+PCnYKPnreJV5YmS7m/Mevp/eVFsIxRFBJyRP
         R+b06I5VT3bkVwkzIt62/v7TLTPoVjC2zi+Y+QyCMH3y1kuKG27mNNKWAcawAptMylXx
         Rf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0q1bitm4M5CudI85IbH4G9Zd55yJ1C186Y4eCrrx0yk=;
        b=k9teyGZE+iOc2YMcLhByZsJdZAmxHPjeyU5lyy9dn4CGv/Oj4ROsZtzWhmCFhNdKAe
         VQe+D+u6JWfc2knqSZs5FBbi6jiZayZPraSY4O1OY6nel0nY4yQFJMuxr8UqcHcSQOPW
         v/ITakMQDO0TByOD/sj8sjQhDqknYhesa7Cy0NdCqDVSqs3M1mpSwbGFaaJGfX4LxDOW
         uujfY32V2gJfFMJU60tnrAcDi4inOi43h1J1pRk9qMq+OICinmzYQQd2N9lqamxgml7J
         Yn10QDQZyTzPt7tp6OJcM/M8yEyFT11zXByVYM2SDapY9mAX9OKWFTn1Z0ZmTh1ulsSt
         nInw==
X-Gm-Message-State: ACgBeo0QMLlNUnyTKzoTGMxNqiMbC6Hr7JLWhCJpvehjmKlcgu2Pv4CD
        gbJXRR1znsESIitAjrA8rqbFQQ==
X-Google-Smtp-Source: AA6agR60fRqF3iLSdJurOEgar8fKn1Rz/StDUIa+ttGkqSTh+i6K9BBuTHTW+mJ8+n1WnawlJ/dpEg==
X-Received: by 2002:a2e:a4d6:0:b0:25e:439e:39d0 with SMTP id p22-20020a2ea4d6000000b0025e439e39d0mr443304ljm.169.1659612947660;
        Thu, 04 Aug 2022 04:35:47 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id bf28-20020a2eaa1c000000b0025e59f125fbsm96303ljb.53.2022.08.04.04.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:35:46 -0700 (PDT)
Message-ID: <5b65d6c2-7ca8-b963-24f7-1d02328fcad3@linaro.org>
Date:   Thu, 4 Aug 2022 13:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk>
 <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
 <Yup4JLh00HZxFQLc@sirena.org.uk>
 <b9cc3290-f0cb-0423-7ff0-dae40b52a379@linaro.org>
In-Reply-To: <b9cc3290-f0cb-0423-7ff0-dae40b52a379@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/08/2022 13:31, Krzysztof Kozlowski wrote:

>> I'm not convinced this is a useful rule to try to enforce, and I'm not
>> sure how well it will work if the same IP is used in several different
>> places.  It's not clear to me what the benefit is intended to be.
> 
> First, the description here is really not adding any useful information.
> 
> "description: Microchip's Polarfire SoC SPI controller."
> Microchip - already in comaptible
> SPI controller - already in compatible and in device description
> 
> The only useful piece could be extending pfs to Polarfire SoC.
> 
> And now imagine every binding doing the same, adding such
> acronym-explanations in every compatible list. Basically we loose easy
> to read, compare, analyze and check for errors enum:
>   enum
>     - microchip,mpfs-spi
>     - microchip,mpfs-qspi
>     - microchip,coreqspi-rtl-v2
>     - microchip,mpfs-some-more-spi
>     - microchip,mpfs-even-newer-spi
> 
> into double-sized oneOf with additional descriptions each one explaining
> "mpfs".
> 
>   oneOf:
>     - description: Microchip's Polarfire SoC SPI controller.
>       const: microchip,mpfs-spi
>     - description: Microchip's Polarfire SoC QSPI controller.
>       const: microchip,mpfs-qspi
>     - description: Microchip's FPGA QSPI controller.
>       const: microchip,coreqspi-rtl-v2

Just to be more specific - this one description actually brings useful
information (FPGA)... This can be easily added as a comment, if anyone
finds it useful:

    enum
      - microchip,mpfs-spi
      - microchip,mpfs-qspi
      - microchip,coreqspi-rtl-v2  # FPGA QSPI

Best regards,
Krzysztof
