Return-Path: <linux-spi+bounces-5021-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E1988DF8
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 08:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFEC1F21F0E
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 06:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1C1422D4;
	Sat, 28 Sep 2024 06:16:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2099.outbound.protection.outlook.com [40.107.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E9EEAA;
	Sat, 28 Sep 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727504214; cv=fail; b=amPXrG6WrzoOGSBGCmjXcgVzcVG/bMTuqYV0Pgi6ce646uqTAWdfFDhFRTEchtx/AKfQtr9h0rst+tYKHlpbUndYNUv/anXNe9JUZkmUDUyNSK74Zp7unDK55RBAx7wml7JSt0BgtoGM5BsgJ7DOLsilTCUwYWyCNYkFjWciiek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727504214; c=relaxed/simple;
	bh=e0KHZTXOMscB4JBf0hHdX3NuUEcsX5/13DznSCRMdrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mrian7I0Rvur21gUutVnlIgBZEugm6UYEb+0D2YHxgW6unX1MUfvQAGi4n3nnUFOMtb91aUbk36XYQGCd7LPZY/+4Idz3GWee7a/Kh7JPbvJByZZndU5hPq/g/Sc8QakivSavOyS0x2Asqjyu1yc+Mr83nxfc8FDTIgAY2ppvII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8+JtsBEzkUQL0Rna31Dd0SsigJj8yB9U576XUdOQ9jbTDh4vBySUyqV2/KJPsp346R2/xdV8UhNqRhYuGu1q8Fnd/fPIIU31h3OCujenwvvXgN3unYdnKAKNUNdOJff0CLyB2eMU6tSqH2O8AsdBUqKbQnwGpZoVdBxPtCQ1nparqg3Nq2eTqdav93NkveEl4rTij5RYmybuNbfNXeO6JBnYDK8DGHJLZ1F/Ks+E33lX9Csuc9Ua+/tNO5AGESZp8rB9238X1lwSOHhU11oqDk8fCfr+rlfa2vTQbiUwm8/1fKE9bo09qVk9gGCyzENtE+zljS4Qhkg3kCtbX7aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0KHZTXOMscB4JBf0hHdX3NuUEcsX5/13DznSCRMdrM=;
 b=rHAX1ZL62ks6THzOcCHa2KW3dXD2kozM+TGUKDDmsTgLaWMgKL3g9yI/WnkEljw5EjC21H5yyAhExTyKhv1td0BYkK2bVR9AgKauH+7miyvCLkYkxqtZPLECHH8ODdHzyV9KODmn8kl16gvpAsKZ0Kj6pIfOfl4+ZEmmYoktnOMVgw81rEnuHNcvkEym4cTuxn5pTXdECQ9jP1XzXkuZ/OIY4DZYGbTx6617q34/x442efj4WeLUwtpCxi+P48hfTUN5dvpBfce29+TIPJRbOVjSCfmyrdXK0nkHxWLVeRE90cEYsrnAz9KcSIJtIEOMoq62OstV888geWrYSVRsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB0906.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 06:16:49 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 06:16:49 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Frank Li <Frank.li@nxp.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, Han Xu <han.xu@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] spi: spi-imx: Fix casting warnings
Thread-Topic: [PATCH 3/4] spi: spi-imx: Fix casting warnings
Thread-Index: AQHbEOFqOkKSFeOShUeusB18TQXiGbJr2asAgADfT14=
Date: Sat, 28 Sep 2024 06:16:49 +0000
Message-ID:
 <PN0P287MB28435966E53B6BA943340A2AFF742@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
 <20240927132944.19285-3-hardevsinh.palaniya@siliconsignals.io>
 <Zvbi7g+xpI8fGth6@lizhi-Precision-Tower-5810>
