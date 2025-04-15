Return-Path: <linux-spi+bounces-7587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785DA89167
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CC4178E9C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6BB18DF8D;
	Tue, 15 Apr 2025 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ia+sFseO"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2A1422AB;
	Tue, 15 Apr 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680889; cv=fail; b=DHXjTPzAGs2d2o/3GtkNru/4FdfTTh4eE4dSd1J/2mc9u++cQEoM9THrCT4TCIUYRFLuyE+j88Q/2BlHqowohYEBd9Y0A9Fef2x97zD00vvicIAU+aCJhCo915HZY73pn0HUQvOd6EWS1rkHqwIzPZa8e8yTnHq4G+G5CnIafR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680889; c=relaxed/simple;
	bh=y+N7lH7+G1jLLrzlhbGBlxZEc3YumXvd7Xcd0GQz9Lw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PB47v4uljNU2JEphTLypOsu+dgNGXOZz97eeS3TVs647fTWzbtUXaRVvnNGgFddD1P2xI3sV10XEHGXaF9HJfaqXwHaYhndzh06byVy6HntR9SOYsJL88my3gW25+mBwJr1YYLZ5ilWzgggp9vNhbTZYJpmtO2GMdMrTXQIQ9Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ia+sFseO; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzmRJ2eAZkqNpyhlpXnp4nXxgyEDsBo29GSJJdeWvC+dcPHQstH66PY3m7e/0ZOZ2sSvHm8wyeyNcXrGYtUM3U8i+X3/MRAxyaObXtDIc549gmJdBL3KcHVixR5T/razzJZmRKFFqw1vkmbqEzGlVhOjSelHZeXVyfOKbiBUJEeTvdhd0SsTH0A8GYZDqCLLBoMvYnzTh22YRivptjzpy/1KE8vWuZjnpBT+BiHO9JtofRoy+e+VYuKfy9udFs6xpvZRDNbWmTpXmm1nrTkP3uXFjc+lXAekxOS46MOopn6/CE2qOheYAtPxLn7UcPraluVEO4+pED6qc2o+FoGquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u/JvugkOUZttkGE2186WKeTwPwDY+rSpw353/7s2to=;
 b=BfO5N1gWdML8XVOUhkjl4S+WoY9KPkA/TsZClYXLVWDoBG3cciVrvm4AWdOKgGsqIGjS7vPd+WeLa5o8lcUTD6wTMJNaHjAsEaVXr5XFlPrS0G9Rxti8lyL7iSmNdo0FzcgHl4sFL3L7dQatutNP6kQ2YdYWn7rMoLHpTGCtA27+ijPn/25YX4v91OZmGxZSru5ckLTdhv6gNXWZ7BtCaQk4rY+Dfg2fQ6D/zmmMQ9p2yIUJ4r4DU75Y6/WnQX1aUI0X5xXv7O3kLHCWc1IABelOXssO0XjC1Gx8rZsaxXD69rlf50cI8pMrEcGqePiw75FDtLvfzhRdnfDX/vLGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u/JvugkOUZttkGE2186WKeTwPwDY+rSpw353/7s2to=;
 b=ia+sFseOj1gX5nbzGhp/IjfewmKfsl0P9+l4+Jca+pJbKpkdDMFnbbLXb4TN2+6eMx6vAvp8rkw4R23El3ImZQFnsLM6FzCU/V2tR1veAVa3l5nc6Py0d9dgnhD56PqLpczqJV8csFREoof7P5I8v7sTRto22fQgI8mspAkWMNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by OS3PR01MB7336.jpnprd01.prod.outlook.com
 (2603:1096:604:14a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 01:34:40 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:40 +0000
Message-ID: <87msci1a34.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 09/10] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:34:40 +0000
X-ClientProxiedBy: TYAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:15::27) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|OS3PR01MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e5d33d-2f5d-49c9-bff8-08dd7bbdb0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s3MYXSEn6zGspVA1WM9+UoxFYxmlvOAOV2XUXIoqppZSaN3S2C7of4dz1l7S?=
 =?us-ascii?Q?F+6RHIoC6QJ5keee3yhpPLqGnVlW/wgUHzvno/Wi/GFjLwT7OSpaiej/nwra?=
 =?us-ascii?Q?ZIXWLq9aIsMZAYGxqHj4vnYC0bo+TG9qUWD+DUOhzSCyFjTBVE0he1L2N2X4?=
 =?us-ascii?Q?19NRYo88zW3mzgnvazJtHiJCjivDj7o7hkGKjHPCRF9Hjn22aBzfENY+bAY6?=
 =?us-ascii?Q?xyw+o/3yPcm5zguFGP5jPiZWcNuppowiBqrxVVCjMN0bGFFtLQ3EzWqrU4H7?=
 =?us-ascii?Q?FokEGSZBy0LBWOp8GtYHOs3kKRw1GE6q2k2pUxyKMGRxzt+QU0WADd5kazWZ?=
 =?us-ascii?Q?HbR9QCA5ySJGKdt1UkQs9wAhYvcadMokw/3MdJcaJjz/m+HymSodBVPNaB0x?=
 =?us-ascii?Q?LSa2n3h50v4/fYH6lHIuo+syBtTPybOteKqeqRLDUgc8YUMjkzIW5tX7EUjg?=
 =?us-ascii?Q?6MBsbr6DrIq+Qq+QX6wtuInqLSLtFbof4tEXbeiXtkoizWXrIoGgjcRri8YH?=
 =?us-ascii?Q?XaGSiJsz3eRVVBQWROWeBi6BCtqkoiXamvEgwWuB5Cw1ewJfJ1LxBw53Pacx?=
 =?us-ascii?Q?Avp4Y53aQw+v9X17Me2eRP4DO4BArjQj+uBmZNGJznTEZRkmQ8YWofy84LQO?=
 =?us-ascii?Q?8DFsUHjPFlO97yU0tMkj1Seao2WMMNxn6Zm0n+Ac4ujOCNtCs7PoWRPCJMa1?=
 =?us-ascii?Q?N8EPy/oHZwDVeKSUd1+Wtu1dk05rMw7G4oCSYN0cry/dbeV3jDQgyE1Hji3v?=
 =?us-ascii?Q?AfNNbJgo/HuorPFsMlY9qxjibk3aSRr4rwADNk4LCZTJ8wUgLzDcgsa/i6YG?=
 =?us-ascii?Q?+NV6CYgArmSQZRrCZWaYroVbNGVv7HKAhnd1HgMxwmHPjl2eAbeMigwmzOA4?=
 =?us-ascii?Q?mv31vK+k9+47PhTBYmiB2mdyZJWIFV7oUmo0HZEeUYV8sRo7+tMj0kjG5W5M?=
 =?us-ascii?Q?9aSOZzQ37kQA/lcVcd6BPSMUug8SbbnDKwuu2r0ulrBXYPHdN+Kep0sonXbC?=
 =?us-ascii?Q?MP7BL1HI1fJ4aVkhLRpQtXJhprp/eDPlb6JRtn9QVfd0BFIzgcnpznPW1nln?=
 =?us-ascii?Q?5HbGI14qgxxNeVjzZqpV8ufdvcntetDGDsnGCAQyLTUkWIT2W4VxTLy0sB14?=
 =?us-ascii?Q?3qHsDBJaiEPTrMyW9QLf5UU5pZLvUg3zQHJbVNFqtP64O2OrfgVMLjOFMqee?=
 =?us-ascii?Q?OaFlrhnGGI3Z23hQUmQwErWpwFVHzO2cidP7PNRaV1TOONpUKD/0l2iM61wT?=
 =?us-ascii?Q?GoLM0ADHl9lGEsz1NlRpsFy1ngC4hKNc/S3VDFaH+BJNM2D6K/XvFBKq2AyO?=
 =?us-ascii?Q?UJjaOzX5wkAEVC27dJWLiegz4mukqvwLnnNn/9R6Cc+8uOQ0hUHPIl2ZlDoq?=
 =?us-ascii?Q?l45vanEyvmNurqOvAgwC8fI6doLhyTrPxbm21NlWLooQ6D3nmN3zBtcSUgG+?=
 =?us-ascii?Q?ZFBl2BTup+zqYbJ3UiHEphT8KC5P6z9yaPeDVMtnXt1BE0CS0x8bvua0QTO3?=
 =?us-ascii?Q?/CmQa+8TrX+EGVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UdeK/ppeXSFJeASMottcHYdqeaCTb3xI0PqDEs0gI2rDMSpH9BGaKSB6z4mV?=
 =?us-ascii?Q?sis7N5KEUwEcDf31z+8vE49/6aJV1qOmccrauilCxELI9pLbfBtPIM248RTj?=
 =?us-ascii?Q?1OWZ+Og6sHbAdbhHyrhX9hUQtYFdTqwzJ8He+xrqo0w1KJBl3tfsKsXtXXvw?=
 =?us-ascii?Q?rzLYn359vxrzqkw+c0IvKjK2OZt96xMjJWGC/0w6azQe7fj8yuzSp7vmpHHL?=
 =?us-ascii?Q?mMtAgqvhX3cn9s6onXN2/HuSn2Bmh5rmQDXSGLyduZDdVD9xZbsvwysElpNE?=
 =?us-ascii?Q?xKymegq/auBiWat963fMfzmqofZDCJS2VMveU8DamslYF7HwdUKHXQHp+/Gk?=
 =?us-ascii?Q?nFipy5XJxatqB7r4WZfbsop/ADNYl2MKmwJI+txIWB33ru1xhMmrVy3eE1Gi?=
 =?us-ascii?Q?jbw0d48Z6FQwafiNDxINaOmN/+EzCIukdjcGixNRK0woLd6h4Ww18CNjBs1C?=
 =?us-ascii?Q?dbtjzCJj7WTI8LCXohzpGn+YPp9uQdYXZLFuVu8vSTX0flyZ2IaS3ZCks9Cr?=
 =?us-ascii?Q?puMrOFKHIvIICF29L8ZZ5BireInT34oqhxB+n8b8TVv6J910B5fU13ivQ7p2?=
 =?us-ascii?Q?6oMHmk8OSROF2IHKUa7Dn0deBWJZbh/F7V4vkZE2AGOM+79J7XNzMKQR+xGn?=
 =?us-ascii?Q?ZiDwjikZxJQ1kMxCRh2irllBBY+GdBIBN7C8H/HEL4yj+FeM5h2NAkaIue2y?=
 =?us-ascii?Q?8q+veW7m/z3/+RXqdPUj+oH68XqIGqYHV+sU9hxDLxG5hZznpXKv5Cr1N6GG?=
 =?us-ascii?Q?54vfZ+NBCHwkifzewlddeEgdnnHpYdLXtNisHvIXFEU9jL1+38tj992oY+Be?=
 =?us-ascii?Q?3BjE6Jvbi0xKacUzZncc/L0wxDg8mdDOVwUq2jQMGGFCaoM8QtLkW8CUqh2Z?=
 =?us-ascii?Q?O8OLTNPBBlMeIvDLPN78hlhQ3c9t9jfJ5vBFQLAerjtX2pCE1dbPMlAi0VLr?=
 =?us-ascii?Q?dK4NkJImDKjE/hO/KWDp9uE24cpSmuFFhaW5jW7eYvww7iYui5pS99CIb0kY?=
 =?us-ascii?Q?5UMy/g2UcDRJoExRVYlcBVJmB2QvpGyXurT8xOAKF04w4rA8evsTvEacQUY9?=
 =?us-ascii?Q?YVMJVVY4m9QNZfOv6RjSR/h3kI0cOfelJPmWRzGNJeYs5pAz96U68Lur4mWk?=
 =?us-ascii?Q?xd3YDXPJZpbft0+afpNMfujAoxo9aADsYIEXbFsLibx30gK6jvy/qmDzvY0x?=
 =?us-ascii?Q?s2eUBmujLKKJALfSiCjmQ/DNpZ+ipWI8lVZLitJDuuacXslSY6A3wgtFMJx9?=
 =?us-ascii?Q?nrL1g/h93jviZM7ckFjovMXofRVAXW6kk9/+6gF+IaEiwGKlKVuB2dZaCabH?=
 =?us-ascii?Q?SFHDjY27zggzR6qvvjO6qlM6CwQQ/vftU6bc7HPaiOJig873iIW8mc3P/VpA?=
 =?us-ascii?Q?W90Wl2u3zZcf2qMOlltkIQJDFSfpl1ukkFR8reNwP+HbasL9RHC736fcjKZQ?=
 =?us-ascii?Q?qf+vvIDX3uTtkbTyK8LYteVWH71ZcjvUrNtiKoMveKeKEQCqcFBTaO8L43e7?=
 =?us-ascii?Q?r5Vt/vMEpdbVQVpdQxvR20xtiD3eSF1elHHVy6znjiQIWO3Dcb0T/mrhNEF4?=
 =?us-ascii?Q?HhGYzZ6sTSbeVYJDcJUhY9mQ8lj176tdPvg/Xu8XOXEAE1re0wUvNwu5TuV0?=
 =?us-ascii?Q?eCPg43H40Upm+przLGaHMG0=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e5d33d-2f5d-49c9-bff8-08dd7bbdb0cd
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:40.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmMmq7KX3S3tNaKPoWbmtih26xqVYfAv4cLpvPpz5O+SElTi3t2RzBrDL72hCcpFqnU8AIGu6nR/ZnQFcFeEHmXWz4cVnJinnmX988rjc4YyjDGvbxLacwsf+orUGW3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7336

