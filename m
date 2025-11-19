Return-Path: <linux-spi+bounces-11348-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C77C70160
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7516F356ED3
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325EA2D949A;
	Wed, 19 Nov 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nkuTe5h/"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010022.outbound.protection.outlook.com [52.101.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EC23EA86;
	Wed, 19 Nov 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569274; cv=fail; b=emwvJVKPxeFkyGGS/cPnzVSZv044C4lpEX0bMdfMhmcSXocqPSmcGPFeejz0kICHS9gFsAsT1vxx3fLCz++baCGUUsO/p0MyDB+Zh+0e0E7AQnHpjqxyWDu2MqsVNKsRlvL+kHXhk6tlPCF1gUZQh1NZx2FmU6zuh1QgBvcIPrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569274; c=relaxed/simple;
	bh=jLdvv88bfdCqomWPpgYFzOf1SbFDI/ZOHEsY8X/pyYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTlx2DwVTxvbPleVUqRPfxuSMclTM9/dRBznaAnPFQw+AJwdqh6VopopnTXhKwpyjsZB3ve8vWYHFFPq8E1aRaP7b4BxC1K3vqkNvnJCjAHm4UjLFtGQD8fkooSGm7/wkPX2dEM1ExzDEGM36oF+68KGKGJsH3HVmqzUKRMF/dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nkuTe5h/; arc=fail smtp.client-ip=52.101.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMedlAspvAjsS2svqmWymKiMdsOKKHgF04PUYFVf8kK0/ueEPDOfDj1E4G3lYELTzZVmwqxLQj6Dtkn0+f66HcM4336rD9rKUxPB8jPAFugySVjDH8UndqDsRw0g7LzUnCbIS0F1zC8iJVzzxcymn2VwdqteFOXFyOTEz8BiO54z0JTCk4XoipC7EBj7FrG9sO1v5F8FXKftx7iP20vpu4GMaIV1yv+IGnVU4uLZl0WKYzREwIl2cLw/HwyQR91AwFY88B3UWBqEsKMsFIteGMcFAfNZFHQchCajoGGYQ9kokDLZ34BXIdOjf3ZtdvdQ+4UOZJ1nTVQk3aCmIB6NuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0voDBMZYKAdozTc9iiGHghjs3B9ktd236y58X+n+r8=;
 b=BQ1pN4YYZphNMYwtEp/ZQDjzarlZykz6LkvuJ6KNlTYBCAih+PjhNOl55smOCjE/qEeZa1t+v5tRxD1ws5+VDzUfIFr+QtJPBf+TIeL5mLS6wiSlS8x28MgKuG2YGWLBj/wfsKReu0FkmiSeNYAkJHm6qWs7gu06zmFtGLz82g92rS6BPI3qgri5+GiHHnI9TcomLYbpeRMBgzJErJch/NxgqLKWCKk7N0B2p2LfUKBFbwpP/ddoSjvUwBf7BQTvilidm6ticxJI9wrSfJEonA2x/LxTZzPO2M1fMoLNInSo07FPLoVkqju/W2u/w0hzCFXsOnnRnJwOEblucG4X9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0voDBMZYKAdozTc9iiGHghjs3B9ktd236y58X+n+r8=;
 b=nkuTe5h/7P4tntFpVfy//3NzJRt8iMyZUiNB4GRMnqG8U4lgZAFgMqFjjgvC5vuwwhNDNnHRO8Ti9gOEjUqd4ZvJ5wLLmXyxp1/v0+/XGuYrxA2lh6jITF+MYlu6OzB38Qqq3nAcpH2yl5t7g+4w/qvu2lfcVnsK1hhdoRXhSqU=
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com (2603:1096:405:1a6::6)
 by OS7PR01MB11778.jpnprd01.prod.outlook.com (2603:1096:604:249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:21:07 +0000
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29]) by TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:21:07 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 00/13] Add RSPI support for RZ/T2H and RZ/N2H
Thread-Topic: [PATCH v4 00/13] Add RSPI support for RZ/T2H and RZ/N2H
Thread-Index: AQHcWW+zcljTdnr600qLn9hOQMHSDrT6LQEw
Date: Wed, 19 Nov 2025 16:21:07 +0000
Message-ID:
 <TYYPR01MB139555ABC0CE8CB9D685355E185D7A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13955:EE_|OS7PR01MB11778:EE_
