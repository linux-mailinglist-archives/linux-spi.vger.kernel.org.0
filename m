Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252BC649BF
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2019 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGJPfu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jul 2019 11:35:50 -0400
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:56238
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfGJPfu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jul 2019 11:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsUHmJJKhzdoUZUUGxzDx6Rwz+CmAcdS3XsqHRxqfMgF489Q6peOisVWTZzqFDbBy0NJHKwU3hiEOq8h7YIEs9hlN4IV1wR+hkb/kcYY4F87qehJtf3PZverZEpX5mfkA/e48NuP8EPA5+NCNjL9+2natbY0mQpBHBkW8X+ry2s8i1P19kJr+slZTlFmCftHPWGz6tVFz0zQTyvDd9WEYG/uZowpp9nEz+JNqv98DosPjj4SsGM+gKUgeA2MGQmBPo13n7pox25fIKSqlcalmQz3VMGU1uZ6tcW7XAjuDw/OFKJpeLoPHtRHyHsE7ua5bRoy+I5Fum6DPOe22dNUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlx9Pvv3DxWHJV3RdMLtjjLG8N0XsMJjIpGhND/qn8k=;
 b=iA3BjTTw51XvKu7/wpkycO20wwQFDyvKCX5WKV6IuG4+aXLvEzuu2WGvbn1QVLNg7RvJLe7TXSopbfWhj0FCadfN3tTVy/58UbB8bDDao2EKZECn3f11PbpjpREZSf5I7rfPFa/2ygXnioWHrzlS9nVsgiOS70D5lUgsSbF4QyTeDmWFFQxQ2yhwk7o25Temk+TNPPUs3Q5ZkGojS2oi9R2LD5+PVTEEDtTgxFPHu/1IKBVHoRDkWWqLaTwkSjkslTliM75oPTP+HKTfxWizAyLaiBPLjGHq+zJ3b96W5v4V0k/jDej2jc5OkXBdzChraB/D5CzTHjR1dNZSWZL0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlx9Pvv3DxWHJV3RdMLtjjLG8N0XsMJjIpGhND/qn8k=;
 b=hXsDIh9e/b/Na4WnHjLL0DvO7qnchl5t0MtdtLOhau5MmnOgU9Jak7x6DOO9wlHVx5lzageijti8X1wxB+ymvnnGG2QfCoAvMYfXzydfk75EIRZny/rRbnllx4XVKK62C5dE6OBs7hNRExlOSGVN4UO1tuUMRFlOD9OnSyq34MU=
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com (20.177.33.210) by
 AM6PR04MB5335.eurprd04.prod.outlook.com (52.135.167.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 15:35:46 +0000
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::b445:1241:947a:ab83]) by AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::b445:1241:947a:ab83%5]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 15:35:46 +0000
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
Thread-Index: AQHVNsj1Ce/O2KTUu0Gwz2jtSdXX0abD91IAgAADTcA=
Date:   Wed, 10 Jul 2019 15:35:46 +0000
Message-ID: <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com> <20190710151628.GF14859@sirena.co.uk>
In-Reply-To: <20190710151628.GF14859@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24311538-076d-473f-3f69-08d7054c4743
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5335;
x-ms-traffictypediagnostic: AM6PR04MB5335:
x-microsoft-antispam-prvs: <AM6PR04MB53352DD43BC126F9FAE8418797F00@AM6PR04MB5335.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(13464003)(68736007)(54906003)(256004)(8936002)(71200400001)(6246003)(71190400001)(4744005)(486006)(86362001)(81166006)(81156014)(9686003)(66066001)(53546011)(6506007)(26005)(186003)(2906002)(102836004)(53936002)(316002)(11346002)(446003)(6436002)(14454004)(52536014)(33656002)(76116006)(25786009)(7696005)(6916009)(7736002)(99286004)(476003)(66556008)(66446008)(229853002)(305945005)(3846002)(76176011)(44832011)(8676002)(6116002)(55016002)(64756008)(66946007)(478600001)(66476007)(74316002)(4326008)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5335;H:AM6PR04MB4967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BJpQSy3JJHKN7LOuMKTDAwCfA/5hKaPVwlPxAlnnKYVmpkcZpj+N1hMSoXlpIw1y0ohm9HpJAVqCtmz5SvM1jUxKTfNd9engjIIG/HdWbQ/1MxcQGWuSt/saogAy05Wa/YEHI934AgzC2+brVrxDActW2Z1VT2FpQgBpgMrk2U5oxuBoiq1xUEx3F0GBsvD1fL3+WS6314iSvr4Zg3z9h/3/VAMl0qejj8J+JgVxUpQt3k+q1heyTF3sMFTfwfGJrOefgafTTV72YpnniRp/4HoSF0yMu9IzyPu3w+urF+HEFxufsWvC6HqQJg+ILrJxIyuDKmWhGvpapluJ6nQGgYFmXD8zsNT+gJ6jgzjHW3FrvWy8pZZHlsvqWhj0OHg7Ax0WTSFMWs+SgrNUvVXH74x7mMRZxEFuKCfhTYH8i5s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24311538-076d-473f-3f69-08d7054c4743
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 15:35:46.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: han.xu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5335
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, July 10, 2019 10:16 AM
> To: Han Xu <han.xu@nxp.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; linux-spi@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB m=
emory
> for FSPI
>=20
> On Wed, Jul 10, 2019 at 10:31:26AM +0800, han.xu@nxp.com wrote:
> > From: Han Xu <han.xu@nxp.com>
> >
> > dynamically alloc AHB memory for FSPI controller
>=20
> Why?  This is currently done at probe which is what you'd expect to happe=
n
> here, there's no explanation as to why this change is being made.

Explained in cover letter, It failed to alloc the whole memory mapping area=
 during
probe on some platforms, since the AHB memory area could be pretty large. T=
he
error may look like:

[    1.129404] fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x=
40000000-0x7fffffff]

