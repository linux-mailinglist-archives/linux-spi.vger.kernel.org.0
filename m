Return-Path: <linux-spi+bounces-6586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089B3A22A02
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 10:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7814E7A1ED0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EA91B4152;
	Thu, 30 Jan 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RWUeJQA6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3125634;
	Thu, 30 Jan 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227744; cv=none; b=rJ16Q/cmgeCVovfN9xd6AbbCXDyGkNmUpCruWnCKukmzDvo5Lhq86DRGj+xWXz9cLztGggo+VIXVI5iI5kBIZXJaZbZddDHHG2fMo/9pAfJuSO8HBwPocN+huKXW91qKYatJgKn+g3P8tuEYevBUIrkHP5wWQPLGYxeQ+kbJ0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227744; c=relaxed/simple;
	bh=cwbL8UiNeVw38LworTppXYP09m57JaPOsaWXGjJ1KzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B+W9FZES55uY11RpqrY2fKYPWHSu3WcbE8aaH1uZfllto4CwOQoAjwAHwTeSZsOMc5qHtSJXzl6h5vzr0IsyxfiNYOPOgyMHDtIFcQZGOBjO/PfQGrffYo0+hrkF+HoOmZsNyRVVuAgb0Tl6wyKAdmEQR/OGOsFObtT5bj0IZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RWUeJQA6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U6QfTO000797;
	Thu, 30 Jan 2025 10:02:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9Fc7EkJjccFhCTeiXlxmIiZqzpO4YNCNmEt6HgwoRsk=; b=RWUeJQA6UeabuBp8
	jMwzHatYEqzy/OUfiE/ibfYTQpydvhNsyPf0MfJtY3ETxX15rWx2yHCRu52p3QXU
	drIFpR1U7pjNkVjgZ0UT4JEL9yol0y7G66FFmqhDmibd/8kHePeUTL2CRLekB7Xw
	1PkS1/DNGiY1XHM2RkHZ8yoYDZBA1P3v7WV1HLLZVoR8utcmDriW1+nEevCKp+fe
	bKrtwrfo48CtK83Med0KoP1r40SVMMnLojuYdkNY/VHuyyjgi/2m2QDG7Ap2pHVi
	Elew6l1sOhS6qloZly7ALDpKmpRaV5Lm8KgP4KdUhBw8DXsr1FOvsyIf3HvqPlnl
	hQbI9g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44fkr2kj4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:01:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ACDB140044;
	Thu, 30 Jan 2025 10:00:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6FFA92D97FA;
	Thu, 30 Jan 2025 09:57:31 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 30 Jan
 2025 09:57:30 +0100
Message-ID: <3660580d-72eb-45ca-8240-55557e334e37@foss.st.com>
Date: Thu, 30 Jan 2025 09:57:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] dt-bindings: memory-controllers: Add STM32 Octo
 Memory Manager controller
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-4-patrice.chotard@foss.st.com>
 <20250129-hilarious-glittering-mustang-fb5471@krzk-bin>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250129-hilarious-glittering-mustang-fb5471@krzk-bin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_05,2025-01-29_01,2024-11-22_01



On 1/29/25 08:52, Krzysztof Kozlowski wrote:
> On Tue, Jan 28, 2025 at 09:17:25AM +0100, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Add bindings for STM32 Octo Memory Manager (OMM) controller.
>>
>> OMM manages:
>>   - the muxing between 2 OSPI busses and 2 output ports.
>>     There are 4 possible muxing configurations:
>>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>>         output is on port 2
>>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>>         OSPI2 output is on port 1
>>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>>   - the split of the memory area shared between the 2 OSPI instances.
>>   - chip select selection override.
>>   - the time between 2 transactions in multiplexed mode.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  .../memory-controllers/st,stm32-omm.yaml      | 190 ++++++++++++++++++
>>  1 file changed, 190 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
>> new file mode 100644
>> index 000000000000..7e0b150e0005
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
> 
> 
> Filename as compatible, so st,stm32mp25-omm.yaml
> 
> You already received this comment.

Sorry, i missed this update

> 
>> @@ -0,0 +1,190 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/st,stm32-omm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STM32 Octo Memory Manager (OMM)
>> +
>> +maintainers:
>> +  - Patrice Chotard <patrice.chotard@foss.st.com>
>> +
>> +description: |
>> +  The STM32 Octo Memory Manager is a low-level interface that enables an
>> +  efficient OCTOSPI pin assignment with a full I/O matrix (before alternate
>> +  function map) and multiplex of single/dual/quad/octal 		SPI interfaces over
>> +  the same bus. It Supports up to:
>> +    - Two single/dual/quad/octal SPI interfaces
>> +    - Two ports for pin assignment
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-omm
>> +
>> +  "#address-cells":
>> +    const: 2
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges:
>> +    description: |
>> +      Reflects the memory layout with four integer values per OSPI instance.
>> +      Format:
>> +      <chip-select> 0 <registers base address> <size>
> 
> Do you always have two children? If so, this should have maxItems.

