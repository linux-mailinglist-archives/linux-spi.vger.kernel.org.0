Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E135941FAB4
	for <lists+linux-spi@lfdr.de>; Sat,  2 Oct 2021 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJBJ5G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Oct 2021 05:57:06 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:46208
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232691AbhJBJ5F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 2 Oct 2021 05:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLOgrJL8dgUfyuMcymGd449rrPLSiXdXu7ALBqx1owtm4UzWQoUvKKe3UhRpJb6RR2P3pnCzpYbRCIfXZw6htLdvNsFAFal8hU3JEMZ15s/Sw7koK6XDN2TdZl3jUng5xRVpCb/gBHvV0Ti3xV2Y9wtAHm6cGFDN/WDfVLrVqLKhzgDr8y3vYUv6mImBQ459eIX0PZBF4kMTlPTQsqF4dkBUIjrNb/4W45sdlBOO1bhHhzj3A8fFUovYVNR9mpsvMPX3twXv+90apkH1F7yS/31mdsXViKLttILmFiKCZarJypLwd/xrqg93XAxNEe3mjg0Wi4VyDDkut7yTSAPgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+N64VZxF0OhHUw3wiV4I6AAqnvJpELNN+UEXGQBveI=;
 b=mNezG7iW6HRfkhKCHfG/gMKcSPJv23aa/MJr76JY8zSkFSD6cBI2Zj3FwZCGMVGhX2PYzA3Hu/lN19T+TRgB2amyKsRbtKNQQ4Z/LJitFdz6TJezNPM28A7XJh21WstpQLlFSzcgGxLktXSZefGlMro7T6wILC9EZxQxkXXUV2X8rhyymDJ/l4TzR3ygMug9I4y7hmsTEI8cW6X6Kdprw2GXGSLLEzUrUrS/DQlBEJ7kilA6Lfip5YJ3LzOHSaaYDAvhLbEPf/PrYvTmVy9lH8q7zgP+/abUwbUDHnFBuCBUIB2QsrLLYQAvhxjYCFf+T5yXQ6ieipdRDUvJSE8cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+N64VZxF0OhHUw3wiV4I6AAqnvJpELNN+UEXGQBveI=;
 b=VCIo+AB8qI1yUgYbwHkjGWE5AAMgD07WV7bG0EeXj79IRbvkKORhWFbFQ234/StSqSB64zM/HMW9fyuEDS8APdmvGtPq4XK4NxqRS2/Tp3qUeMmPwletNQfyb5MaNz9lA/ijmpsW1JVnM+b1PHG8ES0sfzHssFFgj0m4Y3adXzc=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB3966.eurprd04.prod.outlook.com (2603:10a6:803:4e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Sat, 2 Oct
 2021 09:55:16 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::e157:3280:7bc3:18c4]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::e157:3280:7bc3:18c4%5]) with mapi id 15.20.4566.021; Sat, 2 Oct 2021
 09:55:16 +0000
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
Thread-Index: AQHXtwso2m8Esg1oVE6VXXAu/eOY4qu+7hKAgAB7MICAAAbYgIAAAyAAgAAF4oA=
Date:   Sat, 2 Oct 2021 09:55:16 +0000
Message-ID: <20211002095515.iw5rgakysyusvqte@skbuf>
References: <20211001212726.159437-1-michael@walle.cc>
 <20211002013737.hpalogc72umopz4x@skbuf>
 <c5a67c34af869fd93d34320ef181c682@walle.cc>
 <20211002092301.ue77mzzwcel76umx@skbuf>
 <c9a4f7cca7d2e3959e20d8098a322562@walle.cc>
