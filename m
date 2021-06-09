Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C333A16F4
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhFIOVw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 10:21:52 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:33604 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbhFIOVv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 10:21:51 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 3BF1BE31;
        Wed,  9 Jun 2021 22:18:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.73] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30810T139673931085568S1623248332896123_;
        Wed, 09 Jun 2021 22:18:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9bf565096dc6cc666549660df8d44332>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: macromorgan@hotmail.com
X-RCPT-COUNT: 16
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v6 4/8] clk: rockchip: Add support for hclk_sfc on rk3036
To:     Johan Jonker <jbx6244@gmail.com>, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20210608022644.21074-1-jon.lin@rock-chips.com>
 <20210608022644.21074-5-jon.lin@rock-chips.com>
 <4a4524f5-ee85-c7f6-aa95-1df84f2a8a99@gmail.com>
From:   Jon Lin <jon.lin@rock-chips.com>
Message-ID: <d5b4f452-1f76-e82c-42dd-bc6fdf27a59c@rock-chips.com>
Date:   Wed, 9 Jun 2021 22:18:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4a4524f5-ee85-c7f6-aa95-1df84f2a8a99@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/9/21 12:31 AM, Johan Jonker wrote:
> Hi Jon,
>
> For rk3036 we might need another fix added to this serie as well.
>
> clk: rockchip: rk3036: fix up the sclk_sfc parent error
> https://github.com/rockchip-linux/kernel/commit/100718ef0d44872db1672b6a88030374c0d1613b
>
> ===
> Add more people for clk driver changes:
>
> M:	Michael Turquette <mturquette@baylibre.com>
> M:	Stephen Boyd <sboyd@kernel.org>
> L:	linux-clk@vger.kernel.org
>
> ===
>
> Johan
>
> On 6/8/21 4:26 AM, Jon Lin wrote:
>
>> From: Chris Morgan <macromorgan@hotmail.com>
> From: Randy Li <randy.li@rock-chips.com>
>
>> Add support for the bus clock for the serial flash controller on the
>> rk3036. Taken from the Rockchip BSP kernel but not tested on real
>> hardware (as I lack a 3036 based SoC to test).
>>
> Signed-off-by: Randy Li <randy.li@rock-chips.com>
>
> Maybe give credit to the original author?
> clk: rockchip: rk3036: export the sfc clocks
> https://github.com/rockchip-linux/kernel/commit/600925e8ef6edbdda0a4ac6b3c55b0199be1e03e
something wrong when I add randy.li@rock-chips.com email, I will make a 
confirmation with it with him.
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>> ---
>>
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>> Changes in v1: None
>>
>>   drivers/clk/rockchip/clk-rk3036.c      | 2 +-
>>   include/dt-bindings/clock/rk3036-cru.h | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
>> index 91d56ad45817..ebb628733f6d 100644
>> --- a/drivers/clk/rockchip/clk-rk3036.c
>> +++ b/drivers/clk/rockchip/clk-rk3036.c
>> @@ -403,7 +403,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
>>   	GATE(HCLK_OTG0, "hclk_otg0", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 13, GFLAGS),
>>   	GATE(HCLK_OTG1, "hclk_otg1", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(7), 3, GFLAGS),
>>   	GATE(HCLK_I2S, "hclk_i2s", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
>> -	GATE(0, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
>> +	GATE(HCLK_SFC, "hclk_sfc", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(3), 14, GFLAGS),
> Maybe CLK_IGNORE_UNUSED should be changed to 0 ?
>
>>   	GATE(HCLK_MAC, "hclk_mac", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 5, GFLAGS),
>>   
>>   	/* pclk_peri gates */
>> diff --git a/include/dt-bindings/clock/rk3036-cru.h b/include/dt-bindings/clock/rk3036-cru.h
>> index 35a5a01f9697..a96a9870ad59 100644
>> --- a/include/dt-bindings/clock/rk3036-cru.h
>> +++ b/include/dt-bindings/clock/rk3036-cru.h
>> @@ -81,6 +81,7 @@
>>   #define HCLK_OTG0		449
>>   #define HCLK_OTG1		450
>>   #define HCLK_NANDC		453
>> +#define HCLK_SFC		454
>>   #define HCLK_SDMMC		456
>>   #define HCLK_SDIO		457
>>   #define HCLK_EMMC		459
>>
>
>


