Return-Path: <linux-spi+bounces-7471-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B10A81A4B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E69884ABB
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947D14901B;
	Wed,  9 Apr 2025 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ig5qgCWZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010063.outbound.protection.outlook.com [52.101.229.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05729A2;
	Wed,  9 Apr 2025 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160740; cv=fail; b=WFxb0KsRLCxfy718WgymIJtZGWlKgQOs2Dcu5ekbrHBfOz10Qb6yj8p2UgggztBj1aqblib2qay53n5jKTnmiSwRvGNfeZ/xCwsRpRzFLFDqf1PUVGpKi5dr9ou8xibvL0KWei3MOsxhUIb/mgRsXdeiD9gYyxiBohWKzwD8oXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160740; c=relaxed/simple;
	bh=HkMwrYxWDsiky3tt0l9jNXlJNbF0DIC6zbmf4kFvVLY=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ov5oe7P/+Luq4PXaDmQWAUtCZyUhH7S8IbECVb1YTRRMmdXEMhc88xzbETbvjEnEu+jOUg9KTPH2o5//alasZ5ESB5UbIfANBYtn3SMTjRK2ZGM2fLtXHwMo5Ru/VCGi+4v9HI7jRKo34XHNpYWrjlKHYf5iISGPW4dE2MxGgXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ig5qgCWZ; arc=fail smtp.client-ip=52.101.229.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fn6itGPdrcL7I5lkygXImkjDmWE5TdpSmQO5vxJ5nbARECIyin7cglAkMUQdW5SmjHPS2lEYnXsUtBb3Hjh2BwoUw6CjwM9mpDqORNani481sTHD8AfvycerswdH6v6wdWgoDTnfCgLvh5KjDQkARjZQw6wHFAMiGyfh9Evs/sFLQ1qKN9jA7th67X8YjJyRPWAdu85MJUri8NMizKSJjDD1NeETLbc37ehONf1DZ0D4Naubg7ZLsRva9vRgHhyK+pDDDSOZfU4EmSlcq9M6y8kxdCkbVPju0ZTLQP05MdLCk1IFDJGAURO8WAlbIZOuzjLVRGZE2auDXYhI2DUAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtNDLxtDEB7g4fp3SUHO5RsnCljySzmUOXbCN3J4q9s=;
 b=fITfLqb/+WGYuIZmGM/40BEeL6OjsZMUq5xR+aO0hqCK53RyzLcCMQRyRxNDMqCRxbXkqT2NqGjuyfR7TXYyPFavcffmysjKVX2l+GCKmSPTM4TOBhhBzAqFH7r57SSC+3zDJF9mWZru29lNHEaHJq2V1aVHKdyU7qKjZYXREqBOlAOS3DOx4inBrKyRbA4ujubu93u4JPmEPzlA3Qv15iD9Leg1xSbIW+F5uzD88z8JVQe+J2WfVaS9fiKme1f6mAwYUIbeMcm0JBA8jWt0W67Nl8GWkgMz/9l8Qu0Mh6Efn2ywYTw5D11r1e5rNy+Ny65s1Oc3PvN1kPjqqPRpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtNDLxtDEB7g4fp3SUHO5RsnCljySzmUOXbCN3J4q9s=;
 b=ig5qgCWZYQrMcFP3d3ztAD2vsbO5uckSLc3EQKV5m2Q6lkW+n4MT9B3KhN26JeEftW10+DcG69UNHOQUnwwJcz3Be4mMkvCRaQK0wObAgeSlKt/M4SxrcrzwZCX8Xoah+CAQDd/0++P/nHMBeJ6fnC13UjYGVuPOVA3pPIXPo20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS7PR01MB14942.jpnprd01.prod.outlook.com
 (2603:1096:604:395::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Wed, 9 Apr
 2025 01:05:32 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:32 +0000
Message-ID: <87v7re9mar.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 7/7] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:05:32 +0000
X-ClientProxiedBy: TYWPR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS7PR01MB14942:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b50b39-5e96-456c-ce7c-08dd7702a0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dlvoLhT4x1C8qjEiabMnYLVKBqLB1GaVQDTdGkfvErqkHpyejn3dsyWRxjQV?=
 =?us-ascii?Q?55w2IeP2mybpXGJdZoIFs8GDQJislm7enSwBsBILCjjp/pUzTkpqCDq7VQRu?=
 =?us-ascii?Q?E+5YuYrBAvKfrqxbFQUWZ0JIC7QKIndg1OLG6srSZCjdi9KFnUOkeyqB7zGB?=
 =?us-ascii?Q?4M96teVjyI4Wc0OtR6BHzloA5mEMJNkYfQuhwXTGDCu4Tm93A9N04gsPp0k7?=
 =?us-ascii?Q?wFia0PBjHIHouQp6fj8Qi0wco2woMJud14qX/SGAgVRov63xsI9GHD/Tm276?=
 =?us-ascii?Q?UvlsPR+E1fswFBKFHPdTcXCtcBIqpZ8OWqFa6CVFatyVk1v1Ubo/9yWWqb8A?=
 =?us-ascii?Q?MTa/MmpZ0ne/jf7WrYQ2GPL54sI7G9c3PsGnJ7X3FCytpQiMk7j9q8N3uMHC?=
 =?us-ascii?Q?guTA2fth6K7AxNzuos/lD23w17Eqtpr4zodl8S1Lo0ByldaA+3ToWdY9yvXw?=
 =?us-ascii?Q?qm7JhLCfzXzMgaW6L9r0J0nDMYmV0Ucx4hEJjYsdhcc5BqthVBVNAQkEDV5P?=
 =?us-ascii?Q?KFk7iZGXxXPHMWcyb3a2ZXH/vFC5SJr48C+Yo+VBLbFxya+yu4I1w32bh7Tl?=
 =?us-ascii?Q?88vZdvihXahzBEfFrn++IE/w99CS4Lz8/hTkqTbd+amGri6BuBqCwW8jWbvj?=
 =?us-ascii?Q?GvXp0J4R+1CFNcQHmAMQzvDlGlxPGOF2Bv6sIdDCkE48YXYDQetaI/fNuPM6?=
 =?us-ascii?Q?0aPTwhZRPghKuUziBhNEmpuOx4EmDypydMaV/WJYWVS+Vjxd5dwlACnnRjAO?=
 =?us-ascii?Q?XpsPM20IFj0UHRbI4xBmwP6K/dt5fyWT6gYdbg6oF4upf+yY+zSkv/7OGFdg?=
 =?us-ascii?Q?F+xB1bwd+y6XwbQF5KBBw3ee+kQeQCDPiUBztdUfigvwqJgsEeHynVWO9xL0?=
 =?us-ascii?Q?oJ9xuBxxqReFqfvifxH2BZga5i6nQM1pDSiFAevpWv4xsHRcnjBSaSFBGHYG?=
 =?us-ascii?Q?dYo1Kdfc+Q0lQp4luLFbu7PTk8Zxur4mZJSzDQNEDz1LXkqU+vBW4x10CDM+?=
 =?us-ascii?Q?Sjns9HAt6TcHV0/zE2+Ao0LNgeU+4hWwxNrmXSbJDlY0GDwGBHtCPbvgkfds?=
 =?us-ascii?Q?ZNJouWxbM0MaznvqqRwp9WX6tV8J20fOoUWRiqYbmiVuKMU11pbcwdyFEXEQ?=
 =?us-ascii?Q?7loNkPvMhNTxM+63HchD7r8J2ZZuzUGGNRpLohANoCUmnayaPlUpA1KeD0yb?=
 =?us-ascii?Q?5/YebcAHmHWbBTtZtHQKIQ9U2OUw8Kg7NTlTE50zmkb50PU7u5nqTQF8KxPh?=
 =?us-ascii?Q?ye/kD3GPcjqPx5uhcRINwUQSN7DKyg+LLbRHmllXX5cCyjtgYezQyajOu9T5?=
 =?us-ascii?Q?eHZDxr6fPEiKT3gC29mKq5OKNPWhFEK8mPUgJ76kt72HmhxfZcs5jDI/d53f?=
 =?us-ascii?Q?6Vd59CtWKEorWKRZag6aKn9ilSO3HUDq/5ktV0eJBagu4RKHeNpwq7IGL3W4?=
 =?us-ascii?Q?KiqEOBgmhVNSnbZdw3K08L6VyGz5HD9GJ6Wt6XiVjR5WlMwtqlvVBdcxNYP+?=
 =?us-ascii?Q?Db8zMmL+cZYGeZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2w2//PYWr1OPRRavlTnOk2lMyQwNRW9XNN+++9n3WeI+cwr7b3w1tIXxYt6G?=
 =?us-ascii?Q?woJOIXt5z8FdYLrt00PXCg3hkBQM3aDw88JMxyscvrkiHIrvtLcSMG1Ni8vE?=
 =?us-ascii?Q?lj9WcRgXSWcrlqbvg40BtYmovYAUo2wWyF0rxXlFlE/RQwgK/M/EzQACJtrr?=
 =?us-ascii?Q?y7GmpgR3Rt4IERHTiyf6SzvzAzjEb2JXtIJ2Yg0ne8I+oPKZ94DpGso3DFoF?=
 =?us-ascii?Q?LrhaYfj0r4BbSoa3ooOZU3wlY2CzmBzkHIBDyPD1NPqBPHfRWAj0eYD7jEtz?=
 =?us-ascii?Q?axjbJIR1MoQBOy40oXy0FXXIaAFpK9Y+xU5N6SYFK2HPoAa+igtaRFQNrLd7?=
 =?us-ascii?Q?NWmDXNm1efQOLOBcr/+Z/5WZoozcCfIgg+muQ/keczVfQgRGWUYVexD1UPkb?=
 =?us-ascii?Q?ZQucUy7TSBem/24W4klnuBSnozmOFLzmf3WHXnNiaXL7nKZzLUEXwaNAjGtD?=
 =?us-ascii?Q?XAXUILUoSLw5IU91LKrwIDgQMTRzDq7TA4HYrHgZi1BV3t301D+8EnTiA6yT?=
 =?us-ascii?Q?DiF5zbGmnMQUfzPDKeWt/tKgF3VoUTszchQiWOKebRxQSUsN4d6Rw+l50JZ1?=
 =?us-ascii?Q?bKA0dSpBDIUGhQOanlGyqvfUOFv/0ntm2AabrJmGhGnKhNgpC5jW3Xuy2nY9?=
 =?us-ascii?Q?0nNBHL2XHOWFgU8VyRUdqKg1AnatUs34hdqoF0MCbeL+16bl3myfuUTW0zj9?=
 =?us-ascii?Q?wI8lw/nY61mvOuVKqb889M2UPJWtBhPE17JfIVz84s4VsXIphAbmHLpi+MB1?=
 =?us-ascii?Q?IBEgLKROgc7ZWA4hCGkToxbBTko6e3gMju3gYaT6cdmwgE4rB46iQe2OHi9I?=
 =?us-ascii?Q?xASGYCIBhnAukAKYjuWvlrfjKZ8Oyivl8rlybfAsoICrT3c8/Ro1sNFPEF95?=
 =?us-ascii?Q?OSf9ZBuR8vBh11QA1tOBDEnzYlAjv2h/NmLxSW0faBSWtvdJJcTtJe4b09hA?=
 =?us-ascii?Q?JG49EBLOwpiam96s5SfVf0oHWaXabFThpVA8t/4Vvg1G3s82LJaO9pllJl68?=
 =?us-ascii?Q?9wNg7zgpW1pmmJxHz4YkhHKfeAvc8J8mEg87iMU5MtEpAtN9ddOQARy2/aZX?=
 =?us-ascii?Q?d5R4ZeC6xwLFIBFyn1MoMv7crbKShEXTq6Bbjq7wi4Cy1W3+p8Bt8SAs8GE/?=
 =?us-ascii?Q?K4rrbG9t1uhkJlg+/EXnmcrOaO4j2iugu0FTqNJARGZRHSz2F23A9QHMO4LB?=
 =?us-ascii?Q?TWa/dOZmnLi1/CEo393l6GmrWJk5I86xeByrZA7EMaNE8TDDXcJicRXAGw53?=
 =?us-ascii?Q?Xz7I+ih256HZ/sCuKNuszZdi+DAONyj5DpapzIvKt/0fd7P918ekTRAvHDxq?=
 =?us-ascii?Q?DrujQiQoo+XZBS1Aa5ntPbR7z49m3lrvsMkKPQ2jsS4TUId9yrLHWZDUkdn8?=
 =?us-ascii?Q?X0InDA+x7fDiLAkpOSZKTfWEwjLb6JK3W5K1bs9801R+IOGXZPHEuR/din3D?=
 =?us-ascii?Q?2PVYGrEEu+2qvDOyT8xwyBW+zVvY3/PPXZc7Lti58zr+YE7flRg1aR/YDe6x?=
 =?us-ascii?Q?vmc8lOR3/UKbM1nqMOWu51908o29OgVApDUkLkeOjnwibiP5ja6liGH749QJ?=
 =?us-ascii?Q?ma2aFOp/GyutnEc5EI8oR2D1JVysdTJzTREc2FasnyGskovk19Xws2gWhFdG?=
 =?us-ascii?Q?xukdOF925XIpnpDKo8f2wYU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b50b39-5e96-456c-ce7c-08dd7702a0a8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:32.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvwbVhcCJDUXKyWMV/qAT4RBB8W4Vphhbxqt/w1w7XdNgUcCrpvKLVOyu81VSOby7pjaDBR42lWsYP7dS1WU3uIX71J8gzcmh+zKlrTejbfr83VKx6jmN+31KkAH7SjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14942

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


