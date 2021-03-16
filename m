Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5723133CDA8
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 06:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhCPF4Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 01:56:24 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:42496
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229873AbhCPF4F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Mar 2021 01:56:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOiUipaB0vRqukzAcWxDX6wI7Zg58bF0Jt4F2Hee9883mrXYgGF+Q5zchwHCA+83i2v/9XoOyzPOvhym1Hi7ix0dL0MJBV55+oVqKYydotM88Kcs4wntBDAUmI2h9m+RskBeCSveFmKjkso/qwdqd0lZVgKNXFhNbNKVdB29LSvO17JwhVYMdzkHmXHpFQKOlzKMEmo6E0reTdpigFy9AyANUiui1sj8g+kLBnlvqVxmAQPSJYNLGhcDHj8qqHxy1KxzbOrZgvhbi66NGTuCN8t7HueViE0OUAt4OCnhF/Fbkb3Vl0C0if5gJPTRzmpb0zxyfXL5k8KP97lHrJ0eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfrZGZ2AD2LLrzUDMvMHTfG0XEqT7tGtoqz1zpltbfU=;
 b=ijpqtuAP9qhiW3tyoBbex12ROIWphnYg9Kk6Sy4T1SSZhl+1EoxtGSNB1Pqw+RKVty4cYM5bhOK5NvgklmnjVCMrcXwF/CjSyZ8MQB7NWndzHn3mrmpSZbnup0dThV7/FZY6KtDsQGbzJcmwoqzy4rWhksliGDE0iRHL/4kHM4HheV2xqjKmXFm6iVauGsYLd2eAE6347z0Sx5wsTYPVrvEhnbADkuZe2EVpCHsCEKP2HIpiTF/27KBETb+N+Lb6AWZeqKo10ly2DZJR7SYM4M+V1xWk2+j69N02kB2Bi02U2wFqLsMtR87ZQ5k/AF2tfRZQg6UC/RA9Y8H7h+5pTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfrZGZ2AD2LLrzUDMvMHTfG0XEqT7tGtoqz1zpltbfU=;
 b=QTwZlRsuXhQuywVUTvON39H94HEX7I/ENX6r69NQA7A9v6L4AzIST0J8HlEFPUYa/nuFjR/JRIbByx9igWWK+XIGasWNa8C3uZDJlXl0YOT2TWmZYYFyEUy5g3K0q7haTK9tr5v/H85zwZ1LfjCbhd583jx7o7d2FM2OpkrR+4g=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR0401MB2534.eurprd04.prod.outlook.com (2603:10a6:4:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 05:56:02 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 05:56:02 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Thread-Index: AQHXGZTp77oN99ywtki2W2/Bm/x6J6qFX34AgAAK43A=
Date:   Tue, 16 Mar 2021 05:56:02 +0000
Message-ID: <DB6PR0402MB27581D0E1BB152AEF6DA2BF2E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
In-Reply-To: <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [223.236.221.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76a88ad7-1f97-4549-e8ba-08d8e8402e38
x-ms-traffictypediagnostic: DB6PR0401MB2534:
x-microsoft-antispam-prvs: <DB6PR0401MB2534D6FA4C22C323B462A777E06B9@DB6PR0401MB2534.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nnwa1Vq5/XZ9JqX6q2nUuUUM2odETdLbvvh0x8HwuenEjhn06IHwgEx17TDcEJH9h9ut2CMgmUW6nfWXweTqeyacpohyMvHAhUo8un37OUHY6uFs5BKVNUlzKkmSsXNTpsxDvRriZQLodVVDs6/4bRQ8Loh1Y/oZtDajuCtbHBPa+bvxR5bvKhGM2QupAjDZ5mvY8Ln3I8aOVTqwviAjk8QHmfDwT6VDn77lc9WFelL09xGL4IyZv3g9Cj9X2E34wtARTMI14TBAdQYbAOzxax0il8r5lmpvhuhvc3wWLX3ICjKZpeHUXTgdVCrneJhvIOJnpt+NxrPkde6LBOSNmFolt6brWejzsMNbpZMNR+v104KjqmydYVr4YbCDvjo0c8fnAvEJaYb5t6LwvN44OTz5zgDbwxrwsEhShjn8N08NOLQqHRChlHJza3jUgcyn1RAqquJF7GBGWGlBTZoBl0nHhKLIV7l7P6mnx4w2WkUm5MV3r2OsPl0BPYBxJXIDb6O26vMRhbJPRiSTs+85PcpodBXEq2XITlLzterdLXe1R3saDWr4N9C4894Wf6U0xcnKlzWuSIYCfqf5ArVr9pRt+otdTNadVvpm8c1DvgVSfJ9uvK1CdzyuRNj0cwvh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(478600001)(4326008)(76116006)(66476007)(6916009)(33656002)(44832011)(66556008)(66446008)(66946007)(64756008)(71200400001)(9686003)(55016002)(52536014)(186003)(8936002)(2906002)(8676002)(7696005)(26005)(86362001)(54906003)(966005)(53546011)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/MThq3UhR+d4ai8MFbEYzWhulAYcBedqxR8HJFxEPVSM9uSxHhTVaLWQDCcb?=
 =?us-ascii?Q?xt9N9+ZV+fPDgcdxfMHMPEfdBnIF7m8J/LiaJzbQmd/w1ZGt6OGtnV2ul0j2?=
 =?us-ascii?Q?tydXsWXviexMF9m+ihJe8Jq5CGd5BJD/nOAP5hV9lMr5LySQJrZ+HRK5oHUB?=
 =?us-ascii?Q?mboLludujqhBpYtE1BCUPeMhRvEfgPZXHJ5zTNO1DfTgDI79vIY27QrrnaaS?=
 =?us-ascii?Q?2agyRrsjeVZALbBJ6GGWsGGALEKrylaxuq97RUHwhHREkxcDYLYPpfocH6/+?=
 =?us-ascii?Q?4OwzlKDRgIaERh92prjVk21g/+ZE5R+MO8q7A7XhTGWQefrWZL9XxnAo425x?=
 =?us-ascii?Q?svkq2TCUVV3dWkTWM1TfnmYdubJXJp2XN7OQVMg/rzTBP87VxTG0BqTO7ei4?=
 =?us-ascii?Q?+BfpDT11fDJo8KbfTagN6ZJ4nUbxglM2E8UBu46qRDwhLHEAsHr5hypuB+9Z?=
 =?us-ascii?Q?OCeqh1u1Z1b75tHGLeJ/5teLE0vZtAa2VLKBQ0iyu2qLOXZdd7T8jvO06UNS?=
 =?us-ascii?Q?nQtrc8ZmovOLw0BPtQrWIGDmNKBv3w2vo8VW9fjEYSU50cfhALvsLEk9Tuy9?=
 =?us-ascii?Q?1XaZ1fFh/nNtQcDVoMW/BlrA0zteodHoqMuB81RRjsgCEECFGYdGGd5m+x2P?=
 =?us-ascii?Q?1f5WaXmjPUJjniwdvKt7vy5I3Ycn8oNJIdqXxznmC2IULkUomQoZcy/b0Ho4?=
 =?us-ascii?Q?C+HUEoFJYAti9ASQEeDOvClY+A9IMy0CYNepqJKNC6yn4cn9RnNl4AxEZZ/S?=
 =?us-ascii?Q?3Knba1TDt8v/+3SbHkYlTfp4BrLKDam5v/Xh5890VExCOKGPw7y4kpqh5hY1?=
 =?us-ascii?Q?3Qej4ccDauasLDhOFIq8m4RId+e9ogc/CBwXdkb3BEyOKa7DPb7v5ANHOmo+?=
 =?us-ascii?Q?UWIxUtZB2L5s1jUoETEVfL4jSCQhA5zWZ7EpsIV6gDt2R1C6eq9oyECaAOq8?=
 =?us-ascii?Q?JZuLobKiqtujKlIufxQ7xMoVCjFtgDjNTmRlVzHEaOeQ2ju98hfgFyU15Pv/?=
 =?us-ascii?Q?9iAoC8mbilPwnL/UkFUAsdu8WC02Xw8crYd6v8DY+tcmDv6elbTSHswVRmLG?=
 =?us-ascii?Q?zPtJ/YtjGqcdWhr7v3dlBOnMWVhQgXYnp8op5rs/JsHdCR9j2CQ3zf5lLJZf?=
 =?us-ascii?Q?ReKrAHBKK9M9r8OnRpj21xM7F7q/un4TLFgLmIeizp8lYIDznp9xZDKp0R8W?=
 =?us-ascii?Q?xElhN2aBbjbTpDtLuawL+RXJKMKL0Fw1M6wZMfIVzz/Z6+bjCwFsBQbGFj0v?=
 =?us-ascii?Q?NK5sgUe0qK4EV1R42dLt1TbdCvCdIuIO/73B+5JHSYrxFFwliYuTrCI9jt4/?=
 =?us-ascii?Q?rXo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a88ad7-1f97-4549-e8ba-08d8e8402e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 05:56:02.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSU60ktRDeDatG1LHNTf/97DCKqO4CYS7n4IkYQ36zhFYB98gWRuy08n1uoveIXs7ij+ywx5HRwSU4Uz4ah4sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2534
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Pratyush Yadav <p.yadav@ti.com>
> Sent: Tuesday, March 16, 2021 12:01 AM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mark Brown <broonie@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Vladimir Oltean <olteanv@gmail.com>; linux-
> mtd@lists.infradead.org
> Subject: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to js=
on schema
>=20
> Caution: EXT Email
>=20
> +Cc mtd list
>=20
> Hi,
>=20
> On 15/03/21 05:45PM, Kuldeep Singh wrote:
> > Convert the Freescale DSPI binding to DT schema format using json-schem=
a.
> >
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > ---
> > Hi Rob,
> > This patch is checked with following commands with no warnings observed=
.
> > make distclean; make allmodconfig;
> > make dt_binding_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/spi/fsl,spi-fsl-dsp=
i
> > .yaml; make dtbs_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/spi/fsl,spi-fsl-dsp=
i
> > .yaml
>=20
> When I add the "fsl,spi-cs-sck-delay" property under the flash@0 node in =
the
> example and run dt_binding_check, I see the below error:
>=20
>   /home/pratyush/src/linux/Documentation/devicetree/bindings/spi/fsl,spi-=
fsl-
> dspi.example.dt.yaml: flash@0: 'fsl,spi-cs-sck-delay' does not match any =
of the
> regexes: '^partition@', 'pinctrl-[0-9]+'
>      From schema:
> /home/pratyush/src/lin/Documentation/devicetree/bindings/mtd/jedec,spi-
> nor.yaml

Hi Pratyush,

Thanks for mentioning, I just noticed the same error after adding fsl,spi-c=
s-sck-delay property.
Since my example is not using the property, the error went unnoticed.

Taking example of nvidia qspi bindings i.e=20
https://lore.kernel.org/linux-devicetree/1608585459-17250-3-git-send-email-=
skomatineni@nvidia.com/

I constructed other properties in similar fashion and later noticed that
example in nvidia bindings uses compatibes as "spi-nor" instead of "jedec,s=
pi-nor"
and therefore passes "make dt_binding_check".

> I am trying to solve a similar problem for the Cadence QSPI controller bi=
nding and
> I wonder what the best solution for this is. The obvious one would be to =
add
> these properties to jedec,spi-nor.yaml. I haven't managed to come up with=
 any
> other solution to this problem.

I agree with the solution to add properties in jedec,spi-nor.yaml and addin=
g properties
particular to specific controllers for flashes in generic jedec,spi-nor.yam=
l may not be
a good solution though. Please let me know your views.

Other approach is to add these properties in same binding itself (if possib=
le) so as=20
to limit the scope of these properties. Looking forward for more suggestion=
s.

Regards
Kuldeep
