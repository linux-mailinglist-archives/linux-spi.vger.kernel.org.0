Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388EC1F54C8
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgFJM1p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 08:27:45 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:46310 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgFJM1p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Jun 2020 08:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591792064; x=1623328064;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=QiFuJl1R5fgwI47VUdUxy1XjRtgrcDqvma+iH44NFSk=;
  b=hnRHTdJronscFR2yTjdh97Lj7hS7DuvbTw98YNO51LZ3UXc/1VMvT8iB
   tL32XQg6qZmB6lfLXpoB2+hle/VHVqO0638F1CEGsBCKwtcezoAnTve40
   UtUMcouuRqBCG2vZROnAdGnkLkF3n4xEH4so9O9shjaHuRwzWkSXN++Dg
   nAX7PHQHVJ+VPaqQzE/QaSkUOXkRjHN0YWkIxvvNbhEGsAoBZYHFFM+e1
   XzF4NOtkHPx8N+c74t5M1N2DM2VmSRzs38MnZhCez0+lm1Ql7QT9DniJX
   /3Ff2ZGW35ZOcUDC3V/+4FNzDYCCEapg/1X7uBVSRMVOABLrnwaMGtED2
   Q==;
IronPort-SDR: 0d4g912uhVPOIXVwiNumUIxOuwQwPv1k6y8Nq0I/CzHL1DwOmpG02rnaDxCk0Xul9ey7Wz6RVN
 MoGmGnZ+EQRMel+AUBLPvkn7ON7+DX3N23NsBUbSe4kf82ZfGLZHOVKqaD2P/bCFZobnMwyTGW
 Mk/GSb29bEgBZO+qe3ATVlY/gWm3VEHHqjYkS8fUrMoicwslgxm0AquKfxlA4tXmFapYTg87ht
 IqeLuIZL/Xyzue7miwmvTsqASQip6ZlkRDLZm2sBWdIJbnx0uIdzdqdMkwOrhoL/map1dFX0IR
 qI4=
X-IronPort-AV: E=Sophos;i="5.73,496,1583218800"; 
   d="scan'208";a="15250796"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2020 05:27:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 10 Jun 2020 05:27:35 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3
 via Frontend Transport; Wed, 10 Jun 2020 05:27:32 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-7-lars.povlsen@microchip.com> <20200602230738.mz2y6i2kjagyt7tk@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/10] dt-bindings: spi: spi-dw-mchp: Add Sparx5 support
In-Reply-To: <20200602230738.mz2y6i2kjagyt7tk@mobilestation>
Date:   Wed, 10 Jun 2020 14:27:31 +0200
Message-ID: <87d067hzrg.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> On Wed, May 13, 2020 at 04:00:27PM +0200, Lars Povlsen wrote:
>> This add DT bindings for the Sparx5 SPI driver.
>
> This whole file can be easily merged in to the generic DW APB SSI DT
> binding file. Just use "if: properties: compatible: const: ..." construction
> to distinguish ocelot, jaguar, sparx5 and non-sparx5 nodes.
>
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  .../bindings/spi/mscc,ocelot-spi.yaml         | 49 +++++++++++++++----
>>  1 file changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>> index a3ac0fa576553..8beecde4b0880 100644
>> --- a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>> @@ -23,15 +23,23 @@ properties:
>>      enum:
>>        - mscc,ocelot-spi
>>        - mscc,jaguar2-spi
>> +      - microchip,sparx5-spi
>>
>>    interrupts:
>>      maxItems: 1
>>
>>    reg:
>>      minItems: 2
>> -    items:
>> -      - description: Designware SPI registers
>> -      - description: CS override registers
>> +    maxItems: 3
>> +    oneOf:
>> +      - items:
>> +          - description: Designware SPI registers
>> +          - description: CS override registers (Not sparx5).
>> +      - items:
>> +          - description: Designware SPI registers
>> +          - description: CS override registers (Not sparx5).
>> +          - description: Direct mapped SPI read area. If provided, the
>> +              driver will register spi_mem_op's to take advantage of it.
>>
>>    clocks:
>>      maxItems: 1
>> @@ -43,6 +51,23 @@ properties:
>>         enum: [ 2, 4 ]
>>      maxItems: 1
>>
>
>> +  spi-rx-delay-us:
>> +    description: |
>> +      The delay (in usec) of the RX signal sample position. This can
>> +      be used to tne the RX timing in order to acheive higher
>> +      speeds. This is used for all devices on the bus.
>> +    default: 0
>> +    maxItems: 1
>
> spi-rx-delay-us is defined for a particular SPI-slave. Please see the
> DT binding file: Documentation/devicetree/bindings/spi/spi-controller.yaml .
> Although as I suggested before this delay isn't what the Dw APB SSI RX sample
> delay functionality does. Probably a vendor-specific property would be better
> here. But I'd also define it on a SPI-slave basis, not for all devices on the
> bus.

Right, I was hunting for something "similar". As pointed out, this is
really different in nature, and the unit is also too coarse.

I will change this to "snps,rx-sample-delay-ns" as suggested in your
other comments.

>
>> +
>> +  interface-mapping-mask:
>> +    description: |
>> +      On the Sparx5 variant, two different busses are connected to the
>> +      controller. This property is a mask per chip-select, indicating
>> +      whether the CS should go to one or the other interface.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 0
>> +    maxItems: 1
>
> As Mark rightfully suggested this seems like an SPI-slave related property, then
> most likely it should be defined on the SPI-slave basis (probably as a bool
> property). Additionally it's vendor-specific, so the property name should be
> accordingly prefixed.

Yes, I'll change this to a per-device property. I need the same for the
above as well.

>
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -50,11 +75,15 @@ required:
>>
>>  examples:
>>    - |
>> -    spi0: spi@101000 {
>> -      compatible = "mscc,ocelot-spi";
>> -      #address-cells = <1>;
>> -      #size-cells = <0>;
>> -      reg = <0x101000 0x100>, <0x3c 0x18>;
>> -      interrupts = <9>;
>> -      clocks = <&ahb_clk>;
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    spi0: spi@600104000 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "microchip,sparx5-spi";
>
>> +        reg = <0x00104000 0x40>, <0 0>, <0x3000000 0x4000000>;
>
> I have a doubt that defining an empty reg region is a good idea, since you can
> detect the reg requirements by the node compatible string.

Yes, its probably better that way. It looks ugly too :-)

Thanks for your comments!

---Lars


> -Sergey
>
>> +        num-cs = <16>;
>> +        reg-io-width = <4>;
>> +        reg-shift = <2>;
>> +        clocks = <&ahb_clk>;
>> +        interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>      };
>> --
>> 2.26.2
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lars Povlsen,
Microchip
