Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6894172F0D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 04:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgB1DCA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 22:02:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:38100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgB1DCA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 22:02:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 19:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="261722452"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Feb 2020 19:01:57 -0800
Received: from [10.226.38.23] (unknown [10.226.38.23])
        by linux.intel.com (Postfix) with ESMTP id 6A8B958052E;
        Thu, 27 Feb 2020 19:01:50 -0800 (PST)
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        devicetree@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        Dinh Nguyen <dinguyen@kernel.org>, tien.fong.chee@intel.com,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        david.oberhollenzer@sigma-star.at,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqJno0gmUnGnsWFYdHY_3CHNijtksAmRhuEudimip0aK4w@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <10e65e28-197f-b094-5901-917b07f09adf@linux.intel.com>
Date:   Fri, 28 Feb 2020 11:01:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJno0gmUnGnsWFYdHY_3CHNijtksAmRhuEudimip0aK4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

      Thank you so much for the review comments...

On 28/2/2020 1:07 AM, Rob Herring wrote:
> On Thu, Feb 27, 2020 at 12:27 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
> You need to run 'make dt_binding_check' because this doesn't pass.
Sure,  run and fix it.
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 142 +++++++++++++++++++++
>>   2 files changed, 142 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> new file mode 100644
>> index 000000000000..3ad2850c412e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -0,0 +1,142 @@
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
>> +  - compatible : should be one of the following:
>> +        Generic default - "cdns,qspi-nor".
>> +        For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
>> +        For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
>> +        For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
> The schema below says all this, so drop this part.
>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +        - enum:
>> +           - ti,k2g-qspi
>> +        - const: cdns,qspi-nor
>> +
>> +      - items:
>> +        - enum:
>> +           - ti,am654-ospi
>> +        - const: cdns,qspi-nor
>> +
>> +      - items:
>> +        - enum:
>> +           - intel,lgm-qspi
>> +        - const: cdns,qspi-nor
> These 3 items can be 1 entry (combine the enums).
Noted, will fix it.
>
>> +
>> +      - items:
>> +        - const: cdns,qspi-nor
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
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      128 or 256 bytes size of the data FIFO in words.
> Sounds like constraints. Make them a schema.
Sure, will make as schema.
>> +
>> +  cdns,fifo-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      4 byte bus width of the data FIFO in bytes.
> That's not very clear. It should be schema constraints anyways:
>
> enum: [ 4, 8, 12, 16, ...??? ]
>
> or:
>
> multipleOf: 4
> minimum: 4
> maximum: ?
Noted,  will fix it.
>> +
>> +  cdns,trigger-address:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      32-bit indirect AHB trigger address.
>> +
>> +  cdns,rclk-en:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> Wrong type if this is a 'flag' aka boolean.
Yes , you are correct.
>> +    description: |
>> +      Flag to indicate that QSPI return clock is used to latch the read data
>> +      rather than the QSPI clock. Make sure that QSPI return clock is populated
>> +      on the board before using this property.
>> +
>> +# subnode's properties
>> +patternProperties:
>> +  "^.*@[0-9a-fA-F]+$":
>> +    type: object
>> +    description:
>> +      flash device uses the subnodes below defined properties.
>> +
>> +  cdns,read-delay:
>> +    description:
>> +      Delay in 4 microseconds, read capture logic, in clock cycles.
> Huh? Is it in time or clocks?
>
> No unit suffix here, so this needs a type ref. That's what 'make
> dt_binding_check' fails on.
it's clock cycles to adjustable delay,  read data delay between the 
Flash Device data outputs and the controller data inputs
>> +
>> +  cdns,tshsl-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, for the length that the master mode chip select
>> +      outputs are de-asserted between transactions.
> multipleOf: 50
>
> And so on for the rest.

Okay , Noted.

Regards
Vadivel
>> +
>> +  cdns,tsd2d-ns:
>> +    description: |
>> +      Delay in 50 nanoseconds, between one chip select being de-activated
>> +      and the activation of another.
>> +
>> +  cdns,tchsh-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between last bit of current transaction and
>> +      deasserting the device chip select (qspi_n_ss_out).
>> +
>> +  cdns,tslch-ns:
>> +    description: |
>> +      Delay in 4 nanoseconds, between setting qspi_n_ss_out low and
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
>> +    qspi: spi@ff705000 {
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
