Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE361F9E3D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgFOROq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:14:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45940 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOROp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 13:14:45 -0400
Received: by mail-io1-f65.google.com with SMTP id y5so18680975iob.12;
        Mon, 15 Jun 2020 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hiOijoD53LX37YRMIwEiw00dAjUSx8soGvrpBh7UCNk=;
        b=Qp9t/KukYyFxOiVzLy05euwvk2eHpu3iUN54O56gdnqMdhs2oFTtUmSgr4OIRQjalN
         jXMkicbQ4ftOaaksx7gMLuIc3GhsFBoXB2aZGezpjzQeKaMSlrMz73L31/4eiPwL5tBz
         /5YHxy7eu6z22XXhs8l7pTRL0G/QBzRJaMUTpiYtNBCM4XI/uVysscsjv0GjSS5R5eLn
         X/G8UJjcxLdni/NPuaRrZiHgM9EgvKETQe+VQgxCHc1MDSJtI8yS//l3Eox9bZwEk8bt
         ilYdm1Fq0tW4DduMvS+ERjovuHRWvAGo2WCsz2aMvM8+2ng1nj+GEMPmAzwpQpuySFn9
         R3FA==
X-Gm-Message-State: AOAM530pGKBUdNU2LvGx9W34hCV31XdZccl4eENEIq0xY1ixgBBSdL3w
        nb9zQ1tGiSkmPgchUoKczQ==
X-Google-Smtp-Source: ABdhPJzMt4RbwBhE8d8aXJ1Kn/OXGkG36uamUKf5TRxX+ttPOWrLxY6THuuBLi6cS0RFohMBITK0UQ==
X-Received: by 2002:a02:7f4d:: with SMTP id r74mr21951710jac.51.1592241283969;
        Mon, 15 Jun 2020 10:14:43 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v11sm8354642ile.61.2020.06.15.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:14:43 -0700 (PDT)
Received: (nullmailer pid 1974668 invoked by uid 1000);
        Mon, 15 Jun 2020 17:14:41 -0000
Date:   Mon, 15 Jun 2020 11:14:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] dt-bindings: spi: Convert imx cspi to json-schema
Message-ID: <20200615171441.GA1971091@bogus>
References: <1591235731-15673-1-git-send-email-Anson.Huang@nxp.com>
 <1591235731-15673-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591235731-15673-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 04, 2020 at 09:55:30AM +0800, Anson Huang wrote:
> Convert the i.MX CSPI binding to DT schema format using json-schema,
> update compatible, remove obsolete properties "fsl,spi-num-chipselects"
> and update the example based on latest DT file.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add "unevaluatedProperties: false".
> ---
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       | 56 ------------
>  .../devicetree/bindings/spi/fsl-imx-cspi.yaml      | 99 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> deleted file mode 100644
> index 33bc58f..0000000
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -* Freescale (Enhanced) Configurable Serial Peripheral Interface
> -  (CSPI/eCSPI) for i.MX
> -
> -Required properties:
> -- compatible :
> -  - "fsl,imx1-cspi" for SPI compatible with the one integrated on i.MX1
> -  - "fsl,imx21-cspi" for SPI compatible with the one integrated on i.MX21
> -  - "fsl,imx27-cspi" for SPI compatible with the one integrated on i.MX27
> -  - "fsl,imx31-cspi" for SPI compatible with the one integrated on i.MX31
> -  - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
> -  - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
> -  - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
> -  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
> -  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
> -  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
> -  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
> -- reg : Offset and length of the register set for the device
> -- interrupts : Should contain CSPI/eCSPI interrupt
> -- clocks : Clock specifiers for both ipg and per clocks.
> -- clock-names : Clock names should include both "ipg" and "per"
> -See the clock consumer binding,
> -	Documentation/devicetree/bindings/clock/clock-bindings.txt
> -
> -Recommended properties:
> -- cs-gpios : GPIOs to use as chip selects, see spi-bus.txt.  While the native chip
> -select lines can be used, they appear to always generate a pulse between each
> -word of a transfer.  Most use cases will require GPIO based chip selects to
> -generate a valid transaction.
> -
> -Optional properties:
> -- num-cs :  Number of total chip selects, see spi-bus.txt.
> -- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> -Documentation/devicetree/bindings/dma/dma.txt.
> -- dma-names: DMA request names, if present, should include "tx" and "rx".
> -- fsl,spi-rdy-drctl: Integer, representing the value of DRCTL, the register
> -controlling the SPI_READY handling. Note that to enable the DRCTL consideration,
> -the SPI_READY mode-flag needs to be set too.
> -Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
> -
> -Obsolete properties:
> -- fsl,spi-num-chipselects : Contains the number of the chipselect
> -
> -Example:
> -
> -ecspi@70010000 {
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	compatible = "fsl,imx51-ecspi";
> -	reg = <0x70010000 0x4000>;
> -	interrupts = <36>;
> -	cs-gpios = <&gpio3 24 0>, /* GPIO3_24 */
> -		   <&gpio3 25 0>; /* GPIO3_25 */
> -	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
> -	dma-names = "rx", "tx";
> -	fsl,spi-rdy-drctl = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
> new file mode 100644
> index 0000000..606af7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl-imx-cspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale (Enhanced) Configurable Serial Peripheral Interface (CSPI/eCSPI) for i.MX
> +
> +maintainers:
> +  - Shawn Guo <shawn.guo@linaro.org>
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fsl,imx1-cspi
> +      - const: fsl,imx21-cspi
> +      - const: fsl,imx27-cspi
> +      - const: fsl,imx31-cspi
> +      - const: fsl,imx35-cspi
> +      - const: fsl,imx51-ecspi
> +      - const: fsl,imx53-ecspi
> +      - items:
> +        - enum:
> +          - fsl,imx50-ecspi
> +          - fsl,imx6q-ecspi
> +          - fsl,imx6sx-ecspi
> +          - fsl,imx6sl-ecspi
> +          - fsl,imx6sll-ecspi
> +          - fsl,imx6ul-ecspi
> +          - fsl,imx7d-ecspi
> +          - fsl,imx8mq-ecspi
> +          - fsl,imx8mm-ecspi
> +          - fsl,imx8mn-ecspi
> +          - fsl,imx8mp-ecspi
> +        - const: fsl,imx51-ecspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: SoC SPI ipg clock
> +      - description: SoC SPI per clock
> +    maxItems: 2

Can drop 'maxItems', it is redundant here.

> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: per
> +    maxItems: 2

And here.

> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for RX
> +      - description: DMA controller phandle and request line for TX
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  fsl,spi-rdy-drctl:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Integer, representing the value of DRCTL, the register controlling
> +      the SPI_READY handling. Note that to enable the DRCTL consideration,
> +      the SPI_READY mode-flag needs to be set too.
> +      Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
> +    enum: [0, 1, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx5-clock.h>
> +
> +    spi@70010000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "fsl,imx51-ecspi";
> +        reg = <0x70010000 0x4000>;
> +        interrupts = <36>;
> +        clocks = <&clks IMX5_CLK_ECSPI1_IPG_GATE>,
> +                 <&clks IMX5_CLK_ECSPI1_PER_GATE>;
> +        clock-names = "ipg", "per";
> +    };
> -- 
> 2.7.4
> 
