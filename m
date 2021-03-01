Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24A3284B8
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhCAQmV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 11:42:21 -0500
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:27414
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233087AbhCAQkJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 11:40:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWGUiFap0oYedHYhkwMwfTl/DmwcqTnqc1mvjoZ4AJPfXR+gDMr26nKEqrbwbZ5xhYIhQ4wV8VOkrQ8abao/0WrkRuapji7N7/9QMJbW7+YGliil+1w6Ef7aW45Fh6VqJ0YnQS4leoVBLAXaURii/ygsXfNqZAa1gQfM8zeD7jfSMKPag04RJckaB24trswaPFSOSF10QT/8PGQ9QHtcZEn9nYxC++QWHbsEYFtvxEDUn8qPeU3mmNbZHXzHhg/HkgUm1p/q6JY3kvwaBGFYm1/b6F2im8wsVy2KfifdHICegLZz8cHD8B6AXgBRwQWPcoN3eSAlBKXFTmvYXsvLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw/xFwOD1RXpOrDERDs2k/M7HiIPOKFF/FZo7HI+FVM=;
 b=Di7CPP4+li8p3l6wAHaU4ANbvTdXqf/USJJhbEWPR3a4OrT+Vck65uf8YgqfZlZtu/akvp7UBHi4BiHWid5slJ6neavMhSdXOKDRr0EF6VXKUDSpimL2aNiWmchD/tO5GfPBcuTydTCaK7QTLSNZanZEabzlkQNiuyur3mTW8sZK2/bRT6LCnycU4k+bRRSY1vY/usqRrLxNwRXfN0lt6fMTR36CHFbTxIZjJ3x1XHZyGH2xowALYIfHBi2IimREfRpxqCJciiUMl1TeoNyNujjN3gQfXlOQOq3F3kebAYk9aV/rxpgCBTSwg83iafvVyJ76bYbEiWWUgU075EPD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw/xFwOD1RXpOrDERDs2k/M7HiIPOKFF/FZo7HI+FVM=;
 b=XQcmeq6q3lEDhWjM06BdovlNCOSb0QjyjvO2/A7HptBdxAsHVYIA0u+REhUnxIPeFkA3WNSeQD1WLIpJaWCFFuYXpKnTyNs2nLe8MIEMOUTOGt0DK5khK1EXcyrMzRnttqxCHE3fza0gXeqow6bsikeabc4hI1WFyB0t2uG8bEo=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 1 Mar
 2021 16:39:18 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 16:39:18 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: RE: [EXT] Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for
 imx8dxl
Thread-Topic: [EXT] Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for
 imx8dxl
Thread-Index: AQHXDoY+gDfnhwGOzEaNbBXq0bNZoqpvH7GAgAAzDSA=
Date:   Mon, 1 Mar 2021 16:39:18 +0000
Message-ID: <DB6PR0402MB2758C61D8320CD0A88DC3B38E09A9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
 <20210301103230.1816168-3-kuldeep.singh@nxp.com>
 <20210301132539.GB4628@sirena.org.uk>
