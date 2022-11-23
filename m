Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E9635701
	for <lists+linux-spi@lfdr.de>; Wed, 23 Nov 2022 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiKWJgc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Nov 2022 04:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiKWJgE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Nov 2022 04:36:04 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA5DDFAF
        for <linux-spi@vger.kernel.org>; Wed, 23 Nov 2022 01:33:28 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t10so20785915ljj.0
        for <linux-spi@vger.kernel.org>; Wed, 23 Nov 2022 01:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tliGyxYJ/M9yhNINnK8ElFfaX3Jak4W7Fp+GxN+I+M=;
        b=L4iplxi7ER7RIiYBkm4S1dudIn9f86xBVHxreXEQgJ5lSrbf2MrGuV0UgVCmXEIjgE
         bY+z5zjqE0nuA+JNnwQmuSuNjJ3twBl3r2MfZexEGXofdAcZDVT1UQDrqxZ4xV/jDHTy
         4mmmFgi1603ubkciItGZ5dsGwp0z9TxtAmFeWfqAy+msE5DHHTarEHY2iucxOkO4vUVq
         lXSc/XI3HeMUC1FM2t4FOa0pNNRdV3UAzRnEYd746kGsBpwSI4vLMAfoPJsxMOx5NT6x
         VcJhN6t5/lcKIFY18KxI9aUz47laZo9p6YWlyz6tjHw95ZoAyi3oj5OCNSXQS3y3X6qJ
         odxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tliGyxYJ/M9yhNINnK8ElFfaX3Jak4W7Fp+GxN+I+M=;
        b=FCtbABEIBddgAh7jmKTzMMRtDwSpNpQgMI9PLFRADFu2zA39IsWyOj2cyA79fZYNPx
         mnTJEaqQcoTL4fda2/v9wp4zvkPmiG1GffUX4fy2d8f9ncEdC+V49z2DOct21P704fgD
         EpUXHLHB2M+8H2bz1RkdGjl9aURCRrDVwhR9UNidNoN1szIPfaLIsQ4EvjWvtWfzT5Se
         AlPAR28Wpf4dZc9Gpsk2b3lzGaNZnlzHsT49/q6j7QCFDpVIjeEXrC1J61UJym/UkvPx
         6So/oQ3DYbbJ8WBV7sYw4KUonNrefBIzyGyRHUeMOsYIjWE4GlAFRzrP26ilkSMwUKWy
         ohCg==
X-Gm-Message-State: ANoB5pkiqc8gbxBxDbqLXQD5HQjVw2oFfFcVad/I34n6J8c5EVV4TFhK
        S4ok734sSRec//9d8Q0PfXA97A==
X-Google-Smtp-Source: AA0mqf4cp9QrFyfWfJoVxJGdmhMowXszheP+stjtDDUx2aAMkUeuMgt8dNwMkDTi5B8+1ztabRJ+Yg==
X-Received: by 2002:a2e:8ecd:0:b0:277:6d79:8936 with SMTP id e13-20020a2e8ecd000000b002776d798936mr5886630ljl.362.1669196007095;
        Wed, 23 Nov 2022 01:33:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512075000b0049462af8614sm2816809lfs.145.2022.11.23.01.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 01:33:26 -0800 (PST)
Message-ID: <579f9320-f114-2977-bb70-d5a26a3d2279@linaro.org>
Date:   Wed, 23 Nov 2022 10:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add Socionext F_OSPI controller
 bindings
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221121014800.13989-1-hayashi.kunihiko@socionext.com>
 <20221121014800.13989-2-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121014800.13989-2-hayashi.kunihiko@socionext.com>
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

On 21/11/2022 02:47, Kunihiko Hayashi wrote:
> Add devicetree binding documentation for Socionext F_OSPI SPI flash
> controller.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/spi/socionext,f-ospi.yaml        | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml b/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
> new file mode 100644
> index 000000000000..e04492c4fc84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/socionext,f-ospi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both lines.

> +
> +title: Socionext F_OSPI controller
> +
> +description: |
> +  The Socionext F_OSPI is a controller used to interface with flash
> +  memories using the SPI communication interface.
> +
> +maintainers:
> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

Drop quotes.

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

