Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F59331F41
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 07:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCIGaH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 01:30:07 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:36423
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhCIG3q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 01:29:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STxe36fFsHSHDQsJs/5pUjid6VvzbrKC6cvkSftjYkbEDTS+6r5kvBGagLiJ3ltOoecNnrLpKC396b3Ng3sCyAe6a/AJeowW8NSYHWTDQ4acoQFJzYhkb214FueNxo19gfmt2RGyXVxCjDmDJODUBFWb1WEa6FlmWNmQ84sU3mMIi5XOlt3hs1/8zdrzLLagh3xxNySRxBfeEK9cLmBay7/1hkzsnqenJoKKmgE5gKFs4qi1qMVZq/2MJkJMK/X684UZzba6CTLMr8WhrRSndN337THeEMUyhJFOCgXxLJyVqCzAY0QmdXuhqT8qai6NgFJaPk2EW5hYiNGzT5Rg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbI30dWEme6rGmorZL7z2sOmo6jv7SDSqL160fQ58rY=;
 b=kPfgmPWvjaZ/Yv/PukaXcZi7Ht2/SLCQz2o8KSp00JgSPowW2iuWH+bcbweMsWjfab1bJOwboHlTror1n0ADQMkAGHblFvAZR8QJJNmnK2N05GSwlAou4lXcHfnNLdpsd1WbohtV/lnYFA5MlZtnLSaOJOdJrececIBCHw5s4JHuWCJiQaAqF7Aw4m3KmDsV4D9vmUxJqz7ggHh1JMaIZ0PFAhgPnzEdTiUQW23YnD8NaDFWSci0vSY6RP709BNx/mP3jbjz4vZqfKJ8TYyVl1vxhXnLJExp31MIKmzABA8hxWBlDbu77w3Gj108SkhRDmzMPQOkfuIdf0+4M5TPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbI30dWEme6rGmorZL7z2sOmo6jv7SDSqL160fQ58rY=;
 b=ZHFvk21xeOYkoh5wo/X+7XK+fAD8m+crXTboiE2KyskJw85XYTz8PgwWANSLL3+uZYtddQ2TcJT/0OVK/wQer7lo/omeioShPvaVx1VOJaYnoOvjZVExf4xqtT/V9zs8XO0tHYCUVnGQG3I/lVpPJEa3wYzLyEJVAxLkB7uKOyY=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Tue, 9 Mar
 2021 06:29:40 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 06:29:40 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     "hs@denx.de" <hs@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
CC:     Ashish Kumar <ashish.kumar@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for
 imx8mp in FlexSPI controller
Thread-Topic: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry for
 imx8mp in FlexSPI controller
Thread-Index: AQHXFKW4s58kNKH0jECKpV1fGZtOvap7J56QgAADu4CAAAIckA==
Date:   Tue, 9 Mar 2021 06:29:40 +0000
Message-ID: <DB6PR0402MB275899B5183869C7D471118AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210309053116.1486347-1-hs@denx.de>
 <20210309053116.1486347-3-hs@denx.de>
 <DB6PR0402MB275838BF727B891FD6E2A62AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <290d37d7-7362-e00d-0e19-5fb5b78a4bf2@denx.de>
