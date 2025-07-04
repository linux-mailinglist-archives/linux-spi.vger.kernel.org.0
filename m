Return-Path: <linux-spi+bounces-9049-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72C2AF9531
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3843B1CC0C0A
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41071A3A8A;
	Fri,  4 Jul 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mtVV5Gsd"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011057.outbound.protection.outlook.com [52.101.125.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97A1E4AE;
	Fri,  4 Jul 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638455; cv=fail; b=PGFzAz6SgG+nT9DohWC512Vx1fpweZLz31GXOPmb2k42BteWUcGIcrPlJ28YJFmNmgW8TZXK2fI7dNCK8aWpnWK8sk94HEqDOy2jDdpwasCP/iJlqz09dhOkQGfMm2oZjwPAa8sl7vOSrkuxhk3ZWADwf9oapmoUbLR8jmmkYiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638455; c=relaxed/simple;
	bh=pmxDwCcjweJ4gHV87I+luZQx+w9TBA09mOEesckNN9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sfNhfkzMOGUcBMEg84xkasXyo5hPlxG+9KU3nkkURgIdHfpqRRWk72wh7PinssNoqOa89Xh8pQIijr398Pn+/bAl+0NtnCttKmwWWfvMdcckCvuoYiQHrpdkR4pra58s03U9cZgPhbibdsHyOxgRd09jJHdhbbuotBCyyn8cWRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mtVV5Gsd; arc=fail smtp.client-ip=52.101.125.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZcSdXl8sgvin5NbSoVh3PDy9dvc4Z5Xpbij2KYb99j2e5+V4Defl9IG4qvV9nc1Qo0Vl+GfyR2NPrQzl/bXA0SHd+6Lcr8ijltY8oNJJRQ+LcZF493FKWTTvICcZtk8ENKmsIShunIggEWi/1Das7Qcz1yQxi/y1Bbz08SC33r+HqawOAx9a7avuonXluiPMIMdbVM1l3lTrW0foBUey29nTz5ELEEq8ypnxbwI9e+QZUKD9aKY7l1+8h6cu/ou0u/2xxls+Vr97Q/EgzDQaQpQ5jrXmGIW0uJgcYfr+9pbuIF8Qqe9SkVazHkeGeM4L9rjuj3LBHms1u3XL4sF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ6UKdMYxgqB5ULZqfp7TKBd5bhoTlt53zZgB7cugt4=;
 b=YY7i1rObB7Dl0Oa++7Rzs5EgfDD8ERByhq8EVruM4I/To7cTGWJTrbxRJKdBBJ353ahZKf0XKE1QjAMuu2eUvqPO5qEUVUjAacYQUXBr2OvvCgUnpJ4OjWWW18U7WmN9ZqdwYKKCoy/tP61g1+KFnvwlnY8trd4JvaPvvB4m+5O+8BJg5PQ662SeE7noj9qQk0UoKtywthykG56CSlCuCcFFRxso2dpk9YFRrn6+iZj+EGlG1RlJkAO6KyCld7f73Qkl6xjumZwzHXeZ2RZer0twrcK78o7c7ejUvOkkFlwIvxi8E7uchFacGD4TEBTxsR5+pS4jd/dM2bl9+b6XFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ6UKdMYxgqB5ULZqfp7TKBd5bhoTlt53zZgB7cugt4=;
 b=mtVV5Gsd2QdqLuBuOcp8v9pImpeSOV40P4J2G3qYBmp1YefzqM/PfAj/NDAwXvvLay9S888mB6fJ134SCQhQc8oDYCHam0bC3ztiTA0drfOFG+/3lfw8oNaYbsUByl8Hou4cYXCgmapFXnBU1jW1mwRwjJNoEqK/dOKlT6Uh8eY=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OSCPR01MB13298.jpnprd01.prod.outlook.com (2603:1096:604:350::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:14:09 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 14:14:09 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Thread-Topic: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
Thread-Index: AQHb5T14qAnsKZMNTUuJ9m/tpR5+9rQTqtsAgA5loaA=
Date: Fri, 4 Jul 2025 14:14:09 +0000
Message-ID:
 <TYCPR01MB120936F918EA67B7850743F40C242A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
 <20250624192304.338979-4-fabrizio.castro.jz@renesas.com>
 <TY3PR01MB11346270DF3A4B90C5A73B450867BA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346270DF3A4B90C5A73B450867BA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OSCPR01MB13298:EE_
x-ms-office365-filtering-correlation-id: 53960230-128d-41db-8a3b-08ddbb050b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NZavWOLFx3gTUAmdN7tVeLEgXNECMLlkamxgRoS7/RIbIHOqwUjhy4pJJvv1?=
 =?us-ascii?Q?aYhEpSx+Mmhd3W0du4MajUSJ/BxLnWihg2xfuLBS5YrMlAyZeL8II3DiaLV9?=
 =?us-ascii?Q?yOnVAWmOTpC4hCgJDAp/Lx1wCUAR7XQaEcgiLZYVgTf0XgLVAORzx/nihuoJ?=
 =?us-ascii?Q?xMzA0kL/1TPNUjaFHoLytjd0lawE4flgau0MbCzUsxLnX1o91yxwLAC77nBQ?=
 =?us-ascii?Q?ZX8m3WoDEIex7Sz3nTQeT07j+OZo0tGkLIYoBu9Hq72A71IMIXIPVadPQYjh?=
 =?us-ascii?Q?gapJlfcDtw2nhQNYEgenKQ3v6L3trhnHdLVGdYWbpWUQMW0wwbRxm09JDqJ8?=
 =?us-ascii?Q?l92UimIZ+AMcu1CrNAmtXi97el0TvSjopl0vyo2SlBhWDx/sPnF+/jzxBiGx?=
 =?us-ascii?Q?WC5xYjJAk8bu1LSCmPCkWig+sjn1xYSlMKCD2TDpDa2X+gjS9qma8SelMc8z?=
 =?us-ascii?Q?bU3THyV70jAiTWyH0sDD41u7QlY5Otufs3zeYVNPd0P0oAzct1/wiZqYXb1T?=
 =?us-ascii?Q?+PCC3UDajWn+yefYRADAi9pXK7efmjS+xPTLZUGK0CNeRpM5d1+5GdpxAde6?=
 =?us-ascii?Q?i+0pW8uk/TfnUteJYyGUhCHVRG9Oz1aj/vDYeZ+MZv3TbltSVqj6+exJThwe?=
 =?us-ascii?Q?RQIhsnYrbvOpNsqDh6IIW8hyQD6y0jCFZ0FCryC/M2ca+mX8TlWHvEvvpbOE?=
 =?us-ascii?Q?4+90dqJsVof0220co2mmbPsIcdo1XPa2ducO02FTtmVHwHQvNTwFHLwPwflZ?=
 =?us-ascii?Q?7P/LkpJ5ydNju2mYHMsS+t2tgh7npO+Bgf7yRHVc92a3WxudEeGExlt/kKeG?=
 =?us-ascii?Q?eJBNFCva+KJqhgvlc/M68QmHnN6HRtP4cjbf8VPX/pKmL/JviZoa/QxRhfJa?=
 =?us-ascii?Q?n4wdSaq6XcdJWpDbEag6D1c3y+aB5weush2mFrmtTxXVe0ikL1bnNaXPiogW?=
 =?us-ascii?Q?YOD8cgwlNLV25wNyaVOr9wpANtVchaV2kRzP8u6r01D+PXaH1Qgwyw5gvdtB?=
 =?us-ascii?Q?pJzUMr8gM6t/tEvqqEVDcqAU9vur2Cp57uuORdXXFeCSQNvhg/mF7PTlQ1Vo?=
 =?us-ascii?Q?IhSUI4VA86QYfxccXVVcuKQj1WQLReKdnt2x6hNL+o+NNxosfmt8eNNxuW6D?=
 =?us-ascii?Q?a++JCxW7FS82SOdT0iGY9SzlDyVIkzW9hu9ErIUPEVnlhiT4ccc4PjywMvsq?=
 =?us-ascii?Q?SltH8J/ixyDdr0TsqV47FYb9jUSQ/eedfEvAeoewoGBM20WlB3MIgcQfXXRK?=
 =?us-ascii?Q?OT7KHXVg+HdcRFRKDS7wekPIf2TwNObONpFmjNgWpd+b1eFiD5lnMnJ93ZWO?=
 =?us-ascii?Q?FRJ+Y1wtby8rBRGrGnNnhjtckJh4xSDLe0Q7ayxZOekLWki1i2utcz6pc12U?=
 =?us-ascii?Q?f0Xke7RdMdPO2rNopVGgF5RJPbmxNI4PmSiMm0VRpO+plXqZcLnVo5SjZ6rf?=
 =?us-ascii?Q?d0tDRtfa5IleCqsGFekIHO8dkmgwGXJhAO3jbDttDspcVRFONps1gP6Zez1t?=
 =?us-ascii?Q?jw4Q1OMPQi43r9k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yULKrZVO0Bk9N7d7TLMvUzzm1DuT4CuQFYAmu7wLG9oLdEX6RfY4DhcT32ZF?=
 =?us-ascii?Q?Bj6mfqv7YEKLGTfFGUJzYz8U5CWNYhKKabx02uw9HEXRcZC3ALjTbWR9QILp?=
 =?us-ascii?Q?P6/XENfsIc8NchZybNgaPty7gS7eYt1CGtGjE1UEtHe3PbkQqN+JmEsj2n4X?=
 =?us-ascii?Q?UuKV6a+s38xozUfc9FashJnZmv1L4gOSra84EFYY09Ig/NMoN2YQCZm6gPdw?=
 =?us-ascii?Q?dW4nLq4plwdpSSAcAFlgiohr2HY+y0Er1Q03pQHVPMJst7ZnqIB/zlia0mnt?=
 =?us-ascii?Q?jJK13/PinvJl9j1COecBMX0Fa1O7KO75oEc5ZgwqcUOxPfaxdKkmY7RsBJ0U?=
 =?us-ascii?Q?Lr2zmaxPxq9NR5wv9wvp4SIAwb6B4XZt3/JGpFkPEza9h8teWVLTZ7F17w/T?=
 =?us-ascii?Q?aNe6G9kegv7hC419N/FeV2YKNizkpjRjUioRW3oIr4NJTxqZfS57SV6i8nNO?=
 =?us-ascii?Q?raFmqpL2caXkOANRLFsSSS9pQpVhvokPNnoyIDCHa8V8DR0ASCzA9GJ6UnaP?=
 =?us-ascii?Q?GElJFGmD/wPvAGWI/5WyN/gP+CxctyzUXW9OLWMGVbQN/bRhun5n+hXY1Cpa?=
 =?us-ascii?Q?tND5dcAwIt7EeitQvFCeMw1EifDRSmeen6FHMTyI4K2kaKdhb0q3SwsfwytB?=
 =?us-ascii?Q?4rkO7oODKtqo/V4QF8oBrmD4FTcqYHL0iH7ai2OhDGSz0FBNlhlKuo5mAYCO?=
 =?us-ascii?Q?fKeTfXNEsmtXSTBql2XKhRLvxehceB4iMZIbfCQuxOT9SFBJNPv6NbHE1gqS?=
 =?us-ascii?Q?yOgY7FdckixNxRwMNFssjrJtXMb+/qWhciiCOuNwv/kqBdfKIsbK5Z7uXscQ?=
 =?us-ascii?Q?i6vfMqlmvUbfI+Tdi7wXKVKMoOGGapUXn0zf2MK3TkbqqnXs+ASaV6CryBGn?=
 =?us-ascii?Q?dVv0wt0DL13Hr7OYNrs/DxBjIEN/36gDdiR+uZrW5aHNfrGiP1kBYVnkKDVf?=
 =?us-ascii?Q?9x+NYrTzNlI7Jfdyp1Jnffjxo5Osuubqn6OTNE6FoyjH8BYsyP9k8XOjNUhP?=
 =?us-ascii?Q?qaEjHlRzjFtDLwrp00QOUVZFqsq9XJNm4MPyx6ZOdgx0Y4rMlFOPjSajPiO1?=
 =?us-ascii?Q?ZpaM5zIT6AIMHGANSoh8E7TcFSY19W9HyMZrtZQ56y+ohod8HkHYzveJKGHf?=
 =?us-ascii?Q?CCWZdVpdNx+/BAbYIc74oNHVRbSDNow2QshrUrO+Tz2bfuamEizhUHP5FBZj?=
 =?us-ascii?Q?X9J/5zuw7HAjIWq5mQS+ofePxfyU2EvaHQd1RtstEt+hUCpj7NdaoBV+BPLs?=
 =?us-ascii?Q?uAwJfxzbiL4ruVsC/jSp1HuIZsKjonuz88ggzuiQriCzv/tuqEA/WX5cz66F?=
 =?us-ascii?Q?yUi4Z6SJle0T8hfhjFVDoKZJWY29Riz3jHkT36sSNklmcVngZrZT9Z1bKxg8?=
 =?us-ascii?Q?Nq3bG2eXBcBLS0Czh0CK3Npb/WLXiYKXBsdmmIBH8FYyTY4dqMBVwZFPB/Pt?=
 =?us-ascii?Q?m2te9bdrjUmuIcaomn0BPz3KBkN72MIN11o0wPZYnIGSEa7uXwvG9Y7O7oz4?=
 =?us-ascii?Q?dXwiX7gM2pZHD5eOr86BM+EtxO8pbZDQSS6RGMOJ/uL9LAo2IvnNQjV1GjnZ?=
 =?us-ascii?Q?uj4I8rgovWAmdLK++tLkEAX3zUFAv7q7LtCvuNfWVH8RAwDacTaJpeN6rB/n?=
 =?us-ascii?Q?1A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53960230-128d-41db-8a3b-08ddbb050b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 14:14:09.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9O5XP1YyKmevw2yHgY8o53m55zbCmku3MlIBilvOsL+ylmZqjwpVIbZIbxdxfco0qdqgl2mcZzbEKa6+n40H0kUF2r343wWpJ05ImioHGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13298

Hi Biju,

> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 25 June 2025 11:20
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Mark Brown <broonie=
@kernel.org>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>; Philipp Zabel <p.zabel@pengutronix.de>;=
 Geert Uytterhoeven
> <geert+renesas@glider.be>; Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-renesa=
s-soc@vger.kernel.org;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
>=20
> Hi Fabrizio,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Sent: 24 June 2025 20:23
> > Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.maha=
dev-lad.rj@bp.renesas.com>
> > Subject: [PATCH 3/6] spi: Add driver for the RZ/V2H(P) RSPI IP
> >
> > The Renesas RZ/V2H(P) RSPI IP supports 4-wire and 3-wire serial communi=
cations in both host role and
> > target role.
> > It can use a DMA, but the I/O can also be driven by the processor.
> >
> > RX-only, TX-only, and RX-TX operations are available in DMA mode, while=
 in processor I/O mode it only
> > RX-TX operations are supported.
> >
> > Add a driver to support 4-wire serial communications as host role in pr=
ocessor I/O mode.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >
> > I have noticed a problem when unbinding the driver that is solved by:
> > https://lore.kernel.org/all/20250616135357.3929441-1-claudiu.beznea.uj@=
bp.renesas.com/
> >
> > Once the above series gets accepted I'll send a patch to add runtime pm=
 support, and I'll also switch
> > to using devm_spi_register_controller.
> >
> >  drivers/spi/Kconfig          |   8 +
> >  drivers/spi/Makefile         |   1 +
> >  drivers/spi/spi-rzv2h-rspi.c | 469 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 478 insertions(+)
> >  create mode 100644 drivers/spi/spi-rzv2h-rspi.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index f2d2295a55=
01..fcc6987945fa 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -923,6 +923,14 @@ config SPI_RSPI
> >  	help
> >  	  SPI driver for Renesas RSPI and QSPI blocks.
> >
> > +config SPI_RZV2H_RSPI
> > +	tristate "Renesas RZ/V2H RSPI controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	help
> > +	  RSPI driver for the Renesas RZ/V2H Serial Peripheral Interface (RSP=
I).
> > +	  RSPI supports both SPI host and SPI target roles. This option only
> > +	  enables the SPI host role.
> > +
> >  config SPI_RZV2M_CSI
> >  	tristate "Renesas RZ/V2M CSI controller"
> >  	depends on ARCH_RENESAS || COMPILE_TEST diff --git a/drivers/spi/Make=
file b/drivers/spi/Makefile
> > index 4ea89f6fc531..c19d02653b8a 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -126,6 +126,7 @@ obj-$(CONFIG_MACH_REALTEK_RTL)		+=3D spi-realtek-rt=
l.o
> >  obj-$(CONFIG_SPI_REALTEK_SNAND)		+=3D spi-realtek-rtl-snand.o
> >  obj-$(CONFIG_SPI_RPCIF)			+=3D spi-rpc-if.o
> >  obj-$(CONFIG_SPI_RSPI)			+=3D spi-rspi.o
> > +obj-$(CONFIG_SPI_RZV2H_RSPI)		+=3D spi-rzv2h-rspi.o
> >  obj-$(CONFIG_SPI_RZV2M_CSI)		+=3D spi-rzv2m-csi.o
> >  obj-$(CONFIG_SPI_S3C64XX)		+=3D spi-s3c64xx.o
> >  obj-$(CONFIG_SPI_SC18IS602)		+=3D spi-sc18is602.o
> > diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.=
c new file mode 100644 index
> > 000000000000..9541f2c2ab2b
> > --- /dev/null
> > +++ b/drivers/spi/spi-rzv2h-rspi.c
> > @@ -0,0 +1,469 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Renesas RZ/V2H Renesas Serial Peripheral Interface (RSPI)
> > + *
> > + * Copyright (C) 2025 Renesas Electronics Corporation  */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/limits.h>
> > +#include <linux/log2.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/reset.h>
> > +#include <linux/spi/spi.h>
> > +
> > +/* Registers */
> > +#define RSPI_SPDR		0x00
> > +#define RSPI_SPCR		0x08
> > +#define RSPI_SSLP		0x10
> > +#define RSPI_SPBR		0x11
> > +#define RSPI_SPSCR		0x13
> > +#define RSPI_SPCMD		0x14
> > +#define RSPI_SPDCR2		0x44
> > +#define RSPI_SPSR		0x52
> > +#define RSPI_SPSRC		0x6a
> > +#define RSPI_SPFCR		0x6c
> > +
> > +/* Register SPCR */
> > +#define RSPI_SPCR_MSTR		BIT(30)
> > +#define RSPI_SPCR_SPRIE		BIT(17)
> > +#define RSPI_SPCR_SCKASE	BIT(12)
> > +#define RSPI_SPCR_SPE		BIT(0)
> > +
> > +/* Register SPBR */
> > +#define RSPI_SPBR_SPR_MIN	0
> > +#define RSPI_SPBR_SPR_MAX	255
> > +
> > +/* Register SPCMD */
> > +#define RSPI_SPCMD_SSLA		GENMASK(25, 24)
> > +#define RSPI_SPCMD_SPB		GENMASK(20, 16)
> > +#define RSPI_SPCMD_LSBF		BIT(12)
> > +#define RSPI_SPCMD_SSLKP	BIT(7)
> > +#define RSPI_SPCMD_BRDV		GENMASK(3, 2)
> > +#define RSPI_SPCMD_CPOL		BIT(1)
> > +#define RSPI_SPCMD_CPHA		BIT(0)
> > +
> > +#define RSPI_SPCMD_BRDV_MIN	0
> > +#define RSPI_SPCMD_BRDV_MAX	3
> > +
> > +/* Register SPDCR2 */
> > +#define RSPI_SPDCR2_TTRG	GENMASK(11, 8)
> > +#define RSPI_SPDCR2_RTRG	GENMASK(3, 0)
> > +#define RSPI_FIFO_SIZE		16
> > +
> > +/* Register SPSR */
> > +#define RSPI_SPSR_SPRF		BIT(15)
> > +
> > +/* Register RSPI_SPSRC */
> > +#define RSPI_SPSRC_CLEAR	0xfd80
> > +
> > +#define RSPI_RESET_NUM		2
> > +
> > +enum rspi_clocks {
> > +	RSPI_CLK_PCLK,
> > +	RSPI_CLK_PCLK_SFR,
> > +	RSPI_CLK_TCLK,
> > +	RSPI_CLK_NUM
> > +};
>=20
> Do we need this enum?

I can drop it if I switch to using devm_clk_bulk_get_all_enabled().

>=20
> > +
> > +struct rzv2h_rspi_priv {
> > +	struct reset_control_bulk_data resets[RSPI_RESET_NUM];
> > +	struct clk_bulk_data clks[RSPI_CLK_NUM];
>=20
>=20
> It is used only in probe/remove. By using devm_clk_bulk_get_all_enabled()
> this can be local??

Okay, I'll move it to rzv2h_rspi_probe().

>=20
> > +	struct spi_controller *controller;
> > +	void __iomem *base;
> > +	wait_queue_head_t wait;
> > +	unsigned int bytes_per_word;
> > +	u32 freq;
> > +	u16 status;
> > +};
> > +
> > +#define RZV2H_RSPI_TX(func, type)					\
> > +static inline void rzv2h_rspi_tx_##type(struct rzv2h_rspi_priv *rspi,	=
\
> > +					const void *txbuf,		\
> > +					unsigned int index) {		\
> > +	type buf =3D 0;							\
> > +									\
> > +	if (txbuf)							\
> > +		buf =3D ((type *)txbuf)[index];				\
> > +									\
> > +	func(buf, rspi->base + RSPI_SPDR);				\
> > +}
> > +
> > +#define RZV2H_RSPI_RX(func, type)					\
> > +static inline void rzv2h_rspi_rx_##type(struct rzv2h_rspi_priv *rspi,	=
\
> > +					void *rxbuf,			\
> > +					unsigned int index) {		\
> > +	type buf =3D func(rspi->base + RSPI_SPDR);			\
> > +									\
> > +	if (rxbuf)							\
> > +		((type *)rxbuf)[index] =3D buf;				\
> > +}
> > +
> > +RZV2H_RSPI_TX(writel, u32)
> > +RZV2H_RSPI_TX(writew, u16)
> > +RZV2H_RSPI_TX(writeb, u8)
> > +RZV2H_RSPI_RX(readl, u32)
> > +RZV2H_RSPI_RX(readw, u16)
> > +RZV2H_RSPI_RX(readl, u8)
> > +
> > +static void rzv2h_rspi_reg_rmw(const struct rzv2h_rspi_priv *rspi,
> > +				int reg_offs, u32 bit_mask, u32 value) {
> > +	u32 tmp;
> > +
> > +	value <<=3D __ffs(bit_mask);
> > +	tmp =3D (readl(rspi->base + reg_offs) & ~bit_mask) | value;
> > +	writel(tmp, rspi->base + reg_offs);
> > +}
> > +
> > +static inline void rzv2h_rspi_spe_disable(const struct rzv2h_rspi_priv
> > +*rspi) {
> > +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCR, RSPI_SPCR_SPE, 0); }
> > +
> > +static inline void rzv2h_rspi_spe_enable(const struct rzv2h_rspi_priv
> > +*rspi) {
> > +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCR, RSPI_SPCR_SPE, 1); }
> > +
> > +static inline void rzv2h_rspi_clear_fifos(const struct rzv2h_rspi_priv
> > +*rspi) {
> > +	writeb(1, rspi->base + RSPI_SPFCR);
> > +}
> > +
> > +static inline void rzv2h_rspi_clear_all_irqs(struct rzv2h_rspi_priv
> > +*rspi) {
> > +	writew(RSPI_SPSRC_CLEAR, rspi->base + RSPI_SPSRC);
> > +	rspi->status =3D 0;
> > +}
> > +
> > +static irqreturn_t rzv2h_rx_irq_handler(int irq, void *data) {
> > +	struct rzv2h_rspi_priv *rspi =3D data;
> > +
> > +	rspi->status =3D readw(rspi->base + RSPI_SPSR);
> > +	wake_up(&rspi->wait);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static inline int rzv2h_rspi_wait_for_interrupt(struct rzv2h_rspi_priv=
 *rspi,
> > +						u32 wait_mask)
> > +{
> > +	return wait_event_timeout(rspi->wait, (rspi->status & wait_mask),
> > +				  HZ) =3D=3D 0 ? -ETIMEDOUT : 0;
> > +}
> > +
> > +static void rzv2h_rspi_send(struct rzv2h_rspi_priv *rspi, const void *=
txbuf,
> > +			    unsigned int index)
> > +{
> > +	switch (rspi->bytes_per_word) {
> > +	case 4:
> > +		rzv2h_rspi_tx_u32(rspi, txbuf, index);
> > +		break;
> > +	case 2:
> > +		rzv2h_rspi_tx_u16(rspi, txbuf, index);
> > +		break;
> > +	default:
> > +		rzv2h_rspi_tx_u8(rspi, txbuf, index);
> > +	}
> > +}
> > +
> > +static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *rspi, void *rxbu=
f,
> > +			      unsigned int index)
> > +{
> > +	int ret;
> > +
> > +	ret =3D rzv2h_rspi_wait_for_interrupt(rspi, RSPI_SPSR_SPRF);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (rspi->bytes_per_word) {
> > +	case 4:
> > +		rzv2h_rspi_rx_u32(rspi, rxbuf, index);
> > +		break;
> > +	case 2:
> > +		rzv2h_rspi_rx_u16(rspi, rxbuf, index);
> > +		break;
> > +	default:
> > +		rzv2h_rspi_rx_u8(rspi, rxbuf, index);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
> > +				  struct spi_device *spi,
> > +				  struct spi_transfer *transfer)
> > +{
> > +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(controlle=
r);
> > +	unsigned int words_to_transfer, i;
> > +	int ret =3D 0;
> > +
> > +	transfer->effective_speed_hz =3D rspi->freq;
> > +	words_to_transfer =3D transfer->len / rspi->bytes_per_word;
> > +
> > +	for (i =3D 0; i < words_to_transfer; i++) {
> > +		rzv2h_rspi_clear_all_irqs(rspi);
> > +
> > +		rzv2h_rspi_send(rspi, transfer->tx_buf, i);
> > +
> > +		ret =3D rzv2h_rspi_receive(rspi, transfer->rx_buf, i);
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +	rzv2h_rspi_clear_all_irqs(rspi);
> > +
> > +	if (ret)
> > +		transfer->error =3D SPI_TRANS_FAIL_IO;
> > +
> > +	spi_finalize_current_transfer(controller);
> > +
> > +	return ret;
> > +}
> > +
> > +static inline u32 rzv2h_rspi_calc_bitrate(unsigned long tclk_rate, u8 =
spr,
> > +					  u8 brdv)
> > +{
> > +	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv))); }
> > +
> > +static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz=
)
> > +{
> > +	unsigned long tclk_rate;
> > +	int spr;
> > +	u8 brdv;
> > +
> > +	/*
> > +	 * From the manual:
> > +	 * Bit rate =3D f(RSPI_n_TCLK)/(2*(n+1)*2^(N))
> > +	 *
> > +	 * Where:
> > +	 * * RSPI_n_TCLK is fixed to 200MHz on V2H
> > +	 * * n =3D SPR - is RSPI_SPBR.SPR (from 0 to 255)
> > +	 * * N =3D BRDV - is RSPI_SPCMD.BRDV (from 0 to 3)
> > +	 */
> > +	tclk_rate =3D clk_get_rate(rspi->clks[RSPI_CLK_TCLK].clk);
> > +	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brd=
v++) {
> > +		spr =3D DIV_ROUND_UP(tclk_rate, hz * (1 << (brdv + 1)));
> > +		spr--;
> > +		if (spr >=3D RSPI_SPBR_SPR_MIN && spr <=3D RSPI_SPBR_SPR_MAX)
> > +			goto clock_found;
> > +	}
> > +
> > +	return 0;
> > +
> > +clock_found:
> > +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_BRDV, brdv);
> > +	writeb(spr, rspi->base + RSPI_SPBR);
> > +
> > +	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv); }
> > +
> > +static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
> > +				      struct spi_message *message)
> > +{
> > +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(ctlr);
> > +	const struct spi_device *spi =3D message->spi;
> > +	struct spi_transfer *xfer;
> > +	u32 speed_hz =3D U32_MAX;
> > +	u8 bits_per_word;
> > +	u32 conf32;
> > +	u16 conf16;
> > +
> > +	/* Make sure SPCR.SPE is 0 before amending the configuration */
> > +	rzv2h_rspi_spe_disable(rspi);
> > +
> > +	/* Configure the device to work in "host" mode */
> > +	conf32 =3D RSPI_SPCR_MSTR;
> > +
> > +	/* Auto-stop function */
> > +	conf32 |=3D RSPI_SPCR_SCKASE;
> > +
> > +	/* SPI receive buffer full interrupt enable */
> > +	conf32 |=3D RSPI_SPCR_SPRIE;
> > +
> > +	writel(conf32, rspi->base + RSPI_SPCR);
> > +
> > +	/* Use SPCMD0 only */
> > +	writeb(0x0, rspi->base + RSPI_SPSCR);
> > +
> > +	/* Setup mode */
> > +	conf32 =3D FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
> > +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
> > +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_LSBF, !!(spi->mode & SPI_LSB_FIRST)=
);
> > +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SSLKP, 1);
> > +	conf32 |=3D FIELD_PREP(RSPI_SPCMD_SSLA, spi_get_chipselect(spi, 0));
> > +	writel(conf32, rspi->base + RSPI_SPCMD);
> > +	if (spi->mode & SPI_CS_HIGH)
> > +		writeb(BIT(spi_get_chipselect(spi, 0)), rspi->base + RSPI_SSLP);
> > +	else
> > +		writeb(0, rspi->base + RSPI_SSLP);
> > +
> > +	/* Setup FIFO thresholds */
> > +	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, RSPI_FIFO_SIZE - 1);
> > +	conf16 |=3D FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
> > +	writew(conf16, rspi->base + RSPI_SPDCR2);
> > +
> > +	rzv2h_rspi_clear_fifos(rspi);
> > +
> > +	list_for_each_entry(xfer, &message->transfers, transfer_list) {
> > +		if (!xfer->speed_hz)
> > +			continue;
> > +
> > +		speed_hz =3D min(xfer->speed_hz, speed_hz);
> > +		bits_per_word =3D xfer->bits_per_word;
> > +	}
> > +
> > +	if (speed_hz =3D=3D U32_MAX)
> > +		return -EINVAL;
> > +
> > +	rspi->bytes_per_word =3D roundup_pow_of_two(BITS_TO_BYTES(bits_per_wo=
rd));
> > +	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_SPB, bits_per_word -
> > +1);
> > +
> > +	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
> > +	if (!rspi->freq)
> > +		return -EINVAL;
> > +
> > +	rzv2h_rspi_spe_enable(rspi);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2h_rspi_unprepare_message(struct spi_controller *ctlr,
> > +					struct spi_message *message)
> > +{
> > +	struct rzv2h_rspi_priv *rspi =3D spi_controller_get_devdata(ctlr);
> > +
> > +	rzv2h_rspi_spe_disable(rspi);
> > +	rzv2h_rspi_clear_fifos(rspi);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2h_rspi_probe(struct platform_device *pdev) {
> > +	struct spi_controller *controller;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rzv2h_rspi_priv *rspi;
> > +	unsigned long tclk_rate;
> > +	int irq_rx, ret;
> > +
> > +	controller =3D devm_spi_alloc_host(dev, sizeof(*rspi));
> > +	if (!controller)
> > +		return -ENOMEM;
> > +
> > +	rspi =3D spi_controller_get_devdata(controller);
> > +	platform_set_drvdata(pdev, rspi);
> > +
> > +	rspi->controller =3D controller;
> > +
> > +	rspi->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rspi->base))
> > +		return PTR_ERR(rspi->base);
> > +
> > +	rspi->clks[RSPI_CLK_PCLK].id =3D "pclk";
> > +	rspi->clks[RSPI_CLK_PCLK_SFR].id =3D "pclk_sfr";
> > +	rspi->clks[RSPI_CLK_TCLK].id =3D "tclk";
> > +	ret =3D devm_clk_bulk_get(dev, RSPI_CLK_NUM, rspi->clks);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot get clocks\n");
> > +
> > +	rspi->resets[0].id =3D "presetn";
> > +	rspi->resets[1].id =3D "tresetn";
> > +	ret =3D devm_reset_control_bulk_get_exclusive(dev, RSPI_RESET_NUM,
> > +						    rspi->resets);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot get resets\n");
> > +
> > +	irq_rx =3D platform_get_irq_byname(pdev, "rx");
> > +	if (irq_rx < 0)
> > +		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
> > +
> > +	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
> > +			       dev_name(dev), rspi);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "cannot request `rx` IRQ\n");
> > +
> > +	ret =3D clk_bulk_prepare_enable(RSPI_CLK_NUM, rspi->clks);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
>=20
> Can't we use devm_clk_bulk_get_all_enabled() instead that will fill struc=
t clk_bulk_data??

Will do.

>=20
> > +
> > +	ret =3D reset_control_bulk_deassert(RSPI_RESET_NUM, rspi->resets);
> > +	if (ret) {
> > +		dev_err(dev, "failed to deassert resets\n");
> > +		goto quit_clocks;
> > +	}
> > +
> > +	init_waitqueue_head(&rspi->wait);
> > +
> > +	tclk_rate =3D clk_get_rate(rspi->clks[RSPI_CLK_TCLK].clk);
>=20
> Is it not possible to get this clk from struct clk_bulk_data by using the=
 id "tclk"??

It is, with a for loop looping over the data filled up by devm_clk_bulk_get=
_all_enabled().

I'll switch to using devm_clk_bulk_get_all_enabled().

Cheers,
Fab

>=20
> Cheers,
> Biju


