Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1E2C206F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 09:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgKXIxb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 03:53:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63988 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbgKXIxa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 03:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606208175; x=1637744175;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eB1HFeqRNnBzzC3aP4mGPfRsz4C9/ZWlYG6EkqjI7jg=;
  b=GdiuakOeqm0Bmcc4PaGA2Il2PAKSoYA0EZfOiG0h/FTzhsErclMfDsvp
   1eBoGcWOr9Qg04eY8dqnXH57i7BLJDiDFYpP/6mmwuaRDHCLAnZXP/idv
   WbCxuoXz6HOUZSx60HNsWtlO80qk5zqbI1+c0O5j1q/hIx9DYLaZ6DyIF
   dvyCQpqy7/FPwq00RpdSisvjJxqlcjdR3MxF0sGTrrQz7jaVPmIlkMSyZ
   NyK3h7ylOv+kxkXhqJB1u56/uDSUPZ/fvEG3uA2pxuy9chEjMlY3B6poo
   cq+9L3LfhKab9CkbiMVCWZ7QtSYzdhTV0lxSK4HRKVOQCccMnaLIWdt+o
   A==;
IronPort-SDR: 3uZ63IBfSPCR5o7I25lmbXY6wfnhbnnh5kYsExCNadx0e6aNOr7ixg6K0u/PgKmewOKXibO5Sq
 Z7gXRvSWnnKgk9WqyGSyq3eySBp5ZNIAU1xTmH2bLIOIpOa23rU8OsoT/T4iXkFljt0a7uyzVb
 WG1ACzAcOaOHWHtK5mcUis2dqOuCWhdcxMH0SNjmNfxpsmX7wd4dYwPuVgHLPQZ+AfbHvCbjUn
 p+SJLtJOsPp1I/71CGScfPKuq/4nbMc4G1RXToY6pkv6BnXHIh7L0wKf69jUCK0cHwp0eoTo1S
 DeY=
