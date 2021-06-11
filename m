Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568813A3A8E
	for <lists+linux-spi@lfdr.de>; Fri, 11 Jun 2021 05:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhFKD4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 23:56:13 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:45668 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFKD4N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 23:56:13 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 9B7FA1DB8;
        Fri, 11 Jun 2021 11:54:10 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.73] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15328T140654309000960S1623383648787942_;
        Fri, 11 Jun 2021 11:54:10 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <70eca2d5e53924834f14eb9922eb0b7d>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-clk@vger.kernel.org
X-RCPT-COUNT: 19
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v7 9/9] arm64: dts: rockchip: Enable SFC for Odroid Go
 Advance
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-spi@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org
References: <20210609140412.16058-1-jon.lin@rock-chips.com>
 <20210609141348.19178-1-jon.lin@rock-chips.com>
 <20210609141348.19178-5-jon.lin@rock-chips.com>
 <20210610173657.GA20228@wintermute.localdomain>
 <89283da6-b00e-4d0f-5c4a-0169bda101d3@rock-chips.com>
 <SN6PR06MB5342327048383CC3D416C93DA5349@SN6PR06MB5342.namprd06.prod.outlook.com>
From:   Jon Lin <jon.lin@rock-chips.com>
Message-ID: <19481190-2a28-8602-8f5f-6258a967833d@rock-chips.com>
Date:   Fri, 11 Jun 2021 11:54:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN6PR06MB5342327048383CC3D416C93DA5349@SN6PR06MB5342.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/11/21 11:38 AM, Chris Morgan wrote:
> On Fri, Jun 11, 2021 at 10:26:35AM +0800, Jon Lin wrote:
>> Hi Chris
>>
>> May you attach the XT25F128B device code to me, and I'll try to work it out.
> Sure, here is the patch I am using:
>
> https://patchwork.ozlabs.org/project/linux-mtd/patch/SN6PR06MB5342C82F372F37FB8E21B327A57A9@SN6PR06MB5342.namprd06.prod.outlook.com/

this patch works well in my rk3308 tx-2 rx-2 XT25F128BSSIGU case.

# dd if=/tmp/rand.img of=/dev/mtdblock0 bs=4096 seek=1024
1024+0 records in
1024+0 records out
#
# dd if=/dev/mtd0 of=/tmp/rand1.img bs=4096 skip=1024 count=1024

1024+0 records in
1024+0 records out
#
#
# md5sum /tmp/*.img
83e45a56766168b47e6db1d41b1b403d  /tmp/rand.img
83e45a56766168b47e6db1d41b1b403d  /tmp/rand1.img
#
# dmesg | grep XT25F128BSSIGU
[    0.200738] spi-nor spi3.0: XT25F128BSSIGU (16384 Kbytes)
#

>
>> On 6/11/21 1:36 AM, Chris Morgan wrote:
>>> On Wed, Jun 09, 2021 at 10:13:48PM +0800, Jon Lin wrote:
>>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>>
>>>> This enables the Rockchip Serial Flash Controller for the Odroid Go
>>>> Advance. Note that while the attached SPI NOR flash and the controller
>>>> both support quad read mode, only 2 of the required 4 pins are present.
>>>> The rx and tx bus width is set to 2 for this reason.
>>>>
>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>>>> ---
>>>>
>>>> Changes in v7: None
>>>> Changes in v6: None
>>>> Changes in v5: None
>>>> Changes in v4: None
>>>> Changes in v3: None
>>>> Changes in v2: None
>>>> Changes in v1: None
>>>>
>>>>    .../boot/dts/rockchip/rk3326-odroid-go2.dts      | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>>>> index 49c97f76df77..f78e11dd8447 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
>>>> @@ -484,6 +484,22 @@
>>>>    	status = "okay";
>>>>    };
>>>> +&sfc {
>>>> +	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
>>>> +	pinctrl-names = "default";
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <0>;
>>>> +	status = "okay";
>>>> +
>>>> +	flash@0 {
>>>> +		compatible = "jedec,spi-nor";
>>>> +		reg = <0>;
>>>> +		spi-max-frequency = <108000000>;
>>>> +		spi-rx-bus-width = <2>;
>>>> +		spi-tx-bus-width = <2>;
>>> Note that I am still working with Jon Lin to research this, but it was
>>> found in testing that if I set the tx bus width to 1 the problems I
>>> encountered in earlier are resolved. At this time I do not know if it
>>> is an issue with the driver for the flash controller, or if the NOR, or
>>> board itself has some sort of errata which prevent dual tx from working
>>> correctly. Note that as of right now the flash chip I am using (an
>>> XTX XT25F128B) is not currently supported in mainline, so it's very
>>> possible this is some sort of errata with the chip. It's also possible
>>> that there is something with the board that is interferring with dual
>>> mode TX.  When Jon comes back that he has tested dual mode on the SFC
>>> with a different board/chip I will recommend that we change the tx
>>> bus width here to a 1, and then once the XT25F128B gets mainlined we
>>> can see if someone else has issues with dual tx mode so we can note
>>> that as a problem with the chip. Or maybe there is something weird
>>> with dual tx mode yet on the SFC driver/controller, I don't know yet.
>>> I'm all too happy to work with a Rockchip engineer so things like
>>> this can be determined before we hit mainline. :-)
>>>
>>> The XTX25F128B driver is currently awaiting a decision on how to handle
>>> continuation codes, as this chip ID should be using continuation codes,
>>> but doesn't appear to return them when you query for manufacturer ID.
>>> So I should also note in the commit here that the SFC will still be
>>> unusable on the Odroid Go Advance until the XTX25F128B is also
>>> mainlined.
>>>
>>> Thank you.
>>>
>>>> +	};
>>>> +};
>>>> +
>>>>    &tsadc {
>>>>    	status = "okay";
>>>>    };
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
>>>>
>>>
>>
>
>


