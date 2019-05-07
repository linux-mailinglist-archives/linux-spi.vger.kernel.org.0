Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B31165C3
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEGOfm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 10:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfEGOfl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 May 2019 10:35:41 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A720E2087F;
        Tue,  7 May 2019 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557239740;
        bh=/XkcMtZQIpjRMiz1T2qad6TxcjqnG9Miac8ikYCqU6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DQRDcGfTdeusktCABD4gk9TcYK2onQTU0g0HvtSY1cK919Mfp0aVYAi/CSxbVI6Sn
         TDb0LzMk8sxrDHBFL4UN2pErHsSQ2uZCsqJN30o8RRpJAJf7J/ri5H3h+O/3rLSWMm
         Qs9BlwZaZqEEqQ/dNJ+tOFYc6pmuucqeySECeHy4=
Received: by mail-qk1-f180.google.com with SMTP id w20so356866qka.7;
        Tue, 07 May 2019 07:35:40 -0700 (PDT)
X-Gm-Message-State: APjAAAWEqPA9nKeA+cd2pCQAqX+dfzq3pnpMGKSezf4A2PH254KWS+nf
        /u4Tjfmhxd9elLCnQlISnoZ0Vw+nuPx18sIqqA==
X-Google-Smtp-Source: APXvYqxmhNvlrV328Mx2uun8Zwuep9D85FcT9j6MBr7UX8OuKIjNMNyXYevMaqtFHmWBh/AZmkLb3NuqmIkYNg8yN4o=
X-Received: by 2002:a37:ad14:: with SMTP id f20mr25561161qkm.147.1557239739860;
 Tue, 07 May 2019 07:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 May 2019 09:35:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
Message-ID: <CAL_JsqKeLWgGLafwbKViTgpw4B=W9YGULaMr8h0p_rWX8PP_UQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add YAML schemas for the generic
 SPI options
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 7, 2019 at 8:48 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The SPI controllers have a bunch of generic options that are needed in a
> device tree. Add a YAML schemas for those.

I'd started on this one, but was planning to move it to the schema
repository. The issue there is re-licensing (adding BSD 2 clause).
Maybe better to just move it later.

>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt         | 111 +-----
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 156 +++++++-
>  2 files changed, 156 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> deleted file mode 100644
> index 1f6e86f787ef..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -SPI (Serial Peripheral Interface) busses
> -
> -SPI busses can be described with a node for the SPI controller device
> -and a set of child nodes for each SPI slave on the bus.  The system's SPI
> -controller may be described for use in SPI master mode or in SPI slave mode,
> -but not for both at the same time.
> -
> -The SPI controller node requires the following properties:
> -- compatible      - Name of SPI bus controller following generic names
> -                   recommended practice.
> -
> -In master mode, the SPI controller node requires the following additional
> -properties:
> -- #address-cells  - number of cells required to define a chip select
> -               address on the SPI bus.
> -- #size-cells     - should be zero.
> -
> -In slave mode, the SPI controller node requires one additional property:
> -- spi-slave       - Empty property.
> -
> -No other properties are required in the SPI bus node.  It is assumed
> -that a driver for an SPI bus device will understand that it is an SPI bus.
> -However, the binding does not attempt to define the specific method for
> -assigning chip select numbers.  Since SPI chip select configuration is
> -flexible and non-standardized, it is left out of this binding with the
> -assumption that board specific platform code will be used to manage
> -chip selects.  Individual drivers can define additional properties to
> -support describing the chip select layout.
> -
> -Optional properties (master mode only):
> -- cs-gpios       - gpios chip select.
> -- num-cs         - total number of chipselects.
> -
> -If cs-gpios is used the number of chip selects will be increased automatically
> -with max(cs-gpios > hw cs).
> -
> -So if for example the controller has 2 CS lines, and the cs-gpios
> -property looks like this:
> -
> -cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
> -
> -Then it should be configured so that num_chipselect = 4 with the
> -following mapping:
> -
> -cs0 : &gpio1 0 0
> -cs1 : native
> -cs2 : &gpio1 1 0
> -cs3 : &gpio1 2 0
> -
> -
> -SPI slave nodes must be children of the SPI controller node.
> -
> -In master mode, one or more slave nodes (up to the number of chip selects) can
> -be present.  Required properties are:
> -- compatible      - Name of SPI device following generic names recommended
> -                   practice.
> -- reg             - Chip select address of device.
> -- spi-max-frequency - Maximum SPI clocking speed of device in Hz.
> -
> -In slave mode, the (single) slave node is optional.
> -If present, it must be called "slave".  Required properties are:
> -- compatible      - Name of SPI device following generic names recommended
> -                   practice.
> -
> -All slave nodes can contain the following optional properties:
> -- spi-cpol        - Empty property indicating device requires inverse clock
> -                   polarity (CPOL) mode.
> -- spi-cpha        - Empty property indicating device requires shifted clock
> -                   phase (CPHA) mode.
> -- spi-cs-high     - Empty property indicating device requires chip select
> -                   active high.
> -- spi-3wire       - Empty property indicating device requires 3-wire mode.
> -- spi-lsb-first   - Empty property indicating device requires LSB first mode.
> -- spi-tx-bus-width - The bus width (number of data wires) that is used for MOSI.
> -                   Defaults to 1 if not present.
> -- spi-rx-bus-width - The bus width (number of data wires) that is used for MISO.
> -                   Defaults to 1 if not present.
> -- spi-rx-delay-us - Microsecond delay after a read transfer.
> -- spi-tx-delay-us - Microsecond delay after a write transfer.
> -
> -Some SPI controllers and devices support Dual and Quad SPI transfer mode.
> -It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
> -wires (QUAD).
> -Now the value that spi-tx-bus-width and spi-rx-bus-width can receive is
> -only 1 (SINGLE), 2 (DUAL) and 4 (QUAD).
> -Dual/Quad mode is not allowed when 3-wire mode is used.
> -
> -If a gpio chipselect is used for the SPI slave the gpio number will be passed
> -via the SPI master node cs-gpios property.
> -
> -SPI example for an MPC5200 SPI bus:
> -       spi@f00 {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
> -               reg = <0xf00 0x20>;
> -               interrupts = <2 13 0 2 14 0>;
> -               interrupt-parent = <&mpc5200_pic>;
> -
> -               ethernet-switch@0 {
> -                       compatible = "micrel,ks8995m";
> -                       spi-max-frequency = <1000000>;
> -                       reg = <0>;
> -               };
> -
> -               codec@1 {
> -                       compatible = "ti,tlv320aic26";
> -                       spi-max-frequency = <100000>;
> -                       reg = <1>;
> -               };
> -       };
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> new file mode 100644
> index 000000000000..dc239083886c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI Controller Generic Binding
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +description: |
> +  SPI busses can be described with a node for the SPI controller device
> +  and a set of child nodes for each SPI slave on the bus. The system SPI
> +  controller may be described for use in SPI master mode or in SPI slave mode,
> +  but not for both at the same time.
> +
> +properties:
> +  $nodename:
> +    pattern: "^spi(@[a-zA-Z0-9]+)?$"

