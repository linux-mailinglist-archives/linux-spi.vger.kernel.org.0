Return-Path: <linux-spi+bounces-7630-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C26A91143
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 03:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA623AFC5C
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E5184E;
	Thu, 17 Apr 2025 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ajMyDPla"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15E1B6CFE;
	Thu, 17 Apr 2025 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853979; cv=fail; b=RceecU0ZCsiRDYi8aznFoOX7jPPlfWRGQaT2EoZNQarTtc6nBtMVUL1JbtGqiEdekj+McVWbyxh1vJ7EGbDYLqwhlJQtHMHYhrADDG4qIOfj98fJDpllSXI1v4BOLzW+aul3HN2V2RZUaLrd/Ompm+g/agQuIlnasIT6MP+ob0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853979; c=relaxed/simple;
	bh=AYnwjDwae2+3TV9XXXQqLVrLAR28kMuBzZSS7jHLJUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uuTRGqBATpEDQPjVGI8nhjBbafoGkOJhwE3Vv1pS5MIQeazTz09+cPr72jLvrATWe4X6chJFYkgB4ZD3majHeKLn/vlLh6ajHU7flYi0JvzoFgIRXZk4ZOiwuWRSr62kh4gS5NjBMSrckMysanu4LstKIgisIKkW6t5Uj6Vnlyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ajMyDPla; arc=fail smtp.client-ip=40.107.247.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIsVQM3020mjfIoS3RgAnOyAUVafDRcuvuQ4MLoW6aoJFZcwdqOZVnd85Lp9FneFoMBs0BFO2AgW1pjY8FpYFRVL5LJVXS4KyX+s8dar1gsVLyXDnwA8XwJPfohwl7ICvg5fPk1FBE1J64p0NnN/Sqwb4pszlOfxZSIbYJc2fX3FiUmeTGei7AV615rKLitHO0BIHL6bqglzajiyHAJFEdrK6igQ3hIdwDOC7WrIAH/IUC03/ZI7ScfV4DNadB/oj+Q96plJbOdNLnqK3J+LVC4s1NKvBdAL54pMYHv+y8BzEQAlUCk2MvT1Uo293rriCtCzHm4Wa3x0eQ9yvUP/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDFjGIl1LIiMjWtafzFDKpMegYkeHYtaw9vkQ0OHLa0=;
 b=BCL/W8czEWMg83NhVd+T54zLBI/jOcByiWCD4MgqH51kXIUMjL5WPCFCspp1iXd9xn7ZDpryNB69yhpyEukmOF/nty67C8CtLxP3+tFeqkN3SAJ8JeYKEMo/ajzZWDo2aSSrU8yvxtBQh/eH7P8p0fZWEawc+A4mj9XBEPsjpyJ1I4mrwMqnK6JQ2C4nTe3u2hiP2w7yN6+oGVhzFrYkCPRMXp5rWjc3tIdOYYLSoDRx2a00ZpkH9cpmuxN32Rd6MtFkBgK84QmrSIdlurAzK2GQTEZ9brjLwJs34iYhiVlmAQjgkW5hfT02/7VAuFDDs+fY8/8A6tloi136VCt2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDFjGIl1LIiMjWtafzFDKpMegYkeHYtaw9vkQ0OHLa0=;
 b=ajMyDPlarGGvA6Py7WhgyUst8vmK/KFF1xmf9WuxPDN/5+h5jN5Ggg7IQzGhTYhcuL9nwsOyWfzNuMDf5qttNwhLpyvqrm902I5PxOiPHcqMyK54czWuZfF7Hk/z7phegeSnfEPdOtjSgsCm1PI5shzO3dRhPLajBeMrnGAuesE96xqg1Jyj4oEoA4Wn2khfUhWbEHF5gBrKn0MYjHFzXkGYHCmXu0breohv/LkN0DmEaD9Ws4Pb3TFFmvdAwS35pHyqcE1g3b5VNxAVr+p7MmddYg58C82Dt+zIp44RitXqrD8hkYSIv8UxI/8yITBAdFgevdtgH4BCh3+Cs7K5yA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 01:39:34 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%7]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 01:39:33 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Tamura Dai <kirinode0@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] spi: spi-imx: Add check for spi_imx_setupxfer()
