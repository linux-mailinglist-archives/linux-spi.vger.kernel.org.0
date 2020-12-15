Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97E32DB11A
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgLOQNz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 11:13:55 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:34565 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbgLOQNs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Dec 2020 11:13:48 -0500
Received: by mail-oo1-f66.google.com with SMTP id x23so1760125oop.1;
        Tue, 15 Dec 2020 08:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJZnRtX3sbuHq49+KxzSlxIlH2YFeZZTDaGKbhkXMPc=;
        b=T4A9W5ccVotMK6lIUNKrcjflr8XbJSKy8S+YGUt+DvrSggSzWPlZ9vqib0NCrGCnWM
         YlmUvWw/LtQN/uTU8kBqGm6dbaYRA+HBgSx78Ik8o65pyOGzklhwiEDbQYbw8OpkBzV2
         cAzDkfIiAp8K+1yef2M7OmPHKXJ8vEWjwHSL0NGlbCpUbyaOkD8oFd+63qsF6xgFrnZA
         jzlDdt0OH/oSw6F3/Y/NFgpWgvHx5cKEqkcUdPQiWlPUQv82Y/RSP3iSORX8M4LH3eZn
         hwysXj9+VwHOyuyexL7Jr3FndyXTaF5PRbvG9IE0VhJOUlnC8wl19XA76d2ogjzSI9rZ
         bXDg==
X-Gm-Message-State: AOAM531ksb4cTppqHAJywceCRDfL5aT8OV0/vHT5ehjnw9BFl7OXgaBd
        njBGSrHJHXu2hPJXG3MpbA==
X-Google-Smtp-Source: ABdhPJx2AG7yR79xBmnEKYChigB3jUkSqzlHLc2xAzoccoZHSNNlTwnG2/qBh7in6d5DkM1o/KLg1g==
X-Received: by 2002:a4a:2f91:: with SMTP id p139mr23199961oop.0.1608048785972;
        Tue, 15 Dec 2020 08:13:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm509358otj.46.2020.12.15.08.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:13:05 -0800 (PST)
Received: (nullmailer pid 3949669 invoked by uid 1000);
        Tue, 15 Dec 2020 16:13:04 -0000
Date:   Tue, 15 Dec 2020 10:13:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lukas@wunner.de, bbrezillon@kernel.org, p.yadav@ti.com,
        tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree
 binding
Message-ID: <20201215161304.GA3935217@robh.at.kernel.org>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
 <1607721363-8879-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607721363-8879-3-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 11, 2020 at 01:15:56PM -0800, Sowjanya Komatineni wrote:
> This patch adds YAML based device tree binding document for Tegra
> Quad SPI driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml         | 130 +++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> new file mode 100644
> index 0000000..0b5fea6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra Quad SPI Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>

allOf:
  - $ref: spi-controller.yaml#

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra210-qspi
> +      - nvidia,tegra186-qspi
> +      - nvidia,tegra194-qspi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: qspi
> +      - const: qspi_out
> +
> +  clocks:
> +    maxItems: 2
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+":

You can drop '^.*'.

> +    type: object
> +
> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the SPI device.
> +
> +      reg:
> +        maxItems: 1
> +
> +      spi-max-frequency:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Maximum Quad SPI clocking speed of the device in Hz.
> +
> +      spi-rx-bus-width:
> +        description:
> +          Bus width to the Quad SPI bus used for read transfers.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [1, 2, 4]
> +
> +      spi-tx-bus-width:
> +        description:
> +          Bus width to the Quad SPI bus used for write transfers.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [1, 2, 4]

All of the above 5 properties are covered by spi-controller.yaml. You 
only need additional constraints here. As 8-bit mode is not supported, 
you need:

spi-tx-bus-width:
  enum: [1, 2, 4]

> +
> +      nvidia,tx-clk-tap-delay:
> +        description:
> +          Delays the clock going out to device with this tap value.
> +          Tap value varies based on platform design trace lengths from Tegra
> +          QSPI to corresponding slave device.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      nvidia,rx-clk-tap-delay:
> +        description:
> +          Delays the clock coming in from the device with this tap value.
> +          Tap value varies based on platform design trace lengths from Tegra
> +          QSPI to corresponding slave device.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 255

Please include these properties in your example.

> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +  - resets
> +
> +additionalProperties: true

That's generally wrong unless it's a schema to be included by other 
schemas.

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/reset/tegra210-car.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    spi@70410000 {
> +            compatible = "nvidia,tegra210-qspi";
> +            reg = <0x70410000 0x1000>;
> +            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&tegra_car TEGRA210_CLK_QSPI>,
> +                     <&tegra_car TEGRA210_CLK_QSPI_PM>;
> +            clock-names = "qspi", "qspi_out";
> +            resets = <&tegra_car 211>;
> +            dmas = <&apbdma 5>, <&apbdma 5>;
> +            dma-names = "rx", "tx";
> +
> +            flash@0 {
> +                    compatible = "spi-nor";
> +                    reg = <0>;
> +                    spi-max-frequency = <104000000>;
> +                    spi-tx-bus-width = <2>;
> +                    spi-rx-bus-width = <2>;
> +            };
> +    };
> -- 
> 2.7.4
> 
