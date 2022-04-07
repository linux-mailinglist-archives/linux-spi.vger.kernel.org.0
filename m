Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECF4F8779
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbiDGS4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiDGS43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 14:56:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF092C1
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 11:54:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so12757931ejd.9
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P5t7OevoqfgFjRrAxyC45i6wviQtAlsVjUBZbWy7gH4=;
        b=KL/jdqB/8wdHm4tVl+cty3roBUjEw3Xvp55KEqJIMDyghPTHAE0/0T73Vd1qsKJxin
         5+YJC8KR/eytHSAoJ6LIrG5Di+EIl7xOGc9zdSUw+zGv0Wi41TCRv/qpA2nov2p8/yCt
         XATM2jxZJLIAX/CKfNSEoGfFNp+SIFMAWP+sezxJUrUgekOvp1DIIeP+HAZ01uC2tR0O
         2J3yaYFjUv/mbjagVfCubLMLtnPEpZV9JNecY+kqDzwvHBnx0MH6dko+rasZiCf6GnjY
         5y1AC2uDPaL3nLiPAPLc1doKpIV2oTGzQgXJKd6nxUwl05S7APxhLtM7MhcuDJph+mSu
         akfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P5t7OevoqfgFjRrAxyC45i6wviQtAlsVjUBZbWy7gH4=;
        b=1PbnAZiA+YBvan0GueSU6yP3REIqVK3EU5RamN62ickawifhQiTWMH9H/hQoEtua8O
         HTv0B58fmRJGLCXqi4wgsq1fyThCMTTnVbe6eRSTmLUhmv6/eKMs1SqvYTK5T+IgSwGp
         IFfogDim9otHKkk24pdhyKwJgBYKFch9mRTQwE1QT78eP170JHzcu5qU5kFoUPcYvUcB
         spWyxjXqZ9ScvxMlZQ+UhR1/5B8FXr/SD96KMmjKR3qxSXRUhraEoOIOpXE+Aia+ItIO
         I3O2QDk6+/PbUYXWoYzSjZJPRBHKDfRzaqaNsSqMOnvyM4EpRyZ2VB1SugDG39DQfVZT
         7NRA==
X-Gm-Message-State: AOAM532d43VrTbEHHDJG8BzfgI+KOM9BDV1h6R0JX3uJBVLY645mGoyE
        sRRrmB9zmWMqYxp6UfRzs4EzyQ==
X-Google-Smtp-Source: ABdhPJycXKO2QYwQvSX8Ts92BaP32pn1JJgkuHfAY4U1V8JbdPo1sOdSx8Jvd+rm4dqfMoRhPVwlig==
X-Received: by 2002:a17:907:3e22:b0:6e7:d37:204e with SMTP id hp34-20020a1709073e2200b006e70d37204emr14870135ejc.375.1649357664158;
        Thu, 07 Apr 2022 11:54:24 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x9-20020a05640226c900b0041d015bb8a5sm1380703edd.26.2022.04.07.11.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:54:23 -0700 (PDT)
Message-ID: <a2f89f06-f586-2bf3-fbfa-f0fd1b6ad057@linaro.org>
Date:   Thu, 7 Apr 2022 20:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-2-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-2-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Document the compatible for Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Add description and board compatible
> 
>  .../bindings/arm/pensando,elba.yaml           | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml

It seems you ignored to Cc devicetree binding maintainers for all your
devicetree bindings patches.

Please rebase on a recent kernel tree and use scripts/get_maintainers.pl
to get list of people to Cc. Your tree could not have my address, but
why Rob is missing is a surprise...

Best regards,
Krzysztof