No, we can have one child.

> 
>> +
>> +  reg:
>> +    items:
>> +      - description: OMM registers
>> +      - description: OMM memory map area
>> +
>> +  reg-names:
>> +    items:
>> +      - const: regs
>> +      - const: memory_map
>> +
>> +  memory-region:
>> +    description: Phandle to node describing memory-map region to used.
>> +    minItems: 1
>> +    maxItems: 2
> 
> List the items with description instead with optional minItems. Why is
> this flexible in number of items?

If only one child (OCTOSPI instance), only one memory-region is needed.

Another update, i will reintroduce "memory-region-names:" which was 
wrongly removed in V2, i have forgotten one particular case.

We need memory-region-names in case only one OCTOSPI instance is 
used. If it's OCTOCPI2 and the whole memory-map region
is dedicated to OCTOSPI2 (OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)

We need to know to which OCTOSPI instance the memory region is associated
with, in order to check "st,syscfg-amcr" 's value which must be coherent 
with memory region declared.

so i will add :

  memory-region-names:
    description: |
      OCTOSPI instance's name to which memory region is associated
    items:
      - const: ospi1
      - const: ospi2

> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  access-controllers:
>> +    maxItems: 1
>> +
>> +  st,syscfg-amcr:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      The Address Mapping Control Register (AMCR) is used to split the 256MB
>> +      memory map area shared between the 2 OSPI instance. The Octo Memory
>> +      Manager sets the AMCR depending of the memory-region configuration.
>> +      Format is phandle to syscfg / register offset within syscfg / memory split
>> +      bitmask.
> 
> Don't repeat constraints in free form text.

ok

> 
>> +      The memory split bitmask description is:
>> +        - 000: OCTOSPI1 (256 Mbytes), OCTOSPI2 unmapped
>> +        - 001: OCTOSPI1 (192 Mbytes), OCTOSPI2 (64 Mbytes)
>> +        - 010: OCTOSPI1 (128 Mbytes), OCTOSPI2 (128 Mbytes)
>> +        - 011: OCTOSPI1 (64 Mbytes), OCTOSPI2 (192 Mbytes)
>> +        - 1xx: OCTOSPI1 unmapped, OCTOSPI2 (256 Mbytes)
>> +    items:
>> +      minItems: 3
>> +      maxItems: 3
> 
> You do not have there three phandles, but one. Look how other bindings
> encode this.

yes, i see, will update with 

    items:
      - description: phandle to syscfg
      - description: register offset within syscfg
      - description: register bitmask for memory split

> 
>> +
>> +  st,omm-req2ack-ns:
>> +    description: |
>> +      In multiplexed mode (MUXEN = 1), this field defines the time in
>> +      nanoseconds between two transactions.
>> +
>> +  st,omm-cssel-ovr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configure the chip select selector override for the 2 OCTOSPIs.
>> +      The 2 bits mask muxing description is:
> 
> bit mask of size? 1? Then just enum string, no?

I didn't get your point ? the size of bitmask is 2 bits as indicated.
    -bit 0: Chip select selector override setting for OCTOSPI1
    -bit 1: Chip select selector override setting for OCTOSPI2


> 
>> +        -bit 0: Chip select selector override setting for OCTOSPI1
>> +          0x0: the chip select signal from OCTOSPI1 is sent to NCS1
>> +          0x1: the chip select signal from OCTOSPI1 is sent to NCS2
>> +        -bit 1: Chip select selector override setting for OCTOSPI2
>> +          0x0: the chip select signal from OCTOSPI2 is sent to NCS1
>> +          0x1: the chip select signal from OCTOSPI2 is sent to NCS2
> 
> I don't understand why this is so complicated. First, can you even send
> chip select OCTOSPI1 to NCS2 and use 0x1 as mux? or 0x3 as mux?


By default, if st,omm-cssel-ovr property is not present:
  _ chip select OCTOSPI1 is send to NCS1
  _ chip select OCTOSPI2 is send to NCS2

It's the default configuration.

If st,omm-cssel-ovr property is present, you can mux the chip select 
of both OCTOSPI instance on NCS1 or NCS2 as you want.

Yes you can send chip select OCTOSPI1 to NCS2 by using 0x1 as bitmask mux
(in this case chip select OCTOSPI2 is sent to NCS1).

If you use 0x3 as bitmask mux, you send  :
   _ chip select OCTOSPI1 is sent to NCS2
   _ chip select OCTOSPI2 is sent to NCS2

