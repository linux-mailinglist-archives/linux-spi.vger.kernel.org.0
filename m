Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81F31DAFA6
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgETKF4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 06:05:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:9129 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgETKFz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 06:05:55 -0400
IronPort-SDR: 1+RHnfLlQj0pD1oFWLWuHGaglogrJEvjpipEE6bUo2g8CVtf8nPph0CPBwtU2HaXZL4Hal7oU6
 jGKFPzBITRIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:05:53 -0700
IronPort-SDR: k4MGfed4z1V1QVYLnzSUq5BUEJDxC8Nx3fg8RDLK32tCZX6T2hV40qFS+LbhjTUpdrb7tn/L3B
 eEdR5roby4/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="466330359"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 03:05:53 -0700
Received: from [10.213.128.101] (vramuthx-MOBL1.gar.corp.intel.com [10.213.128.101])
        by linux.intel.com (Postfix) with ESMTP id 441C6580101;
        Wed, 20 May 2020 03:05:50 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, broonie@kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20200512004919.40685-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200519184415.GA441457@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <b685ed91-e25b-4a1e-2779-d39dc56cecb3@linux.intel.com>
Date:   Wed, 20 May 2020 18:05:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519184415.GA441457@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

   Thank you very much for the review comments...

On 20/5/2020 2:44 am, Rob Herring wrote:
> On Tue, May 12, 2020 at 08:49:19AM +0800, Ramuthevar,Vadivel MuruganX wrote:
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
>> index 000000000000..28112b38e6a9
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
> 
> Need to define what each entry is.
Noted.
> 
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
> 
> ...FIFO in words.
Good catch.
> 
>> +    allOf:
>> +      - $ref: "/schemas/types.yaml#/definitions/uint32"
>> +      - enum: [ 128, 256 ]
>> +      - default: 128
>> +
>> +  cdns,fifo-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      4 byte bus width of the data FIFO in bytes.
> 
> Constraints? Perhaps:
> 
> multipleOf: 4
Noted, will update.
> 
> if an enum doesn't work here.
> 
>> +
>> +  cdns,trigger-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      32-bit indirect AHB trigger address.
>> +
>> +  cdns,rclk-en:
>> +    type: boolean
>> +    description: |
>> +      Flag to indicate that QSPI return clock is used to latch the read data
>> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
>> +      on the board before using this property.
>> +
>> +# subnode's properties
>> +patternProperties:
>> +  "^.*@[0-9a-fa-f]+$":
> 
> 'a-f' is twice. What's the max number of chip selects? If less than 10,
> then '@[0-9]$' is enough. '^.*' can be dropped too.
16 chip select supports.
> 
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
>> +
>> +examples:
>> +  - |
>> +    spi@ff705000 {
>> +          compatible = "cdns,qspi-nor";
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +          reg = <0xff705000 0x1000>,
>> +                <0xffa00000 0x1000>;
> 
> Seems kind of small for a data area if this is like most SPI flash
> controllers.yes you are right, following the existing example as it is.

Regards
Vadivel

> 
>> +          interrupts = <0 151 4>;
>> +          clocks = <&qspi_clk>;
>> +          cdns,fifo-depth = <128>;
>> +          cdns,fifo-width = <4>;
>> +          cdns,trigger-address = <0x00000000>;
>> +
>> +          flash@0 {
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
