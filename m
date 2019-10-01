Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED76C2B93
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 03:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJABNR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Sep 2019 21:13:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:64309 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfJABNR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 30 Sep 2019 21:13:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 18:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,569,1559545200"; 
   d="scan'208";a="191307813"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2019 18:13:16 -0700
Received: from [10.226.38.18] (unknown [10.226.38.18])
        by linux.intel.com (Postfix) with ESMTP id 927655803E4;
        Mon, 30 Sep 2019 18:13:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: Add support for cadence-qspi IP
 Intel LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190930223640.GA18491@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <e70c6f98-7e0f-97f2-bede-00de4389f825@linux.intel.com>
Date:   Tue, 1 Oct 2019 09:13:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930223640.GA18491@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

    Thank you for the review comments.

On 1/10/2019 6:36 AM, Rob Herring wrote:
> On Mon, Sep 16, 2019 at 03:38:42PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> On Intel Lightening Mountain(LGM) SoCs QSPI controller support
>> to QSPI-NAND flash. This introduces to device tree binding
>> documentation for Cadence-QSPI controller and spi-nand flash.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/spi/cadence,qspi-nand.yaml | 84 ++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>> new file mode 100644
>> index 000000000000..9aae4c1459cc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/spi/cadence,qspi-nand.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Cadence QSPI Flash Controller on Intel's SoC
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +description: |
>> +  The Cadence QSPI is a controller optimized for communication with SPI
>> +  FLASH memories, without DMA support on Intel's SoC.
>> +
>> +properties:
>> +  compatible:
>> +    const: cadence,lgm-qspi
> Vendor here should be 'intel'. Perhaps the binding should be shared too
> like the driver.
>
> Plus the vendor prefix for Cadence is cdns.
Agreed!, will update.
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  fifo-depth:
>> +    maxItems: 1
>> +
> This is vendor specific, so needs a vendor prefix, type, and
> description.
agreed!
>> +  fifo-width:
>> +    maxItems: 1
> Same
>
>> +
>> +  qspi-phyaddr:
>> +    maxItems: 1
> Same
>
>> +
>> +  qspi-phymask:
>> +    maxItems: 1
> Same
will update all the above.
>> +
>> +  clocks:
>> +    maxItems: 2
> Need to define what each clock is when there is more than 1.
Sure, will update.
>> +
>> +  clocks-names:
>> +    maxItems: 2
> Need to define the strings.
Noted, will update.
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - fifo-depth
>> +  - fifo-width
>> +  - qspi-phyaddr
>> +  - qspi-phymask
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +
>> +examples:
>> +  - |
>> +    qspi@ec000000 {
> spi@...

Controller is qspi , so that have updated.

With Best Regards
Vadivel Murugan R
>> +          compatible = "cadence,qspi-nand";
>> +          reg = <0xec000000 0x100>;
>> +          fifo-depth = <128>;
>> +          fifo-width = <4>;
>> +          qspi-phyaddr = <0xf4000000>;
>> +          qspi-phymask = <0xffffffff>;
>> +          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
>> +          clock-names = "freq", "qspi";
>> +          resets = <&rcu0 0x10 1>;
>> +          reset-names = "qspi";
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          flash: flash@1 {
>> +              compatible = "spi-nand";
>> +              reg = <1>;
>> +              spi-max-frequency = <10000000>;
>> +          };
>> +    };
>> +
>> -- 
>> 2.11.0
>>
