Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6C4F873F
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbiDGSpi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiDGSph (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 14:45:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB871C71D0
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 11:43:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a6so12834852ejk.0
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2Nl6hqkoPoQrOR55oB17M+hylrpKvmLoP9toR4HUSJU=;
        b=bbO0uqVxvu4ahlRD+g2cdHo7WJKW7tDEfYzPOI2X4aUdCI53arspD0JLeRyfKRhdAF
         lEVB+MtiaPNzrWttOzPgByFl3TbMKOdVPx7ot+p3X1IaPqm7Fbz7HfuZmBMmdvF3mYAq
         VJh0xAglXs7iCBspZbv8wGaJ1MqlEa4AptNWbiTNUk7/X+/dvP+464kRZXWzYLX7kC1H
         iR37dbzZL81EcgJGdDU9L060LXK/5BAXW45eQyDu6x9FB6rTqolkZBzIh/bP01eOXub3
         7Tg/nliyuYyL53sfhKfgzyBwFh+JsjHJ4kY/fOGHDX6PfhRoTc50K9U5bCseIRBfVboJ
         LTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Nl6hqkoPoQrOR55oB17M+hylrpKvmLoP9toR4HUSJU=;
        b=XY/OkdPB3VsfflzaT5Nu9V+lrFLEg71uv2l4XgLov3Np4MEHjcZrdXTp+efqVrEDuY
         Ie4mickGpD+6nn1cb3Qtg+cXUsFRdhdVw+UBL8ZZK56jumDKOPUoeQlL01DRcRnr9nXD
         bVgji55suj4L3XhrIKTE/+h2/qeE5r5W6MKC+rfekjq2a9N93hvE11Yj1EKiaVJKs168
         TlogKc/Sp/7y67tzt8r0GMysxlt1QZqa5pdNhJ8tf2uZ5xDTGhkgLztFzOfjQxupEYLp
         cHmOmwi9iCjvJ5Ln+3X3vpmuZ2RV2bBK475FYLto7RxY1rsMObqUScVg3dJece3SEkV2
         zlRQ==
X-Gm-Message-State: AOAM533FiqVv5btPtS1QBjw1hgLSTzsfOWvsLCSQ7Cny9vXx7bMzBV83
        sEi0QF/JAZM8bfIlJp9HJfjVMg==
X-Google-Smtp-Source: ABdhPJzI2pLtk/+ra64hfNt7igXY34wMScIybI18g7cZPToFglQAPuG4Sn7Rp+yrNpe7ze5hxQmfDQ==
X-Received: by 2002:a17:907:9725:b0:6e8:454e:e16e with SMTP id jg37-20020a170907972500b006e8454ee16emr1192313ejc.721.1649357014881;
        Thu, 07 Apr 2022 11:43:34 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709063e4e00b006e73392e592sm5967136eji.209.2022.04.07.11.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:43:34 -0700 (PDT)
Message-ID: <b51086d6-00d4-cc8e-8f11-64c01afb8b3a@linaro.org>
Date:   Thu, 7 Apr 2022 20:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/11] dt-bindings: Add vendor prefix for Pensando Systems
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
 <20220406233648.21644-3-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-3-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Add vendor prefix for Pensando Systems: https://pensando.io
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..0ce8f94eab08 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -936,6 +936,8 @@ patternProperties:
>      description: Parade Technologies Inc.
>    "^parallax,.*":
>      description: Parallax Inc.
> +  "^pensando,.*":
> +    description: Pensando Systems Inc.

List is ordered alphabetically, so this goes one further.

>    "^pda,.*":
>      description: Precision Design Associates, Inc.
>    "^pericom,.*":


Best regards,
Krzysztof
