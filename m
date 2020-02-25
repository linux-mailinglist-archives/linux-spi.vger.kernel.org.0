Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0D16B9AB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 07:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgBYGYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 01:24:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:52909 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbgBYGYO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Feb 2020 01:24:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 22:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="384372054"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 24 Feb 2020 22:24:11 -0800
Received: from [10.226.38.25] (unknown [10.226.38.25])
        by linux.intel.com (Postfix) with ESMTP id 78FC158052E;
        Mon, 24 Feb 2020 22:24:08 -0800 (PST)
Subject: Re: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        simon.k.r.goldschmidt@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        tien.fong.chee@intel.com,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <64b7ab12-0c11-df25-95e7-ee62227ec7ec@linux.intel.com>
Date:   Tue, 25 Feb 2020 14:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKJky=y4nhECUFVzTYvEpjFoOH_6UY9uZG5bvBVWq=SYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

      Thank you for the review comments...

On 24/2/2020 11:54 PM, Rob Herring wrote:
> On Tue, Feb 18, 2020 at 8:29 PM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Cc the DT list if you want this reviewed.
Sorry,  next patch will add DT list in CC.
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> new file mode 100644
>> index 000000000000..1a4d6e8d0d0b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -0,0 +1,147 @@
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
>> +      Size of the data FIFO in words.
> A 4GB fifo is valid? Add some constraints.
128 is valid, will update.
>> +
>> +  cdns,fifo-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Bus width of the data FIFO in bytes.
> Add some constraints.
4 is valid , will fix it.
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
>> +
>> +# subnode's properties
>> +patternProperties:
>> +  "^.*@[0-9a-fA-F]+$":
>> +    type: object
>> +    description:
>> +      flash device uses the subnodes below defined properties.
>> +
>> +  cdns,read-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Delay for read capture logic, in clock cycles.
> 4 billion clock delay is valid?
based on the ref_clk , will add it.
>> +
>> +  cdns,tshsl-ns:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> You can drop this, anything with a standard unit suffix already has a type.
sure , will drop it.
>> +    description: |
>> +      Delay in nanoseconds for the length that the master mode chip select
>> +      outputs are de-asserted between transactions.
> Constraints...?

50ns, will add it.

Regards
Vadivel
>> +
>> +  cdns,tsd2d-ns:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Delay in nanoseconds between one chip select being de-activated
>> +      and the activation of another.
>> +
>> +  cdns,tchsh-ns:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Delay in nanoseconds between last bit of current transaction and
>> +      deasserting the device chip select (qspi_n_ss_out).
>> +
>> +  cdns,tslch-ns:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
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
