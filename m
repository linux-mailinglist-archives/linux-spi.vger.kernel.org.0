Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74F839D532
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 08:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGGpz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 02:45:55 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:33426 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGGpy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 02:45:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jun 2021 02:45:53 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id E871C7D3;
        Mon,  7 Jun 2021 14:35:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.73] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32531T140357140461312S1623047754740766_;
        Mon, 07 Jun 2021 14:35:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7508cccd791cddd4389844d16fe8e0b2>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: kernel@esmil.dk
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v3 3/8] dt-bindings: spi: spi-rockchip: add description
 for rv1126
To:     Johan Jonker <jbx6244@gmail.com>, broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk
References: <20210605094659.13507-1-jon.lin@rock-chips.com>
 <20210605094659.13507-3-jon.lin@rock-chips.com>
 <4d60a524-5a54-f972-7605-25db3b825cfa@gmail.com>
From:   Jon Lin <jon.lin@rock-chips.com>
Message-ID: <9d6c9b33-2e56-430b-0ea7-df0ebc0a16b4@rock-chips.com>
Date:   Mon, 7 Jun 2021 14:36:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d60a524-5a54-f972-7605-25db3b825cfa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/6/21 4:30 AM, Johan Jonker wrote:
> Hi Jon,
>
> Some comments. Have a look if it's useful.
>
> ===
>
> In order to get this patch reviewed by rob+dt you must include:
> robh+dt@kernel.org
> devicetree@vger.kernel.org
>
> Check your review status here:
> https://patchwork.ozlabs.org/project/devicetree-bindings/list/
>
> Get the other lists and maintainers with:
> ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
> --nogit <patch1> <patch2>

done.

> ===
>
> Please try to order patches like:
> (1) dt-binding - compatible addition
> (2) driver patches
> (3) devicetree node patches
>
> The script below gives a warning if the wrong order is used.
> ./scripts/checkpatch.pl --strict <patch1> <patch2>

done.

> ===
>
> The [PATCH v3 2/8] has duplicate Signed-off-by's.
>
> Signed-off-by: Jon Lin <jon.lin at rock-chips.com>
> Signed-off-by: Jon Lin <jon.lin at rock-chips.com>
>
> What has changed in version 3 ?
> Maybe add a cover letter and a change log too?
> git format-patch -v4 -8 --cover-letter HEAD

done.

> ===
>
> The commit message in [PATCH v3 4/8] has to many "applications", so
> maybe restyle a bit?
>
> Add compatible string for rv1126 to applications for potential
> applications.
done.
>
> Adding "rockchip,rv1126-spi" to rockchip_spi_dt_match[] is strictly not
> needed when using "rockchip,rk3066-spi" as fall back string.
> Could a maintainer advice?
>
> Maybe this bug of mine should revert too?? Or is it legacy? ;)
> spi: rockchip: add compatible string for px30 rk3308 rk3328
> https://lore.kernel.org/r/20200309151004.7780-1-jbx6244@gmail.com
I agree with you. If the maintainer doesn't have any comments, I will use
"rockchip,spi" as compatible names for the subsequent rk platform.
>
> ===
>
> Johan
>
> On 6/5/21 11:46 AM, Jon Lin wrote:
>> The description below will be used for rv1126.dtsi in the future
>>
>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>> index 1e6cf29e6388..4ed5b72a8494 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>> @@ -27,6 +27,7 @@ properties:
>>         - items:
>>             - enum:
>>                 - rockchip,px30-spi
>> +              - rockchip,rv1126-spi
> Sort alphabetically.
>
>>                 - rockchip,rk3188-spi
>>                 - rockchip,rk3288-spi
>>                 - rockchip,rk3308-spi
>>
>
>