Thread-Topic: [EXT] [PATCH] spi: spi-imx: Add check for spi_imx_setupxfer()
Thread-Index: AQHbrzaEaYg1Jc+Hk0CsR8JmDd2KBrOnFBTQ
Date: Thu, 17 Apr 2025 01:39:33 +0000
Message-ID:
 <VI2PR04MB111477C8C199A1110FF0BBCB6E8BC2@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20250417011700.14436-1-kirinode0@gmail.com>
In-Reply-To: <20250417011700.14436-1-kirinode0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|AS8PR04MB9126:EE_
x-ms-office365-filtering-correlation-id: 325ec7e2-fbaa-42b6-9370-08dd7d50b4ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DvdwvXsRUBvrwvqGS70eykj1eapkidNfil2Yj/k0p0YI2GbOeRkF6KtTIo1j?=
 =?us-ascii?Q?BZdpbuEuXBaacu0o6/oQClyBfnvqO8PUoDYKaKEi7OlzXe6HEePZRTBQbxIA?=
 =?us-ascii?Q?0G7uZfjpfmh/6G6UcMOZxCf4W26rrmDL03v5S13xwySyvsCQriU4ACRdC6YT?=
 =?us-ascii?Q?OhlCLReeAn1rKmVnhDZxaEOYLnp/QR5P4qejCzXt8/8I+dQGFugrw0qrHaRY?=
 =?us-ascii?Q?sMCPzVmQ9qDDOgWmaCfeThG1h7WhAzsIwW1R+tL0xY8z7wTLHEzwOX1BG55G?=
 =?us-ascii?Q?2GI2O8zAJbd1Ep7mTP5weAgIlG4f2U0oc2hSO7x9N4fd7RmrcUynfG6Kmv+P?=
 =?us-ascii?Q?vF+mMK1fNq+onD7UAKJKwFsEi78d5tjE7r/PzUHE9eEQFxKC2Y5D+vHzxx7P?=
 =?us-ascii?Q?dlcjR0mhS5ZjHh6WnzZWfTf7VLlIzpjEOBGFEK4vUkPv2JP8Sg9Cfgeo9QdN?=
 =?us-ascii?Q?g6kob+qXEu2MD03442s4WR/s2rA9MnE68iodoWyuy0tRLnvnN8c3NtV5RSjt?=
 =?us-ascii?Q?W3jCA7GCK0s0rVzd2dZIlbxJpzNiPw9BpSWPEeUOFlNZ7Z/9jaR9kWBOdJIN?=
 =?us-ascii?Q?41/5/yEsiCrR36Y1mgg4hf1Ip84Bvx03DLFfhNO1bnXoZdw3W1QSNB00Cpy2?=
 =?us-ascii?Q?3VtM+Gz9Oze2RWdM67vGuGjP6LidOVtJCfjRleGOMcXKfKhlMfDVrgv7q9iY?=
 =?us-ascii?Q?1mRaUTGPNdI2PCqxEs4ZHnbGEVETyxWNgXh97N0I8T6KpIG/Am8VPm6bOLOV?=
 =?us-ascii?Q?Sk/tGIMtY8nJoIlSzPX9GmGneETsCgzEvW2KnSGBWKWloTncNhqUAfkgnTfE?=
 =?us-ascii?Q?UfFg4hnn3aQRNnmKvWErW5OZZlUH3Fc3ngBC8cUrY8XIs7E0fKixPGiXdBi2?=
 =?us-ascii?Q?ccOOugukl/vOixCXhs2LF+imyV5lsliThufI6ZYUsdbW3OvRci10JfbbT3KP?=
 =?us-ascii?Q?0POSHzjAzZRX3+MDX/EfPfGai+v7f9hIw3WhhqS/mnvCW0fshAvZ3TlQAhqe?=
 =?us-ascii?Q?Ng5mE0xPaSDf4KvwiAFZoTphZDnh6p1JJOkNouvMkyHfp1jER+reS61RtIej?=
 =?us-ascii?Q?cVEpaX1et6meSdt/NZdYw6Mp0DSaw97Mud6B3JcaIuvdvpdDd+RXY5a1tyky?=
 =?us-ascii?Q?B2y0QWyIUIam+VKJoLaNcJirMPLjxaxQ44K/MWInc/QtZPJdLC1QQ5dgj5bB?=
 =?us-ascii?Q?kJ2xEMftBnqb0QVz5NdXu5I9zFBZMNijkSvqNE7QoVyXn+sLRAJyyZgctR4Y?=
 =?us-ascii?Q?WfkoAXYV/6pEA5+g64sXub7HmJ/EhJ7UMUhxNWBzwSWnPALh39LO/seNRssV?=
 =?us-ascii?Q?9vDuWYtMLFn5IgBN7PFEO9lHAQ8LZJWN0Aaf7UD1JJ3rLnGVxDyWlbUMi3fb?=
 =?us-ascii?Q?NV3oVg1JlVz6rVYuHGCbruqROLaOf4YHDCdbN4NyJRzWnshB5g0tQagr17IQ?=
 =?us-ascii?Q?9mkbFzgt17jbfShU2x7XMkGX96qMxud8Ufm0MxBpNNHlo3avtOGo6Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u8c6yHCvnbYi7VVLubCZz3y4vDFb0uCUbmzPQOk45+JzJMMHRPaPcDUZE5b8?=
 =?us-ascii?Q?JXYeUI+/Bm9Wb876GNt+20vARE9c9hVfIE16lqWftSuR8kd0WL3XGOCjk9I4?=
 =?us-ascii?Q?Nn8NJhKlj7PwPpg9FyEe+jyErpMMJa4eH/GuYC9gi/ioa0dYQaGGiP1n7Li3?=
 =?us-ascii?Q?JSMpXYo07AKHDT3gUoublORGud+0j316Ui/4qSslpRJ+P16L5xa+3SphUae5?=
 =?us-ascii?Q?B+CmaVKCrXi1NJTVq9yQYYKccUfrKcllExg6MZftfkxTE3FjXVTIX878eJih?=
 =?us-ascii?Q?0nRjctTI1lvyg70hJd8BZ9aJG9CTM2dLksAX6/RNBEur9sUfclYtHUnosrsF?=
 =?us-ascii?Q?UhSH8qybJEwJHp3baRijEC7CRj3tN58d3YEhrE4OEnZklmVHWK1T3Tx6Vsus?=
 =?us-ascii?Q?UDFcXmrUZKE/EMLm+hiHADWgvVS/oAZv5ZhOV/GXqTmSZO6ORyeIi+H93pcP?=
 =?us-ascii?Q?Bk6yLl/6JOvUWbYuXftsF6SkoJv1AxbduZk+wOb+uOQAOfVxKseSNB7t1C+k?=
 =?us-ascii?Q?sJch85LqWABHnXgz9k7aqWNWMmv9vu7XCVh1GprSx7wdLn2ZlA15P9eur03X?=
 =?us-ascii?Q?tKYPgLhkft6CKFqppeE69RHydt/ze8YKWuT4fJVAnUDxShs+bSrvp3jQPirC?=
 =?us-ascii?Q?ncFR7mUVq5HDh2O+4hAflZjSF3qefl85UbFkIH/jJ7r68xkbSqRSkTuvsOif?=
 =?us-ascii?Q?sbXEz0FYhAmvqBH2rNbpLUxAJQFfus6L739/tPK+NJ26ylHfrW4HYAQyzxbi?=
 =?us-ascii?Q?CceU0w/9iLy9rBLttz4VHTKhcIemI8ncd+H31iqg7yaLS0i2ihVktkqoIcvA?=
 =?us-ascii?Q?jQgmK6vyrJjLl1xeM70DyPcSU5rfp1ogJR0dV0wFQmAfDWIKDv5N4Pv3slfw?=
 =?us-ascii?Q?3HT+RllqyVoAQb4alVGuNmrw9VtXltlTE9J/r4UeqT+EYgEt1XOSG9XcMBp8?=
 =?us-ascii?Q?Q9zkcFtgHUqAj3oA0JvAZc749KfJtN/fMqu/1wiPiJ8zRvhXzi6ZVh1uLO9B?=
 =?us-ascii?Q?vvvhYMgr3gnisb7dQ4q3HEbAVxBQ93qu1T5QWsRMCLj+7Siyv2MLoQoxjcZZ?=
 =?us-ascii?Q?3vLjPYfICFfRIHx5S6yIC3P4FJaooLc+pafVX7y3WsAA1MXUd+vcBZw6XcEF?=
 =?us-ascii?Q?ehUO2KPb8y6cz/1xeqjyoididn2reysy8pUygs1IDGOjpLe/oY7JoYlpWT6z?=
 =?us-ascii?Q?8Sd2GmuXDr3XMjjIMwJi62vYM/tQ7dK0oAwBbzQMlFkxTNhRUQGG4DwisnGZ?=
 =?us-ascii?Q?ft/FwYATwkcy6lbCapYDqFImQ7YtAT6PDlZhZT+dBaBlCzwmpZYh35O/rnyt?=
 =?us-ascii?Q?Ze7v6flqTHi1cG7HB/FUzZEr3hQEksI+FI7jQEmWsTZnazQ/sSbi8QyNvRBg?=
 =?us-ascii?Q?co8CDS6Y0YRPHY5RcacqKV0SkvulKDuIMS8Qk83VfEInSpRrtCrnN4TI6fgu?=
 =?us-ascii?Q?GYxHCeErEkYQge6QCfVvAM2nx4r+jbXzRsbAfnZSmMK7K3lCXlDuWCMjVQ9L?=
 =?us-ascii?Q?cTbOWQClwQlgQzee4+3xc9dDpPOAd4gIWj1/h1PwXeCDGbT/D1D7i8UVedyT?=
 =?us-ascii?Q?bDQ35I/MY4g0aIZsBGI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 325ec7e2-fbaa-42b6-9370-08dd7d50b4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 01:39:33.8096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDlTuuwQpXLPbMs+GIYXvRtoPlmZn2d/rOLRyReazb6Crk7YWXTsMsF+EwH3DrcaYLg3tAH/Q9DSayV4PlSgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126