x-ms-office365-filtering-correlation-id: 43f6e40d-56fc-435e-4f89-08de2787a527
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yrqK5yA5TP0WgvPAIDbxAdUIUoD5gXPDLhiDw2Vd8rZcwZJKweMTWhoA0UvR?=
 =?us-ascii?Q?x90+dYUcfo/qQngMWHy9uImc3pL90pFEONiKWSVV5I5b48JjYODeZP/PVX9c?=
 =?us-ascii?Q?T02DUjj8Ctzxpa6YxU3nnKZBkJRh+SvSYutLpc0X+Nf8oDueQF0yMxwqQHgn?=
 =?us-ascii?Q?qCL3p50W3jw2SfJ7qGflfPPHeAUrhtgdEQwtWNJYC8CEKBKGn58v04h3LlSk?=
 =?us-ascii?Q?GVbh7s8U+A/cKbsuDdljxPPoUlVzpk5vphWIm3nMemNTKNyo5oe7D7+/885+?=
 =?us-ascii?Q?VN3RmB+L8+BsBv2NRNzaTBEftaUg2ebizIcXeM56SaeWbNt7+5aQ0i0KXx/G?=
 =?us-ascii?Q?bRcamI9KyDgFOcLPFGsJzklGnEDgMOhAW50E2DgAGbK1yRRnWcCgCScOaSJO?=
 =?us-ascii?Q?/zjZreGwhDYu5sI9PTpsivYzr1iNXCt8mCiD3xg5JRLsd+voyofiEMqCq9Xa?=
 =?us-ascii?Q?/c8CsBdjG3TA5IEDrnhiBxCI61r3D5SwcLm7bdr0vNL1nkTndZAZ/jaZjhVw?=
 =?us-ascii?Q?ygeLT73hCTXZby5hiqxC7dwPCZvqX6PjdW4pGGV6szyow1CRi2WCCPQGjqi2?=
 =?us-ascii?Q?CULORB+dhVRy+/1tnc3aBTimI+A4r1gmdx/OkL4QjAK0xr6dsTj3V0p7Ts5i?=
 =?us-ascii?Q?x5PaeGTgCGFsAsaeUkCvrlHxpYO+bA+IGzylzkiriysC6edfEq9lIlNhwksK?=
 =?us-ascii?Q?hZfYTWz6ezQ/zDuRFvKg4R4i3CcsDN5TR//gbgRQeV573SaX77HbYeum6iHo?=
 =?us-ascii?Q?cwHZMvGSmLesDuEEyctyq1c9Z6FwPLp1fyYP/OGX8pHwqmTQnZl3MXpwKMhE?=
 =?us-ascii?Q?+42Sfzsq6Wq5Ue2Y7Hzcva5gQVFYckm0ZFSezvzjtyVzryjnAsKnywD9U0In?=
 =?us-ascii?Q?Zaf3NXF7QQ6EFuf+7QGf92ofwxietHQ8dbtcqSJrqCnIeYUy5eaOIgJFBln2?=
 =?us-ascii?Q?420PEVsgPf1xz1ci3K9Kl2jTKDyM4LhJQbf1neb2xzdlUmOKxQmPOwS61/d0?=
 =?us-ascii?Q?t0ja/x9OgCjgghg4CJHPoofIqjwKACgCxdGSqh/KZOD48qHHHu6NjgZp5tsy?=
 =?us-ascii?Q?5ACntM0/UINklZYY0BUqIDIK9sEYayTm6mlXKmgsjixfqrP7cB/99xhJGvgp?=
 =?us-ascii?Q?I7DsNXKyuPtD8JhrOlzaRdDClUYlVPOom/OROnQ8WpkYUun+mY436fiiW1KW?=
 =?us-ascii?Q?FRiXsj9HJp2EtjEIc/ScdMM2BEN7PdWBsclMNlXxnZfMM/oiMlzm7VmqztYM?=
 =?us-ascii?Q?6QmdLdcJB5InYDJWTLo49AXm2yDH315MeU1sdanD+zmmNRYoMIMp8yPQVcnb?=
 =?us-ascii?Q?HgA/L0TfVFt8+xWL2LuIppA1ONRHE3Dvt5UkaPsLMKfthkH+wf1hqLwFHK1q?=
 =?us-ascii?Q?ofRvdLi2blylyulc3zq/7BHjHU5wJYWZ7Cag3R7gaCCNJanWz/7AW5x8giTN?=
 =?us-ascii?Q?+JKvLi/PgEBjCBIMKAOoIZCjl0+nrGU4edjGWtIdeGWEDpVRfsTnPwy6IxIZ?=
 =?us-ascii?Q?WoyormrAGBakSVGfYBoHUv4LK1fEB6zUagdB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13955.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xU9vfSCSIYQRotxGrttgrkDKBR1gJGGqxlRY9js6wz/mkaHFToITcV5m/D3J?=
 =?us-ascii?Q?hOiZrYQgKrzIbv/u1YA5tg5cDR4EgziVcD8irCgYjbig+ZA7yiTA3zeKxOzX?=
 =?us-ascii?Q?Nzd6zSLM0TAnK2Z/2oF0ZfmtiBMKCBWUf+lilziCZzkh90DK0GwuNO0QBHBM?=
 =?us-ascii?Q?elqtVmNN6+30L7sk6QPqJhauosxenfggcFs0bWtXX8QSlNEzMT83KH0Bs6RH?=
 =?us-ascii?Q?J+xZIZ9sFVBaOYsmlqnqMhXhuWBBeywujAwe4O4KAMOQtVjoPvT0uVsp3Zib?=
 =?us-ascii?Q?tG+tBlNVAi9anCPAg3hyk7JPkys7ZOIrHhzb6nq5Fq+DZ7TmhlfX0mcrfkVw?=
 =?us-ascii?Q?yd8r+qTQdHgZFWLNZ2Rwlg4KJEVm8uo/365J90cJfFKAeP+Z+GEZrfse597f?=
 =?us-ascii?Q?WH6uvcrFbXhDtq6M2BG52phPzvkyce12v2uenprcmgfCZx4wkYdVQPHnQ46F?=
 =?us-ascii?Q?53UY+uPKGp+9sBnsIRFOKHRvszUUIz7vMFDMyiUq9F0UFvgntTGRx5KnFuet?=
 =?us-ascii?Q?OtOLiM/bezbFbyDK7jBGhnwAVUenPJi/QgpXBMfGl3dpM1uhvxA7CN+eGL6P?=
 =?us-ascii?Q?RjXDAutOFBXyDsw+7RiozQa3MnQovt/u3ZcsJfftQfzSf57VLaJviccQItmz?=
 =?us-ascii?Q?KriuPYCzCOfqbihzOYhKSdlfAp51YEBZqVFOLI0OfQrQUJbYaH1YM0B+0Hlt?=
 =?us-ascii?Q?OgQ03o1xRFN/RXBKSw3+yJd7lZ9ENp2Ka2o8MH8ikUKVLS6Hdp/nQyblGlkx?=
 =?us-ascii?Q?pQFyV7ZrEZmGeQe+Joj1trX2UY6zDDwoOiryf0l6AcXzIUaFvlo1lK5bIN6X?=
 =?us-ascii?Q?Xt4EjQcd9dwR4lMgtqgieMyGmnMkGopTBTR00ewg5T3Jtkg97pf+Gky1n6MS?=
 =?us-ascii?Q?euHfPZHw0+rBXwUkGo69cNx5OxEei3UZRa9PbTNX/hAEEncEr2eNKZkM6shA?=
 =?us-ascii?Q?3Y0WzSUiTu/TjwVkl9qzh4DmcYmLbl2ZFU5cQtHKCZW9gF1a50+zQ5ac3fpm?=
 =?us-ascii?Q?AutWntny1j6XtznJNNQIBcfFffsySejiWVvo9eraQpRiiFYV7EDjoParkivx?=
 =?us-ascii?Q?FEOe/uFAGYQgFJNztQ838ZGbfY1KzWtg2yGc1q6fn+OUNpZhyNUDe73eOuz3?=
 =?us-ascii?Q?JWxpzxLwaCV+vfYorSDZ896A2joSHE+vTjVVFqDd/n7WVaWNrrN+2nRUylq5?=
 =?us-ascii?Q?Q1j71m1UJbCxLh6tObmUDLRv3qjnc4BXTl58bDCTRuZ2avvexiVXFoNFJDcJ?=
 =?us-ascii?Q?RWffS+MefCJjVFGYCcwfRyLNgIejlhGeD2RK8L6EtBQejEEgaEcMKpU0mfbi?=
 =?us-ascii?Q?xR24M/7noEySn08/Q2wQdkkk0g/Wkkt3wm0A0tIPd9fOyIaCD3kKpB2lH4S4?=
 =?us-ascii?Q?iC7nm6LUsvV1h3y5+AxEwLxcBr6uHTAEcmrwBzPZ4Hs2p1R0CoTKt1oRcojI?=
 =?us-ascii?Q?m/yd+aqQp7KGUNd+45L7gJuzl78fEB3KkRoQRydi3FfK1e2sgeEgUB7OJm1r?=
 =?us-ascii?Q?hRjjqPI8Axkfk/fdRWWlDmXVn+NbbBjI8PQRkQ/mLSS7RMTICu9QwAVinqek?=
 =?us-ascii?Q?T+ENTRulGlo6MMJa5BRQnoujr/QVAdo6wFXObJ8LUojFoDE2ehvRR2m6v2Fd?=
 =?us-ascii?Q?uhbi8NmtlSkbSz01xbMqzQw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13955.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f6e40d-56fc-435e-4f89-08de2787a527
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 16:21:07.7790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6CoaK9HWDxcprZDjq+lialhW0VyRoEiMsKpiKK/HRFeyi8f/eZNET3xUfGNlcvOYzO+bmP1vaiUl9IRDCpuaoqQ5ZyJ9n9YiNaIkp3Z7AqZ2NbMwp9IsH/OEJhr5j1k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11778

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 19, 2025 6:14 PM
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Mark Brown <broonie=
@kernel.org>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley=
 <conor+dt@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>; magnus.damm <magnus.damm@gmail.co=
