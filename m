Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9E28D7F4
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 03:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgJNB3g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 21:29:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbgJNB3f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 21:29:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 89C074C22A09E86D6D3C;
        Wed, 14 Oct 2020 09:29:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 14 Oct 2020
 09:29:27 +0800
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
To:     Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-7-thunder.leizhen@huawei.com>
 <bda5f620-7140-51fb-fadd-6ebd3c0db935@ti.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4f5f9b55-9fad-9318-82d4-6b258643738b@huawei.com>
Date:   Wed, 14 Oct 2020 09:29:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bda5f620-7140-51fb-fadd-6ebd3c0db935@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/14 1:32, Dan Murphy wrote:
> Zhen
> 
> On 10/13/20 11:08 AM, Zhen Lei wrote:
>> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
>> cmd-gpio.
>>
>> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
>> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> index b3c45c046ba5e37..c7a06a9650db2ed 100644
>> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> @@ -24,7 +24,7 @@ properties:
>>     compatible:
>>       const: olpc,xo1.75-ec
>>   -  cmd-gpios:
>> +  cmd-gpio:
> 
> Preference is gpios not gpio. But Rob H accept or reject

Look at the search result below. It seems that the driver have not been merged into mainline.
But the property name is really used as cmd-gpio at mmp2-olpc-xo-1-75.dts:235, I don't think
the mmp2-olpc-xo-1-75.dts can make a mistake. Otherwise, the driver will not work properly.
Meanwhile, Both names cmd-gpios and cmd-gpio seem to be in use. But I prefer cmd-gpio, after
all, only one gpio is assigned now. The motorola,cmd-gpios add "s" because it contains 3 gpio.

Without this patch:
git grep -wn "cmd-gpios"
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml:27:  cmd-gpios:
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml:35:  - cmd-gpios
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml:52:        cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt:10:- motorola,cmd-gpios      Three GPIOs to control the power state of the MDM6600
Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt:22:  motorola,cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,
arch/arm/boot/dts/motorola-mapphone-common.dtsi:78:         motorola,cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,

git grep -wn "cmd-gpio"
Documentation/devicetree/bindings/leds/leds-ns2.txt:9:- cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
Documentation/devicetree/bindings/leds/leds-ns2.txt:12:  the corresponding cmd-gpio/slow-gpio values. All the GPIO values combinations
Documentation/devicetree/bindings/leds/leds-ns2.txt:29:             cmd-gpio = <&gpio0 30 0>;
arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts:90:                       cmd-gpio = <&pca9554 1 GPIO_ACTIVE_HIGH>;
arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts:100:                      cmd-gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
arch/arm/boot/dts/kirkwood-d2net.dts:29:                    cmd-gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
arch/arm/boot/dts/kirkwood-is2.dts:31:                      cmd-gpio = <&gpio0 30 0>;
arch/arm/boot/dts/kirkwood-ns2.dts:31:                      cmd-gpio = <&gpio0 30 0>;
arch/arm/boot/dts/kirkwood-ns2max.dts:50:                   cmd-gpio = <&gpio0 30 0>;
arch/arm/boot/dts/kirkwood-ns2mini.dts:51:                  cmd-gpio = <&gpio0 30 0>;
arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:                cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;

> 
> Dan
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

