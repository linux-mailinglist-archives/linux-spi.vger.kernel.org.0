Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF320420988
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 12:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhJDKyx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 06:54:53 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:60734
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230380AbhJDKyw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Oct 2021 06:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAjheErIMtW82BhTKGCOPifQpfFP+rg+KrqgG87y/q/xI+17AomJGG4NKitlOb1/JaduFiE8SOlyMAPOn5vve96lsH3MT5/8ZNOaK8oSyCK9+6lM6vFlITRDoUfklawEzwe+HB/tsL6c48eiRDmiHd+PVNbLMvKjYjnpTP3ZWDlP3p8ihjxFKjLYV+Ky6GEChno5dKySyh30jtgnljzMwORUBv6Rbitw/wThzjn1Zo/XaFD0fnjpahkIzPzQ9DdSsyNwnGRcP6pzTtb1OnrQ7pnwi7Ce44tI6ri3SmfA4CwpgTrMDpqo8mPxFJgWJgwnhZrfWyRlZlqf2zPzhROHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vwv9p6j1C0wGf++BPBFQNJuhiNFbwHh/KXdbfmWVQ4E=;
 b=lEMpK5iTb+7PmiSk2oIXbohAhE2aBE781O0erwAHAQ4mECGeApPdJXYu9qucAixy7S07pv9OVvPuZ7YWsk3e7ZRPjwV52fepe7EP0WIVHn63tlQkx/87atPhHUd69PM9hgn49QzSSyMc76ueqC3ACtFPV+xzmuUuwwsBj28hC/6A7QOGIaLVVUMLu241RkyHw0a6DHDLlPdkv5eDZheQ0ovG+2QaO154iCsZmyyYGzYc3x5BTzlMQW/fIRIUUnp0lleFmyNexD99MYj7f5NA6CsToJbsT65nr/9phlQ0kGCamT0+8a7bErfGKKrUpHEgRfbUxJZeqU567Hzg+/aRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwv9p6j1C0wGf++BPBFQNJuhiNFbwHh/KXdbfmWVQ4E=;
 b=Mqwx778bwBcaEV+UBgYsYrDzTz7sQzjlzKY02Ehb/Vhh51pe52K39tTC26oPHc/+NOvsaAO2soh8hj9Kpot3m0lGn/XhHAx1RpFTxBVwnS1zNlCrSq13ul4NBvYCTuq8j8TZ45IRxwAJy1S25sHzGNJd1zDYMHJZK/TluTkLVhY=
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 10:53:01 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::d4f7:fe6:3e65:3c55%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:53:01 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name
 erratum workaround
Thread-Topic: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node name
 erratum workaround
Thread-Index: AQHXt28arOP2aB2AkUGBx2yLmX7R+6vCoCAQ
Date:   Mon, 4 Oct 2021 10:53:01 +0000
Message-ID: <AS8PR04MB86736BFE2CEEF2FBEB6D7985E0AE9@AS8PR04MB8673.eurprd04.prod.outlook.com>
References: <20211001212726.159437-1-michael@walle.cc>
 <20211002013737.hpalogc72umopz4x@skbuf>
 <c5a67c34af869fd93d34320ef181c682@walle.cc>
 <20211002092301.ue77mzzwcel76umx@skbuf>