In-Reply-To: <c9a4f7cca7d2e3959e20d8098a322562@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba60476b-3d13-46df-b26b-08d9858abcb7
x-ms-traffictypediagnostic: VI1PR04MB3966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB39661163AD3A4E8C22C24C1CE0AC9@VI1PR04MB3966.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzMww6LNDhu6kkTXHdoZyBfKVZv4fcP8BQaEavV0+zot383CRhPzSBZqOjwmmqo/9p0KwYCo2EraF8VA/JUStBPyNRa6pcqRFsYT53yh0sfXCK7lMbba/cyKKQ8goIkAwgUQJEOD+12tgfhbdy6GgLr9ARrWGFh7aptWHLnfnMRW36/xSjNuzBWWd3oT4ZFL/8RrgagT6qAOxwQOvrtD4oszmNWq7tFi3yNGpPSoGtNG1u8rc4qkD4IAr84RGPJ8aozdGYppj1lX1WD/fcrTFpo6apqUvMld9vvcBMWYSuBE5igVkRpooULKzatmQ98Rky680pLXZaNzD1ll4avYBGQmgLXqJ6eJTxvzaNY/6e2LOOg6no3dNlPnRKASbKvYHphwmZ1u5iWAo6NcIIRXeXLfXoHmNpGCFEiN1vcHITFS8suWb4/yrsb9epqoK7TamiFHncQe0OwqOQvuJuoZZdzQXBvKbwjrYHH1UyNqf12lHl7wAvMn8kE9VUtYWTZWz1ZttKmp8gqvQCNucOpFj4pFtOuOIZHvVSqlU2Ol01mObtSpVYC/PvGz7RDI3l8c5jYulfBNeTKp0PEmYrl2+e/3lKr0FJL+ooEVFuQQBIj2lsooJm34OlDltsA7tejv7sWTZxhiWUmHlSjcUB2fnovoaG8+mLPmbMUrOKFRrddHSoCCtAWDXhDBmXVWN1Ftu2Zqs8CtK9YNd8gjHWe5ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6512007)(9686003)(6486002)(1076003)(71200400001)(44832011)(66946007)(4326008)(83380400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(54906003)(6916009)(38100700002)(122000001)(8936002)(508600001)(33716001)(86362001)(8676002)(26005)(186003)(38070700005)(2906002)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cBxdFbCIYO7n1+F8cT3rCLHfyKmsQCitsXHgz+8HvvfiypWmCdHKJTDev8q3?=
 =?us-ascii?Q?mf7QXalpMUWN0dtupWvCvc+jW9uXJdlLaHDe1JNd0CvEUsAGh//xI9xu/abh?=
 =?us-ascii?Q?cPWd8S1U6n0NBbArtlQ0Lpe039Wuq9OA9jTjtFJc/lEcXvhQnbd/ZLqNBDRp?=
 =?us-ascii?Q?O8vsbhLHN8+AQFivg2kAyuq+LnZYsaxo9I5pXEF4XtWZm2u0RQjuFop3clib?=
 =?us-ascii?Q?Whf33Bgriv3arMga3y4zFXfCzMooF+oO3Ee5Rsx9EY3JX2HcHVWi5435AHlw?=
 =?us-ascii?Q?dF1X14LppohYZ8FZ3NEmYAcG9YQPM1dCcYmwUdw8Xu9Foq6cvLShUe2gBts7?=
 =?us-ascii?Q?no216Z5wo+28QJ/DZIkMYmRMc4zhlvBjvQJ+D5ysnS5LRFMS/T4PeAH1gr72?=
 =?us-ascii?Q?jg4nZ7RpRAi4QtoCkxBXyNegxUHVS0UM1mM1GBOQ4+3CVNn+iTTnFTGyIkjn?=
 =?us-ascii?Q?VhaIrgOgxJFuppri2j+K1JnfAa05hIsN0uyrbxBrVwN2J+V5SILAR40pFAJ1?=
 =?us-ascii?Q?UKrL34Q5iLVaHD5JpX0IshsYgvUE+oT404ZRCUiVPZPD/qKqGar0J50rqPei?=
 =?us-ascii?Q?5cVzHBdpKzM3K5yeFsa4qtrYlQqbcMEaKzDpgSGTG51TUPGQ/c6h17F3isD9?=
 =?us-ascii?Q?S38/C8rDuUYkBt+H8jyAyqOOFmYiLbldtszDvTxoU4H7UPiexk4fawGdfH3n?=
 =?us-ascii?Q?mvZ6qC4iFqYTX17mpZ0BCVf8txjBL7O+gdurNTM7lWupdTG72232sUNSvCuK?=
 =?us-ascii?Q?o1DDhvmO5v22A7pmNxT7ovJ2vsaMH0OgPCOxIip2nZvay0RMpsOkqFdr2aK/?=
 =?us-ascii?Q?4n2D4zh5GMODqjTKppKv4xNfASHbOYHxLgp9yHAMaCkO8ZrMnYdSqGEkRxlD?=
 =?us-ascii?Q?ZBCmlq5wEk0Hqf7WrVmhI/YAxUrPgalfxxAifQ5YTj2u/bB7jcB8HM5K1TXF?=
 =?us-ascii?Q?cGynoqr0Di25HTZ9Lk0IVpmk3PjrI8uNJiVp3lSRPGwAENP45fM0oPu36zYj?=
 =?us-ascii?Q?Yb15pX1LfaaGV6BipoGs12NkCDyxnx+5rHKkgO9u2SNOi0PVG/x9Rs79Rkeo?=
 =?us-ascii?Q?SOcOBbGdD3kCxpjK70SvVz7aQ5DwqgFb8PAEtonCEF36CgBZTZ0tj/d6nTvJ?=
 =?us-ascii?Q?1Tf6EWkORtBeOw05D/cNiZNV3XLLAiZUaD8c5hCqtV8HI4XdeHAap4h9qmrL?=
 =?us-ascii?Q?RaQ0CXt4YKk9/zJoWhi/0NrbqXuPPU4PWpRfr+QBF3cogN/937Fu4SqVPTDR?=
 =?us-ascii?Q?PaGX+zpWrZq3VnGMcfFyaWTmxevIdHxSfAuZePC7MTvESBDEDnG+SOLnqQ7z?=
 =?us-ascii?Q?WyY3ojy81jBF5zDWTyDdlqDDoi1K+cMuYyEqCYOdmdo3pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23802ECF98F84D4D8DE049A8B9FF57E2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba60476b-3d13-46df-b26b-08d9858abcb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2021 09:55:16.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQycxQhCMhKRd562c0CevRlIbwYwi4Zx4o51M+rsqC4EhM1I/D0tDlgTj4/gqk6t6uAiqf7aJMEWtEKF0MR6Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3966
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Oct 02, 2021 at 11:34:12AM +0200, Michael Walle wrote:
> > > > Ugh. So your solution still makes a raw read of the platform PLL va=
lue
> > > > from the DCFG, now it just adds a nice definition for it. Not nice.
> > >=20
> > > Keep in mind that this is intended to be a fixes commit. I agree with
> > > you that having a new clock in the device tree and checking that woul=
d
> > > have been better. Feel free to change the workaround after this fix
> > > is applied (without a fixes tag), but I don't think introducing a new
> > > clock (and you forgot to update the bindings)

I don't think I'm the one who forgot to update the bindings, btw.
In Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt (still not
using JSON schema), the "clocks" are not documented as to what they want
and why do both "fspi" and "fspi_en" even exist. The only mention you
see of the "fspi" and "fspi_en" clocks in that file is an _example_.
And that example remains correct, because it is for the LX2160A.

> > > will qualify as a fixes
> > > commit. Esp. when you change the compatible string.
> >=20
> > I think it could be justified as a fixes commit to Shawn Guo - the
> > LS1028A is not "compatible" with LX2160A in the sense that it has
> > software-visible errata which LX2160A doesn't have.
>=20
> And you'd need to get Rob into the boat for the dt bindings "fixes",
> no? For the new clock.

Yup.

> > > > How about:
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > index 343ecf0e8973..ffe820c22719 100644
> > > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > > > @@ -326,15 +326,17 @@ i2c7: i2c@2070000 {
> > > >  		};
> > > >
> > > >  		fspi: spi@20c0000 {
> > > > -			compatible =3D "nxp,lx2160a-fspi";
> > > > +			compatible =3D "nxp,ls1028a-fspi";
> > >=20
> > > Why not
> > >   compatible =3D "nxp,ls1028a-fspi", "nxp,lx2160a-fspi";
> > > to keep at least some compatibility.
> >=20
> > Of course that would be even better. I just wanted to rush to get here
> > before Mark, and it looks like I still didn't make it in time.
> >=20
> > Worst case, new (cleaned up to not calculate the platform clock on its
> > own)
> > driver will still probe with old device tree, but not apply the ERR
> > workaround for 300 MHz systems.
>=20
> No worst case is, the flexspi driver doesn't probe at all (new devicetree=
,
> old kernel ;).

Well, if you're going to take my patch as is, sure. But the device tree
can still be modified in such a way that old kernels keep seeing what
they saw before - the fallback compatibility string, and ignore the
third clock provider.

With even more care and consideration for new kernels operating with old
DT blobs, the ERR workaround could check for the clock provider in the
device tree first, then fall back to open-coding its own deductions of
the platform clock if that fails. After a grace period of one or two
years or so, maybe the open-coding could then be removed.

> > I may be ignorant here, but I just don't know how many systems use 300
> > MHz platform in practice. Anyway, it's always difficult to fix up
> > something that came to depend on DT bindings in a certain way.
> >=20
> > > >  			#address-cells =3D <1>;
> > > >  			#size-cells =3D <0>;
> > > >  			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> > > >  			      <0x0 0x20000000 0x0 0x10000000>;
> > > >  			reg-names =3D "fspi_base", "fspi_mmap";
> > > >  			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > > > -			clocks =3D <&fspi_clk>, <&fspi_clk>;
> > > > -			clock-names =3D "fspi_en", "fspi";
> > > > +			clocks =3D <&fspi_clk>, <&fspi_clk>,
> > > > +				 <&clockgen QORIQ_CLK_PLATFORM_PLL
> > > > +					    QORIQ_CLK_PLL_DIV(2)>;
> > > > +			clock-names =3D "fspi_en", "fspi", "base";
> > > >  			status =3D "disabled";
> > > >  		};
> > > >
> > > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.=
c
> > > > index a66fa97046ee..f2815e6cae2c 100644
> > > > --- a/drivers/spi/spi-nxp-fspi.c
> > > > +++ b/drivers/spi/spi-nxp-fspi.c
> > > > @@ -314,8 +314,6 @@
> > > >  #define NXP_FSPI_MAX_CHIPSELECT		4
> > > >  #define NXP_FSPI_MIN_IOMAP	SZ_4M
> > > >
> > > > -#define DCFG_RCWSR1		0x100
> > > > -
> > > >  /* Access flash memory using IP bus only */
> > > >  #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
> > > >
> > > > @@ -922,55 +920,18 @@ static int nxp_fspi_adjust_op_size(struct
> > > > spi_mem *mem, struct spi_mem_op *op)
> > > >
> > > >  static void erratum_err050568(struct nxp_fspi *f)
> > > >  {
> > > > -	const struct soc_device_attribute ls1028a_soc_attr[] =3D {
> > > > -		{ .family =3D "QorIQ LS1028A" },
> > > > -		{ /* sentinel */ }
> > > > -	};
> > >=20
> > > Mh, I see how you came to the conclusion to rename the compatible
> > > string. But normally, this also contains a revision check,
> > > which is missing here IMHO. It might as well be fixed in the
> > > next revision (though we both know, this is highly unlikely; its
> > > still wrong). So while you could rename the compatible (oh no!)
> > > you'd still have to do the rev 1.0 check here.
> >=20
> > So you want a compatible string a la "fsl,ls1021a-v1.0-dspi", right?
> > I don't know, no strong opinion, as you said, we both know that no
> > LS1028A rev 2 seems to be planned.
>=20
> Nooo. No revisions in the compatible string.
>=20
> const struct soc_device_attribute ls1028a_soc_attr[] =3D {
> 	{ .family =3D "QorIQ LS1028A", .revision =3D "1.0" },
> 	{ }
> };
>=20
> Thus you'd still need that check above.

Ok, the idea of changing the compatible string was to make the driver
search for the third "base" clock. But the bindings document can simply
say that the "base" clock is optional for all SoCs - with the caveat
that the LS1028A ERR workarounds will not be applied if not provided.
And in that case, not even a SoC specific compatible string is needed.=
