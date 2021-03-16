Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92AC33CE0A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhCPGmt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 02:42:49 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:46861
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230385AbhCPGm0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Mar 2021 02:42:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpEmyw53Vpx8WMmIW9LpKIICgBtGTMyRygPAfiBTsT72di1o2QxAf2THam7iSjvXkMKKnMVFSl3Fs583KA71UW1YHDO7axZT6W1LiOw0oADcD7FCux3MXs5gF3UiVr7HuM162CppsZ9CTMxNmMd3CnLG/J/nk/riJ4dnImEeyUyykOyMst4jCwfO5ifwqZBl/thJ7iS2usCi9jGiVZPj11WDCc44nMROxLuREujtc3g2HxVH9ZpfKZIiZH11er3XavFqsEIcyoalibwhE2K3B0qIVwI9UhDjgPIQ2fOKXKku07YakF3nQl9pbdG22oYnWNaUMaOOlT6jgSP+2oHojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kotEWciMuVcCTxStL+MFLWlEZhjUREv3Pf/3Yk5BFk=;
 b=NY7a5S/FCdGoNXbXAEVcsVpdmoT+mua1LohxOqAUyEfkVN3B4CD35LCXmbbkvwfmvGA+E88ed6/NknaFfYhJHNh+JHXXg1Y7/j7vT0pVDxBhUvlVRu+OMgzyjjhORlVbIVkAciX1ZRHbbHaKtqFcrZ5vmopEA7rk5jfr9YGyvONH+FwARYHv94PuNxMgPmf7RDCi9lyplz9dvX2zG7LLI62VnQ6R4fmFRDO39cdO0pYYgWhPuwXhmeKoAyns6T1h+QtDNPO+1O8O8EA6VRNR7/Vl5qwR1bmtHH7jM6nT6jmqMKEZvk4vWkYcKSrveW/wVwKEuL5RauxaluqgKzkGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kotEWciMuVcCTxStL+MFLWlEZhjUREv3Pf/3Yk5BFk=;
 b=Cy6797fv3l+/Y0rNLaPk5dih0MQ7A288CjlyznWx7c05C2vBFC1YjvJVrIa8vJJHtgjvCeMUG7NmxIh2igoIG4MmJsBk9EW3wuypJ6tMWvKIKT2AhSzv9rpB03K7Z/aBqxUw8cGfLMbEcyJeOyZrDhA+fSxNPqNen3QdXcLhPtg=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 06:42:23 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 06:42:23 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Heiko Schocher <hs@denx.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH 0/2] enable flexspi support on imx8mp