> 
> Second, your bitmask value of "0x0" means OCTOSPI1 and OCTOSPI2 are sent

i think the 0x0/0x1 in the description brings to confusion as it's only the 
bit value not the bitmask.

> to NCS1 (whateveer NCS is). This sounds wrong, but your binding says is
> perfectly correct. Is that true? Is that correct binding?

 4 bitmask possible choice :
   0x0 : the chip select signal from OCTOSPI1 is sent to NCS1
	 the chip select signal from OCTOSPI2 is sent to NCS1

   0x1 : the chip select signal from OCTOSPI1 is sent to NCS2
	 the chip select signal from OCTOSPI2 is sent to NCS1

   0x2 : the chip select signal from OCTOSPI1 is sent to NCS1
	 the chip select signal from OCTOSPI2 is sent to NCS2

   0x3 : the chip select signal from OCTOSPI1 is sent to NCS2
	 the chip select signal from OCTOSPI2 is sent to NCS2


I propose to update the st,omm-cssel-ovr description as following

  st,omm-cssel-ovr:
    $ref: /schemas/types.yaml#/definitions/uint32
    description: |
      Configure the chip select selector override for the 2 OCTOSPIs.
        - 0: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS1
        - 1: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS1
        - 2: OCTOSPI1 chip select send to NCS1 OCTOSPI2 chip select send to NCS2
        - 3: OCTOSPI1 chip select send to NCS2 OCTOSPI2 chip select send to NCS2
    minimum: 0
    maximum: 3


> 
> 
>> +
>> +  st,omm-mux:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
>> +      The muxing 2 bits mask description is:
>> +        - 0x0: direct mode, default
>> +        - 0x1: mux OCTOSPI1 and OCTOSPI2 to port 1
>> +        - 0x2: swapped mode
>> +        - 0x3: mux OCTOSPI1 and OCTOSPI2 to port 2
> 
> So these are just 1-3, not hex, not bitmasks. Missing constraints or
> enum.


ok , i will update as following

  st,omm-mux:
    $ref: /schemas/types.yaml#/definitions/uint32
    description: |
      Configure the muxing between the 2 OCTOSPIs busses and the 2 output ports.
        - 0: direct mode, default
        - 1: mux OCTOSPI1 and OCTOSPI2 to port 1
        - 2: swapped mode
        - 3: mux OCTOSPI1 and OCTOSPI2 to port 2
    minimum: 0
    maximum: 3


> 
> 
> 
> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  ^spi@[a-f0-9]+$:
>> +    type: object
>> +    $ref: "/schemas/spi/st,stm32mp25-ospi.yaml#"
> 
> Not much improved. I think you got here comment to drop quotes. That's
> the second comment you ignored.

sorry, i missed this comment too

> 
>> +    description: Required spi child node
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - clocks
>> +  - st,syscfg-amcr
>> +  - ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
>> +    ommanager@40500000 {
>> +      compatible = "st,stm32mp25-omm";
>> +      reg = <0x40500000 0x400>, <0x60000000 0x10000000>;
>> +      reg-names = "regs", "memory_map";
>> +      memory-region = <&mm_ospi1>, <&mm_ospi2>;
>> +      pinctrl-names = "default", "sleep";
> 
> pinctrl-names after pinctrl-1

ok

> 
>> +      pinctrl-0 = <&ospi_port1_clk_pins_a
>> +                   &ospi_port1_io03_pins_a
>> +                   &ospi_port1_cs0_pins_a>;
>> +      pinctrl-1 = <&ospi_port1_clk_sleep_pins_a
>> +                   &ospi_port1_io03_sleep_pins_a
>> +                   &ospi_port1_cs0_sleep_pins_a>;
>> +      clocks = <&rcc CK_BUS_OSPIIOM>;
>> +      resets = <&rcc OSPIIOM_R>;
>> +      st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
>> +      st,omm-req2ack-ns = <0x0>;
> 
> Time is never expressed in hex, we do not follow 0x18h clock in
> continental Europe.

ok

> 
>> +      st,omm-mux = <0x0>;
>> +      st,omm-cssel-ovr = <0x0>;
>> +      access-controllers = <&rifsc 111>;
>> +      power-domains = <&CLUSTER_PD>;
>> +
>> +      #address-cells = <2>;
>> +      #size-cells = <1>;
>> +
>> +      ranges = <0 0 0x40430000 0x400>,
>> +               <1 0 0x40440000 0x400>;
> 
> ranges always go after reg/reg-names.

ok

> 
>> +
>> +      spi@40430000 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "st,stm32mp25-ospi";
> 
> Please follow DTS coding style in ordering your properties.
ok i will move address-cells and size-cells at the correct place.

Thanks 
Patrice

> 
> 
> 
> Best regards,
> Krzysztof
> 