In-Reply-To: <Zvbi7g+xpI8fGth6@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN2P287MB0906:EE_
x-ms-office365-filtering-correlation-id: f540b582-f116-4ec2-7ddf-08dcdf85232c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4ztV9EtR3uaSCiurQcpmJ8jLt0aO2j24YEPoFNvNeUqHy52ev5mD7r3fPd?=
 =?iso-8859-1?Q?P8dHeiL14LqV5uprsXYPYgyULKyde6yFo9PRa3C/kg1RioaPvVNuyrm3M+?=
 =?iso-8859-1?Q?l/TfR5+W2hCTfVXzCU4zHiyXUtijGlMqW5iACks3cf3YKFfwyqK9vMIYCf?=
 =?iso-8859-1?Q?3is3Kag6xzEYeKR8csapnuHEN2WcI0likDBJ6yx0lKC3so+xZmcQ3LmOGs?=
 =?iso-8859-1?Q?E655V0J+PwqTEO/oTImg47f4xjGtuAgFLvlFVnSRzPJHsVG1aJ6O6/RphA?=
 =?iso-8859-1?Q?JB7HCmo9n1uZA1v3cE6+2LXE0+lrs8Kz9164vBN6GQBRU4PXtC09OPyjNv?=
 =?iso-8859-1?Q?pJxXyUEsvxaaU97kmR2dxLQVeegCQvBlI+9BlFiosIZvWISd0AMndq7RX/?=
 =?iso-8859-1?Q?rHhpOfkI6FfZ8aB4AhtNwnJg7pbTu2abL+JjWTv+lM495iqQMIxA2O+U6G?=
 =?iso-8859-1?Q?Vi98ASA0JMPcLOAmcGZVdkUHNJ9lt2Hf6d9eFihYEVPuqONahsNYZXW/z6?=
 =?iso-8859-1?Q?CaRcYVpz0nRWrjcPKdrdTD8GfyV1c0zr5JR4dPIH8BRRStZOvKrXNG0aL8?=
 =?iso-8859-1?Q?EelTS2oCcJVtcNHV7S0VNrUUYU/AlU5ItISK7M7pgqr2NfBxGXiMZ69IE2?=
 =?iso-8859-1?Q?vLOdmyeWkOHdrBbJ7rmholyhsjhY9fKXhJK4dufix5c5lADgH3nKUPSvGA?=
 =?iso-8859-1?Q?peVm7EwLDlETHc5FAnxCgkZnwVgppSRtl6iQsq30VW5Fo9u2pp9tPQMdVH?=
 =?iso-8859-1?Q?W3BFivfvgTnNcTtQzGWvwbz8mqvt1qDBb7XbYw5wYdR3Jnqt6hCWmerh/d?=
 =?iso-8859-1?Q?mbMq93dLk2h8zw8JvuK9a4m9fX0JQkZ7isxsTir00kPJFfzr1FTrfkk70G?=
 =?iso-8859-1?Q?XVfjm+3sxqAxZzgeqTsZ5rtXEmke6Rwtu8bo5r6qwSbvB6E7cQfnwqwzeN?=
 =?iso-8859-1?Q?E3GyqzD6BlddYAozAQKVxGYyKD59+l19EUHwPYfjXUlpmPgNAQLlMqd6WL?=
 =?iso-8859-1?Q?uBiTJBynJpy+5zZkf0xqklAQAZk9+1RDE1rApYBpc153R+AOgB6O091Jeb?=
 =?iso-8859-1?Q?4tTFE8AvWYAyw4IpVnkcmOQiYLiZGoecyhNSgcGrRrjVkcIXMSlpzZqQwX?=
 =?iso-8859-1?Q?ABku2Vk+yk3zwZGBrG+s+ITfWxyiHkLWUPtwdbl1XlcjAEIrxCnWJOGavj?=
 =?iso-8859-1?Q?YrC8TB13ZCwb28+QY8FmFTVTKamfefX0GgpZ7CFFAkdvPTlEgrWYRhE5nI?=
 =?iso-8859-1?Q?dl9sVITHvD37eTBlafdYQpt0wHBzFynzMvHvLjwKg0kJA5QglqoGlgLQk/?=
 =?iso-8859-1?Q?cmZKtyOu31vxb8eMi7cQizvAZj2m5WPqF7gqtN1TOq8zs5LLJ+g/tMS5SX?=
 =?iso-8859-1?Q?a9N8bef18UucgkRWJTaecG9VV+jZWEdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DKFPu+oTAV5v/86AnlKxCRbkQzlHUKscTv2cePwEXMqRBPGITzN2PlFelr?=
 =?iso-8859-1?Q?CO9L5aUHWudkJZmFsfkM2RXHfB+8PzEfKV5y4xwEU4gaRuGw+kU/qgJo8T?=
 =?iso-8859-1?Q?n2JY8WBaLGuY5mjZNYg40uVv9YMH+Egd2oSHtm0g0w7NRVZifIvJj1SwzI?=
 =?iso-8859-1?Q?oAeioavQ9wgl7Z/aSTakaz8UzS/bELuPMGDcyT8rA7tAYixx3zOwfDNZCv?=
 =?iso-8859-1?Q?zynRR8euXCqI6fZI9uUMxW7fiPNvlKDyzHFM4np6Eb2WbzJ/2inHB8x6Y3?=
 =?iso-8859-1?Q?9KmeUq13O9t+A4jeQ0pG7C4J/3sFqnQtLZycsU4OHwznADn2N8RGBCYgXw?=
 =?iso-8859-1?Q?kbcFmP52OaV/D640HCkYj+H0vSqeUpWABTgWOdrnjCGWrV3pUgkEhm7o5U?=
 =?iso-8859-1?Q?wBLI9Qi/U69w2q3iaeASJGTUZfeL3xW6A+MxCl86G+fyCIICRa2y6gPGcj?=
 =?iso-8859-1?Q?lDEKMmio1TWQ3aEEjOOM9URkCepj4YMqzsSaqIsBtJPxU6VCxNMxSvQuSO?=
 =?iso-8859-1?Q?7GW0Dj0Q1zQMJ6qjmWHOBtm477XnirV8BhDNOzJLqz+dFLmlPp6oTbLsyp?=
 =?iso-8859-1?Q?K9SS8+OCHF2jS82uxCar631Uywivc+dx+Qv1G0TpOqMq8R8fiJXZkxOJiu?=
 =?iso-8859-1?Q?z+Lu4K5BgG0nFVpp6x0vxRQCI/IfiRwQqBVBoVkRK3Etio0d4JIWisQGhc?=
 =?iso-8859-1?Q?TnDAnvgcO9YwTt+eqd+rSVrZLhp27iyr6hJelX30TrRmBegaKuNsDmzNLC?=
 =?iso-8859-1?Q?RmulxezbTMNHXt7to0d6ko9jmu5E9g3Mzo1Ndging0PohPxT45wLRmjt4c?=
 =?iso-8859-1?Q?aDLiZdAXCYIUZl/PzdZ//gw8sQ4Cr2mQ+297ppmMMHnhxnG+iycFZAB4ZP?=
 =?iso-8859-1?Q?o3jtVVmJt3Oi7tRdnN6Dn9ZnckzNEroNhbdvwUUI2Mw+MezRcbWmm2Hm1X?=
 =?iso-8859-1?Q?Nw3KLWboxo/U6le+S/sdiPuvNhIMhMNzyqzZheF7ZCQmWp6LTN+UVlmvU0?=
 =?iso-8859-1?Q?rBu7xW0NgQDROMSYCC0+7BNuoajTVDOSD3E5VHcXyVGBKiKr8Udbhd3ySL?=
 =?iso-8859-1?Q?3vg0asBOZbTeFCUVkxMROI5ybIbq9Uf1oJa80Wj7Xov4/LpjQCiFrH0+0N?=
 =?iso-8859-1?Q?MAAQLc2mAPkzUfwUGYHIWA7vpOQL2CD2f+2EVU/YtuaIYK0Qifq0OZJHgl?=
 =?iso-8859-1?Q?hfs1kmIOs8NcjFRPGWV8d12MPA9DBxA2XcetXbjkXRJIdLyDgzCvWJttD6?=
 =?iso-8859-1?Q?RFCwmunbvjxSXnsSmToeBqaMPFfVZpp60BzgOfeJPoxOgMfSqec+aeLzbb?=
 =?iso-8859-1?Q?C0xHwXzMLgp/3XeM1hERVQn7D4Pl4Hti5lct9v3Z3N+peiXPewa564wtPD?=
 =?iso-8859-1?Q?X8f+nRbYvVXI+fe3WqG1DBMA4XN3/kTKyOFHaaI8tHsaVvVbcN2skKFtC+?=
 =?iso-8859-1?Q?ROcvdB8K/NUY6f4o1iZZ2hw3//ldi7XEaRQZUjwsMu9g1qwcwFMfgfJS9m?=
 =?iso-8859-1?Q?oD8iOBxUnD2duZ7uZl+x06LxJLZF1gTF89eWruh8zVx0CjbfaE88Q+YaBe?=
 =?iso-8859-1?Q?hWj8Ltu+7hIKddML6F//Cb2dNRQJLO1AAfrOg7AUf5BIg2VelYRjqgMKNV?=
 =?iso-8859-1?Q?yKQgBRX97tZvKiMtj+OGiAdQz/btr3RW0DvlnUuT7fgkO1MjKAwC7PSfCX?=
 =?iso-8859-1?Q?5u9IK8MTJHvCtVRfy3I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f540b582-f116-4ec2-7ddf-08dcdf85232c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2024 06:16:49.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYijzN7YWy1OYMTh0CHXDAgkf7p4p6XqVdv/bmDN6P6KeV0WNQGV0nWEs0kdrkU/803O0TNovNQqIA6zymjOXiCb/XI/6QKEhB/FJZLCzV8oldPuQXQDbX3BtjUut49A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0906

