Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0011212268
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgGBLgL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 07:36:11 -0400
Received: from mail-eopbgr20123.outbound.protection.outlook.com ([40.107.2.123]:46830
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgGBLgK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 07:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q01MIlOBJvsHvQ6P9v8T+R5W3Lhd0s6ttBi7HFMAd2Zyj01QgF64YgIItueYjJKIPTwBuhjUEIXkvko5zygOf+1ZQ9hJFNgAYILKYjfPFrqwgNUNBPlcdcmsnfmAm9q2RMXnoNGpm/nrKzc7Y3Gy09h7vgDyOtbCTTAc43EpmInhqIF/cNT1jGZpibhBEygRqHUzvXZM97Tpu9gXrE9cAJKkjBoOpdZkwmw/53lXm++RKq9Y7bwR4Ur36p71I5sgp/6fIkR+odIARlDA0OmyT0bRMfdSmhid0tvWkjO1+UoxKFiQHXYT/pc4GDNXHHi7yn1vaGtSPGMcQL4lKI6Cyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyxu5QM96OjDgKum/dm9tCNOYxNb0Ok4QEvkC5omJYc=;
 b=DT9H4XMLO1juRQn4A2YW8bNU8Ah6IEQI7HUC30NXyGtz5KYptXXAEOWjFAFO5Lc1t+Sj8YMS4JnSfFGItCHgk5dyQtaBpNChRvsCXYTpA7vIMUnPr6XskZEFkjCXkESTj6FaO05X2Uw7AdUY0ZkXx5NteYPrByxDT3mBp6o4Qu6V7XQZ9XNrDqHn+DqlO2u8rHJcoerjdLTnAtdFaSlxn2M1SxgurjKToZd9Va6fHNyXf6GJCLmv8mZ2KXuXb50+tHrqtWCtGcgTc/eT8lz9XROrtrhgL0qLVRCeFpBTTSUujnFRZWYuyxRrpVc12916/zFVCDV+1LobBeAg4FrdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyxu5QM96OjDgKum/dm9tCNOYxNb0Ok4QEvkC5omJYc=;
 b=lM3QB0l/65VTUhXUlrVeoROpw7UexriBlKfJbkXoxEixmVQHB2Om/sHFaXvLpgtvicdw00/ESmAxR0NSpnWBgTgv0Ka7ABcR+xfiGBFoKXMLibcXTwBTiIuar2WroKTWKuZh8kj4u8TYgN7GtzUvqn5yvLZqK5DMTx4MaLWoS+A=
Authentication-Results: baikalelectronics.ru; dkim=none (message not signed)
 header.d=none;baikalelectronics.ru; dmarc=none action=none
 header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4473.eurprd02.prod.outlook.com (2603:10a6:10:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Thu, 2 Jul
 2020 11:36:05 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::ccd1:96b3:48dc:c5d1%7]) with mapi id 15.20.3131.030; Thu, 2 Jul 2020
 11:36:05 +0000
Subject: Re: [PATCH v3 4/8] mux: sparx5: Add Sparx5 SPI mux driver
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
 <20200702101331.26375-5-lars.povlsen@microchip.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <99d9c814-24e2-b3a3-bf0f-765ee51df558@axentia.se>
