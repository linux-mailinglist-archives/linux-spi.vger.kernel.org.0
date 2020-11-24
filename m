Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534DE2C2094
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgKXI4n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 03:56:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62559 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbgKXI4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 03:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606208201; x=1637744201;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hClvudRZ4CfU+wN8Mt0N7x59bKYYLkcgihgJizm6Px8=;
  b=Ep8zDapxYqny6pPC6vU+ytx8z8EvNuQhm51KF7sD31hCflc6JE6lLSit
   ddwy6UNXGSqaszUEzv5pF1wJs96BR3fFaBg4v7BaceC/ml1zGLyZTRArh
   cdMElIszyXxsV4vok2dJXjoleEiVA84IlAFxhU7XltjhIMmuR5eUkzQEa
   tjCh2d1YVA+HvPxw+51iVXBPEW3XvOnAGf6tdtMX6rGfaJ+T3YHpEJG2K
   MFan2+j+fuEPNExA82f0ozQTIvVn79T2mitRSw5AP9VlMDdPeEfENzk3u
   Rv80I78Mizb3CrPvBDZ7DQ7iVRmgbZM+WFc+94JycA0uGt9c7kK695z2s
   Q==;
IronPort-SDR: vwZTyY5YHfzK+mINzBouOiPQJr/x2ekpV1GYKrzTPxuSYSmEdvG5lExURV7c68V1qasItoSbXA
 wN0Ef4c3Bh2wRhuxNYR85q0FYgps0H+dri+pDd7LKz4jt6YjPrZIUVryj4Qeevg3sW22WzQ9/n
 E3xbriuLPECuZWO2MPsHrrk+K2o7fBFJzzEnutU+XA2xFbW8S51dpjTM+rAm8XlSxISEGc2Ok1
 SAjaIm64rjsm+RfA56JRFrWXiG/xrGyIw8Fm34sf3z10GIxX0CtqXP39bi87nYVLplJc0DRipZ
 J00=
X-IronPort-AV: E=Sophos;i="5.78,365,1599494400"; 
   d="scan'208";a="153393279"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2020 16:56:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwHMqPGCta4IhsnXoPkQHxm31BFD5eYlm4W+IlG9DY3ny4CPwTL8kAJ3Yz6iRvP7ddc6DGGNmhJ/jwvrZfDQPWN+XHQSoxRTmELI/NRSeYlZuBqiB0XP45RhTtP0jtlkBZst8gDOFM19rRkcyGRTyRe/IaKlyE4hjAhWYnIVyMjIp5lPpgzI6LgfIL/hcHA28w1UlNdI+QpuPLX+ox7cJ9HDLekq/F5D2oHiLIpDCXzQdkbemk4WarB/t1y+M4dAf0pJ7QsPKF//H8gvEOYlzjE5rtvvVhG0HjC2Y2MxgpA9OiwGWemGjIjJCutoTpBuSCL205qlVsSC2ZBa4Az0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hClvudRZ4CfU+wN8Mt0N7x59bKYYLkcgihgJizm6Px8=;
 b=Ty8x/fMsdqSGXpSpMNTYU+I/N5/0npl8dGSSl8yTaGewLl+aEXzun/GzkUoUQZpS4XGAzf+DMUyRcmQjaiCw4OTJgSKZk+hAq/ZGPqB35tVHcwBu1j87aeyhODZvs1XUEZx0/sm46rDYH2n3KSl26Ea51qZBDMThvGtZGV5KDrLdkfGJFmobmFnjjgDub7Bk8FnFcTUdZ6GplscyKTS8gB27ou5gg8pGzSLcrPxuY5dF2GQiy94hF77wrm++w/IEi/dyNrd718eISQwoSnspKUflk5K4L3hKx2zWQRnQ8x5I7igypecGIXlSOxpry6m0xvEX4fa7s0NYBzeVPRGyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hClvudRZ4CfU+wN8Mt0N7x59bKYYLkcgihgJizm6Px8=;
 b=jq5jFzqU4AWDLjWkLaTsaQhI7xK7G6ukla2Z0taqtxlEVA3cHcYnMJj1nYQeS7ZgdyeBBsqoy7rAacNwmMfzmfYYR6aY8RBm5S/ng7ott3pU0LjU6ixp6AZGUbAS3XbYcXkqa94IcQEDWLUZSd4nNJjZSZztcx1ffcZiHfiq7YQ=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6792.namprd04.prod.outlook.com (2603:10b6:610:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 08:56:40 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 08:56:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
Thread-Topic: [PATCH 20/32] riscv: Add Kendryte K210 FPIOA pinctrl driver
Thread-Index: AQHWtN4lakjfsgLC7Uq3vn4b+Zr42Q==
Date:   Tue, 24 Nov 2020 08:56:39 +0000
Message-ID: <CH2PR04MB652200854C0486B5875FA256E7FB0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-21-damien.lemoal@wdc.com>
 <CACRpkdZhOxz5NhrkFxZ5G4aOrmBoAcQodOvqzNROQtXpHVQGDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:ccb9:9212:86f5:6af]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1242702-dd96-4721-8497-08d89056dbb3
