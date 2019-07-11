Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BCB66023
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2019 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfGKTpY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jul 2019 15:45:24 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:59186
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGKTpY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jul 2019 15:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEBBaiydBLvKJzveZNII95/4yP9OBnL9VJmTbMWDGdA=;
 b=pCdP4mNRHy9lMMYo4snXYATq85uX0Qw6DTpcY1d3EUxcE/qG1uAd2EHiUvHgssAacZX6YOKw9WEIZaMZDYkwtcYlne8g9vUXV2ZsGkhy2T29jd8ZLWsOopUj3azPCE/ZNOMhmNyHQhhDK6nCju3Sl+Q5Iq2dSQwBaPL4MzWBL4I=
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com (20.177.33.210) by
 AM6PR04MB4805.eurprd04.prod.outlook.com (20.177.35.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 19:45:19 +0000
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::b445:1241:947a:ab83]) by AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::b445:1241:947a:ab83%5]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 19:45:19 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Ashish Kumar <ashish.kumar@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB
 memory for FSPI
Thread-Topic: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB
 memory for FSPI
Thread-Index: AQHVNsj1Ce/O2KTUu0Gwz2jtSdXX0abD91IAgAADTcCAAWOsgIAAdIuA
Date:   Thu, 11 Jul 2019 19:45:19 +0000
Message-ID: <AM6PR04MB49670C9EA59A507F9C78B42097F30@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com> <20190710151628.GF14859@sirena.co.uk>
 <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
 <20190711124117.GG14859@sirena.co.uk>
In-Reply-To: <20190711124117.GG14859@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238ad76a-b72c-4fc2-51c2-08d706384e2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB4805;
x-ms-traffictypediagnostic: AM6PR04MB4805:
x-microsoft-antispam-prvs: <AM6PR04MB480563F2B2D68D3E6FB7938E97F30@AM6PR04MB4805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(13464003)(14454004)(476003)(7696005)(7736002)(6916009)(26005)(186003)(25786009)(2906002)(4326008)(5660300002)(486006)(8676002)(99286004)(102836004)(44832011)(81166006)(66066001)(6116002)(66476007)(9686003)(52536014)(55016002)(53546011)(6246003)(6436002)(446003)(478600001)(74316002)(66946007)(68736007)(76116006)(71200400001)(3846002)(11346002)(316002)(71190400001)(53936002)(81156014)(14444005)(256004)(33656002)(229853002)(66446008)(66556008)(6506007)(86362001)(76176011)(64756008)(305945005)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4805;H:AM6PR04MB4967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oqFhOYdIus4r2R2vN9HXUPgRgz4hKgTlhCifPsKv+N1wAcqAodIX1aeudVOPnOV9gfzSvf+yzIgYD90XyqM9SYmcfklmzgzJETQiQR0FTkhpMUNXahiJ3SCbGHxa9gvqMT+6aaBEEJfjhsDVus2ZL5p7VHpfX1qgoxkQQaJj70bbH/Eg2QIDh/okgyFgGeobXJQNBAWqxNV44QlNE1aSPSqKbrBOX/btAi5GNKBHqyQ8avLA4Nxc4Y3x3ZwQFw9Qrx823sc3cJANOF3lfvVqkzDvJ3dSmLveSdMtDWJ0/cSqRHR3eWSB4Bby09bMgSUZjioqBBMA78U2+jz5BEwPrb/Fc1qgwyj4sgaTLIXFOUOT36qPnpyX9TpSuPx4q+/GvoEXGc8N8dp5mUG7QqcZNu7clGdkQhGUY9bQAULjJCw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238ad76a-b72c-4fc2-51c2-08d706384e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 19:45:19.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: han.xu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4805
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, July 11, 2019 7:41 AM
> To: Han Xu <han.xu@nxp.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; linux-spi@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc A=
HB memory
> for FSPI
>=20
> On Wed, Jul 10, 2019 at 03:35:46PM +0000, Han Xu wrote:
>=20
> > > > dynamically alloc AHB memory for FSPI controller
>=20
> > > Why?  This is currently done at probe which is what you'd expect to
> > > happen here, there's no explanation as to why this change is being ma=
de.
>=20
> > Explained in cover letter, It failed to alloc the whole memory mapping
> > area during probe on some platforms, since the AHB memory area could
> > be pretty large. The error may look like:
>=20
> > [    1.129404] fsl-quadspi 1550000.spi: ioremap failed for resource [me=
m
> 0x40000000-0x7fffffff]
>=20
> The commit itself needs to have some explanation of what it's doing so it=
's in the
> git log, particularly for something odd like this.  More generally this j=
ust doesn't feel
> like it's solving the problem - essentially we're just deferring the mapp=
ing and then
> keep on failing operations until the allocation succeeds for some reason.=
  That's
> going to be disruptive for users of the device and it doesn't seem like i=
t's going to
> be a robust solution.  Why does the allocation not work initially and why=
 is it more
> likely to work later on?

Yes, I will explain the reason in next version. To allocate the whole 256MB=
 memory at one time exceed the vmalloc limit, so we dynamically allocate sm=
all amount of memory just as needed. There is no failing operation, just de=
ferring and re-allocate if new access area beyond the previous allocate are=
a.