Date:   Thu, 2 Jul 2020 13:36:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200702101331.26375-5-lars.povlsen@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::22) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0502CA0012.eurprd05.prod.outlook.com (2603:10a6:3:e3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 11:36:04 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c35e6624-beaf-4438-bb72-08d81e7c1b1c
X-MS-TrafficTypeDiagnostic: DB7PR02MB4473:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4473ED4CB93119522BDD329FBC6D0@DB7PR02MB4473.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYm3jthk/1qD5EfUXwq5GzfRfbraasmUef6Y4a9crAOslNzaplN1H+ihlTV3sBXTI+bNIEKAp23mQ9LtfTSU3n7fNvkXR9Jk4d2X8HPn7rj5wMp8NjzqUf1gnobs3NE6wMfp4er4FSm0g3clSrUDj3+p/GNXpDXwYcgJXQeWJBwBtge6vjMzvRk8ITFSyZ+ByikPFhozCCiDGrY1p/zaWeG7wUhDINDeiGnEppAi1LiJi/WQAiXMYaK1Ed/3vdiTNZSwtzhnJSccfqnm9xnkAVUgCGxBOILV66tBu+aPmb30nxxxKiTA41eLRPjuZLJo+ssz4gSr8Ics9ZeQyxrjEbFKNmNfpT11C/z0wX2b4G0XD4KGO6SkvpfszFYbs2Xh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(8676002)(31686004)(4326008)(956004)(2616005)(36916002)(52116002)(54906003)(16526019)(16576012)(36756003)(8936002)(6486002)(186003)(31696002)(508600001)(110136005)(26005)(66556008)(5660300002)(66476007)(86362001)(83380400001)(2906002)(53546011)(316002)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: y5Q5EUmJGp7LMNgGEwO5GZCetLysqUJK3z1xn4YNV7Re6GZYsLx2NL77neFozUubmSJUwh7dF6loB2LXkBWwT2gkHKoOF46V+Y40LDI0epKNgDpYVaMqPOlCQeD/DN8jXGDu1FJBUMs+rHQQBCapWdcQpGopqYpVPVs2PJ1F1tFWnmoDs9VA8G3Fnth7fKWET1HqIuhyCRzQNMMmvjAp6WbDnnfP1hQp2uZUTHc5LcLTKscIVm2EpMWsmshhMxe/jFDyR36A3XQeCN1w7oOpLTMU7j4yv3CzWOWNUk323fOH4u21Kl5iedYqM2z8uR8fxSTs19L6mQT4rxDcq2lRjwhUGqpOcUDizhTudAF5o9BWVP3iCr8KKHDX9jxUfltO0zXp9hPDgeIQfxRFQd84yBgne8jjisHrGQjyF8xd4/zRVMpjxj0jgzcsTKXdaJaPrP6tCXrLA3s8h3JpM3ANtYbAMfN3xu0+oUTgFBZTQuM=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c35e6624-beaf-4438-bb72-08d81e7c1b1c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 11:36:05.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMNluxAj7xZx4bQdC5GmWZG4cS7a+n/T3cC83lThX9B6w85ChxiBOHilQXoFPbd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4473
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On 2020-07-02 12:13, Lars Povlsen wrote:
> The Sparx5 mux driver may be used to control selecting between two
> alternate SPI bus segments connected to the SPI controller
> (spi-dw-mmio).
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  drivers/mux/Makefile     |   2 +
>  drivers/mux/sparx5-spi.c | 138 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 drivers/mux/sparx5-spi.c
> 
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index 6e9fa47daf566..18c3ae3582ece 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -8,9 +8,11 @@ mux-adg792a-objs		:= adg792a.o
>  mux-adgs1408-objs		:= adgs1408.o
>  mux-gpio-objs			:= gpio.o
>  mux-mmio-objs			:= mmio.o
> +mux-sparx5-objs			:= sparx5-spi.o
>  
>  obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
>  obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>  obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
> +obj-$(CONFIG_SPI_DW_MMIO)	+= mux-sparx5.o
> diff --git a/drivers/mux/sparx5-spi.c b/drivers/mux/sparx5-spi.c
> new file mode 100644
> index 0000000000000..5fe9025b96a5e
> --- /dev/null
> +++ b/drivers/mux/sparx5-spi.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sparx5 SPI MUX driver
> + *
> + * Copyright (c) 2019 Microsemi Corporation
> + *
> + * Author: Lars Povlsen <lars.povlsen@microchip.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/mux/driver.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/mux/driver.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +
> +#define MSCC_IF_SI_OWNER_SISL			0
> +#define MSCC_IF_SI_OWNER_SIBM			1
> +#define MSCC_IF_SI_OWNER_SIMC			2
> +
> +#define SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x88
> +#define SPARX5_IF_SI_OWNER			GENMASK(7, 6)
> +#define SPARX5_IF_SI2_OWNER			GENMASK(5, 4)
> +
> +#define SPARX5_MAX_CS	16
> +
> +struct mux_sparx5 {
> +	struct regmap *syscon;
> +	u8 bus[SPARX5_MAX_CS];
> +	int cur_bus;

Surplus unused variable?

> +};
> +
> +/*
> + * Set the owner of the SPI interfaces
> + */
> +static void mux_sparx5_set_owner(struct regmap *syscon,
> +				 u8 owner, u8 owner2)
> +{
> +	u32 val, msk;
> +
> +	val = FIELD_PREP(SPARX5_IF_SI_OWNER, owner) |
> +		FIELD_PREP(SPARX5_IF_SI2_OWNER, owner2);
> +	msk = SPARX5_IF_SI_OWNER | SPARX5_IF_SI2_OWNER;
> +	regmap_update_bits(syscon,
> +			   SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL,
> +			   msk, val);
> +}
> +
> +static void mux_sparx5_set_cs_owner(struct mux_sparx5 *mux_sparx5,
> +				    u8 cs, u8 owner)
> +{
> +	u8 other = (owner == MSCC_IF_SI_OWNER_SIBM ?
> +		    MSCC_IF_SI_OWNER_SIMC : MSCC_IF_SI_OWNER_SIBM);

Empty line missing here.

> +	if (mux_sparx5->bus[cs])
> +		/* SPI2 */
> +		mux_sparx5_set_owner(mux_sparx5->syscon, other, owner);
> +	else
> +		/* SPI1 */
> +		mux_sparx5_set_owner(mux_sparx5->syscon, owner, other);
> +}


This smells like there are only two states for this mux control, and that
the whole point of this driver is to make the exact numbering selectable.
I don't see the point of that. To me, it looks like the pre-existing
mmio-mux should be able to work. Something like this? Untested of course,
and I might easily have misunderstood something...

mux: mux-controller {
	compatible = "mmio-mux"
	#mux-control-cells = <1>;

	/* SI_OWNER and SI2_OWNER in GENERAL_CTRL */
	mux-reg-masks = <0x88 0xf0>;
};


spi0: spi@600104000 {
	compatible = "microchip,sparx5-spi";
	spi@0 {
		compatible = "spi-mux";
		mux-controls = <&mux 0>;
		reg = <0>;
		/* SI_OWNER = SIMC, SI2_OWNER = SIBM  --->  mux value 9 */
		spi-flash@9 {
			compatible = "jedec,spi-nor";
			reg = <9>;
		};
	};
	spi@e {
		compatible = "spi-mux";
		mux-controls = <&mux 0>;
		reg = <14>;
		/* SI_OWNER = SIBM, SI2_OWNER = SIMC  --->  mux value 6 */
		spi-flash@6 {
			compatible = "spi-nand";
			reg = <6>;
		};
	};
};

> +
> +static int mux_sparx5_set(struct mux_control *mux, int state)
> +{
> +	struct mux_sparx5 *mux_sparx5 = mux_chip_priv(mux->chip);
> +
> +	mux_sparx5_set_cs_owner(mux_sparx5, state, MSCC_IF_SI_OWNER_SIMC);
> +
> +	return 0;
> +}
> +
> +static const struct mux_control_ops mux_sparx5_ops = {
> +	.set = mux_sparx5_set,
> +};
> +
> +static const struct of_device_id mux_sparx5_dt_ids[] = {
> +	{ .compatible = "microchip,sparx5-spi-mux", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mux_sparx5_dt_ids);
> +
> +static int mux_sparx5_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mux_chip *mux_chip;
> +	struct mux_sparx5 *mux_sparx5;
> +	struct device_node *nc;
> +	const char *syscon_name = "microchip,sparx5-cpu-syscon";
> +	int ret;
> +
> +	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_sparx5));
> +	if (IS_ERR(mux_chip))
> +		return PTR_ERR(mux_chip);
> +
> +	mux_sparx5 = mux_chip_priv(mux_chip);
> +	mux_chip->ops = &mux_sparx5_ops;
> +
> +	mux_sparx5->syscon =
> +		syscon_regmap_lookup_by_compatible(syscon_name);
> +	if (IS_ERR(mux_sparx5->syscon)) {
> +		dev_err(dev, "No syscon map %s\n", syscon_name);
> +		return PTR_ERR(mux_sparx5->syscon);
> +	}
> +
> +	/* Get bus interface mapping */
> +	for_each_available_child_of_node(dev->of_node, nc) {
> +		u32 cs, bus;
> +
> +		if (of_property_read_u32(nc, "reg", &cs) == 0 &&
> +		    cs < SPARX5_MAX_CS &&
> +		    of_property_read_u32(nc, "microchip,bus-interface",
> +					 &bus) == 0)
> +			mux_sparx5->bus[cs] = bus;

The above if is a mess. The kernel model is to handle the exceptional cases
first and break/goto/continue/return/whatever so that the interesting code
can happen at lower indentation level.

		if (of_property_read_u32(nc, "reg", &cs))
			continue;
		if (cs >= SPARX5_MAX_CS)
			continue;
		if (of_property_read_u32(nc, "microchip,bus-interface", &bus))
			continue;

		mux_sparc5->bus[cs] = bus;

Cheers,
Peter

> +	}
> +
> +	mux_chip->mux->states = SPARX5_MAX_CS;
> +
> +	ret = devm_mux_chip_register(dev, mux_chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_info(dev, "%u-way mux-controller registered\n",
> +		 mux_chip->mux->states);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mux_sparx5_driver = {
> +	.driver = {
> +		.name = "sparx5-mux",
> +		.of_match_table	= of_match_ptr(mux_sparx5_dt_ids),
> +	},
> +	.probe = mux_sparx5_probe,
> +};
> +module_platform_driver(mux_sparx5_driver);
> 
