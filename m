Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225112A2489
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 06:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgKBF7s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 00:59:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:64189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgKBF7s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 00:59:48 -0500
IronPort-SDR: NLiUv86qaQu/1V9ddf19rxoULnSWF5zqfPah1Y8QaYJXv9Kqk+H6cdEU6i7lveWwzglBSJ19Bi
 yxJie2BtvTBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="166248192"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="166248192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 21:59:47 -0800
IronPort-SDR: W0TteDyg7ISdJG3H+XzyGENQBOpqHZr1lfvKhAbM+N3B9AU/F+j6dvrrfaWOGBoUdlZji4kGXd
 rtCtPXAXxGYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="537888254"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2020 21:59:47 -0800
Received: from [10.226.38.24] (vramuthx-MOBL1.gar.corp.intel.com [10.226.38.24])
        by linux.intel.com (Postfix) with ESMTP id AD4385807AA;
        Sun,  1 Nov 2020 21:59:43 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v6 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-6-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030151837.GA3854035@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <a49505e9-500a-1c88-b5b5-1f6ea5e94c86@linux.intel.com>
Date:   Mon, 2 Nov 2020 13:59:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201030151837.GA3854035@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

Thank you for the review comments...

On 30/10/2020 11:18 pm, Rob Herring wrote:
> On Fri, Oct 30, 2020 at 01:31:52PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
>> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ---------
>>   .../devicetree/bindings/spi/cadence-quadspi.yaml   | 149 +++++++++++++++++++++
>>   2 files changed, 149 insertions(+), 67 deletions(-)
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
>> index 000000000000..ec22b040d804
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>> @@ -0,0 +1,149 @@
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
> 
> You don't need 'oneOf' if there is only one entry...
> 
> So you've dropped 'cdns,qspi-nor' alone being valid. Granted, the txt
> file was fuzzy as to whether or not that was valid. So you have to look
> at all the dts files and see. I prefer we don't allow that and require a
> more specific compatible, but if there's a bunch then we should allow
> for it. The commit message should summarize what you decide.
we need bunch of compatibles as below, TI, Altera and Intel uses 
different compatible's so we added 'oneOf'.

cdns,qspi-nor can be dropped instead I can add cadence,qspi ,because 
this driver suuports qspi-nor and qspi-nand as well.

Sure, let me go through other documentation files for reference.

> 
>> +          - enum:
>> +              - ti,k2g-qspi
>> +              - ti,am654-ospi
>> +          - const: cdns,qspi-nor
> 
>> +examples:
>> +  - |
>> +    qspi: spi@ff705000 {
>> +      compatible = "cadence,qspi","cdns,qpsi-nor";
> 
> And you missed fixing this.
Yes, fixed by "cadence,qspi" keeping alone, need to remove 
cdns,qspi-nor, thanks!

Regards
Vadivel

> 
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
