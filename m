Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6E4DE2D8
	for <lists+linux-spi@lfdr.de>; Fri, 18 Mar 2022 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiCRUvs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Mar 2022 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbiCRUvq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Mar 2022 16:51:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91B66108551;
        Fri, 18 Mar 2022 13:50:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 565441515;
        Fri, 18 Mar 2022 13:50:26 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FBB43F7D7;
        Fri, 18 Mar 2022 13:50:24 -0700 (PDT)
Message-ID: <3bf14cf0-f00d-f718-30ea-e63272f3ce72@arm.com>
Date:   Fri, 18 Mar 2022 20:50:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Content-Language: en-GB
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
 <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2022-02-25 21:13, Heiner Kallweit wrote:
> Add a YAML schema binding for TM1628 auxdisplay
> (7/11-segment LED) controller.
> 
> This patch is partially based on previous work from
> Andreas Färber <afaerber@suse.de>.
> 
> Co-developed-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v5:
> - add vendor prefix to driver-specific properties
> ---
>   .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>   1 file changed, 92 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> new file mode 100644
> index 000000000..2a1ef692c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Titan Micro Electronics TM1628 LED controller
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: titanmec,tm1628
> +
> +  reg:
> +    maxItems: 1
> +
> +  titanmec,grid:
> +    description:
> +      Mapping of display digit position to grid number.
> +      This implicitly defines the display size.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 1
> +    maxItems: 7
> +
> +  titanmec,segment-mapping:
> +    description:
> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 7
> +    maxItems: 7
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg

Would it be fair to say that "spi-lsb-first" and "spi-3wire" are also 
required? The chips aren't configurable so won't exactly be usable any 
other way. Furthermore I believe the transmission format actually works 
out equivalent to SPI mode 3, so should warrant "spi-cpha" and 
"spi-cpol" as well.

> +
> +patternProperties:
> +  "^.*@[1-7],([1-9]|1[0-6])$":
> +    type: object
> +    $ref: /schemas/leds/common.yaml#
> +    unevaluatedProperties: false
> +    description: |
> +      Properties for a single LED.
> +
> +    properties:
> +      reg:
> +        description: |
> +          1-based grid number, followed by 1-based segment bit number.
> +        maxItems: 1
> +
> +    required:
> +      - reg

I'm concerned that this leaves us no room to support the additional 
keypad functionality in future. Having now double-checked a datasheet, 
the inputs are also a two-dimensional mux (sharing the segment lines), 
so the device effectively has two distinct but numerically-overlapping 
child address spaces - one addressed by (grid,segment) and the other by 
(segment,key).

Rob, Krysztof, any thoughts on the best DT idiom to leave accommodation 
for that? I'm thinking either require an intermediate node to contain 
each notional address space, or perhaps add another leading address cell 
to select between them? I don't believe any of these things have further 
functionality beyond that.

Thanks,
Robin.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@0 {
> +            compatible = "titanmec,tm1628";
> +            reg = <0>;
> +            spi-3-wire;
> +            spi-lsb-first;
> +            spi-max-frequency = <500000>;
> +            titanmec,grid = /bits/ 8 <4 3 2 1>;
> +            titanmec,segment-mapping = /bits/ 8 <4 5 6 1 2 3 7>;
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            alarm@5,4 {
> +                reg = <5 4>;
> +                function = LED_FUNCTION_ALARM;
> +            };
> +        };
> +    };
> +...
