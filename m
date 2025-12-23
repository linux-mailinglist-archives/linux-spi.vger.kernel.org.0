Return-Path: <linux-spi+bounces-12095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C495CD9B1E
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA8A30184D4
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE312E54D3;
	Tue, 23 Dec 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="lP5I2mOc"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010028.outbound.protection.outlook.com [52.101.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E22C235B;
	Tue, 23 Dec 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500947; cv=fail; b=gLP+qH4sENttEkFlBRtouZuLJA1bl9mporWxIetG9in1aWNaxFcgMM0Utcgn1WQncEJ8ObfEqdkb8oCHDtGy6EdhOZ80i08nH3ew5amulldxqfjhwl26sH5VhmYuM2/IgCrsINMchbP9/dfE0ZJvSWml86nlECPWvVITVhjweZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500947; c=relaxed/simple;
	bh=bOeCgoyOgoWq/XyGsIQpUQrEEnMv2zCA8ThMgksfIos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mKDifOpqezaB/Xb1R2zUfz8qFw+I0EgE2Ez+tUedkKVhU8/SXSPzVdebc+8+bIEhLFzni1scsshIpzZfv23q9ctj0fgMAC9bzRg6bNXl2mH/iRB1BaGEXjiVrgBspolL1TfV8pUsca6JqcM650cSyzDcRUnbssgAO1iZZw7SD30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=lP5I2mOc; arc=fail smtp.client-ip=52.101.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzniTfypf544wYjqt5xGvTQVWbtHQ1tACKMMDc3G9AyuyoeDlqCfU0RVSk4f+PZ4EwZrH1iGV0zF2D1JsOPTBqknAr0bqLz1E88kRL0S4CiY6TfObp9g0Z91/IgcsKnIzygd4yf2Z0MIaGNBJvx18PrL82eiCnbYnNFzee9WrxiOin/EoJRV4Ke1qMbemCsDZKx01DYxDKxcGi5+6hqHYbn3hffPjTicbZdVXPieHiCJa7ENfx0l3RWYAeyx1hPFaCSN7WYFdYwEmuZKfl16tZK5lgq/VLAGoEukU7NOEtv0sz1wseeyvwOFbNoCFl4CZxMC6yFbnVguaZxPug941w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4c/BH9VBVvL+LUIw0IHXtNFxpzg8/SzSTmBqpvZ56c=;
 b=yn0GCOEOkJnyD50SFP/JmZ830c6WaRbq0/vQSVOGNyiSeByfqxzNo02gCw/w55DRNf2uKHDKDntma2jn1SVPxOhsrT8C6UEND6OX4GuPMcAXYduy0t/mq3LORG+HLEAGBaMNFNuNmZUpp9ewJSINajY8HpK5AloYj/UsgbNgPmNaMVrdG/Dvrj1mz1D2Trq1FAjV519l26dP4XQz+oHk4Wx7uPknBWCfbJ4uuNWJm/O4YjOgKVxmHXPcfeTOeUt4VOK0f0OjgQPNK1kMv9Acp4zrjz9DN+v06QFrsKevFMtcTyE75LbqCsfkOOe4agWRsqV0IRsT49wMxZyARllVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4c/BH9VBVvL+LUIw0IHXtNFxpzg8/SzSTmBqpvZ56c=;
 b=lP5I2mOc4ib5gGdj2YQDzm9bZ+1lwF/GodyC5D/DfsGeYCqjrhIsQjRfcsDpfx10PaBBZsJAcsS0Cpuhu6QT8fOLzCcbqT20YVUjjpuLUFm+TKdEkZSB3tYxwKBW9ubViwUZjmrrP2qP+FDLYIsjiuIfFN/WseURsKbVKvmGNLk=
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com (2603:1096:405:1a6::6)
 by TYVPR01MB10845.jpnprd01.prod.outlook.com (2603:1096:400:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 14:42:21 +0000
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29]) by TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29%7]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 14:42:21 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 12/13] arm64: dts: renesas: r9a09g077: wire up DMA support
 for SPI
Thread-Topic: [PATCH 12/13] arm64: dts: renesas: r9a09g077: wire up DMA
 support for SPI
