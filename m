Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3852B332D46
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 18:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCIRaT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 12:30:19 -0500
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:62038
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230303AbhCIRaD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 12:30:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPHpWJO5epvlSFgOwixQoaN2yrlI2z60E206s/RmJGt1aqWD8eILap8dj112TpMglDLbivZS+E97KVh+hvbBMJz+CmTbaz0v1FGWpANcQwSBWqWoPVDY9xhEu60TROQqGWQ6FUn9/wOBDAw01Wjm1exmyu4pqLgvjMt1PAcorHWthci6GeSmpHE0fYaS3FrEQfF5ruAN/RYczXzaqv1DmpyCwIEpW3Z5kHKyHJuvhYzntrVhZQjOhRBMsbgoRqLCmG7jZakctHkWMo6u/2wNyjHBpNFdlXc9+H/2Lh188GyA8C7HgXKENx2BAaPDIWuCm8ou1zaT2Z2QNFAYMHjmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD5JfsuWzgmo2mb9Wap1TJ/8HaCT6deNhRuM4bmANPY=;
 b=ngqNCS4k3u5XmRCrbZ8vB2eVj9a89PSSv73GLlgJfNs5bcIM+TQ7SY7Ni34mGM2/hgARNZ+C883MF5yn0rVZ7e+o+7nAxEopouNzrX7D4/dKW6ZTrD5IJJyfCbtoto0tw5fvAaAwlqqcfgB+TRT9OVrBb9/A3oCi11c/X2SCK+CsJ61MBxhGCizI2hTwLJws6dMsuDVL5+lA2a2xYwcxExUuySkoUXXfHjZW7ZvCgQltaP+6VovY/+8U1yO4Jp4MRcE4SU2vus7THcf3cnI5ugNGuPrOsELPAkQdkCc4DX7xjKowSYBekk0Js1VB5sKU5nbpupHmWEQBLE4JVL/SJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD5JfsuWzgmo2mb9Wap1TJ/8HaCT6deNhRuM4bmANPY=;
 b=XLQmxisneMKlPAz8YvBb1xUJsMKqdQ/CESZuG617yvIuMPgH7JGwAcVxUUKtV1JstoTc4aIzXQgU2NsCqnzqU7xjF09s3JBiYHI6qXoXKy2eavljLMSL3BBa+LkGtkt3SGaXq6LUUHwc2XxynwCuIowecmvSSL2V/KTsGw53GXE=
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 17:30:01 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 17:30:00 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json
 schema
Thread-Index: AQHXFM/6iIqk6EfgdU6QexJiEf5Gy6p7hhTAgAAR0oCAAE7kYA==
Date:   Tue, 9 Mar 2021 17:30:00 +0000
Message-ID: <DB6PR0402MB275840529A4F50EBFC723E1AE0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
References: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
 <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210309123601.GA4878@sirena.org.uk>
