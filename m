Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAC04FA6CF
	for <lists+linux-spi@lfdr.de>; Sat,  9 Apr 2022 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiDIKmM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 Apr 2022 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiDIKmL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 Apr 2022 06:42:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50646165AE
        for <linux-spi@vger.kernel.org>; Sat,  9 Apr 2022 03:40:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z12so62708edl.2
        for <linux-spi@vger.kernel.org>; Sat, 09 Apr 2022 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IH+smdr6HwLu60QJ4rEGM3k3Dwd3Lj1hSShNkYwWADk=;
        b=rty0p7mqU35z9SiXjeEgTFu8FRbCxhvexcOsUrlIt2BwWJXSFqETpUfh2SurdgIZHw
         Cxf0QKOMKHkPNrhcH+CV/QQI0ne3PxKaMbZa9I+apWEeb3EmZRb9Xm9DsSqN3fd/y5YS
         pujlC6id7v5BvTbGc3HuJ3meNyErqCDv1e1p9GFTGXZe48ilLPuKzwrjFVesKoG0u3Rd
         WRhs2UyS+RLKF8stOLNdwGkLc1oThzFAxJLrYbxYz1oBgY5hIwVZIBQVuyp2DfS8r7Kt
         NJXmg74A/HlxVPmM6HPI+ZNCN1XkvSzC8vGEn11aQYEYh6aNEXbVNeickzbYxvhJcYfz
         SGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IH+smdr6HwLu60QJ4rEGM3k3Dwd3Lj1hSShNkYwWADk=;
        b=zBqFeHncMDvkUvJURCNLRKU2wk19wTCOjJdVZJkrb1RrDxu3whRuoIHl3dpfIbVP+d
         0Lk6uLtcx3NhIDjSPJVPRIAZMKYAlnobHTTSRT8z+Ld+vtBCWCvtYObRwvgqMA4XJXVB
         cOuuM4II5Zbn6eksR25iYbW64IvLBEO82CAajPGVMf1UZOgdLwkdQDhXCDiJrnRdnSiW
         sqQLDbkqCHG2GSSDx8HxsbcxjAY6MMYUbQWV8xVjJeJqHgzPDNtedSv58AMaO8AtnHPf
         FcyTSNkCqElvYLB6pbKGYkjuzu+ahwiLJArdK1Pi/vMq52uyg88FY4giVl5Z9iawNuef
         drgw==
X-Gm-Message-State: AOAM533D23WuiVdyG3ub8lV/qPV2pcLL+20HniJKC7fxzeBifFWa4NHw
        Zw0rZj4C7XWKPGJGu4DWAyhUgg==
X-Google-Smtp-Source: ABdhPJyKA/1xZ2gv355sS2o5W8tQkWswcamJ0HPKtJp41RHmX4J+r9pD8t6bnrZaAwz6XaMcPo2fow==
X-Received: by 2002:aa7:c58d:0:b0:41d:6d1:6f43 with SMTP id g13-20020aa7c58d000000b0041d06d16f43mr12679263edq.125.1649500801722;
        Sat, 09 Apr 2022 03:40:01 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906c00c00b006e66eff7584sm8204774ejz.102.2022.04.09.03.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 03:40:01 -0700 (PDT)
Message-ID: <49c1d200-8c07-b306-a400-86ee6a637bb4@linaro.org>
Date:   Sat, 9 Apr 2022 12:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-2-brad@pensando.io>
 <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org>
 <CAK9rFnyRrS_LvoZ_j66cKDHgecqcqzJN5krSxdCquBanViKyHg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK9rFnyRrS_LvoZ_j66cKDHgecqcqzJN5krSxdCquBanViKyHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 09/04/2022 04:19, Brad Larson wrote:
> On Thu, Apr 7, 2022 at 11:45 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>> Change from V3:
>>> - Add description and board compatible
>>
>> That's a bit confusing... the subject is for v1.
> 
> Goal was to identify in the cover letter patch the key changes from
> the V3 patchset to this V4 patchset.  Then in each patch that had a
> material change highlight that in the patch itself.  Will try and make
> it more clear.

This is fine, I am talking about the subject - it is marked as a v1, so
it's confusing to see a changelog.

One way to achieve this is: "git format-patch -v4 -11 ..."

Best regards,
Krzysztof
