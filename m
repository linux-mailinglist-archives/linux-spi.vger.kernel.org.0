Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4145A28EE0B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgJOH7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 03:59:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729992AbgJOH7h (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 03:59:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D7AB1CCEAD4900AD1C6;
        Thu, 15 Oct 2020 15:59:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 15:59:30 +0800
Subject: Re: [PATCH v2 1/1] dt-bindings: misc: add support for both property
 names cmd-gpios and cmd-gpio
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
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
References: <20201015044443.1828-1-thunder.leizhen@huawei.com>
 <20201015044443.1828-2-thunder.leizhen@huawei.com>
 <CAMuHMdX6qLJbk=ik1CoqbycrLSr+vMwzpY6esnKRpXsTxaiSAw@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5df45c92-9a2c-82d4-491a-ec869f347665@huawei.com>
Date:   Thu, 15 Oct 2020 15:59:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX6qLJbk=ik1CoqbycrLSr+vMwzpY6esnKRpXsTxaiSAw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2020/10/15 15:01, Geert Uytterhoeven wrote:
> Hi Zhen,
> 
> Thanks for your patch!
> 
> On Thu, Oct 15, 2020 at 6:52 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>> The definition "gpio_suffixes[] = { "gpios", "gpio" }" shows that both
>> property names "cmd-gpios" and "cmd-gpio" are supported. But currently
>> only "cmd-gpios" is allowed in this yaml, and the name used in
>> mmp2-olpc-xo-1-75.dts is cmd-gpio. As a result, the following errors is
>> reported.
>>
>> slave: 'cmd-gpios' is a required property
>> slave: 'cmd-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> index b3c45c046ba5e37..dd549380a085709 100644
>> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
>> @@ -24,15 +24,21 @@ properties:
>>    compatible:
>>      const: olpc,xo1.75-ec
>>
>> -  cmd-gpios:
>> +  spi-cpha: true
>> +
>> +patternProperties:
>> +  "^cmd-gpio[s]?$":
>>      description: GPIO uspecifier of the CMD pin
>>      maxItems: 1
> 
> In general, the *-gpio form is deprecated.  So why complicate the DT
> bindings by adding support for deprecated properties?

I just don't know this information. So this patch can be ignored.

> 
>   1. Explicitly allowing deprecated properties means new users may be
>      added,
>   2. Once all in-tree DTS files are converted, the warnings will be gone
>      anyway,
>   3. Out-of-tree DTB will still work, as it's very unlikely support for
>      the "gpio" suffix can/will be dropped anytime soon,
>   4. If anyone runs the validator on out-of-tree DTS files, the most
>      probable intention is to fix any detected issues anyway, and the
>      files can be updated, too,
>   5. If any out-of-tree code or tooling relies on the *-gpio form, it
>      may already be broken.
> 
>> -  spi-cpha: true
>> -
>>  required:
>>    - compatible
>> -  - cmd-gpios
>> +
>> +oneOf:
>> +  - required:
>> +      - cmd-gpio
>> +  - required:
>> +      - cmd-gpios
>>
>>  additionalProperties: false
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