In-Reply-To: <20210309123601.GA4878@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [27.58.231.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2697cb92-902d-40e1-afba-08d8e320f7d4
x-ms-traffictypediagnostic: DBAPR04MB7223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB72235EBB45866218C6C48DA3E0929@DBAPR04MB7223.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l17LmEJv9dAvJdL2jf7Xj3BrG/ych3WHUjAG844CASBrer2BxieyhdV30ZdxPo4gSZl4op6Pefv/3nhDXhEv7xtFLycmE8raiyNhBnmwo9NGTtpCmzizwWyUGVHvLq8lV1T/Cs28+9+VfEd5zt4iJBFSO5IQXNN8A8DAsdMNSWCXMiMTDbNExE59u0lpCGAPTQY1628OCd0Oi6buvIekYByJ2IjPns/kWd2Jfptg3NjMW8J7tMEQ1ZxNBoi9RP2JFfdpipiGHQxhf5T03SKvMXFcQHWt03Ta4Wqd7f4HUA8oqguww6g0kp8CjlKnRyUog550BoTCWO+w4IOQC/ByWe+vKrjRwOC46gz1N87jfmuN4l3zQ6gUHv7COkM7iaYxMADK9ZKkCL0v2Z/N6Iar9gUs6FzKmWP1a/TSXZMgCr2QOWS0I360bpp3Dvl66ai5vuMZl06lP8iNkPKkF3WeTWJG8Z2HKXKAjUYfLrSmCSfCGdT7tfUrdNE7G+Xlwfu3MUzGCkdV54NCJ8qMgwmvPvvrs3iLNokig9CHUYpr4VgI/rg7K8vmCIeASEJiCYtu3y5z2MsJnZ85YofPKc86m4KhbPXSaGO/KMZCiiYzxLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(39850400004)(396003)(6506007)(26005)(53546011)(966005)(9686003)(54906003)(8676002)(186003)(6916009)(83380400001)(4326008)(66476007)(52536014)(66946007)(86362001)(2906002)(316002)(44832011)(7696005)(8936002)(64756008)(5660300002)(71200400001)(478600001)(66446008)(66556008)(76116006)(55016002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BTjjBkHjjD7tMt4IWFA7EbGiYsGvUwq++03zHgoAhxJDjQYLY2YZHFFXpx6p?=
 =?us-ascii?Q?7r9Q5wX/idFMcn/vYYQB7YRbSmRlbG1G78iHrVsdFKn37OOQYWBxmepOV49x?=
 =?us-ascii?Q?ZSxSqoUOmXTv+VNvUatHK2Dr92SFbXB6R9VL00eihyEXGeLR5sUD/wIUZVYD?=
 =?us-ascii?Q?SZRWbe8juGIkcaUatO3dByVyrQ0RB+8b7PxZZHiocx0Yif55FbAMjrlA2Mo6?=
 =?us-ascii?Q?gdLZVkA2a7e/NwY4iJy9FrOdOGIFCg453iJnpDCxFDrLhRJOJthdKg8V8kyU?=
 =?us-ascii?Q?D5SGp/fdZ7YjlXM3eA2oVjLcpym9s9cxOL/6X3SaXc8Sv1jQYOKMB0iuFANf?=
 =?us-ascii?Q?pHSfFh+Qq98UAId2u0bQKJHMUlMdNKDXCFWp2gy5EK8NzvhbdxsL538aWyKu?=
 =?us-ascii?Q?WgYjcmOu7ohjnzAtGdSa9qwtUmJIQCeQMHy+RT57XLoWTSb0ijp0k7Xekc1B?=
 =?us-ascii?Q?dO3AFcrTLkpBxgGH7h1UCYUOAFO+bVmyPGD0DJcGByNAQFMNrEF0bmRc2jnr?=
 =?us-ascii?Q?ZKxAHCj72k2cZUeqPHaSxn9DRzqlK/0W/4xMB/Z382ZCSplPxQaHtkteVcw0?=
 =?us-ascii?Q?d0jUghToL8mbaRwQeHSuy8cGzT3s628MqBiq74jkgOrpCFV17btnC2FYsx59?=
 =?us-ascii?Q?6M7zx+1wf3jTpgPFcVoUOkg9zX9hk7Snqq0j4YRTGZQgqvsbxYWv4GB0d/B9?=
 =?us-ascii?Q?hKGey+0rhe9cTyPxErYXi82uhUb86wgf2Pt3utztV8raWi6HNGu+DNuCEg2d?=
 =?us-ascii?Q?7VDbhH4gOxZBE0ncC6yN35777zgMsug3vWzAiXLQePzfUHMNYfFBydiGWlg8?=
 =?us-ascii?Q?gwIR/nJszXipIGzM2ZIS7t2W8f6DAO4j0JMMG+x1uTIll8WV3JapKltn8bbp?=
 =?us-ascii?Q?qUBwht1tbP07d5S6n9HmxRigjsDGmzewva5W6e8uMNq7+HOvQu+9+zbMzNpg?=
 =?us-ascii?Q?V5+Bg4O1Xr1n9uReCnnejKvuFevhsgBlKq12p7YJDFDr8M5VSMMTr1rVZBy4?=
 =?us-ascii?Q?izD0Fni1yB4cr9C8CtUHrFjcHQda+xhata0Pzq2HWOni+cSeMgBnQA08f2B4?=
 =?us-ascii?Q?/WCoL+DK4ttX8d0c+kwMYDkzbdBm9LrK8rk29NwDd8trdVPEt+7c3HGa3DtW?=
 =?us-ascii?Q?7ad33cO2DDNSZqhnCTOlEXafkq913FLy9/P3Z3JQPR3ZJBJfbMSGlTPwPZzD?=
 =?us-ascii?Q?2urQxFSxU3fdbJzxV4ljaXWeE3nHpJnkyKeQLeOY4dTL1kK/JeeT7tD/FQeE?=
 =?us-ascii?Q?O668UY/d12XJIl4N0kwRuJBSc7YhKZC9/PzbQONdyO2xX+FngH1G0Fq9KOEA?=
 =?us-ascii?Q?7MM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2697cb92-902d-40e1-afba-08d8e320f7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 17:30:00.8035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZRE/8zSt6RGJDjbZVTOLAbsIP9RDpUXmZsEYaaGx0J88ECNjfNMeNDGyBGoKG4SLYS6liQqtnOpA2Zmm6QNAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, March 9, 2021 6:06 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ashish Kumar
> <ashish.kumar@nxp.com>
> Subject: [EXT] Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json =
schema
>=20
> On Tue, Mar 09, 2021 at 11:41:50AM +0000, Kuldeep Singh wrote:
> > + Mark (Forgot to add him previously)
>=20
> ...
>=20
> > I was not sure with which tree this patch will go through.
> > Currently, I have rebased this on top of
> > tree(git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git,
> > branch: for-next)
>=20
> Binding patches generally go through the subsystem tree so please send th=
e patch
> to me.

Thanks for letting me know.
I have developed the patch on top of your tree and also sent to spi-devel m=
ailing list.
Please see [1] for more details. Kindly let me know if I need to resubmit t=
he patch.

Regards
Kuldeep
[1] https://patchwork.kernel.org/project/spi-devel-general/patch/2021030910=
3528.3538910-1-kuldeep.singh@nxp.com/

