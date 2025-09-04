Return-Path: <linux-spi+bounces-9904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2EB43EA9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5465188154F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761430CDBE;
	Thu,  4 Sep 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="a7KQJY49"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020124.outbound.protection.outlook.com [52.101.84.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372E30BB98;
	Thu,  4 Sep 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995846; cv=fail; b=uf/NFO++k4cab0vSNPcIc9BMpQmLML6yI3KFc3ppYdomCFIJtV56ejKF5HRklWfgEVYrngiXFYKFIL2LJ4oOg4Yol0qdFu3jvm6tE96MqauuoJYKnQ3n/7/xW91sFSpQixkCg0KtsW5wmVzyMPSMb1wM/ULAdu7CR+3S7ZFlz2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995846; c=relaxed/simple;
	bh=+Nm3fELD9WL0sP7I8SgBwgxRbJ7HPuWkU9SZTeZ8DNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuyw4eM7flEE1iQjWbvgHyA+46fLwFsQV2TCyO3qgz8u02x8ujym4hdY1DD/uWovrlboCaXuf9/4eMflqDF57VrrjYmv3j1oDdI4wRr+yzFmve8Fa04FZz6xgDJF3XyctHt7TZPRhSeIgP0YKXGWtWSC19+Wvgqbkga1sf9i9Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=a7KQJY49; arc=fail smtp.client-ip=52.101.84.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI4vdtaubP8NU+VExvCNVp83bwZzx5Y1bxD4SnF39GR8VxgOVqqKhuqdvhFqBw0saU09UkOsrN4ObMbeGdDgx8GicZKitMz9gf3Ztlwwjvm9Orvw7CV25j8aPiV3HnBkzRn5knoYWaVeTTPwmD4txf12Mv3Lq319kyOtiX8yRoEc7BY7P0ZpswG3heE89CUwqeG/TQ/BJ7Ju9Q4M4TSQu3YPYtkLzCK8Fly7//YPQYGca5AEBfdnnwH0kggoL1soT1YXWMm1rhuj6LUwXwPpHNnRG6jhqReBGNmkAdfHx77farGSYj6J7YxvDeXh20RnCCt24l4z2lsCrzBryGMS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLW0rjS0msSp5vUdllXYkdkhmO9FyNWos6T1VzkkTWU=;
 b=prpmAHflYwbWOqSmNsIiAhbIclHTIGX99F+J6Kxg0RUq+hDYSlOSoJQos/ohU3Nml+1kV79Z3pjbxYwIY5C4M95utPijCHF7S1u3ND0WLFQVrCWQIcMvUplI9DnsTkWitiGDUrSQCtMrrOzCwEUkqXRwWQ9pidkeW+RqSJ80BsgjKilsGp0FLtiSentst38r6NkTxz51iHR4ilS5iN+nJTj11VJxUTr8vwNKdReQvy2wAO24+7TlLqr23cgyAJzKxZDkqsAq/ib4E54lmw2mN12bMoN1lH9lsdickLaz//pOdrlb8SZ6RcxOeYZotAudcJe63hMLDMJ9siY/jaVzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLW0rjS0msSp5vUdllXYkdkhmO9FyNWos6T1VzkkTWU=;
 b=a7KQJY498Kihq/6Ixl2EWVR0nwpwah73cgjyliAG3j1dt3xeMNVpGKHmaMN0VKxIlSk8PS98xmfmAwgns4BvO3+6fuI0J/CKrX5Ko2yq+s1VJnCyTtAdNAz0B/98Hh2yrI7qnWL1v7O4sOahl2w0WDoygIBERMlKVwKJoPXZQYEbOHIbseXv2v9msL288s2l3I23ofnJfzaQcktV7N9aJYCwnBTS1ujuPjKTJITqYezOcpcK7kA2i0+QFm5oEvS76+LUMP0/JWtljjefGe8bGVXsDa1cKP7rkPot/dFpPm+apzicegieheVuymzXeEnKi/ARKGFBY2K52tyQik8AMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:23:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 08/13] spi: airoha: support of dualio/quadio flash reading commands
