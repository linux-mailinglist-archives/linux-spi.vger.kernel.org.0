Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA9213768
	for <lists+linux-spi@lfdr.de>; Fri,  3 Jul 2020 11:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGCJPI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Jul 2020 05:15:08 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10957 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgGCJPI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Jul 2020 05:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593767707; x=1625303707;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=fBtSKRP9N2Fgt7VYWXnH4CSjKQi6GEbOhmh3zxMw3Ag=;
  b=ZOufPXQkjAQ2BMM+ToBnKVQhK1c94eoKb7QNNKPuLGe6CA0NAk2rm+pd
   LyQIsGXKAyO+OaHY4/bMwyjpMNTaP4dXQLYASeYuTyNQXzzG+X1bDU4/s
   L2Li8l5/dnMx6auh/y7YleYNGUxK6xwYzvutLiyKXEED9JTeeyGfo8vYF
   +2WrcOBrVXPl/EYqXUkXUk4rkgjTmHd5SvVtRJFqP7SofYcO7I1RhQTy2
   kmjvCisWwtoKooJEtG3KlwXGP63LwDeYVz4u6Thk+xf7IpyAhdrPPemhy
   F2azYNXIeW5ql8KdmY5EEMJK1RdxN2ohgy8wDdSYewB85UsvihfIc6sUS
   g==;
IronPort-SDR: Wded69KT4fpELpHp57F+Q/ZYnZ6icWWDlTQ9+rBq4isydhxOMnrvMe8O5XChU7DdAm7PKuINHs
 zBtQKzHKa9bA/Kx7BnOcSDP+wIv2OrxKna0LH4Rw0Hj8uTLKtWgd5875lpXIrr4M8d/0gHro1H
 5QAUcw01oGjDssIPTB7ouwWVWXwItObZwixZ+tBTVzwNIBeOHGRRHTmKBhqXQHX5vVHOQcea7E
 hv9ycdwgvUNcrWefoNMf6GvYM1qN12n9gSaNsGMpur2RX6dOBMBPub+j7RMPrCEHl6Jb3JYqLe
 Jco=
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="17936686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2020 02:14:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 02:13:43 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 3 Jul 2020 02:13:41 -0700
References: <20200702101331.26375-1-lars.povlsen@microchip.com> <20200702101331.26375-5-lars.povlsen@microchip.com> <99d9c814-24e2-b3a3-bf0f-765ee51df558@axentia.se>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 4/8] mux: sparx5: Add Sparx5 SPI mux driver
In-Reply-To: <99d9c814-24e2-b3a3-bf0f-765ee51df558@axentia.se>
Date:   Fri, 3 Jul 2020 11:14:00 +0200
Message-ID: <871rltklk7.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Peter Rosin writes:

