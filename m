Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A041F937
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhJBBj1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 21:39:27 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:5386
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230255AbhJBBj1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 1 Oct 2021 21:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9/zVNBdr65pWupbdT2BEHjmi2f4+3FwtaeaJKHkHnCGzMUDfWOMzFOo888+/Ml+3zfJijXQeThidd9Y2bTZ52ST72nsp+tqUtm0aEkKynmwf5CYjgHv7xlqIglflLSkU71jOcGszyrgzXFNsV6oy4TVNrbE5PsErJseo0xspnpO41JXpbXwLnbPB45KpaJTkwJ2sCO6pUq40gs4pymbhZhxbs7aMzAhVFT3Yn72pdiBKK2Q5VeKpoYqMrygNDUY8pyy/yZKv/C1ASmzBVHLj3qvxV8qTsMzXunLag0GLVyF/2Jti4BswEnCPORuOfGLsWEVW1+wIJ5y/dhusqcFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjnb0cv0ExgEWRNlhIH8bF9xZ8qV1ec5x8zYMfSe2MI=;
 b=d/G/xjWfEmtChI09V9x0/25KechWRbMxTJ+Et3DDUWjFboQf1hzwkO/EuDBvsFhXlbQSGQ++5wwe4e67rbnJztIVcuHTSybIycsLAqJHjF2eNbvrV02puR4a4k/HhFTwpuY+rlxz1eTRWiBXpRuY/UM1gEGwOsDKFxHMN5oq/yk7MlDz2LJK3aVVfWAFNiBhOZ5wMZ1c0Z4Jw9Y+B5keT3ZEjGmLroSToh3HC3iHk52rpiLEyoAlwbL6u9mLydMjfhNorN0hNGVKuW58i3xizeMEtbx8cPON2KUCaEoyhXZ9JXLzDVK1fFBk4GiN3rX9sCgQ0RocNtOLY+p1O0PubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjnb0cv0ExgEWRNlhIH8bF9xZ8qV1ec5x8zYMfSe2MI=;
 b=hyDh2z2cCoBrIWfkBZFpoO1rB1MTdHw4gV8aJPVdwrBuwewnseAT+LQW1UP/FtK5wACRriFW+57KtwdnGKDPL3EludfwXX+6JJ/dJQUdiwsKqKTYlLh95fZWMxk/Q/Fs8n6E9N5Z8pAACMDMIhobTTGncesU8EtC7ftLKhZDqpY=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Sat, 2 Oct
 2021 01:37:38 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::e157:3280:7bc3:18c4]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::e157:3280:7bc3:18c4%5]) with mapi id 15.20.4566.019; Sat, 2 Oct 2021
 01:37:38 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name
 erratum workaround
Thread-Topic: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name
 erratum workaround
