Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8BF3AA8CB
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jun 2021 03:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhFQBx5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 21:53:57 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:43056 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFQBx5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Jun 2021 21:53:57 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 14F3B1B67;
        Thu, 17 Jun 2021 09:51:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P15326T140654340470528S1623894702990941_;
        Thu, 17 Jun 2021 09:51:44 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8676accae82e1e2e8682e39c204adf18>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: macromorgan@hotmail.com
X-RCPT-COUNT: 21
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v7 1/9] dt-bindings: rockchip-sfc: Bindings for Rockchip
 serial flash controller
To:     Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Jon Lin <jon.lin@rock-chips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?B?6buE5a626ZKX?= <hjc@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>
References: <20210609140412.16058-1-jon.lin@rock-chips.com>
 <20210609140412.16058-2-jon.lin@rock-chips.com>
 <20210610024350.GA697147@robh.at.kernel.org>
 <e8e7c8c1-4f71-538c-a8e1-b61a894bd4a8@rock-chips.com>
 <CAAEAJfCyXWvcqswXfmgXBX-et0mq3vxoUacUmHGso9t+XoNqOg@mail.gmail.com>
 <CAL_JsqL1Sb_TCw6TG7XGBDtmhMVD+_n7d-ii7N9N7w1+A627=w@mail.gmail.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <e2be59ae-37a0-4455-e5a6-f7156da29e95@rock-chips.com>
Date:   Thu, 17 Jun 2021 09:51:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL1Sb_TCw6TG7XGBDtmhMVD+_n7d-ii7N9N7w1+A627=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On 2021/6/16 下午11:38, Rob Herring wrote:
> On Fri, Jun 11, 2021 at 10:33 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>> Hi all,
>>
>> On Thu, 10 Jun 2021 at 00:04, Kever Yang <kever.yang@rock-chips.com> wrote:
>>> Hi Rob,
>>>
>>> On 2021/6/10 上午10:43, Rob Herring wrote:
>>>> On Wed, Jun 09, 2021 at 10:04:04PM +0800, Jon Lin wrote:
>>>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>>>
>>>>> Add bindings for the Rockchip serial flash controller. New device
>>>>> specific parameter of rockchip,sfc-no-dma included in documentation.
>>>>>
>>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>>>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>>>>> ---
>>>>>
>>>>> Changes in v7:
>>>>> - Fix up the sclk_sfc parent error in rk3036
>>>>> - Unify to "rockchip,sfc" compatible id because all the feature update
>>>>>     will have a new IP version, so the driver is used for the SFC IP in
>>>>>     all SoCs
>>>>> - Change to use node "sfc" to name the SFC pinctrl group
>>>>> - Add subnode reg property check
>>>>> - Add rockchip_sfc_adjust_op_size to workaround in CMD + DUMMY case
>>>>> - Limit max_iosize to 32KB
>>>>>
>>>>> Changes in v6:
>>>>> - Add support in device trees for rv1126(Declared in series 5 but not
>>>>>     submitted)
>>>>> - Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does not
>>>>>     affect interpretation and has been widely used
>>>>> - Support sfc tx_dual, tx_quad(Declared in series 5 but not submitted)
>>>>> - Simplify the code, such as remove "rockchip_sfc_register_all"(Declared
>>>>>     in series 5 but not submitted)
>>>>> - Support SFC ver4 ver5(Declared in series 5 but not submitted)
>>>>> - Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
>>>>> - Change to use devm_spi_alloc_master and spi_unregister_master
>>>>>
>>>>> Changes in v5:
>>>>> - Add support in device trees for rv1126
>>>>> - Support sfc tx_dual, tx_quad
>>>>> - Simplify the code, such as remove "rockchip_sfc_register_all"
>>>>> - Support SFC ver4 ver5
>>>>>
>>>>> Changes in v4:
>>>>> - Changing patch back to an "RFC". An engineer from Rockchip
>>>>>     reached out to me to let me know they are working on this patch for
>>>>>     upstream, I am submitting this v4 for the community to see however
>>>>>     I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
>>>>>     soon and these are the ones we should pursue for mainlining. Jon's
>>>>>     patch series should include support for more hardware than this
>>>>>     series.
>>>>> - Clean up documentation more and ensure it is correct per
>>>>>     make dt_binding_check.
>>>>> - Add support in device trees for rk3036, rk3308, and rv1108.
>>>>> - Add ahb clock (hclk_sfc) support for rk3036.
>>>>> - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
>>>>> - Change IRQ code to only mark IRQ as handled if it handles the
>>>>>     specific IRQ (DMA transfer finish) it is supposed to handle.
>>>>>
>>>>> Changes in v3:
>>>>> - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
>>>>> - Changed the compatible string from rockchip,sfc to
>>>>>     rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
>>>>>     driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
>>>>>     RV1108 SoCs, and possibly more. However, I am currently only able
>>>>>     to test this on a PX30 (an RK3326). The technical reference manuals
>>>>>     appear to list the same registers for each device.
>>>>> - Corrected devicetree documentation for formatting and to note these
>>>>>     changes.
>>>>> - Replaced the maintainer with Heiko Stuebner and myself, as we will
>>>>>     take ownership of this going forward.
>>>>> - Noted that the device (per the reference manual) supports 4 CS, but
>>>>>     I am only able to test a single CS (CS 0).
>>>>> - Reordered patches to comply with upstream rules.
>>>>>
>>>>> Changes in v2:
>>>>> - Reimplemented driver using spi-mem subsystem.
>>>>> - Removed power management code as I couldn't get it working properly.
>>>>> - Added device tree bindings for Odroid Go Advance.
>>>>>
>>>>> Changes in v1:
>>>>> hanges made in this new series versus the v8 of the old series:
>>>>> - Added function to read spi-rx-bus-width from device tree, in the
>>>>>     event that the SPI chip supports 4x mode but only has 2 pins
>>>>>     wired (such as the Odroid Go Advance).
>>>>> - Changed device tree documentation from txt to yaml format.
>>>>> - Made "reset" message a dev_dbg from a dev_info.
>>>>> - Changed read and write fifo functions to remove redundant checks.
>>>>> - Changed the write and read from relaxed to non-relaxed when
>>>>>     starting the DMA transfer or reading the DMA IRQ.
>>>>> - Changed from dma_coerce_mask_and_coherent to just
>>>>>     dma_set_mask_and_coherent.
>>>>> - Changed name of get_if_type to rockchip_sfc_get_if_type.
>>>>>
>>>>>    .../devicetree/bindings/spi/rockchip-sfc.yaml | 88 +++++++++++++++++++
>>>>>    1 file changed, 88 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..42e4198e92af
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>>>>> @@ -0,0 +1,88 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/spi/rockchip-sfc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Rockchip Serial Flash Controller (SFC)
>>>>> +
>>>>> +maintainers:
>>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>>> +  - Chris Morgan <macromorgan@hotmail.com>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: spi-controller.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - const: rockchip,sfc
>>>> Use 'enum' instead of oneOf+const.
>>>>
>>>> You need an SoC specific compatible.
>>>
>>> The rockchip sfc controller is a standalone IP with version register,
>>> and the driver can
>>>
>>> handle all the feature difference inside the IP, so we would like to use
>>> a more generic
> Okay, if the version register can be relied on, then this is fine.
> Just add a comment that further differentiation is done using a
> version register.


Thanks for your confirm, this will make things much simple for driver 
maintain.

@Jon, please update your patch per Rob's requirement.


Thanks,
- Kever


