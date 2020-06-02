Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FAF1EC576
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jun 2020 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgFBXHp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 19:07:45 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57676 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgFBXHp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 19:07:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C898F803083B;
        Tue,  2 Jun 2020 23:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 36FlyoStlb5r; Wed,  3 Jun 2020 02:07:40 +0300 (MSK)
Date:   Wed, 3 Jun 2020 02:07:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lars Povlsen <lars.povlsen@microchip.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/10] dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
Message-ID: <20200602230738.mz2y6i2kjagyt7tk@mobilestation>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-7-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513140031.25633-7-lars.povlsen@microchip.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 04:00:27PM +0200, Lars Povlsen wrote:
> This add DT bindings for the Sparx5 SPI driver.

This whole file can be easily merged in to the generic DW APB SSI DT
binding file. Just use "if: properties: compatible: const: ..." construction
to distinguish ocelot, jaguar, sparx5 and non-sparx5 nodes.

> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../bindings/spi/mscc,ocelot-spi.yaml         | 49 +++++++++++++++----
>  1 file changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
> index a3ac0fa576553..8beecde4b0880 100644
> --- a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
> @@ -23,15 +23,23 @@ properties:
>      enum:
>        - mscc,ocelot-spi
>        - mscc,jaguar2-spi
> +      - microchip,sparx5-spi
> 
>    interrupts:
>      maxItems: 1
> 
>    reg:
>      minItems: 2
> -    items:
> -      - description: Designware SPI registers
> -      - description: CS override registers
> +    maxItems: 3
> +    oneOf:
> +      - items:
> +          - description: Designware SPI registers
> +          - description: CS override registers (Not sparx5).
> +      - items:
> +          - description: Designware SPI registers
> +          - description: CS override registers (Not sparx5).
> +          - description: Direct mapped SPI read area. If provided, the
> +              driver will register spi_mem_op's to take advantage of it.
> 
>    clocks:
>      maxItems: 1
> @@ -43,6 +51,23 @@ properties:
>         enum: [ 2, 4 ]
>      maxItems: 1
> 

> +  spi-rx-delay-us:
> +    description: |
> +      The delay (in usec) of the RX signal sample position. This can
> +      be used to tne the RX timing in order to acheive higher
> +      speeds. This is used for all devices on the bus.
> +    default: 0
> +    maxItems: 1

spi-rx-delay-us is defined for a particular SPI-slave. Please see the
DT binding file: Documentation/devicetree/bindings/spi/spi-controller.yaml .
Although as I suggested before this delay isn't what the Dw APB SSI RX sample
delay functionality does. Probably a vendor-specific property would be better
here. But I'd also define it on a SPI-slave basis, not for all devices on the
bus.

> +
> +  interface-mapping-mask:
> +    description: |
> +      On the Sparx5 variant, two different busses are connected to the
> +      controller. This property is a mask per chip-select, indicating
> +      whether the CS should go to one or the other interface.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    maxItems: 1

As Mark rightfully suggested this seems like an SPI-slave related property, then
most likely it should be defined on the SPI-slave basis (probably as a bool
property). Additionally it's vendor-specific, so the property name should be
accordingly prefixed.

> +
>  required:
>    - compatible
>    - reg
> @@ -50,11 +75,15 @@ required:
> 
>  examples:
>    - |
> -    spi0: spi@101000 {
> -      compatible = "mscc,ocelot-spi";
> -      #address-cells = <1>;
> -      #size-cells = <0>;
> -      reg = <0x101000 0x100>, <0x3c 0x18>;
> -      interrupts = <9>;
> -      clocks = <&ahb_clk>;
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    spi0: spi@600104000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "microchip,sparx5-spi";

> +        reg = <0x00104000 0x40>, <0 0>, <0x3000000 0x4000000>;

I have a doubt that defining an empty reg region is a good idea, since you can
detect the reg requirements by the node compatible string.

-Sergey

> +        num-cs = <16>;
> +        reg-io-width = <4>;
> +        reg-shift = <2>;
> +        clocks = <&ahb_clk>;
> +        interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>      };
> --
> 2.26.2
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
