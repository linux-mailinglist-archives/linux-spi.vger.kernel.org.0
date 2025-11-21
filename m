Return-Path: <linux-spi+bounces-11449-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1C9C77E13
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F4614EA7A3
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC733D6E4;
	Fri, 21 Nov 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DjUFckQQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5E33B96D;
	Fri, 21 Nov 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713104; cv=fail; b=FIbZklWDWv+Ia/GW/br/PDcYCOv/WALx+zHhKc1BAVH405CQVLgtbIP49efH7KlRbi95EeuDz8Na7fGbwvy/qQXrQRgOT1mNkbspYlRbpUhw+/w/wxcEipIHinu4vEe9i8QGcYk26CL111QcuJxheBFYi9j0JFsNOWn2m/O5K3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713104; c=relaxed/simple;
	bh=KYZiR+/04J8hmqvo9M+jpxcKcVz7lgNuVlsu+OSPCNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoxaDHbJ1Cdthix/CzdPFolkg3BlebxKBO9ASxsgiywtFDL9mryIWea5ouxRq/GAuzVPtP+Kj0HF5HFcUjA29Ob8rhMLb3q28K05YyrYBnyEyqhfjmh7rH9R0jiESgRaDBkPbgKj86zYFgW+UUD/DjKIEvTaWTSRv9q2koEbPCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DjUFckQQ; arc=fail smtp.client-ip=52.101.83.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYNEmR+frHhIo7Ay4QQ0yh+KpvOQJZ7Ab5t0bhxs4fpn0eRBJIIFeOcucUVokJkHI/okq9W9rBy2jSG4VCXx6koWmg71RGtjqur7E7ZanwGE+UN4apD5UTdxUVqin0kAnk126m+Xyg8CsIfbDE0PSNVdtWPT5ASDcNgGzKOdTBXlw9Z3/4Ik0qAbm1L5YVc4ZZgnyzJ85/HddOA9nrESDvzcxUBwn+f8nDvRhrbYTyfzBMy1DEU8P6O/KeXDT3+X/+ZTzVWiH9Jmw9xJD20RMH5lsswbZxKUMy/xgj6YCErc0iKxhZwCq3lu6N+iHWCXKTHjAs2MiVdrucFwJSLr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiDKNfr9PhPGmaMa56yMu6Kh5ujGIWCX2OidVz1i9Dg=;
 b=qhE2uVd0FefOHxcByBVWbHCrn7OlXsnN/Tdk0pPtp7SS+MsqqFhUHUoM1S6zDlILlTIZUj9MBp+PYJkjGWF4uVcciK5IrnMy33GCflAQMUCOOIbNNlG6QyV4cbr+BgCxg3QdBd+rlx2Ug/u6cDrjm/QSJbgFVUgo0493lXWX7lrByWFIchAe3t19MkJ02dwPWIUBn9aXBvKpefkdQbrgmA+CqUwne2ni7nEb8fPcUkGoW8TLk7dleeYIMbEqGro4rpQ2z+EwYwh64xYTgslgEUKLGAx8+vl3WDYbyvq6f3koJFL67KN0Xd/8Ij0qEHe9GVjiu4CjP+H1XI+R5pgNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiDKNfr9PhPGmaMa56yMu6Kh5ujGIWCX2OidVz1i9Dg=;
 b=DjUFckQQvq0bRmN1Q3RMeZvZl0Z7vh/vIESuFuOVBpKVPUTEElAQO5MjZnsBMkXOWUnNsnd3XAOeIBhCLY8uHpLYYUmFZSDCbufjwKm12RKXcXxOmb5J2F0mRQylEKnxdGRNtb4mHZP/Mjnp7f+Z2YQ6z5sVb8aPSdwUlEyFJzHGaTHKnTPzyx5liQTSboNTI5CyN5N2XRngO3sy9RKJNdGBr1VBy4xHzfg+caru7E+th+qA44cFUS/vW/SMlZmRs7BFfDCGrd0yrAd1bQKQXE+JMqHzH6wJymOuQa9rrhN75S+Ene4vFfPfYZtFfSiCUiNJRFOXUkCvPQ8Ehmv6BA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS5PR04MB9876.eurprd04.prod.outlook.com
 (2603:10a6:20b:678::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 08:18:18 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 08:18:18 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Carlos Song <carlos.song@nxp.com>, Frank Li <frank.li@nxp.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "rongqianfeng@vivo.com"
	<rongqianfeng@vivo.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Thread-Topic: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Thread-Index: AQHcV27Z6cHfdUO/9EORSCr4y25j27T8z+jA
Date: Fri, 21 Nov 2025 08:18:17 +0000
Message-ID:
 <VI2PR04MB11147DF123E2313B91CD8FBC7E8D5A@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
In-Reply-To: <20251117030355.1359081-1-carlos.song@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|AS5PR04MB9876:EE_
x-ms-office365-filtering-correlation-id: 72d7c1c8-a8a6-46db-e1b5-08de28d686b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wPh1WJQe6jIiAndfDFgs1veIgktXKdG/KgLqydPFTCaUEZlCuhWjCW0cfPVG?=
 =?us-ascii?Q?SvmqMS+sCH+Sz5FTldGLwpDU3kk9AiEK3Smezv93s8E2SPFts7h0nzr3CbBt?=
 =?us-ascii?Q?ZaQewYd4RiU1SLhy1LaXKroonp+1V0T98ZmPiZvcX3mtz5Iy6I5EEkyJeQUm?=
 =?us-ascii?Q?pk2zPmhdvrUduVZEPFgBoR4BPR6AByaPB0IoLH8wtiNdxiIbKEMzBK+TYZyA?=
 =?us-ascii?Q?7AF7vipIi/P5ZuNqJZakqzXlVWH6y9dKV/gXqEEOWlA8X7SyEGg7x7LuZuVh?=
 =?us-ascii?Q?CrBQ7XQ6NB3yv4o9W6x+iL/ozJBp38S232NmL6OIMH/LsNyqORZRFf8lUjqq?=
 =?us-ascii?Q?DfLM9jnw0+qmGmJYV2c+2hkkmte4cEMYJ8vKRuT9Mg8KnsxqZs3Ngl3YvtuB?=
 =?us-ascii?Q?0d/ktzNI1eebxNTX192LpBjJx4IyzdYYGfbTaB/k/8k7GAJPdvaYfk6fWVpz?=
 =?us-ascii?Q?S+Mx+2/P7KB2c/3Y4PGeXWsj/v7m1iRHeD/KpWq0DiBUgC5PPmMYb6SiksFf?=
 =?us-ascii?Q?QYdbQ+0LuJ0ZYHRQqLOQC9eP83dnk/CzT63tqy7vIQF9KNPOT89jMRMwn85X?=
 =?us-ascii?Q?cqWQhmwGSVMedsUCVjlYTmZrWCBaC/bRj5gTNhD4bL8JsjERMsmj5Q9lcY5u?=
 =?us-ascii?Q?FS9xcW13nW6NNmSZUgk0JTMCtYacNOsEVcXJ8MNFeAe4dNNWhLAfVDjgeEuR?=
 =?us-ascii?Q?N5ee0krJPTuY3kR/KfQBcqstegcV/9jt48fOShHXIm0O1uaxA6zYreBHMBsL?=
 =?us-ascii?Q?aALJKajnawFrVK0OFOd9DRSEOuqv4cn7t03fLbKhG/a/5LDBpcyGzBx/2nTA?=
 =?us-ascii?Q?sGhejSV7h4je0eNZh7MsLtL6MuRQzsGl1FPNmPvWRdyLJ/3ZaK8u4AoP1pr3?=
 =?us-ascii?Q?QYvYsKaSusSKUqCB/4Kidcux4X5gA7A50bU1P3ZfebQuJLeSgWpTOw6/sTfu?=
 =?us-ascii?Q?wYJJK0vAtn5dD0i/RJCUcwU3HRA6OcZ9ZkmJsakv8x/fhWjnnZwW5RDkL+nU?=
 =?us-ascii?Q?ZxJZ/PrWnBw4gqbkcoKfoIrPUAP6wqgppKFqimHafR5A6/KvFVb51StD195M?=
 =?us-ascii?Q?6IndK+sxaYd/ol/85iW83QgkXEXiZLTHY1cjqRhVAO7fEZIvYJKI5AvQhS0/?=
 =?us-ascii?Q?Tz72woyRsIBRKQr4phLdqyS4vQGT5bUEfcwU+lwcc42pGK7ylf4jRuGofSDH?=
 =?us-ascii?Q?47Q8SggArhsl6Nw93iueI5b5aofKaBX10yXZ/FeVCL2W6xbLqgzYU6mLprFU?=
 =?us-ascii?Q?gbyuTqT9pM69JWj77SCw4A0s7Qrl0FqRI/cdFhVm2Pg4t8nLDvU6B3Orn+l0?=
 =?us-ascii?Q?vjN+++AuiMFZJ0bK/IiYxLDrW/vtOuV5KYvFjFX+qMBZ/11CBy+rIqFR1psO?=
 =?us-ascii?Q?V3DF3Oe1FQGU72/jxFch6cgauwYyGhUxpJjKK2gb9cNuFQt0w4q7VfsFgaFb?=
 =?us-ascii?Q?CBPzgFupO5lR6qWT4GwBD+7+FdVLfRr1Fnc0xhjbBgFtTkuHq60vwQK64quV?=
 =?us-ascii?Q?Ua44LpoUzMuunrAgUcdwc6oonKUQENxAtuVv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t3mF0m1I++4DPxS2LcK2KOBLLwC348zAQxE8KwjeRL/vTnB/QqMEWZxirLJi?=
 =?us-ascii?Q?DJSb1WgEp4IlUVGTyOTyhoafeSog42Z4/s5ItJ9whPZ+qb2Bh6lLEtXjSpDS?=
 =?us-ascii?Q?Tks00jaZM/ukt21hCuUwbDDikH9XdRVhSx8HuJjwUL654IqL+BgjEGz1vUeB?=
 =?us-ascii?Q?5auUMr74l+xYnxsqgIYvlNZFnFeZZgcAsiCVIaTnkk4/6ABG7WBTlR6pgt0w?=
 =?us-ascii?Q?ov1nnppgAHkf2AcKU9jM1yQJJKGhrlx32z1yFx6Nc0ibkFfiH8rrKQHzV1rA?=
 =?us-ascii?Q?940f86M4svmJtS1ScWRQBQXl+LDGBRQt4Z4rYbjlAz3C8Rd9xtCv0++NoncQ?=
 =?us-ascii?Q?jqx55DTm4seq+wVKKxp4qW6jaow9Fs5xstezrfWkq2wl5vSdQdPt+CnSHwhZ?=
 =?us-ascii?Q?ghwlp15OAWpz6hrLIQO0vp6O3QMvM7DVG1zoGVXXoTKN4eLmI0oL74eNvApW?=
 =?us-ascii?Q?LUKf1OLd/QTKOqSBJR3iRM10p7nPBHPt8el1YiuW6RXHDf8RqYywYlcMz6HL?=
 =?us-ascii?Q?kVrZ/4xSgv2WJR2YiftFNeWMHUj/FhjYNzKEkZ5To5Ifrxp0p0c2LqqgM8IW?=
 =?us-ascii?Q?4hEDcThJ848cI8m55G4c2DI/gCXK9yS1OfsXlJrl6jnfcTY5yA4CbhlmNCFH?=
 =?us-ascii?Q?dphQJ3eUecgHN1rQHwtT65R5aABmXux3a/68tVVo1Y1QOFP08DZ/Bs0Mv98D?=
 =?us-ascii?Q?MJ7X0oULouStktneI4uet3ntUsjuqTxuduTm4KD323LVc3IWu1cxBedTan6Z?=
 =?us-ascii?Q?VXPSjcDwhlht0wBbamcfLbksyiR1Tjx2JowYwqFuFQB+EsERPNEjVaOnf87Z?=
 =?us-ascii?Q?q9wSvFy8/boDY0bkkq5oN2EpfmWvw+fPCd3K+rugwlSkhzs56RXTJZ7A9M5a?=
 =?us-ascii?Q?UiLnNKHuQD+7IGob2wrsarQdxreqjEVbdrGf91l39XDQ2nKdXEw914WRvppU?=
 =?us-ascii?Q?VbX9b0CEd6Xf6WksMAy5qOSvVjy5ikQscOqpdYvUZeBfMX4+1kR5WH148nlK?=
 =?us-ascii?Q?jgWvXYnIcncz3/+bOH/Ojlptm1QvaXbO07rCCR2PDNX5EWmXIHD7snjaWsaN?=
 =?us-ascii?Q?KdwpZ2S/llFJ5VRyTHbz8lQInt0R05zvQt8BbRhxhwfRaIv9qyrXl5If2qm1?=
 =?us-ascii?Q?cb7vO6BmbrynxB0shohZS0k16sC/5I/2VcLkGa4q1O34902mwPg7zsWcD88T?=
 =?us-ascii?Q?5B5NQpvXit+AKJHsB2DvrJhnJxtRwwbtc7UD4i5lKVqDnTQuEul/oatj/s+i?=
 =?us-ascii?Q?Gy84X4sLC3aK/fhn957DUvXKuNhFzYFwLeQysNn6G8NM05tqaUfdl3Gf6YeG?=
 =?us-ascii?Q?Jj3W/ecS06BFts1jiH7xhJbVfvqvtN+x2Co1ugjQ+QG4Wmal6Z5apj7/N9dL?=
 =?us-ascii?Q?yJ/jR4/8aApKFn/2SLZNDffgeZMYSFLEnEuqCyOpXgOVFT5hDFzvOa8LFJ1s?=
 =?us-ascii?Q?0kF0tLfY4N1x1lqZAr9pNnAu7gVy4OgGUfWI/iwfV68jEeZDwR6InGT8Rv7Q?=
 =?us-ascii?Q?5YNDR3B0atlnzPsO8Xn0QbC/kpe2u7qRUqZlhN/wEPDhhuk8zdVXdoykxT54?=
 =?us-ascii?Q?yFVyM+1RMsyX+wMRBrr+t5E9fj51lYZB73t10CZd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d7c1c8-a8a6-46db-e1b5-08de28d686b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 08:18:18.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEBhBqRjAuGcdYtrW9zt1rQVdCsgWtxtRfJQPNIfRj2MiWPKCRAZupLbHiax/nYTkD1bypw1WTdd+0cednuruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876


Gently ping to avoid missing...

> -----Original Message-----
> From: carlos.song@nxp.com <carlos.song@nxp.com>
> Sent: Monday, November 17, 2025 11:04 AM
> To: Frank Li <frank.li@nxp.com>; broonie@kernel.org; rongqianfeng@vivo.co=
m
> Cc: linux-spi@vger.kernel.org; imx@lists.linux.dev; linux-kernel@vger.ker=
nel.org
> Subject: [EXT] [PATCH] spi: spi-fsl-lpspi: fix watermark truncation cause=
d by type
> cast
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> From: Carlos Song <carlos.song@nxp.com>
>=20
> 't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are u=
8. Using
> min_t with typeof(watermark) forces both values to be cast to u8, which
> truncates len when it exceeds 255. For example, len =3D 4096 becomes 0 af=
ter
> casting, resulting in an incorrect watermark value.
>=20
> Use a wider type in min_t to avoid truncation and ensure the correct mini=
mum
> value is applied.
>=20
> Fixes: a750050349ea ("spi: spi-fsl-lpspi: use min_t() to improve code")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c in=
dex
> 8da66e101386..065456aba2ae 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -486,7 +486,13 @@ static int fsl_lpspi_setup_transfer(struct spi_contr=
oller
> *controller,
>                 fsl_lpspi->tx =3D fsl_lpspi_buf_tx_u32;
>         }
>=20
> -       fsl_lpspi->watermark =3D min_t(typeof(fsl_lpspi->watermark),
> +       /*
> +        * t->len is 'unsigned' and txfifosize and watermrk is 'u8', forc=
e
> +        * type cast is inevitable. When len > 255, len will be truncated=
 in
> min_t(),
> +        * it caused wrong watermark set. 'unsigned int' is as the design=
ated
> type
> +        * for min_t() to avoid truncation.
> +        */
> +       fsl_lpspi->watermark =3D min_t(unsigned int,
>                                      fsl_lpspi->txfifosize,
>                                      t->len);
>=20
> --
> 2.34.1
>=20