Thread-Index: AQHXtwso2m8Esg1oVE6VXXAu/eOY4qu+7hKA
Date:   Sat, 2 Oct 2021 01:37:38 +0000
Message-ID: <20211002013737.hpalogc72umopz4x@skbuf>
References: <20211001212726.159437-1-michael@walle.cc>
In-Reply-To: <20211001212726.159437-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d723fae-07db-4230-5467-08d9854537ed
x-ms-traffictypediagnostic: VE1PR04MB6509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6509F7FC8CF4193464D8CB3CE0AC9@VE1PR04MB6509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vE17QgDdNvH3vCwTRoXhMtY4HzX1i3jG2mnT7yN90IMt64XGFXZ3o9m8RjsnmWfNRW8xgzAalLGiAr05mzFyx8VdxuXLzRxQp9Sh9FViAaeXweojHLhN+BL7ZAkDn4CfVX+GYO7Q2f5/ZM8s0t5EEgLVCxd1IYaBZmxSZF8jmi0+mPBj5R9Z2KwBfxekyK4/ZJTYz6IGGZNyxaEqgMtoXeJZHTsbfci1RkoAzdiLc3k487egfsmw1QUxd5dQpsUwnGf3NnaWsKazks3niXMbM5nR0+GH6/Hbf5je4HqQ/pV0NDgbqQHJXUqhE6p+0YYw+P0spunNDvh81UDv+3wXEB9AoJD/BHrFlLBIR0lb0GkHrsvYGxZRQWzk5fWgJWlPFvheYy8t92ocAeMrywI6BXG1HKZgIij0zxNqf5EZBWt7c7Pw8AHZcaxc7JUO5AJPAXNt+g3iK8lAiWBq/NNje3Iy/1gz/GMEaMxL20IEWhzwRuY/YN2V9GILj+bF5C9Zmpn6lEa3jszEBZAiqCMVl1AjgxtvJJzp9f8tpQ5X1vP4NHSiZyuM+HQWjDb5wsfEtWJUwl8rSEdgnvFDKizY6mylWwVJSFbsEPDY0hDaIktUvAM031r8iCmU+ckCNjRxCxY1JxtMbWQ0MgofXpyoUMJ98teyg2w5bJZ0OqwXnh07Kc1FHvdW26RCVOp3OwQTqS4TB3+1ofIyb1nnHPmMMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(86362001)(6506007)(91956017)(76116006)(66446008)(64756008)(66556008)(38070700005)(44832011)(4326008)(8936002)(5660300002)(83380400001)(9686003)(6512007)(66946007)(26005)(6916009)(66476007)(186003)(316002)(122000001)(508600001)(71200400001)(33716001)(54906003)(8676002)(2906002)(38100700002)(6486002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QYSeHyBCGgbfzbZ4D37jRHG+P75DHFlN6F/T8sBGy1iBrxMi+LKXo2FLn41b?=
 =?us-ascii?Q?d7nfqE2lRNF60iw/uhYHnBxfiugt16eAgDdvxn8IXrysgatekDxv6wMLzbfB?=
 =?us-ascii?Q?578nUWUvC5AyCrQ5HcMpl4av714pKfQHh9WvUmtd5BJgJcxMH95x+LNjIJqG?=
 =?us-ascii?Q?9S7cK8JqV6HSp/xs8gbc1xg0px/rBqPZOZaO6iJwxbdQr399TuXz2z8VcKwy?=
 =?us-ascii?Q?kt7urfGeaHdPh/WWgOu/Z+0f3m+NJ4EwnN66n9JAp/F+TLIt+mljn37e83Gl?=
 =?us-ascii?Q?pxC0Vc4Cx52dlBixho1p1eeItgXeD2RltFpHMs2KVM/xte1KTVsu8DluqSqs?=
 =?us-ascii?Q?40GuZtBp5NTCnJDMiBJCh3kGtmrru/Jn+mc2T/hP/wXBPNjkRuEpMrw0AEsV?=
 =?us-ascii?Q?RCIhTd2DiPRwXlnMyyh+y6oOrzbxx2AmikzIEkBLYy9aczj2ACc21ApBEeIe?=
 =?us-ascii?Q?vs+Cu7mzW3+wPy2fNlqE7esjy9N3IMpQrlpho9J3Mu17RhlHHBOfMzdXtDD3?=
 =?us-ascii?Q?5FgoVbxrg07TiIXdLRPDAJojXAF/GSTh3RVU1sonVRu+T1tudnIuJOtOpzGK?=
 =?us-ascii?Q?5yhmIMprWKRJkRBSuO31EAkowzU9nDw8hIVRSw/4Kw4VKzVNigzzEjJSSzFu?=
 =?us-ascii?Q?RQ8fYcwcCrfDOChye90V3W0EOlxTnQ0t118vHsKLR9reQtjkZG/nkc1n59J9?=
 =?us-ascii?Q?IMm/fum8ui4sOERu0hTNNq1AW8DsvNi9UDiDC7/u8h91hDeGT4zg8aVkVso3?=
 =?us-ascii?Q?OolmZjRUgNbMF+7aNv6wPVoUIAVeJVMmMxDejpjuedd871GichlGsg89Akcb?=
 =?us-ascii?Q?8cDJUcfrAwjOn+g9tG5fJ786HfXuj+0a6e3hFoYRictqAHbVzQ+6mW37qaqF?=
 =?us-ascii?Q?C7KOqMttO/Krf/ewvrSexzraASsN+xkeeYdugi9TywaMyoiAWi+PFFLY9Ahf?=
 =?us-ascii?Q?4KowXAzOKGv1GJLhUCfaeiglJ5YFyA6M/G6EAUa1QXNgXYrYkjTcetb9hFXf?=
 =?us-ascii?Q?hOzi4md4zHCEYMiatNsVOM7URwRDtpJcQoYtAMsP64pXqxyqwq0csaAS4k/W?=
 =?us-ascii?Q?6pSsr/Z1YzhVuD8/UDH60mU1u436+7GCVA8vL1yYY+C4b+P6pBiARdcH1/Hj?=
 =?us-ascii?Q?JY64SC0CDTDZ/ZKJmBBSD638fGEaxAyHdXFKivvv6tlq4ucyphOQNx14oR/G?=
 =?us-ascii?Q?W7J8rREeouaC74UYShQbsn98piqORUOlZOD5/HQqm33yUKMQfna4+HFXxTD3?=
 =?us-ascii?Q?V7iF7yss8dX8S9SiO1kA+d4oCJwWKAJXlCsN6dEd9hWHVyKSKQGkNbpUU/ON?=
 =?us-ascii?Q?ZUCDz3tC8UASW6IS/AFoHcumt3ntBUNsEL05uWkj782jag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEA4DD3F0A5854419EE5BA6A00224721@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d723fae-07db-4230-5467-08d9854537ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 01:37:38.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TX3V1TEAtrhGJsuXbA6DIc0Wacwe5+oBGBYN7uPirI4glKJptnVSe+gDyty7QZnkuxrOZ/+q7dACKdxWHznG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 01, 2021 at 11:27:26PM +0200, Michael Walle wrote:
> In commit 7e71b85473f8 ("arm64: dts: ls1028a: fix node name for the
> sysclk") the sysclk node name was renamed and broke the erratum
> workaround because it tries to fetch a device tree node by its name,
> which is very fragile in general.

It seems to me that the honest approach for the patch that got broken
would have been to add a separate "nxp,ls1028a-fspi" compatible string
instead of keeping banging "nxp,lx2160a-fspi", and for this special
compatible string, require the platform PLL as a clock provider, and use
clk_get() and clk_get_rate().

> We don't even need the sysclk node because the only possible sysclk
> frequency input is 100MHz.

True. In the RCW, every SYSCLK_FREQ value except 0b1001011000 - 100 MHz
is reserved.

That goes to show how shallow my patch which broke this ERR workaround
was. The sysclk frequency in the device tree was 100 MHz before _and_
after the U-Boot "fixup", but the warning message was just annoying me.

> In fact, the erratum says it applies if SYS_PLL_RAT is 3, not that the
> platform clock is 300 MHz.

Correct, although one implies the other.
And probably the platform clock does not matter either, just the clock
that the block gets, which just "happens" to be platform clock / 2.
Anyway.

> Make the workaround more reliable and just drop the unneeded sysclk
> lookup.
>=20
> For reference, the error during the bootup is the following:
> [    4.898400] nxp-fspi 20c0000.spi: Errata cannot be executed. Read via =
IP bus may not work

Well, in Kuldeep's defence, at least this part is sane, right? I mean we
cannot prove an issue =3D> we don't disable reads via the AHB. So it's
just the error message (which I didn't notice TBH, sorry).

On the other hand, is anyone using LS1028A with a platform clock of 300 MHz=
? :)

> Fixes: 82ce7d0e74b6 ("spi: spi-nxp-fspi: Implement errata workaround for =
LS1028A")
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/spi/spi-nxp-fspi.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index a66fa97046ee..2b0301fc971c 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -33,6 +33,7 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> @@ -315,6 +316,7 @@
>  #define NXP_FSPI_MIN_IOMAP	SZ_4M
> =20
>  #define DCFG_RCWSR1		0x100
> +#define SYS_PLL_RAT		GENMASK(6, 2)

Ugh. So your solution still makes a raw read of the platform PLL value
from the DCFG, now it just adds a nice definition for it. Not nice.

> =20
>  /* Access flash memory using IP bus only */
>  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> @@ -926,9 +928,8 @@ static void erratum_err050568(struct nxp_fspi *f)
>  		{ .family =3D "QorIQ LS1028A" },
>  		{ /* sentinel */ }
>  	};
> -	struct device_node *np;
>  	struct regmap *map;
> -	u32 val =3D 0, sysclk =3D 0;
> +	u32 val, sys_pll_ratio;
>  	int ret;
> =20
>  	/* Check for LS1028A family */
> @@ -937,7 +938,6 @@ static void erratum_err050568(struct nxp_fspi *f)
>  		return;
>  	}
> =20
> -	/* Compute system clock frequency multiplier ratio */
>  	map =3D syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
>  	if (IS_ERR(map)) {
>  		dev_err(f->dev, "No syscon regmap\n");
> @@ -948,23 +948,11 @@ static void erratum_err050568(struct nxp_fspi *f)
>  	if (ret < 0)
>  		goto err;
> =20
> -	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier ratio */
> -	val =3D (val >> 2) & 0x1F;
> -	WARN(val =3D=3D 0, "Strapping is zero: Cannot determine ratio");
> +	sys_pll_ratio =3D FIELD_GET(SYS_PLL_RAT, val);
> +	dev_dbg(f->dev, "val: 0x%08x, sys_pll_ratio: %d\n", val, sys_pll_ratio)=
;

Do we really feel that this dev_dbg is valuable?

> =20
> -	/* Compute system clock frequency */
> -	np =3D of_find_node_by_name(NULL, "clock-sysclk");
> -	if (!np)
> -		goto err;
> -
> -	if (of_property_read_u32(np, "clock-frequency", &sysclk))
> -		goto err;
> -
> -	sysclk =3D (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
> -	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
> -
> -	/* Use IP bus only if PLL is 300MHz */
> -	if (sysclk =3D=3D 300)
> +	/* Use IP bus only if platform clock is 300MHz */
> +	if (sys_pll_ratio =3D=3D 3)
>  		f->devtype_data->quirks |=3D FSPI_QUIRK_USE_IP_ONLY;
> =20
>  	return;
> --=20
> 2.30.2
>=20

How about:

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1028a.dtsi
index 343ecf0e8973..ffe820c22719 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -326,15 +326,17 @@ i2c7: i2c@2070000 {
 		};
=20
 		fspi: spi@20c0000 {
-			compatible =3D "nxp,lx2160a-fspi";
+			compatible =3D "nxp,ls1028a-fspi";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0x0 0x20c0000 0x0 0x10000>,
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names =3D "fspi_base", "fspi_mmap";
 			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&fspi_clk>, <&fspi_clk>;
-			clock-names =3D "fspi_en", "fspi";
+			clocks =3D <&fspi_clk>, <&fspi_clk>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
+			clock-names =3D "fspi_en", "fspi", "base";
 			status =3D "disabled";
 		};
=20
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a66fa97046ee..f2815e6cae2c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -314,8 +314,6 @@
 #define NXP_FSPI_MAX_CHIPSELECT		4
 #define NXP_FSPI_MIN_IOMAP	SZ_4M
=20
-#define DCFG_RCWSR1		0x100
-
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
=20
@@ -922,55 +920,18 @@ static int nxp_fspi_adjust_op_size(struct spi_mem *me=
m, struct spi_mem_op *op)
=20
 static void erratum_err050568(struct nxp_fspi *f)
 {
-	const struct soc_device_attribute ls1028a_soc_attr[] =3D {
-		{ .family =3D "QorIQ LS1028A" },
-		{ /* sentinel */ }
-	};
-	struct device_node *np;
-	struct regmap *map;
-	u32 val =3D 0, sysclk =3D 0;
-	int ret;
+	struct clk *clk_base;
=20
-	/* Check for LS1028A family */
-	if (!soc_device_match(ls1028a_soc_attr)) {
-		dev_dbg(f->dev, "Errata applicable only for LS1028A\n");
+	clk_base =3D clk_get(f->dev, "base");
+	if (IS_ERR(clk_base)) {
+		dev_err(f->dev, "Errata cannot be executed. Read via IP bus may not work=
\n");
 		return;
 	}
=20
-	/* Compute system clock frequency multiplier ratio */
-	map =3D syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
-	if (IS_ERR(map)) {
-		dev_err(f->dev, "No syscon regmap\n");
-		goto err;
-	}
-
-	ret =3D regmap_read(map, DCFG_RCWSR1, &val);
-	if (ret < 0)
-		goto err;
-
-	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier ratio */
-	val =3D (val >> 2) & 0x1F;
-	WARN(val =3D=3D 0, "Strapping is zero: Cannot determine ratio");
-
-	/* Compute system clock frequency */
-	np =3D of_find_node_by_name(NULL, "clock-sysclk");
-	if (!np)
-		goto err;
-
-	if (of_property_read_u32(np, "clock-frequency", &sysclk))
-		goto err;
-
-	sysclk =3D (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
-	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
-
-	/* Use IP bus only if PLL is 300MHz */
-	if (sysclk =3D=3D 300)
+	/* Use IP bus only if platform PLL is configured for 300 MHz, hence we ge=
t 150 MHz */
+	if (clk_get_rate(clk_base) =3D=3D 150000000)
 		f->devtype_data->quirks |=3D FSPI_QUIRK_USE_IP_ONLY;
-
-	return;
-
-err:
-	dev_err(f->dev, "Errata cannot be executed. Read via IP bus may not work\=
n");
+	clk_put(clk_base);
 }
=20
 static int nxp_fspi_default_setup(struct nxp_fspi *f)
@@ -994,10 +955,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	/*
 	 * ERR050568: Flash access by FlexSPI AHB command may not work with
 	 * platform frequency equal to 300 MHz on LS1028A.
-	 * LS1028A reuses LX2160A compatible entry. Make errata applicable for
-	 * Layerscape LS1028A platform.
 	 */
-	if (of_device_is_compatible(f->dev->of_node, "nxp,lx2160a-fspi"))
+	if (of_device_is_compatible(f->dev->of_node, "nxp,ls1028a-fspi"))
 		erratum_err050568(f);
=20
 	/* Reset the module */=
