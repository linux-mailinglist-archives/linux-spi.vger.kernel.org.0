Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDA9C923
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2019 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfHZGUi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Aug 2019 02:20:38 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:42308
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfHZGUh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Aug 2019 02:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzFf+o4zPIJd1198wqG9iQWwX8nmPphmMj95/zRfq75qAGaL2Kg622AsbZMMz3bXbqzu/FJ+QKOk+JNNiDq1G7/KSwpt0RMPFaH22zoaoSCBRicn/0QxGLm6k7aJtvkuW0P1HsZ38GyVNoWubiNswIF7S/VT7Yx9Ih4FAIYEfKoqVAtQZkSg/5QAwyNmnFH/n7q/9EuC9FyTRxJDJPm9ohlDjeNTpqaAZBEtmig0oTQfxxYe4Po/oterxEyTYm4EU/KJpd3NjFavcGEOciO7ZatIeIKTX5QsvL44uVZ2GJpvGg6qcG1RUbpbgHGbxewGT67gpaoOHZJamz4jBLHL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+ZXnJgTeodQOFcm6PxAlsbytCWnS/vrJ3QaZi14Go=;
 b=NudaVA7HfG8c7evzfRKlE9l5VTBslIPhnO8kRJHfIy3pnGcy/qNL9I0155VvmpE0l27bFFWHafNCigCMmPZPEc8r+DXiT9bxJdYLiHjPKc3lggmL7pmj8+l2mBEEcJbb7WjLdPVnDWPOhB4HzSl2414X4pnfKwkUUKfHKAraHLb1uDHtIA0P9g85sYdOLl1R2D0t/qwM10cAb3UO0MHAEylDV5TrRE85C0Iz8kA/ILq59HYv4aZXyBlZAZlQnL2wW15+1X8WXN11Vr/V5sRySd8LmhDq0+Jw2tt3EO6c+vBLLiYEyPS9eW6B6mnLhwEkqe8dtv/So+6sn6qUii5t4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+ZXnJgTeodQOFcm6PxAlsbytCWnS/vrJ3QaZi14Go=;
 b=DLEFshg+wzKWOuRd3+k13AKETnimZs+rqDD1IRTNVspcFEBURannI+EQkqRJ4Y0JHtwa4/x+6vkhbo5Cc5MEkcgk/N/8PU37PJefLQ391ItIRDfr9/okUTTvwIl6OFn8knPAukmETSI4dx4uP7qBNbzJsYwOa2TFYeHM5eNhSyY=
Received: from DB7PR04MB4011.eurprd04.prod.outlook.com (52.134.110.11) by
 DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 26 Aug 2019 06:19:53 +0000
Received: from DB7PR04MB4011.eurprd04.prod.outlook.com
 ([fe80::5d74:d199:a2bb:448]) by DB7PR04MB4011.eurprd04.prod.outlook.com
 ([fe80::5d74:d199:a2bb:448%3]) with mapi id 15.20.2178.022; Mon, 26 Aug 2019
 06:19:53 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Thread-Topic: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Thread-Index: AQHVUcEk+xwdBczP/06jXTHXcyeTPqcFfYEAgAAn5gCAAfAcgIAFb7Tg
Date:   Mon, 26 Aug 2019 06:19:53 +0000
Message-ID: <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822190507.GI23391@sirena.co.uk>
In-Reply-To: <20190822190507.GI23391@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [92.120.0.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95ddf433-4023-4113-bc81-08d729ed689b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4490;
x-ms-traffictypediagnostic: DB7PR04MB4490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB44903F432A593FF99C49CE6B95A10@DB7PR04MB4490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(13464003)(14454004)(6506007)(33656002)(81166006)(71190400001)(71200400001)(54906003)(74316002)(486006)(316002)(7736002)(25786009)(7696005)(55016002)(52536014)(81156014)(11346002)(99286004)(6916009)(229853002)(5660300002)(476003)(6246003)(446003)(102836004)(44832011)(9686003)(66066001)(305945005)(4326008)(478600001)(14444005)(256004)(186003)(8936002)(76116006)(76176011)(2906002)(8676002)(66476007)(66556008)(66946007)(64756008)(6116002)(66446008)(26005)(6436002)(53546011)(86362001)(3846002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4490;H:DB7PR04MB4011.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PX69SgU2jYPO8RWJ1eNi5+VkZRkGI+5CGw81bbnIQsVmqQscUbA/NiNP34zuOXKTNopy8bk2vNVl7BOb0epBMoe9Lv64URzmhI1HuAY2bym7GlIwWjQhqwdmlvS9AoWH103AJzVUaje3zScsfLLbhXA5NOI/vpH58rpgZBHmJdbub8UftD1jULvcs9Gk3AvsSjakgxeLnky+d0cJwT8DYdIKXvsjwN1677kn5MoucxEm52cH3Pa15zBPwJR8PjrVCY0+yil2gaukGT4xaGZ7zwMh/tLH09TlZbdHJJPrrcx/pBtMBPIRnRZXV4b6/xltYOI55mhnbP1yC3CJcOc7HiFVOBkbwsATfsELTbdp4Oam6BGcdIUoXCAoFvUz6ib2ArgzZdsGDa0dOzQBZEiiKz0e8Ghj+zt4izfjS0QDBp8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ddf433-4023-4113-bc81-08d729ed689b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 06:19:53.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8NUpBk9q8EcAUsPT3ba1/7aSLstJ9rgFapp+RIPkuSTiWz4ibc145f2bXvHO7Cn35XqyCZ+4MylCuYAzKNqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, August 23, 2019 12:35 AM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: shawnguo@kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-next@vger.kernel.org; Kuldeep Singh
> <kuldeep.singh@nxp.com>
> Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add=
 ls2080a
> compatibility string to bindings
>=20
> On Wed, Aug 21, 2019 at 02:18:43PM +0000, Ashish Kumar wrote:
>=20
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>=20
> > Snippet from driver spi-fsl-qspi.c
> > static const struct of_device_id fsl_qspi_dt_ids[] =3D {
> >         { .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
> >         { .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
> >         { .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
> >         { .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
> >         { .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, =
},
> >         { .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, =
},
> >         { /* sentinel */ }
> > };
>=20
> > I had previously sent dts patch based out of Shawn's tree with
> > dependency on these dt binding patch. To which Shawn had replied to
> > get dependency patch accepted first before sending this dts change.
>=20
> Right, there appears to be an entry for patch 1 which was added without t=
he
> binding doc being updated - patch 2 looks to not have the compatibles in =
the
> driver though?
Hi Mark,

For Patch-2, I intended to use this in arm64/boot/dts/freescale/fsl-ls1088a=
.dtsi (please see below), since both ls1088 and ls2080 has same QSPI contro=
ller.
So I had introduced new compatible
+                "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
+                "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"

Now the dtsi will look like this:
               qspi: spi@20c0000 {
                        compatible =3D "fsl,ls2080a-qspi", "fsl,ls1088a-qsp=
i";
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        reg =3D <0x0 0x20c0000 0x0 0x10000>,
                              <0x0 0x20000000 0x0 0x10000000>;
                        reg-names =3D "QuadSPI", "QuadSPI-memory";
                        interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
                        clock-names =3D "qspi_en", "qspi";
                        clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
                        status =3D "disabled";
                };

If you think this is incorrect, then I can add this in driver
{ .compatible =3D "fsl,ls1088a-qspi", .data =3D &ls2080a_data, },

Regards
Ashish=20