Hi Frank,=0A=
=0A=
Thanks for suggestions=0A=
=0A=
>>=A0 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 u32 val =3D be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDA=
TA));=0A=
>> +=A0=A0=A0=A0 u32 val =3D readl(spi_imx->base + MXC_CSPIRXDATA);=0A=
>=0A=
>be32_to_cpu() is necessary in little endian system. You can't simple remov=
e=0A=
>it. you can use ioread32be=A0here.=0A=
=0A=
I agree , i will update with ioread32be=0A=
=0A=
>>=0A=
>>=A0=A0=A0=A0=A0=A0 if (spi_imx->rx_buf) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int n_bytes =3D spi_imx->targe=
t_burst % sizeof(val);=0A=
>> @@ -436,7 +436,7 @@ static void mx53_ecspi_tx_target(struct spi_imx_data=
 *spi_imx)=0A=
>>=A0=A0=A0=A0=A0=A0 if (spi_imx->tx_buf) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(((u8 *)&val) + sizeof(v=
al) - n_bytes,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi_imx->=
tx_buf, n_bytes);=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D cpu_to_be32(val);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D (__force u32)cpu_to_be32(v=
al);=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi_imx->tx_buf +=3D n_bytes;=
=0A=
>>=A0=A0=A0=A0=A0=A0 }=0A=
>=0A=
>Original code logic is strange, you'd better to remove cpu_to_be32 here.=
=0A=
=0A=
I will remove=A0=0A=
=0A=
>=0A=
>below writel change to iowrite32be().=0A=
=0A=
Sure=A0=0A=
=0A=
>=0A=
>Frank=0A=
=0A=
Best Regards,=0A=
Hardev=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Frank Li <Frank.li@nxp.com>=0A=
Sent:=A0Friday, September 27, 2024 10:23 PM=0A=
To:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
Cc:=A0linux-spi@vger.kernel.org <linux-spi@vger.kernel.org>; olteanv@gmail.=
com <olteanv@gmail.com>; broonie@kernel.org <broonie@kernel.org>; Han Xu <h=
an.xu@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@peng=
utronix.de>; Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam=
 <festevam@gmail.com>; Haibo Chen <haibo.chen@nxp.com>; Yogesh Gaur <yogesh=
