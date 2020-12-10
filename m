Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AAD2D6484
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392808AbgLJSIM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 13:08:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19556 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392547AbgLJSIG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 13:08:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd263da0000>; Thu, 10 Dec 2020 10:07:22 -0800
Received: from [10.2.90.244] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 18:07:21 +0000
Subject: Re: [PATCH v1 2/7] dt-bindings: spi: Add Tegra QSPI device tree
 binding
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-3-git-send-email-skomatineni@nvidia.com>
 <20201209172643.GA638607@robh.at.kernel.org>
 <1a9f0391-321d-2463-827b-284bba38e07d@nvidia.com>
Message-ID: <061c6770-860a-8b5b-7d14-32745a630922@nvidia.com>
Date:   Thu, 10 Dec 2020 10:08:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1a9f0391-321d-2463-827b-284bba38e07d@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607623642; bh=mQCndjBdMDE2zRyHrOPCBno3Q9FtrmzY5DN+TW0E3OE=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=iMuzQzBYFg7V9xtZEOU5XFuckw8QYJBPm9VwWp1T8xEAWlTQtpDkz+5jfM5BVKGCz
         PSzh+6wk8GkMjAMbRE1iIbUcghnVGyKTw0j758WSubQZRNwsy7YiJF4Rq8wQjwHbUQ
         3qn3pbJX+jSsq0kZjJmKWXLQU07FqhX3jzhGV4B7wvoxb13Mh4DVLv5dp7MPVl/DCn
         r+YQpvdicoM9QyFRpmcjkQV1rhx/nlcR3k4xKPguYgiTMF/yuLuNL5zzeDIfQ5Iftq
         fsJGDzqt5jeD2Xq9CrJoaTf98e41s4h3176iJWh4uK1oefBtHMAjRUEzs5KeWBtCw3
         /rkhYgDbxvO4Q==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/9/20 12:28 PM, Sowjanya Komatineni wrote:
>
> On 12/9/20 9:26 AM, Rob Herring wrote:
>> On Tue, Dec 01, 2020 at 01:12:43PM -0800, Sowjanya Komatineni wrote:
>>> This patch adds YAML based device tree binding document for Tegra
>>> QSPI driver.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>> =C2=A0 .../devicetree/bindings/spi/nvidia,tegra-qspi.yaml | 77=20
>>> ++++++++++++++++++++++
>>> =C2=A0 1 file changed, 77 insertions(+)
>>> =C2=A0 create mode 100644=20
>>> Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
>>>
>>> diff --git=20
>>> a/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml=20
>>> b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
>>> new file mode 100644
>>> index 0000000..038a085
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
>>> @@ -0,0 +1,77 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/nvidia,tegra-qspi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Tegra Quad SPI Controller
>>> +
>>> +maintainers:
>>> +=C2=A0 - Thierry Reding <thierry.reding@gmail.com>
>>> +=C2=A0 - Jonathan Hunter <jonathanh@nvidia.com>
>>> +
>>> +properties:
>>> +=C2=A0 compatible:
>>> +=C2=A0=C2=A0=C2=A0 enum:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nvidia,tegra210-qspi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nvidia,tegra186-qspi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - nvidia,tegra194-qspi
>>> +
>>> +=C2=A0 reg:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: QSPI registers
>> Just 'maxItems: 1'
>>
>>> +
>>> +=C2=A0 interrupts:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>> +
>>> +=C2=A0 clock-names:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: qspi
>> Kind of a pointless name.
> Thanks Rob for feedback. Do you mean to change name something like=20
> qspi-clk instead of qspi?

Rob, reason I added clock name is later when we add ddr mode we will=20
have additional clock.

So driver uses clock name to retrieve.

Will add both clocks to dt-binding doc in v2 although support for ddr=20
mode in qspi driver can be implemented later.

>>
>>> +
>>> +=C2=A0 clocks:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>> +
>>> +=C2=A0 reset-names:
>>> +=C2=A0=C2=A0=C2=A0 minItems: 1
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: qspi
>> Same here.
>>
>>> +
>>> +=C2=A0 resets:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 1
>>> +
>>> +=C2=A0 dmas:
>>> +=C2=A0=C2=A0=C2=A0 maxItems: 2
>>> +
>>> +=C2=A0 dma-names:
>>> +=C2=A0=C2=A0=C2=A0 items:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rx
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: tx
>>> +
>>> +required:
>>> +=C2=A0 - compatible
>>> +=C2=A0 - reg
>>> +=C2=A0 - interrupts
>>> +=C2=A0 - clock-names
>>> +=C2=A0 - clocks
>>> +=C2=A0 - reset-names
>>> +=C2=A0 - resets
>>> +
>>> +additionalProperties: true
>>> +
>>> +examples:
>>> +=C2=A0 - |
>>> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/clock/tegra210-car.h>
>>> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/reset/tegra210-car.h>
>>> +=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-controller/arm-gic.=
h>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 spi@70410000 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "nvidia,tegra210-qspi";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0x70410000 0x1000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=
errupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
cks =3D <&tegra_car TEGRA210_CLK_QSPI>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clo=
ck-names =3D "qspi";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
ets =3D <&tegra_car 211>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
et-names =3D "qspi";
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma=
s =3D <&apbdma 5>, <&apbdma 5>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma=
-names =3D "rx", "tx";
>>> +=C2=A0=C2=A0=C2=A0 };
>>> --=20
>>> 2.7.4
>>>
