Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64B5EB211
	for <lists+linux-spi@lfdr.de>; Mon, 26 Sep 2022 22:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIZU2H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiIZU2E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 16:28:04 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648AC9FA96;
        Mon, 26 Sep 2022 13:28:02 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1278624b7c4so10781666fac.5;
        Mon, 26 Sep 2022 13:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=auy+cxKcc8eI2Uhu+qm54E46IRglRqVFF347Yn8jFX4=;
        b=OBS0eQhFwisRHJKzdvhAv92zRPWrZ6dPJmLdDGQ4MUcuyuLZZ+TVIIh25UlhHwcfyI
         0elvTrMoq6KdhP+HGPVhr/wmwG7TRJRxogsSUrIL7WvkwbbxYOl+vHZTaMSqLlrpGNdm
         GkI+98sXEmLI9F99TdLJbCBnGq6TUJ1RqysIb90BiaFUlfD4WqcMnXirdKZi2ahatDZV
         kpIaIXJSen85YQiUFunrDxrM9agKMxFoWdUIE13Urgc01cjbN2wROfADCNByFFLn7kHD
         WffvCGkLgOJnmhVlcykCw3khzafpDrWVHbdAmiD9Ifbuq7X1bnSD927SnVjf4Quu+wGY
         IRfA==
X-Gm-Message-State: ACrzQf3o1qOrtnMxRLJ2yoKfg00+blNQqDGU+Bf/s6v+iqS80bg9JyEl
        nsC2vBRmZ+VF7wQZOjoXZIqTLGU6BQ==
X-Google-Smtp-Source: AMsMyM7wwf6CJTGQ5p14C1PoCEnqcGr+H5KC4BxnIocKFuz4+Y+evjpdxQUruxGweyDm5Hku2ckjTA==
X-Received: by 2002:a05:6870:899d:b0:12b:cdce:63d5 with SMTP id f29-20020a056870899d00b0012bcdce63d5mr282808oaq.51.1664224081573;
        Mon, 26 Sep 2022 13:28:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a056808014600b003509cc4ad4esm7569470oie.39.2022.09.26.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:28:01 -0700 (PDT)
Received: (nullmailer pid 2750278 invoked by uid 1000);
        Mon, 26 Sep 2022 20:28:00 -0000
Date:   Mon, 26 Sep 2022 15:28:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: Re: [PATCH 1/3] dt-bindings: arm: airoha: Add documentation for
 Airoha SPI controller
Message-ID: <20220926202800.GA2747274-robh@kernel.org>
References: <20220922100410.1101874-1-bert@biot.com>
 <20220922100410.1101874-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922100410.1101874-2-bert@biot.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 22, 2022 at 12:04:08PM +0200, Bert Vermeulen wrote:
> Create documentation for accessing the Airoha EN7523 SPI controller.
> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  .../bindings/spi/airoha,en7523-spi.yaml       | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> new file mode 100644
> index 000000000000..e5bc7814424e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/airoha,en7523-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7523 SPI controller
> +
> +maintainers:
> +  - Bert Vermeulen <bert@biot.com>
> +
> +description: |
> +  This binding describes the SPI controller on Airoha EN7523 SoCs.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: airoha,en7523-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SPI clock

'maxItems: 1' is sufficient.

> +
> +  clock-names:
> +    items:
> +      - const: spi

You don't really need clock-names when there is only 1.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/en7523-clk.h>
> +    spi0: spi@1fa10000 {
> +      compatible = "airoha,en7523-spi";
> +      reg = <0x1fa10000 0x10000>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      clocks = <&scu EN7523_CLK_SPI>;
> +      clock-names = "spi";
> +    };
> -- 
> 2.25.1
> 
> 