m>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: linux-spi@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicet=
ree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.=
xa@renesas.com>
> Subject: [PATCH v4 00/13] Add RSPI support for RZ/T2H and RZ/N2H
>=20
> V4:
>  * remove conditional minItems: 2 and maxItems: 3 for clocks property
>    since it is already set to that
>  * remove renesas,r9a09g087-rspi check since it implies
>    renesas,r9a09g077-rspi
>  * replace contains: enum: with contains: const: since there's only one
>    compatible to be checked against
>=20

Forgot to mention that I dropped the clk patch since Geert queued it up.

> V3:
>  * no changes
>=20
> V2:
>  * fix missing unwind goto quit_resets
>  * add resets: false and reset-names: false
>=20
> Cosmin Tanislav (13):
>   spi: rzv2h-rspi: make resets optional
>   spi: rzv2h-rspi: make FIFO size chip-specific
>   spi: rzv2h-rspi: make clocks chip-specific
>   spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
>   spi: rzv2h-rspi: avoid recomputing transfer frequency
>   spi: rzv2h-rspi: make transfer clock rate finding chip-specific
>   spi: rzv2h-rspi: add support for using PCLK for transfer clock
>   spi: rzv2h-rspi: add support for variable transfer clock
>   spi: rzv2h-rspi: add support for loopback mode
>   dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
>   spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
>   arm64: dts: renesas: r9a09g077: Add SPIs support
>   arm64: dts: renesas: r9a09g087: Add SPIs support
>=20
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      |  62 +++-
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  72 ++++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  72 ++++
>  drivers/spi/spi-rzv2h-rspi.c                  | 339 +++++++++++++++---
>  4 files changed, 476 insertions(+), 69 deletions(-)
>=20
> --
> 2.52.0