In-Reply-To: <290d37d7-7362-e00d-0e19-5fb5b78a4bf2@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [27.58.231.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89aed073-fa50-40a9-2ad3-08d8e2c4b830
x-ms-traffictypediagnostic: DBBPR04MB7787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7787338E278DF880E268ACF5E0929@DBBPR04MB7787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvY3KGrvTY5bC59DjaDp8X/3pU/qy5OH0EPYQYW64ha4t7C+ZYt6N75QmHLGva1iRn/tX0zdroo5XKHvxiw1n5G34P7zeihgd8w/JHR641BXSDf/k0RnQzkYvR8gfvNuzz8vtqmAtkG77lOhqtCgSkm++RjEtqwEovXFtuXTBHT9bKm5AlyiI+gprIUKtNktynIQXpjZ+5UB8IV/ExoBux9YQUQZwpE5ztQ9A6nfrJ/e7yztfO2ckMl9UixREgEIxgVjnuIK6dhSORbctM/cXZxvPLrHOWsRkD7wm6HIPnlnu3jL3NDITVzpmLmqog3vCS5Xv0VfNyI2VpFacyo7M4jr7FXKD0XgaCOEVSMgtoGssP8bYF1p9boPJAl1XwdIbW2G/FGTxTiL/EDVKXXjGTQeHr0mCFi4vvg2yIQaimPgdMDVr6zHx7fif0QzJE+yUizVIVb0AJYW00BpiGcD7xpCLI2LgA4ibKadGnLeMldbFSEeNeIw2ZFtZ8FrsN5x8SwyNB96uqxhYVylTgUGQpu3pk9ARy+sryYUTdIvuc79h4+5lR0irU45CSlqyb/R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(4326008)(2906002)(478600001)(54906003)(5660300002)(52536014)(110136005)(66946007)(186003)(8936002)(66446008)(83380400001)(76116006)(55016002)(64756008)(86362001)(26005)(6506007)(8676002)(44832011)(316002)(7696005)(9686003)(71200400001)(66556008)(53546011)(66476007)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dfbh2kldlLFFNeHzPwCaq4nN4XiE8HsAPvGTCLg/Yoll9S430YBxkRP2g4oY?=
 =?us-ascii?Q?MYycICWJpsE+eJ72rNR4K0iGikhOBomiEn25/4jEZwyEUGqIYOXtYLaiTXuu?=
 =?us-ascii?Q?Un++hIH6L0KIPCIoSWIpN6+jxUX46fmkE/w7N+xtKu8KjAA7bM68XAuFUpDO?=
 =?us-ascii?Q?gg3seuIjDtdwUQ9g85exW1navwuyvPM91E/XniehosNvyFDntwvP+cp1I+32?=
 =?us-ascii?Q?erW+s1rH2lRpD4GuJHxIH52F41hByZzKsfTuxtUpFXkS2/FcA5vVd/ZAU4Rd?=
 =?us-ascii?Q?h4kan4LSAaabSrqvHBmus5HiR9BGEmIfMf6gNgz/vgck/HtNAzByyg8Q/soc?=
 =?us-ascii?Q?7NIQE7W+/a+tHv3kBdXmuPnI0pP1N6rTlUSnpG190dlMFJTNfP/0hvHHAxZC?=
 =?us-ascii?Q?5Xa3D8W6txTXh7t8htSAMeZQSmop7co8TgTx+hsMErWzBAWplNEQ9PxNiGfD?=
 =?us-ascii?Q?zA95LAf0USq9oX6SMFH9mUz01qJwQpqVvhh4wNI32MNjCJmQvbVpndZKi0g7?=
 =?us-ascii?Q?j5kAVbEEeqEl8DOf3S1KG29szVUCJ9JtTTYyE2h1jDvP4kCvRrDleQ14NRAG?=
 =?us-ascii?Q?o8IFUF/V9dWxh88KsSUjwRO/ZySmNvp8ecXZLEIabJPsQXuOoqkkp+hL3j+c?=
 =?us-ascii?Q?KbzM+jaEeEwn1lpRwCIk9kNCy1G7adIAFIYmqygUO0MnasBHGvxWlD2aQi6f?=
 =?us-ascii?Q?ANdmA7yBTD2ai9iDZCc4ONrz1OsVIprS6RA5TArusLDgxh6td+vBgWE+maqH?=
 =?us-ascii?Q?b/pSb9F0yi/T+2BRJIB2PO2W2K+3DQZWaGo1KoBiJqpCOiM6gMfeDfnX5rZ4?=
 =?us-ascii?Q?lEXH1PY1UwhJxmq1I5bB04vqrOwFEcPztG4uFmbabiHJWpJjpHRUVGTPg9OY?=
 =?us-ascii?Q?LySKODl24o6JXYyE2Bl/HOWYwaVwExotd9iiCCbub2XXSb/0JvT1F3wTRpE6?=
 =?us-ascii?Q?pJ0bdf/7OFapQVXgjyHk8GMkIpvDhr1m5/jB2YG52ioH62wlwk5zDOIAfO37?=
 =?us-ascii?Q?CQPzFb50K9QyLD2n7fTIQYOQ7axydszRJ0YliXHylFVGJ9sZCU+HrDl+Icim?=
 =?us-ascii?Q?clDm2Hs7Sf/kLr2CKrUk3wdeUe49GOigL/zyYOEC8Bi9IiYHsWLByHU1iXwl?=
 =?us-ascii?Q?eRsRSAdWd3avgxD62HwE/kQE3IWW9Yi1x6PJkKoW6qGPA3U/9RIXSBbTgR5j?=
 =?us-ascii?Q?HZ2AGjsRnJo4gLg1K+tPVZO3NOGCI5J/vnw9StfhsdzWUr9Obt1jeHmbiQm5?=
 =?us-ascii?Q?Oq3qLWIJsa6DHniKhiumcl7Ph8HMsiKD4Q38myroyY0f98AAolFmdk370XYM?=
 =?us-ascii?Q?kFxFvFSrkNnqQSuO74ZEM6qN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89aed073-fa50-40a9-2ad3-08d8e2c4b830
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 06:29:40.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0Z3atH0Vk3XgQzYRTxNKD/F+/YoaE/fSkzhDO8y5pbyZDbApl7t/HIdGu0p+4i7jjGadpFdi+WaNJSps2e4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Hi!
>=20
> On 09.03.21 06:56, Kuldeep Singh wrote:
> > Hi Heiko,
> >
> >> -----Original Message-----
> >> From: Heiko Schocher <hs@denx.de>
> >> Sent: Tuesday, March 9, 2021 11:01 AM
> >> To: linux-arm-kernel@lists.infradead.org
> >> Cc: Heiko Schocher <hs@denx.de>; Ashish Kumar <ashish.kumar@nxp.com>;
> >> Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> >> Yogesh Gaur <yogeshgaur.83@gmail.com>; devicetree@vger.kernel.org;
> >> linux- kernel@vger.kernel.org; linux-spi@vger.kernel.org
> >> Subject: [EXT] [PATCH v2 2/4] dt-bindings: spi: add compatible entry
> >> for imx8mp in FlexSPI controller
> >>
> >> Caution: EXT Email
> >>
> >> add compatible entry "nxp,imx8mp-fspi" in NXP FlexSPI controller
> >>
> >> Signed-off-by: Heiko Schocher <hs@denx.de>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >> index 7ac60d9fe3571..fd5f081f6d91b 100644
> >> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >> @@ -4,6 +4,7 @@ Required properties:
> >>    - compatible : Should be "nxp,lx2160a-fspi"
> >>                             "nxp,imx8qxp-fspi"
> >>                             "nxp,imx8mm-fspi"
> >> +                           "nxp,imx8mp-fspi"
> >
> > It seems the changes are not on top of tree. Please see[1] for latest c=
hanges
> including imx8dxl entry.
> > Snippet below:
> >
> > Required properties:
> >   - compatible : Should be "nxp,lx2160a-fspi"
> >                           "nxp,imx8qxp-fspi"
> >                           "nxp,imx8mm-fspi"
> >                           "nxp,imx8dxl-fspi"
>=20
> My patches are based on mainline..
> *   144c79ef33536 - (origin/master, origin/HEAD) Merge tag 'perf-tools-fi=
xes-for-
> v5.12-2020-03-07'
> of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (vor 32 Stund=
en)
> <Linus Torvalds>
>=20
> Should I post this patch rebased on [1] or may all patches rebased on [1]=
 ?

Hi Heiko,

As per cover letter, I can identify that first two are driver/Documentation=
 patches and other two are device-tree patches.
Device-tree patches(3/4 and 4/4) will go via Shawn tree (git://git.kernel.o=
rg/pub/scm/linux/kernel/git/shawnguo/linux.git)
And initial two driver patches(1/4 and 2/4) will go via Mark's tree (git://=
git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git)

One approach I can think of is to send driver patches first and later send =
device-tree patches mentioning dependency on first two patches.
Maybe Mark can comment here if he has any other opinion.

Thanks
Kuldeep
