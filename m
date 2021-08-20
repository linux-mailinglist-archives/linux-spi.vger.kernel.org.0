Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938A33F28A8
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhHTItQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 04:49:16 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:7136
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232622AbhHTItQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Aug 2021 04:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVq46GUkJ+zschSdseAsDB6jgMCPT1GbBL3/4WK51zXP880oPW3tlh+f4U4/Y/YPlmwcY5X8s9b3FpEDegK571f72O7hfg2NVptTcAUvloqogM5O4+xDzRiv5cnjHfOwVPcT6xWPYcdYmlsuTxkqhbvdoFJemfDlOZDCICNloYCpVZrltg81lnN3XHpW2O0sVYvg0uU3MoCxGqVpdfnUdZAyQILRboGQGwJyZC0XuvhTYgUvXI2qYGDWdXi9sfl3KUsqNTEtnCe7+AEhE4k3A+nhkQPeaHxM1WJZR1ADzO1ECM3Ylv30lhXePt/vYB4M7z2PIKcASjmGsRI4ympuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMA5vOuI7ng9zcVEW5DZYkRfT4usYLdMdiAp4bnRJSc=;
 b=Pnchz2w4Jvl3wDxCTo8t5sZePcgFo3dEsqh07Vzz4DBH5Le1hiIand8zsRQJzmVbpEJZWfl9Mr6ZTI2E9R5WR135TGo6tyD2y0G4udITS1JpBnQXb267gf28Y3D5AzZmKZPXf50eLK+uXDKLKohMk5wWFK6q4k9B9BQICW//8HuzQvjQFrPBj/qcHDtEFVvjnhLsCpFEmTdE9149WULOB1r78m1DMl9k/fCvPIav1k3UmybnG+bHEWe2RuuPjL1UzgCFg9GV2EzGduTt7MY2HF0kjnk5A5fOx7EjfNDzgdFbgprehE4E/edlsVRQ03nJkzlXPGIdio19IiN+jetDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMA5vOuI7ng9zcVEW5DZYkRfT4usYLdMdiAp4bnRJSc=;
 b=duuzSpGnv6ae/V8znFYQgVRmMzLyO1wctcmbwEcMmbHlWEM7pQPG+aBB80IpVAAGy5ZdNsFbRDFrqu2Vi8i4plpsRbwJtB80aF6sMq2lfx24HlSUzkjr90OuvGY4147+0HFdcDDjv4SrMZqkvkzC4PgDjIAaiHpPIKBbzT2NATk=