Thread-Topic: [EXT] [PATCH 0/2] enable flexspi support on imx8mp
Thread-Index: AQHXGiHilVAG0/q0oE2pkR62eySgfqqGI38w
Date:   Tue, 16 Mar 2021 06:42:23 +0000
Message-ID: <DB6PR0402MB2758717E38C20E7BFEC5FED8E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210316050425.1758778-1-hs@denx.de>
In-Reply-To: <20210316050425.1758778-1-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [223.236.221.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a317c45-d598-459e-8370-08d8e846a7f9
x-ms-traffictypediagnostic: DBBPR04MB7787:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB778707940AC3CC5B3B717D9BE06B9@DBBPR04MB7787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E95yjg1YW0nCvxP/vJMSxm25U07zbVtxo/a7XdgpFYq3lRPLhsochoTFjzrnq0fHMmwy0MRFvWoX0cBzVqG47UftR2PIhW4eJPpk02B4qVRsuUwg7qOVVTN7AjgoDN2jiQklahcic5Lk+53l2n/Eie0bt5RASoT0EDJU7H4WwaX+ZVs3fPU70AMhx7H0g75PyzsFAxWe0E6bxMrTvdoydJaU4xxrdNpwkQ7An9m/enok/fEwu/Fx//jMjzqMbHv+KdUIF5rmbd7Yk0mWgJbdj5TiLdUt5HHdZXIM1HZDqGawzjFFbyExuR1qVnJjUGdsvrz+GqhLEqIhGTpIE++oICgmwk6Ula5oZhp19JWDgPpnQiJAN1SDX9xTBaoGA1H+phTqMi6dq8QKdyg81FI0Pnp+/xEd52BKtIYqtzAVUtFb+TH7gywfEioiKoq6VLVk/UZ1V6VhCQqVsc9W6dR8R00wipe9IMTVKugqk0bejYbiX8WS3SMiRTOu8JDnJn/O/5JD5QtAlYBeDu42dBXLmaehR+baG/8VIQdFRdf0GrdL9qsX/s2Xenm5RC4l2k3+rcVkIb29qcz9g0XqNCY11zNOFG4XxKNC3NlKqdwFje1hSHy6VkdiZwB17HNKb51rc6FMWTcUs3IaBqx5QgIIRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(4326008)(55016002)(316002)(2906002)(71200400001)(54906003)(26005)(83380400001)(76116006)(5660300002)(33656002)(186003)(44832011)(66446008)(9686003)(66556008)(45080400002)(110136005)(53546011)(64756008)(6506007)(7696005)(966005)(478600001)(86362001)(8676002)(52536014)(66476007)(66946007)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pT4ul0HF8+zPUIT1t9GK4X4MT8WxZCSWamAQPye35akKk8TlH1twwax/ZCn7?=
 =?us-ascii?Q?xtfmLOPeawKx5h4Z7JeOc/UygYNGWEWRl3OGswr/UNnUokaLowu0NkvAD/wX?=
 =?us-ascii?Q?A7HWTbf+EfpmoZAzoPlyTXUkXPMyugUuUln0P/epKuHzoLkFJh3MVa3i+6au?=
 =?us-ascii?Q?PCeleWr8FrR0Lkzd4CvxDjo7eYEbvzLPRmwj533KQ/5i55MIO7Y9H0IQBFfs?=
 =?us-ascii?Q?8LK+x242BgVfGnnr+Wm9n14V+i6HE8H6OBdgs/5dBLbUKA5lLUUYbTrxz6Gw?=
 =?us-ascii?Q?HJOJmZXXH1OkepBn+xRbfJGqJo+/hLMfuFxwsGkunJ3iHJl6xr4ljWK/ZjhP?=
 =?us-ascii?Q?mx5frZ31pdthxTlp7Tyqy7D+vaQWm2LEx670Ykuha0NPx4fOqD8QlQrjWsfo?=
 =?us-ascii?Q?Bxu7VAOt+66DzmpExMH5f3V7E51XcIdCFG1rnnsrWJ6PSrYY7h5NpwjXMFat?=
 =?us-ascii?Q?m5xuL+EL7rmLs8SMPh4PPTFX+lwgUp5TbkGLXDXEDTRUCrq2b3AVjes5hbSS?=
 =?us-ascii?Q?bJZrjqFCw2ssqTMRIm/Qtr7stx4gmRaCGvB3zitas92BF26aOvZXk/8ki6FW?=
 =?us-ascii?Q?d7E2yRKUMQHpkNYf3QtTNcT/3GWlss+Dkva164fWhZ0iIWQIpHMjLu0bb537?=
 =?us-ascii?Q?Vuz0TlSwZdZ6LMZU/cQtad3zYtclRibbRj9eXty+klJT/2VLPh/C5co8p7Ck?=
 =?us-ascii?Q?wEeuIpLlusP/CEpZ2xfPnJpV7uOAWD57Jw56fDPdK4N4prRSyJkxxlEKuipU?=
 =?us-ascii?Q?JzMnmrjxnSJE3rY1Pg7aoAX3i+Jaxx+AhtoXyNUdjMyBj54TX/my/ZE1Y/Vz?=
 =?us-ascii?Q?ic3o6pVJA29+G4Y9+etDHO9aGmk9swujm9YwT5VoNBd2wIJZkhlcqewnNh8g?=
 =?us-ascii?Q?LidTRbltOVLZr6lJNjlksN57KCD85gHsSOiyni95tSkx4mrri6GmYUTyM5PS?=
 =?us-ascii?Q?pAoS8iPXr9uayvgfRPcsnIQvbJRW5LkzV/9ek9LGhcQlq4+b4Q8vLJiyaJ6d?=
 =?us-ascii?Q?vQ0LCMMhBPnfrWt/egMgMIk7wFIDSbk+SIlDGUXpbEO1vlJyQX0fANfgxqeL?=
 =?us-ascii?Q?bPUl/2lMEzwcsC+ufPYIJ74IDuVQyZcGNarq4fR5Nxqoq5rKWYS+bCU/R4A3?=
 =?us-ascii?Q?MViUnrUYAniQ7HXtn/+zZIiZCStn1FNYtQEfXFHO2cHHTD02ZvQDTk+08Xcs?=
 =?us-ascii?Q?pM5alFl8xJ2ftxyfHBiaLFNc0j6TAqSA96tFVMEL2A4K83XlQ1ujAJYzWyeo?=
 =?us-ascii?Q?KUV7QPjiN2NKPG5r+eGEd9k5LVirxlz9I4jxnSlgWfa3mbj/ttNhtXOoiMFL?=
 =?us-ascii?Q?cAba0Mmxl6eNah5dyh1ApNry?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a317c45-d598-459e-8370-08d8e846a7f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 06:42:23.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZF/0GcpDJ7p+3uTaDz/1f0fw1HH/eIYzt9Hr92e5RDJuv6VyeP5/ewQo3qE+McsNRufmLtfQoVYnciVaNEJByg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Heiko,

> -----Original Message-----
> From: Heiko Schocher <hs@denx.de>
> Sent: Tuesday, March 16, 2021 10:34 AM
> To: linux-spi@vger.kernel.org
> Cc: Heiko Schocher <hs@denx.de>; linux-arm-kernel@lists.infradead.org;
> Ashish Kumar <ashish.kumar@nxp.com>; Kuldeep Singh
> <kuldeep.singh@nxp.com>; Mark Brown <broonie@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] [PATCH 0/2] enable flexspi support on imx8mp
>=20
> Caution: EXT Email
>=20
> add compatible entry in nxp_fspi driver for imx8mp
>=20
> new in v3:
> seperate spi changes from series:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
inf
> radead.org%2Fpipermail%2Flinux-arm-kernel%2F2021-
> March%2F643289.html&amp;data=3D04%7C01%7Ckuldeep.singh%40nxp.com%
> 7C5da0c3da3dbe410baaf508d8e83903f4%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637514678868305498%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3D2uy0EKUh4Nt0BceSQbIkCZDfakid3wx5uwebw0DhEIQ
> %3D&amp;reserved=3D0
>=20
> into own series as Kuldeep suggested and rebased against
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 144c79ef33536 ("Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07' of
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")

The changes are not on on top of spi tree
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
and therefore may not apply seamlessly.

I recently added driver support for imx8dxl which is accepted in spi tree
And these patches will cause conflict with it.

Kindly rebase these patches on top of the tree.

Regards
Kuldeep