Date: Thu,  4 Sep 2025 17:23:34 +0300
Message-ID: <20250904142339.656346-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 170d48a1-bd79-41f4-14f4-08ddebbeaf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FJqajn+aVt1sfnz8Fl3eTNny6Dq9/lEC80dFWCtOzP/mWDfAJzb4B+s8fT5n?=
 =?us-ascii?Q?IYIL/L/2o4fD+6ZWU+cr870pQNWSp7vpdkAU2CAwmc5N9y68NWrq5SPTwCZ/?=
 =?us-ascii?Q?FYgCaZt7ZxFLVZJRlyhgKsu9BmamEpnN0HgjkjHjyXu9CDuGjPwjEGDomHxv?=
 =?us-ascii?Q?9qDqdONFt/HYXq3n7ALxI8Q9BxwX9emBJf7OFgM4eEieooq0z9ZPJKz375MY?=
 =?us-ascii?Q?m2D5U48OABMgcMAWqns97+fX78rG6IyyTZ/6LjUZkpVXJozTM0jHzJMge6BW?=
 =?us-ascii?Q?Io4CtHb/ZlMOEYslB3oMzQkWSUv3vhhUg5iKkZZSTQoiyVlHUBFynld9dKbV?=
 =?us-ascii?Q?NsMjnRC4FU4xFi/ZbSwyx8KlKcBwoPv1qiM2z1JoyiFfAvF11BNuJoNjg0+6?=
 =?us-ascii?Q?yYs3mmTQXx4/fRvHb99UbtBbH/ySTw83+fs/9VzYjSMpQ3yfN6o0ikXNuKbi?=
 =?us-ascii?Q?B7O+5/dP4+/SdotKb/SUxxpaISwgRAgKgad5N9mmCVmNh8ldk8I0JK8iYpVo?=
 =?us-ascii?Q?/2zCwrl60iJL+p/3Bjojqmpb9gbUptGOvm8o97ScDggcxVdWi4h3pgZje7Fx?=
 =?us-ascii?Q?9J/6Gh8F8dGl9MxMA16MeT4L/ZT0wii/5oxHu0ntxL0OtNRgXrZua/1yunKQ?=
 =?us-ascii?Q?GliO2WBzRd0UdWlPDcPBpevuumaqL78s5N6gI3enK4GI+mp4e4tj/HKdx3m7?=
 =?us-ascii?Q?veyDUMr5DMQGR49xTtQFNyOd3jI/CrCeimCV615wlVwZxjsPRyoZm6saPDsl?=
 =?us-ascii?Q?V2zWufJ36Nl73lknVYPO6NemdZmZ3vLw+YwdUFlXKYQQRjhEOcf1ch3YxBzR?=
 =?us-ascii?Q?NjdWydzPOHlhTvfLcXPTolIFHFyuCyn9wF14mChvdxCwSL4996+0aq5FfAw7?=
 =?us-ascii?Q?tSpVor9cK7v12ElzzjC7estxqtDLr/cGQkw3+ZS96mv8nbyrY7mbmomsA3Ml?=
 =?us-ascii?Q?PMaJ9U+op9AcshKrPtRMwnOLyhYGEeS9iGyjk+lcOGGRHHeBPm6JIP8gZNEm?=
 =?us-ascii?Q?XvNmk0iqakXm5M1bu8VpJNVdNhS+afIaKaH/QeNXOawnrfTfUv8dg7qC7Et9?=
 =?us-ascii?Q?q0oRS6DeGAaiFJ5tMhbS40J6/yRrMIi8UhQK/m14T0or8OR/QQsvAfNftEQI?=
 =?us-ascii?Q?Ic4ergMaZEYg3JTLnDEnIc9tC3HPSyq4eItyfwvxav+H9wzRJI++IZrwut4k?=
 =?us-ascii?Q?HD05n6vqk2qjXiT6yIfs0d0UEqa7yS+BdiHYzbu5zRtbXGho46kxSAbf3zd8?=
 =?us-ascii?Q?wXqV+mrQ7sxIohe76Y4lbYoR+VuBJssyCo5jMAlKY3k+wgm3+pcn387uS/oY?=
 =?us-ascii?Q?/8BeciBdnatQLqmh0IwDPDsnkXtWUMCU/D2dvvT1KIFvOo9TwGkOCs5B6bVP?=
 =?us-ascii?Q?kGUC7hSObNcsn6NoRFRE/ZM1o+p5fs3O4Lm75vL38NS5bG3VA/if0vyYH4ag?=
 =?us-ascii?Q?H8RUzM7KxnsmgBoUjXtmh6TNoktMgWqgqpr99fqESVew/kksDJZJtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alEQM3BkHQ626b6CI7hplGz8ynepSZu0V2i2S5uprx7Vd0ijj4kKgsZUZytU?=
 =?us-ascii?Q?0ZPuK2laBH4FHUaDnVBHoVXF59uXO+2nXpZ6X1JaxQ1gGSs5IuPavGexaoKg?=
 =?us-ascii?Q?PYWfSm9KtRDiF66P6J7IOeeOzfC/pqUeqL+SPrKMHLw61pisWY6IdgwD5Eel?=
 =?us-ascii?Q?mianyB3b2/qW9gAu+QtC7IvfdkQmIddj5pXEVVkpWjPFngIDODA9DW+R5XSS?=
 =?us-ascii?Q?4cIwwwIm7RyAh6820lqyLaSaNb8KWT8Q2UMiPqxqoek6DA6e5sUbje9Q9c/0?=
 =?us-ascii?Q?f0BWGleUMzYQsT1eHZKqOT20iiJEyJrTVkfghCH4eNgB50d28ZzV0Mpp6/o2?=
 =?us-ascii?Q?ZEoGnIAf1DubtNYytzXTPYNWVsKgPgf/hKNAsiTqVrCUTYTDBo75vkgM3vk1?=
 =?us-ascii?Q?Gygg+hkusytj0Iq4O7ev5+jmIq1AVfDDmILf8zrzwZdzq/tcwmZk+y5TRe1v?=
 =?us-ascii?Q?9q4A6qfVxqLk5o4/E6avhnlv+7gY9E61umtDr1ixnVy4e3aEJkG9o4qBCYG1?=
 =?us-ascii?Q?Te5wcGA8qKB0SRLtXZkimu5jDS7jbO4HI0HbqIy5ocylo4MhLQTIncjvGX2t?=
 =?us-ascii?Q?FaXQtNs/waqm5qJK6LkE5Du8wEe3+ejIwcMYtacGwn6cg2OU8L2OHSqJEyV7?=
 =?us-ascii?Q?Rdw4sdRYnNLuHT0idpxFjaUyktCNuCg2GrRDjWpyhEIbv/Trih3vHKiPOjEI?=
 =?us-ascii?Q?01b8OIOT8Ggmq/UT/LHaaISWcU1hUBR0VXFXsb+bmPpEGWMU5P1TGKCeEkAE?=
 =?us-ascii?Q?U+Qg3LmGGzLVq9+zT9Qn1zNvJGiR1NFPX/SSq4wJk12yreaoDNo3r8bZViP/?=
 =?us-ascii?Q?WnAoVkvlSjKrWhv3du2Dik+bAmpGaeZ+HdA7i4+jCvHPTkYPkSEGyOxzr1Qs?=
 =?us-ascii?Q?Kts6UdV2BMh+P//6tA5rT53cHx5ghIlYK6fMdKkv9mqlIRoBFMPbefjBOtuR?=
 =?us-ascii?Q?lEbeXjSEUliflVWisGvqm1kET97M1OeO2wxKI815emmmqpd9WjFGE65IdZLV?=
 =?us-ascii?Q?ivuCCZX1Qdxb05Byy23j12Ico2okxt953V7TMLVuODjrJGQbA4Sb5SL4DzS3?=
 =?us-ascii?Q?elC56fTvcpjiFKGrvn5MTBuzGwO2uP4drNL5kDEoEpY3Y6F4JK/8Uc6lNaKc?=
 =?us-ascii?Q?nnCNptyqRk8vrERHTVylA+qa2bfW9ij/URSnV7kmt055Cz7C77qXVUtoB3WB?=
 =?us-ascii?Q?9l6ngXSMTIDlqRvwFqenLT1icHMiexrastzbVuHf1feYaGk7yA649JEnkOuw?=
 =?us-ascii?Q?NOMLooaJ5Psb9LYN6GSkl4keAvm8gHzFZvIY79+mORt2RxazP/J3GDLI3fuS?=
 =?us-ascii?Q?GWxEHVHvB4qNtnSqbAWuRSX9J8ZEEw86Yi0+qPECHhMd2oYTqnVsaBjFBYat?=
 =?us-ascii?Q?YmYni7x+Qv/VXmxZNrfRNFcbPf2T7JMIK42O7EXn1fQcUyzQvu+Jmy78Doqc?=
 =?us-ascii?Q?usCcEt2C16CVxZydBoEUBv4+egYq1BurBngirkKCs7JuDCaF9436XJIgV3fY?=
 =?us-ascii?Q?4o5SDOKsshdTDVbHS3bwlnHK5DtO/hK5xM0edOL07l0t0dp5582QtENFuoso?=
 =?us-ascii?Q?CbRzF1bgl+lBz93KAZCGyHXEeUqueJQxy2C2wFHb3vwbX7jARIed/COED3sm?=
 =?us-ascii?Q?gRDK1GbrT/FtMBp/lIlHCJk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 170d48a1-bd79-41f4-14f4-08ddebbeaf68
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:57.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L7qGJdE3p0HmV6esx1x2him/cGXy3+c/RcLkUvnAgCjfFs1jmgtFoITK9epDGFZ4Xzh6oFooETzbeZ6U5tF/nYAcNHmdPXUIYDEvgPXuLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index e90fab69d81e..744eeb2b24ef 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -664,26 +668,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -717,7 +733,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