X-IronPort-AV: E=Sophos;i="5.78,365,1599494400"; 
   d="scan'208";a="256942319"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2020 16:56:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoJiYqgvDCxmpUg8vnWKUCu4y4WqdhfvXz2rEcU0qybLsfVRu9LlzCB79thAupjABsc2rLIafI6Z8gfwnIc4rJ1NdCi8FWHBIc2R1Xxw1L/JGlv2x8OUi20kfeAGOrgWEmUlHue2EMHGGIx7Iv5Nzcs4S8u/r/Qa6OX/ddwfYGxILoVOutBHqbVH/kP0mpQLQm2WA9B2cTPXUbDMEBBmmKX/FP5MXNLANj4joO5DxmZxXyrohud0RaHJJOn2B0hIYm4qw3tE33gp9jNtZFrChLNNajTDB1mGn8OyJak67cak/iTtQPvbthRSO9c818Jy2c2sjF2iJKMBWvol3Zg+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB1HFeqRNnBzzC3aP4mGPfRsz4C9/ZWlYG6EkqjI7jg=;
 b=CeWiEkNwYaath16ypjyNHC3pfHDP1UoBbig+rw1zl8HYTb8zvee6U8wINWfHhRPdyujI7A+NpuvGst+vyDcnhZ+ESLdKsX9NQQO5uKHWDSiu8BWLIPIqiJ2cW1+5WHJMyG61VX5ZUzX8aYvpDQ/OAg5YXsqXLYwxjs41/CoscNOo2yqBMkIb3PrqzbmEFXGEChhju1ipFAp5dCBlpnPEyv8mU+BfaQST7w3pEKFpa7USN9pZlmZv47BYYxlQreufHufIVna1HJ5ItL+2LErv6irdIdjHb9emxdNVgmsAlzjtMCD4s/MJ1nxur+Cq8CDknV811KQ2dSeTxdNNkpe4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB1HFeqRNnBzzC3aP4mGPfRsz4C9/ZWlYG6EkqjI7jg=;
 b=d+OPrxa6NFNJmGlnIUlYdj88guUUeoDSeFX5MKxsrmab2IoJqfQ3ptPn8ifVjELJVzlufcGe1Fm/T+JaZkSqQeE0ixxDnRmphSF1hP+vP+3EG7dL/z7/gDIImC82tvSc5IvV9GT+peJz6f5RGtziAtFtpeehl8dKMsHA5le0wQA=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6792.namprd04.prod.outlook.com (2603:10b6:610:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 08:53:27 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 08:53:26 +0000
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
Date:   Tue, 24 Nov 2020 08:53:26 +0000
Message-ID: <CH2PR04MB65228DE061918A4D2A08A0CFE7FB0@CH2PR04MB6522.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 4849a9ec-27d8-4d70-091e-08d8905668a2
x-ms-traffictypediagnostic: CH2PR04MB6792:
x-microsoft-antispam-prvs: <CH2PR04MB6792928B1FCB66FF40B41D0FE7FB0@CH2PR04MB6792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wSPSmp6eS58E7srcja9uosX0uoa+pSSTffVyJeAUgvCX8ihoSXHDqdZLeusFiu6Mqfz/3Qbot/7l0+X4G3qo2IZwq/j177akMeyiGD/NyLTXGEVyR9qLi+iPajZDPAtvBqKC2rB/EJrfwFyRPtWNGd5BVgWztvvwqWAlgGpHjBqjUVJ6y7BRm18A/4aaP6qC3eUspeMEhBIXGROLyGlo+ZpRQ6GeM4qf5qwJDkieNkJ+4LECGuw5HV4rG4UDQ3sdMkj2LV3TSZc29aUj0Da3EiRwuLGmbatgtZe8VP/UPtYTAtxnkChRfJZcYmfw1KT2OneY2xCnuNbcs98Bn8omw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(5660300002)(52536014)(6916009)(7416002)(2906002)(86362001)(316002)(54906003)(83380400001)(71200400001)(8676002)(91956017)(76116006)(4326008)(6506007)(7696005)(66556008)(66446008)(66476007)(64756008)(9686003)(55016002)(478600001)(186003)(53546011)(66946007)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UtmxirpjpLmNU/StNSWOoVtB88I7Xc6hDGJomOGQ3B2jpCS7qw1DT6HU9NSs?=
 =?us-ascii?Q?AlPEzFjKnQDDSnf4mRVgHLaU3JuVbTfI6MVI1x6WrxhnlYi2BlTskreR3FK1?=
 =?us-ascii?Q?gGN8faTHsR+17aPPRc7l0vTn784O0XEOkBk8GT0+nX+/PIjR8xZR5QryMSvt?=
 =?us-ascii?Q?kW61Cf5lNikCNNcQuOY0kBmFo5C6teTW5RdknR2NlHTBeLPnf/x27hrMHjFz?=
 =?us-ascii?Q?QzEJGy5JQcq8xI7OVOyjUsfJ3EufxZC2Fx1JLGA3iQ+rSavWPbMrkD7RACEH?=
 =?us-ascii?Q?RLqfuAOid+87GrbuqA3UN0+3dLnCGs7VHQ/uDZtNlf4Em07eyDG0/WvkE8P7?=
 =?us-ascii?Q?mCgP8AXT+Q2Bw3gNUAkoOQjZzGJPrQ11poUaOreLnb0XAgzIYeSdwuDRQz39?=
 =?us-ascii?Q?MamIqYROzr/vw+ptf6DTgaO83Ll8/5zaOR9B6tycsQWG7L4ef8xhUaXuftcL?=
 =?us-ascii?Q?dD/N8ESu7Cr7YlgwWiK+vTRehAi1WNn/qP38/FfQrmKwQXoXCB7rUJOteZwh?=
 =?us-ascii?Q?+OUsUw2tvsbXfQfDYks+EmnDBkfRv1mqJeCZtAjsE/zkPzhgQXcTbQew6YNx?=
 =?us-ascii?Q?673zVoQm4BiU84YQ9PLN/Q+zAx+PG/NOCQf/sHKbVHeVUgYehG3MHhmeUjOS?=
 =?us-ascii?Q?mX9WczVhCExPG/vWYDbO3CEoM5UAHxivbckJpXXbtQRMYg1+AP1gGCMEqoAO?=
 =?us-ascii?Q?MYq4oO0jXXssLUC8ijWJdSZyEYLROAHgpqBfBj7z1jAK/UfamKsM3LOmR75L?=
 =?us-ascii?Q?cMPQ4Who4JnjtEqTZa3rWEe2UdUDK2Vbv88Rr9/R8Z6PXEEVQ2UvXDRCIgH2?=
 =?us-ascii?Q?9MumQ8bZ+J4eq96+TzU2mh0pUPXRgAt0hnovpQcZOiQBs54+btRLdgcEvTWz?=
 =?us-ascii?Q?1Bo9mxGeHYFhKMOE7z/ZY5HaHWyGr/EV94DQuexoer1kehcfZgzhxfsTjwqN?=
 =?us-ascii?Q?+51g5ioKUEQJgYk7+ehTWw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4849a9ec-27d8-4d70-091e-08d8905668a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 08:53:26.8717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPoexknNN0HKhdFs2yZg/qSSyfynHH/ZvAxXb6tzvFrKgFWH9JzhHjByI9DpO7uGItVTnSgklZscN0Yxc1HDaA==
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
I posted V2 of the series earlier today. That version addresses the build b=
ot error.=0A=
Note that checkpatch throws a warning on this one for the K210_PIN() macro,=
 but=0A=
that is in my opinion a checkpatch false positive since similar macro=0A=
definitions exist in many places in the kernel.=0A=
=0A=
> Would also be nice if the maintainer could add some comments?=0A=
=0A=
What do you mean ? I do not understand. scripts/get_maintainer.pl indicates=
 that=0A=
you are the maintainer of the pinctrl drivers subsystem. Do you mean adding=
 an=0A=
entry to the MAINTAINER file for this driver ? I can do that and put my sel=
f as=0A=
maintainer. Or do you mean you would like a comment from Palmer (riscv arch=
=0A=
maintainer) ?=0A=
=0A=
=0A=
> =0A=
> Yours,=0A=
> Linus Walleij=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
