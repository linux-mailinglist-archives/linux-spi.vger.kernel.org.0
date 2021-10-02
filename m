Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD15B41FA95
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhJBJYv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Oct 2021 05:24:51 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:53271
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232681AbhJBJYv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 2 Oct 2021 05:24:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEok0HBId5NZiBzEkDgAzmxDdMhDGMJUNWpNrYc3YzfrTebsI3Mh6m1fXNV9PfbkE6z4pSq65YRRreZ0E+IUalL/TeSHXsmXS3uYr/TnyIVDJmj+cqj9MHBxMpReuFV9Wtmlfv/scDcZ/fpYGGyi/6iOpO8sgO/uIEcCek6oyZ8wwT0kc2giBrW5bTp4d7zQv1q8IaDTECtPGAvRgMCJ1ezLUd8aBdS1OS975Ylad0kt99bg+icUkV5NXc0xm4isHY2UUQA3q09z9h8VjvqhglkOAb2GeAWoQqxLX6uKfl8SYwt2DtrudZPKPAe3eu1C8dtcrkknnuE2ukxBC/wrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCb/F5FxbaV3gspPt//KpkAqqlNfE0WMi7efm8kDFmg=;
 b=j8bn7Jpq86Us/cFVkxuNy+bgN3OL2ScjW56jXdgr3la44oibUr3WAC3vp3PioxIuSqvJ6Mslrou9+KPnHmGq9QQOUja7dsWtt0NgQ0R5ateNO2/hHssuXjVQAYjwbiZJRc2z7V1jLibbXANmh4UwmxTMpIBsBxQV8xFMILnHX9gmX63JSUc12GsVxee4Zyyf9ElufZfgROPDPHxf2MrMFDHJ7ByS7hZ3/wiZR8eJ+2bAk6T2hxg5ekIBlBXWXYFjUQeV9xShAshsLjX8ULOanDBE+TEj1CdGGwBKOSTazSiwZUHGLvoVsf6nNZ/jmt92BNGgdurCmilzBt3Hvav80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCb/F5FxbaV3gspPt//KpkAqqlNfE0WMi7efm8kDFmg=;
 b=VuqEMocqMTG069OBFToXT5BkZuCEf3YwOKmyD9Pb7WsbepNqNAneIVThzWTwTCeTksDdWuCKOKDfLTh7ntyEn41DuKj4UK9tQ+6IzY2DdLgzLWD053w2byB1YuKxn8d37uS5uPfHJl0zjbbhZ3e6ehM2DyyEiMURKZREmdBAqw0=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB4685.eurprd04.prod.outlook.com (2603:10a6:803:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Sat, 2 Oct
 2021 09:23:03 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::e157:3280:7bc3:18c4]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::e157:3280:7bc3:18c4%5]) with mapi id 15.20.4566.021; Sat, 2 Oct 2021
 09:23:02 +0000
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
Thread-Index: AQHXtwso2m8Esg1oVE6VXXAu/eOY4qu+7hKAgAB7MICAAAbYgA==
Date:   Sat, 2 Oct 2021 09:23:02 +0000
Message-ID: <20211002092301.ue77mzzwcel76umx@skbuf>
References: <20211001212726.159437-1-michael@walle.cc>
 <20211002013737.hpalogc72umopz4x@skbuf>
 <c5a67c34af869fd93d34320ef181c682@walle.cc>
