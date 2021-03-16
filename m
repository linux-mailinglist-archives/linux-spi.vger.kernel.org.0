Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909A033CDC2
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 07:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhCPGIk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 02:08:40 -0400
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:12545
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232718AbhCPGIT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Mar 2021 02:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC5wD6sRQPahT6kMJ536wqJslTwoCcUvgtvjkw3cWqoQ2vFSGOzJRORjAKPkVqYPcKAfc/eDnpPS9DXUJw0A3YO8JQHp8dAoK1+G/m5oceYfe523H4svNL6keVAqBHzgNEQQOKkLY9l00ZtfO24/XPwKClQ4ApLk5fR8wcwp7gCNuKQfnxQ9BMtTTpocCnRJF65vR8MDbsWphR+Ei1GfCgmHlqhN5m6nL0YtSyhcuIDGjqPLv0JUVYHJLa+jVKNkhTAGzDan7gCpKxMeQy0FjN+VpMP27FCwF+ck+e41wjZuXNKCScsrQVBdnD2tbnc9tNxFNghDpA/tErQTodaR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyFHmDebShXkul0hDxlq/aE0FTguH3QQdXLSaJv/0+E=;
 b=JzT9N2QP3Uy4wTiGAQ7Bt/wP4DfAtihPm8v1iVpRGPz13xAkf0j7Ym1nXoj6fUIWB/FkH0MSNGn+Z8ZXEVRIu4ZCaca6MIsW1rqTsH1kqlCMNlKEHlSxB1RY6Co1nWctfuOG4SkEqSfFJ/FiwkvrGbHZac+v4lDMMtJuLgho9bEwoZ6b7Tx5GomLoHQDqVJi11pIX0RHqGyX1S81xWD2IhTnB8ZYM1eaROFHEHh8QPE2S3ZmEzZnp1Yj8+y7x49yinfMrsZhaYr2oqunEpttMN9FHtivyfbEgHMXnbNEU1PVNRr5wasJd2siikUg9vRmcsg55DZUcXosAopum+kA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyFHmDebShXkul0hDxlq/aE0FTguH3QQdXLSaJv/0+E=;
 b=d+IQLwaYErYQAeJDdfdz/mLfLGo1548GBgogFDsplNddk8rlUMTAKm1yimPhjvvJbVfoLA1KDrSSSPKUx5oCIwfkTPCFyJxmHBCM/G6e4IX0aNTyS6YtoKcPlDIi6QeNvMx1+Qe16wM9PStG6b+sBk/bbBbpGuZRfClQR8EfX4U=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 06:08:17 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 06:08:17 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Thread-Index: AQHXGZTp77oN99ywtki2W2/Bm/x6J6qFh6sAgACXclA=