gaur.83@gmail.com>; imx@lists.linux.dev <imx@lists.linux.dev>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-arm-kernel@lists.inf=
radead.org <linux-arm-kernel@lists.infradead.org>=0A=
Subject:=A0Re: [PATCH 3/4] spi: spi-imx: Fix casting warnings=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
On Fri, Sep 27, 2024 at 06:58:34PM +0530, Hardevsinh Palaniya wrote:=0A=
> Sparse warnings:=0A=
>=0A=
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32=0A=
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32=0A=
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32=0A=
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32=0A=
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32=0A=
> drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32=0A=
> drivers/spi/spi-imx.c:439:21: warning: incorrect type in assignment (diff=
erent base types)=0A=
> drivers/spi/spi-imx.c:439:21:=A0=A0=A0 expected unsigned int [addressable=
] [usertype] val=0A=
> drivers/spi/spi-imx.c:439:21:=A0=A0=A0 got restricted __be32 [usertype]=
=0A=
>=0A=
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>=0A=
> ---=0A=
>=A0 drivers/spi/spi-imx.c | 4 ++--=0A=
>=A0 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c=0A=
> index 85bd1a82a34e..8d09d9c1c556 100644=0A=
> --- a/drivers/spi/spi-imx.c=0A=
> +++ b/drivers/spi/spi-imx.c=0A=
> @@ -407,7 +407,7 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *=
spi_imx)=0A=
>=0A=
>=A0 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)=0A=
>=A0 {=0A=
> -=A0=A0=A0=A0 u32 val =3D be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDAT=
A));=0A=
> +=A0=A0=A0=A0 u32 val =3D readl(spi_imx->base + MXC_CSPIRXDATA);=0A=
=0A=
be32_to_cpu() is necessary in little endian system. You can't simple remove=
=0A=
it. you can use ioread32be here.=0A=
=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 if (spi_imx->rx_buf) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int n_bytes =3D spi_imx->target=
_burst % sizeof(val);=0A=
> @@ -436,7 +436,7 @@ static void mx53_ecspi_tx_target(struct spi_imx_data =
*spi_imx)=0A=
>=A0=A0=A0=A0=A0=A0 if (spi_imx->tx_buf) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(((u8 *)&val) + sizeof(va=
l) - n_bytes,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi_imx->t=
x_buf, n_bytes);=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D cpu_to_be32(val);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D (__force u32)cpu_to_be32(va=
l);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi_imx->tx_buf +=3D n_bytes;=
=0A=
>=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
Original code logic is strange, you'd better to remove cpu_to_be32 here.=0A=
=0A=
below writel change to iowrite32be().=0A=
=0A=
Frank=0A=
=0A=
>=0A=
> --=0A=
> 2.43.0=0A=
>=