x-ms-traffictypediagnostic: CH2PR04MB6792:
x-microsoft-antispam-prvs: <CH2PR04MB679238887B4A047341E68B49E7FB0@CH2PR04MB6792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5y8kJv00q/9+kLPRf0eVWm3GgZsp3Kf5jgMKTp7jPtq2X1BDn+yCES+If3wBsBZ8OaWd52IGQDU1ToLiCr9RZ+A95ZkGDz4RoEIa0f4ZtIXZPCP7ZkKvfJeES1LM1BIRBT4xYImANuGjYn7Owi4KD4Nq92HriABdYRzVAvL7dS8ZIxDpC1uUMbEHPy6xMxmdJK3d2qDFDKgtyC+Ln1Zdx/yjxv9+qPcu09Rsow6CzaRJ+DSizFsLfKeWi6rqo2ZGKvrV+38mu7dWckykMFhoFkQpke/AKCSjz8T6d0pyMKXPW1JIxzVegXnexfbXUuL993MbW718nHyPx+J5bORNJJcQpMeEPwI3pR9PJ/dvTUysrDFyDMCCv6noP2HRA1SlG+M9pU9UN+P7ufBjqu1bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(52536014)(6916009)(7416002)(966005)(2906002)(86362001)(316002)(54906003)(71200400001)(8676002)(91956017)(76116006)(4326008)(6506007)(7696005)(66556008)(66446008)(66476007)(64756008)(9686003)(55016002)(478600001)(186003)(53546011)(66946007)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+sZZWakPqIeojs9AHHFoR7j/Jz7ChEwdhJxLlO9yWXZosE/DKCF9NbH/jtGA?=
 =?us-ascii?Q?QlKN79m3ezBiex3iJOasCxqbYOtS44aU0y+Z7TrbjZGxow5CoOVXuRpPpxzR?=
 =?us-ascii?Q?X4DCM20nt40+jvvcITcOOnMMudCXiA/2mjrNhk02kguQJ3b54yPyrChkU9HR?=
 =?us-ascii?Q?6Su+4nwdn7/cgXJNk9FqVUHA76GoN03/6tbPYoBN7PHjUVZDFBGEWgmG0i0m?=
 =?us-ascii?Q?bxi8RmUC0syPsS73c7Gfjxiv1XbXUnTmVktQX3S0MwarQ3dc7hoOcN3vTpdf?=
 =?us-ascii?Q?EVUhztSLWJEfBhBYd5ie53Ac0v6Zr702vRqGljyILF1ygISHsEvXyjdhXb7a?=
 =?us-ascii?Q?SIdUr6TwB16OjNcM1Taj19OdibX5X9dRXhHrOfW04TtQph5n6CMm1zlxp5wr?=
 =?us-ascii?Q?hC/pIBCq3s2JmC64O1naWt2k/5wG0RfiDFvRZqQEqJZ+Oy0LhrTXEFsjm2o/?=
 =?us-ascii?Q?kf8E6rsLXxBS7rf+5ltZ+Sw513PwrNdKMVb9TOapjzPO/8IlhTzhhrvveJrn?=
 =?us-ascii?Q?mczwb/zJ6JPMJHk2ES2dX7feGwE0cY06+aIubQoOj1sXxKqdSXyz+ctgPVBx?=
 =?us-ascii?Q?fsw+Dj3uqYVTfy7lKmK1zUHxjpEFy8Sfn70HP1e9YI0L/QSUD+C5Q4I+BZX/?=
 =?us-ascii?Q?hh4jkBNrf0tn/sAxOpPaZQtNN4+8HNzwJf4pMCsZH6hXyd5xBuNi/Va5P9iq?=
 =?us-ascii?Q?GdfKPNJpDB5i12tEoWsLTeYBnCn4XAw5cf3m7FsVaxtjmBht/JPUjzfYrmfF?=
 =?us-ascii?Q?GiLdNf+P48zKClvfFkCcTHuwV+VmpNjdgCaUcopCrzw7MSrp5cyOJhdnYJaq?=
 =?us-ascii?Q?xxOoz+QHTwqjuZZeEg3/u4p/xecGoMTS0aypRhztZsdbHPCfUtgJgeFVjE+2?=
 =?us-ascii?Q?VmkeiNViG/EgElKo3C/SdXa6Uuf1RKU1ZLH5fL6aweYpx5lBmaVwW7GcEuqX?=
 =?us-ascii?Q?fr/VTPPjyr4kPujjBsIDnQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1242702-dd96-4721-8497-08d89056dbb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 08:56:39.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6CKY7rYXuq0lxSSqmWJzPoxJNUU5Ki3pcl3qoP7aBoaBvCoStgvajkOdBN3GzCmcZRbjJZsCKF4BK+2rr01hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6792
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/11/24 17:43, Linus Walleij wrote:=0A=
> On Sat, Nov 7, 2020 at 9:15 AM Damien Le Moal <damien.lemoal@wdc.com> wro=
te:=0A=
> =0A=
>> Add the pinctrl-k210.c pinctrl driver for the Kendryte K210 FPIOA=0A=
>> (fully programmable IO array) to allow configuring the SoC pin=0A=
>> functions. The K210 has 48 programmable pins which can take any of 256=
=0A=
>> possible functions.=0A=
>>=0A=
>> This patch is inspired from the k210 pinctrl driver for the u-boot=0A=
>> project and contains many direct contributions from Sean Anderson.=0A=
>>=0A=
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> =0A=
> The kernel build robot is complaining about this patch so I'm waiting for=
=0A=
> a new version.=0A=
=0A=
If you did not receive the V2 patches, please let me know and I will resend=
.=0A=
The patches are all on the riscv list:=0A=
=0A=
http://lists.infradead.org/pipermail/linux-riscv/2020-November/003280.html=
=0A=
=0A=
And for the fpioa driver:=0A=
=0A=
http://lists.infradead.org/pipermail/linux-riscv/2020-November/003293.html=
=0A=
=0A=
> =0A=
> Would also be nice if the maintainer could add some comments?=0A=
> =0A=
> Yours,=0A=
> Linus Walleij=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