In-Reply-To: <20211002092301.ue77mzzwcel76umx@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e8a6287-4e52-43ce-0cfe-08d987252296
x-ms-traffictypediagnostic: AS8PR04MB8513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8513326B2209BE4FA0F1D3CCE0AE9@AS8PR04MB8513.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyiXZveQBXNgYSaZF4+nmtFopqkmN6JfwupW0v34XW7qZGn3cMBrvKCBEtP10TawhHvKFvkAhgp490Cmn6fWaZXYgOu5WEh0YJyJG4nxrLVKCLRHeVFsUPfsF77PyEch5efbSyUC7C9CuQoat8UPXsF7zxmrMnsRMFz0lWljf3g0kPN0bvE0rLJryAQrkzN3QDLIwbmdeIyb0ndZvH06T7ban2QsqmjNh0l3ODlJn22pYqncv9i4EvjbYzbd0v/I1ZP/4uHuxiB4dxQ2ujon3kY/UR3nMZ6xMMaIHiw5CSEzYVjuUB918yoV83E3nZ+KGB+S/BAJnllY2touO8PgxR4JeOmrZtoR8nAFzMUpKSVq7Ixowf/KXhCUPNXFFP3R2K/3cIPSeTCNyK3wy2Ogx61xqoX1f7qUkpWFkNtoZNOseR5hoUahoWP0K60U5AV5RjYnW6xRr3VZqVp6ohT7j98n1g3es/HYaaGwXaQmoUFbeEwZBzngSm2WKK174WFWJQVKsxLBTJXBfUt4a5RkP0RzRxvT29mwVPvYSmd76N+/tmgDm86HtZJzAWnKkdqcUJ1W4KCcKLNHnRinpF3XxgsUpnwMUZ64e3z4XlY/HKAwgewGnN/Yeit3tZ1dh1wU/bcm/DdoBnAWys4CegCUyibQ/V8Ra9IH4L4R0f0VKz217rywRdZWOk/5f+RhoYk2XiETaIhcqyyCn4XBdCNL1MnU5yRwADXhGBRnTz4Fw7shcjoQciuK9adbe8TYmGZ27quBfX3APIPMRZiEnJYUY53WwAQV2DL1YkI0btxwAig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(55016002)(8676002)(44832011)(8936002)(186003)(7696005)(38100700002)(122000001)(5660300002)(55236004)(53546011)(6506007)(4326008)(9686003)(26005)(30864003)(71200400001)(33656002)(76116006)(966005)(66946007)(508600001)(38070700005)(66556008)(2906002)(52536014)(54906003)(316002)(110136005)(66476007)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KvWAD6WckzB/LsymM95AQUsK/BpU6PqWTzMq5Ny/Jw+0GPuAhVxzUbZ+qtnY?=
 =?us-ascii?Q?amHQwalO/2x+mV5SKPDzy5lJef3llPAtWr3KiTP0Yqn+ndS2FMYX5hyKbXQZ?=
 =?us-ascii?Q?iVcgFu5x1TJCCv0KGzT1aAhMzDzSBmtSxdA+0PJ+uOepHwNXTKRR+yu2EQUa?=
 =?us-ascii?Q?RzNn5rlAfALx84LtOPu9nuf70PGUDE9jZJKAfXFngRnHKLAOQvYWE8bPYE46?=
 =?us-ascii?Q?OYDeGGblRUtoQWJGkz39CQI6pwM/beKsyKXlZom/xQS8mC89xBuPEk3wuQlZ?=
 =?us-ascii?Q?rf5RyGypEP4j0eYp3ZRgFLanUXMm+6k2JLfi04iJromW4YUjG+RXB4tNGtdu?=
 =?us-ascii?Q?y0UjfWQjsx+lcJZ6WjTItnzsxyI8V79CHxMnR4Y7NPZ2WFdC1Sc3ounfTXkB?=
 =?us-ascii?Q?4h1MMdRsrPj1Ol+FIP34zzKPXGsZH9hxqoBWpjgbhH1VDzXjN/4kMNp8m7zc?=
 =?us-ascii?Q?G2Ql7EqUJfQi8Pxz0VKkqHRpiuEw4teRiAgp9yFYf+R/0G4Q/Ov1WAuMCJhi?=
 =?us-ascii?Q?6gGcGxAyrwd2Sqs6HKQMXfTLs12YrvniBdGD5OUYN6qBaQt+waTHXQh+/5GX?=
 =?us-ascii?Q?xcLevHzhp2e+UJlqfO+myuY9cg+Kbj2G7S7CuWzUzhbyLgoFH3k9q6YutTTy?=
 =?us-ascii?Q?3R77BCk9PBBD2SoysO7WJ5BJ0jbxmF833jEV6T7kLMd4BGj/aJWhZZKJBcnL?=
 =?us-ascii?Q?sBZ0MI6QyM7zYEGd2UgbWkdhrwE0jM/Z3fShaibBmOCClsiu5fUt80PrSI1D?=
 =?us-ascii?Q?kCXj2hdPT3099hFajKOcs+Pf5KK2ZP9jfkjkavJHAmbhfQbYZWqMLKu0x2PS?=
 =?us-ascii?Q?bA7een1tv6iL5/s6SU6rO/9D0VmK9p5qshLttn2yV1a047Giwa/63cJF49wm?=
 =?us-ascii?Q?8NngQZRdgxEytLaLDZ44km92Z+dxzKeUAt4m5m4/b+uDYT+wR4W4+ln18V7R?=
 =?us-ascii?Q?mPwDMVIzNgYJF6QHKiUnJJxokC48Zsx3PEWSvrS1lu7Ibc7ACd9aPeW5cFrM?=
 =?us-ascii?Q?XhqkUbTjcU4ug+E2sCCDjU4G9shU/HKZeGVII3dQp30iwt8QiGbYz70oh+I9?=
 =?us-ascii?Q?KPZW7r9IzpUbCGkJrOIcRzQl6kAc9sFOyT74Mwj2RLSWUbQPOG1X4g0LpbUW?=
 =?us-ascii?Q?YfJtO6YaOwxauL/Ncpn8op7VifrH/1He/t8WAfwRGM1Sl1KshqZo9epTU9/K?=
 =?us-ascii?Q?aQ0TpFaL9gjccS6q2JOCLwv9FBQW8+LfWW4TlwILWluDJt2Rm0AVZ1NmeMEd?=
 =?us-ascii?Q?X9E5aby2LAngpbsYtFyz7bzUM1tNzrHxbYsBLO4Fso7bQty5ulNh6uo4ipoG?=
 =?us-ascii?Q?Lb43a7c9FvQhFQfvB9Mis5do?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8a6287-4e52-43ce-0cfe-08d987252296
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 10:53:01.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sp9VWquLO9ALlm7vjY/ReKltSNvJQbJPy+AxdKXqDfBo/DPAhrct1eBTKgf7AmLDHCchoxrZuZfF3RjdFHf1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vladimir and Michael,

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Saturday, October 2, 2021 2:53 PM
> To: Michael Walle <michael@walle.cc>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>; Yogesh Gaur <yogeshgaur.83@gmail.com>; Mark
> Brown <broonie@kernel.org>; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: Re: [PATCH] spi: spi-nxp-fspi: don't depend on a specific node n=
ame
> erratum workaround
>=20
> On Sat, Oct 02, 2021 at 10:58:31AM +0200, Michael Walle wrote:
> > Am 2021-10-02 03:37, schrieb Vladimir Oltean:
> > > On Fri, Oct 01, 2021 at 11:27:26PM +0200, Michael Walle wrote:
> >
> > > > Make the workaround more reliable and just drop the unneeded
> > > > sysclk lookup.
> > > >
> > > > For reference, the error during the bootup is the following:
> > > > [    4.898400] nxp-fspi 20c0000.spi: Errata cannot be executed. Rea=
d
> > > > via IP bus may not work
> > >
> > > Well, in Kuldeep's defence, at least this part is sane, right? I
> > > mean we cannot prove an issue =3D> we don't disable reads via the AHB=
.
> > > So it's just the error message (which I didn't notice TBH, sorry).
> >
> > Its just an error message in case the platform clock is 400Mhz. But if
> > you have a 300MHz platform clock the workaround wouldn't be applied.
>=20
> Understood, that's why I asked...
>=20
> > The reference is just there if someone stumbles over this error and
> > searches for it on google.
> >
> > > On the other hand, is anyone using LS1028A with a platform clock of
> > > 300 MHz? :)
>=20
> ...this.

