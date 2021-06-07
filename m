Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9719339D8F2
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFGJiN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 05:38:13 -0400
Received: from regular1.263xmail.com ([211.150.70.197]:39254 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhFGJiM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 05:38:12 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 30E301BBF;
        Mon,  7 Jun 2021 17:35:36 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.73] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31751T140094889510656S1623058535154905_;
        Mon, 07 Jun 2021 17:35:36 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <64b7a42d8996c14ab6b47535c6dccd2d>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v4 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126 and rk3568
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        broonie@kernel.org, Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210607063448.29589-1-jon.lin@rock-chips.com>
 <20210607063448.29589-2-jon.lin@rock-chips.com>
 <ef90ae6d-40bb-8389-f4f8-536a7b610fb7@gmail.com> <3681106.bcXerOTE6V@diego>
From:   Jon Lin <jon.lin@rock-chips.com>
Message-ID: <a38fc74e-809a-0823-2abe-bf6e05e1a5a3@rock-chips.com>
Date:   Mon, 7 Jun 2021 17:35:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3681106.bcXerOTE6V@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/7/21 5:04 PM, Heiko Stübner wrote:
> Am Montag, 7. Juni 2021, 10:15:30 CEST schrieb Johan Jonker:
>> Hi Jon,
>>
>> On 6/7/21 8:34 AM, Jon Lin wrote:
>>> The description below will be used for rv1126.dtsi or rk3568.dtsi in
>>> the future
>>>
>>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>>> ---
>>>
>>> Changes in v4:
>>> - Adjust the order patches
>>> - Simply commit massage like redundancy "application" content
>>>
>>> Changes in v3:
>>> - Fix compile error which is find by Sascha in [v2,2/8]
>>>
>>>   Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> index 1e6cf29e6388..2d7957f9ae0a 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>> @@ -27,12 +27,14 @@ properties:
>>>         - items:
>>>             - enum:
>>>                 - rockchip,px30-spi
>>> +              - rockchip,rv1126-spi
>> This list is sort alphabetically.
>> Move "rockchip,rv1126-spi" below "rockchip,rk3568-spi"
>>
>>>                 - rockchip,rk3188-spi
>>>                 - rockchip,rk3288-spi
>>>                 - rockchip,rk3308-spi
>>>                 - rockchip,rk3328-spi
>>>                 - rockchip,rk3368-spi
>>>                 - rockchip,rk3399-spi
>>> +              - rockchip,rk3568-spi
>>
>>>             - const: rockchip,rk3066-spi
>>>   
>>>     reg:
>>>
>> ===
>>
>> Your comment in [PATCH v3 3/8]:
>>>> Adding "rockchip,rv1126-spi" to rockchip_spi_dt_match[] is strictly not
>>>> needed when using "rockchip,rk3066-spi" as fall back string.
>>>> Could a maintainer advise?
With consulting to my colleague，we plane to:
1.If new soc's spi ip is compatible with the fall back one, we wont add 
new compatible id to the code.
2.I will add new fall back string stand for new generation ip: 
rockchip,rv1126-spi
>>>>
>>>> Maybe this bug of mine should revert too?? Or is it legacy?
>>>> spi: rockchip: add compatible string for px30 rk3308 rk3328
>>>> https://lore.kernel.org/r/20200309151004.7780-1-jbx6244@gmail.com
>>> I agree with you. If the maintainer doesn't have any comments, I will use
>>> "rockchip,spi" as compatible names for the subsequent rk platform.
>> Compatibility strings are supposed to be SoC orientated.
>> So generic ones like in the manufacturer tree can't be used here.
> Johan ist right :-) .
>
> rockchip,spi won't work at all, especially as these controllers always change
> over time. [0]
>
> Best example is the iommu. We started with "rockchip,iommu" thinking this
> won't change over time, but with the rk3568 we get a new slightly different
> iommu.
>
> The vendor-kernel then introduces somewhat random "-vX" additions to
> distinguish them, but often they do seem to be very software-centric.
>
> Meaning, hardware-designers moved stuff around and software-developers
> then invented the versioning to differentiate between versions.
>
> The devicetree is supposed to describe the hardware though, so going with
> the relevant soc-specific compatible gives us the necessary hardware-centric
> differentiation.
>
> Also this allows to catch later issues with specific soc implementations ;-)
> Like 6 monts down the road we discover some special behaviour on the
> rk3568 and devicetree is supposed to be stable.
>
> So having the relevant compatibles in place allows us to just add driver
> fixes and have those apply on the rk3568 if that is need at some point.
>
> Heiko
>
After the explain from you and Johan, I found that the idea 
"rockchip,spi" was immature.
>
>
>
>


