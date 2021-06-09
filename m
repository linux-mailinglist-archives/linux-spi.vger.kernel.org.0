Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273803A0A3A
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 04:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFICt5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 22:49:57 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:54620 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhFICt4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 22:49:56 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 22:49:55 EDT
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 164081F5D;
        Wed,  9 Jun 2021 10:40:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095126476544S1623206439537590_;
        Wed, 09 Jun 2021 10:40:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <109c2c5a014b780e9cd049b63178e813>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v4 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126 and rk3568
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jon Lin <jon.lin@rock-chips.com>, broonie@kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20210607063448.29589-1-jon.lin@rock-chips.com>
 <20210607063448.29589-2-jon.lin@rock-chips.com>
 <ef90ae6d-40bb-8389-f4f8-536a7b610fb7@gmail.com> <3681106.bcXerOTE6V@diego>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <f815ad6c-36c5-039e-0ae8-0ab523a75caa@rock-chips.com>
Date:   Wed, 9 Jun 2021 10:40:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3681106.bcXerOTE6V@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Heiko, Johan,

On 2021/6/7 下午5:04, Heiko Stübner wrote:
> Your comment in [PATCH v3 3/8]:
>>>> Adding "rockchip,rv1126-spi" to rockchip_spi_dt_match[] is strictly not
>>>> needed when using "rockchip,rk3066-spi" as fall back string.
>>>> Could a maintainer advise?
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


Rockchip SPI and SFC controller can use a generic compatible string, 
because there is a version

register inside the IP, and all the feature update will have a new IP 
version, so the driver is

used for the SPI/SFC IP  in all SoCs, we don't need to care which SoC is 
using this driver.

If we have to use the compatible string "rockchip,rk3066-spi" and each 
for a new soc, then we

have to update the driver compatible id list and document for each soc 
which is totally not need

and not correct  to do it.

The example "iommu" is different, because there is no version register 
inside the IP and the IP

can not identify itself, which need a software define "-vX".


Thanks,

- Kever

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
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>