> Hi!
>
> On 2020-07-02 12:13, Lars Povlsen wrote:
>> The Sparx5 mux driver may be used to control selecting between two
>> alternate SPI bus segments connected to the SPI controller
>> (spi-dw-mmio).
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  drivers/mux/Makefile     |   2 +
>>  drivers/mux/sparx5-spi.c | 138 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 140 insertions(+)
>>  create mode 100644 drivers/mux/sparx5-spi.c
>>
>> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
>> index 6e9fa47daf566..18c3ae3582ece 100644
>> --- a/drivers/mux/Makefile
>> +++ b/drivers/mux/Makefile
>> @@ -8,9 +8,11 @@ mux-adg792a-objs             := adg792a.o
>>  mux-adgs1408-objs            := adgs1408.o
>>  mux-gpio-objs                        := gpio.o
>>  mux-mmio-objs                        := mmio.o
>> +mux-sparx5-objs                      := sparx5-spi.o
>>
>>  obj-$(CONFIG_MULTIPLEXER)    += mux-core.o
>>  obj-$(CONFIG_MUX_ADG792A)    += mux-adg792a.o
>>  obj-$(CONFIG_MUX_ADGS1408)   += mux-adgs1408.o
>>  obj-$(CONFIG_MUX_GPIO)               += mux-gpio.o
>>  obj-$(CONFIG_MUX_MMIO)               += mux-mmio.o
>> +obj-$(CONFIG_SPI_DW_MMIO)    += mux-sparx5.o
>> diff --git a/drivers/mux/sparx5-spi.c b/drivers/mux/sparx5-spi.c
>> new file mode 100644
>> index 0000000000000..5fe9025b96a5e
>> --- /dev/null
>> +++ b/drivers/mux/sparx5-spi.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Sparx5 SPI MUX driver
>> + *
>> + * Copyright (c) 2019 Microsemi Corporation
>> + *
>> + * Author: Lars Povlsen <lars.povlsen@microchip.com>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/mux/driver.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/mux/driver.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +#include <linux/bitfield.h>
>> +
>> +#define MSCC_IF_SI_OWNER_SISL                        0
>> +#define MSCC_IF_SI_OWNER_SIBM                        1
>> +#define MSCC_IF_SI_OWNER_SIMC                        2
>> +
>> +#define SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL  0x88
>> +#define SPARX5_IF_SI_OWNER                   GENMASK(7, 6)
>> +#define SPARX5_IF_SI2_OWNER                  GENMASK(5, 4)
>> +
>> +#define SPARX5_MAX_CS        16
>> +
>> +struct mux_sparx5 {
>> +     struct regmap *syscon;
>> +     u8 bus[SPARX5_MAX_CS];
>> +     int cur_bus;
>
> Surplus unused variable?
>
>> +};
>> +
>> +/*
>> + * Set the owner of the SPI interfaces
>> + */
>> +static void mux_sparx5_set_owner(struct regmap *syscon,
>> +                              u8 owner, u8 owner2)
>> +{
>> +     u32 val, msk;
>> +
>> +     val = FIELD_PREP(SPARX5_IF_SI_OWNER, owner) |
>> +             FIELD_PREP(SPARX5_IF_SI2_OWNER, owner2);
>> +     msk = SPARX5_IF_SI_OWNER | SPARX5_IF_SI2_OWNER;
>> +     regmap_update_bits(syscon,
>> +                        SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL,
>> +                        msk, val);
>> +}
>> +
>> +static void mux_sparx5_set_cs_owner(struct mux_sparx5 *mux_sparx5,
>> +                                 u8 cs, u8 owner)
>> +{
>> +     u8 other = (owner == MSCC_IF_SI_OWNER_SIBM ?
>> +                 MSCC_IF_SI_OWNER_SIMC : MSCC_IF_SI_OWNER_SIBM);
>
> Empty line missing here.
>
>> +     if (mux_sparx5->bus[cs])
>> +             /* SPI2 */
>> +             mux_sparx5_set_owner(mux_sparx5->syscon, other, owner);
>> +     else
>> +             /* SPI1 */
>> +             mux_sparx5_set_owner(mux_sparx5->syscon, owner, other);
>> +}
>
>
> This smells like there are only two states for this mux control, and that
> the whole point of this driver is to make the exact numbering selectable.
> I don't see the point of that. To me, it looks like the pre-existing
> mmio-mux should be able to work. Something like this? Untested of course,
> and I might easily have misunderstood something...
>

Peter,

Good suggestion with "mmio-mux" - I overlooked it actually supports
regmap. It makes DT configuration a little less intuitive, but removes
the baggage of the dedicated sparx5 mux driver and bindings.

It also pushes the solution towards using "spi-mux", but at least the CS
in the DT does not have to be repeated.

So a little more DT stuff, but less new code.

I will try to implement the "mmio-mux"/"spi-mux" solution in a rev4.

Any comments from Mark?

Anyway, Peter, thank you for your comments.

(Your driver comments are all valid, but it appears the driver isn't
needed after all)

Cheers,

---Lars