In-Reply-To: <20210301132539.GB4628@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.176.14.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6203128e-d3e1-4147-5cfc-08d8dcd08ef2
x-ms-traffictypediagnostic: DBBPR04MB7884:
x-ms-exchange-minimumurldomainage: kernel.org#8760
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7884A554490524CAD197D677E09A9@DBBPR04MB7884.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LEK13uRZm8H2VasnhHd0+pOX7mPBydYV3wEEHRJwGNPxML4HHsXqC50nEuBdgyExJzqnNDPjrNPbayEDD9ZB4imwiMorVEuLnyI0g+uCzvqJ4S/I4+hoAd4Hwz6uCfQK2MDIHkaoAzeqvbX6xWlqpp48QnDfFnhbNZvZx9yaQyJYD0Yf6o9hNL9Ey8KU240zvUHLHxoveu6kwofrKbjV8Sle7mtLEe6Q6qhV1PsJpih/MUlo0ZVPtsvyaPtpjkYtkelvkKqJQX9QsMpFojG0Cxxtg4EjxHjcSiWu7nI5D3wN/E0kN/4/+UZPaZyeJ+6rEkpOpk1folGPPxeMQOuaFy3O+Y6Wfx685cDKMMySqrb76pWmW+x1x54GaTE2yAv3xB0W/zjLoznsBcaHXI0qkoxUOnibkHuyBilc22RrWozr0Fm+MHsrxWv/q8CQHARuSjj069N8YhALrFpqoWWG7hs/OOZygE9v1ZmxCVRR+BFiieRBSbOr3kbDOnESw5wWKo1SN0J4MQrQxDJsZORghSe+8/hVHrIJbmCx2ZTUU/IIHEknqNBKtUJb0UhIfy57aqcjtkpU4pAH9Sqs5nS4CDxxItYY6AzdewoTX+pqrdsCPpTh6TZGL5BWK/We/NnZjSDfa8v7lIQDKfBMQ6pxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(54906003)(186003)(86362001)(26005)(6916009)(83380400001)(316002)(4326008)(71200400001)(966005)(55016002)(478600001)(66574015)(55236004)(9686003)(2906002)(5660300002)(53546011)(76116006)(66476007)(66556008)(6506007)(64756008)(7696005)(8936002)(44832011)(66446008)(66946007)(52536014)(33656002)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7jK44QJVXODM2MjapH0RhMqG6bxj4Y/zgfhvTM13cnSNt/cKqdO6gsLV9mxs?=
 =?us-ascii?Q?mw5TuMdeks9tCv3WVZmYjBx5/GVkObhVWYyqT6dUHqGG3ysyQ06lHDr7B/5X?=
 =?us-ascii?Q?9U+RHvp65HhOw8uOwW7zAwQqQGjVQEA55sHx8do3fVHxJnWF5iAOGNpIMfyp?=
 =?us-ascii?Q?qEa3Trzlp5UL8HpfVNm0iV9Ug9inmyGqu7ixAwVEc3waB585N7fox/kAkR22?=
 =?us-ascii?Q?Q8ekhgjq4M7pJfa0dkOBsgqP7etVGl5nJUZZeBdEp3O/O2SLVY2H83AFTb8R?=
 =?us-ascii?Q?wQwRbQ2HKWkhW7/ENldvkNkUIYsvCD/Yv5KfB5TgzKes/yZ71wU/vdrfmN22?=
 =?us-ascii?Q?u8TOJg5GAUe6mxLAi2V0r2yMegMCkx6ytFaMKDQ4l7wsZ8O5J+VIGsT5tb56?=
 =?us-ascii?Q?+N2lFjXh9FAP4XkGCVymavwuiXb3CXZjbZ70b1J15xq3RVFlcc12ydTgIrOz?=
 =?us-ascii?Q?vOl7dcShy3jhKVZcC0KiYlXjWwqJL57yRVCiM7c9c4bqcJOsJKFmK9L5DC9t?=
 =?us-ascii?Q?AkA5wCA/nQp8WjZlSGflDdsxr8oDE0Akr284ZldWOLc8H4BL7/JdFkss8NB3?=
 =?us-ascii?Q?Za1lzz3XHxnArlYWDMlaLuUh2XOVCxDs+aVxS1NvSHJnZHXRdnRPLeJwZpyy?=
 =?us-ascii?Q?34D6iO9fo37EFMqNJpxh9awHMUyx+GNn/bIGibjCuNLHPBaDCPvPdGZl2nCW?=
 =?us-ascii?Q?cBFJLsLjpBtCOMT8TeFk4T455n+n66H0yUSfEawiCf0dAMfS/RBGCjIXIxXt?=
 =?us-ascii?Q?tCFkpuho1Nx3G6+uXuBqEVUVztmLwHESfQc951P7+baauBdh8MIjEQGadok1?=
 =?us-ascii?Q?8S6eJayXyLJB2l4J64B6vzGDu5ncdJPKGmXV8D17FsGEdDC2lZEx+H90+WeC?=
 =?us-ascii?Q?y5BWPtqV2MrIlxxhqI/eFS0b51UelJvtLD0dSPJa2Yhi7JPEzP0fBdYPC+mt?=
 =?us-ascii?Q?fOCElBURGpi3UAJNfRIcUbRrN+j3E8OwPqXojzD3iNwcPmAx1IKYTND93iLp?=
 =?us-ascii?Q?bg6HS6eeiof+0ftWRWbRtexNUGPehYNE3NIBaX9bxuu0fhRvnbSRjUuaUfq3?=
 =?us-ascii?Q?h4bm+HSOz0twI/3kKsrpouGcsWnw6V7k8+uYi0WpLJR0jhuTsxgzvYjp4ysa?=
 =?us-ascii?Q?i26TtOp8O20bul2+IMwcs26cq3HxQAbI0mhDnpMuAagPU7RFDexA7M4y5DSC?=
 =?us-ascii?Q?PattCDUALXEc3j+dlDJbvv3a8JAkoiw9RmAuCkOTFMDpSN2irtP/LngVfjSW?=
 =?us-ascii?Q?wgjSmiKeE+T4Fp+EzDikwJOUrYi7Nt3MUlTTPckYlzNbCr2hfXJFPfXyCYBb?=
 =?us-ascii?Q?89oqOiTS/H/vPyaoLek4nYn+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6203128e-d3e1-4147-5cfc-08d8dcd08ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 16:39:18.1312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvv4PDkPOW0T2WfniyxHf9LBObIJ0Z9+n/3sQUAHnQeSpkk1psln493h8yP+KBYgzFhuTSBqaBhG6mlMAxpGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Monday, March 1, 2021 6:56 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>; Han Xu <han.xu@nxp.com>
> Subject: [EXT] Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for =
imx8dxl
>=20
> On Mon, Mar 01, 2021 at 04:02:29PM +0530, Kuldeep Singh wrote:
>=20
> > This patch is dependent on
> > https://patchwork.kernel.org/project/spi-devel-general/patch/161459304
> > 6-23832-1-git-send-email-kuldeep.singh@nxp.com/
>=20
> Please include human readable descriptions of things like commits and iss=
ues
> being discussed in e-mail in your mails, this makes them much easier for
> humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise travell=
ing so
> this is even more pressing for me than just being about making things a b=
it
> easier to read.
>=20
> That's a DT binding YAML conversion patch, why would there be a
> dependency on it?

I have converted bindings to yaml version in the patch and also added imx8d=
xl compatible along-with the conversion. Please see the difference in compa=
tible entries from txt to yaml conversion[1].
Kindly let me know do I need to submit different patch for adding new compa=
tible or ok to include in the conversion patch itself?

[1]
Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
+properties:
+  compatible:
+    enum:
+      - nxp,lx2160a-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8dxl-fspi

Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
-Required properties:
-  - compatible : Should be "nxp,lx2160a-fspi"
-			    "nxp,imx8qxp-fspi"
-			    "nxp,imx8mm-fspi"

>=20
> >
> >  drivers/spi/spi-nxp-fspi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>=20
> This needs a DT binding update adding the new compatible.

Please see above for comments.

Thanks
Kuldeep
