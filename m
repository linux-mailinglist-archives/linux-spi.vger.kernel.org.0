Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D813C3653
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJANu0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 09:50:26 -0400
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:60489
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfJANu0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Oct 2019 09:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2aak5mf3P0qnjxx1gSYCkTh+I4mfnYno7ecHM60sxsz1JG+pR7U+GG3kYwxeagUouNJcYKd7pte6DrOBsMj67LtwFMxry9txNzjcc+u3Cc4gjovQsppyQ43ipohnAV2SjQUqCqC5l56scvkUmmy6+CWaA5xt4e8W74qne7J+5UlAOeY6wLng9vkjF8U7lkh5LVTHLY/YjyqeeTIf2wRxqYmmQE26RmaBk2pXOVzI8q9awLXJsOmljhehUHPKUsuvLMeYpWm8CaFXfN/P9waxr/LyIS71szTKL9pMhnYuQvXCAcz9AKIVGROmzdZusEpW86lRK7Km7bkJR+x2LlflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/YlrwRcjyC0w3GW3Pbu5Zm6LRG5sEcVGqfZJJExpdE=;
 b=kkY1bsCy9Pdm9+PEcTFdo2P5lXrpb/2U8YMua9hE46G++OKByk7wJAAO/cT+OoQp7PqMFwkhcMiXYWqLdp51o8Xbt0ni4ZO1oB4/6vDr7rVETfN10PmZhg24X5Fcr5J+oTsyY6zI8STfHFbGXzS91S5jZK2pIteO4kosX6PFvvOmcbwjPJW9VP0c8+aWxknFyzJ6K7wbVvJIpds9Y8bkxiopAVYGg9gF5okRf7YjsmEqEm5DRpDUcg7rkM3qjlQR8UcpTBi4bmOBlY37XeatZL3ZmN8dfi97oVOcpqcYxWjQBzaJfTAS7xw7AoegBaBHdBm4K0SefmVuwA7fYYwWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/YlrwRcjyC0w3GW3Pbu5Zm6LRG5sEcVGqfZJJExpdE=;
 b=GYdxGg3KvuL442fmW5gxYgr8e61tWoA0/bA0OMhjvBG76qZ/gw9d7hqVP37NAcJtAfcgNmcshVXZTi6NxkwZPiyBwoxEhJZvm8BHH2UmGtXETRy3KODr8aX9BhHX2K6i7bi/qL30biuFurSb6F8Xh/anLVX8S8Guv7O/QwhXdcc=
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com (20.177.98.81) by
 TY2PR01MB3754.jpnprd01.prod.outlook.com (20.178.132.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 13:50:20 +0000
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::50a2:2971:5d46:aa50]) by TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::50a2:2971:5d46:aa50%3]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 13:50:20 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
Thread-Topic: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
Thread-Index: AQHVbffPFybnaZeN90q5ZOF0l55acqdFxCOAgAAdrsA=
Date:   Tue, 1 Oct 2019 13:50:19 +0000
Message-ID: <TY2PR01MB292460F29AE0664CFFD70EFDDF9D0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
 <20191001120203.GA28106@bogus>
In-Reply-To: <20191001120203.GA28106@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d122c35b-8ac3-43c3-9d5e-08d746764cec
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TY2PR01MB3754:|TY2PR01MB3754:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3754B6CD0479A6E099F3926CDF9D0@TY2PR01MB3754.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(66946007)(52536014)(66446008)(8936002)(71200400001)(71190400001)(966005)(5660300002)(478600001)(66066001)(99286004)(81166006)(486006)(81156014)(8676002)(14454004)(6506007)(76176011)(66556008)(7696005)(102836004)(476003)(66476007)(76116006)(11346002)(256004)(14444005)(26005)(446003)(186003)(316002)(6116002)(3846002)(6436002)(55016002)(54906003)(4326008)(6916009)(33656002)(86362001)(305945005)(9686003)(2906002)(6306002)(229853002)(25786009)(7736002)(74316002)(6246003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB3754;H:TY2PR01MB2924.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLdWpChwDCAEIb8cp58WR8z3lr4wq9tcTeGOjD6Bgmzs9pA9hiFfd6iujEyewzxFRW8zN4Q081NQvM4wQ2i3zp6h83qCbRvEjlCKWoDStB5F9hfkg/mBSpg+y100HSZuOx8SS4VMqC/oivrnMWs/uOKvRXNTeZcseIWJzwGPnoC9Tv7U0YR3S9NGhr2fSVFXkGRV+AMm6NkcVgN3gjOjeFeSJ5X3oFg2dZNRQx4vK6kCdxK02e9OwDSYVn6l7CBrBZ+ixG3hlzyuuhgc108wJjLhAQo3W9kytIGAobMKP4LxJXuA0sjUyj8fwU1A7SM8QBVvbI8HttnlRa7hirbc6Q+47kBO43sCkd9PK7Iep/m1D62Q5aydElxmvStUA47GZ5hYQ/uSmGAdLCrQH2YdlD6l3ux0c3N0XFM3gxAQSJNdGAiAlSREPwpryCbhV3LxAexCPcePOWO6uhfhn6KkZQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d122c35b-8ac3-43c3-9d5e-08d746764cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 13:50:20.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhWlF2Xm2cXyGRdn3EvAF4awnfHJi23JDIZIJYzmyw2AhQ6e3CJDM31u2fQmp3KQbyYyE6HTnFaljc6EGA/JrHpQlrnWECON3XmVYr5dLWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3754
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Tue, Oct 01, 2019 at 13:02:34AM +0100, Rob Herring wrote:
> On Wed, Sep 18, 2019 at 09:04:34AM +0100, Gareth Williams wrote:
> > Note in the bindings documentation that pclk should be renamed if a
> > clock domain is used to enable the optional bus clock.
> >
> > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> > ---
> > v2: Introduced this patch.
> > ---
> >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > index f54c8c3..3ed08ee 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > @@ -16,7 +16,8 @@ Required properties:
> >  Optional properties:
> >  - clock-names : Contains the names of the clocks:
> >      "ssi_clk", for the core clock used to generate the external SPI cl=
ock.
> > -    "pclk", the interface clock, required for register access.
> > +    "pclk", the interface clock, required for register access. If a cl=
ock domain
> > +     used to enable this clock then it should be named "pclk_clkdomain=
".
>=20
> What's a clock domain?
>=20
> Unless this is a h/w difference in the IP block, then this change doesn't=
 make
> sense.
This is a reference to the use of clock domains that are implemented throug=
h
generic power domains. The domain is implemented in=20
drivers/clk/renesas/r9a06g032-clocks.c and general details of clock domains
can be found at=20
https://elinux.org/images/1/14/Last_One_Out%2C_Turn_Off_The_Lights.pdf

>=20
> >  - cs-gpios : Specifies the gpio pins to be used for chipselects.
> >  - num-cs : The number of chipselects. If omitted, this will default to=
 4.
> >  - reg-io-width : The I/O register width (in bytes) implemented by
> > this
> > --
> > 2.7.4
> >
