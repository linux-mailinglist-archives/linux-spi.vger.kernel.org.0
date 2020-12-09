Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA42D4BEE
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgLIU2k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 15:28:40 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4239 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgLIU2k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 15:28:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd133500001>; Wed, 09 Dec 2020 12:28:00 -0800
Received: from [10.2.90.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 20:27:59 +0000
Subject: Re: [PATCH v1 2/7] dt-bindings: spi: Add Tegra QSPI device tree
 binding
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-3-git-send-email-skomatineni@nvidia.com>
 <20201209172643.GA638607@robh.at.kernel.org>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <1a9f0391-321d-2463-827b-284bba38e07d@nvidia.com>
Date:   Wed, 9 Dec 2020 12:28:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209172643.GA638607@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607545680; bh=a+YYFPeNAX9ceupGi7mBDJuGY63SjjffyHHchHc5KX8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=hua9Xkyt6+aiMEOH4HBXf5O9Vzj41eAyftRgSv8h23S9VNLzYbbuJGRDFgu5AgdQX
         VTHR3xS6dby6Obx+AHJItteN5Smb+i2FQbJ+Xr/65Pb7F6zG8Jm1tNtefH2HLn9cQ5
         EzcNR3j23l0mttyWY7DdKVlbxQukTtgOXUanIuQtsjF4ReJtX9GwaKBsMhuYLo2Lga
         FoXaBb7c3+Uwqp/xfuTVxuapPJyh4NC5jdkfQAocs8CSK49yQ4nqMBUD4ESmu5FLYa
         zCL3YJxIUzhu0aAa3AJLLSVwrkLotacjz8R/jQ8jdiGHKKdItkomFdcSuXVjG0Qykx
         D9a8UI5P2THIA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/9/20 9:26 AM, Rob Herring wrote:
> On Tue, Dec 01, 2020 at 01:12:43PM -0800, Sowjanya Komatineni wrote:
>> This patch adds YAML based device tree binding document for Tegra
>> QSPI driver.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   .../devicetree/bindings/spi/nvidia,tegra-qspi.yaml | 77 ++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
>> new file mode 100644
>> index 0000000..038a085
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/nvidia,tegra-qspi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Tegra Quad SPI Controller
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jonathan Hunter <jonathanh@nvidia.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra210-qspi
>> +      - nvidia,tegra186-qspi
>> +      - nvidia,tegra194-qspi
>> +
>> +  reg:
>> +    items:
>> +      - description: QSPI registers
> Just 'maxItems: 1'
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: qspi
> Kind of a pointless name.
Thanks Rob for feedback. Do you mean to change name something like 
qspi-clk instead of qspi?
>
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    minItems: 1
>> +    items:
>> +      - const: qspi
> Same here.
>
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: rx
>> +      - const: tx
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clock-names
>> +  - clocks
>> +  - reset-names
>> +  - resets
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra210-car.h>
>> +    #include <dt-bindings/reset/tegra210-car.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    spi@70410000 {
>> +            compatible = "nvidia,tegra210-qspi";
>> +            reg = <0x70410000 0x1000>;
>> +            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&tegra_car TEGRA210_CLK_QSPI>;
>> +            clock-names = "qspi";
>> +            resets = <&tegra_car 211>;
>> +            reset-names = "qspi";
>> +            dmas = <&apbdma 5>, <&apbdma 5>;
>> +            dma-names = "rx", "tx";
>> +    };
>> -- 
>> 2.7.4
>>
