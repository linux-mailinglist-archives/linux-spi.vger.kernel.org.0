Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14B934B8EC
	for <lists+linux-spi@lfdr.de>; Sat, 27 Mar 2021 19:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhC0ShA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 27 Mar 2021 14:37:00 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:39556 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhC0Sge (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 27 Mar 2021 14:36:34 -0400
Received: by mail-ot1-f50.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so8394847ote.6;
        Sat, 27 Mar 2021 11:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=peEyQa+xKPawOZQNLZrgGDdNdpXAZb6tO2t/QAg21zI=;
        b=ogls4L6RhnFnhuTCCskKfeffzqPuXAXTLzYvhJe4GBH6BczFksPRRS/YHAjfTYyiTf
         v19H/vmvht8MnKUFzATe4cDO8Q9/z3eYITcms9/Gdebt3WJIP2Df/1TvFwTWsnIkPAcT
         vVcjoawmgKWdMRng2pzZ7BBhkH07l8yyZTB+yDjDur8bfQE+oKUIvq8GNMMzP0t/5AuS
         rrJCirgJh2TUuqvkIcS/WBZV037/BurFkVs9sbQk1q0Cdu8b/EBXih5mYskK9H3pG0db
         TZdxqCHXTN/KcWmx/ZEH4g8GMMN8rmcdmtU+pkKdqEQnAh3rGNYd4Tos314cZjyG1S6e
         C3vQ==
X-Gm-Message-State: AOAM531yB1fLMVYnCeaKfT6euXlr7qkDAsRPI4Bwiol27uPZq49EqgFE
        dttacMKqWH9BTpaqU4rcdHrw8BMnFA==
X-Google-Smtp-Source: ABdhPJxYiSmOiA5p4cejjeZvZ3sZNoMdVCPqe2KNaOFqrELUAVZxgmdbCuICUibWWJNcdKbbOzQjDQ==
X-Received: by 2002:a9d:4e05:: with SMTP id p5mr16757469otf.264.1616870193375;
        Sat, 27 Mar 2021 11:36:33 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.41])
        by smtp.gmail.com with ESMTPSA id z6sm3160135otq.48.2021.03.27.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 11:36:32 -0700 (PDT)
Received: (nullmailer pid 359581 invoked by uid 1000);
        Sat, 27 Mar 2021 18:36:28 -0000
Date:   Sat, 27 Mar 2021 12:36:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210327183628.GA345487@robh.at.kernel.org>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326130034.15231-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 26, 2021 at 06:30:34PM +0530, Pratyush Yadav wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> There is no way as of now to have a parent or bus defining properties
> for child nodes. For now, avoid it in the example to silence warnings on
> dt_schema_check. We can figure out how to deal with actual dts files
> later.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> [p.yadav@ti.com: Fix how compatible is defined, make reset optional, fix
> minor typos, remove subnode properties in example, update commit
> message.]
> ---
>  .../bindings/spi/cadence-quadspi.txt          |  68 ---------
>  .../bindings/spi/cdns,qspi-nor.yaml           | 143 ++++++++++++++++++
>  2 files changed, 143 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml


> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> new file mode 100644
> index 000000000000..0e7087cc8bf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence Quad SPI controller
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,k2g-qspi
> +              - ti,am654-ospi
> +              - intel,lgm-qspi
> +          - const: cdns,qspi-nor
> +      - const: cdns,qspi-nor
> +
> +  reg:
> +    items:
> +      - description: the controller register set
> +      - description: the controller data area
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  cdns,fifo-depth:
> +    description:
> +      Size of the data FIFO in words.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    enum: [ 128, 256 ]
> +    default: 128
> +
> +  cdns,fifo-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bus width of the data FIFO in bytes.
> +    default: 4

I assume there's some constraints on this?

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  cdns,trigger-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      32-bit indirect AHB trigger address.
> +
> +  cdns,is-decoded-cs:
> +    type: boolean
> +    description:
> +      Flag to indicate whether decoder is used to select different chip select
> +      for different memory regions.
> +
> +  cdns,rclk-en:
> +    type: boolean
> +    description:
> +      Flag to indicate that QSPI return clock is used to latch the read
> +      data rather than the QSPI clock. Make sure that QSPI return clock
> +      is populated on the board before using this property.
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [ qspi, qspi-ocp ]
> +
> +# subnode's properties
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Flash device uses the below defined properties in the subnode.
> +
> +    properties:
> +      cdns,read-delay:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Delay for read capture logic, in clock cycles.
> +
> +      cdns,tshsl-ns:
> +        description:
> +          Delay in nanoseconds for the length that the master mode chip select
> +          outputs are de-asserted between transactions.
> +
> +      cdns,tsd2d-ns:
> +        description:
> +          Delay in nanoseconds between one chip select being de-activated
> +          and the activation of another.
> +
> +      cdns,tchsh-ns:
> +        description:
> +          Delay in nanoseconds between last bit of current transaction and
> +          deasserting the device chip select (qspi_n_ss_out).
> +
> +      cdns,tslch-ns:
> +        description:
> +          Delay in nanoseconds between setting qspi_n_ss_out low and
> +          first bit transfer.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - cdns,fifo-depth
> +  - cdns,fifo-width
> +  - cdns,trigger-address
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    qspi: spi@ff705000 {
> +      compatible = "cdns,qspi-nor";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0xff705000 0x1000>,
> +            <0xffa00000 0x1000>;
> +      interrupts = <0 151 4>;
> +      clocks = <&qspi_clk>;
> +      cdns,fifo-depth = <128>;
> +      cdns,fifo-width = <4>;
> +      cdns,trigger-address = <0x00000000>;
> +      resets = <&rst 0x1>, <&rst 0x2>;
> +      reset-names = "qspi", "qspi-ocp";
> +
> +      flash@0 {
> +              compatible = "jedec,spi-nor";
> +              reg = <0x0>;
> +      };
> +    };
> -- 
> 2.30.0
> 
