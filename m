Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92184F8793
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbiDGTB2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243246AbiDGTB1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 15:01:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42322C6F1
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 11:59:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l26so12843642ejx.1
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sTr0gBmLvMOTcBTMuv173ZMChpC1v8ipaGPwhgHz+JQ=;
        b=oWGYd1JLkOJ9QEVCWJKDcZP9ehCv+WtvoGnx7u5pd/2u9PIan5YFtZkJ4CXdAVzhFz
         04fuvoyhVzm1l41hIxYib/5yZ8DxwQzfpJ1CV4Csuz4ea2HNE2esYYy8N4JoHogSBXrL
         3wOnnUlq/pX7PtlrEXpfqCIqffp/SZpWAStOTaZTjpNou92lGilXPkQfknoPijg3fZ1u
         m8SuFxCjPVvDqVrUJdGoo2MRwwhpjmzzUU6Jd+W+DycWXVKEHFrvBEwULOPhOW/YQlpE
         H4u9zKFKcwRqLDIzxIIfUlhAptwVgO6fXrJRfqR7VZfnd7kx3OS0mc/g/LciTKSZ8xin
         x16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sTr0gBmLvMOTcBTMuv173ZMChpC1v8ipaGPwhgHz+JQ=;
        b=DodY+OeIe4fZAz+VwzUXbIT9w3b12odQl9U9gqmB4K8tw3xdag9xH0Ocahn9suAqUj
         HbqTHW4G0LzVmauK9i1KlvAEEzKrtVlmoZhlwIZEnEeYIIpyI6PnYKH1NUVaYopNVnLE
         6xRbURJs09Yer/AbNb7fg5DE7pyQRagA+AsGSVV53lC7TpQy6iV/+nO2o+n2NEQqhFyW
         he+1+G7wJjA85jMB5CK/rTkixLk1YcI2oVp2fnpxMKIObca0E1P8smryFzyP+yCvJu6p
         iNZexpoU9kHmjOfSxduO5jx72AOsGSerq4uKn0d61KAItondxIIgm1JdjGSq9dw+0mnX
         PkBQ==
X-Gm-Message-State: AOAM530RAXrFvkN1/5utDpBK5TfxcXOxWWldf//ruJnjjRAa/KNYyR2W
        s/Ck3Cv8ZJ+EfclQ8myRMghRRg==
X-Google-Smtp-Source: ABdhPJwhTbizX6MeC2DcKhsowU47cwwjFzCXCG/Vhy17jPGD4JK/qkPHNjvEBuou3RE3FYrN2qj2Pw==
X-Received: by 2002:a17:907:3e1d:b0:6d7:1031:7e0 with SMTP id hp29-20020a1709073e1d00b006d7103107e0mr14393976ejc.580.1649357964303;
        Thu, 07 Apr 2022 11:59:24 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gt17-20020a170906f21100b006e6f9ab4830sm6169002ejb.186.2022.04.07.11.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:59:23 -0700 (PDT)
Message-ID: <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
Date:   Thu, 7 Apr 2022 20:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba
 SoC
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
 <20220406233648.21644-5-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-5-brad@pensando.io>
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
> Document the cadence qspi controller compatible for Pensando Elba SoC
> boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 0a537fa3a641..bc298e413842 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -30,6 +30,7 @@ properties:
>                - intel,lgm-qspi
>                - xlnx,versal-ospi-1.0
>                - intel,socfpga-qspi
> +              - pensando,elba-qspi
>            - const: cdns,qspi-nor
>        - const: cdns,qspi-nor
>  
> @@ -48,7 +49,7 @@ properties:
>      description:
>        Size of the data FIFO in words.
>      $ref: "/schemas/types.yaml#/definitions/uint32"
> -    enum: [ 128, 256 ]
> +    enum: [ 128, 256, 1024 ]

Is 1024 valid for other controllers? If not, then probably this should
be further constraint in allOf:if:then...

Best regards,
Krzysztof
