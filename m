Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028F29357A
	for <lists+linux-spi@lfdr.de>; Tue, 20 Oct 2020 09:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404804AbgJTHFk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 03:05:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:40953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404797AbgJTHFk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 03:05:40 -0400
IronPort-SDR: lWZ77W6L5R04Ky2irkobN1tWi1t8hAFkqKrFngETJpjBu9x9ihjq4kwmjl1/T9Nq2cxqBHWeop
 Z8uvM3pnvBiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="228799067"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="228799067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 00:05:39 -0700
IronPort-SDR: JkUDVMQJ6bqh4I8SPe0n+OqFe+nxcWZJZpFfRcoe/VH2aIaxmzALzjfqBJunetBu7Ey9hRME4X
 drvycVYv10gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="532938891"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2020 00:05:39 -0700
Received: from [10.226.38.26] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.26])
        by linux.intel.com (Postfix) with ESMTP id B91C4580107;
        Tue, 20 Oct 2020 00:05:36 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 2/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201019213553.GA3630580@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <9c5688e2-6831-c31b-85fe-5bcb0bc68be7@linux.intel.com>
Date:   Tue, 20 Oct 2020 15:05:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019213553.GA3630580@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

Thank you for review comments...

On 20/10/2020 5:35 am, Rob Herring wrote:
> On Fri, Oct 16, 2020 at 05:31:34PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
>> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ----------
>>   .../devicetree/bindings/spi/cadence-quadspi.yaml   | 148 +++++++++++++++++++++
>>   2 files changed, 148 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>> deleted file mode 100644
>> index 945be7d5b236..000000000000
>> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
>> +++ /dev/null
>> @@ -1,67 +0,0 @@
>> -* Cadence Quad SPI controller
>> -
>> -Required properties:
>> -- compatible : should be one of the following:
>> -	Generic default - "cdns,qspi-nor".
>> -	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
>> -	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
>> -- reg : Contains two entries, each of which is a tuple consisting of a
>> -	physical address and length. The first entry is the address and
>> -	length of the controller register set. The second entry is the
>> -	address and length of the QSPI Controller data area.
>> -- interrupts : Unit interrupt specifier for the controller interrupt.
>> -- clocks : phandle to the Quad SPI clock.
>> -- cdns,fifo-depth : Size of the data FIFO in words.
>> -- cdns,fifo-width : Bus width of the data FIFO in bytes.
>> -- cdns,trigger-address : 32-bit indirect AHB trigger address.
>> -
>> -Optional properties:
>> -- cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
>> -- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
>> -  the read data rather than the QSPI clock. Make sure that QSPI return
>> -  clock is populated on the board before using this property.
>> -
>> -Optional subnodes:
>> -Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
>> -custom properties:
>> -- cdns,read-delay : Delay for read capture logic, in clock cycles
>> -- cdns,tshsl-ns : Delay in nanoseconds for the length that the master
>> -                  mode chip select outputs are de-asserted between
>> -		  transactions.
>> -- cdns,tsd2d-ns : Delay in nanoseconds between one chip select being
>> -                  de-activated and the activation of another.
>> -- cdns,tchsh-ns : Delay in nanoseconds between last bit of current
>> -                  transaction and deasserting the device chip select
>> -		  (qspi_n_ss_out).
>> -- cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
>> -                  and first bit transfer.
>> -- resets	: Must contain an entry for each entry in reset-names.
>> -		  See ../reset/reset.txt for details.
>> -- reset-names	: Must include either "qspi" and/or "qspi-ocp".
>> -
>> -Example:
>> -
>> -	qspi: spi@ff705000 {
>> -		compatible = "cdns,qspi-nor";
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -		reg = <0xff705000 0x1000>,
>> -		      <0xffa00000 0x1000>;
>> -		interrupts = <0 151 4>;
>> -		clocks = <&qspi_clk>;
>> -		cdns,is-decoded-cs;
>> -		cdns,fifo-depth = <128>;
>> -		cdns,fifo-width = <4>;
>> -		cdns,trigger-address = <0x00000000>;
>> -		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
>> -		reset-names = "qspi", "qspi-ocp";
>> -
>> -		flash0: n25q00@0 {
>> -			...
>> -			cdns,read-delay = <4>;
>> -			cdns,tshsl-ns = <50>;
>> -			cdns,tsd2d-ns = <50>;
>> -			cdns,tchsh-ns = <4>;
>> -			cdns,tslch-ns = <4>;
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>> new file mode 100644
>> index 000000000000..6ed8122a1326
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>> @@ -0,0 +1,148 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/cadence-quadspi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Cadence Quad SPI controller
>> +
>> +maintainers:
>> +  - Vadivel Murugan <vadivel.muruganx.ramuthevar@intel.com>
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: cdns,qspi-nor
>> +      - const: ti,k2g-qspi, cdns,qspi-nor
>> +      - const: ti,am654-ospi, cdns,qspi-nor
> 
> This says that compatible must be:
> 
> compatible = "cdns,qspi-nor", "ti,k2g-qspi, cdns,qspi-nor", "ti,am654-ospi, cdns,qspi-nor";
> 
> You need 'oneOf' here.
Noted, will update.
> 
>> +
>> +    description:
>> +      Should be one of the above supported compatible strings.
> 
> Drop.
okay
> 
>> +      optional properties
>> +      "cdns,is-decoded-cs" - Flag to indicate whether decoder is used or not.
>> +      "cdns,rclk-en" - Flag to indicate that QSPI return clock is used to latch
>> +      the read data rather than the QSPI clock. Make sure that QSPI return
>> +      clock is populated on the board before using this property.
> 
> Needs to be actual schema properties.
Noted.
> 
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +    description:
>> +      Contains two entries, each of which is a tuple consisting of a
>> +      physical address and length. The first entry is the address and
>> +      length of the controller register set. The second entry is the
>> +      address and length of the QSPI Controller data area.
> 
> reg:
>    items:
>      - description: the controller register set
>      - description: the controller data area
Noted, Thank you for the pointer.
> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      Unit interrupt specifier for the controller interrupt.
> 
> Drop description.
will drop.
> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description:
>> +      phandle to the Quad SPI clock.
> 
> Drop description.
will drop.
> 
>> +
>> +  cdns,fifo-depth:
>> +    description:
>> +      Size of the data FIFO in words.
>> +    allOf:
> 
> Don't need allOf here now.
will remove , noted
> 
>> +      - $ref: "/schemas/types.yaml#/definitions/uint32"
>> +      - enum: [ 128, 256 ]
>> +      - default: 128
>> +
>> +  cdns,fifo-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Bus width of the data FIFO in bytes.
>> +    multipleOf: 4
> 
> minimum/maximum?
it's fixed width, so will add default instead of minimum/maximum.
> 
>> +
>> +  cdns,trigger-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      32-bit indirect AHB trigger address.
>> +
>> +  resets:
> 
> How many (maxItems)?
maxItems : 2
> 
>> +     description:
>> +       Must contain an entry for each entry in reset-names.
>> +       See ../reset/reset.txt for details.
> 
> Drop.
Noted, will drop.
> 
>> +
>> +  reset-names:
>> +    description:
>> +      Must include either "qspi" and/or "qspi-ocp".
> 
> Needs to be schema constraints.
Okay, noted.
> 
>> +
>> +# subnode's properties
>> +patternProperties:
>> +  "@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      flash device uses the subnodes below defined properties.
>> +
>> +  cdns,read-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Delay for read capture logic, in clock cycles.
>> +
>> +  cdns,tshsl-ns:
>> +    description: |
>> +      Delay in nanoseconds for the length that the master mode chip select
>> +      outputs are de-asserted between transactions.
>> +
>> +  cdns,tsd2d-ns:
>> +    description: |
>> +      Delay in nanoseconds between one chip select being de-activated
>> +      and the activation of another.
>> +
>> +  cdns,tchsh-ns:
>> +    description: |
>> +      Delay in nanoseconds between last bit of current transaction and
>> +      deasserting the device chip select (qspi_n_ss_out).
>> +
>> +  cdns,tslch-ns:
>> +    description: |
>> +      Delay in nanoseconds between setting qspi_n_ss_out low and
>> +      first bit transfer.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - cdns,fifo-depth
>> +  - cdns,fifo-width
>> +  - cdns,trigger-address
>> +  - resets
>> +  - reset-names
> 
> additionalProperties: false
Noted, thanks!

Regards
Vadivel
> 
>> +
>> +examples:
>> +  - |
>> +    qspi: spi@ff705000 {
>> +      compatible = "cadence,qspi";
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      reg = <0xff705000 0x1000>,
>> +            <0xffa00000 0x1000>;
>> +      interrupts = <0 151 4>;
>> +      clocks = <&qspi_clk>;
>> +      cdns,fifo-depth = <128>;
>> +      cdns,fifo-width = <4>;
>> +      cdns,trigger-address = <0x00000000>;
>> +      resets = <&rst 0x1>, <&rst 0x2>;
>> +      reset-names = "qspi", "qspi-ocp";
>> +
>> +      flash@0 {
>> +              compatible = "jedec,spi-nor";
>> +              reg = <0x0>;
>> +              cdns,read-delay = <4>;
>> +              cdns,tshsl-ns = <50>;
>> +              cdns,tsd2d-ns = <50>;
>> +              cdns,tchsh-ns = <4>;
>> +              cdns,tslch-ns = <4>;
>> +     };
>> +
>> +    };
>> +
>> +...
>> -- 
>> 2.11.0
>>