> mux: mux-controller {
>         compatible = "mmio-mux"
>         #mux-control-cells = <1>;
>
>         /* SI_OWNER and SI2_OWNER in GENERAL_CTRL */
>         mux-reg-masks = <0x88 0xf0>;
> };
>
>
> spi0: spi@600104000 {
>         compatible = "microchip,sparx5-spi";
>         spi@0 {
>                 compatible = "spi-mux";
>                 mux-controls = <&mux 0>;
>                 reg = <0>;
>                 /* SI_OWNER = SIMC, SI2_OWNER = SIBM  --->  mux value 9 */
>                 spi-flash@9 {
>                         compatible = "jedec,spi-nor";
>                         reg = <9>;
>                 };
>         };
>         spi@e {
>                 compatible = "spi-mux";
>                 mux-controls = <&mux 0>;
>                 reg = <14>;
>                 /* SI_OWNER = SIBM, SI2_OWNER = SIMC  --->  mux value 6 */
>                 spi-flash@6 {
>                         compatible = "spi-nand";
>                         reg = <6>;
>                 };
>         };
> };
>
>> +
>> +static int mux_sparx5_set(struct mux_control *mux, int state)
>> +{
>> +     struct mux_sparx5 *mux_sparx5 = mux_chip_priv(mux->chip);
>> +
>> +     mux_sparx5_set_cs_owner(mux_sparx5, state, MSCC_IF_SI_OWNER_SIMC);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct mux_control_ops mux_sparx5_ops = {
>> +     .set = mux_sparx5_set,
>> +};
>> +
>> +static const struct of_device_id mux_sparx5_dt_ids[] = {
>> +     { .compatible = "microchip,sparx5-spi-mux", },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mux_sparx5_dt_ids);
>> +
>> +static int mux_sparx5_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct mux_chip *mux_chip;
>> +     struct mux_sparx5 *mux_sparx5;
>> +     struct device_node *nc;
>> +     const char *syscon_name = "microchip,sparx5-cpu-syscon";
>> +     int ret;
>> +
>> +     mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_sparx5));
>> +     if (IS_ERR(mux_chip))
>> +             return PTR_ERR(mux_chip);
>> +
>> +     mux_sparx5 = mux_chip_priv(mux_chip);
>> +     mux_chip->ops = &mux_sparx5_ops;
>> +
>> +     mux_sparx5->syscon =
>> +             syscon_regmap_lookup_by_compatible(syscon_name);
>> +     if (IS_ERR(mux_sparx5->syscon)) {
>> +             dev_err(dev, "No syscon map %s\n", syscon_name);
>> +             return PTR_ERR(mux_sparx5->syscon);
>> +     }
>> +
>> +     /* Get bus interface mapping */
>> +     for_each_available_child_of_node(dev->of_node, nc) {
>> +             u32 cs, bus;
>> +
>> +             if (of_property_read_u32(nc, "reg", &cs) == 0 &&
>> +                 cs < SPARX5_MAX_CS &&
>> +                 of_property_read_u32(nc, "microchip,bus-interface",
>> +                                      &bus) == 0)
>> +                     mux_sparx5->bus[cs] = bus;
>
> The above if is a mess. The kernel model is to handle the exceptional cases
> first and break/goto/continue/return/whatever so that the interesting code
> can happen at lower indentation level.
>
>                 if (of_property_read_u32(nc, "reg", &cs))
>                         continue;
>                 if (cs >= SPARX5_MAX_CS)
>                         continue;
>                 if (of_property_read_u32(nc, "microchip,bus-interface", &bus))
>                         continue;
>
>                 mux_sparc5->bus[cs] = bus;
>
> Cheers,
> Peter
>
>> +     }
>> +
>> +     mux_chip->mux->states = SPARX5_MAX_CS;
>> +
>> +     ret = devm_mux_chip_register(dev, mux_chip);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     dev_info(dev, "%u-way mux-controller registered\n",
>> +              mux_chip->mux->states);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver mux_sparx5_driver = {
>> +     .driver = {
>> +             .name = "sparx5-mux",
>> +             .of_match_table = of_match_ptr(mux_sparx5_dt_ids),
>> +     },
>> +     .probe = mux_sparx5_probe,
>> +};
>> +module_platform_driver(mux_sparx5_driver);
>>

-- 
Lars Povlsen,
Microchip
