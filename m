Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085D61F3814
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFIK1v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 06:27:51 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9342 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFIK1u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jun 2020 06:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591698469; x=1623234469;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=PFE08cVYhQUpY5zaFOQ/GJEuFcqAMgONaAxufYheBDA=;
  b=DKFFVbx8/uSfMBNZ8zf2+vjclxh3upRqHBM2gVZBJHgbaDIvziTHtNiH
   LEI9EwKPU2dTr6tszSNQOrNOADhWT7QVAuggFNiq1qcWH6Jcpz4EP3d1K
   aYuUsT2uy/k1duGr4wHfactdCoXIQICnWgIt6ZzumkcBnI10/3P7reAAz
   pvfi+8iFMDYFTn8YL+waDyqEbf/gkm8q9CYjEiVTVENEBpjA0bjA1PPyG
   ZPLetN+59kbt2k6fRwk5wWmwrClAReGVrXmZnTdJWZ3SsQatH6rOFxf//
   8WCXPbiUwD+mB5Fr7DoecVFt53eEHzfQN+rRxrsXYK0KSSl9KL5Ki2NPU
   Q==;
IronPort-SDR: DvBSgCKDbJXDL0IpdE3lYQtMLoRVAuznXxSpGbvfLg8x6HIPEduN5SM1VV00Ua71tASeuVdMLA
 revxWCd3KL115Zfb0tHJwI1qVdIb5VAxn2zPdFvbOQfwyyItP+MJuGObwaiwXAZqA5xbO/YEMq
 kW20geL10MMNERGdm15KCxtrfFKMYYxba2pKsYohZSKIgfqRIIClQS3oHqHfExPwyt6tuTAqvr
 qO+a2MQpDv0dzAIfRNQpc5tUDVomRdNALzMDo0PYrwfsFFOIoCMQ/yUdGuSbtGBn/cUKA9nu1w
 8SU=
X-IronPort-AV: E=Sophos;i="5.73,491,1583218800"; 
   d="scan'208";a="82797722"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 03:27:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 03:27:48 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 03:27:45 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-5-lars.povlsen@microchip.com> <20200602194925.qbevttzz3ghvmd2d@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 04/10] dt-bindings: spi: Add bindings for spi-dw-mchp
In-Reply-To: <20200602194925.qbevttzz3ghvmd2d@mobilestation>
Date:   Tue, 9 Jun 2020 12:27:44 +0200
Message-ID: <87img0ilen.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> On Wed, May 13, 2020 at 04:00:25PM +0200, Lars Povlsen wrote:
>> This add DT bindings for the Microsemi/Microchip SPI controller used
>> in various SoC's. It describes the "mscc,ocelot-spi" and
>> "mscc,jaguar2-spi" bindings.
>
> As I see it, there is no need in this patch at all. Current DT binding file
> describes the MSCC version of the DW APB SSI IP pretty well. You can add an
> example to the DT schema though with "mscc,ocelot-spi" or "mscc,jaguar2-spi"
> compatible string and additional registers range.
>

Fine by me. I just had the understanding that a YAML binding had to be
given for a new driver.

I will add the bindings to the existing YAML with proper guards.

---Lars

> -Sergey
>
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  .../bindings/spi/mscc,ocelot-spi.yaml         | 60 +++++++++++++++++++
>>  .../bindings/spi/snps,dw-apb-ssi.txt          |  7 +--
>>  MAINTAINERS                                   |  1 +
>>  3 files changed, 63 insertions(+), 5 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>> new file mode 100644
>> index 0000000000000..a3ac0fa576553
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/spi/mscc,ocelot-spi.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Microsemi Vcore-III SPI Communication Controller
>> +
>> +maintainers:
>> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
>> +  - Lars Povlsen <lars.povlsen@microchip.com>
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +description: |
>> +  The Microsemi Vcore-III SPI controller is a general purpose SPI
>> +  controller based upon the Designware SPI controller. It uses an 8
>> +  byte rx/tx fifo.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mscc,ocelot-spi
>> +      - mscc,jaguar2-spi
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reg:
>> +    minItems: 2
>> +    items:
>> +      - description: Designware SPI registers
>> +      - description: CS override registers
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  reg-io-width:
>> +    description: |
>> +      The I/O register width (in bytes) implemented by this device.
>> +    items:
>> +       enum: [ 2, 4 ]
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +examples:
>> +  - |
>> +    spi0: spi@101000 {
>> +      compatible = "mscc,ocelot-spi";
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      reg = <0x101000 0x100>, <0x3c 0x18>;
>> +      interrupts = <9>;
>> +      clocks = <&ahb_clk>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>> index 3ed08ee9feba4..5e1849be7bae5 100644
>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
>> @@ -1,10 +1,8 @@
>>  Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
>>
>>  Required properties:
>> -- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
>> -  "jaguar2", or "amazon,alpine-dw-apb-ssi"
>> -- reg : The register base for the controller. For "mscc,<soc>-spi", a second
>> -  register set is required (named ICPU_CFG:SPI_MST)
>> +- compatible : "snps,dw-apb-ssi" or "amazon,alpine-dw-apb-ssi"
>> +- reg : The register base for the controller.
>>  - interrupts : One interrupt, used by the controller.
>>  - #address-cells : <1>, as required by generic SPI binding.
>>  - #size-cells : <0>, also as required by generic SPI binding.
>> @@ -38,4 +36,3 @@ Example:
>>               cs-gpios = <&gpio0 13 0>,
>>                          <&gpio0 14 0>;
>>       };
>> -
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1db598723a1d8..6472240b8391b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11231,6 +11231,7 @@ L:    linux-mips@vger.kernel.org
>>  S:   Supported
>>  F:   Documentation/devicetree/bindings/mips/mscc.txt
>>  F:   Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
>> +F:   Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
>>  F:   arch/mips/boot/dts/mscc/
>>  F:   arch/mips/configs/generic/board-ocelot.config
>>  F:   arch/mips/generic/board-ocelot.c
>> --
>> 2.26.2
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lars Povlsen,
Microchip