Date:   Tue, 16 Mar 2021 06:08:17 +0000
Message-ID: <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
In-Reply-To: <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [223.236.221.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01b4920a-357c-4729-d56f-08d8e841e462
x-ms-traffictypediagnostic: DB8PR04MB6857:
x-microsoft-antispam-prvs: <DB8PR04MB6857878C0E34C038A72492B4E06B9@DB8PR04MB6857.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94thw/Gn4qI9A1Dm1MGZS6+zkj3PCQP/cjZjTyuMK6mGRDIG8m6b5CCK3X1L3wXzfHQkobE8kzgJeyvb3Cd1mxMnZfaiYIzr8PqEzI/kqpPLBW6n2XzGEfruI+V2kpGtNyIuSPD1L9shXTYojWw4/ZyJ/uVEwTVBvz36XRFX400+L28wrl4TDwQ0+FHP5hxgD/HIl1Z9Y/kYLKhUf7YLgaHWkOJrovTAu2Kl4y7XAz7GUI1xRADt4/KSZvab9textHFY0kXirH4u/mVObocpyEC8brD2lRk9PDlYNQmLoNvTH7Z+j1DcNme6lRzh/FratnGTSoc3j1HU3mEPm2nR+7Ko29G0UKjyJnrk/J8TtL87b6yEGvCIItC8BjDykWnSsVNXqrxCvxJNyLvc/XpeviZzQ9yIAWlt9j+7G/1IKja3HXEGRJ/6JkuYjTRI318cstuwzX7A0aZ+ygmdWPwEPGB1m1+U5InWEOecLbevIpUB5kwWDEFaeNzYziefiFoZk/VxQeMb5l2ZG3FzHh5TS2j8wM8/+xKCq6BkYmGYWs7gdx5wPkHGuCO46Bz9POyv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(186003)(316002)(54906003)(7696005)(33656002)(9686003)(71200400001)(53546011)(8676002)(8936002)(83380400001)(6506007)(26005)(44832011)(2906002)(86362001)(66556008)(66946007)(66446008)(64756008)(4326008)(6916009)(76116006)(66476007)(55016002)(52536014)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mv0TkaWVc9kMUnISN0hXbYeFxr6oURuIesCG4E0IfJRdBJFTuRYSq1jaVjgx?=
 =?us-ascii?Q?4s+ckEs/EA0tTIDz7KCezt3IQPlex+6EJMJ/Eu7JVvCk7T+DSy5eK03IQRCr?=
 =?us-ascii?Q?a3Wncc04FfWcAxSH1/ACR9pHCh4s8mLLZSPt/M2X0e4oXjfcuB8PpMuH5IHD?=
 =?us-ascii?Q?Mrt5jnrWhyp0YTB17m6vipjINLG0sTc2NTnXVIenj5y41gu8Z+vv0zOzfkdm?=
 =?us-ascii?Q?KLqCEkxaG+3WQLkrY1slmwkmlkkpd9f05xq2uYh/cKAp1G7TOYKv4XDz9vMo?=
 =?us-ascii?Q?pXXg8/YVrl58ZCBCoMk14FvPguN5qbwXrInDE9OE5ADXfNxpOZ7jCP3Aem5Z?=
 =?us-ascii?Q?6fhjPtp07/Up92TBL8hv/Qqk149ZEHpsjtMMlGMA6jJztAUtfuCl2WL3J8A0?=
 =?us-ascii?Q?JoG43hxNELNALLiW7W+NJr+V24NB/VjfLzktfDWmxRCkjEMME2l3urpxyWs2?=
 =?us-ascii?Q?a0TO+3xGYC9PHXH9cFM439JJ8+iy5XEyNQXc+dSNfMbR3YAOP7lLWcMkS3uq?=
 =?us-ascii?Q?LqiG10eLl1z+hIUuVZdKQKAROYKr73fuxhERbvJlrSOzbURf8/8nunl7uPWp?=
 =?us-ascii?Q?kbbP+vTbu4NFvfwzAHT3y5lhQGP38J1D/zHCS+dWTF5id6lRMpml2nO+gXwD?=
 =?us-ascii?Q?PhQ5AwhCcsmtuMxP3MI6WmSMQ8629Fk41cb4D/wgXsYmMQWa2ozxmG5y2Q8d?=
 =?us-ascii?Q?uminJk45scTXcMgMks4aC//sIOnyliACPf5/TXRqy7qe79NgoTtXcHg+ayrD?=
 =?us-ascii?Q?Wr1IGc+BRDuOgUZZQfYfdb0gz6PKN3GTd2u0H8sqiA1H15siWFYKkt0jMcA/?=
 =?us-ascii?Q?wUcS2lpmrneYr0fj/mD80G3JiKqWmfv86p99Ts7x+G4G4FxFEfYpwiqrbNOs?=
 =?us-ascii?Q?7+R5Sgk6XtEMei804xdGXcmMuopdSbXeJpNT5nPa3Ca0vdjmKkENMAhK3+V6?=
 =?us-ascii?Q?dafIdLGlYcT0bPMKuVfnmeo5RMEv64xUoTyxuQ3bdP2B8/ZfV0hWVEmZz8yL?=
 =?us-ascii?Q?N/i20CcnDXyNVeBxeHzfQ6LLEFwkgzJZOZWd8UzmBrIhbpaoEz4pYmyGs+bj?=
 =?us-ascii?Q?nhkcoUy0CeC2+AsPXI2nhV/3+bycblQs3ay/0TyhYYI06jsaex0e7c+uSW7m?=
 =?us-ascii?Q?BiJjRWokn68OChGlLMu+cVtrBJ2TKC+aGb3K7qusaXBN5Uf6m3XgC6ScYi1R?=
 =?us-ascii?Q?e7R1fsqUG/RLQqmOTaUdzziPiEgDOFlR0dYu4ZGPhgrhJztZTHlL6Jr9M3ho?=
 =?us-ascii?Q?em/mkeLmXYBAls4kwwgmlcL5tzrnWEaa8lu8co6fJ5VO9smnMiMukaRDU9Qj?=
 =?us-ascii?Q?tdng4iMdFQzhA7Q6VI73ojkt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b4920a-357c-4729-d56f-08d8e841e462
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 06:08:17.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQ5ANNMa0B1yt9IXdF0srTkPq3zbbCNLmWvAthnzxCsglC6gokWmaE0GVW9w9obBTYO/tU5ARdghTlV0HbNITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vladimir,

> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Tuesday, March 16, 2021 2:25 AM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mark Brown <broonie@kernel.org>; Rob Herring
> <robh+dt@kernel.org>
> Subject: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to js=
on schema
>=20
> Caution: EXT Email
>=20
> Hi Kuldeep,
>=20
> On Mon, Mar 15, 2021 at 05:45:18PM +0530, Kuldeep Singh wrote:
> > Convert the Freescale DSPI binding to DT schema format using json-schem=
a.
> >
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > ---
[...]
> > +
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - fsl,vf610-dspi
> > +          - fsl,ls1021a-v1.0-dspi
> > +          - fsl,ls1028a-dspi
> > +          - fsl,ls2085a-dspi
> > +          - fsl,lx2160a-dspi
> > +      - items:
> > +          - enum:
> > +              - fsl,ls1012a-dspi
> > +              - fsl,ls1028a-dspi
> > +              - fsl,ls1043a-dspi
> > +              - fsl,ls1046a-dspi
> > +              - fsl,ls1088a-dspi
> > +          - const: fsl,ls1021a-v1.0-dspi
> > +      - items:
> > +          - enum:
> > +              - fsl,ls2080a-dspi
> > +              - fsl,lx2160a-dspi
> > +          - const: fsl,ls2085a-dspi
>=20
> Can this simply be:
>   compatible:
>     oneOf:
>       - enum:
>           - fsl,vf610-dspi
>           - fsl,ls1021a-v1.0-dspi
>           - fsl,ls1012a-dspi
>           - fsl,ls1028a-dspi
>           - fsl,ls1043a-dspi
>           - fsl,ls1046a-dspi
>           - fsl,ls1088a-dspi
>           - fsl,ls2080a-dspi
>           - fsl,ls2085a-dspi
>           - fsl,lx2160a-dspi
> ?

Compatible entries in conjugation require enum and const pair.
For example, ls1012a.dtsi uses compatible =3D "fsl,ls1012a-dspi","fsl,ls102=
1a-v1.0-dspi";
Same goes for LS1028 as well.

Therefore, can't mention the compatible entry as single entity otherwise
it may fail "make dt_binding_check" and "make dtbs_check".

>=20
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        spi@2100000 {
> > +            compatible =3D "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi"=
;
>=20
> This doesn't need the "fsl,ls1021a-v1.0-dspi" compatible, can you please =
remove
> it?

I have taken this example from LS1028a.dtsi and it uses these compatibles i=
n conjugation.
If "fsl,ls1021a-v1.0-dspi" is not required, then it should also be removed =
from device-tree
As well as from bindings both.

>=20
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            reg =3D <0x0 0x2100000 0x0 0x10000>;
> > +            interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +            clock-names =3D "dspi";
> > +            clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> QORIQ_CLK_PLL_DIV(2)>;
> > +            dmas =3D <&edma0 0 62>, <&edma0 0 60>;
> > +            dma-names =3D "tx", "rx";
> > +            spi-num-chipselects =3D <4>;
> > +            little-endian;
> > +
> > +            flash@0 {
> > +                compatible =3D "jedec,spi-nor";
> > +                spi-max-frequency =3D <10000000>;
> > +                reg =3D <0>;
> > +            };
> > +        };
> > +    };
>=20
> (...)
>=20
> > -Optional property:
> > -- big-endian: If present the dspi device's registers are implemented
> > -  in big endian mode.
>=20
> I don't see "big-endian" being covered in any common yaml, could you plea=
se not
> delete it? The driver calls of_device_is_big_endian.

Thanks for mentioning.
Will consider this in next version after receiving feedback on other thread=
.

Regards
Kuldeep
