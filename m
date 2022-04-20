Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95B5087AB
	for <lists+linux-spi@lfdr.de>; Wed, 20 Apr 2022 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbiDTMJA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Apr 2022 08:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378384AbiDTMJA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Apr 2022 08:09:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D536B5E
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 05:06:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 11so2044740edw.0
        for <linux-spi@vger.kernel.org>; Wed, 20 Apr 2022 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=UlAja3YPVFSaCcjRJzEPZI+7Ai3V2k+mQnAfV+fzWps=;
        b=QSywyv596dXT8X/29BiGuSl4JY9hscZylHITHlYHy6CCE9hWlNmZw73t+jbz33HpHh
         8mVDucM15hiz0lfxr7SdFoUF315ped2/T1bMg3X5YCoNi8FZdtHj50dlDpaXhGDKAndj
         UkbdP1+Pv9YnYKALr48m32NTXWYqMpT/WTzghaxEwbR/OZrcQ9J/kvwDL9xuZs8QwUta
         pBAAcWi0VhP58Ol2iL/pIHCe9vQyEsQ/+wLpTFfffKEexRqeSiSZ2577ltVHnnLbxUh5
         loeCMuybCRKGN2HGqtdh3nC4prfEWbSWFbERVTF+2hKpuw9k48L36UljxXj14zsmfp5z
         lEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UlAja3YPVFSaCcjRJzEPZI+7Ai3V2k+mQnAfV+fzWps=;
        b=Q9mEjCBNZJUWjxzu1mGB9epITw/kv7hoQPC63a3MqTn/tU486yf9DEe8cuGzke5Ace
         WTXnAb9YdvrmippJr0eACOTF1QB8oB/02YGRpjkGvbu3bJAKBHXcrFnL45q5nzX7h08v
         6G0mMe4zIdVKkA1a/AOGMCmTbfK2Qz9mRmqf6Zdz2BIhL0To6/ro3smz9JOHdgDZInzB
         4eIyjty/e/2qhvu/gW0DVCl7epHhC0zD12YPnEstT1p2/Sl3y8qpifSzWJOcA1eA6E6Y
         EQdWZbr/KMXQOfhpGRVPtqaIkek17KZyymyjHUbmpuQFHqfmtbf4wUexD4ipAlZd0YJW
         duqQ==
X-Gm-Message-State: AOAM531IGZHyJfzxegFxsIErZDWg63IUWF8kxb2ee37Cb2eZCVSULeWI
        WaRCP0iDqplkPq8fNOJYvQhWJw==
X-Google-Smtp-Source: ABdhPJzJlKoCJPioJ/m0NnVQMdZ6j2pDYJ7mzkCaxZoPVg5LHSGsEo73lBQ7kzJo1XeAYP0Uv/JK+Q==
X-Received: by 2002:a05:6402:2694:b0:423:fd1f:30c2 with SMTP id w20-20020a056402269400b00423fd1f30c2mr9265290edd.343.1650456371790;
        Wed, 20 Apr 2022 05:06:11 -0700 (PDT)
Received: from [192.168.0.225] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id vr7-20020a170906bfe700b006e8325fe130sm6570787ejb.31.2022.04.20.05.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:06:11 -0700 (PDT)
Message-ID: <d74f62d7-7aea-b31f-1c2f-540c54df289c@linaro.org>
Date:   Wed, 20 Apr 2022 14:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech sx1301
Content-Language: en-US
To:     Changming Huang <jerry.huang@nxp.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20220420073146.38086-1-jerry.huang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220420073146.38086-1-jerry.huang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/04/2022 09:31, Changming Huang wrote:
> Add DT Binding doc for semtech sx1301
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
> changes in v4:
>   - rename example node, adjust description
> changes in v3:
>   - add the dt-bindings
> 
>  .../bindings/spi/semtech,sx1301.yaml          | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> new file mode 100644
> index 000000000000..420fe8d23a1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/semtech,sx1301.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/semtech,sx1301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech sx1301 SPI controller bindings

This is still wrong.

Please also answer Michael's comments.

Best regards,
Krzysztof
