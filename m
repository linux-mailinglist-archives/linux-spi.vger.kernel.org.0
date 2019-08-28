Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF929FA59
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2019 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfH1GUi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Aug 2019 02:20:38 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:61454
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbfH1GUh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Aug 2019 02:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1rXG5d2DxjbcKGnSekKYw4yIjDMZTU9HaiKKXu824lHc3BixAkAcX6l/fWxsS6xKe2v8zj8jtF+0m6TR9qsMXOV4jpyJnhSuzFibLmv9ycxYcmrfx09Bqw7H28fvWudDw80iZAQ4mLBCRvqfFoZfWk5n+8hQGM2ubmsr2JkRd2Tx62OoGq4y1QMbnlf2finwNpQ/OPMSdCDZE2WAwyrduFmylCsuBaVxg5n2jcKBmUTPKaWa0yEoHHiI+FKAsORIdB7HmPEurZa+9W5U+/8A6ruhf4yHmDDFZ++cd0u94LpY7oE9Yx1Qia/bx+y/WroiK20BaZcURXIIfvYvoZ/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/hZo4sLL2KbmKi8FTbvB3okVHx0LYTRH2w1Hi/X1tU=;
 b=SB4TiTDDWfxnn+NQFpzhgEVZS17B15A2GreGMD/kqx3WBQC/FsqTLGQ+bQjwypozQrLJhMZe/sU/eDsvT0VqbnggiVNugf1prY5pkYLpql24gIuY4BoZ1FrLU3QoMmXJcs9e8sukQIs94klLW6jdLsl65C5KHQi/aSa8CkOwpEPnSwrxu2X7YNWGBDV0tnVy0EKv9h73BRk7IiXRa2c6MeTNACJC6KgNRlN7SZQ1Xdl27awEsnhcW/2esC1hJ4+wPI+P4uwi2EQv/PUNJjLm/01WuuoWjrQ9I7ddlRN7zL6qMs5D+WRJwizqbIexCJPFm6M9vIk2IHJ40DS22Gudww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/hZo4sLL2KbmKi8FTbvB3okVHx0LYTRH2w1Hi/X1tU=;
 b=EnEczV5QQyMp+6n+edQPXsPz37cSC5jszgFD/xtHbzyDgWCiSmUmQC9nx4wtkP+XdPZW/xLOs9DkrTJVvyNiWKYYLJbnFqqfIUvpDCSpNlMEMyZqnkwRXcc8U8BlOwTWrffxoI2i3WQ9JHvb+WK8Xe2ow3s0zz3DCShztqKantc=
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com (10.171.182.24) by
 VI1PR04MB3981.eurprd04.prod.outlook.com (10.171.182.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:20:33 +0000
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::a57b:62dd:488e:b4a]) by VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::a57b:62dd:488e:b4a%4]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:20:33 +0000
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
Thread-Index: AQHVUcEk+xwdBczP/06jXTHXcyeTPqcFfYEAgAAn5gCAAfAcgIAFb7TggAJasQCAAM3G8A==
Date:   Wed, 28 Aug 2019 06:20:33 +0000
Message-ID: <VI1PR04MB401588B866A00A4507CC8C5795A30@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822190507.GI23391@sirena.co.uk>
 <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
 <20190827180320.GE23391@sirena.co.uk>
In-Reply-To: <20190827180320.GE23391@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [92.120.0.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2e8ef57-8709-42d7-a7ee-08d72b7fd589
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3981;
x-ms-traffictypediagnostic: VI1PR04MB3981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3981660FD9EB185F0E711C7C95A30@VI1PR04MB3981.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(13464003)(25786009)(3846002)(229853002)(71200400001)(6116002)(86362001)(71190400001)(478600001)(6916009)(446003)(186003)(486006)(316002)(76116006)(4326008)(14454004)(44832011)(54906003)(33656002)(53936002)(64756008)(66446008)(66476007)(66946007)(5660300002)(66556008)(14444005)(6436002)(66066001)(52536014)(9686003)(6246003)(305945005)(7736002)(76176011)(11346002)(81166006)(7696005)(8936002)(53546011)(6506007)(2906002)(81156014)(8676002)(99286004)(55016002)(74316002)(26005)(256004)(476003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3981;H:VI1PR04MB4015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o18GLmP5Jujz1Uq2/DHQ8/5Y2u4G+cFm2ud/C1zAeqi6XeVqj0SWyLaptp7fST5eSmQieQ3b+BFw/H+J9cCve2gN5N3EWs1idXS2gZZ1SNfHV83mCHQjMBYpuwtaifeQJWG9wir9vkGIVIktF2+DUZ4tSRseUiY8Y7u+nS0FS8tgTZCoD6ftMPeeKUZsshw69Y9UcGaeeJq7LsDMqiQZecDdfs5VZG2tsNq+rhYtYhBH0/QP/0GgT4f3k0wCSqTC+rS+0PfZl2afwtNq9MkF50OcoCEW3aFYazd1xcOgDIcJKLLG8nRFyEItQ3xbTV1dgLfLOMHe4rQYXA8z89Icw2Zi7y6IX3033ClV0IXgyQd4Fx7AJkKn4YI32jaJUv699HabsyIbY7h3tenTPK0uGlxB2fg9tWiwHk21Oc10RzA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e8ef57-8709-42d7-a7ee-08d72b7fd589
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:20:33.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nl3SiHR+hx5SeMnsTdCdhrBjR4KtEWDM/U3ifxRe6tb3b8nsv4JL7VYKwCzQfClf/EDVaCoETsi+kdh9njSdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3981
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, August 27, 2019 11:33 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: shawnguo@kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-next@vger.kernel.org; Kuldeep Singh
> <kuldeep.singh@nxp.com>
> Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add=
 ls2080a
> compatibility string to bindings
>=20
> On Mon, Aug 26, 2019 at 06:19:53AM +0000, Ashish Kumar wrote:
>=20
> > For Patch-2, I intended to use this in arm64/boot/dts/freescale/fsl-
> ls1088a.dtsi (please see below), since both ls1088 and ls2080 has same QS=
PI
> controller.
> > So I had introduced new compatible
> > +                "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
> > +                "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"
>=20
> Even if the compatible is supposed to be used in conjunction with other
> fallbacks it should still explicitly be there in case someone forgets or =
decides
> not to do that for some reason.
Thanks Mark, I will update the spi-fsl-qspi.c to include ls1088, ls1012 in =
driver data.

Regards
Ashish=20
