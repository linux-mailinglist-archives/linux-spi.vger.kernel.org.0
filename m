Return-Path: <linux-spi+bounces-7662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FFA92E47
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299C91B6462D
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112E2222C1;
	Thu, 17 Apr 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TVUcXyiE"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010048.outbound.protection.outlook.com [52.101.228.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5B204583;
	Thu, 17 Apr 2025 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932221; cv=fail; b=hVhRjziFPLULW4hAaq1pls4v7c7ysuh+deNyTRFf2OcZ8HOc0gLwD5YxeimKoLnetS2NsJkp4Vn7I2Zq/qs4zW7rPX7TAvP5ISOjH6yK/nc6dfCZFA0bnWtk7P34ftTLoExlGOkSBCPlNhpIXB/YVaLFPjJZRT72Bv1EjZbWhU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932221; c=relaxed/simple;
	bh=tXkfVnSVjGLPMNd7ZTMoyyOZPTl+N3Dvll7MbLzvk20=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Cn3CY4BiKfllUIaPgc11oohY+uX295Np4OSFJ47ibruQOoQBjGm9py1JgdLQuaYvJIvz5lSL/kVFwV8MhAW5+OfdX+oEh2XUmH5AxA8cEyCYnT6m3qEgbgGyRXNDoQLJZfWJ33q2c4iNTOy9RsTgaOANJkU7m0IQnMOAih6RSPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TVUcXyiE; arc=fail smtp.client-ip=52.101.228.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2vqkPmMzoJ+wT/kW1CSAeuShwrzcUP8xsdP+R3iEIYj/lrzTVzKDqniTb74VfCjRunKD4WBx+ZWJzzmH6SdAgd7b2eio9YArlbUhtquOT3C2mnqtviN3UGLMVfWketvzEGAcmArmwNVHJ+a7D/8WqliMaByB6qa/KKm5d8ql3OWuzweg65b4CTxYCi8GZMoJU34KXS6zDW1ud6VTVPSgy5JTfppxUAAXkgurRgmQzbcB26HO4pNMuXt869YmZUQVq0Wjglc3TQk/airDBUhkgzn93mkzUtdN1JwsAwbU9vaI/bd0a74hdAVe5/jxicYm5xFMD83kQsSrQ1sY0QtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84OcguPbbBpDgrLNWtdJnNO5FeEMj9V/4XpPcDdR6fU=;
 b=neHQFPASlIY14HkshaRecbN/Bg3edalucXPzZ4gnW/Q/RJb9BVzUvyxoMZhtEoMCcrtlw5bhiGjazP2cWUntlwovAOm5Qo68FKUFfpCinLngtC+0kxNzPQG030gAfXrpWQp6P2uGoEB9dO6Ab8agaxU69h4/Vfk7bxRFx6kwF1C/KPRkH51yybTmV6YQYkfxVlAgDAhh0XmN1pUSEWtgElcGiiXnRyXcFmEGGdJInbBEhPns18jk4rJOTjo3skYD+wMpKNx+vGgkLtmJDdiXG2+hYFaQUUOqrfYOdQBZ2H4oKPUaMDkuVY/S0+Z4gmQRnZGpazLOiafMw8KmfXuDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84OcguPbbBpDgrLNWtdJnNO5FeEMj9V/4XpPcDdR6fU=;
 b=TVUcXyiEVC6FqMvR3+tS2YIVqENdHS3i7nytWu+b5U6fK9P31sr3Q/9h57J6WivI+Tv+a2tfBKDdWJ2uimWo3PRFgfwA+3pqNzxdVqIkwUipClNEoJXtddykFrLW4jI0xI1JMEUPoqXSJNhAjDjvFsVa6rRre+lLyz4anpE0tU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:32 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:32 +0000
