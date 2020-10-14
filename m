Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6658728D7D0
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 03:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgJNBIb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 21:08:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbgJNBIb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 21:08:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC2001451D627FFCD02E;
        Wed, 14 Oct 2020 09:08:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 14 Oct 2020
 09:08:18 +0800
Subject: Re: [PATCH 1/6] dt-bindings: leds: choose correct color value of
 multi-led
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
 <20201013160845.1772-2-thunder.leizhen@huawei.com>
 <1565f22c-7be9-e771-7def-afbb28ec07a7@ti.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <82761c4f-6533-9b63-daa4-146a58816f5b@huawei.com>
Date:   Wed, 14 Oct 2020 09:08:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565f22c-7be9-e771-7def-afbb28ec07a7@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/14 0:17, Dan Murphy wrote:
> Zhen
> 
> On 10/13/20 11:08 AM, Zhen Lei wrote:
>> The color value of multi-led is fixed to "const: 8 #LED_COLOR_ID_MULTI",
>> which is required by leds-class-multicolor.yaml.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
>> index 58e974793a7976b..cd877e817ad1a1c 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
>> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
>> @@ -197,7 +197,7 @@ examples:
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>>                  reg = <0x2>;
>> -               color = <LED_COLOR_ID_RGB>;
>> +               color = <LED_COLOR_ID_MULTI>;
>>                  function = LED_FUNCTION_STANDBY;
>>                  linux,default-trigger = "heartbeat";
>>   
> 
> This is not correct.  ID_RGB is the correct variable here.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/commit/?h=for-next&id=3d93edc77515c6f51fa9bbbe2185e2ec32bad024
> 
> Correct fix is to update the leds-class-multicolor.yaml

OK

> 
> Dan
> 
> 
> .
> 

