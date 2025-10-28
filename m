Return-Path: <linux-spi+bounces-10890-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE357C14EDC
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF42C500680
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584CF33345A;
	Tue, 28 Oct 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SLSVJRCj"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010006.outbound.protection.outlook.com [52.101.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78393314DF;
	Tue, 28 Oct 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658754; cv=fail; b=Au4zmH3tRDvCsygvHckWG4++OqjvsQXI0WhLgINWQ8i7xVHoFCboNyv8sgN4lpaE9edROCN0PSmtN2lTYO9Jy/AsA+HPQVFYaFBbCHxAA3C5EDkCYFxq6zpWSRTxc6ppz+b1iMShTbmJMvdxy+CCSZ1j413ZWt9JtLZcbJTWE94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658754; c=relaxed/simple;
	bh=4QD1CwbL2JLynFcD7zm0OK3zfmjjGeJ2Lf66aM893ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHDIBs7shijNV0BY32v+7om45DK20UyXzOtIFFfpa86gO01pqbvSHAvutVRNqKvgGeBggJVHS4xQm9TcS7q61flD/ojNNsuLjJ3eAZdQqxkc4JOj3u60Sg7jRY8TxOoRvfHFHQpUzzNCBUpj5kjhwp/Y+cIoC6XgIxKPrB/szQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SLSVJRCj; arc=fail smtp.client-ip=52.101.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFwXuVYWxB+JOIsvARCtFjuBpTArrVWcn5WGmIoMkPM+Beg5wyPB0USUpSe8xnVLbWy5OoNrlmw4rQokl20awzwcILzD0wC6lIv7GZrjwlRSyitwXQSeyXQwDjr7IZBnRhGhZQLFHelVtHyUHiKaN4pNCtHJBq1pxup8/GYpXAwgNPYBwXozlTnDpHBKoeC0ZkdctLZeQmSptgkHKElnAVvo/XydgcUEn8+j2i8OSagi/GEQ/SvUGZ0vePJnEuS+Xgrnd0zr6GyLtvJ5XJcaAk8MxZeFjW8nTop2ix3bJ7WZkM+xgz+BZxwY3LGcv7KHHd9GMGWbN2H1GyyxbBB8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRsJ6exDJpg6aqWURmt55aHrgLHek3J+lg0Z9OtVfbk=;
 b=MEnbZGFnth7wzlV4OnI1xsP4dui7XID2rrQVM4VdUWTkd4DWD7go4yG1VHOMeYluNPNZQ10uuJxs1M7cljmmUZ1tqgAgSLPaCgC4Q+/CbyP1uggKEI20eEmr9F08WPkOK2A960yd8iCXzHriODgdpQz3h7sa836HJFn61pxVk1NZTS6Epon0xixmQTsUY8aCdX9QLZWMP6iyGkUV3AzUTs65qMesaBViyqvo82KmIyTKeIZOCKLxbtgqyt+7zAbwiPZHCeGmAAcn3RBg+hTluJiA6uGk9/40wcOWV9VVtGVSKxaNIxNZIWWFKvjDZfFSDahR3XHfcXEzdDEYb5mppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRsJ6exDJpg6aqWURmt55aHrgLHek3J+lg0Z9OtVfbk=;
 b=SLSVJRCjD0i9MVDwyjxY4DiNaVDIf7FwAhehR7BgUC+T/L7gknXlntCECBIZdMSl9eVfEgEJRh8Zm1873atWz0G6y2g3a8YbTGPGNIgT5TyfXnKe7pXN+mqmOMgJHVlyNVGAcPFH9YAJYbmLokeaLZiNlfgIwHt9P6dwL+PiwhU=
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 (2603:1096:400:2f6::13) by OS3PR01MB7849.jpnprd01.prod.outlook.com
 (2603:1096:604:178::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 13:39:05 +0000
Received: from TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686]) by TYYPR01MB10512.jpnprd01.prod.outlook.com
 ([fe80::ab64:c8fe:d19e:1686%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 13:39:05 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 01/14] clk: renesas: r9a09g077: add SPI module clocks
Thread-Topic: [PATCH 01/14] clk: renesas: r9a09g077: add SPI module clocks
Thread-Index: AQHcSA9SzOKnWWwIQESHJ14SaFWGk7TXj0TQ
Date: Tue, 28 Oct 2025 13:39:04 +0000
Message-ID:
 <TYYPR01MB10512638B06AB1C3AFE0958B685FDA@TYYPR01MB10512.jpnprd01.prod.outlook.com>
References: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251028133151.1487327-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251028133151.1487327-2-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10512:EE_|OS3PR01MB7849:EE_
x-ms-office365-filtering-correlation-id: 4c6e252a-db6a-4660-8bd8-08de16275ccc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JUJ1P/y0zAMztkYG8H16XjQf09wRhnw82h+dEeq3k0zKA2EUJVH+JFXqhaJ1?=
 =?us-ascii?Q?/dlHF5/omBsLYxxkJJZcH8KMv72jOkmLomqHi5PDXpzA+n04F/zrTuDzxxIW?=
 =?us-ascii?Q?d5vQoWwDw68dM/VJXOaGixjXwujwR7021/5xyZ2M9LD0b2G75at6lxH2xO95?=
 =?us-ascii?Q?Y4sAG5koyBdcPsdTHzZ0eyJekTEFDIr4zWIR/sTmbHvJgZ+3C+0k7ZHd8zP+?=
 =?us-ascii?Q?yGvjCY2SQ6L5ipZl/evtS3e2dQ4hIsgOFYpcp/p5UH/5DdiNz/mNlobIQGZ9?=
 =?us-ascii?Q?4P8y6GvV5fBa2rB4ufqmdbVkvGYtZBSP8m/zt8CmvFp5R1vqaWK5E9Z7YHg3?=
 =?us-ascii?Q?l+ZrOldBwM++HIoF2CsHArGAYpx2Rcx62PEMsyHLblqp/0Gjj4RVKThtBVCx?=
 =?us-ascii?Q?4/TqMnVL1TKnJHzSoWNiYWc1DIxQzaGsV8hTD6cKkLM5sRH34vFrebH9m2sK?=
 =?us-ascii?Q?0QjUaeh31Gl1GHn2tJMRUAighkAwZgh7wZUg2ZkCU5MVbPB8fZe/7kg30Rt4?=
 =?us-ascii?Q?U70NzlstjDa+OWXjMiO9LEweab50F3PFRXSzfNFcl0UOreq/5jfpDRIqEM1M?=
 =?us-ascii?Q?JwXoGd3879RI33Gx/UzpUx+FfUwLBvYdTs6PYbLxOTEhXhil6Q6EdY6vE39x?=
 =?us-ascii?Q?T4s1QVnK2Umb4p3Nb06RJlD7s6msiP135/gvae5yJSYpmux9Hc4zKV4SFv3B?=
 =?us-ascii?Q?2NiM41zYIwKBlbepMamoaErejNa3xA5GACipvh07DAe1k9+wHH57nY4Tzb/T?=
 =?us-ascii?Q?iMqdIN9Zxejj2Vlj/LI4tZH+DcJcdzFFaREqHLrEx9NZsu6+Vt3ei4+O4VGk?=
 =?us-ascii?Q?yF3fUbuRZ8bYE0aoI8BdCYIvshQVCcVupWopOox0bvdi8h0fJtFSrVd54MIh?=
 =?us-ascii?Q?XZem/L1mgIbj5IsZh1aQXE3+DuHqVP3d/uzMeb1EcUMIXczMRs1LEgfLIoeC?=
 =?us-ascii?Q?1xj/yahSivgc8YLzFGCavIChWEeBl6sSvV4Y8TW8nFRfXnv4zI+cK+8oxsIm?=
 =?us-ascii?Q?SuQ1MwPoIp67LTooFRcaf8L0sr4brfrM2WZhsJyxqZ5d/N/w4Q1UnawLhxVG?=
 =?us-ascii?Q?ICn84K5zOAeKv3dHQRw8wtsUNpua6tA0zktPa+abIIJkSnxIDOU1QIgTnVxI?=
 =?us-ascii?Q?FsVNPCjBVtV+tLztDw8TnOhYd/RkD22Cbdmx8QeO/qiLxC0VpCAC4eAqd+wT?=
 =?us-ascii?Q?n3vM7ZlZFh5uz1Y2XZ0Duc1nBYEsgpeUbGJT2pQS7tL3UNWv35nozxz16aY/?=
 =?us-ascii?Q?cONQ9EviqF/SyQvb9UUzggTJ74fsOBM4vWgSK021PDjef0iJz8jW6ITsUWo8?=
 =?us-ascii?Q?wMOp+tZEGsBRGnKufk0cQEUx/25ur4vazEzqyZ5sHVuEDJVE9RA/9LM+Nb2f?=
 =?us-ascii?Q?uR0p6jDMa7iA3sXWOHurbj3wmbpjXhEKuampIdJdQsig/powyEAhelk9iu/C?=
 =?us-ascii?Q?meQERklLrSAcR0mx6TjY8VlICpR8NQwphhwXvq859nnzCf2BIXIC0vCjaQwm?=
 =?us-ascii?Q?F4zdNS41lKKclNR/L5v9qDMexgFLAuhoqXdb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10512.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U9CgDANIYBYdY4Oq9aFtGCbO8lVh6y/SZMJyLcP0SYzwmPsDr5zBIk8IPaUs?=
 =?us-ascii?Q?yyhnOJn6Kyu+ywdH2N1VTM+xNUdy+eSXBpLQLBIk3m633JZYx0ye+vPBIt4e?=
 =?us-ascii?Q?dObNYPxJ3JUs0uQGyHpPv7BsoZjUB4Ptay2RlXnlFHopl0KuPyzqWsZNDflS?=
 =?us-ascii?Q?2u6jq5TC1v6jf8+D8XRSoyZxPPzPb2MZ6rZjsoFqRD6lizsYzZfeFa8L6ouA?=
 =?us-ascii?Q?Vd3xRwFX7ng6fh0zFm0dU7iIogo80YOU3iHRqD/QfQCYFdpKo+lrJh5Z6U5C?=
 =?us-ascii?Q?UWRgpDkfe66/ZceccpWbIz8pTmCfoPJNX2WbbI18DKwfTI8dgPW6Hpvxf6E/?=
 =?us-ascii?Q?6l0DOny2pHTFN89cTq2W/CXBK+IG4qVBJn3SCFQqpdEvQY5cC7eUJKJM0v7f?=
 =?us-ascii?Q?9sRA68LZd2W5m1rBkrTxjqVhq/Wqn0lrXDBLEPn7j2cPhIh4cDI4lI4igfEF?=
 =?us-ascii?Q?of3FrWKL6gxgz18HbbYRx599PSbtF6GdNC9/MahmlbSfBN6S4/G6WdtJYiZp?=
 =?us-ascii?Q?1gGAR299eTJ+Ho4iMyBllmxH20wZQBvDF8l9KUcn6NylIFp4sbG7Ofi9Zd9o?=
 =?us-ascii?Q?A5it7zpJAPb9UQ3CsFxT2JOXgC2B3FIimU7+P8s//HcfiNxZflOKtrMoTvOx?=
 =?us-ascii?Q?hBBbFLc0UacUunFy1ljatAdvsOLWx9SKKomaffr0rfS1frFBzwnIk78418zu?=
 =?us-ascii?Q?HqLvvDBu1s2gXHBjswDpip6QrKjpJt3FYxfuzN8ODmEiWt2sZWlKa8D53OA4?=
 =?us-ascii?Q?V6/zufXZFnWlnUGj3hQ/9QGb3NWimFRf2XPr8eOUO9FUP+1ntIFp496hmnhx?=
 =?us-ascii?Q?MbOBEzk831/iPDLfHqaAdWtzyDWL1AU2q49xJ55soNUL2OEo8havNFbUzMTT?=
 =?us-ascii?Q?tFGWotIN1/c01Bkb1R2zFqOpfsQHsy2BJ8FquDbN2rnVVjZqijSb3SHJ1jC3?=
 =?us-ascii?Q?KIgQmujRGQ8Q7ZB5NtUNx2bCROslX0gYlQ4PT1fz9tohAeLciaLzThFCnq53?=
 =?us-ascii?Q?qG8cq9qYKdmP9owk2ChPU/y+hufxRKLoUp99RVbGFjrNezN6LJJ0h7aP5QRN?=
 =?us-ascii?Q?Oaw57CmUpV+WjxZ+kgZoAUMPvupSALNauUZsbuJfv+5PhWlsPKQFmlZqYeE9?=
 =?us-ascii?Q?gyTxCxUugX2WWxU4MhNJW0TjhSGt5fFh3OA3tRJX1D+/G7Ke9tu7LZm8q8Cg?=
 =?us-ascii?Q?K3gQnx+djDNfB2mF1Sr5R7yoZoU2khVu2fTR9dMzj3zFQl9riqYr0hZqZC87?=
 =?us-ascii?Q?FMRnmTANJp8uLmPos+FbR6GH+LpNgo7yB/LKE6hKWgHL7DI2cSMQ56BmiV2n?=
 =?us-ascii?Q?aBFVvClxkR6l/uVBaoJK/h27vN9of/Su0IroR2vxRQgcGk15LuxWPfYyvgUD?=
 =?us-ascii?Q?KcDj3e1WTEPv/J/zjEWwyTRINkWBqIbWaE/qnZAMyNmu/ksm1cyBwfdBFtdz?=
 =?us-ascii?Q?Ibae7iWhBdHN63L/JFiDGf8RX6xgveMCeCmCFleznXOijiQoYjhGbFf9GJy2?=
 =?us-ascii?Q?iW+W7xJdWj2qRgpPpic7WmdvT3vHoCrO5Urogx8E5jnOKei76tuSrYwej8Bb?=
 =?us-ascii?Q?/KA6vx5rZvdne2dryn+Sil7awHs6gs0mZAhiqxQuHrQNNZCKJzQsK6S4bEY7?=
 =?us-ascii?Q?AdxT2k3rEk/GPSmu7XxGUY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10512.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6e252a-db6a-4660-8bd8-08de16275ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 13:39:04.9441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rvo6eOesBzQ3Wu19oBPP9DJXWgow5tLvRRrdPjfkvoi7U9pa9JP+2fvgsoqD0G7aj89XN0Khb9hGV4m9y4sQb05LYkSEml2NnSB5tgqrZ+8sGlfcEhMycAsOspGF5xWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7849



> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Tuesday, October 28, 2025 3:32 PM
> Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Mark Brown <broonie=
@kernel.org>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley=
 <conor+dt@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.co=
m>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Philipp Zabel=
 <p.zabel@pengutronix.de>;
> linux-spi@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicetree@=
vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org; Cosmin-Gabriel Tanisla=
v <cosmin-
> gabriel.tanislav.xa@renesas.com>
> Subject: [PATCH 01/14] clk: renesas: r9a09g077: add SPI module clocks
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals, each with their own clock divider, which divides PLL4 by
> either 24, 25, 30 or 32, similar to the SCI peripheral.
>=20
> The dividers feed into the usual module clocks.
>=20
> Add them all.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

My bad, these were left over from our internal review. I'll remove them
in the next version.

> ---
>  drivers/clk/renesas/r9a09g077-cpg.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9=
a09g077-cpg.c
> index 79083165537c..0f61e0f09697 100644
> --- a/drivers/clk/renesas/r9a09g077-cpg.c
> +++ b/drivers/clk/renesas/r9a09g077-cpg.c
> @@ -54,6 +54,11 @@
>  #define DIVSCI3ASYNC	CONF_PACK(SCKCR3, 12, 2)
>  #define DIVSCI4ASYNC	CONF_PACK(SCKCR3, 14, 2)
>=20
> +#define DIVSPI0ASYNC	CONF_PACK(SCKCR3, 0, 2)
> +#define DIVSPI1ASYNC	CONF_PACK(SCKCR3, 2, 2)
> +#define DIVSPI2ASYNC	CONF_PACK(SCKCR3, 4, 2)
> +#define DIVSPI3ASYNC	CONF_PACK(SCKCR2, 16, 2)
> +
>  #define SEL_PLL		CONF_PACK(SCKCR, 22, 1)
>=20
>=20
> @@ -94,6 +99,10 @@ enum clk_ids {
>  	CLK_SCI3ASYNC,
>  	CLK_SCI4ASYNC,
>  	CLK_SCI5ASYNC,
> +	CLK_SPI0ASYNC,
> +	CLK_SPI1ASYNC,
> +	CLK_SPI2ASYNC,
> +	CLK_SPI3ASYNC,
>=20
>  	/* Module Clocks */
>  	MOD_CLK_BASE,
> @@ -154,6 +163,15 @@ static const struct cpg_core_clk r9a09g077_core_clks=
[] __initconst =3D {
>  	DEF_DIV(".sci5async", CLK_SCI5ASYNC, CLK_PLL4D1, DIVSCI5ASYNC,
>  		dtable_24_25_30_32),
>=20
> +	DEF_DIV(".spi0async", CLK_SPI0ASYNC, CLK_PLL4D1, DIVSPI0ASYNC,
> +		dtable_24_25_30_32),
> +	DEF_DIV(".spi1async", CLK_SPI1ASYNC, CLK_PLL4D1, DIVSPI1ASYNC,
> +		dtable_24_25_30_32),
> +	DEF_DIV(".spi2async", CLK_SPI2ASYNC, CLK_PLL4D1, DIVSPI2ASYNC,
> +		dtable_24_25_30_32),
> +	DEF_DIV(".spi3async", CLK_SPI3ASYNC, CLK_PLL4D1, DIVSPI3ASYNC,
> +		dtable_24_25_30_32),
> +
>  	/* Core output clk */
>  	DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA55C0,
>  		dtable_1_2),
> @@ -192,6 +210,9 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[]=
 __initconst =3D {
>  	DEF_MOD("sci4fck", 12, CLK_SCI4ASYNC),
>  	DEF_MOD("iic0", 100, R9A09G077_CLK_PCLKL),
>  	DEF_MOD("iic1", 101, R9A09G077_CLK_PCLKL),
> +	DEF_MOD("spi0", 104, CLK_SPI0ASYNC),
> +	DEF_MOD("spi1", 105, CLK_SPI1ASYNC),
> +	DEF_MOD("spi2", 106, CLK_SPI2ASYNC),
>  	DEF_MOD("adc0", 206, R9A09G077_CLK_PCLKH),
>  	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
>  	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
> @@ -204,6 +225,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[]=
 __initconst =3D {
>  	DEF_MOD("gmac2", 417, R9A09G077_CLK_PCLKAM),
>  	DEF_MOD("sci5fck", 600, CLK_SCI5ASYNC),
>  	DEF_MOD("iic2", 601, R9A09G077_CLK_PCLKL),
> +	DEF_MOD("spi3", 602, CLK_SPI3ASYNC),
>  	DEF_MOD("sdhi0", 1212, R9A09G077_CLK_PCLKAM),
>  	DEF_MOD("sdhi1", 1213, R9A09G077_CLK_PCLKAM),
>  };
> --
> 2.51.1