Message-ID: <87r01q2wzv.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 7/9] ASoC: renesas: add MSIOF sound support
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:32 +0000
X-ClientProxiedBy: TY2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:404:42::26) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c5c0b1-4426-47b5-9bfd-08dd7e06de96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tF/WtbZo7yzzi0ICZCB7xCSG3U9Ruw3SJ/GknrsMNZFUImaeFm/v6md1GCe1?=
 =?us-ascii?Q?pFLyTTX8ZpGDfPBX0Lk1Oa87PIGiNW+KsAZLftq7/zRqPJwIW7u2DkoBwNIT?=
 =?us-ascii?Q?y0nVshOl3FXcq/GW3ZeAJqxIqbb6/4CeLcfH4lINwkWYw5s6U8r+K61Op1BW?=
 =?us-ascii?Q?FJMTdbW97H4Mlvcxu5ToTVcFrgcI5xjMDXNQ56LpjHOvmC/QTnhDikvcvicw?=
 =?us-ascii?Q?FwBPOQrTeFEutaFIFaWuzpVCAKs5DED/FN/g/9xdWPjhRFzpY/RTC9d6nwT8?=
 =?us-ascii?Q?MbNnHKxdPp6EO+wDZwfNgqdtSOK2hh4caULWQB40ChoJUxKtBvSh9KShhE9E?=
 =?us-ascii?Q?2DMsTENqE0az4rsCxDHCZR28HJTXM/2Eecv5JtLurGL3gnyOiY0yCVf3FR0m?=
 =?us-ascii?Q?g4v2ZPfqyDyE0DUO96H4sEG0g7J7Z09pyw6SKlXpsPTZhvq49SF3stcZnJa4?=
 =?us-ascii?Q?zFzpSWiYKL7DuflmdQfRJVl9HWEtL878xG/TCvzpgkhJUt88KVCP9udlVjGA?=
 =?us-ascii?Q?RxrgwhLFNs4x3ih/knIY+ax56XcDlmkkGxfb/E8MWPv6MISxrJNP1F2B5Ktn?=
 =?us-ascii?Q?7AHfG54Kcj3toavcRBov1NZM3Qxs6D309+gL8h9KBYvRV+cXYjuQxX5EIEHs?=
 =?us-ascii?Q?gvVT/Z5lP67cfE2ul8KFuxI/JGkchWJLGDitzfflTlALsupjU26lcsKRa04c?=
 =?us-ascii?Q?YIqn8pR2z7lzZLJE+beT/w7Huv8GxlxY2c+ByLKD1LHzIg1BpOzVuQmtvhuo?=
 =?us-ascii?Q?hK0AaJffhavcXvOs+WZrXdpef0MtdAj5QycRJwbefByG7J1vfDhtCh3Ykvi0?=
 =?us-ascii?Q?PNkYH+ROw9TVxErnT1wui5aXoaqVYHIpQj8DXEoGs5kZ777yO813oYeUBh+5?=
 =?us-ascii?Q?lwdZTCEQtVLEdRYPCxMSVl0cxNPycd8Ghs4TJ/HRYRDnjpwVXkyqK0vTLWzy?=
 =?us-ascii?Q?WULOoh9EHIHtb5EJxxwuST0rqR2AQSfNu0osAfrbMOvBGS2OkOzhBs36aiXu?=
 =?us-ascii?Q?M+4C/+Sh/n9Abuuueg6Dq1C60/QkiRw2lzQ7RuwQEZ/HVlAWTdZGU+JmsDTj?=
 =?us-ascii?Q?V+a6XDJrarF1BS+jqnQxBRe0+jSl+emVTLvM6GYfNHxSKUPLeDSZ8wCj9Im9?=
 =?us-ascii?Q?M6xd/53kN5aXDKAaT4SBvJ9a31TDYFpsfWCuRseP6/9r6GcWfmz78Zax/Zoc?=
 =?us-ascii?Q?HxWfUT06WrxlsM/taF0UKFR8OVt7fXZyc+/pYcoKT0EibM5va5eyLE7Y3G2h?=
 =?us-ascii?Q?oyV0HoOKS4Mq1duiyZFBwp2zdsd8rrVtNR6+EJ+kTYU1facKnssV9DPfQGSc?=
 =?us-ascii?Q?o/tPX7QBEOZkQ9purYTKNWt+5lkWcU2qOLx0Velv4dTd/XerhsvUCuJFmuEf?=
 =?us-ascii?Q?MvvAGXM9KtPn7ByKZ9n3PA9tHRkMl4JV9tvgxso69bDDrQqylw0Osg6hgGnP?=
 =?us-ascii?Q?ulL3ADvKlgF3C/AefItiK9oqOVpQZvMzV3K4H3mzyJJa0/YgU+l71reFq/IT?=
 =?us-ascii?Q?u54SYS5JSCznYbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyXHpa6kOkgIbvD9+sv5RCYjBkDBo0AZhyT6z78D2Y82kW/GcZF45Zj40lv7?=
 =?us-ascii?Q?0ia9QrcHavZRuzRF4EjpEautdUKkPt2ElpjZ3hnl19zY45Admg8Ey1ejuu/X?=
 =?us-ascii?Q?zAXcl6s+Z+3YTUkKS0C5R7BkYvazKHGoopG7mh58kgdj9a7UFmv51hp1ySl8?=
 =?us-ascii?Q?Kly+CMGgTNodY3kRAjJg1j9FBCUcuGizB6uMI8OHxREDVV9mJFhda8eCy0r0?=
 =?us-ascii?Q?5xvtcX2iIo6V5fMAiqacSR2S+gEu5u3NvofQxliRQfE9k0PpJ4gKiMnAftQO?=
 =?us-ascii?Q?JxPr3QkNwTcm9iPzYRK0GEBVdHPAiG616L5Cgyvcu2F0QmrXSrT1c8KQXN11?=
 =?us-ascii?Q?keF8/uZa2cPhFVa9437Ck1l0D5BPAHaN0yERFHUnLof4clRNNeeze4dO4l2y?=
 =?us-ascii?Q?nSsMGZlV4k6NY5vU0v0B/EqFYIPnUJz1dQUv+MvV0lIpYHq3mQyrNXRkAWgF?=
 =?us-ascii?Q?Q9H3+9zG1q3DpA3fSEV0qXeX1o85J7hlgI+pOwJu6Spyyx6gUM+jRnDrLmRQ?=
 =?us-ascii?Q?nqwiAci5hfklcR5OY0ukdUopkZZwvpEGeFYxGvH1uKjvGR6fIxKyK1m/XJPZ?=
 =?us-ascii?Q?NilItoyujtLvPvP0BO3M4mXYvlCFXc3UHWc3KDvwuJbSeTm2HY587pEEIP0m?=
 =?us-ascii?Q?8aXoiRJoi7n6kCjZYB8wXKKDPbJEqsIoDb9H0iDdtJPQ9cXRnvWJNZvNRe7S?=
 =?us-ascii?Q?FysFHAnQ1GnPd2cp4l/pAhU1vz7Gz4YY8Vnx8g2L/p02knTmof1AAGG4quDY?=
 =?us-ascii?Q?T1AdgBtm2RzE4fvtUYpRkIr+YbGGWhZW4/qUbvkt6joveLbUh1MpLTAgF47F?=
 =?us-ascii?Q?ixnCoPRQfBskGM8hzgy4t5Ft4o9pjjs9XXsmeTNKuu/oJkg+32QVoIJJxRzF?=
 =?us-ascii?Q?c4cpMpdfNXg+xN20Rr1MfGkAkvyNF1jcQRouZ0dMkOp2nx1M6bTJjk8eTODo?=
 =?us-ascii?Q?pbtzHjzPJ8copNal2BnOHYfyx+yNIX2737pREEhiv1xQsMzoPu8l5vO19Qyj?=
 =?us-ascii?Q?OsLsuErS11i6vckL7ht69UUE3AW4i+Y+j6Ac6Im6juHiWy/l9LGUUH3Ql3Ir?=
 =?us-ascii?Q?aijIBmU0zw2Pii4vjojJQP/4BRbIf+H7lwySiM2TkI2fOTfKjMqiieL0O5ZO?=
 =?us-ascii?Q?5DiiTsnzKyoQxAekEegHLiiYKHG3WVV+KXioEFw8Cf/rE8pMehhK4hfmUUsG?=
 =?us-ascii?Q?lBSakrhG+++CVvUZCtLQaqp6cQduN4rqcecyEnzFjKkuTAjSap2QkY0SuL9N?=
 =?us-ascii?Q?bJFYnJDCU44e2WrL2+c/tHmxuf7eiAGLetda6wQjLfXweFP2TJ9/s/yEivmU?=
 =?us-ascii?Q?Tc9s3dIEmBLMCoQH/+33Hp59M+xlciHfbn9HnnBYJeLnQxP2iTkAfdXUJfpL?=
 =?us-ascii?Q?bSvZZEaDgMZ9JH72QQzVzzjRGKMLDWdffcqe0wEDLzA4l9QiaSRzEO6QQv0H?=
 =?us-ascii?Q?i7K+zcgSlitNJJFB1DxymNMgMXC7u1GM0Gscq8jUYwExUzfOjgR8bzKOlufM?=
 =?us-ascii?Q?ERt3iJX2OQkrsiMfUXri4GD/G5tvFYH/FXCI6H831H+ANpOk0jUbeJgWZ7a0?=
 =?us-ascii?Q?tLG5BHmno//pI9HrvI4t4m6KNwECpRRKUbhzX9OMQhA3zHMWoqh9xY1/qm8R?=
 =?us-ascii?Q?iIBRBlqQ6u0TuW05Sb+fyFQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5c0b1-4426-47b5-9bfd-08dd7e06de96
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:32.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bF5nnxNsaPcmgUt4kDCpBlZfgQ6ywObmkAtRYTtAi7MgIrKL4DTqLnXhQjvn/18CJ5qJrIKD8mbxO5hnXQf09rKbCQAw2LLHiHeNEODIGP5CqOdSUN5zRtHjDDhKXWY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. Adds MSIOF-I2S driver.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/renesas/Kconfig       |   7 +
 sound/soc/renesas/rcar/Makefile |   3 +
 sound/soc/renesas/rcar/msiof.c  | 566 ++++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)
 create mode 100644 sound/soc/renesas/rcar/msiof.c

