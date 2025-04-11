Return-Path: <linux-spi+bounces-7550-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212BA85302
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 07:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BBC9A20C0
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD65F27CB1A;
	Fri, 11 Apr 2025 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DtxoTgt7"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B94C7D;
	Fri, 11 Apr 2025 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744349035; cv=fail; b=enX7b3gRusTBSxDdCAQZoq50FMc5xmvoZARfjVMMk9pyd1c1+RVgEB4sg3bO9bbNyAXP9k/kw/n/1hZSieovF7t4LdAVLzSHLDqfgxDSxZtK382MaqdeThuoBHqgmftct5+mwM2njKkonHsEl7OpMxrMKy3ScGRzYNqe0rG3rRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744349035; c=relaxed/simple;
	bh=dmUPvuzF28QnkkjqvPBIN1ZGH9ZGDm4xClweD6focm8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ewCJrpwI/AQhnZWgl0X5+2ravSefy8j7RDt8qS6yP1GBEbdxAys9GDbioIHKZxIE9q2trqpOBJ18CTJlK5UKlsFAkOzHMCHDaxPJVvKzl7PJjpMmvSl2C70y9dvlJOSEEc6r8VgM8hHdhjFlWm8qaSN/tdqLX3haiYdOYkveNfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DtxoTgt7; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWjHI6i6cx3bro2O3N+pAZk+lmKD1lJeFP6NGyhoCZyPG73edF+0ijMZAK9G8dM7wBNs5O3PFGi7SkPRJ8TWIaW4JmXcGvbXDVbTzKlYilsoiEfvoC6Hk9aWyHsBP5ak9YRd6crLW3X5NWwrHjm6SL6mjRjum4bj18fc5QLFR9GtubYns1CM+PLH0Ky+7B9laWX+vXOILokOIJ+9IwgAKyn7EIXxMjHTzVnUVYhpZ/gpti8A/74G6nBbyGE12wYa4FnhUA6Pjnt+elymwx3fmWBnSFc6JpLIfAvhQG2DQ5rGmuAOVX5dHQufcLwEpRBGXZNfoFOoUxMe0WZGBVL45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOxEyPQrK37Y/QZch/QkyE0GDKlbGdN9CD4QJzU8TMY=;
 b=NYQ67ELMPQH3g9dzb57ax3WpX9t0nknJQoXQOcKglGgMrD1wrQuzwlBY6DtLmVoVJjeFmZUwtPGfJKVuZN7lZoP0fh8cl930el2xBqd2oKU0a8hYK5Pm4MtLDHqH4nwV9ubXC42zXz6yZQFjEMyTzHu0/n3WWpx2UI9MIhuZ3lFz5p5oMl9AefNh8JaGLkx889iysKxdAvOqub+xavNUWR88MBeQIfvtKCoKGUXnTxR+ofni0U4yhmOyXinJ/4we90pIlAxDIFCmusx1hvZ+J9IoVbVK0qMzF4Zep8NrDrNKpioAU/ossArWxgwv0pUhxzY7kw2eamkQiubsC376ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOxEyPQrK37Y/QZch/QkyE0GDKlbGdN9CD4QJzU8TMY=;
 b=DtxoTgt7YeRJiTGRD3/Hqu9av/m16mtslH+MJbl/b2VC/3w54eQRFo439b2a8W6XvYunO3KiaUT6/E+MWJDbvZiw3iZzbWanYTz6R2vpBSe/qHzHWxduvAk1EJujOcPv3tXOUwl6sZDzCxC4omYtlgmylHaNMsC2VQ+rt2O3xM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB8207.jpnprd01.prod.outlook.com
 (2603:1096:400:104::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 05:23:44 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 05:23:44 +0000
Message-ID: <87h62vjmow.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 6/9] ASoC: renesas: add MSIOF sound support
In-Reply-To: <6c859c19-6df3-4663-a655-fa338d08dcea@oracle.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
	<878qo7h5l2.wl-kuninori.morimoto.gx@renesas.com>
	<6c859c19-6df3-4663-a655-fa338d08dcea@oracle.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 05:23:44 +0000
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d9160d-60a9-4e81-100c-08dd78b90758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggMP+LE12wGZ4vqt0gbxZPFgyOphblOeOFbL/PgukeiXN3gEn8Qz1r50cZ4V?=
 =?us-ascii?Q?uvr8IZjh9GMR/ojLs9HZpksAtcZ7Jqfgb4jigAOlYqrQG4sPZhNwEcQrKfPZ?=
 =?us-ascii?Q?a8mn4E2vCXh75patK17qX7N4w/611EfXllZJZHe6V+XVhLHc3NWp4krOF42b?=
 =?us-ascii?Q?9RpRNIzNI8rNgn17cFDMP6L0zrAVK4wxqdEFXhoqvuXCnOV1BLMiWKa8pzVx?=
 =?us-ascii?Q?LMECj6oGmGv0y4D5peEaZ7PnkirkouXebpSpgMV/uZH6NUJrhMT2GQBeAICX?=
 =?us-ascii?Q?4QQrOoC/KGhsdbITBMuwNUpxYCUQ8GbEuFW6NthUpTiq05pQQyLxk3v9ByEw?=
 =?us-ascii?Q?6vaF8276KiRjSifhnkm/2sNuFOasV/Tiyv5tHZBSdU8b8ftmItOgKTEYIcTZ?=
 =?us-ascii?Q?LSHGRLcP2cr/mj1pTZZwrSsHx+EGZ3kwYTsar36I13JKEQFWYqAXmDvlGA0k?=
 =?us-ascii?Q?Z32BkyBy4lMmbroLmpm07WvGV3MdR/LluHXftIhtm3yqWH4Jk/3qn83Y8qna?=
 =?us-ascii?Q?xk4kCB373RRs9syI6hpaIBgAxTFsW00DVcSa18mDWFUanPCpVqy0cqihLZTr?=
 =?us-ascii?Q?2lwKcY5V/tQl3Bj+MLkUxUbR1ZTPOJpu4td8T/lYxh7W+89WORc+5JgPPKj/?=
 =?us-ascii?Q?vp3ttTQCpLTLzdILDlcGw5nOmBGWN94lWzLc/wnPwPxJAxYt2AIJni4y1gGI?=
 =?us-ascii?Q?PSI/rTxSb78mUB5tPpw4G6w/vDvl6GT7XLTUv6pRScD0Vm4ke9Q9992CRAZ3?=
 =?us-ascii?Q?f3LFnWqp5t29tClCLucvD2R7nirJOiom2uG8K50qB2FiSvVE4iVSj0F48V4X?=
 =?us-ascii?Q?adhxHvrK8FqRGOn21z7oJL2F1GJmcmQNDEj0hUpUpci8CkBoJB6N8owO+xJW?=
 =?us-ascii?Q?1G+zGcHIv+/VPeGBTJ4Q7AFi1zy7WSO8cWU6QFm3AThOaO3tjrbXG5KWCasE?=
 =?us-ascii?Q?7QEgKzl5Bz1wxZBrM2KCZqdqjlUx2j43g+Ntuf11hjjNq0LKRHtd369ajZy6?=
 =?us-ascii?Q?s4SvPmfjUs+q/mfg06oQUgbmyz0hPfl38juhGOwQEKcH9YZ/4QhqA+1MzcjK?=
 =?us-ascii?Q?PW9BI6WscVadR3Ca2kawHH+TihJMpXrbtOeRx/GaC2xmu6U9vRM5u8SqtSXM?=
 =?us-ascii?Q?5nLw0Ph3MhSqsu7wjP60kJRVUbSmmg55O6GA5zvim4O/8Myu1BKFMu9lXeDM?=
 =?us-ascii?Q?q2LOIuj7XsOYDpU4GqvsHGw+7tYvgTYyca+L4b+7NLqx9Z4vLXEWwBlWo2Va?=
 =?us-ascii?Q?6MI0SZQuyiFSrBZlWwDjvX5y1cSHORbDy7WFMbVJ5VXTXr4PiNshS0MKJ0Ek?=
 =?us-ascii?Q?x8S2ZhUl7CLdfgiRjBrK/QdjSWopA88lYo4EfevTC3OFs9lDo1foflLislBK?=
 =?us-ascii?Q?n8AB4cl3nQ/S/VSnu1reWlBDRuHagK73QRy+kXil/tiaWKJBLbujxqJJ6giL?=
 =?us-ascii?Q?9+EtySXJ4g4e9fer/yIvs6XX6wBs02tJ/59p8nGDSLDMQfWAG02ExQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRWcv2wYoqbtTb4PWqTjTmxr6UWWjmPgYXhup8SmAy5gRRqGnvnz9Caxf8KC?=
 =?us-ascii?Q?v61Dd9lQum8LcsgqT3zQbjG+C2JZFOhez6EtQF0SulYKj0hyuoyv+KkCHTX9?=
 =?us-ascii?Q?q7H3Hjc0ss2tJiYVaE09/EyFpWZHphMQBlewlOCGqy21SihvKhv5KOUo1Uy/?=
 =?us-ascii?Q?+dlrthSHvJhS7RMlojLazj0CrfSnVNxcZVwPLtKjDSWNvE4jSxfpLv8NEXw1?=
 =?us-ascii?Q?XLwFzMlZ5TQMd8TqDaKMGp5H2OczNVIMgEUEpo6xkOB78az2yPTMKGVz1in4?=
 =?us-ascii?Q?WZXuhj6gawvci1P4I12vqpaqm9cmpIyIztg9Lp9tTXb0ZNdj3X2OqmIoOUy4?=
 =?us-ascii?Q?mUJL8TtlXB0dlH9Yfx62giZhukmUnf/9sEnx9kpl+40D56RL+MeNaaHlytWg?=
 =?us-ascii?Q?T+2N09Vip+CU7ybMVGGqG469gnzXkRNnxEkVccXPWfJp0yWZzVNNQe01WM+v?=
 =?us-ascii?Q?K2wVzYgsRopjKyEC545xDXMXZyiUkydoWAtPE6RkuPjxkTQVDQ+4glJgVwuT?=
 =?us-ascii?Q?DykUj/P8xjCEJYhKKECC+orocKKAw2z/OIMFoQPNrwM4Ie/h60wBBU7sKPUf?=
 =?us-ascii?Q?cReDeDrXYJjn8O2SfKnSRINlyGezJCBaNrSpJ9RZ6oEpP3H/H8ODYTdn/nUq?=
 =?us-ascii?Q?SonkA/glPWLAyA6Q67d6mmX5BtFnwrMlge4ChUsEWJcbzIKDxdPAxYhuFv0L?=
 =?us-ascii?Q?BU1EWA9DXNHh5cJ/mY40ge2U8eXV8IrmIcXlWhuGUtqC3J9+gN7XSRzqCrqP?=
 =?us-ascii?Q?Cf3MQpgufgbYODsd3fBj/wT9X9tZYYj8+ZRfsAgeRJMzwDPQPzF0evyODtQb?=
 =?us-ascii?Q?7wH29IYgEiGmrGuA128ArFix/gQooy4PV4tWS+xn2g32dw3OvO2V1WcSAhWm?=
 =?us-ascii?Q?+5lVR/U/oQZu5RSZXANhjGuKZUtFC6MSktYO6gvkZ6WCohEA68l6zAeXLmda?=
 =?us-ascii?Q?5/OOS63400GiAOMMnfBP+gypQ8y7LRzdP1zBH1cobtIn25zvC5j60SIdS+WF?=
 =?us-ascii?Q?0SfxA6bpcEoGxtWFfn5WXwrb1ZJCm8h4E8z/2+AKqGKWl3ORJSm7SHaUVGtR?=
 =?us-ascii?Q?WvaN+DwQPYPpv7YtQl9PD4AtLCYi71FZv48Us5hS4mCk22EtcBRZjZD4VJ5k?=
 =?us-ascii?Q?9O5PLLjJNcWn+JRvLc59SkfiCi2eFHmlpOuigCEdeJNL210wWAmRjKcoiTlD?=
 =?us-ascii?Q?B8kCZyARv2WGPoVpHMXO8oHRVf1QLUylx812DDt76PqCzdwUStal18ZCWHGX?=
 =?us-ascii?Q?eGbuiciEASOL745BJarxo7esXi2dldpODshLpyK1iruuyV1kaxLx6KOMQluX?=
 =?us-ascii?Q?9yNxpENMdxdmUksNusW8gY2Rgb28ajtOAG7HfYkjJ/e/+2H4lzuPg0E8L7+Q?=
 =?us-ascii?Q?c3kSajGy0nULLeT1ggPdwiDTHVBGU1gomQNsvPM9iW/4dp6gVaVYQAACKI+0?=
 =?us-ascii?Q?R16Cot+zdRGaIaHggfZ56bZafY0Q2JdPf6lACHHkRshLa/oWvre3yUCsKoiM?=
 =?us-ascii?Q?8OWUIo1JbEL9jS/8KVgdf6EtxvpCL7chE25hkPfCP27++vBGbvrecQB+SdK9?=
 =?us-ascii?Q?LnnlBbRI6K6F1PzlAs1tTOyfOKPIvx6CGDQnawbF0NxgVYB98/7ygg/cqT+v?=
 =?us-ascii?Q?u96ara9QwtWL35vnZDmnxHU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d9160d-60a9-4e81-100c-08dd78b90758
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 05:23:44.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7E7Yy4RZzp3d/599IgxBkjs/LwLsN3C74qWqjpRl55cnrJkR4oqvBK4OS24KGQV5B9E0s0EI0zhvF3O2UX92iZaFC56B7YENqD5weq5/F0yFcq9qcAUxJ2CBhi/3dkjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8207


Hi ALOK

> > +/*
> > + * The data on memory in 24bit case is located at <rigth> side
> 
> typo rigth -> right

Oops, thank you for poining it.
Will fix in v3

Thank you for your help !!

Best regards
---
Kuninori Morimoto