Received: from AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15)
 by AM9PR04MB9001.eurprd04.prod.outlook.com (2603:10a6:20b:408::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 08:48:36 +0000
Received: from AM9PR04MB8472.eurprd04.prod.outlook.com
 ([fe80::456e:a772:9b6f:838]) by AM9PR04MB8472.eurprd04.prod.outlook.com
 ([fe80::456e:a772:9b6f:838%9]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 08:48:36 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Bough Chen <haibo.chen@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Bough Chen <haibo.chen@nxp.com>
Subject: RE: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default lut index
Thread-Topic: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default lut
 index
Thread-Index: AQHXlZpBukS8cgDBkkW0SXctb7cw4qt8DSBQ
Date:   Fri, 20 Aug 2021 08:48:36 +0000
Message-ID: <AM9PR04MB847228498D541C54AD81E69EE0C19@AM9PR04MB8472.eurprd04.prod.outlook.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
 <1629445443-10300-2-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629445443-10300-2-git-send-email-haibo.chen@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 694c4237-61c4-4c00-4891-08d963b74cdc
x-ms-traffictypediagnostic: AM9PR04MB9001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR04MB9001828A05FB0D3AB1AE4EC3E0C19@AM9PR04MB9001.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hy8tuUaHKLbbxOfDVNlemwwF2D2T/A15/6OV7sRvDGz33CkKShyeuNARBlPBP0R9vMSLXayP5btu/KhmcruL5NvtB66OfGIC9lBh0SePrtFjbPapTqs60hdAZ+EzVGpJIn4mou7wzvNB6BSQnGpzhYkChy5r7tcC5EBgk8Nlj8Fv0PtRrbf3Fl6kpkHCPJEixbppfIcJEQNz69TmofW/ekIjnqJOSvUC4TWklO1yGWB2+pKwuKQDT6Tx3P8YrOkyM1G7qtM10nlfeDVdtw4/M/mTOD1LTOhs4KGk4lnU7uCA26fpSubL5gd+28m6PjIYw33eIghj/fiRZ9gdHKj2NgMejjGh699QAK0Zt9D53MneBLXndtkesaJeTIGR1+I0tv79mk9suQEhRGigtCMUexb/wvgNWocLhvyluqekH9pOj2hw6s4TjlSbZXG8/rjbNVYZxxMq0kwngqB8M+/0S0HTO5FfQpRSwyGPnlDAYnRS1OSOCfzkyu7FbkH0a2Uf0J4ubsFhSbG4O621QCsQyYG1g570L4qowSVf7uw550LHKlg++qsQENCigDk4jjuNzlBvx4LYjH8wraJtayOgolBA24NPEX6y/oiHpN7F13cRjBUwADIr/5QswmGGpLGNGLrUH0jHSEbbv8NlXnJlW6rmKYVxtc6YsiwTYCzJyGTWtP0hReC9Y8XoWUxMUPz1XgoMLX+TtsRSwOFGgodOWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(8936002)(64756008)(66446008)(53546011)(52536014)(66476007)(86362001)(83380400001)(7696005)(2906002)(122000001)(55016002)(8676002)(76116006)(66556008)(4326008)(71200400001)(33656002)(38100700002)(26005)(38070700005)(186003)(44832011)(478600001)(110136005)(9686003)(5660300002)(316002)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvKlQztcMUSPDV2pG1PVDMdYzI745K7uc9BztuK/uPPc3bU8+27WLX4HJDPR?=
 =?us-ascii?Q?5jFycetuLA1Mx1LYMFD8nQ7muhAdczc6ceIkY6Gm80v5FHFzAFl/1pr5w8eh?=
 =?us-ascii?Q?2wqRSvBvDKdNvEIES1KdvMR03cmtozuBEVw4b1Wf9C1yQyRdgal9PpqOOiGI?=
 =?us-ascii?Q?kRCATwdRjdVs70RROuMHS9OmMyTYj4j8HBH7YmX5rhYYXGrn7r6ob2/FXspI?=
 =?us-ascii?Q?iGuZi8nSF9vuZS23AlR3AudM2pAjr0v7ITDPsdZFbDqfEBJ7OJb8IHdpZh1n?=
 =?us-ascii?Q?vzqjokXZLbtzYNfQgZhPicD6ZCMHu2bNeOW/nhqz7xMUnoP7H8Sd55H7k+fl?=
 =?us-ascii?Q?mn/LmpY9/uC/w6i2LRoJmQQUtZ/Za0dZ6i1PNwckdeo/K+sXmGACI1B5WSL7?=
 =?us-ascii?Q?R1zWGbTJW1AEVPIReJ+ppz5cZBKS7CRwXmbAgmEFIpVAvuvReQNUn94gZ8qG?=
 =?us-ascii?Q?HOy0NL8jj9xrS7NXxQAmNW8O1n9hMyLSH3Hp9XzgAQlx3n6wVqP1RkZ4Y8MZ?=
 =?us-ascii?Q?iyBY+ubRJLhacAiAZDg+FQ1jt+A7yneSzZ61fQhyaka4h2OLfTLgvlIMktRc?=
 =?us-ascii?Q?knVwYAoq3Hd2YvR/k+lOH4Jk/iofIuyYgrIv6/VBVmF+QQ0I7+QpZIqG2dCn?=
 =?us-ascii?Q?CSzdh5A0cyT/WpUv2TdaVuBSqx1KaA00T7Rxgnz6CWjXMvdKj00m1IhlmSRy?=
 =?us-ascii?Q?r9iSXQgqgEu1M95zg5yWmeEr/lGlTsgLTFb93mz9MOboVqHlPZyIqkaBEpsT?=
 =?us-ascii?Q?5X0QnLYfnt7D/4km2SIGrJzZEVi6idhWekm2mKk+0uhDGPx5Ig6GSIbrz5nX?=
 =?us-ascii?Q?3lOorAk1IFrC7zGBH+5W+r1dlkQcrsI6pXS0EeoNdbQ+aV3Q0IbR0X9NX+mp?=
 =?us-ascii?Q?9SJ0kMUcA0EOTaX5pEcdNs3CTJhVN83+ZZe54J3dw/T2KFHjrXUhJMTHHS26?=
 =?us-ascii?Q?gmLDnvQ6UnP4/ZU6zOdLJs04XEVBgUaZaW+crRepKMS2uftN1UNYwrpROPh2?=
 =?us-ascii?Q?eL61k3xakJpe0aPOFEKFLd4NSDMxiaD/2fhKTxuqhXgWl9/GPjunkldfkUKW?=
 =?us-ascii?Q?OFZT0gZ88sGMhY58JahSIvBn2WvoNxGljp8dEjhC3ROsZ80H8X6r+5iyaKqH?=
 =?us-ascii?Q?Ix0ZyU0CcV4gBebL8ZECxmg+8YXbQp0OXnKk7m3brCwptQ1g9HakCmxrOSF8?=
 =?us-ascii?Q?dPl4wpU2ykzp6oXj8vgp899KATT048XE1Z5OedpYR2IUnRZsydR7dH+QQfVY?=
 =?us-ascii?Q?RmcR4eWNekmskXZ0A1n6q34mW2ZKsEGOmbot64Sm7Q6Xnq3GwkGmGWq2xtiS?=
 =?us-ascii?Q?fbqvpXwKqpTU/Es9wng+CGxI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694c4237-61c4-4c00-4891-08d963b74cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 08:48:36.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq+NvmR4hrLNTIXAzW1qH+gV8D7rVjZYYZQ1iZiKIeuvmWp0ZRZXFvZ4W3HKbotYOjdgbZ3GqBzc5eEbv9897A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9001
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Haibo,

> -----Original Message-----
> From: haibo.chen@nxp.com <haibo.chen@nxp.com>
> Sent: Friday, August 20, 2021 1:14 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>; yogeshgaur.83@gmail.com;
> broonie@kernel.org
> Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Bough Ch=
en
> <haibo.chen@nxp.com>
> Subject: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default lut inde=
x
>=20
> Caution: EXT Email
>=20
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> The fspi dynamic lut use the last lut for all IPS operations, the imx8ulp=
 only
> supports 15 luts, so change the last lut index from
> 31 to 15.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c inde=
x
> 1eecf20f1dab..a764eb475aed 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -63,9 +63,9 @@
>  /*
>   * The driver only uses one single LUT entry, that is updated on
>   * each call of exec_op(). Index 0 is preset at boot with a basic
> - * read operation, so let's use the last entry (31).
> + * read operation, so let's use the last entry (15).

One nitpick:
Last LUT entry is still 31 for all platforms except imx8ulp which has 15.
QSPI driver uses last lut entry 15 whereas 15 will be middle entry for flex=
spi(in general).

The word 'last' in current comment does not seem appropriate for all cases.
Maybe you can update comment for ex:
"Index 0 is present at boot with a basic read operation and last lut entry =
is 31.
Some platforms like imx8ulp supports 16 lut entries and therefore, use lut =
index entry 15."

Other than that,
Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Regards
Kuldeep
