Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C2F58F09E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiHJQok (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHJQoj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 12:44:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2A11A0C
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 09:44:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u6so11324510ljk.8
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VOLDuPix/0lVR9yaNuPldPK7FBAubvn5P7aOtNnMozY=;
        b=PxOmy31FMgnLAPzakLjut5vLpoUvufDZnrYVP17Y48jyHAinJzMIaKywcuoaJwPKTg
         eQCMfxVEJA2L/CK8eGRqltCaWjIRMUQglFpEZvF+ERgJxnOwpG/cbVif0yKnx9z7Snow
         SIM9KFxcdIhwV7AXsMMc1Py8OH9T+iO7fMMrI0eSP2w2qB+CTnnXbjcQrYDo7TQY9vfA
         D51wlzvZ+klATs1G6HpGHcegPyR7hZCN7A4kOVmw6nEHCxN0XNAZIkPJshHFg9Qi1hsM
         T08q9GkKN8t7TvEF/iUm+ruwky/ZEt0E6lvjtiRTroHzQjvUXDeK9aj1XR2+5kgZORG3
         Tosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VOLDuPix/0lVR9yaNuPldPK7FBAubvn5P7aOtNnMozY=;
        b=sm6dK30k/KxxfL37P31b6DnwaLsL1eieu8sqgyIeIEjfIw12jVzP0uunOqXDU5Xzha
         j5K9hM6QgdV+zRIDXx+XKqSClO+KokaIOcWZIuemCs2KFoVdG/Jvv57BhoVxcsOEyKMV
         TIMf2qSMd8TuijQcsH7nCkbugcfPzJbLC6dXgSQBFoJBYeQbNcIkycuLUmoBXNrfXrkQ
         9mnbVm/7WexTK0ECwvd/ojkEfkazOT9eJlG3oTYKJSRYbL3hk+VaTMsFWOB9keC1nAh+
         W44PeEICP/DOrgdWC6GZvHtUlrlcsJxJ+3oXW+pJCE2/dQrdssN2sCHjnPDZ44XirhlJ
         P1qQ==
X-Gm-Message-State: ACgBeo35n7P3iRdyg9UMwtoZGWkrdhyz7VW6mQ7lH3ejLVVIRGSCYB6Q
        DBI9rCAtDFZ3j2TwxqjN39OcTw==
X-Google-Smtp-Source: AA6agR4eoACd1ljMRqSIXs9EqFqbtjFc5gnzr+PoO1i7OTkPo+HY2BZ5YR46FSliA7NymB0fqOuUTg==
X-Received: by 2002:a2e:81d2:0:b0:25e:68c3:f434 with SMTP id s18-20020a2e81d2000000b0025e68c3f434mr9196641ljg.526.1660149876935;
        Wed, 10 Aug 2022 09:44:36 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0025e0396786dsm466556ljc.93.2022.08.10.09.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:44:36 -0700 (PDT)
Message-ID: <4e096cc4-a012-8ef0-d5a2-1a32d1f6c83e@linaro.org>
Date:   Wed, 10 Aug 2022 19:44:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] spi/panel: dt-bindings: drop 3-wire from common
 properties
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20220810131311.428645-1-krzysztof.kozlowski@linaro.org>
 <YvPaaOgCUABREOcX@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvPaaOgCUABREOcX@sirena.org.uk>
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

On 10/08/2022 19:18, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 04:13:11PM +0300, Krzysztof Kozlowski wrote:
>> The spi-3wire property is device specific and should be accepted only if
>> device really needs them.  Drop it from common spi-peripheral-props.yaml
>> schema, mention in few panel drivers which use it and include instead in
>> the SPI controller bindings.  The controller bindings will provide
>> spi-3wire type validation and one place for description.  Each device
>> schema must list the property if it is applicable.
> 
> What's the plan for getting this merged?  I can just apply it at -rc1 if
> that works for people?

Ah, I should mention it before, my bad. There are no dependencies, no
stoppers. I hope this will go via your SPI tree.

Best regards,
Krzysztof
