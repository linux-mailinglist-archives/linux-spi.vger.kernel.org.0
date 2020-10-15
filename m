Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3728EDC9
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgJOHdU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 03:33:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgJOHdU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 03:33:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6F4CD129FA1D36E22D9;
        Thu, 15 Oct 2020 15:33:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 15:32:59 +0800
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
To:     Lubomir Rintel <lkundrak@v3.sk>
CC:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Benson Leung" <bleung@chromium.org>,
        linux-leds <linux-leds@vger.kernel.org>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-7-thunder.leizhen@huawei.com>
 <20201015071256.GA1092695@demiurge.local>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <78daaeae-dc13-91ca-a33e-6fcba5f7f3d5@huawei.com>
Date:   Thu, 15 Oct 2020 15:32:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201015071256.GA1092695@demiurge.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/15 15:12, Lubomir Rintel wrote:
> Hi,
> 
> On Wed, Oct 14, 2020 at 12:08:45AM +0800, Zhen Lei wrote:
>> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
>> cmd-gpio.
>>
>> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
>> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Thanks for the patch.
> 
> I've sent out an equivalent one some time ago:
> https://lore.kernel.org/lkml/20200925234805.228251-3-lkundrak@v3.sk/
> 
> In any case, either is fine with me.

Geert Uytterhoeven just replied me that the *-gpio form is deprecated. So your
patch is the correct one.

> 
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>
> 
>> ---
>>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> index b3c45c046ba5e37..c7a06a9650db2ed 100644
>> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> @@ -24,7 +24,7 @@ properties:
>>    compatible:
>>      const: olpc,xo1.75-ec
>>  
>> -  cmd-gpios:
>> +  cmd-gpio:
>>      description: GPIO uspecifier of the CMD pin
>>      maxItems: 1
>>  
>> @@ -32,7 +32,7 @@ properties:
>>  
>>  required:
>>    - compatible
>> -  - cmd-gpios
>> +  - cmd-gpio
>>  
>>  additionalProperties: false
>>  
>> @@ -49,7 +49,7 @@ examples:
>>        slave {
>>          compatible = "olpc,xo1.75-ec";
>>          spi-cpha;
>> -        cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
>> +        cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
>>        };
>>      };
>>  
>> -- 
>> 1.8.3
>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 