Hi, Thank you for fix.

Reviewed-by: Carlos Song <carlos.song@nxp.com>

> -----Original Message-----
> From: Tamura Dai <kirinode0@gmail.com>
> Sent: Thursday, April 17, 2025 9:16 AM
> To: Mark Brown <broonie@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>
> Cc: linux-spi@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Tamur=
a Dai
> <kirinode0@gmail.com>
> Subject: [EXT] [PATCH] spi: spi-imx: Add check for spi_imx_setupxfer()
>=20
> [You don't often get email from kirinode0@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Add check for the return value of spi_imx_setupxfer().
> spi_imx->rx and spi_imx->tx function pointer can be NULL when
> spi_imx_setupxfer() return error, and make NULL pointer dereference.
>=20
>  Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000  Call trace:
>   0x0
>   spi_imx_pio_transfer+0x50/0xd8
>   spi_imx_transfer_one+0x18c/0x858
>   spi_transfer_one_message+0x43c/0x790
>   __spi_pump_transfer_message+0x238/0x5d4
>   __spi_sync+0x2b0/0x454
>   spi_write_then_read+0x11c/0x200
>=20
> Signed-off-by: Tamura Dai <kirinode0@gmail.com>
> ---
>  drivers/spi/spi-imx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> 832d6e9009eb..c93d80a4d734 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1695,9 +1695,12 @@ static int spi_imx_transfer_one(struct
> spi_controller *controller,
>                                 struct spi_device *spi,
>                                 struct spi_transfer *transfer)  {
> +       int ret;
>         struct spi_imx_data *spi_imx =3D
> spi_controller_get_devdata(spi->controller);
>=20
> -       spi_imx_setupxfer(spi, transfer);
> +       ret =3D spi_imx_setupxfer(spi, transfer);
> +       if (ret < 0)
> +               return ret;
>         transfer->effective_speed_hz =3D spi_imx->spi_bus_clk;
>=20
>         /* flush rxfifo before transfer */
> --
> 2.47.2
>=20