In-Reply-To: <c5a67c34af869fd93d34320ef181c682@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d768eb-a2ca-4ea3-2960-08d985863c05
x-ms-traffictypediagnostic: VI1PR04MB4685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4685140CDEC3B1754918BE68E0AC9@VI1PR04MB4685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaWfcpHtuLv4Fec/NMDedHkVk1zXPJQLsFmxkwuCjxklsekwZ/BPAh3XwspiMygOz0IE24uYYRlex+CJj7O0kxbv14o/TPEWcZZXB/sUv2o07ugnExqQhYlKICoPsszEmMC/WSzzTvqW9/d67c4r8X9+YrmIeMkzU7vYTnEg8u9Vzq56w210J/UouawWguFGme6hvf08b4G/Oe7ynYxXy9T8+Rs8k42TxWBWK8eHnEu0RgxjzVjQL4BwRyeggEeIgK6T/URhQqkQDdEQeyo/7zDyKQTlMIoPbG8dqJhk+2M3X5raD1FnOvWDWqpTNiHJK7IynUYCvoK5D1yKuJntZG79+MEEwjZJaKOVCAJrZ4HoKpSZvN76enCqDp9rSfCQx18rBeabmysR+jactMe4z1R84r5H/4DO9QwU6Y2q+5nVlJZ5KIk8VEnUyBSlHjmx2cT+IIWTjzXXqN9PbWdoR4yhyDDnVW9AI3rz/n2lNkeFbJrG68lXjR3aarzi1KVpnHU6yctm/wPoTvMyJNm5DRLoTVe9016GndGOB4Cr1QevSi8P2woC4DBXF8XuPBgyK04ychVDJZocv/ObvQFRTPUZCYdyrBSyxRvssjykbR+EYyzRM+hbljGNhVbzB1bzzPAKnOMq+ppD7L8Mq2oiZhHNqB2ajk0H2J5WE8LXzU9xApYFdonGFYuABxjD3r90jRgxhG3K47YoBDvD6q8aPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(122000001)(5660300002)(6486002)(54906003)(316002)(9686003)(6512007)(44832011)(1076003)(86362001)(2906002)(4326008)(186003)(508600001)(26005)(38100700002)(6916009)(91956017)(6506007)(33716001)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(8676002)(83380400001)(8936002)(71200400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7c0vxF4T7hIEcDq/5Z7W4hONll6rneGmmDd7V+Jp9R/7/VjJFjmvyzKjUQWC?=
 =?us-ascii?Q?GJq5Z5BMH4u7TH39WVCyxgmgBrpJtARvOmHsFsIJp5LMxpxnxg/vgeW2Ui5t?=
 =?us-ascii?Q?Gyl1qbOWbzWmh65INHtBEBnC7tDxCvLAxO2xpodk0lS6YxpSBB5lJ+y2yTr5?=
 =?us-ascii?Q?yS7tQ16VXKXK5O92YVYKZDOMfB5TNepSJ8CBRLvOVsfohycUsRP3vwK2Mma2?=
 =?us-ascii?Q?I17SXeNfFhjJItz7JW/saZseeytwwKlAd9mZkXl4PNfTQMkEnXZe20Z8Ptlf?=
 =?us-ascii?Q?f46E3CVsS9ryaVX9u+vUVH9b/J//uljswyJMM9TsqLzusCgyYZZRgds0Lcvo?=
 =?us-ascii?Q?nrRbgyo6lQHQr8daZSrqXiMXe92Ps/3DvIWzaHePiz/q6oTwqULhfL/658p7?=
 =?us-ascii?Q?BrGTz6TDeoJbYpvGhH+1EnKX8c28qpWLWuagwwLFn1JJ7pqp6cO5s6nb+DFy?=
 =?us-ascii?Q?UsakaecdAkRbrJudOWDoUj/sPMkAxSRTtRsUdl/NrkgFjjzs61zhbb8ss20t?=
 =?us-ascii?Q?dnQlinDt6DxnIYB0xPSHd3rTV6lc/zSlz8IX2HhrqPXgp60eAdPn0IQOIyt0?=
 =?us-ascii?Q?DOglCk7rIJlM84v01GAM0WgM0c5hFYeWdxqUbN68fBW15hCM49njAQOZOjh/?=
 =?us-ascii?Q?19NizMCO9z50fojKLVSHLN9ZehkK2yiXcJJ2piHBbJGAzIEAGIcTobsm1hys?=
 =?us-ascii?Q?1M/zVLrpl7QJ9Xii+zQN5S9Zzi6JbXd1ZNj8ezXr+eAOUNAG0TJCGeAzYkxW?=
 =?us-ascii?Q?IN7+KnOBtXHNzS1hBbwhfxHBLynBLrOC9qLcZMs85Yh4Qe0Gzryi8s6Cx0SI?=
 =?us-ascii?Q?k63KkpmLSJ4nwvDSkG+L0PaDpaL4nNNf5YMRi3ANgF7sVr+j3l6VW9pg4gSv?=
 =?us-ascii?Q?m0mjgADSZi+IEtejErOHQr01ZTSQFrsBTQrJqceBRxIUFYZHORgvVvXMBw3c?=
 =?us-ascii?Q?XHyg0GWR+ActkvVhyhG1tlGffce8cC4Yk3m4f84s4OULJIU61AZSDI1cVVTc?=
 =?us-ascii?Q?1g4Uz2637j9QE4vmlSzNghInD+yPiorCcnpVoHhqORvYI5xnQxKeWtbjRiKv?=
 =?us-ascii?Q?Nr3OOOghg6dX5TBgg98TbpLGpW/J5KKahmRFoo/o2XGbyy57gxOhmES0l17l?=
 =?us-ascii?Q?GL2Mx48ETKbDEgItqJXupKmEnP3WAQsKqRX4CmM/oZywy9hzPOjtIdzK4YD0?=
 =?us-ascii?Q?o/wEzE5lGNgZtIU9VLLy679DlCqfhkwwqdpa+rW7AQ4gJPMCmlySFlJSNiV2?=
 =?us-ascii?Q?hEkAbnuD0e+qrir+JEx/yT9hHKcy/m4zjIKhLKzSz8hao1ArPaCefZxn9NcW?=
 =?us-ascii?Q?toAfXMkIKMVVhCM9gksY1Bz0hvNQ81Ob7OLTO0IvAXD7Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76E33D9A238F9749A25FB84EE1AAC0AF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d768eb-a2ca-4ea3-2960-08d985863c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 09:23:02.6899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+zOHQBG+CTp1YPId3fGui1FwKdxHJAt5MFkCXNTh9cs2uk2TPH8RBG4H1yM0Ef8obbVMjWidQeDjCSHWPZCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4685
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Oct 02, 2021 at 10:58:31AM +0200, Michael Walle wrote:
> Am 2021-10-02 03:37, schrieb Vladimir Oltean:
> > On Fri, Oct 01, 2021 at 11:27:26PM +0200, Michael Walle wrote:
>=20
> > > Make the workaround more reliable and just drop the unneeded sysclk
> > > lookup.
> > >=20
> > > For reference, the error during the bootup is the following:
> > > [    4.898400] nxp-fspi 20c0000.spi: Errata cannot be executed. Read
> > > via IP bus may not work
> >=20
> > Well, in Kuldeep's defence, at least this part is sane, right? I mean w=
e
> > cannot prove an issue =3D> we don't disable reads via the AHB. So it's
> > just the error message (which I didn't notice TBH, sorry).
>=20
> Its just an error message in case the platform clock is 400Mhz. But
> if you have a 300MHz platform clock the workaround wouldn't be applied.

Understood, that's why I asked...

> The reference is just there if someone stumbles over this error and
> searches for it on google.
>=20
> > On the other hand, is anyone using LS1028A with a platform clock of 300
> > MHz? :)

...this.

> > > Fixes: 82ce7d0e74b6 ("spi: spi-nxp-fspi: Implement errata workaround
> > > for LS1028A")
> > > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > >  drivers/spi/spi-nxp-fspi.c | 26 +++++++-------------------
> > >  1 file changed, 7 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > > index a66fa97046ee..2b0301fc971c 100644
> > > --- a/drivers/spi/spi-nxp-fspi.c
> > > +++ b/drivers/spi/spi-nxp-fspi.c
> > > @@ -33,6 +33,7 @@
> > >=20
> > >  #include <linux/acpi.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/bitfield.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/completion.h>
> > >  #include <linux/delay.h>
> > > @@ -315,6 +316,7 @@
> > >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
> > >=20
> > >  #define DCFG_RCWSR1		0x100
> > > +#define SYS_PLL_RAT		GENMASK(6, 2)
> >=20
> > Ugh. So your solution still makes a raw read of the platform PLL value
> > from the DCFG, now it just adds a nice definition for it. Not nice.
>=20
> Keep in mind that this is intended to be a fixes commit. I agree with
> you that having a new clock in the device tree and checking that would
> have been better. Feel free to change the workaround after this fix
> is applied (without a fixes tag), but I don't think introducing a new
> clock (and you forgot to update the bindings) will qualify as a fixes
> commit. Esp. when you change the compatible string.

I think it could be justified as a fixes commit to Shawn Guo - the
LS1028A is not "compatible" with LX2160A in the sense that it has
software-visible errata which LX2160A doesn't have.

> > >  /* Access flash memory using IP bus only */
> > >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> > > @@ -926,9 +928,8 @@ static void erratum_err050568(struct nxp_fspi *f)
> > >  		{ .family =3D "QorIQ LS1028A" },
> > >  		{ /* sentinel */ }
> > >  	};
> > > -	struct device_node *np;
> > >  	struct regmap *map;
> > > -	u32 val =3D 0, sysclk =3D 0;
> > > +	u32 val, sys_pll_ratio;
> > >  	int ret;
> > >=20
> > >  	/* Check for LS1028A family */
> > > @@ -937,7 +938,6 @@ static void erratum_err050568(struct nxp_fspi *f)
> > >  		return;
> > >  	}
> > >=20
> > > -	/* Compute system clock frequency multiplier ratio */
> > >  	map =3D syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
> > >  	if (IS_ERR(map)) {
> > >  		dev_err(f->dev, "No syscon regmap\n");
> > > @@ -948,23 +948,11 @@ static void erratum_err050568(struct nxp_fspi
> > > *f)
> > >  	if (ret < 0)
> > >  		goto err;
> > >=20
> > > -	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier
> > > ratio */
> > > -	val =3D (val >> 2) & 0x1F;
> > > -	WARN(val =3D=3D 0, "Strapping is zero: Cannot determine ratio");
> > > +	sys_pll_ratio =3D FIELD_GET(SYS_PLL_RAT, val);
> > > +	dev_dbg(f->dev, "val: 0x%08x, sys_pll_ratio: %d\n", val,
> > > sys_pll_ratio);
> >=20
> > Do we really feel that this dev_dbg is valuable?
>=20
> No, I just briefly looked at it to see it prints 4 ;)
>=20
> > > -	/* Compute system clock frequency */
> > > -	np =3D of_find_node_by_name(NULL, "clock-sysclk");
> > > -	if (!np)
> > > -		goto err;
> > > -
> > > -	if (of_property_read_u32(np, "clock-frequency", &sysclk))
> > > -		goto err;
> > > -
> > > -	sysclk =3D (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
> > > -	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
> > > -
> > > -	/* Use IP bus only if PLL is 300MHz */
> > > -	if (sysclk =3D=3D 300)
> > > +	/* Use IP bus only if platform clock is 300MHz */
> > > +	if (sys_pll_ratio =3D=3D 3)
> > >  		f->devtype_data->quirks |=3D FSPI_QUIRK_USE_IP_ONLY;
> > >=20
> > >  	return;
> > > --
> > > 2.30.2
> > >=20
> >=20
> > How about:
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 343ecf0e8973..ffe820c22719 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -326,15 +326,17 @@ i2c7: i2c@2070000 {
> >  		};
> >=20
> >  		fspi: spi@20c0000 {
> > -			compatible =3D "nxp,lx2160a-fspi";
> > +			compatible =3D "nxp,ls1028a-fspi";
>=20
> Why not
>   compatible =3D "nxp,ls1028a-fspi", "nxp,lx2160a-fspi";
> to keep at least some compatibility.

Of course that would be even better. I just wanted to rush to get here
before Mark, and it looks like I still didn't make it in time.

Worst case, new (cleaned up to not calculate the platform clock on its own)
driver will still probe with old device tree, but not apply the ERR
workaround for 300 MHz systems.

I may be ignorant here, but I just don't know how many systems use 300
MHz platform in practice. Anyway, it's always difficult to fix up
something that came to depend on DT bindings in a certain way.

> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <0>;
> >  			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> >  			      <0x0 0x20000000 0x0 0x10000000>;
> >  			reg-names =3D "fspi_base", "fspi_mmap";
> >  			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks =3D <&fspi_clk>, <&fspi_clk>;
> > -			clock-names =3D "fspi_en", "fspi";
> > +			clocks =3D <&fspi_clk>, <&fspi_clk>,
> > +				 <&clockgen QORIQ_CLK_PLATFORM_PLL
> > +					    QORIQ_CLK_PLL_DIV(2)>;
> > +			clock-names =3D "fspi_en", "fspi", "base";
> >  			status =3D "disabled";
> >  		};
> >=20
> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index a66fa97046ee..f2815e6cae2c 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -314,8 +314,6 @@
> >  #define NXP_FSPI_MAX_CHIPSELECT		4
> >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
> >=20
> > -#define DCFG_RCWSR1		0x100
> > -
> >  /* Access flash memory using IP bus only */
> >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> >=20
> > @@ -922,55 +920,18 @@ static int nxp_fspi_adjust_op_size(struct
> > spi_mem *mem, struct spi_mem_op *op)
> >=20
> >  static void erratum_err050568(struct nxp_fspi *f)
> >  {
> > -	const struct soc_device_attribute ls1028a_soc_attr[] =3D {
> > -		{ .family =3D "QorIQ LS1028A" },
> > -		{ /* sentinel */ }
> > -	};
>=20
> Mh, I see how you came to the conclusion to rename the compatible
> string. But normally, this also contains a revision check,
> which is missing here IMHO. It might as well be fixed in the
> next revision (though we both know, this is highly unlikely; its
> still wrong). So while you could rename the compatible (oh no!)
> you'd still have to do the rev 1.0 check here.

So you want a compatible string a la "fsl,ls1021a-v1.0-dspi", right?
I don't know, no strong opinion, as you said, we both know that no
LS1028A rev 2 seems to be planned.

> > -	struct device_node *np;
> > -	struct regmap *map;
> > -	u32 val =3D 0, sysclk =3D 0;
> > -	int ret;
> > +	struct clk *clk_base;
> >=20
> > -	/* Check for LS1028A family */
> > -	if (!soc_device_match(ls1028a_soc_attr)) {
> > -		dev_dbg(f->dev, "Errata applicable only for LS1028A\n");
> > +	clk_base =3D clk_get(f->dev, "base");
> > +	if (IS_ERR(clk_base)) {
> > +		dev_err(f->dev, "Errata cannot be executed. Read via IP bus may not
> > work\n");
> >  		return;
> >  	}
> >=20
> > -	/* Compute system clock frequency multiplier ratio */
> > -	map =3D syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
> > -	if (IS_ERR(map)) {
> > -		dev_err(f->dev, "No syscon regmap\n");
> > -		goto err;
> > -	}
> > -
> > -	ret =3D regmap_read(map, DCFG_RCWSR1, &val);
> > -	if (ret < 0)
> > -		goto err;
> > -
> > -	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier ratio *=
/
> > -	val =3D (val >> 2) & 0x1F;
> > -	WARN(val =3D=3D 0, "Strapping is zero: Cannot determine ratio");
> > -
> > -	/* Compute system clock frequency */
> > -	np =3D of_find_node_by_name(NULL, "clock-sysclk");
> > -	if (!np)
> > -		goto err;
> > -
> > -	if (of_property_read_u32(np, "clock-frequency", &sysclk))
> > -		goto err;
> > -
> > -	sysclk =3D (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
> > -	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
> > -
> > -	/* Use IP bus only if PLL is 300MHz */
> > -	if (sysclk =3D=3D 300)
> > +	/* Use IP bus only if platform PLL is configured for 300 MHz, hence
> > we get 150 MHz */
> > +	if (clk_get_rate(clk_base) =3D=3D 150000000)
> >  		f->devtype_data->quirks |=3D FSPI_QUIRK_USE_IP_ONLY;
> > -
> > -	return;
> > -
> > -err:
> > -	dev_err(f->dev, "Errata cannot be executed. Read via IP bus may not
> > work\n");
> > +	clk_put(clk_base);
> >  }
> >=20
> >  static int nxp_fspi_default_setup(struct nxp_fspi *f)
> > @@ -994,10 +955,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi
> > *f)
> >  	/*
> >  	 * ERR050568: Flash access by FlexSPI AHB command may not work with
> >  	 * platform frequency equal to 300 MHz on LS1028A.
> > -	 * LS1028A reuses LX2160A compatible entry. Make errata applicable fo=
r
> > -	 * Layerscape LS1028A platform.
> >  	 */
> > -	if (of_device_is_compatible(f->dev->of_node, "nxp,lx2160a-fspi"))
> > +	if (of_device_is_compatible(f->dev->of_node, "nxp,ls1028a-fspi"))
> >  		erratum_err050568(f);
> >=20
> >  	/* Reset the module */
>=20
> --=20
> -michael=
