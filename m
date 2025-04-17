Return-Path: <linux-spi+bounces-7663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D02A92E49
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0314C3B8339
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F02222B5;
	Thu, 17 Apr 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dfQhKUmK"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5C22171B;
	Thu, 17 Apr 2025 23:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932226; cv=fail; b=UMTNax8kFUT4qvgbAiMbn6qWdiNCuti0RgbUPsA2WgJvj8o1JRs5ZbhdIkRZExkSv9pbycjva1VMnO721g6/Jhz4hNHlNN/JPWve/D8CFE1KUlcRq7RBDGmunawt69WNTEyG1Ud2wzKr0lqG4RC11USJpplg0uxvigINmB5s9f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932226; c=relaxed/simple;
	bh=EnwVklwU9AE/MtgF/en38xpg7PiD950v9zH0l5Y4oDg=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=uIdFfrQn4OPVUAlIGOiEP0yi3EXozon0iDHPWzh/NKGZ9O37fsQsUiTkX6XgELhW+x2r2b++rXmlcI9XjfkvUDSSH4gJzEg/2jszG+rH1GLczGgLN5+bZCYaNq/nWZOy9JrO8YKXNdKJNUPD5bzyBRlU8bFvHzMTvzqXiyh0B18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dfQhKUmK; arc=fail smtp.client-ip=52.101.229.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPrrSlqI7Kcs/CSj0cysnq0gWUvDso+/+tYy4/Y8Zn+/AjqV5F/YSRlOfdRAiyvCA35U3tMFueHiFrxxFdMeGDM7/mIxMUVt7RdcNOYDPPMEEn4Ak0wOMByUBdpGZlk9MjJQk8oPapuC5c76WSXCnFNClpcQ7y62tdq19zTCRA3NlQG0oQ0dor0WHklm33qWvzTWnroohRwDTLK8RdFceNk9wKVfTnRcU06pWdwyCVCZ94VlbJ9ophDT7TqfP8yNSZRxwh0mKRIlsg0W+kgyC1wWZ+UDSntRR6ra56bx6trrjvy/6LWTEQdWoju5zKyntT7dGgT+ru/G6uX4oNA1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk0sNmcZHvDCchu1kdobVzQjuzd/LKAgmLquykYKNTc=;
 b=TxQThg4vf1anWndR74CQLIiDKsPEuomeQtGzQ+Kf76i6F6+O0m39YWcXAuSEa6pqxitgeuxH0Z2r+errKj2K2jEZFBSZtt2CDkpfL0dtmWHubBOjrXtO3IJjNfBId+x8tj5FqRlCNnfBFp/42UVDEAcMYnHQjdciFSlID/c+wmaDFC/Xfn+lI9c9A2M2IflFa517+Plmz6SiQ3j7BgVb9aSO4r0YkXbfMADpL1HgLywPDP1PSqautcUVCEPdOJaTz+3fhfmBQyM9q1yG1v+kul3wNIKRTlk0z47xwJi+/BisFJxq6Xxrmhnh6bXmmsaaK7jb5OsjICVOegi7//hFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk0sNmcZHvDCchu1kdobVzQjuzd/LKAgmLquykYKNTc=;
 b=dfQhKUmKobcDvBuxW/AxzG+rD/2v3k/l4jtyBU5mvQdDUcqD9E1nT8T9VMdDBC1OiaAFVnPSj4Xvzry5Oaz6D2lAt3S/0YP8ZxuCn0JkUkr3BBxQ9NPaJS26LsUXqUoqzzq6gw/dkmKE3tDV9GmPGw36G7kowc1VJEhaqpzO/rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:37 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:37 +0000