diff --git a/sound/soc/renesas/Kconfig b/sound/soc/renesas/Kconfig
index cb01fb36355f0..dabf02a955ca1 100644
--- a/sound/soc/renesas/Kconfig
+++ b/sound/soc/renesas/Kconfig
@@ -46,6 +46,13 @@ config SND_SOC_RCAR
 	help
 	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
 
+config SND_SOC_MSIOF
+	tristate "R-Car series MSIOF support"
+	depends on OF
+	select SND_DMAENGINE_PCM
+	help
+	  This option enables R-Car MSIOF sound support
+
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/sound/soc/renesas/rcar/Makefile b/sound/soc/renesas/rcar/Makefile
index 45eb875a912a6..3a2c875595bd8 100644
--- a/sound/soc/renesas/rcar/Makefile
+++ b/sound/soc/renesas/rcar/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-soc-rcar-y		:= core.o gen.o dma.o adg.o ssi.o ssiu.o src.o ctu.o mix.o dvc.o cmd.o debugfs.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
+
+snd-soc-msiof-y			:= msiof.o
+obj-$(CONFIG_SND_SOC_MSIOF)	+= snd-soc-msiof.o
diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
new file mode 100644
index 0000000000000..75c9e91bada10
--- /dev/null
+++ b/sound/soc/renesas/rcar/msiof.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car MSIOF (Clock-Synchronized Serial Interface with FIFO) I2S driver
+//
+// Copyright (C) 2025 Renesas Solutions Corp.
+// Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+
+/*
+ * [NOTE]
+ *
+ * This driver doesn't support Clock/Frame Provider Mode
+ *
+ * Basically MSIOF is created for SPI, but we can use it as I2S (Sound), etc. Because of it, when
+ * we use it as I2S (Sound) with Provider Mode, we need to send dummy TX data even though it was
+ * used for RX. Because SPI HW needs TX Clock/Frame output for RX purpose.
+ * But it makes driver code complex in I2S (Sound).
+ *
+ * And when we use it as I2S (Sound) as Provider Mode, the clock source is [MSO clock] (= 133.33MHz)
+ * SoC internal clock. It is not for 48kHz/44.1kHz base clock. Thus the output/input will not be
+ * accurate sound.
+ *
+ * Because of these reasons, this driver doesn't support Clock/Frame Provider Mode. Use it as
+ * Clock/Frame Consumer Mode.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+
+/* register */
+#define SITMDR1		0x00
+#define SITMDR2		0x04
+#define SITMDR3		0x08
+#define SIRMDR1		0x10
+#define SIRMDR2		0x14
+#define SIRMDR3		0x18
+#define SICTR		0x28
+#define SISTR		0x40
+#define SIIER		0x44
+#define SITFDR		0x50
+#define SIRFDR		0x60
+
+/* SITMDR1/ SIRMDR1 */
+#define PCON		(1 << 30)		/* Transfer Signal Connection */
+#define SYNCMD_LR	(3 << 28)		/* L/R mode */
+#define SYNCAC		(1 << 25)		/* Sync Polarity (Active-low) */
+#define DTDL_1		(1 << 20)		/* 1-clock-cycle delay */
+#define TXSTP		(1 <<  0)		/* Transmission/Reception Stop on FIFO */
+
+/* SITMDR2 and SIRMDR2 */
+#define BITLEN1(x)	(((x) - 1) << 24)	/* Data Size (8-32 bits) */
+#define GRP		(1 << 30)		/* Group count */
+
+/* SICTR */
+#define TEDG		(1 << 27)		/* Transmit Timing (1 = falling edge) */
+#define REDG		(1 << 26)		/* Receive  Timing (1 = rising  edge) */
+#define TXE		(1 <<  9)		/* Transmit Enable */
+#define RXE		(1 <<  8)		/* Receive Enable */
+
+/* SISTR */
+#define TFSERR		(1 << 21)		/* Transmit Frame Synchronization Error */
+#define TFOVF		(1 << 20)		/* Transmit FIFO Overflow */
+#define TFUDF		(1 << 19)		/* Transmit FIFO Underflow */
+#define RFSERR		(1 <<  5)		/* Receive Frame Synchronization Error */
+#define RFUDF		(1 <<  4)		/* Receive FIFO Underflow */
+#define RFOVF		(1 <<  3)		/* Receive FIFO Overflow */
+#define SISTR_ERR_TX	(TFSERR | TFOVF | TFUDF)
+#define SISTR_ERR_RX	(RFSERR | RFOVF | RFUDF)
+#define SISTR_ERR	(SISTR_ERR_TX | SISTR_ERR_RX)
+
+/* SIIER */
+#define TDMAE		(1 << 31)		/* Transmit Data DMA Transfer Req. Enable */
+#define TDREQE		(1 << 28)		/* Transmit Data Transfer Request Enable */
+#define RDMAE		(1 << 15)		/* Receive Data DMA Transfer Req. Enable */
+#define RDREQE		(1 << 12)		/* Receive Data Transfer Request Enable */
+
+/*
+ * The data on memory in 24bit case is located at <right> side
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *	[  xxxxxx]
+ *
+ * HW assuming signal in 24bit case is located at <left> side
+ *	---+         +---------+
+ *	   +---------+         +---------+...
+ *	   [xxxxxx  ][xxxxxx  ][xxxxxx  ]
+ *
+ * When we use 24bit data, it will be transferred via 32bit width via DMA,
+ * and MSIOF/DMA doesn't support data shift, we can't use 24bit data correctly.
+ * There is no such issue on 16/32bit data case.
+ */
+#define MSIOF_RATES	SNDRV_PCM_RATE_8000_192000
+#define MSIOF_FMTS	(SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+struct msiof_priv {
+	struct device *dev;
+	struct snd_pcm_substream *substream[SNDRV_PCM_STREAM_LAST + 1];
+	spinlock_t lock;
+	void __iomem *base;
+	resource_size_t phy_addr;
+
+	/* for error */
+	int err_syc[SNDRV_PCM_STREAM_LAST + 1];
+	int err_ovf[SNDRV_PCM_STREAM_LAST + 1];
+	int err_udf[SNDRV_PCM_STREAM_LAST + 1];
+
+	/* bit field */
+	u32 flags;
+#define MSIOF_FLAGS_NEED_DELAY		(1 << 0)
+};
+#define msiof_flag_has(priv, flag)	(priv->flags &  flag)
+#define msiof_flag_set(priv, flag)	(priv->flags |= flag)
+
+#define msiof_is_play(substream)	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK)
+#define msiof_read(priv, reg)		ioread32((priv)->base + reg)
+#define msiof_write(priv, reg, val)	iowrite32(val, (priv)->base + reg)
+#define msiof_status_clear(priv)	msiof_write(priv, SISTR, SISTR_ERR)
+
+static void msiof_update(struct msiof_priv *priv, u32 reg, u32 mask, u32 val)
+{
+	u32 old = msiof_read(priv, reg);
+	u32 new = (old & ~mask) | (val & mask);
+
+	if (old != new)
+		msiof_write(priv, reg, new);
+}
+
+static void msiof_update_and_wait(struct msiof_priv *priv, u32 reg, u32 mask, u32 val, u32 expect)
+{
+	u32 data;
+	int ret;
+
+	msiof_update(priv, reg, mask, val);
+
+	ret = readl_poll_timeout_atomic(priv->base + reg, data,
+					(data & mask) == expect, 1, 128);
+	if (ret)
+		dev_warn(priv->dev, "write timeout [0x%02x] 0x%08x / 0x%08x\n",
+			 reg, data, expect);
+}
+
+static int msiof_hw_start(struct snd_soc_component *component,
+			  struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int is_play = msiof_is_play(substream);
+	int width = snd_pcm_format_width(runtime->format);
+	u32 val;
+
+	/*
+	 * see
+	 *	[NOTE] on top of this driver
+	 */
+	/*
+	 * see
+	 *	Datasheet 109.3.6 [Transmit and Receive Procedures]
+	 *
+	 *	TX: Fig 109.14	- Fig 109.23
+	 *	RX: Fig 109.15
+	 */
+
+	/* reset errors */
+	priv->err_syc[substream->stream] =
+	priv->err_ovf[substream->stream] =
+	priv->err_udf[substream->stream] = 0;
+
+	/* SITMDRx */
+	if (is_play) {
+		val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SITMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SITMDR2, val | GRP);
+		msiof_write(priv, SITMDR3, val);
+
+	}
+	/* SIRMDRx */
+	else {
+		val = SYNCMD_LR | SYNCAC;
+		if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
+			val |= DTDL_1;
+
+		msiof_write(priv, SIRMDR1, val);
+
+		val = BITLEN1(width);
+		msiof_write(priv, SIRMDR2, val | GRP);
+		msiof_write(priv, SIRMDR3, val);
+	}
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, val);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE | TEDG;
+	else
+		val = RXE | REDG;
+	msiof_update_and_wait(priv, SICTR, val, val, val);
+
+	msiof_status_clear(priv);
+
+	/* Start DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	return 0;
+}
+
+static int msiof_hw_stop(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+	int is_play = msiof_is_play(substream);
+	u32 val;
+
+	/* SIIER */
+	if (is_play)
+		val = TDREQE | TDMAE | SISTR_ERR_TX;
+	else
+		val = RDREQE | RDMAE | SISTR_ERR_RX;
+	msiof_update(priv, SIIER, val, 0);
+
+	/* Stop DMAC */
+	snd_dmaengine_pcm_trigger(substream, cmd);
+
+	/* SICTR */
+	if (is_play)
+		val = TXE;
+	else
+		val = RXE;
+	msiof_update_and_wait(priv, SICTR, val, 0, 0);
+
+	/* indicate error status if exist */
+	if (priv->err_syc[substream->stream] ||
+	    priv->err_ovf[substream->stream] ||
+	    priv->err_udf[substream->stream])
+		dev_warn(dev, "FSERR(%s) = %d, FOVF = %d, FUDF = %d\n",
+			 snd_pcm_direction_name(substream->stream),
+			 priv->err_syc[substream->stream],
+			 priv->err_ovf[substream->stream],
+			 priv->err_udf[substream->stream]);
+
+	return 0;
+}
+
+static int msiof_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct msiof_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	/*
+	 * It supports Clock/Frame Consumer Mode only
+	 * see
+	 *	[NOTE] on top of this driver
+	 */
+	case SND_SOC_DAIFMT_BC_FC:
+		break;
+	/* others are error */
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	/* it supports NB_NF only */
+	case SND_SOC_DAIFMT_NB_NF:
+	default:
+		break;
+	/* others are error */
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		msiof_flag_set(priv, MSIOF_FLAGS_NEED_DELAY);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Select below from Sound Card, not auto
+ *	SND_SOC_DAIFMT_CBC_CFC
+ *	SND_SOC_DAIFMT_CBP_CFP
+ */
+static const u64 msiof_dai_formats = SND_SOC_POSSIBLE_DAIFMT_I2S	|
+				     SND_SOC_POSSIBLE_DAIFMT_LEFT_J	|
+				     SND_SOC_POSSIBLE_DAIFMT_NB_NF;
+
+static const struct snd_soc_dai_ops msiof_dai_ops = {
+	.set_fmt			= msiof_dai_set_fmt,
+	.auto_selectable_formats	= &msiof_dai_formats,
+	.num_auto_selectable_formats	= 1,
+};
+
+static struct snd_soc_dai_driver msiof_dai_driver = {
+	.name = "msiof-dai",
+	.playback = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= MSIOF_RATES,
+		.formats	= MSIOF_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.ops = &msiof_dai_ops,
+};
+
+static struct snd_pcm_hardware msiof_pcm_hardware = {
+	.info =	SNDRV_PCM_INFO_INTERLEAVED	|
+		SNDRV_PCM_INFO_MMAP		|
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.buffer_bytes_max	= 64 * 1024,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.fifo_size		= 64,
+};
+
+static int msiof_open(struct snd_soc_component *component,
+		      struct snd_pcm_substream *substream)
+{
+	struct device *dev = component->dev;
+	struct dma_chan *chan;
+	static const char * const dma_names[] = {"rx", "tx"};
+	int is_play = msiof_is_play(substream);
+	int ret;
+
+	chan = of_dma_request_slave_channel(dev->of_node, dma_names[is_play]);
+	if (IS_ERR(chan))
+		return PTR_ERR(chan);
+
+	ret = snd_dmaengine_pcm_open(substream, chan);
+	if (ret < 0)
+		goto open_err_dma;
+
+	snd_soc_set_runtime_hwparams(substream, &msiof_pcm_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(substream->runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+open_err_dma:
+	if (ret < 0)
+		dma_release_channel(chan);
+
+	return ret;
+}
+
+static int msiof_close(struct snd_soc_component *component,
+		       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_close_release_chan(substream);
+}
+
+static snd_pcm_uframes_t msiof_pointer(struct snd_soc_component *component,
+				       struct snd_pcm_substream *substream)
+{
+	return snd_dmaengine_pcm_pointer(substream);
+}
+
+#define PREALLOC_BUFFER		(32 * 1024)
+#define PREALLOC_BUFFER_MAX	(32 * 1024)
+static int msiof_new(struct snd_soc_component *component,
+		     struct snd_soc_pcm_runtime *rtd)
+{
+	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
+				       rtd->card->snd_card->dev,
+				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	return 0;
+}
+
+static int msiof_trigger(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream, int cmd)
+{
+	struct device *dev = component->dev;
+	struct msiof_priv *priv = dev_get_drvdata(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		priv->substream[substream->stream] = substream;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = msiof_hw_start(component, substream, cmd);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		priv->substream[substream->stream] = NULL;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ret = msiof_hw_stop(component, substream, cmd);
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static int msiof_hw_params(struct snd_soc_component *component,
+			   struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct msiof_priv *priv = dev_get_drvdata(component->dev);
+	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
+	struct dma_slave_config cfg = {};
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ret = snd_hwparams_to_dma_slave_config(substream, params, &cfg);
+	if (ret < 0)
+		goto hw_params_out;
+
+	cfg.dst_addr = priv->phy_addr + SITFDR;
+	cfg.src_addr = priv->phy_addr + SIRFDR;
+
+	ret = dmaengine_slave_config(chan, &cfg);
+hw_params_out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver msiof_component_driver = {
+	.name		= "msiof",
+	.open		= msiof_open,
+	.close		= msiof_close,
+	.pointer	= msiof_pointer,
+	.pcm_construct	= msiof_new,
+	.trigger	= msiof_trigger,
+	.hw_params	= msiof_hw_params,
+};
+
+static irqreturn_t msiof_interrupt(int irq, void *data)
+{
+	struct msiof_priv *priv = data;
+	struct snd_pcm_substream *substream;
+	u32 sistr;
+
+	spin_lock(&priv->lock);
+
+	sistr = msiof_read(priv, SISTR);
+	msiof_status_clear(priv);
+
+	spin_unlock(&priv->lock);
+
+	/* overflow/underflow error */
+	substream = priv->substream[SNDRV_PCM_STREAM_PLAYBACK];
+	if (substream && (sistr & SISTR_ERR_TX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & TFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_PLAYBACK]++;
+		if (sistr & TFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_PLAYBACK]++;
+	}
+
+	substream = priv->substream[SNDRV_PCM_STREAM_CAPTURE];
+	if (substream && (sistr & SISTR_ERR_RX)) {
+		// snd_pcm_stop_xrun(substream);
+		if (sistr & RFSERR)
+			priv->err_syc[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFOVF)
+			priv->err_ovf[SNDRV_PCM_STREAM_CAPTURE]++;
+		if (sistr & RFUDF)
+			priv->err_udf[SNDRV_PCM_STREAM_CAPTURE]++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int msiof_probe(struct platform_device *pdev)
+{
+	struct msiof_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq, ret;
+
+	/* Check MSIOF as Sound mode or SPI mode */
+	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
+	if (!port)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = devm_request_irq(dev, irq, msiof_interrupt, 0, dev_name(dev), priv);
+	if (ret)
+		return ret;
+
+	priv->dev	= dev;
+	priv->phy_addr	= res->start;
+
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(pdev, priv);
+
+	devm_pm_runtime_enable(dev);
+
+	ret = devm_snd_soc_register_component(dev, &msiof_component_driver,
+					      &msiof_dai_driver, 1);
+
+	return ret;
+}
+
+static const struct of_device_id msiof_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-msiof", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, msiof_of_match);
+
+static struct platform_driver msiof_driver = {
+	.driver	= {
+		.name	= "msiof-pcm-audio",
+		.of_match_table = msiof_of_match,
+	},
+	.probe		= msiof_probe,
+};
+module_platform_driver(msiof_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Renesas R-Car MSIOF I2S audio driver");
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
2.43.0