Thread-Index: AQHcYsibyGf2fMfUyUyEK1lj0id+8LUvaiqAgAABrdA=
Date: Tue, 23 Dec 2025 14:42:21 +0000
Message-ID:
 <TYYPR01MB139556681F53AC66A668F7E4D85B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201134229.600817-13-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdWUPM=q7J_S_x7=CZoYxKm-v=7GGGkq9Nv0T14b8MBtpA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWUPM=q7J_S_x7=CZoYxKm-v=7GGGkq9Nv0T14b8MBtpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13955:EE_|TYVPR01MB10845:EE_
x-ms-office365-filtering-correlation-id: 05531a62-6b07-4cb4-a97a-08de42317ab4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YZOs2OWtTPxLtyWizQkGoKKJ2OHZ16AsYjTHybKAXbnvIv/q63VXNCrYXmH9?=
 =?us-ascii?Q?jDlv412wjGt40N+qMf4E/Mn1X2ha4tKw68k4JZh2mTikp7B1b1xjzPtVT1EZ?=
 =?us-ascii?Q?Cm4ZXXuxB3Nqjq0n7MXc0/kJgdcpM/4Dpx07D7LT8uI/Ctc37YotOtI8Yuq5?=
 =?us-ascii?Q?emyr0Jq1o+ty9gTHWX+BPF9JcIPc/OxqNLKz3aTMk4FxEsithnmKX5F23Ewf?=
 =?us-ascii?Q?QptGg1CqvUBgy7OdfpfZ77IPdfsvJRFSTFPCY+EX71jqrPWL5wPnHTpKvyTs?=
 =?us-ascii?Q?n8lj2tQLuVHCHWXntJ9KJyNseai67w8UnuIe2SoYu1SSjFV7lPuHbxggen3n?=
 =?us-ascii?Q?rLSroXdZzRdkg1GmzR2GnVdf7s1iF34J7VSFmuLbLY3CCcP04m3y3W+oZA+n?=
 =?us-ascii?Q?BcRBLYpKGb5OShbSpKDhjfRFZMkVDWMp2mkoxDVPR+jZu3jvN3pIfQQq8VXO?=
 =?us-ascii?Q?ZZgrB3KdHhHxm8BiqLewnuX0KQ8rI15W3XKnC4yw7WHUjVkDbfokWzex+nkB?=
 =?us-ascii?Q?3jlpSt/ZIzJ3m75ii353qywiNX0ZMAHZSMNigC0XvUr1OHJQPiMpjkKSOxxJ?=
 =?us-ascii?Q?276h0Ss/lniGw+ps6d/Mmp7fLwxwYgaQ/119pW+acnLmWe2p/gmExQpCA8mH?=
 =?us-ascii?Q?YJDWAlvIugFVzFUhC14n5jFgxcSQC7oq9Jvv2UfDgmpwPQ7OqyhMX+IO7x7V?=
 =?us-ascii?Q?j4RzWHVTBg3SZq6doN5l4U+nSNdWN7A3+lTmiN1bsVP6uulZ5YiQh+UUXudt?=
 =?us-ascii?Q?Vo5wvpS4/EiaxWk9Qjms0JQPKhG9BLVStPpSdbqwl+2/G483V9J5N67po2VN?=
 =?us-ascii?Q?jnm/m/sTtLDUpT0ggJl5W4uKVOONbrMWqoJWQFOxtvIP0eVU2f5AI5lzO50j?=
 =?us-ascii?Q?qJRv+ZuvJije41mqJMJrDQXclgad38rpyCCI1yNJb7qxdx5JRJVUpn6XQ52y?=
 =?us-ascii?Q?hdDPigCYq0CpUYdUk4L1B+WZiIcmSz+kbrSksHJv4h8qBTiMGO+TD2TL0tq7?=
 =?us-ascii?Q?W7Vlq4Y/al2G51QqpRok9Mm1ovJjN/j9G+53++JIiaxuc0882QL5SFxvIjUG?=
 =?us-ascii?Q?j3oHrc75x5mguxy5/QWe99HW3UmvEjQFLuYLXB7mBEg/prdNXxPpxbiLIWCv?=
 =?us-ascii?Q?AOzrAWI5Z5YNYP5sZBLFpRspLpRJ8pj5Fo4/Qb6GP8m3hdXrF070ZrPEaica?=
 =?us-ascii?Q?n5eoqeuXaehyENR156Lqwbg8GdaovkvdDvHYJDAbLgofdhr0n6v9LeLtzJ0t?=
 =?us-ascii?Q?E0GQOLB4Er8/5Rnt8BIvd5E4tOelbkol8lKYmz0+U+gJ9rVhggASVPU2ZMwJ?=
 =?us-ascii?Q?9ZAX8ysySSQhbiV/HenyMNPMOFDCuBz4Fig/HhLLxjsqcX+nrI1UxgzteoiF?=
 =?us-ascii?Q?lpFoAdh1VorsRMCXrJsrDzthS+vXdkpQScjCl5eFlP1shbs00oGOY6HFXkF+?=
 =?us-ascii?Q?3QuwjjyD7gzQVF1pPySvmLNNr89ot5oWxgDBlOfqKfnqTkkDnwEhmVf1NGIy?=
 =?us-ascii?Q?spXjY6Bn6X/MSSHUeLsjpLESqp+3Z4I2SGQF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13955.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pzagJe1gwZGdsO8g1uLbslYcHD8jIBoz3ApCZ8CRnsCi46Q3zb/C4wz+O0YE?=
 =?us-ascii?Q?DRzT3k5FDNS62nJ0IlkWkZ4lEdedkDWD7LTg76v7pmCIQwhyC3rloJorNJJS?=
 =?us-ascii?Q?txujvIIAwt5cRUABStMim/qqAf0AYpjoJtt0HrxGn3y+YNgXeT2ReNUYXM7V?=
 =?us-ascii?Q?uD15b1f2Jt8fc3wxxewLyjgj4WcYKU5AS5xQrXz5j3zD03XN5dbEBpYW6VPW?=
 =?us-ascii?Q?vrkgHkpPr04xI2UM+XlssL3lB0AnVllSMk3pVHPNj1cPrvgR3hOIigEJobOc?=
 =?us-ascii?Q?fcvNx9oWBXJ1QQvlueFyjB5NQvZdw1jihzdkFVHXMcPd+nTRP97an3LJ+W59?=
 =?us-ascii?Q?eKCgOVlj9DiUBXpH7rnAC1irEN7XouZvNpOzt2PfhNLI5KEyRKOd+qeYDyfC?=
 =?us-ascii?Q?UdEOkNJOHdaYW8sgSEusXNnfWKieNMl7O1EXksFEYkbsw+08ntENTI2XQzPB?=
 =?us-ascii?Q?GZYcHynk2GJaJ4VWDxINqLlTqlTIh/iRu40gR2HzFlbptLXViqHNUbSAmKVH?=
 =?us-ascii?Q?rIthzyITFlXVZ+E8a8HdMVI3bJ9SKclb7MJsOsrlPkcfIM24f1rrHdRdj6Wc?=
 =?us-ascii?Q?OLEpOs+2aBcxD8qVsn+IrFkwzsyVkw3DRgv9yweb8rAS20aENcMviUiVF4UY?=
 =?us-ascii?Q?vPgF5+lkuV+iFr/lHrOJgSw90Qhkf1sub8Sd3NkZZAMH87avOoiW22Qweofn?=
 =?us-ascii?Q?Vif7JBjQLczFTa8FnzRpI7wCLn5lPOvTkOzmz4gm+BHzLGJWl22APq6l/BJa?=
 =?us-ascii?Q?Y+E0+ufGZnUFY67EdUaTCLVj/31kxB2/ekoxSC3P9KURM5Qnr3yw7lbyXvUM?=
 =?us-ascii?Q?0dQkcfIQ+ncOYfSrIx+N3sPtzWBnFqUFoyXXUJAF2KvGNKr9/JF7evoQCWTq?=
 =?us-ascii?Q?yv+Oqd5T6VbKakNEBBd8Ibvx7YZLY0IBE+vJn9etRj2yI5XWv+mO3EdVpos9?=
 =?us-ascii?Q?1Qezl5LOV9FNOIHp1l9XMn2nEqeirLBk3P1hVoSIEnpYKZxs7hf+2U24QPwT?=
 =?us-ascii?Q?uAnN5M/8HeKbA20D0Lx08l5y9fsoVL46BTWfFSx/U8WMvwBuuNgx+pfLrASr?=
 =?us-ascii?Q?kHE5Rd2lQWRXdqLiVdX2Kt4r8F52k6rjhX4ioDf3bCKC5efRpSH76AcNtqBp?=
 =?us-ascii?Q?AcZdrv7ku9UY9PEriiM/PREKgzGosYbk4JMT9uPKBiP2qMYn8WEMgFt56zw4?=
 =?us-ascii?Q?+m8JvBbS04l7+OAAf+8n3rU/Q98FrS7cCa+yfZTvh70O9AF1kFV8FVp2seXc?=
 =?us-ascii?Q?scCkYyk+Cm1rHQoZ8dUisA8h02H4WY95Iyg3ohEUaKJHuYDYsA0JUV/d7CU0?=
 =?us-ascii?Q?HnrqnGWxxk5AZHBvIYDxcioDv1HEpU4cbFc9nr310QulQqz17+NG3N5jNifp?=
 =?us-ascii?Q?eAlIku3nDVYtXkvFWJQadN0n84JmC/aY/5c/LEM8it0iTHJgHx9dPQVFVYUc?=
 =?us-ascii?Q?yYj0DR8GGLxCC6dzuxY9WGiUxuCSWgmMui5Gdmlp+qxruzS97bodwIy70zNR?=
 =?us-ascii?Q?j/KMuOcD8OKA6k8339gtVd2T/FNMVnqmFtRcWBcyaFyCUJZI7DBcsix9T8w7?=
 =?us-ascii?Q?PePPHRMZ3tl6XvH/JKUFkNIR8366/VupnAW6lfy0NUPefOwCTK7D5joNZ8d7?=
 =?us-ascii?Q?HH72XnUIdnZ/WYaQFIdc2F2kCp+SDpWJdv4MuDd84Ndf2O65Fxfwufi/4lEK?=
 =?us-ascii?Q?f+0kFqYp8PMkervIn0kOI/N7TOMtWkjCyZs5w7yp5MTdcyG5a8fUZzMJfUDO?=
 =?us-ascii?Q?85aim4WSSrGEQcGjaQA0eqL2tVsgi+zoENTLaiJtn+vv80Rpz4B6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05531a62-6b07-4cb4-a97a-08de42317ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 14:42:21.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/enogxfSiCprQYHWTQ0Treh7oDCMjPMRcF4RMtPDLydwJFU2sZcSdKxJ2P+ungs9i79KHpRUIfTJvca7E66a21rOJn/c6vt0+dKhw3INcLMNbCyc5RHAwn9PZMaOO4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10845

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: Tuesday, December 23, 2025 4:25 PM
>=20
> Hi Cosmin,
>=20
> On Mon, 1 Dec 2025 at 14:44, Cosmin Tanislav
> <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > RZ/T2H (R9A09G077) has three DMA controllers that can be used by
> > peripherals like SPI to offload data transfers from the CPU.
> >
> > Wire up the DMA channels for the SPI peripherals.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> > @@ -200,6 +200,8 @@ rspi0: spi@80007000 {
> >                         clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
> >                                  <&cpg CPG_MOD 104>;
> >                         clock-names =3D "pclk", "pclkspi";
> > +                       dmas =3D <&dmac0 0x267a>, <&dmac0 0x267b>;
> > +                       dma-names =3D "rx", "tx";
>=20
> RZ/T2H does not seem to have restrictions about which DMA controllers
> can be used by which SPI instance.  Hence shouldn't these point to
> all three DMA controllers?

It does seem like there's no restriction about which DMA controller to
use.

>=20
>     dmas =3D <&dmac0 0x267a>, <&dmac0 0x267b>,
>            <&dmac1 0x267a>, <&dmac1 0x267b>,
>            <&dmac2 0x267a>, <&dmac2 0x267b>;
>     dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx";
>=20

I was not aware that the DMA core supports this. I will add the other DMA
controllers to the list.

> Note that this requires updating the DT bindings, as they currently
> restrict dma to two entries.
>=20

dma-names:
  items:
    enum:
      - rx
      - tx

This should work fine, right?

> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

