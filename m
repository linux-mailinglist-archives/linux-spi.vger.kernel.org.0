Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECF566684
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jul 2022 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiGEJs1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jul 2022 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiGEJsX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jul 2022 05:48:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB1B75
        for <linux-spi@vger.kernel.org>; Tue,  5 Jul 2022 02:48:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f39so19642185lfv.3
        for <linux-spi@vger.kernel.org>; Tue, 05 Jul 2022 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ahpvfjUdXTR8WSsjap+PAgVIzJ16qJ7M8PATGfTPtFI=;
        b=hXYh3ispdpHgB9k7Iam45wMwEKXDESJJWiotYpXkdeS9eJapOErB2G7dIMxlYFRta9
         MVodOWys9y/5TNwtIFzRWNutDMqOVTytJ18zQRoWiUWqYemL6igs7DK5kAQP0IQlJmDN
         qEkfNJ9I/NINevOP+1+Vi0CeWGUtA0GzV2DafPHBe2k/r3fHUXoZFRnmL95uXJ8GFGGS
         s3FES0TubM69HkJDeS0E0drO0lEo6RTrjYGMFgigqsWW6HAuqeZUSM+4UEA5qZa9ZeVE
         ma8btURFm3pDjuQPBqDiDk5RQYh8h+SfTLRpi/BqEjRq2yZriwDiyi6iVB/st89b/HIU
         REgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ahpvfjUdXTR8WSsjap+PAgVIzJ16qJ7M8PATGfTPtFI=;
        b=hkuT9PleRLygO7Lv03Nm1bD3ourHYoHuCyuDoZWfh6exWgrqFf9KVy+8RP77iyGa6c
         /huNJYlooWXZERrKZwvajKluhL3cLLWNLxanQRTyT7hnUTkQ4B03BMDXP3lr651glTIi
         zI02REtvAsiQCXa/FYyvc0Sj8ixcgex+5KngvD6jAvhGaFdR+2DJgPoCD0svRc1kUqzB
         l+sm4/++jlCyfCL1QH0nnPKvEUzbA0QMuOkFtx6a4+3SpGb0vD1WxwZZzh5p+wceJIYW
         nOodmTIpJUS3i5FH/VbUDjEwidgn8ydpnptE3j/UsbEzELF/1QbQOZqs8TY//1NNYk/O
         gqiQ==
X-Gm-Message-State: AJIora/7x2n9UebYtWHR/I+H+ZvP+cTEDM9xt834GYwyhxLozV5NhxpP
        RnUwdaneuZXy38u7Wtm7bQwzxg==
X-Google-Smtp-Source: AGRyM1u721+7xpKSxN/uYG1ugKxyjBkKJ+dK71jGvPOj3htzgCrnsBaya92MI59e4jlypYIxOOnQkQ==
X-Received: by 2002:a05:6512:3d89:b0:481:bcf:cecd with SMTP id k9-20020a0565123d8900b004810bcfcecdmr22709190lfv.511.1657014500137;
        Tue, 05 Jul 2022 02:48:20 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bf26-20020a2eaa1a000000b0025d2f556e6csm401559ljb.14.2022.07.05.02.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:48:19 -0700 (PDT)
Message-ID: <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
Date:   Tue, 5 Jul 2022 11:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Content-Language: en-US
To:     haibo.chen@nxp.com, ashish.kumar@nxp.com, yogeshgaur.83@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, han.xu@nxp.com,
        singh.kuldeep87k@gmail.com, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/07/2022 11:11, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add one optional property nxp,fspi-dll-slvdly
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> index 1b552c298277..6bd61565686a 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> @@ -45,6 +45,12 @@ properties:
>        - const: fspi_en
>        - const: fspi
>  
> +  nxp,fspi-dll-slvdly:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specify the DLL slave line delay value.

What are the units?

Best regards,
Krzysztof
