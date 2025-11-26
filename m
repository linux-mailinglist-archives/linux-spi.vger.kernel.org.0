Return-Path: <linux-spi+bounces-11554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DCC87C94
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E35754E17D5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA463090F5;
	Wed, 26 Nov 2025 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ivSxHxDy"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C63305E2F;
	Wed, 26 Nov 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123031; cv=fail; b=WExEjFqo57w04sGIrC6DzY/cIexZP1NugPAuaOMe+tWyiHNq7tIpgh37d76DnlARQRsLpBdF44nspNLreODefFc00wWala/8fn986AnCRdQCtN5tLy/7HKIwvMPyuQACdw9fOZkAE58aIQyf5u8xIYeXMGYyT5nGeZoP7xYJWKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123031; c=relaxed/simple;
	bh=P9gygu6UUuFuNq6MgG2zyM4q8QfURqLEt25PqBBf5Lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWz7WptKLx693phfmzdIoR5Skt9OgcrrNGxjK9scMH880dPgDcwTXbbUS0N7sU3OLpol4vyZvpT6sCI0ckhd6ErOKDeq7beEqyiY3Ckuawz5DclS4UIi9v0cp/OxGng0FjwGt8oamlAJQp3d9LUtWDSK++uEJs/9ROGqgd6pqv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ivSxHxDy; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htRp7zZ3qxHaI8tejq0og8qxuLxKn000bEkgzyNF4ClqsqnwJxClJP+CfP4MdHpdI0wpiYxre5q5mdnnqd25+1r5nyfyBxtxO5yoHzGvffc8w/Qggjbi9EZEVvYXYE7+Q76STrfWrQZATs679Mr3OC3mD7lhshqA18q1suLXmSX2fomkTLqHcpkr1c6CKftEipkMPwySsul7bxvBYx5nTbb5H0gr1cqO0jY/QgRRO28sR7BMP6nLfZKSdhZy76YE6v/NgFHUo+vgrq6RxziFKSfFUPSTjBgsPPU/bt/9NvnudR74+kTPdIDWP26w71QDRZAgKzZHBWMsVvKF3qXwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2luBa9G4pYxMNK0If21uNwTbmAa0cHlujUaYW0MLKE=;
 b=JZfTYRWeXayf8pOHw9BHxplUE1bDXN95ndio1HkoyZF+b3++3t7XVMFKZSmPoJ0C8Z8pIsKanGtdaMUgxu5xDBaNQn7ixb3O+XCuji0js4NZidTbFPSrvWL6EBJD7TqS75Zv8y0bdwLxx9H/wGAs4wFfwjOyLOECoWVjTEaC++OaJ+3n/9/wxMaP3FQ5ek66o6YHJpjFnUsbw1W3xuce3eF8BHvz22eWou7gSOTAzi8/SZYRmxgaIzIFLCuOZFz9AgD9OR/yS4DFS3EVbivVnVGMcDKMmE8CdwBxbmbzq7KJGRaWzqqqFgXG4of4ElpKXnKbtzCHF+xClQyR+648cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2luBa9G4pYxMNK0If21uNwTbmAa0cHlujUaYW0MLKE=;
 b=ivSxHxDyus0Sg020TTvTS+Ydv/h2RUsgif+AqjYxheRfU2hav9YgxeRPpjKNxP3RnyLsuhrQVLqJIa8jHKC0kSYVJvexkvXWJ1SUIvwp8Nr6i2+Tua33PnPDyBDPEJtGitk1LUY7gn4J2o27erw1YrKtAr8kE0YmNv51lWjhTuac4s4DvVwbDayocGRSP6cdrvQh+pFDii1H/U4s8SAJqKEyQ01g10V/2dawoh8pdMvNjK0cMQJ+ps1GmkSu7c9uqH8mwwDN9xzEXrwb+oXOu4T550nSrQk1gb/DMszI3/V2iR5DiB5uPgXsARfVpKdzyw9yGuANy/8xfhX9GhkRiw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB10620.eurprd04.prod.outlook.com
 (2603:10a6:800:26f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 02:10:26 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 02:10:26 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, david laight
	<david.laight@runbox.com>, Frank Li <frank.li@nxp.com>
CC: "broonie@kernel.org" <broonie@kernel.org>, "rongqianfeng@vivo.com"
	<rongqianfeng@vivo.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Thread-Topic: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Thread-Index: AQHcXnnUFTDSylRETkOQZpVQi7N1Rg==
Date: Wed, 26 Nov 2025 02:10:25 +0000
Message-ID:
 <VI2PR04MB111477CFB4C4253842C234FF9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
 <aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
 <20251122105716.24769251@pumpkin> <aSXHB_CWYZYnQ6ui@black.igk.intel.com>
In-Reply-To: <aSXHB_CWYZYnQ6ui@black.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|VI2PR04MB10620:EE_
x-ms-office365-filtering-correlation-id: 6c287291-131e-44b7-ad6c-08de2c90f6bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j2UwQAK9VRWF61j9DUFgN+6W7WAzm2+YjlwsI5UotX4E89sZQBWEllGYd91N?=
 =?us-ascii?Q?X1r24nsY/9vkAjzoZa48S62FTJ5bB4VyIZMrTPtUnrOSHBx3M/ABZubkfPpx?=
 =?us-ascii?Q?ye6Fs+j5RySjuFJWliwT6pNALJzTbhok03TsbqbIQEmYDQdDgM3S+0RspiYQ?=
 =?us-ascii?Q?iw9fGK3aSqQUyg4Zhn9SeG1C5lXSHpdrCaThRWWKiAcgIcpFqChb9HzKyAvq?=
 =?us-ascii?Q?Qht/t7Rxv9JyovSA9kc8jcnGoejAdLUDaF+ztGt9bHZoGCr/ujBZwwCM0L48?=
 =?us-ascii?Q?ZU8bzQrIQQrbJhluyCyOJ6x+rWQCytbcdFHlBxWslm8VsgHrYYhpv8XE0qKY?=
 =?us-ascii?Q?BfNjdhwzmQuE2q1BMdl9POnoG9qz+kgH05VNY63i9WxC4Q21KsF5Tn1qTAqG?=
 =?us-ascii?Q?QkWfX0Wqg0qKCh2ZXvsRTFc1Ikximtxfv0YUNLN60BpuIicSXDxk6QIXEQxy?=
 =?us-ascii?Q?WWUGwdxlfAoHOaooqnCpWosYoOOZVptkTxWyqmarQZwn9rbJmnPrqAoEaKJI?=
 =?us-ascii?Q?M6cZrFv65007vkF4CUUuliy7w/yeJJRBkFK2uZL4age63HN+Oz7ugcc5bvPk?=
 =?us-ascii?Q?KzC2VYfyGHEuAWUe5sOp9ONBImLo2kb9/qkP0ZfYwg6228LdKSx78lEt+dS5?=
 =?us-ascii?Q?wqEtcdaVcMol3ikk4soFtiNjSXqodvdEqk4p03Ljk1NFzEFCO6bCtOKdibjb?=
 =?us-ascii?Q?CrIJVPqksLilczxOAR1alIyHeMifVfoHS5czgi3oetIfnj0dZoeA+QF4/VUP?=
 =?us-ascii?Q?AZjqApVTSmpdhk5uOWWG/5RPtMBEckE1aH9klSd1uYpRDTiY46OEzzR8DhGf?=
 =?us-ascii?Q?aHUjj2FRAYS5GIjILUp4uosLtBgSDJlQ/rp4FBi7azCzCgVfprCSG5yJjJ6r?=
 =?us-ascii?Q?hbkgJTnpGDlFNec3BseR9Mu/DdUKmx3p93KBq7o9lKYO1N9thkzlPOEEEwI6?=
 =?us-ascii?Q?I2SSloHMpW9Zh6+rTEqSTu+EXNs3JckqgfeEcVWiG21zYNfIgdLSf+Ifei2i?=
 =?us-ascii?Q?ZpeBV7PAVBF8zNeaNOfupuivQi8F3Uy3PzU+m0Ho/b4tImB+HMshY9w5Jf3I?=
 =?us-ascii?Q?j/BgC8elt4dDb5TDjzATnhcrn6yiqi1gKxeL5MwoHJl5cQinq5sOBvyiOWko?=
 =?us-ascii?Q?EHR/SrqGaxgDAnTn+ExKdREFFjMCdnUpPVe5py+GlEHQyMrvOZpwa6TFpzPY?=
 =?us-ascii?Q?DJ26nSnBWEOdjstadQ0VJ9tCv07cDsAqTcD6eYD9atTyimqALxIaNdXzT5bG?=
 =?us-ascii?Q?4x1HoTzuMp2AVobTouooBCdmYcY+nJpbfvP/eN+ieA0rKks49d4Ps/OsafRH?=
 =?us-ascii?Q?3u513B+rN+aA4KauhPKP1n1dFFCIta4qiQib+34KkjzhZhw+s6hPaUBlgLNf?=
 =?us-ascii?Q?jNi2TtUPCGkV8N1HMHL/of1PD0hNnTIxqM4WgEjW49NyF9ck0/MBvCPtcVKP?=
 =?us-ascii?Q?WD29eIoSUFBsC0uhJl3EfFj2R/GFyhafIOAbs6PIlo7+hBhkkAWeqXcrwQVR?=
 =?us-ascii?Q?14jPuAd7+y4EJ6Fpzi5LdG9E67+1suGvO5yl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oMvk3c+iToxHmH+i77ZcrtDhy9Hd+kEDscjOxhowKfIOv6sTg7ORY0aOz69K?=
 =?us-ascii?Q?h/wvEJhhaYVvAW9DUh7XMrho2UVzZKSX7ds/TdwnCh49g1lHwyKrPmeO065M?=
 =?us-ascii?Q?yRkYTDiMm5rhGlnPj6gKiSE53fgDdW6ZHEOSNuQqDWBxyizIT0cVYNMu3IuX?=
 =?us-ascii?Q?EyJ7wOpzN6nqMYxH38BePBxqHppSO18PtpQzJCqCsUEvl4tTOI714wXUzVwB?=
 =?us-ascii?Q?4xlqPxzODsPpbvx1j/Sb5wK8DEE+0u/jQ3Nk2fKc6htR93xXckcC+bzwit1K?=
 =?us-ascii?Q?FnSN4+j3Bwgm4bJ/4n7tY63Euzv/sxcxlTdQEDALS+Ye5sapD6JivhBSL5Qw?=
 =?us-ascii?Q?+WAYvjm3ozaHSFxhFUrTtNneL7lv8g6nmGU0xcCKovh7AesNRVXPNdQ3rbFK?=
 =?us-ascii?Q?SYxJMrsyfKXnhrvVIs4k82C4gTbD8QMzSt/gqM99Y39ZndwwoaXQMJ0MS4vv?=
 =?us-ascii?Q?VD1kQbVW4m07Bs7Tqsfk7zmR5CUZQpJVkIX0vPYqKd/dZsL+2KDQBM27/vcL?=
 =?us-ascii?Q?E3+YQNq4ACRDCfysHM0D9tXyRI2C1gJ2XfEyhEO++bT4a+IRmgxmzdFGFtbu?=
 =?us-ascii?Q?0uw4AsaSl3ieJ12CZOK5lbq7LkA/9+F+ZSKyPse0jgrSOcCtxXzXwU/8Gny0?=
 =?us-ascii?Q?i5J59/vtsNWwCnU+ABhdg+e8w0KAL5QkHMpXxwxbWijSh7vNU5nuoKyqDlu9?=
 =?us-ascii?Q?TnwFrZW5w3+ExoHJ06NHSlqnDcDr3aYNgq1ECk27TIha1JZfFtAJXwEuXwt7?=
 =?us-ascii?Q?p9CzJU1m+q9LBH34Jh5QwafBt6nMlbdNR3sYtU7oPQVt0iFlqgieSfp8qKEi?=
 =?us-ascii?Q?ZltrdLhdO9ZGR7iLrwf9omy8O+PbOcBTBTJ8cJTeGjFmuT/hwIYiRcMyQvJe?=
 =?us-ascii?Q?+xrxttFQWowFM8T4XaQSqhsB3SDQgJkS4gZJjy5MAZorx+GvxFA/Qg2HKt1U?=
 =?us-ascii?Q?Gn2xPr2VLPYy9xDZh3yv8H86ybQXYhDArLHMXtMd2ezaOJTVp1RNbed/xbst?=
 =?us-ascii?Q?+6oPz0rFRcqm9/jVJqGTtektKfyPog5N9lSCmT4aD0apycSdzzl/AthucBtc?=
 =?us-ascii?Q?2ccfcWJnVflxq0G+k+QxV2mgPWoNXpRlJ4YJWjMZZAtBJilbzGc4+JbuWLLh?=
 =?us-ascii?Q?nNVwecbHcVVsbI8nvk4nWWHV72aarEpmExNjjiPB3gL3y/i4HjA29/8OkovH?=
 =?us-ascii?Q?KkHmNmbUE4C8cgP82+RNoafnRpCPLuFJcj9F301iIqINVawTYtO2cMRpJAwl?=
 =?us-ascii?Q?NPIKqXXrrnA4m3zPFdB+gHGypxUNW8Pe9W5yHpvQCtZOi03XqWchC2SkHaMh?=
 =?us-ascii?Q?vgpORv+CYLlCKXwjJuGSxZVCA1f3Iy7MXquUaM2l2qEodmrlHX+M/FDB5LKb?=
 =?us-ascii?Q?id6QOuNP09ECIQrKhLRo5KLLnMAQFNex2ovK43C6aUI6rT5faQ9mlVclZlnt?=
 =?us-ascii?Q?3sLJ4DGWOcgAbqXOQPyO0+9iKn5yoKY6zKDkNqbEOd6oRluyRct7R37Tx7G+?=
 =?us-ascii?Q?q3pKwltV33VVXAu2R9fUsiDwtD/y/Jb8e+rdiVIXGVB8Jaj56VrYbF56smeQ?=
 =?us-ascii?Q?hWYojT5cCtXvp0xN8x4Pw6rxaTef16UcdIWn0xR8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c287291-131e-44b7-ad6c-08de2c90f6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 02:10:25.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODINvGDhrPRPr40OFKvwiIfZ6S5A52oKIZ/rfahCP81Wx4mDJRNAHZJY1D5JbX3tYRmTSxJP5JL5YtaMewsOaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10620



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, November 25, 2025 11:11 PM
> To: david laight <david.laight@runbox.com>
> Cc: Frank Li <frank.li@nxp.com>; Carlos Song <carlos.song@nxp.com>;
> broonie@kernel.org; rongqianfeng@vivo.com; linux-spi@vger.kernel.org;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation c=
aused by
> type cast
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Sat, Nov 22, 2025 at 10:57:16AM +0000, david laight wrote:
> > On Fri, 21 Nov 2025 11:19:34 -0500
> > Frank Li <Frank.li@nxp.com> wrote:
> > > On Mon, Nov 17, 2025 at 11:03:55AM +0800, carlos.song@nxp.com wrote:
>=20
> ...
>=20
> > > > + /*
> > > > +  * t->len is 'unsigned' and txfifosize and watermrk is 'u8',
> > > > + force
> > > > +  * type cast is inevitable. When len > 255, len will be
> > > > + truncated in min_t(),
> > > > +  * it caused wrong watermark set. 'unsigned int' is as the
> > > > + designated type
> > > > +  * for min_t() to avoid truncation.
> > > > +  */
> > > > + fsl_lpspi->watermark =3D min_t(unsigned int,
> > > >                                fsl_lpspi->txfifosize,
> > > >                                t->len);
> > >
> > > There are thread discussion about min() and min_t()
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
o
> > > re.kernel.org%2Fall%2F20251119224140.8616-1-david.laight.linux%40gma
> > >
> il.com%2F&data=3D05%7C02%7Ccarlos.song%40nxp.com%7C24c955c5ab414a26
> 730
> > >
> a08de2c34dda3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6389
> 96802
> > >
> 735067934%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO
> iIwLj
> > >
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C
> > > %7C&sdata=3DNEBirtRBR5RXz9cUXuqWVtHT6b3memVhsRe5mA7AIAQ%3D&
> reserved=3D0
> >
> > The big comment even carefully explains that the two types are unsigned
> ones.
> > So a simple min() is absolutely fine (and the comment can go away).
> >
> > The old typecheck in min was just so stupid.
> > In this case the 'u8' variable is promoted to 'int' (they always are)
> > and then converted to 'unsigned int' to match the other type.
> > Even though there is an implicit 'int' =3D> 'unsigned int' cast it is
> > impossible for a negative value to become a large positive on (which
> > is the only justification for the type check).
> >
> > I'd check the file for other uses on min_t() as well.
>=20
> Just came to this thread to echoing what David said. +1 to the above, ple=
ase
> convert to simple min(). The use cases for min_t() and max_t() should be =
rare
> really.
>=20

Hi,

Thank you for all ack about this patch.
From my points, min() ot min_t(unsigned, x, x) both are ok.
This patch has been picked, do I need to do a new patch to use min() instea=
d this patch?

Carlos
> --
> With Best Regards,
> Andy Shevchenko
>=20