I think we want just "(@.*)". At a minimum, you need to allow for ','.
It would be the a bus schema for the parent which should validate unit
addresses, so we should pretty much just allow anything here.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  cs-gpios:
> +    description: |
> +      GPIOs used as chip selects.
> +      If that property is used, the number of chip selects will be
> +      increased automatically with max(cs-gpios, hardware chip selects).
> +
> +      So if, for example, the controller has 2 CS lines, and the
> +      cs-gpios looks like this
> +        cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
> +
> +      Then it should be configured so that num_chipselect = 4, with
> +      the following mapping
> +        cs0 : &gpio1 0 0
> +        cs1 : native
> +        cs2 : &gpio1 1 0
> +        cs3 : &gpio1 2 0
> +
> +  num-cs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Total number of chip selects.
> +
> +  spi-slave:
> +    $ref: /schemas/types.yaml#/definitions/flag

"type: boolean" is sufficient here. Maybe we should just remove
'flag'. OTOH, maybe consistency with other types and the abstraction
is better as we could add to the flag schema.

> +    description:
> +      The SPI controller acts as a slave, instead of a master.
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"

Only if there are child nodes...

> +
> +patternProperties:
> +  "^slave$":

type: object

> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the SPI device.
> +
> +    required:
> +      - compatible
> +
> +  "^[a-z]+@[0-9]+$":

  "^.*@[0-9a-f]+":
    type: object

> +    properties:
> +      compatible:
> +        description:
> +          Compatible of the SPI device.
> +
> +      reg:
> +        maxItems: 1
> +        description:
> +          Chip select used by the device.

I tend to think we should limit something like this to reasonable
values. We're not going to have 2^32 chip selects. 256 should be
enough for anyone(TM).

> +      spi-3wire:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires 3-wire mode.
> +
> +      spi-cpha:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires shifted clock phase (CPHA) mode.
> +
> +      spi-cpol:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires inverse clock polarity (CPOL) mode.
> +
> +      spi-cs-high:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires the chip select active high.
> +
> +      spi-lsb-first:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires the LSB first mode.
> +
> +      spi-rx-bus-width:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [ 1, 2, 4, 8 ]

Is the old doc out of date and 8 is allowed now?

> +          - default: 1
> +        description:
> +          Bus width to the SPI bus used for MISO.
> +
> +      spi-rx-delay-us:
> +        $ref: /schemas/types.yaml#/definitions/uint32

This can actually be dropped because any property with a unit suffix
is already type checked.


> +        description:
> +          Delay, in microseconds, after a read transfer.
> +
> +      spi-tx-bus-width:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [ 1, 2, 4, 8 ]
> +          - default: 1
> +        description:
> +          Bus width to the SPI bus used for MOSI.
> +
> +      spi-tx-delay-us:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Delay, in microseconds, after a write transfer.

You missed spi-max-frequency.

> +
> +    required:
> +      - compatible
> +      - reg
> +
> +examples:
> +  - |
> +    spi@f00 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
> +        reg = <0xf00 0x20>;
> +        interrupts = <2 13 0 2 14 0>;
> +        interrupt-parent = <&mpc5200_pic>;
> +
> +        ethernet-switch@0 {
> +            compatible = "micrel,ks8995m";
> +            spi-max-frequency = <1000000>;
> +            reg = <0>;
> +        };
> +
> +        codec@1 {
> +            compatible = "ti,tlv320aic26";
> +            spi-max-frequency = <100000>;
> +            reg = <1>;
> +        };
> +    };
>
> base-commit: fcdb095ad0016d77d3729dcf8ea915ca4b80fd8b
> --
> git-series 0.9.1