Message-ID: <87plha2wzr.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 8/9] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:36 +0000
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da96aa8-0c94-4a64-3020-08dd7e06e131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvGPW5LwQiTeY235QNHckdvmMjupKJ4er9I+TrzR5rvtICZyJq0Kswym5ypH?=
 =?us-ascii?Q?uka3fMbTrU3xxHwBJWczY4WXKUo9DfiR7gtCJKgn6vDUUDKgytllJKIdONal?=
 =?us-ascii?Q?UIFGFOj1k4DY79wCPHX4B522/0RtJdQmP+NhVdsdW00wf3ekjJCj8obvuPTF?=
 =?us-ascii?Q?IIlqHOEx4dpCHnpTMiZplmCI49umgTIQrLgUYW4GtkpPU290a5Q/S0ar1GyN?=
 =?us-ascii?Q?7vt5NHr7qPI8CmELoirr6qHvz+vz68bUasP28jNvFxpVIT900cu4+YxKMStu?=
 =?us-ascii?Q?z1zJmhx/kLMjEJhKsNTqdGM1On8XMJz/rM/+sWqO85zGVtuJTX2+EXxqBobF?=
 =?us-ascii?Q?tkM69Nq8cjGFR0OQgu2RoK+zoEv3Mod0BlwkeiWgpE6uDC5RTwh5wMLf4JN4?=
 =?us-ascii?Q?weUpksmcpX2KoF1BukHa7zqwE7EhwLvgYvo/eUXWOgDceHarQf7nIhm7S8g+?=
 =?us-ascii?Q?6ihBteLWAAKW2RzkBLfW7s83y4Ym3bCmLUfMoabuiH2AXZ/kzWdw0tdlqbDA?=
 =?us-ascii?Q?Vu360kZDeAJm8y4oOX5V1lYWs1IymEFP37FGGU6BtWxRPaIu9qNZmbC2opWx?=
 =?us-ascii?Q?tKrCe1FSE+76YUxD6doraUw1Rl+EdQ6ecrUsss45ebzTeCOVtBqcQBe0Bo7d?=
 =?us-ascii?Q?2gi7RHUZ3NeSq0qAYnxSZzEn0Ch5XOZSTnfdMDJNq65kAMO77Mlkd/VdAtsj?=
 =?us-ascii?Q?OVgQHaaSn7EYRVJLX6wiERdc1h0baZds7/k3Lu61HHsr8yXzT1yw0x0sS+VM?=
 =?us-ascii?Q?p5w7E0pgLjd0IUvP22ej8ko3vFXB+7P52m+JJE/CgBtIea0TMx1LLjTamx+p?=
 =?us-ascii?Q?R9FPmljGcBa1mTZycntCh7x5/GTZV0U/SbDlu03nlMt/JnnMtQFvcnnvt8z/?=
 =?us-ascii?Q?PgUVsgePkm92QNZTPypNVXB7Dl05gaGDrsmfGXu6Iz4Tm2sm47p3wFSo89+n?=
 =?us-ascii?Q?pqqJOZfksQHWUZqMUCqphpZzkHxI9EdxJ+LZ2VNY9vtQ3u52eHuEzA4Moxns?=
 =?us-ascii?Q?9dk9L16+xGhp4euFZ5flxgY0ZGo40mJ8n+7w4zY1VXjhOoos7yB+EA1JG/rX?=
 =?us-ascii?Q?H2GMkOSVCAKgk7Zs007u426aFkbNd/GlKsl0+PI8tNjJvkyeFdkCQhc2KxYF?=
 =?us-ascii?Q?MjbIc+G1FoFcV0q39ovqzS0yGimVYkEyZbVxAyrt45CcLc/XODXXpUdiFjI3?=
 =?us-ascii?Q?VUUdJLpSwLcME+CGhkG4RVhGp8noXNcqayXjXzj910fFPF41rcbKq++jNkem?=
 =?us-ascii?Q?/txwZMQSTZOYGizmO1ewf/SB/ndUXRiEXmm+SMtqZ/r0AQYEDMGCRcsxc0tz?=
 =?us-ascii?Q?ppgYc1OCLh2+rjDto7vFTHyyvjR7qQEsjk24iFohbl8wGBqaL3ZF2dX3WQWU?=
 =?us-ascii?Q?hjWCqxdQ/a7sqzBc8SsheuyMc2TYurPuuZXzXgGyq8qwZJGETB6wA/fkA2FC?=
 =?us-ascii?Q?wYa3OvmbNEelHaGIJxX3SpGSWVI3qWqNULlt3w6oUB1yS2F8QH7j5e32wmi6?=
 =?us-ascii?Q?i1xEHfQQDdO2MN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cjnbIAIgqpM0V/BW7cX58VvGwK6JanFrzux+A7wnDa+uUZXLK1wSQNM77ew5?=
 =?us-ascii?Q?IJKGPRdElsgzcUPSXLbGKTpdxuyg0CR+H2k66DwJy6EC+/t7MRKiMSXPlZVO?=
 =?us-ascii?Q?eheT3Hngh8d7y0Otl+5z3gFm5AlsQX7GdFOgR6bUAKnslHFyoQJM1/I80IGj?=
 =?us-ascii?Q?+6BG/1o7mIRhM6qN09cp6OZ5TxV8iyeuDBbuCmMVhkEfmPFfKlWjxy99LOJ0?=
 =?us-ascii?Q?5NeiFPvm6f45mAoHe0OIwZK5WkFKVcOAUckr661PHWnkT2r5yBpjxPoTsvtD?=
 =?us-ascii?Q?yWyV7G1lIDm/7M/hFguZCaaSArSUnhv15L6bte2Gg6YCSSKtnf6YH5HcNCR/?=
 =?us-ascii?Q?AbP0gwn5bOCi8ZUpfYO/AuVbBmRQgUZJDUwFIElvHLGxx0yY+wYogaZqT4KI?=
 =?us-ascii?Q?SK+huZTHtKgluED9F9XLJbjS306KNW8787GCz9091uYnIyYf/aphuUACdILs?=
 =?us-ascii?Q?Jr4LUi7fb8FRk/ezgpm1cGKd9Bb2Ya9fAbFGerIwSaGw/vwi1EKx/oQ7apyN?=
 =?us-ascii?Q?uBdYGuX51yrg+oZ9UydUBv0Dh85fVvAnImQ8CpqUH91CHXTMbNTZcTWyZwy6?=
 =?us-ascii?Q?k5EBSzE3TP1sTV7NdnD8mz7UbdyW2sINJGzUeMOkXqMMsMP0GakrAsRgE2+g?=
 =?us-ascii?Q?edCD1NrGhSGQohtf3geaT+56VoRINULHArfdHlVUarlUZWpqIV00eXYLkfm/?=
 =?us-ascii?Q?MD79dsxrtiWLssBE6V2jPGaxLHz+yw4TUQDmjpOztLnZrZmskbfjjBGWI4t2?=
 =?us-ascii?Q?YjiWv21pFyFN4w0oADA4B0n9Do5wuQJ7Ky8cQSBv1V4A29a1eY7KwtSl/kW0?=
 =?us-ascii?Q?L19l9mUCNVL0aohrH6QNGUkJ0cYGImkLsBkyV8YSIIiVmeDD9hEWU0SmsVZj?=
 =?us-ascii?Q?W6ZJTogqXmQQzicQNiMesav37vq9vm71gxTDjUU+klG9Dq7gf63nELUKyiHj?=
 =?us-ascii?Q?puQLK6WD8ycC7RPDjEtipnIUeGGifYZJnA8RX0Xs38KCs+LixGBC/2riZAjW?=
 =?us-ascii?Q?xAunkmd7UHIHPhqi89ss//pPYUvoF+PZq4LRDuWmjhVCA+QHcw9AS38kN2rO?=
 =?us-ascii?Q?hwVBrqa+MDPm1iotaGaMfQGyIJRWOZqoL9hKbXBGV/IbY4PASGUd+cMDCPFr?=
 =?us-ascii?Q?5DVohjBQEUYbc3Kul2q3LJ35G0HJpusEc4CAvnAXsp86KNasa3z8O7lk+AiJ?=
 =?us-ascii?Q?H891zN26J+66F7BYGIm3F25zvVzcC78r6BOyWk+qgMaSjZkxxjH9VT2Yqj+f?=
 =?us-ascii?Q?SUGNSJ4LbnO5Z0a2LhJtiKBnSlq+6jUvdLi7WIqmdp1XT5EgVnHZn7cCm7FE?=
 =?us-ascii?Q?TdJ2d/nbtNlhLmDlPEGvKglqMcPxsFK46/JvyzmH3EtLWu/y71+W3MvVPrfW?=
 =?us-ascii?Q?qLNL+iv0LdBp4GyK7EcrtR+LZSs97kN/KRqxsDUwciHeTeWogIzoOWMJW4Gk?=
 =?us-ascii?Q?5fKGPXAqPqOPIaUjL2fU5MUs4u0H0PwvUHq8DCw3aOh/k1TXTzaPOR8s0zkQ?=
 =?us-ascii?Q?XhYcPssSPhVudq5nVWVLUkoudGJiJidhPw9zvTmLIsEQ9Y5IvQGWNM1ODE2j?=
 =?us-ascii?Q?yhf7xEz/WW0X240H6DZpq7f+XSADyLtKTH55OoHgttw9CFP+a2dx7xq9JKbM?=
 =?us-ascii?Q?eoy5NKjBEFk1EL0AMjxTOtM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da96aa8-0c94-4a64-3020-08dd7e06e131
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:37.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPNWwzq9ijVwwgeAFfgLfaJkE3Qnq1WheSPGdXHa8jhHwAMiJ0vkdVunVgSUWbKMoOgJddKjP57X6EaiTELXx75Jg6FkKdKBfVaEjwlP5hiRHcNgQWBwN+95ucQylwdK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Sparrow Hawk has Headset (CONN3) AUX_IN (CONN4) for Sound input/output
which is using MSIOF. Support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../dts/renesas/r8a779g3-sparrow-hawk.dts     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index b54d45115a856..0a4a9e1f85a59 100644
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


