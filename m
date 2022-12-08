Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06E646C15
	for <lists+linux-spi@lfdr.de>; Thu,  8 Dec 2022 10:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLHJoW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Dec 2022 04:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLHJoW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Dec 2022 04:44:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD06E542
        for <linux-spi@vger.kernel.org>; Thu,  8 Dec 2022 01:44:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g7so1204287lfv.5
        for <linux-spi@vger.kernel.org>; Thu, 08 Dec 2022 01:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tR+f/+3nybjrz985QuJTlkfFuvKyHlsK8G2EHEYD21M=;
        b=NvP+hneTcrJLq5aKAbWBlzRJJD/2srJe9IAT/Pq2hUX9OAuJ1vz01KfcttkSjfGWq6
         MkVQq1uw8kaTQSnVB8uX4rSsEPLC1n/PxH/go/ginVJgW0kAhDGkoNoRs1nCQHSk4/ck
         94ktgccj6TDjOHMk+TlN+wvvuCtzqnhdW7+fA1IExI/sPZyyW9qQ4IwDE45IaqKWgC1L
         fz0+PgDy6EuN18RY7i+dTcRX5m1e/rFaC7S5djIFlmkXMFDMfb3lBRwtf1W/F9Vre7Gh
         5Y9A7wMqnRq2lIyDogonPN6I6vu4NSaPH0jxR54Lwuur/QSXC6XPAOQghUC7UTeLNFms
         ZW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tR+f/+3nybjrz985QuJTlkfFuvKyHlsK8G2EHEYD21M=;
        b=LMkHgT9jtsdU5VwpZ1fG0QKckdXx9mXlK/8n1LpKEPuwlXNiuC0LId53V4MjqrOlNe
         0nyi7w+Qj/v41KIfZO+iiEnWR+XYIETq2PuC27a6UeXXc35Q6AJ05QEwyduok9trnKyJ
         vRTV/JkyCfdDZIQpEzF3R2K5dgVNXBSyYkr2VDSNtFb4RW25i5U1K2Vcm/POqUeZFGCh
         NSUrFXHdN7wy2j13P3pUmMalCwzCcG53ugpGS/qecLBNYYiwYUIG4YmIHgdQxHuIgxkF
         4oJPhTVP2gUJ9ftNCk8k0+b1bzTvQsoeZW7Xy1XMN8n1IhcfFxy8VY/GfhyQpzOeNsLn
         lECw==
X-Gm-Message-State: ANoB5plWGeMH85V9v6nduA23EerqAyGoheUVsqCxMS5KaZ6wu7ONxXHu
        e2V0LTSpm0Q3GXHR1Yc/tfEDxA==
X-Google-Smtp-Source: AA0mqf77vkoDAk7e+na4oDIjnlgURFAAvORsW7EKDtnaXGZNkHzBFx7iahF6vIP8MxlwXav31qtCag==
X-Received: by 2002:a05:6512:31c5:b0:4a2:3ca7:3a44 with SMTP id j5-20020a05651231c500b004a23ca73a44mr26614010lfe.23.1670492659337;
        Thu, 08 Dec 2022 01:44:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d23-20020a194f17000000b0049482adb3basm3257906lfb.63.2022.12.08.01.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:44:18 -0800 (PST)
Message-ID: <fe70d964-229a-8bda-a414-e009dd955e5e@linaro.org>
Date:   Thu, 8 Dec 2022 10:44:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 7/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
 <20221208062955.2546-8-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208062955.2546-8-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/12/2022 07:29, Xiangsheng Hou wrote:
> Split MediaTek ECC engine with rawnand controller and convert to
> YAML schema.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../bindings/mtd/mediatek,mtk-nfc.yaml        | 154 +++++++++++++++
>  .../mtd/mediatek,nand-ecc-engine.yaml         |  62 ++++++
>  .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
>  3 files changed, 216 insertions(+), 176 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-ecc-engine.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
> new file mode 100644
> index 000000000000..eb1a44c7ae4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/mediatek,mtk-nfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek(MTK) SoCs raw NAND FLASH controller (NFC)
> +
> +maintainers:
> +  - Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-nfc
> +      - mediatek,mt2712-nfc
> +      - mediatek,mt7622-nfc
> +
> +  reg:
> +    items:
> +      - description: Base physical address and size of NFI.
> +
> +  interrupts:
> +    items:
> +      - description: NFI interrupt
> +
> +  clocks:
> +    items:
> +      - description: clock used for the controller
> +      - description: clock used for the pad
> +
> +  clock-names:
> +    items:
> +      - const: nfi_clk
> +      - const: pad_clk
> +
> +  ecc-engine:
> +    description: device-tree node of the required ECC engine.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +patternProperties:
> +  "^nand@[a-f0-9]$":
> +    type: object

This should be instead:
    $ref: nand-chip.yaml#
    unevaluatedProperties: false

and then properties below (due to current dtschema limitations) should
list properties from nand-controller.yaml:

      nand-on-flash-bbt: true

Optionally, we could create additional schema - nand-controller-chip,
which would be referenced directly by nand-controller and itself would
ref nand-chip.

> +    properties:
> +      reg:
> +        minimum: 0

no need, 0 is the minimum.

> +        maximum: 1
> +      nand-ecc-mode:
> +        const: hw
> +
> +allOf:
> +  - $ref: nand-controller.yaml#
> +
> +  - if:

Best regards,
Krzysztof

