Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACDB32A5DF
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446152AbhCBN12 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:27:28 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:9088
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1381333AbhCBFUr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 00:20:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifsRdxRrRTkYgf+59HwevtexaRPAzqbpHBgyx2tS5pmI4guLQQln+qvjBrurG1gIv1xJYhtdHhSddrMIc8kooJfkqGHfr3a3SNhx2i/L5/jgo/iMz7fE0SudCShsl9h1FIv4dBAN8WCBj66GeujF/X/0NYYPT0r9WZ6GXn7QJnS3mz/DrTZCBe9Qli0q/lNR2HH+dP+web0xE0DJ6o0GZJ81QrZN6jx21Z+7pglCRq0YCijYvaHPtVRkwRdzWdHfDA95kWxBxkOysviMObv2FtafmYPqTRRtbj84kp9kINNsiXIWW1hvtCTQ2rcYJ1OtPQGhbz/yFjM5MNjtUHo3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrSpHxl7EtR9QktsNP7nQMKiNZWNeg6JnsBKKtaZNXY=;
 b=kL/nEf8k5toHLg9gKhZg/3O3lGrHcYQYwns0ooz2C0qz90Woi4wBe76f2P7ugEFkzFIW/lxcaVtvM45ZLemzYgWYnoyPs8He8IkpUxyOt8IX8tkH4+EblkXYtw+duqUK74YDibH6tmEr28Ls/D6TYX71FUtmpnxIqOlTUZVTcI+N1Dl7s8go5BRouKJD5HmdDCzMtkopfGz/wHCTu1Nr71XGJzKJJh+wgcqjds4BiHypAo3ok4FIyoBULyEM4Nftu0eVfNNH2Gd3VXhw7rIVK37UqNCqwImJ80f2b1jWP+ETyfARlDcB727i4ugHrk/vfzo7Q3aegVaXNf29I2I0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrSpHxl7EtR9QktsNP7nQMKiNZWNeg6JnsBKKtaZNXY=;
 b=lGkNnLfcP1c/mtBnIz6mMc3HptusLrCynO1HZaX2G3MKyXfmFU3XGGV6UaWI2T5Z2md9N08nBGupbMGCDD+zXIrhTAS0XWvQ0IvZ00XNeXEHOttdyhDYSco70s9r6PTfweCupN8TpHLeHs2nERvUi+vKGXfXQkgXaClaQyGV/ME=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB6PR04MB3128.eurprd04.prod.outlook.com (2603:10a6:6:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 05:19:57 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 05:19:56 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: RE: [EXT] Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for
 imx8dxl
Thread-Topic: [EXT] Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for
 imx8dxl
Thread-Index: AQHXDoY+gDfnhwGOzEaNbBXq0bNZoqpvH7GAgAAzDSCAAAv2gIAAx0ug
Date:   Tue, 2 Mar 2021 05:19:56 +0000
Message-ID: <DB6PR0402MB275830516E1930F051982B88E0999@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
 <20210301103230.1816168-3-kuldeep.singh@nxp.com>
 <20210301132539.GB4628@sirena.org.uk>
 <DB6PR0402MB2758C61D8320CD0A88DC3B38E09A9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210301171111.GE4628@sirena.org.uk>
In-Reply-To: <20210301171111.GE4628@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.176.14.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0efa184-bb66-48ad-5190-08d8dd3ad1b3
x-ms-traffictypediagnostic: DB6PR04MB3128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB3128A33374977046F25F63BEE0999@DB6PR04MB3128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgZ2wUNE5RfapT0pqmpAmYT3JqAT4447FeqwPCXeSqTbN9tkO8u6gJQmYbGUSsdQdT5Zn05QiLpDKtwexUyvv6j7TiHDXp9NTi5IwsVR/ITEOps+a3rEqXQfgaSQ55L2Ajp9vqCEAGwcFw+H9pCCOCaQ6toF2y1kA8Prlqp46lwHc+0kOEPskuPqfr4skC4zJgcn4d+E0skXglxE0MzwKDbW1pllnd0+AAeOou8R6DzOnkL6AXglztmS0k4Z3bYkOL+dhzNjZJZ7ekrb/bV2GVfiqpedc0bXoFtFU1C4QnHX82fu7bJCN8Zv3IuoyTiU+wHWkp7+T3nniWEUV4NEvbz83hqQ/27aoWLKOTCPkxoDGDpjfDDt0CZ/oiuzQDcH22KDOiOqASDdGj9Jrll+Kn9BPpfw6yNO3RSzVSlKrwqFK7MzA+UpayXLyp+0RIPIp4R+ODjSYNB2Tq/waQKUd5Rm61Lsr60tMVHE1TGlERLh2AfYxDYwHHWJD4FXaPnoe4hf0hJOEp65xC7UglTJM55vzWhTr6WVyxUnWjpXEVjP/EZ5PSHEA6Fl1zVhiQgL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(478600001)(66556008)(86362001)(4326008)(8676002)(4744005)(52536014)(55236004)(44832011)(33656002)(71200400001)(2906002)(186003)(5660300002)(316002)(66446008)(64756008)(66476007)(6916009)(66946007)(9686003)(7696005)(54906003)(26005)(55016002)(76116006)(6506007)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C5gHWyRgxnMMcHBCJBf5waZlV1MDghmXWdzmXkDXk1Yl3FCB+r5H8C7CalJB?=
 =?us-ascii?Q?hklyZznM92wjePHB0itwCpeM+909d/4Y9MHF5I4dxS270gfX9ZEAXc37OAAx?=
 =?us-ascii?Q?JXq3hp7HSUbjP7erT3T/HoxY9ugUJ1hlyUzCXDHVINy1ctwYBIwrGc1uL40R?=
 =?us-ascii?Q?aaHDeeioPyq5YzoVF1/VDFjIuRegRFzL+4XS7vjt2Cp5/PIt+4+vyDiZFSKt?=
 =?us-ascii?Q?7bL/oofj/1fF+DpZb+x/aiWxng6pIFJu3i3lkqwMsLRdV42o8ooTJTp52KM0?=
 =?us-ascii?Q?9RWySllKnoM7k7nemECqV2t1UA/oX6n/cHKEHjS6Y1hYkqwrkqiD01kHvLb9?=
 =?us-ascii?Q?SzeuOkubZxjY9X+SY3S+sXucCxag41r4pFQwddM7Ewt8++HG1yD1MMOnLnd5?=
 =?us-ascii?Q?JJltunT412FKHNB8jxE2wgPsj4zYAbmSJBDp3TGyWwS1fFncOJ54UxCWUHOC?=
 =?us-ascii?Q?pz3P85w24YKdObkAlje/yCPB1PaWxaI8Vz8b0qpe48IipI8Mb51upnoqUzMf?=
 =?us-ascii?Q?pXUBGDypT+peljOFdUYjmM3B7lpVY2DMlcmKvjuHB3QZAkspFzdUyN1JAnMc?=
 =?us-ascii?Q?pDYTp2FtU3QQJ+e5pMYmdkixgxDVywkxl60lg5BmTSaWfKfbBh28H3+Pe3Tn?=
 =?us-ascii?Q?trjmbaCb5fGT7V82mdSCTc3BhB8dQ+6cja8w5R6hvnNcYtCrrmJFKt8F1sRY?=
 =?us-ascii?Q?DObGm3fD+KlNaHGR2qRZzr3JUoUevekpkmx5BdtslS/iwPP1+CEjToX884Ff?=
 =?us-ascii?Q?tSvYqWBB4yd45i6y4Qzx6wVlpMbdhszic4Rrh6mqTBknhCG+nojAizcn2A+Z?=
 =?us-ascii?Q?ib7ZTZ5dE0PMyrLtCgKt3hFO8zcl2j//zidENVgSTIWviWnUdTKt+F3veJLV?=
 =?us-ascii?Q?BGPg+QBTEZmZnJCgkA5eF9fL+0SCgMySQc7BzyYZNYnrKWv0V2QteFSr1eqn?=
 =?us-ascii?Q?aGSiTU/rGNUqCtA+UsslY07LdfSfzbPGUzcafYp9E9IwM449YwkqXtSrkgnm?=
 =?us-ascii?Q?okCVpTEER99xtFEt60kez+XZRuRnorSzINc0VEgyT5LRDTUR8Ow4hdZpGrkO?=
 =?us-ascii?Q?XFlE4NfBNNHrfrzJ/GYylz6nQu4fWt3DIijT6zds4+diNmPw++zwV/YOPWw5?=
 =?us-ascii?Q?SodkN0NxjMKtwJ5iWibTAV2asi6A2X3rIk+92148xW5K7oSLju32hkFXMSTE?=
 =?us-ascii?Q?izp12cFFIbpUavXCXcee3c29aD95Cg9mvxj8K61+WbOchr5UKUYay9ccGMwG?=
 =?us-ascii?Q?ep6h3d9emOVi1HkVZ8NFhgd6QOVPGRplygzdcZQ1YwipS2i/imRNRdc0uUHA?=
 =?us-ascii?Q?s0QnlUFFP3uoimSvQF0QNtvS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0efa184-bb66-48ad-5190-08d8dd3ad1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 05:19:56.8037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4e0NCaXLazsCOSfriG8qrPCVmpYDh67a9et6xY2o99UT+4IaZUr5D+5mtLk+M0ft7apPzeRJmYwzZ7xUVMuLyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3128
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> > I have converted bindings to yaml version in the patch and also added
> imx8dxl compatible along-with the conversion. Please see the difference i=
n
> compatible entries from txt to yaml conversion[1].
> > Kindly let me know do I need to submit different patch for adding new
> compatible or ok to include in the conversion patch itself?
>=20
> Your YAML binding conversion should have been a standalone patch only
> doing that conversion, the new compatible should have been split out and
> gone first - each patch should only do one thing as covered in submitting=
-
> patches.rst.  As things stand the changelog for the conversion is mislead=
ing
> since it doesn't mention the new compatible.

Thanks Mark for mentioning.
I will send compatible adding patch with this series and post yaml conversi=
on later.

Regards
Kuldeep