Sparrow Hawk has Headset (CONN3) AUX_IN (CONN4) for Sound input/output
which is using MSIOF. Support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index b54d45115a85..0a4a9e1f85a5 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -4,6 +4,29 @@
  *
  * Copyright (C) 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
+/*
+ * DA7212 Codec settings
+ *
+ * for Playback
+ *	> amixer set "Headphone" 40%
+ *	> amixer set "Headphone" on
+ *	> amixer set "Mixout Left DAC Left"  on
+ *	> amixer set "Mixout Right DAC Right" on
+ *
+ * for Capture (Aux/Mic)
+ *	> amixer set "Aux" on
+ *	> amixer set "Aux" 80%
+ *	> amixer set "Mixin PGA" on
+ *	> amixer set "Mixin PGA" 50%
+ *	> amixer set "ADC" on
+ *	> amixer set "ADC" 80%
+ *	> amixer set "Mixin Left Aux Left" on
+ *	> amixer set "Mixin Right Aux Right" on
+ *	> amixer set "Mic 1" on
+ *	> amixer set "Mic 1" 80%
+ *	> amixer set "Mixin Left Mic 1" on
+ *	> amixer set "Mixin Right Mic 1" on
+ */
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
@@ -150,6 +173,12 @@ vcc_sdhi: regulator-vcc-sdhi {
 		gpios-states = <1>;
 		states = <3300000 0>, <1800000 1>;
 	};