I didn't receive emails in proper order not sure why.
Anyway, I will try to pitch in details which I have.

There was one customer(cannot recall name) using LS1028A with 300Mhz.
They reported AHB failure issue and later on it turns out to be an errata.
I didn't hear anything from them whether they pursued with 300Mhz or fallba=
ck to 400Mhz.

>=20
> > > > Fixes: 82ce7d0e74b6 ("spi: spi-nxp-fspi: Implement errata
> > > > workaround for LS1028A")
> > > > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > > ---
> > > >  drivers/spi/spi-nxp-fspi.c | 26 +++++++-------------------
> > > >  1 file changed, 7 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-nxp-fspi.c
> > > > b/drivers/spi/spi-nxp-fspi.c index a66fa97046ee..2b0301fc971c
> > > > 100644
> > > > --- a/drivers/spi/spi-nxp-fspi.c
> > > > +++ b/drivers/spi/spi-nxp-fspi.c
> > > > @@ -33,6 +33,7 @@
> > > >
> > > >  #include <linux/acpi.h>
> > > >  #include <linux/bitops.h>
> > > > +#include <linux/bitfield.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/completion.h>
> > > >  #include <linux/delay.h>
> > > > @@ -315,6 +316,7 @@
> > > >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
> > > >
> > > >  #define DCFG_RCWSR1		0x100
> > > > +#define SYS_PLL_RAT		GENMASK(6, 2)
> > >
> > > Ugh. So your solution still makes a raw read of the platform PLL
> > > value from the DCFG, now it just adds a nice definition for it. Not n=
ice.
> >
> > Keep in mind that this is intended to be a fixes commit. I agree with
> > you that having a new clock in the device tree and checking that would
> > have been better. Feel free to change the workaround after this fix is
> > applied (without a fixes tag), but I don't think introducing a new
> > clock (and you forgot to update the bindings) will qualify as a fixes
> > commit. Esp. when you change the compatible string.

dt-bindings are updated to json schema and already posted upstream awaiting=
 Mark's feedback.

Moreover, using third optional clock seems a viable solution.
Since this is the first time we have stumbled such issue and isn't a freque=
nt one,
We can keep current changes as is and if face similar issue later, can swit=
ch to new proposed solution.

Similar changes are also done for u-boot[1] in an absurd manner as I couldn=
't find simpler way to do it.
I'll be glad to receive feedback on those patches.

Regards
Kuldeep
[1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D256398

>=20
> I think it could be justified as a fixes commit to Shawn Guo - the LS1028=
A is
> not "compatible" with LX2160A in the sense that it has software-visible e=
rrata
> which LX2160A doesn't have.
>=20
> > > >  /* Access flash memory using IP bus only */
> > > >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> > > > @@ -926,9 +928,8 @@ static void erratum_err050568(struct nxp_fspi
> *f)
> > > >  		{ .family =3D "QorIQ LS1028A" },
> > > >  		{ /* sentinel */ }
> > > >  	};
> > > > -	struct device_node *np;
> > > >  	struct regmap *map;
> > > > -	u32 val =3D 0, sysclk =3D 0;
> > > > +	u32 val, sys_pll_ratio;
> > > >  	int ret;
> > > >
> > > >  	/* Check for LS1028A family */
> > > > @@ -937,7 +938,6 @@ static void erratum_err050568(struct nxp_fspi
> *f)
> > > >  		return;
> > > >  	}
> > > >
> > > > -	/* Compute system clock frequency multiplier ratio */
> > > >  	map =3D syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
> > > >  	if (IS_ERR(map)) {
> > > >  		dev_err(f->dev, "No syscon regmap\n"); @@ -948,23 +948,11
> @@
> > > > static void erratum_err050568(struct nxp_fspi
> > > > *f)
> > > >  	if (ret < 0)
> > > >  		goto err;
> > > >
> > > > -	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier
> > > > ratio */
> > > > -	val =3D (val >> 2) & 0x1F;
> > > > -	WARN(val =3D=3D 0, "Strapping is zero: Cannot determine ratio");
> > > > +	sys_pll_ratio =3D FIELD_GET(SYS_PLL_RAT, val);
> > > > +	dev_dbg(f->dev, "val: 0x%08x, sys_pll_ratio: %d\n", val,
> > > > sys_pll_ratio);
> > >
> > > Do we really feel that this dev_dbg is valuable?
> >
> > No, I just briefly looked at it to see it prints 4 ;)
> >
> > > > -	/* Compute system clock frequency */
> > > > -	np =3D of_find_node_by_name(NULL, "clock-sysclk");
> > > > -	if (!np)
> > > > -		goto err;
> > > > -
> > > > -	if (of_property_read_u32(np, "clock-frequency", &sysclk))
> > > > -		goto err;
> > > > -
> > > > -	sysclk =3D (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
> > > > -	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
> > > > -
> > > > -	/* Use IP bus only if PLL is 300MHz */
> > > > -	if (sysclk =3D=3D 300)
> > > > +	/* Use IP bus only if platform clock is 300MHz */
> > > > +	if (sys_pll_ratio =3D=3D 3)
> > > >  		f->devtype_data->quirks |=3D FSPI_QUIRK_USE_IP_ONLY;
> > > >
> > > >  	return;
> > > > --
> > > > 2.30.2
> > > >
> > >
> > > How about:
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > index 343ecf0e8973..ffe820c22719 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > @@ -326,15 +326,17 @@ i2c7: i2c@2070000 {
> > >  		};
> > >
> > >  		fspi: spi@20c0000 {
> > > -			compatible =3D "nxp,lx2160a-fspi";
> > > +			compatible =3D "nxp,ls1028a-fspi";
> >
> > Why not
> >   compatible =3D "nxp,ls1028a-fspi", "nxp,lx2160a-fspi"; to keep at
> > least some compatibility.
>=20
> Of course that would be even better. I just wanted to rush to get here be=
fore
> Mark, and it looks like I still didn't make it in time.
>=20
> Worst case, new (cleaned up to not calculate the platform clock on its ow=
n)
> driver will still probe with old device tree, but not apply the ERR worka=
round
> for 300 MHz systems.
>=20
> I may be ignorant here, but I just don't know how many systems use 300
> MHz platform in practice. Anyway, it's always difficult to fix up somethi=
ng
> that came to depend on DT bindings in a certain way.
>=20
> > >  			#address-cells =3D <1>;
> > >  			#size-cells =3D <0>;
> > >  			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> > >  			      <0x0 0x20000000 0x0 0x10000000>;
> > >  			reg-names =3D "fspi_base", "fspi_mmap";
> > >  			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > > -			clocks =3D <&fspi_clk>, <&fspi_clk>;
> > > -			clock-names =3D "fspi_en", "fspi";
> > > +			clocks =3D <&fspi_clk>, <&fspi_clk>,
> > > +				 <&clockgen QORIQ_CLK_PLATFORM_PLL
> > > +					    QORIQ_CLK_PLL_DIV(2)>;
> > > +			clock-names =3D "fspi_en", "fspi", "base";
> > >  			status =3D "disabled";
> > >  		};
> > >
> > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > > index a66fa97046ee..f2815e6cae2c 100644
> > > --- a/drivers/spi/spi-nxp-fspi.c
> > > +++ b/drivers/spi/spi-nxp-fspi.c
> > > @@ -314,8 +314,6 @@
> > >  #define NXP_FSPI_MAX_CHIPSELECT		4
> > >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
> > >
> > > -#define DCFG_RCWSR1		0x100
> > > -
> > >  /* Access flash memory using IP bus only */
> > >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> > >
> > > @@ -922,55 +920,18 @@ static int nxp_fspi_adjust_op_size(struct
> > > spi_mem *mem, struct spi_mem_op *op)
> > >
> > >  static void erratum_err050568(struct nxp_fspi *f)  {
> > > -	const struct soc_device_attribute ls1028a_soc_attr[] =3D {
> > > -		{ .family =3D "QorIQ LS1028A" },
> > > -		{ /* sentinel */ }
> > > -	};
> >
> > Mh, I see how you came to the conclusion to rename the compatible
> > string. But normally, this also contains a revision check, which is
> > missing here IMHO. It might as well be fixed in the next revision
> > (though we both know, this is highly unlikely; its still wrong). So
> > while you could rename the compatible (oh no!) you'd still have to do
> > the rev 1.0 check here.
>=20
> So you want a compatible string a la "fsl,ls1021a-v1.0-dspi", right?
> I don't know, no strong opinion, as you said, we both know that no LS1028=
A
> rev 2 seems to be planned.
>=20
> > > -	struct device_node *np;
> > > -	struct regmap *map;
> > > -	u32 val =3D 0, sysclk =3D 0;
> > > -	int ret;
> > > +	struct clk *clk_base;
> > >
> > > -	/* Check for LS1028A family */
> > > -	if (!soc_device_match(ls1028a_soc_attr)) {
> > > -		dev_dbg(f->dev, "Errata applicable only for LS1028A\n");
> > > +	clk_base =3D clk_get(f->dev, "base");
> > > +	if (IS_ERR(clk_base)) {
> > > +		dev_err(f->dev, "Errata cannot be executed. Read via IP bus
> may
> > > +not
> > > work\n");
> > >  		return;
> > >  	}
> > >
> > > -	/* Compute system clock frequency multiplier ratio */
> > > -	map =3D syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
> > > -	if (IS_ERR(map)) {
> > > -		dev_err(f->dev, "No syscon regmap\n");
> > > -		goto err;
> > > -	}
> > > -
> > > -	ret =3D regmap_read(map, DCFG_RCWSR1, &val);
> > > -	if (ret < 0)
> > > -		goto err;
> > > -
> > > -	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier ratio=
 */
> > > -	val =3D (val >> 2) & 0x1F;
> > > -	WARN(val =3D=3D 0, "Strapping is zero: Cannot determine ratio");
> > > -
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
> > > +	/* Use IP bus only if platform PLL is configured for 300 MHz,
> > > +hence
> > > we get 150 MHz */
> > > +	if (clk_get_rate(clk_base) =3D=3D 150000000)
> > >  		f->devtype_data->quirks |=3D FSPI_QUIRK_USE_IP_ONLY;
> > > -
> > > -	return;
> > > -
> > > -err:
> > > -	dev_err(f->dev, "Errata cannot be executed. Read via IP bus may not
> > > work\n");
> > > +	clk_put(clk_base);
> > >  }
> > >
> > >  static int nxp_fspi_default_setup(struct nxp_fspi *f) @@ -994,10
> > > +955,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi
> > > *f)
> > >  	/*
> > >  	 * ERR050568: Flash access by FlexSPI AHB command may not work
> with
> > >  	 * platform frequency equal to 300 MHz on LS1028A.
> > > -	 * LS1028A reuses LX2160A compatible entry. Make errata applicable
> for
> > > -	 * Layerscape LS1028A platform.
> > >  	 */
> > > -	if (of_device_is_compatible(f->dev->of_node, "nxp,lx2160a-fspi"))
> > > +	if (of_device_is_compatible(f->dev->of_node, "nxp,ls1028a-fspi"))
> > >  		erratum_err050568(f);
> > >
> > >  	/* Reset the module */
> >
> > --
> > -michael
