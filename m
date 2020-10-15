Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86128EB7A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 05:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgJODXh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 23:23:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgJODXh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Oct 2020 23:23:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3230BD2B7BC282DF4284;
        Thu, 15 Oct 2020 11:23:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 11:23:29 +0800
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
To:     Rob Herring <robh@kernel.org>
CC:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
 <4f5f9b55-9fad-9318-82d4-6b258643738b@huawei.com>
 <20201014135019.GA1563910@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <49b680f8-d7d7-8ea3-894c-73cbfacc5ba4@huawei.com>
Date:   Thu, 15 Oct 2020 11:23:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201014135019.GA1563910@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/14 21:50, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 09:29:26AM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2020/10/14 1:32, Dan Murphy wrote:
>>> Zhen
>>>
>>> On 10/13/20 11:08 AM, Zhen Lei wrote:
>>>> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
>>>> cmd-gpio.
>>>>
>>>> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
>>>> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>>>> index b3c45c046ba5e37..c7a06a9650db2ed 100644
>>>> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>>>> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>>>> @@ -24,7 +24,7 @@ properties:
>>>>     compatible:
>>>>       const: olpc,xo1.75-ec
>>>>   -  cmd-gpios:
>>>> +  cmd-gpio:
>>>
>>> Preference is gpios not gpio. But Rob H accept or reject
>>
>> Look at the search result below. It seems that the driver have not been merged into mainline.
> 
> Yes, in drivers/platform/olpc/olpc-xo175-ec.c.
> 
> Your mistake is the gpiod api takes just 'cmd' as the GPIO core handles 
> both forms.

OK, thanks for your information. I have found that it defined by gpio_suffixes[].

> 
>> But the property name is really used as cmd-gpio at mmp2-olpc-xo-1-75.dts:235, I don't think
>> the mmp2-olpc-xo-1-75.dts can make a mistake. Otherwise, the driver will not work properly.
>> Meanwhile, Both names cmd-gpios and cmd-gpio seem to be in use. But I prefer cmd-gpio, after
>> all, only one gpio is assigned now. The motorola,cmd-gpios add "s" because it contains 3 gpio.
> 
> The preference is it is always '-gpios' just like it's always 
> 'interrupts' or 'clocks'.
> 
> However, whether to change this is really up to the OLPC folks. Given 
> the driver has always supported both forms, it should be okay to change 
> the dts. Though there could be other users besides the kernel.

If both "cmd-gpios" and "cmd-gpio" are supported, should we use enum to list both
of them in yaml? or use patternProperties?

I'm going to send v2 based on this idea.

> 
> Rob
> 
> .
> 

