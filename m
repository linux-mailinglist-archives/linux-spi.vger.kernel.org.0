Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6912064B
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLPMuO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 07:50:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55828 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfLPMuO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Dec 2019 07:50:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBGCo5tL114860;
        Mon, 16 Dec 2019 06:50:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576500605;
        bh=RlMwp5ZUS8U4z0fPiE9aBb1RcLF2ZfFaDsNvc1JjsHQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t6jOE56/zbG+qmtqL7IHe5S/4hThxJJqaOwjr/lyVW0vzf2f1CC1LpXdMkhgwrl8E
         0mKv5tpVlUf18nOUzwU/onupnHiXp3kKjBaZP0aEm23vD1/iWd7WVd2F/z+4qKI05Y
         TbQ5zjVwJFaze8AMuI7eQbt59/sF8NpbodJT4NEQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBGCo5wI117262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 06:50:05 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 06:50:05 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 06:50:05 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBGCo2gn096690;
        Mon, 16 Dec 2019 06:50:03 -0600
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191209084035.55603-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191209084035.55603-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8d71f459-96a2-4b09-05e1-5f905e9bb3af@ti.com>
Date:   Mon, 16 Dec 2019 18:20:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209084035.55603-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 09/12/19 2:10 pm, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence,qspi.yaml      | 162 +++++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> new file mode 100644
> index 000000000000..7756c34bb453
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cadence,qspi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence QSPI Flash Controller support
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  Add support for the Cadence QSPI controller,This controller is
> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
> +  has been tested On Intel's LGM SoC.
> +

This looks like a commit message. Description should probably says
something like "Binding Documentation for Cadence QSPI controller..."

> +  - compatible : should be one of the following:
> +        Generic default - "cdns,qspi-nor".
> +        For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> +        For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> +        For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
> +
> +properties:
> +  compatible:
> +    enum:

This should be:

  compatible:
    oneOf:
      - items:
        - enum:
           - ti,k2g-qspi
        - const: cdns,qspi-nor

      - items:
        - enum:
           - ti,am654-ospi
        - const: cdns,qspi-nor

      - items:
        - enum:
           - intel,lgm-qspi
        - const: cdns,qspi-nor

      - items:
        - const: cdns,qspi-nor

> +      - cadence,qspi

This wrong and does not match what you is there in description above.
"cadence" is not a valid vendor prefix... It should be "cdns" as per
Documentation/devicetree/bindings/vendor-prefixes.yaml

Have you verified this yaml schema? I see bunch of errors for my platform

> +      - cdns,qspi-nor
> +      - ti,k2g-qspi
> +      - ti,am654-ospi
> +      - intel,lgm-qspi
> +
> +  reg:
> +    description: |
> +      Contains two entries, each of which is a tuple consisting of a
> +      Physical address and length. The first entry is the address and
> +      length of the controller register set. The second entry is the
> +      address and length of the QSPI Controller data area.

Don't you need to put a constraint here, like:

maxItems: 2

> +
> +  interrupts:
> +    description:
> +      Unit interrupt specifier for the controller interrupt.
> +

maxItems: 1??

> +  clocks:
> +    description:
> +      phandle to the Quad SPI clock.
> +

maxItems: 1??

> +  cdns,fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the data FIFO in words.
> +
> +  cdns,fifo-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bus width of the data FIFO in bytes.
> +
> +  cdns,trigger-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      32-bit indirect AHB trigger address.
> +
> +  cdns,is-decoded-cs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Flag to indicate whether decoder is used or not.
> +
> +  cdns,rclk-en:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Flag to indicate that QSPI return clock is used to latch the read data
> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
> +      on the board before using this property.
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: qspi
> +      - const: qspi-ocp
> +
> +# subnode's properties
> +patternProperties:
> +  "^.*@[0-9a-fA-F]+$":
> +    type: object
> +    description:
> +      flash device uses the subnodes below defined properties.
> +
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay for read capture logic, in clock cycles.
> +
> +  cdns,tshsl-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds for the length that the master mode chip select
> +      outputs are de-asserted between transactions.
> +
> +  cdns,tsd2d-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds between one chip select being de-activated
> +      and the activation of another.
> +
> +  cdns,tchsh-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).
> +
> +  cdns,tslch-ns:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Delay in nanoseconds between setting qspi_n_ss_out low and
> +      first bit transfer.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks

> +  - cdns,is-decoded-cs

Not a required property as per existing DT bindings


> +  - cdns,fifo-depth
> +  - cdns,fifo-width
> +  - cdns,trigger-address


> +  - resets
> +  - reset-names

Again optional properties

> +
> +examples:
> +  - |
> +    qspi: spi@ff705000 {
> +          compatible = "cadence,qspi", "cdns,qspi-nor";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          reg = <0xff705000 0x1000>,
> +                <0xffa00000 0x1000>;
> +          interrupts = <0 151 4>;
> +          clocks = <&qspi_clk>;
> +          cdns,is-decoded-cs;
> +          cdns,fifo-depth = <128>;
> +          cdns,fifo-width = <4>;
> +          cdns,trigger-address = <0x00000000>;
> +          resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
> +          reset-names = "qspi", "qspi-ocp";
> +
> +          flash0: n25q00@0 {
> +              ...
> +              cdns,read-delay = <4>;
> +              cdns,tshsl-ns = <50>;
> +              cdns,tsd2d-ns = <50>;
> +              cdns,tchsh-ns = <4>;
> +              cdns,tslch-ns = <4>;
> +          };
> +    };
> +
> 

No blank line before EOF, please

-- 
Regards
Vignesh
