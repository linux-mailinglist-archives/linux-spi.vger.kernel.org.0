Return-Path: <linux-spi+bounces-10510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75229BCB89A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F67F422878
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CB27F01B;
	Fri, 10 Oct 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="wlL+jeav"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196327A10D;
	Fri, 10 Oct 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067133; cv=fail; b=UFCcpfgcSEBLNNRp0eUfbYtR2beDw/C0w2w4SzzpJ/GeIegPC6QB5oBIu06v2ySvDu/r4lEWBuEfLXZCpD9BPlcrN3ljgnonpMUuxqTCmoN1qt+KO2jbNfwhMzMRA1id5NlEd4tPydVo+7Ca1MtDgxMARoqLh0mBgj9Id30ZS94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067133; c=relaxed/simple;
	bh=cBHsnFZtmlxn0wHvSPe8hsUcctWdvufB77xOkfG7jHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyW3VWdo5fFozuWodjCZsFW/fwN5mbf5vSMn48lKYowSeZ7bIeH52CzmEAOZEJrmtNQcniFnVqsaBanncTcr/JYhqBS5iREgcqb1mlpzkf5yYIHQR41btOocOUeaET4kesQ8avz0FBV+wKPela3iVl/UebwBHZ7dT9L72YPYO1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=wlL+jeav; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZrFvqtCZOvLSOSqputI9s0TBQAUqIxbFPxocfs02E5K2jjjrM6dkP3CTYpml8VqGJvjNXsbziNDZqL2BF1OS5PHxxci9ep5XG4vgApiDAYE+TsrQzG/M5Tq0YrX9wvXeW5U9FKrzK2YV5gu7+eZEhmd2iRbZG6jL6COydl1pButpQ2ck1vzOkae20ISylNmMcdvnM1vCOeEAEXM85tn/43vWhu7Ad0FNts+ju7KfboxI8amAPOEwODR/tCa6ieUsZ126/HPc3th4m/CR+zBsyYRB5N898Ntr6skX2+byGviO/Mq928R9iURpI+hzoa+rrYGaVfxoh8FIuA+80C6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=Ex7gacL16thi2F5DEquKJoEBwYYJM4k9bM497J3qpRFHisTabxX5O0bDbMLERXPH+OP2oDxAJ4VW2D574ZWRRjzZGnIy8ol67CHnQ+51sGUpXbb+rMo0YvMY3SNCJKMjdkdtPTyggIoY+YxxDcaNxkMtxRDcgfBXQAyx3njYxVgQdkWTrWGgKVRhyfZbNJLuzSHpjv/N42w3mM+V0GPpEpj8U3ZKcgQD/o/ZKjmHBWLHhYCF2sfKO3qgdrFPu6jJq7XWl+Dj3lOgBgJcsu1BeTUeZjRaAITSW5o82RP9khFwqcATKgUxlGN+PbZWcqhcd62QQYjM8ikfrN0CngC4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=wlL+jeavYBtY3bavMa7NYzobDm7eIdA5SUqVo5nXIqREiSoUBV8JjuBWGcu4S6TYHLnyKvNufWn+rnvyczjp3drYn0ZOQCJVhbpQJBVoygZMWKUlHmwD8X+PNLo4BvyOE24COg8Sjx8UfyCZ59QFPdn2m4Wq9hGaMpgc0vq78V5CQaonl1tAnHI1xBeBnE7f+SklSBW9gdd2g/dfNWg5G3M3mYarA7ZXKPJ84PqOPrb8RLJYIYPXj848r1sY5mOOVEHSJamK7oHKRtmwVszqvmanGBuZH1zy0rLy/aoYTpF9JHgjZ1qn7tUyaehG6X9ZxhNhtnOdhCEcUpurMCOaxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:32:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:32:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 10/17] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Fri, 10 Oct 2025 06:31:29 +0300
