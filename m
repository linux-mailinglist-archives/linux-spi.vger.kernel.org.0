Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F5A18C555
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 03:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCTCdV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Mar 2020 22:33:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:29834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgCTCdV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Mar 2020 22:33:21 -0400
IronPort-SDR: z0HNa5FV7vimi3PCrE6YjuPoXzYxGYprA43qYkCWbRQkWxQb/bcuQQsklk/SYAsMgI7Eefp60Z
 RZHKbZs+oTmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 19:33:20 -0700
IronPort-SDR: 3gLzar50WJh58Au/dPfS6lx/T+v8IZQKDkiOwfTZeGclg81UlL5H5XPgqdBU8Slfy0mjCfpB43
 XBZJWWCaLDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,282,1580803200"; 
   d="scan'208";a="239106177"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 19:33:20 -0700
Received: from [10.215.159.127] (vramuthx-mobl1.gar.corp.intel.com [10.215.159.127])
        by linux.intel.com (Postfix) with ESMTP id 0E21358058B;
        Thu, 19 Mar 2020 19:33:13 -0700 (PDT)
Subject: Re: [PATCH v12 1/4] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, devicetree@vger.kernel.org,
        boris.brezillon@free-electrons.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        tien.fong.chee@intel.com, marex@denx.de,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org, richard@nod.at,
        computersforpeace@gmail.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200310015213.1734-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200319184448.GA25121@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <7b12612b-17b2-3bab-5c58-57dd46b7d44d@linux.intel.com>
Date:   Fri, 20 Mar 2020 10:33:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319184448.GA25121@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

      Thank you for the review comments...

On 20/3/2020 2:44 am, Rob Herring wrote:
> On Tue, Mar 10, 2020 at 09:52:10AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 127 +++++++++++++++++++++
>>   2 files changed, 127 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>> deleted file mode 100644
>> index 945be7d5b236..000000000000
>> --- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
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
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> new file mode 100644
>> index 000000000000..d21f80604af4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -0,0 +1,127 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Cadence QSPI Flash Controller support
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +description: |
>> +  Binding Documentation for Cadence QSPI controller,This controller is
>> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
>> +  has been tested On Intel's LGM SoC.
>> +
>> +properties:
>> +  compatible:
>> +     enum:
>> +       - cdns,qspi-nor
>> +       - ti,k2g-qspi
>> +       - ti,am654-ospi
>> +       - intel,lgm-qspi
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  cdns,fifo-depth:
>> +    description:
>> +     Depth of hardware FIFOs.
>> +    allOf:
>> +      - $ref: "/schemas/types.yaml#/definitions/uint32"
>> +      - enum: [ 128, 256 ]
>> +      - default: 128
>> +
>> +  cdns,fifo-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      4 byte bus width of the data FIFO in bytes.
>> +
>> +  cdns,trigger-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      32-bit indirect AHB trigger address.
>> +
>> +  cdns,rclk-en:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Flag to indicate that QSPI return clock is used to latch the read data
>> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
>> +      on the board before using this property.
> Sounds like a boolean rather than a uint32? If not, then constraints on
> the values?
Good catch, will update.
>> +# subnode's properties
>> +patternProperties:
>> +  "^.*@[0-9a-fA-F]+$":
> How many chip selects do you support? The unit-address can be limited as
> I'd guess it's less than 16. Also, should be lowercase hex.
MAX 16 , will update.
>> +    type: object
>> +    description:
>> +      flash device uses the subnodes below defined properties.
>> +
>> +  cdns,read-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Delay in 4 microseconds, read capture logic, in clock cycles.
> 4us or clock cycles?
clock cycles
>> +
>> +  cdns,tshsl-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, for the length that the master mode chip select
>> +      outputs are de-asserted between transactions.
> Sounds like you can add:
>
> multipleOf: 50
>
>> +
>> +  cdns,tsd2d-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, between one chip select being de-activated
>> +      and the activation of another.
> Same here
>
>> +
>> +  cdns,tchsh-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between last bit of current transaction and
>> +      deasserting the device chip select (qspi_n_ss_out).
> multipleOf: 4
>
>> +
>> +  cdns,tslch-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between setting qspi_n_ss_out low and
>> +      first bit transfer.
> multipleOf: 4
Noted, will update all of the above.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - cdns,fifo-depth
>> +  - cdns,fifo-width
>> +  - cdns,trigger-address
>> +
>> +examples:
>> +  - |
>> +    qspi: spi@ff705000 {
> Drop the label.
Agreed!
>> +          compatible = "cdns,qspi-nor";
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +          reg = <0xff705000 0x1000>,
>> +                <0xffa00000 0x1000>;
>> +          interrupts = <0 151 4>;
>> +          clocks = <&qspi_clk>;
>> +          cdns,fifo-depth = <128>;
>> +          cdns,fifo-width = <4>;
>> +          cdns,trigger-address = <0x00000000>;
>> +
>> +          flash0: n25q00@0 {
> flash@0

Agreed!

Regards
Vadivel
>> +              compatible = "jedec,spi-nor";
>> +              reg = <0x0>;
>> +              cdns,read-delay = <4>;
>> +              cdns,tshsl-ns = <50>;
>> +              cdns,tsd2d-ns = <50>;
>> +              cdns,tchsh-ns = <4>;
>> +              cdns,tslch-ns = <4>;
>> +          };
>> +    };
>> +
>> -- 
>> 2.11.0
>>
