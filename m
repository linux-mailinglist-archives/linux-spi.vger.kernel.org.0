Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C413A0ADB
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 05:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhFIDwJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 23:52:09 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:59678 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhFIDwJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 23:52:09 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id C12D66E2;
        Wed,  9 Jun 2021 11:50:13 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.73] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31751T140095189415680S1623210612190495_;
        Wed, 09 Jun 2021 11:50:13 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b3b6a22af7c09d01b3aaab2eafd191f0>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: macromorgan@hotmail.com
X-RCPT-COUNT: 16
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v6 1/8] dt-bindings: rockchip-sfc: Bindings for Rockchip
 serial flash controller
To:     Johan Jonker <jbx6244@gmail.com>, linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
References: <20210608022644.21074-1-jon.lin@rock-chips.com>
 <20210608022644.21074-2-jon.lin@rock-chips.com>
 <eb576a12-d084-6cf3-35d0-e50354b7b272@gmail.com>
From:   Jon Lin <jon.lin@rock-chips.com>
Message-ID: <64021ae2-1bd1-04ae-9930-36219320cf26@rock-chips.com>
Date:   Wed, 9 Jun 2021 11:50:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eb576a12-d084-6cf3-35d0-e50354b7b272@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 6/9/21 2:03 AM, Johan Jonker wrote:
> Hi Jon,
>
> A look at the build log shows this error:
>
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210608022644.21074-2-jon.lin@rock-chips.com/
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dt.yaml:
> spi@ff3a0000: clock-names:0: 'hclk_sfc' was expected
> 	From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dt.yaml:
> spi@ff3a0000: clock-names:1: 'clk_sfc' was expected
> 	From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>
> Check document with:
>
> make ARCH=arm dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>
> Remove any errors before submitting.
>
> ===
>
> Johan
>
> On 6/8/21 4:26 AM, Jon Lin wrote:
>> From: Chris Morgan <macromorgan@hotmail.com>
>>
>> Add bindings for the Rockchip serial flash controller. New device
>> specific parameter of rockchip,sfc-no-dma included in documentation.
>>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>> ---
>>
>> Changes in v6:
>> - Add support in device trees for rv1126(Declared in series 5 but not
>>    submitted)
>> - Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does not
>>    affect interpretation and has been widely used
>> - Support sfc tx_dual, tx_quad(Declared in series 5 but not submitted)
>> - Simplify the code, such as remove "rockchip_sfc_register_all"(Declared
>>    in series 5 but not submitted)
>> - Support SFC ver4 ver5(Declared in series 5 but not submitted)
>> - Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
>> - Change to use devm_spi_alloc_master and spi_unregister_master
>>
>> Changes in v5:
>> - Add support in device trees for rv1126
>> - Support sfc tx_dual, tx_quad
>> - Simplify the code, such as remove "rockchip_sfc_register_all"
>> - Support SFC ver4 ver5
>>
>> Changes in v4:
>> - Changing patch back to an "RFC". An engineer from Rockchip
>>    reached out to me to let me know they are working on this patch for
>>    upstream, I am submitting this v4 for the community to see however
>>    I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
>>    soon and these are the ones we should pursue for mainlining. Jon's
>>    patch series should include support for more hardware than this
>>    series.
>> - Clean up documentation more and ensure it is correct per
>>    make dt_binding_check.
>> - Add support in device trees for rk3036, rk3308, and rv1108.
>> - Add ahb clock (hclk_sfc) support for rk3036.
>> - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
>> - Change IRQ code to only mark IRQ as handled if it handles the
>>    specific IRQ (DMA transfer finish) it is supposed to handle.
>>
>> Changes in v3:
>> - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
>> - Changed the compatible string from rockchip,sfc to
>>    rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
>>    driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
>>    RV1108 SoCs, and possibly more. However, I am currently only able
>>    to test this on a PX30 (an RK3326). The technical reference manuals
>>    appear to list the same registers for each device.
>> - Corrected devicetree documentation for formatting and to note these
>>    changes.
>> - Replaced the maintainer with Heiko Stuebner and myself, as we will
>>    take ownership of this going forward.
>> - Noted that the device (per the reference manual) supports 4 CS, but
>>    I am only able to test a single CS (CS 0).
>> - Reordered patches to comply with upstream rules.
>>
>> Changes in v2:
>> - Reimplemented driver using spi-mem subsystem.
>> - Removed power management code as I couldn't get it working properly.
>> - Added device tree bindings for Odroid Go Advance.
>>
>> Changes in v1:
>> hanges made in this new series versus the v8 of the old series:
>> - Added function to read spi-rx-bus-width from device tree, in the
>>    event that the SPI chip supports 4x mode but only has 2 pins
>>    wired (such as the Odroid Go Advance).
>> - Changed device tree documentation from txt to yaml format.
>> - Made "reset" message a dev_dbg from a dev_info.
>> - Changed read and write fifo functions to remove redundant checks.
>> - Changed the write and read from relaxed to non-relaxed when
>>    starting the DMA transfer or reading the DMA IRQ.
>> - Changed from dma_coerce_mask_and_coherent to just
>>    dma_set_mask_and_coherent.
>> - Changed name of get_if_type to rockchip_sfc_get_if_type.
>>
>>   .../devicetree/bindings/spi/rockchip-sfc.yaml | 87 +++++++++++++++++++
>>   1 file changed, 87 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>> new file mode 100644
>> index 000000000000..160449713f97
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
>> @@ -0,0 +1,87 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/rockchip-sfc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip Serial Flash Controller (SFC)
>> +
>> +maintainers:
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +  - Chris Morgan <macromorgan@hotmail.com>
> In the driver spi-rockchip-sfc.c is used:
> Chris Morgan <macroalpha82@gmail.com>
> Maybe use a consistent email address?
> Also Hotmail does strange things to message-ID's and links/content
> inside patches.
>
>> +
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: rockchip,rk3036-sfc
>> +      - items:
>> +          - enum:
>> +              - rockchip,px30-sfc
>> +              - rockchip,rk3308-sfc
>> +              - rockchip,rv1108-sfc
>> +          - const: rockchip,rk3036-sfc
>> +      - const: rockchip,rv1126-sfc
> A look at the driver shows this:
>
> +static const struct of_device_id rockchip_sfc_dt_ids[] = {
>
> +	{ .compatible = "rockchip,px30-sfc"},
>
> remove
>
> +	{ .compatible = "rockchip,rk3036-sfc"},
>
> +	{ .compatible = "rockchip,rk3308-sfc"},
> +	{ .compatible = "rockchip,rv1126-sfc"},
>
> remove
>
> +	{ /* sentinel */ }
> +};
>
> When no '.data = &my_sfc_data' exist then there's no need for additional
> compatible strings in the driver.
> ===
> example for I2S:
> 	{ .compatible = "rockchip,rk3399-i2s", .data = &rk3399_i2s_pins },
> ===
> Compatibility strings are supposed to be SoC orientated.
> With rockchip_sfc_get_version() all we need is one fall back string for
> now I think. Is rk3568 identical. Please advise.
>
>
>        - const: rockchip,rk3036-sfc
>        - items:
>            - enum:
>                - rockchip,px30-sfc
>                - rockchip,rk3308-sfc
>                - rockchip,rk3368-sfc
>                - rockchip,rk3568-sfc
>                - rockchip,rv1108-sfc
>                - rockchip,rv1126-sfc
>            - const: rockchip,rk3036-sfc
>
> ===
>
> The rk3368 TRM also describes a SFC controller.
> For the mainline DT completeness is it possible to add a rk3368 SFC node
> as well? ;)
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Bus Clock
>> +      - description: Module Clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: hclk_sfc
>> +      - const: clk_sfc
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  rockchip,sfc-no-dma:
>> +    description: Disable DMA and utilize FIFO mode only
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/px30-cru.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/px30-power.h>
>> +
>> +    sfc: spi@ff3a0000 {
>> +        compatible = "rockchip,px30-sfc","rockchip,rk3036-sfc";
>> +        reg = <0xff3a0000 0x4000>;
>> +        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
>> +        clock-names = "clk_sfc", "hclk_sfc";
> The clocks in the examples and dtsi files must have the same sort order.
>
>> +        pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus2>;
>> +        pinctrl-names = "default";
>> +        power-domains = <&power PX30_PD_MMC_NAND>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        flash@0 {
> >From spi-controller.yaml:
>
> patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
>
>      properties:
>        compatible:
>          description:
>            Compatible of the SPI device.
>
>        reg:
>          minimum: 0
>
>          maximum: 256
>
>          description:
>            Chip select used by the device.
>
> This allows 257 sub nodes.
> Support up to 4 chip select in the driver.
> #define SFC_MAX_CHIPSELECT_NUM		4
RK SFC design is up to 4 CS.

Sorry, I don't see any specific improvement in this comment, can you 
explain it in detail.
>
>> +            compatible = "jedec,spi-nor";
>> +            reg = <0>;
>> +            spi-max-frequency = <108000000>;
>> +            spi-rx-bus-width = <2>;
>> +            spi-tx-bus-width = <2>;
>> +        };
>> +    };
>> +
>> +...
>>
>
>