Message-ID: <20251010033136.1475673-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f78e0e5-8be4-436f-efa7-08de07ad92f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LrjlTQqnWnHvz1RO2icX3fLLed8bJl1qVUv0XQaWlIXJ/IQG/u8Syst772fy?=
 =?us-ascii?Q?/2sPHx72AZgyThdoPVnhPIB8PitWJ3k4T51PSOMKNbc1Ks8XeaENH+Kaltsg?=
 =?us-ascii?Q?n5pblOZ+37Roya1Zk/ftDBIlaAqQjTyLg7GM/A5QGJxf8FQxoRCameA1Ajhc?=
 =?us-ascii?Q?xIonZ0xpJzydmXhdZ7xhAEFGiduLIntUOHt10nwyHT+09DaY4yHZ8tru88pm?=
 =?us-ascii?Q?u0vBtjxAKlEvFUJfru6SmzWnCQ/ouTStofzTjTQwntDwN/LeJLGn2pckEeOa?=
 =?us-ascii?Q?gaqiHCgjYNfQgPccExQ9Nerhr+//ROGXJCf05A+IsKwR+FUIommK8Niyfz6p?=
 =?us-ascii?Q?WvbtN38HqRyjgnL6suRG1oxLmauXA0uuvDBS+SC9AyzLIxAlZV69tiFBAjk8?=
 =?us-ascii?Q?7E+/JVOos5HdYf9TYpnvdpw25WqiGGB6+EqAIjmNuA461UUzAWV7QsjzK5Nn?=
 =?us-ascii?Q?6V/deQ2TrpHzao2cX6FNmugrVxSO0iT7J2ylKg5i3olaR8og2VjBo4USXR2D?=
 =?us-ascii?Q?/TLBctiNqWosoxzLZOe/WYm/1slEWLznNFztaqXudFX4Vd7VG3jwJS6BVbvR?=
 =?us-ascii?Q?8VHBo6mrHsu4ji3wkWNyyc/GV/gpoeZ93M0ottOqsO7JJpTUuiirDKql3Pmm?=
 =?us-ascii?Q?At1N3VjcjO257cxccEHm6KcCf31dpoJWdGdODCna9hDwYGYONQUJha82hcys?=
 =?us-ascii?Q?tWSSmwZVUuyXIrEOMcfuLROnIZoU8Shh+hj0lPwo41HPnU8MYYeLj1PGL9fi?=
 =?us-ascii?Q?94Fx4d7F0DYZ3jh6J581gDu1LpzyrYwaBNFPOMPlcu1Qx++GDLWDXaFvaM2O?=
 =?us-ascii?Q?TTAK3gm8Y08KW1AfRJxGfadMJh58jSe0mI5s9nq7DVhtXjpk/+SH2lMF+yH2?=
 =?us-ascii?Q?c16lkv9cR7pzQSV4xgNR7ZIxsAofQX0f0cbG9w4TGkOKzygORNn8VBOPe+R8?=
 =?us-ascii?Q?WOfYgLgh2X2CuJL+39OfFP+sW1UJL87HYo1XoFbu3CjonKLk1wW3CeAakm+n?=
 =?us-ascii?Q?d3Xsjnyut3FMirIADRMFoh8d5a/67fZi7xQV66mQYNnak9+h8eJX0crE2IjN?=
 =?us-ascii?Q?X2lwT6Gt02niabMJ2wttBVZEeTyUay9lLv+wYThhQNtBvVozTtxQw7jWTLGO?=
 =?us-ascii?Q?YAskTVA7m7B4PMia6bT6sF4rNUhZCDVf9iPX6+5wXoP+pbEqH9t121XkYfOK?=
 =?us-ascii?Q?wFf/O2FiccG1wMvfIGAAdw8f810x5t6w2lXoqaG9/lJX4Aq4S5VrtHfHBIEp?=
 =?us-ascii?Q?q26p8tfCEyVIPE+eNcAmnrwXAOSu86d6syVVpFj+DB7ebcaa9Wm9EIWWOeVH?=
 =?us-ascii?Q?64akpbm8SeytLyY0ggHF3tD4kOxh2j6bRRBARMwYFHJb1o+C8csQceHP+agd?=
 =?us-ascii?Q?JMcMZc4Gy3sJPtsISpzF1eQShCxjRYF9x6xAUGR9eIR7wessTkGkFuXgzTUJ?=
 =?us-ascii?Q?yjgT9U42nbDRQ+XEyJohIPB6CviUFE/a35XHtjdTAocyT4Ea0qvaB5Boi1fj?=
 =?us-ascii?Q?C6lpKwHB/Jak8ak4SvklRImhEUCwdUDTPdDIBf6i1EpzfIFfzBll6BUO2A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zgtXqv9tL5Z7XnI6MNzs3fD/XAg2XMHbinGGOw3cAl7gUwXtTKx+aj0lffFI?=
 =?us-ascii?Q?8z1tby7nrm14yfIq9k6OKbQKgd/milZGLw+mzdaWUlogf2IPRgfR6DB4c1iH?=
 =?us-ascii?Q?3Y/D4/pKfxpCjfAwItKGP26CBwxrKAjFP95hgZZz2PbL60wc83D2Mqgt/W72?=
 =?us-ascii?Q?GiqEFqh6q7CI1oP3V3HpNQBRy9X7AAJbpRIf2HiJ4wtoa1j8vn3O2kN+7xKF?=
 =?us-ascii?Q?IYMWZStDu5iLLPJX/ew185VtiOL+aMe2+4gOBBMUrs1a2yV3RLXnkCyXSJSo?=
 =?us-ascii?Q?js06He5D5Yu3XEWCn+taD/BLA75oULEyrmOJ6hEwDTtEKbUDqtLbrMwgZ/dP?=
 =?us-ascii?Q?+UB/lCe6wefjHd+Zye8a8XXJN18nq7ADUdy8CRmr71P2QGq/LNQwxxboupzQ?=
 =?us-ascii?Q?ZWX2pfsXvWWWPxlVPsujIG/LLyraUa37bMPYmscj8llxOpPnrrn4m50p6RKL?=
 =?us-ascii?Q?mJgeJY/27RQEbWqHRfXYpEbVxSED38huTvcVGFFhfPbAZYvARUT8o0Mwh6LE?=
 =?us-ascii?Q?Y0HynpFzvj5rJR/AeV426dK9jl2q/pmqvWPYmeQGK0qK1mXmRcbPys5j6pxY?=
 =?us-ascii?Q?cT/3JsPD7YFKEEPcHC/o+7FhyGcqZIznN8hdg4Y5b6CGy3A01j5aTIlnR5G4?=
 =?us-ascii?Q?Olc/5LYHj3ejAJ7qMppW1FVuGi1VjGxIiwiTAwZ1hWpn5XRL/eV3ryYSMYSZ?=
 =?us-ascii?Q?ulOKM/o6aOf5Sv+z4Iunf76bJEe+0t7RxE5KN2AvqfTG30nXzOr32I7eZLR5?=
 =?us-ascii?Q?gvRBpgGMB8H4LNp4ch7LPmQQrgoYKfKjXskDAORI14V0AeKKlf/hd0xwY9en?=
 =?us-ascii?Q?Uc7vjBQHl08DpgoHgjuA86UBheSRXZnizWaE263ljnrRZeOITudPWeRlpsd2?=
 =?us-ascii?Q?rdiV26pBPAj0Zyvx/9sjSrpgAISW0CV4R/IsXrLX1L6vLnN0wp7rWF86IAhR?=
 =?us-ascii?Q?YkoHPaR3lAFSjkKDC7dRVUGKKh8K+uSWz1cdAKI4Fx3w24YDxciWVUM/xejA?=
 =?us-ascii?Q?Tg5E38uT8zkzD1fMxxC+ifvJ71bjzN2ewmah+urjyBGJVk4zBpKG/BxykOEJ?=
 =?us-ascii?Q?dMyg97CAqJBY9AK8b7tmnWzfxUuztIMB0X7cudYry3BAOi4njCtP8/ScDUwD?=
 =?us-ascii?Q?Nqo8buuF4eEVlxZJX9B468PNsGL4F/DEfuzjpa/nWjtTonbC0sSdwWe6lopr?=
 =?us-ascii?Q?nn2M3wE2KbkdYp21LzJ/BsUt+w3ezjqMxyoAaTyWkMmHubABcrD6Mg7P2zKt?=
 =?us-ascii?Q?ydbbT+3E+6KR+jtTPRh9lgoGw44Gd7qJ2PxdyN2Nu+3V8PSGRbWq4yrHsz2h?=
 =?us-ascii?Q?QIuwL1qs2v8f/EBgQYLHBNcBw8aedXcUvAUXy+8pSsqPa9YtkNm5rZpa2ExE?=
 =?us-ascii?Q?HqD5bn0I/BSMPzc2onHRgL3u82FeRLcQvJKoC8LFVFi9hLgNWKcizexFWWJN?=
 =?us-ascii?Q?cl7+6fcfEIUXAhq3A0hDGWEoyFfU2S5wz8n4hh4Y3oh8Scud4rCEdOcnsTO6?=
 =?us-ascii?Q?eG9vuJiYVV6U1tL2Wz6QNiWChujYpAuj/qDiFpP+QFXwEfYihbJ0MlN2P+oz?=
 =?us-ascii?Q?SIG4EsNJDR4+wow5a3acId8ocjsCwIrMXf00wPBmIgoYXnI/sJ3/jMpW+dWC?=
 =?us-ascii?Q?I8K4WZP529UOaW26y3eciXE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f78e0e5-8be4-436f-efa7-08de07ad92f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:32:01.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbPqqnpOMv4L340Ol6ClQf+7wIX2k0X36FRLYoaT9UyJgGZ/PNpotBTI343Ym2Fyj2UfUAw52Q5k8G3DbOa/yj0EjM3Ivxvp+Ow+w1G7E8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 135 +++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 719b424d4cce..3fb76e2dd5e3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -668,7 +668,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -684,7 +725,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
@@ -711,18 +759,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -815,7 +851,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -831,8 +908,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -857,22 +942,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.51.0


