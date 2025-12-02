Return-Path: <linux-spi+bounces-11705-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133FDC9A637
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F6E3A5F97
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90B21D3CC;
	Tue,  2 Dec 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V39aCt+8"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4B19C556;
	Tue,  2 Dec 2025 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764658869; cv=fail; b=pQW7q+mmvd/CbzJ4rMXbfhbtuSU5ipj+Rt/t+kP9bgu8ervl3LEqX4bHwls7Fn8X9AmcBi2Wa3E5WBgM7cHWMLYEz/TMEoJuHNihv2f1nUjVKWCVYwF//2UoI2GtBogHfqRuPzKYlSTybwPD8S53nfHnCmw5th47LL+nwMrbhTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764658869; c=relaxed/simple;
	bh=LHvGJgY67/X3f5JWruSAXaFrWyJz/amTmFqgnIbryIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j9sO59Be/Ej9gxeNdpGpFTPyWE2YavJgghQQRuEoUYxOKudlgdf/wYtClqcXKzBLWSm2hnkADVlLBlQt1OVpWONdYh233VokKbPMJJv3y0T6TUk58k9+FU6ACJKsInogUPTii5WKt33wTmRbbPa+uJCojVkDZ0HLdJrwfQwOqgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V39aCt+8; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/Rsgxcxhyn+dEDAK0SX99vcTlAFUmz3G96C74J/ylJ2dvxvulELqGMN407uvm0WgxuQwjSLG2RT/G89rTwd+5ZtK73rSDm+twbBW7WKlqVn4gOOCEjY2t7G3/d9ippAVxiSsq7WUK79Jf/e5s737RosW2BVSAqqIYaAx91Pqrka9wmcLmy22TwdJ1L/IX6orNeN4MHAar6IhDgvQ2on0c2Xcm4dOk8zLCUCYG19POITwnzi7ek0YB+XxymaD/i+NcIem/bPJXxS1T3Q5QCjP/8kKhdXlDj47FUn/cFXdRWc1+z3jirHseYttsPqH8s9lOv/Qf70aCRWCQhQIIQa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjPXHDDb8C4INWIPN41mTZva2BjYcMQz7dmR5hvs5Eo=;
 b=ci89ivgzqYKJqh2ecbo1opsnEkxgKAqkYPtlbUXyTwyqHTBolV18bTdxRrvk20ENSk70ViwoSWmGW8ftgz0gZeWGpppW/TNNiJjtRRQU/soLn9tvuSSS/r7WiqZEgyeZsp3hn7EC2dSlFciiPkZ8HV48t2i/hFNfJpo6709+9jcEiJaijavFEjYsa3xCkYXPzoQYcMhknsc0+gYPT2vEjXhMqKEhxLhzEKGBvT2CY3dE3ZnaeujqFiTHuRpMrd4nPo46/JmZd69gHnLKff3OpqKVOPDrt+Qo6/vzuhhv0JRgkPKmKXSkHHtXm891egCv108PJ7Ca5Tk+JDrzClahcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjPXHDDb8C4INWIPN41mTZva2BjYcMQz7dmR5hvs5Eo=;
 b=V39aCt+87GH53+XGjBvFAVugD9LaRHusUEU80UioXYYs/9d99DmtAJqDJO4uRbm80bc7rt1PNUUbMK4PVcnSTERh8ioE2qziYiK5P8yVFF4b+DWiY/b4esvNnsUHkb8fCjMigdMbMsQH3j1bnreZ7e/M7kIsF384elR2lwQKvlQZMnwYZ3uaqBnX41xKffUqqacrhWpq1woACN4BP6IaKUs1B+p6eWuc72uUdTYAM++cfds/LRD6iASFR+KU509UJ1rNIuDoz01EZLHpFC+i0xJKUKsMVygMnu60sH7lgaq+2f8+ei1Skg3X3YyBwqL5Ko3ZHhlOCNh8acTV6RPFWw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PAXPR04MB9303.eurprd04.prod.outlook.com
 (2603:10a6:102:2b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:00:59 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:00:58 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "broonie@kernel.org" <broonie@kernel.org>, "hawnguo@kernel.org"
	<hawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Thread-Topic: [PATCH 6/6] spi: imx: enable DMA mode for target operation
Thread-Index: AQHcXfNYgnkhVybOTEWLiW6Jy5/IP7UDjt8AgApjUnA=
Date: Tue, 2 Dec 2025 07:00:58 +0000
Message-ID:
 <VI2PR04MB11147D35A22A7B29384468B21E8D8A@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-7-carlos.song@nxp.com>
 <aSXT5tzhfHYVUrGy@lizhi-Precision-Tower-5810>
In-Reply-To: <aSXT5tzhfHYVUrGy@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|PAXPR04MB9303:EE_
x-ms-office365-filtering-correlation-id: 4cf625c3-dbce-4d26-2a3c-08de31708bd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w97YNlYTyW48SbJCmyrzQJjlfjcvMltR7oBEYYglBoi5bo6EzoRCjuJTSvKk?=
 =?us-ascii?Q?nsSGLxj3u5J1D8I0LAa3aqK9ATW1oLRPSokwo3LoAMDUdsT3GgW/81puh2op?=
 =?us-ascii?Q?bLgSNlWFCr2NY+vPimFusO8xLNVEhavzu6Md3OHpbXz1cEJfJWWz4QYsWqbx?=
 =?us-ascii?Q?2Jjix/jJgrLq9uyeMWUTvab5G1GkrkqFVBDLbgjt7CosELdytzCDlso08+vX?=
 =?us-ascii?Q?ozHMecr5qCMG1gDJfoJWj6J/kB0IAfDxX4TPphsiKksEgU8N7ueTulbzUaJ6?=
 =?us-ascii?Q?GbnPRdLUvlJPdcJqNCx5we/fR6WDD6nMo4LJvgCmJ9s11zWHrfS9OZ6QAcaw?=
 =?us-ascii?Q?UKDomXUgGuc+e4owIkD0mG1taVaw5vkPzFBI6Vhw1VV9aOztPB2JoPrCJywC?=
 =?us-ascii?Q?nr1SEFPxAkUS6t7dDl5ig45NhA6IgshviL5wr+5oTvlBUPzkcbaty0uk4dIb?=
 =?us-ascii?Q?fyV8SLfkXJtz37yEcarDcOkaIWdx41nVIgzJo0SMxbWAoTP1aYlJ8VkZDL2h?=
 =?us-ascii?Q?cwazvMGRoNj2YX8y24o1SU5qhqxKMtvSgS/cksTfGdi+ebOW8YZle4pstLka?=
 =?us-ascii?Q?E3Sc4kJCQXGKKdrLdcyIMuaIOtlL7ZXizbc82I8st+l4SxC0eKnb4eyfWkzm?=
 =?us-ascii?Q?TRhv7x1pl/1SjqAw61c3JCSrOybuCIfLBjM6BJVSTQP0re/4sEEjFWV+9ctl?=
 =?us-ascii?Q?kBDLSeplKPScXpU9e/7O6a4UQaCTZgX+xWBEEYgcEAfMObZRy4QVmMhu7h62?=
 =?us-ascii?Q?qaMkkr+vmhEWQi7+jQEJUrD/wDZe6fop3yJoGQCxDglCKi0ULWnidggcmr6T?=
 =?us-ascii?Q?8l8vQlM3o16rse0t6Po3B1LVKHiYDJwrm2yWqWRsUqvHWVwq3B2AzSy9YOHC?=
 =?us-ascii?Q?P+rLz+dEDsVzqgXb1uMaPWwFOlPFYl47NkQt7wvu+nemD2hfMef3EOeHPdR1?=
 =?us-ascii?Q?L86103MjtnRrk3BMIRcNOXyELdo3eYS5D16dkVoxsekiWrfrHjqL1jNaa+Iq?=
 =?us-ascii?Q?4WZDp/MfA5iJgplEhvDKvLT64HJrLnCT2c0bcAbgYYRe6INoyWTEy4bKgwEm?=
 =?us-ascii?Q?EafKcerjbxrdQENz2obdTsRZUl6DUT2tN1ekDGzRhyn+A94O2wiFbIF+feeL?=
 =?us-ascii?Q?3k7+q7siKNYTkhnqgpap2h/YDXQlnvC53k/G+93H/JIeNs59sGo99pw6u7J4?=
 =?us-ascii?Q?/w07XBaX3KxlnRk04W7LyIHJoo60p221pSccfsYxh265tAyq1KHoKWEyLfZO?=
 =?us-ascii?Q?czEKj37N+sncp3ILDXXECtvdU4cFfhg2MSYbpoCXHNBc19w87ti2CX1iAheA?=
 =?us-ascii?Q?4+T+VUx6MBMWUoRgDdj4TrPH40pR2kkl2imAsLngAgT93a80qv5BhQzLJZxu?=
 =?us-ascii?Q?YrWLNimqnJ1EY2vs7wVeQUVmGTCy9eY9D30rubTW1pCeZBXAB5AzH2h4Yvcn?=
 =?us-ascii?Q?EuEuH/uOz2717x2lFoTWCYJTLt4KLN5m9wnsPEJ6K4rzNdDUe3gVlk7mbgnM?=
 =?us-ascii?Q?dLzwXR4DPHfNbx1MF6Z8V1D6irn4Z71/6ZFV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pquDuZlVWaLVa50oH7W0DrdNr/y+uFwp7ZjeY+7JP0ZI/7+n+qxE7N7NoA33?=
 =?us-ascii?Q?uHlFHclmNzjU1MvgwugUBDQFaT3EDp0iVPyoECyGnrYe0wkW2+UbA77ON2bm?=
 =?us-ascii?Q?Wg4TzsFntGkhO/BCp5mFEmn9vhgVu+9A+jhOUlpjT2uD7YBZJR+jX3LpkBRf?=
 =?us-ascii?Q?DfN2wzlVMLRZbeS9vGzqCdX22ePP4gzooug2T25S0qU97MQcJ0xIEIxW8juB?=
 =?us-ascii?Q?Mghcx4krb9oPAc4uhxVmxcS+ZwfRxHzXTtakc/umM1j0xIzMfAF3R/AQ1U3w?=
 =?us-ascii?Q?DCqjJzf2e2X5TmDE9hsxu7ScdeoEv0BmnHaI6WVguJwTL7yTJ+KkbRfWdXdT?=
 =?us-ascii?Q?FNei+fS+Ff9j7XugQtMRVPpw1Kg3FF0+WFH6G+IlqT9tJ3uCaTmmPWmYv5A8?=
 =?us-ascii?Q?Nn3QQ1yXmMATSIdP2J56Q0ud1ICXEwo4tI9WJ6Xo9EDbMQZ5IIypsGPfYS3X?=
 =?us-ascii?Q?J/Q1FykbGR+EiMNG9q2yAec5YvrocIm67LQz56MWaxfxCJjB8hf6VYi4IL9k?=
 =?us-ascii?Q?kWNLv3zO+vxckK2d6jKGcE8673qgNQOYMbcPdYlwHIHfq+RUfsp/4nN5IOqq?=
 =?us-ascii?Q?ivhToThtRZ9lY+7z3TiM9RSU0p1otZ5EBhQWHtAxUSPYm4uKDYRkMDW+wBDg?=
 =?us-ascii?Q?IeMIX8edMyXeQ/RFJs5+zryq4XU6Ge4IRGhQJ5tsTqGvBV80nOhXv6IQmP/X?=
 =?us-ascii?Q?8X+3yd0e0bPjKv6j2AGkzgBWGkCO87tNzVeaqDutfYPOGwViwm7gWyeXy/1r?=
 =?us-ascii?Q?L4q+MYGF3JhBNYt+o3TuZMq0CgfGOJT3Z5oMVGzUeQA7hx6FeevRpUPyBd/t?=
 =?us-ascii?Q?PRF/npaO5Ijby4Tt6ibQlKA5XdyzBI/kBdOPW8bGAawQim8IJN+bOZjvbOy9?=
 =?us-ascii?Q?1w8Cv8M7pcooK6KZoTW8hii0T/NQ5H0Ff/yqYOh/kpsF1V892lDi3/oshGkd?=
 =?us-ascii?Q?mL9pxNkhxrvqnA36jj2VV/e+kxbc63C+bTBtZp/NcWoCAZlp/A+CV0aBopMQ?=
 =?us-ascii?Q?IaoXihXYaG5RqvG13eTFHKaU/1gXI6XR2S8antQxxXx60MZJN3huykggp1Od?=
 =?us-ascii?Q?7Hda5MKY+gw7tp58DA3hdJqD3IOSy8MsHnLeotL4HJSVxxxwmnBvlEJFU80A?=
 =?us-ascii?Q?T4oDqjonxorvXMmXo2lq/MgqYspwoI4wnGtYN+eXU0D+NG2OSKnNfvYE9FnP?=
 =?us-ascii?Q?MLAU6XlIfifBG4QGe7YAh/l3XRa3s/79CynPqecYcuk/VlprYH+LXQCPAH0/?=
 =?us-ascii?Q?4Q6VSSNGiYYSniRDxrQGV4k0k2VEFNW7yvTccXSb2KRJncFdHMHYLJtJe50I?=
 =?us-ascii?Q?ihYkYG1/bcgKk8BQfTtHH/2jCShm56WndpSBtwzdRq/a5zm0Noh4COPNpMIC?=
 =?us-ascii?Q?gzirPpmwC8yHdiK7lj7PG66HmVehDVPnfPA+nFef7TZdcbc93ZjAELW0UYAA?=
 =?us-ascii?Q?/ksvppGMVwWpptX531NMGN9AhMvAzhIXemwk9m/l0Zo02DCzFTRRkq4EW2lg?=
 =?us-ascii?Q?OO96CXyNVBKldVkg/12G7IcF7FqDoRQqkmZCykxDeHhB9hHsfj3fgO+z0q9p?=
 =?us-ascii?Q?0l8skKkCkhjHDoc5xXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf625c3-dbce-4d26-2a3c-08de31708bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 07:00:58.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBvYw2QDMjWGAGkpqoRtx1xeLBiH10faXG3jWvDfCgGqx8RIC4XLEd/pJjCozNaXW5RV3wvlsFt44btizaONpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9303



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Wednesday, November 26, 2025 12:06 AM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: broonie@kernel.org; hawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; linux-spi@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 6/6] spi: imx: enable DMA mode for target operation
>=20
> On Tue, Nov 25, 2025 at 06:06:18PM +0800, Carlos Song wrote:
> > Enable DMA mode for SPI IMX in target mode.
> > Disable the word delay feature for target mode, because target mode
> > should always keep high performance to make sure it can follow the
> > master. Target mode continues to operate in dynamic burst mode.
>=20
> If two paragraph, need extra empty line. If one parapraph, move to previo=
us
> line.
>=20
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > ---
> >  drivers/spi/spi-imx.c | 78
> > +++++++++++++++++++++++++++++++------------
> >  1 file changed, 56 insertions(+), 22 deletions(-)
> >
> ...
> >
> > @@ -1756,23 +1753,51 @@ static int spi_imx_dma_submit(struct
> > spi_imx_data *spi_imx,
> >
> >  	transfer_timeout =3D spi_imx_calculate_timeout(spi_imx,
> > transfer->len);
> >
> > -	/* Wait SDMA to finish the data transfer.*/
> > -	time_left =3D wait_for_completion_timeout(&spi_imx->dma_tx_completion=
,
> > -						transfer_timeout);
> > -	if (!time_left) {
> > -		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> > -		dmaengine_terminate_all(controller->dma_tx);
> > -		dmaengine_terminate_all(controller->dma_rx);
> > -		return -ETIMEDOUT;
> > -	}
> > +	if (!spi_imx->target_mode) {
> > +		/* Wait SDMA to finish the data transfer.*/
> > +		time_left =3D
> wait_for_completion_timeout(&spi_imx->dma_tx_completion,
> > +							transfer_timeout);
> > +		if (!time_left) {
> > +			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> > +			dmaengine_terminate_all(controller->dma_tx);
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -ETIMEDOUT;
> > +		}
> >
> > -	time_left =3D wait_for_completion_timeout(&spi_imx->dma_rx_completion=
,
> > -						transfer_timeout);
> > -	if (!time_left) {
> > -		dev_err(&controller->dev, "I/O Error in DMA RX\n");
> > -		spi_imx->devtype_data->reset(spi_imx);
> > -		dmaengine_terminate_all(controller->dma_rx);
> > -		return -ETIMEDOUT;
> > +		time_left =3D
> wait_for_completion_timeout(&spi_imx->dma_rx_completion,
> > +							transfer_timeout);
> > +		if (!time_left) {
> > +			dev_err(&controller->dev, "I/O Error in DMA RX\n");
> > +			spi_imx->devtype_data->reset(spi_imx);
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -ETIMEDOUT;
> > +		}
> > +	} else {
> > +		spi_imx->target_aborted =3D false;
> > +
> > +		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion)
> ||
> > +		    spi_imx->target_aborted) {
>=20
Hi, Frank
Sorry missing these questions:

> Suppose somewhere set target_aborted to true. I think here should use
> READ_ONCE() to make sure read from memory.
>=20

Will do this in V2.

> Not sure why here use wait_for_completion_interruptible() but at master m=
ode
> use wait_for_completion_timeout().
>

Because target should support ctrl+c to stop this transfer(need interruptib=
le) and target will keep waiting until the master clocks coming to shift ou=
t/in data(don't need timeout).
So use wait_for_completion_interruptible() for target mode

> > +			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
> > +			dmaengine_terminate_all(controller->dma_tx);
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -EINTR;
> > +		}
> > +
> > +		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion)
> ||
> > +		    spi_imx->target_aborted) {
> > +			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
> > +			dmaengine_terminate_all(controller->dma_rx);
> > +			return -EINTR;
> > +		}
> > +
> > +		/*
> > +		 * ECSPI has a HW issue when works in Target mode, after 64 words
> > +		 * writtern to TXFIFO, even TXFIFO becomes empty, ECSPI_TXDATA
> keeps
> > +		 * shift out the last word data, so we have to disable ECSPI when in
> > +		 * target mode after the transfer completes.
> > +		 */
> > +		if (spi_imx->devtype_data->disable)
> > +			spi_imx->devtype_data->disable(spi_imx);
> >  	}
> >
> >  	return 0;
> > @@ -1895,10 +1920,16 @@ static int spi_imx_dma_package_transfer(struct
> > spi_imx_data *spi_imx,  static int spi_imx_dma_transfer(struct spi_imx_=
data
> *spi_imx,
> >  				struct spi_transfer *transfer)
> >  {
> > -	bool word_delay =3D transfer->word_delay.value !=3D 0;
> > +	bool word_delay =3D transfer->word_delay.value !=3D 0 &&
> > +!spi_imx->target_mode;
> >  	int ret;
> >  	int i;
> >
> > +	if (transfer->len > MX53_MAX_TRANSFER_BYTES &&
> spi_imx->target_mode)
> > +{
>=20
> why only target have len limiation?
>=20
> Frank

This is a errata:
Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip Select (=
SS) signal in Slave mode is not functional" burst size must be set exactly =
to the size of the transfer.
This limit SPI transaction with maximum 2^12 bits.

So I add a limit for this. I will comment at V2.

Carlos
> > +		dev_err(spi_imx->dev, "Transaction too big, max size is %d bytes\n",
> > +			MX53_MAX_TRANSFER_BYTES);
> > +		return -EMSGSIZE;
> > +	}
> > +
> >  	ret =3D spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
> >  	if (ret < 0) {
> >  		transfer->error |=3D SPI_TRANS_FAIL_NO_START; @@ -2104,7 +2135,7
> @@
> > static int spi_imx_transfer_one(struct spi_controller *controller,
> >  	while (spi_imx->devtype_data->rx_available(spi_imx))
> >  		readl(spi_imx->base + MXC_CSPIRXDATA);
> >
> > -	if (spi_imx->target_mode)
> > +	if (spi_imx->target_mode && !spi_imx->usedma)
> >  		return spi_imx_pio_transfer_target(spi, transfer);
> >
> >  	/*
> > @@ -2116,7 +2147,10 @@ static int spi_imx_transfer_one(struct
> spi_controller *controller,
> >  		ret =3D spi_imx_dma_transfer(spi_imx, transfer);
> >  		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
> >  			spi_imx->usedma =3D false;
> > -			return spi_imx_pio_transfer(spi, transfer);
> > +			if (spi_imx->target_mode)
> > +				return spi_imx_pio_transfer_target(spi, transfer);
> > +			else
> > +				return spi_imx_pio_transfer(spi, transfer);
> >  		}
> >  		return ret;
> >  	}
> > --
> > 2.34.1
> >