+
+	/* Page 30 / Audio_Codec */
+	sound_card: sound {
+		compatible = "audio-graph-card2";
+		links = <&msiof1_snd>;
+	};
 };
 
 /* Page 22 / Ether_AVB0 */
@@ -341,6 +370,29 @@ i2c0_mux1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			/* Page 30 / Audio_Codec */
+			codec@1a {
+				compatible = "dlg,da7212";
+
+				#sound-dai-cells = <0>;
+				reg = <0x1a>;
+
+				clocks = <&rcar_sound>;
+				clock-names = "mclk";
+
+				VDDA-supply   = <&reg_1p8v>;
+				VDDMIC-supply = <&reg_3p3v>;
+				VDDIO-supply  = <&reg_3p3v>;
+
+				port {
+					da7212_endpoint: endpoint {
+						bitclock-master;
+						frame-master;
+						remote-endpoint = <&msiof1_snd_endpoint>;
+					};
+				};
+			};
 		};
 
 		i2c0_mux2: i2c@2 {
@@ -603,6 +655,52 @@ sd_uhs_pins: sd-uhs {
 		function = "mmc";
 		power-source = <1800>;
 	};
+
+	/* Page 30 / Audio_Codec */
+	msiof1_pins: sound {
+		groups = "msiof1_clk", "msiof1_sync", "msiof1_txd", "msiof1_rxd";
+		function = "msiof1";
+	};
+
+	/* Page 30 / Audio_Codec */
+	sound_clk_pins: sound-clk {
+		groups = "audio_clkin", "audio_clkout";
+		function = "audio_clk";
+	};
+};
+
+&audio_clkin {
+	clock-frequency = <24576000>;
+};
+
+/* Page 30 / Audio_Codec */
+&rcar_sound {
+	pinctrl-0 = <&sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* It is used for ADG output as DA7212_MCLK */
+
+	/* audio_clkout */
+	clock-frequency = <12288000>; /* 48 kHz groups */
+
+	status = "okay";
+};
+
+&msiof1 {
+	pinctrl-0 = <&msiof1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* ignore DT warning */
+	/delete-property/#address-cells;
+	/delete-property/#size-cells;
+
+	msiof1_snd: port {
+		msiof1_snd_endpoint: endpoint {
+			remote-endpoint = <&da7212_endpoint>;
+		};
+	};
 };
 
 /* Page 31 / FAN */
-- 
2.43.0


