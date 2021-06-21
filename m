Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E178B3AE618
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFUJee (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 05:34:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33776 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUJee (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 05:34:34 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15L9WJaj009185;
        Mon, 21 Jun 2021 04:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624267939;
        bh=4I2/2eb8nZ0S8cBUZBu8V0VwmlPkUizPMMASelNMArs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pA625G/CNfc3Kz+RFgb04T6l6InYatEelIoDsHQzoSWPbezLssQKimxPFrNQ16kGd
         xlE6yY+fvAA5g5O1xlx576SuIfynRuB88T9UGWlH8cM3qzXAhMvkHHgjs+S71Hd99Z
         p5H035ORGZt/N9p2QjXmFG9FrlS9uFt4GzWuYdhY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15L9WJev014028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jun 2021 04:32:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 21
 Jun 2021 04:32:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 21 Jun 2021 04:32:19 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15L9WF2l120911;
        Mon, 21 Jun 2021 04:32:16 -0500
Subject: Re: [PATCH v2] dt-bindings: spi: omap-spi: Convert to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210608052010.15656-1-a-govindraju@ti.com>
 <20210618204505.GA2835349@robh.at.kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <b7a661bc-69f4-4c90-c6db-a7ef84d43f65@ti.com>
Date:   Mon, 21 Jun 2021 15:02:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210618204505.GA2835349@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On 19/06/21 2:15 am, Rob Herring wrote:
> On Tue, Jun 08, 2021 at 10:50:09AM +0530, Aswath Govindraju wrote:
>> Convert omap-spi dt-binding documentation from txt to yaml format.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> changes since v1:
>> - split the series according to their respective trees
>>
>> link to v1:
>> https://lore.kernel.org/patchwork/project/lkml/list/?series=502255
>>
>>  .../devicetree/bindings/spi/omap-spi.txt      |  48 -------
>>  .../devicetree/bindings/spi/omap-spi.yaml     | 126 ++++++++++++++++++
>>  2 files changed, 126 insertions(+), 48 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
>>  create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
>> deleted file mode 100644
>> index 487208c256c0..000000000000
>> --- a/Documentation/devicetree/bindings/spi/omap-spi.txt
>> +++ /dev/null
>> @@ -1,48 +0,0 @@
>> -OMAP2+ McSPI device
>> -
>> -Required properties:
>> -- compatible :
>> -  - "ti,am654-mcspi" for AM654.
>> -  - "ti,omap2-mcspi" for OMAP2 & OMAP3.
>> -  - "ti,omap4-mcspi" for OMAP4+.
>> -- ti,spi-num-cs : Number of chipselect supported  by the instance.
>> -- ti,hwmods: Name of the hwmod associated to the McSPI
>> -- ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
>> -			  input. The default is D0 as input and
>> -			  D1 as output.
>> -
>> -Optional properties:
>> -- dmas: List of DMA specifiers with the controller specific format
>> -	as described in the generic DMA client binding. A tx and rx
>> -	specifier is required for each chip select.
>> -- dma-names: List of DMA request names. These strings correspond
>> -	1:1 with the DMA specifiers listed in dmas. The string naming
>> -	is to be "rxN" and "txN" for RX and TX requests,
>> -	respectively, where N equals the chip select number.
>> -
>> -Examples:
>> -
>> -[hwmod populated DMA resources]
>> -
>> -mcspi1: mcspi@1 {
>> -    #address-cells = <1>;
>> -    #size-cells = <0>;
>> -    compatible = "ti,omap4-mcspi";
>> -    ti,hwmods = "mcspi1";
>> -    ti,spi-num-cs = <4>;
>> -};
>> -
>> -[generic DMA request binding]
>> -
>> -mcspi1: mcspi@1 {
>> -    #address-cells = <1>;
>> -    #size-cells = <0>;
>> -    compatible = "ti,omap4-mcspi";
>> -    ti,hwmods = "mcspi1";
>> -    ti,spi-num-cs = <2>;
>> -    dmas = <&edma 42
>> -	    &edma 43
>> -	    &edma 44
>> -	    &edma 45>;
>> -    dma-names = "tx0", "rx0", "tx1", "rx1";
>> -};
>> diff --git a/Documentation/devicetree/bindings/spi/omap-spi.yaml b/Documentation/devicetree/bindings/spi/omap-spi.yaml
>> new file mode 100644
>> index 000000000000..cd20704f2edc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/omap-spi.yaml
>> @@ -0,0 +1,126 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/omap-spi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SPI controller bindings for OMAP and K3 SoCs
>> +
>> +maintainers:
>> +  - Mark Brown <broonie@kernel.org>
> 
> A TI person here please.
> 

Added myself as the reviewer in v3.

Thank you for the review and comments. I have posted a respin(v3) of
this patch after addressing all the comments.

Thanks,
Aswath

> You need a ref to spi-controller.yaml
> 
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - ti,am654-mcspi
>> +              - ti,am4372-mcspi
>> +          - const: ti,omap4-mcspi
>> +      - items:
>> +          - enum:
>> +              - ti,omap2-mcspi
>> +              - ti,omap4-mcspi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
> 
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
> 
> Don't need these, covered by spi-controller.yaml.
> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  ti,spi-num-cs:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Number of chipselect supported  by the instance.
>> +    minimum: 1
>> +    maximum: 4
>> +
>> +  ti,hwmods:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Must be "mcspi<n>", n being the instance number (1-based).
>> +      This property is applicable only on legacy platforms mainly omap2/3
>> +      and ti81xx and should not be used on other platforms.
>> +    deprecated: true
>> +
>> +  ti,pindir-d0-out-d1-in:
>> +    description:
>> +      Select the D0 pin as output and D1 as input. The default is D0
>> +      as input and D1 as output.
>> +    type: boolean
>> +
>> +  dmas:
>> +    description:
>> +      List of DMA specifiers with the controller specific format as
>> +      described in the generic DMA client binding. A tx and rx
>> +      specifier is required for each chip select.
>> +    minItems: 1
>> +    maxItems: 8
>> +
>> +  dma-names:
>> +    description:
>> +      List of DMA request names. These strings correspond 1:1 with
>> +      the DMA sepecifiers listed in dmas. The string names is to be
>> +      "rxN" and "txN" for RX and TX requests, respectively. Where N
>> +      is the chip select number.
>> +    minItems: 1
>> +    maxItems: 8
>> +
>> +patternProperties:
>> +  "@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Flash devices are defined as a sub-node of the spi controller
> 
> Covered by spi-controller.yaml.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      oneOf:
>> +        - const: ti,omap2-mcspi
>> +        - const: ti,omap4-mcspi
>> +
>> +then:
>> +  properties:
>> +    ti,hwmods:
>> +      items:
>> +        - pattern: "^mcspi([1-9])$"
>> +
>> +else:
>> +  properties:
>> +    ti,hwmods: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +    main_spi0: spi@2100000 {
> 
> Drop unused labels.
> 
>> +      compatible = "ti,am654-mcspi","ti,omap4-mcspi";
>> +      reg = <0x2100000 0x400>;
>> +      interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&k3_clks 137 1>;
>> +      power-domains = <&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
>> +      dma-names = "tx0", "rx0";
>> +    };
>> -- 
>> 2.17.1
>>
>>

