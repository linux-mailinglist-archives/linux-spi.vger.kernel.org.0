Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C133829A36B
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 04:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440926AbgJ0DqA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Oct 2020 23:46:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:39249 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390384AbgJ0Dp7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 23:45:59 -0400
IronPort-SDR: 4CI7y5vlQ0FabzC5a55ytBpcNAa7cqEA0RhkBIu2e7Ux4Z3T7j32oW2RH5JTKk8g+4Al1DNXZk
 3Csia1n/xYZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232210383"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="232210383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 20:45:58 -0700
IronPort-SDR: +JQ0nHjEtx7L2UnwMMF08Zmf2TNF3m9fsXc3BtF8yAqaZ8ehZ9r73k4gmmec2j4qjDWUZKA5Pz
 fLhcg4Fjjwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="303619920"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2020 20:45:57 -0700
Received: from [10.226.38.22] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.22])
        by linux.intel.com (Postfix) with ESMTP id A7C42580100;
        Mon, 26 Oct 2020 20:45:54 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v3 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201026094519.56083-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201026094519.56083-6-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201026130851.GA4188139@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <a71ec5b8-3169-4968-d3ab-d0280441a722@linux.intel.com>
Date:   Tue, 27 Oct 2020 11:45:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201026130851.GA4188139@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

Thank you very much for the review comments...

On 26/10/2020 9:08 pm, Rob Herring wrote:
> On Mon, Oct 26, 2020 at 05:45:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
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
>> index 000000000000..b1b3d3ce0cc2
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
>> +    oneOf:
>> +      - items:
>> +         - const: cdns,qspi-nor
>> +         - const: ti,k2g-qspi, cdns,qspi-nor
>> +         - const: ti,am654-ospi, cdns,qspi-nor
>> +
>> +  reg:
>> +    items:
>> +      - description: the controller register set
>> +      - description: the controller data area
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  cdns,fifo-depth:
>> +    description:
>> +      Size of the data FIFO in words.
>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>> +    enum: [ 128, 256 ]
>> +    default: 128
>> +
>> +  cdns,fifo-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Bus width of the data FIFO in bytes.
>> +    default: 4
>> +
>> +  cdns,trigger-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      32-bit indirect AHB trigger address.
>> +
>> +  cdns,is-decoded-cs:
>> +    type: boolean
>> +    description:
>> +      Flag to indicate whether decoder is used or not.
>> +
>> +  cdns,rclk-en:
>> +    type: boolean
>> +    description:
>> +      Flag to indicate that QSPI return clock is used to latch the read
>> +      data rather than the QSPI clock. Make sure that QSPI return clock
>> +      is populated on the board before using this property.
>> +
>> +  resets:
>> +    maxItems : 2
>> +
>> +  reset-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      enum: [ qspi, qspi-ocp ]
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
> 
> As-is, these apply to the parent (controller) node. If these apply to
> the child nodes, then they need to be under 'properties' under
> '@[0-9a-f]+$'.
Ok, Noted.
> 
>> +
>> +  cdns,tshsl-ns:
>> +    description: |
> 
> Don't need '|' if there's no formatting to preserve.
Noted, will update.

Regards
Vadivel
> 
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
>> +  - cdns,is-decoded-cs
>> +  - cdns,rclk-en
>> +  - resets
>> +  - reset-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    qspi: spi@ff705000 {
>> +      compatible = "cadence,qspi","cdns,qpsi-nor";
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
