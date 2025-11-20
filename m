Return-Path: <linux-spi+bounces-11366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060BAC722F8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 05:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 3D18529193
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 04:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424742E5407;
	Thu, 20 Nov 2025 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2p2A7K8W"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023115.outbound.protection.outlook.com [40.107.162.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193412DE703;
	Thu, 20 Nov 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612895; cv=fail; b=O1EjvGWI3kZPU2t+zFTWecmwG1qD09SpXWuY3jfrgQl0d8R1UoSPRSzTOrbTldD8TvEzNlVAbZMuxyFOI11AFV+t8SBqsv3HNRrStKKiSATfMWq90p5GvxigpNu76UhwH74UICm8ILO1vJQh+maNp5DPszg9SIfpb28FAEVRt+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612895; c=relaxed/simple;
	bh=7/S5OMKjwhG64I/aam5nepN8hJsSF3iL7qLJ7oVYXIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HYueWiY+2yTwWsIBHZItqAO3BlR4FtAKtP+/Ggza2nC4gzlZDl/feGxGTSGHIuXvdMafQicUhULyRMSsUwTmhkxy0LU/3CmpIVu6quDqCR8o9Evh5W7adEyhFKXgTfqaXno41Y8/Y84RPHXkkNFRSvKHTTMkjZ1R3SOa63kV3Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2p2A7K8W; arc=fail smtp.client-ip=40.107.162.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNMiuI8f/yMChJhHe97WXgwNbj0v29Vuopl1NMOvgHQOaKed5nr4jwitXgTjfbrEeNjv4JtZ/MWjFdHHwyWuXM/h1FMROF+3jpERoSG28lKh3TyQHAXbk/ciVkZFMvKMz9f1xDk+fyYSuulQc4SVm0L70Pg+g4aVNOHzRJA27TA/h6kW7o7kakX7KVNGq+SgwgCk5zLfOoJQbpGziLtLhbV1zXOal/aYTngO3yxODvPDcHw4i/1OxQxLz7NMtEJxb0lFHB+w5O8EW9ErdFs/WeryJa25GfGSsmBtag9nxKmFf4BGRxW0ciUSRT7R54oPGPvmiottNwnXVcgVPUfcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZRuKKPQrvyoqJHMmbDvPgvhUsyjIY7/ZU0Kx97WZss=;
 b=vbj+yGyGL6u+i+Vf3IfBiR7u1CdoJZnMdQ877c0L321wtGLrPhJd1nj7QPhDliwbdQNzCtxlPhrODPUREMcZD64qmsCpTAi7MmiwPOZwq78qW2zWykV5prfTe7p7LRGj+iVfCYaAUSAQeLPFOvncVgBarDvyIu8qg9HU7avWRSKluzQ0p8e8tzhGTA+wiIybmX+CWEA2xoOKrsP4eyeVysxs1ktPGmnLkUlYdQB7Np22MHNlBQQDKeA9oYwbIUeKTx2bbLJGcnaoXx2h7qMMmEoiP99mHWmJ+5DXlgdzsbY1p7v1TiwPF3OzVNLFO7h3AWYSgFmXfrG2PgGAIb/MGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZRuKKPQrvyoqJHMmbDvPgvhUsyjIY7/ZU0Kx97WZss=;
 b=2p2A7K8WZS7a4PxYNGZAoqzmx23VuOXxdALWvujpg4/SvDXkAs1yMX8uZDhx+tHATVubahr7KcUbqvbOFdn58rddp9WABoWuQVa08nQqk1ZvWqSKc0EjYDqw/Sg8SRBSE1qagMcrsSdofT9/dxcv51jQ9M8CdX/eJ9enPkZC7nFvaH4BhG6N7c7RpNdWsxSJE7SVzm95O9CwFrsS0DJ0GjEtvoHQlzfe7wmZT/TCqRX3flsrL8x4MmA9lj9oCNyc0WyWYlcCylanfK2H/unY8mcuTdP1cYbAS5SfOXYVXFoPnvVzmeSU7AbD5r3p2thUDrlGJrf42A0bUU1JJgDsow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6541.eurprd08.prod.outlook.com (2603:10a6:102:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 04:28:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 04:28:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Thu, 20 Nov 2025 07:27:51 +0300
Message-ID: <20251120042753.640492-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ffcd66-f025-4f3e-f826-08de27ed31c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbJ5b+j/5aNp1XaqxEp9VkeIGZ2swCnAbh1zNaSjo8kdo69sdNZ2+QoyBN98?=
 =?us-ascii?Q?PhJo+Rg44+HQAVsQMk8+D+4G+QVX4u45iFP2sDR2qW0d3fIWyjEoyDYD7y7S?=
 =?us-ascii?Q?gEp7fVsdl8/bTswEC4TguCpzuNOJnL/5c7badBE0lHxWEMhe5duka4Pp7ViD?=
 =?us-ascii?Q?FScckLtHyAHn4CqKU3qiwcjDByYjPSb3YFehwS34ByWNqxfOX/FQsbVMLCe8?=
 =?us-ascii?Q?n2CDs1VpHOpijYwo6LZjOx89AyHBOGN4HG6O7aNgNveVogcdZVU0bRSsSHNQ?=
 =?us-ascii?Q?36Ow547v745MtjEIByvT3N/kGToswQYEMWYEDrTwiOWqDRT0lN95yORAMfo6?=
 =?us-ascii?Q?Yr1WqhSz5+zqETPxsaOBv148L2AoetcSk8UVfTkQfy4vxaINfv9jvGvUdhxu?=
 =?us-ascii?Q?VnkYnXtIlPjq+gJ47M0+gIw7btrINmz5K/CelTNlgsOBasr2zD2V08wrjQ6j?=
 =?us-ascii?Q?tia8ReaAwfc1v5pCQp0ABPxuf98nZQ4wMY7bQJPJ3m49SiNiusa4mSODaImE?=
 =?us-ascii?Q?WV14biW5HCOFYZrvg3Y3ct2yoEav3rsy0d+CqaU55+OcmGxF/BRqmMxCGF8S?=
 =?us-ascii?Q?DAoxNcTTZ338o9jQvq90/Hs5qzTFXF8q6wSZCq+74S4jZDrsBX8QbZpQdSg5?=
 =?us-ascii?Q?Q0ure89FrU0V74Sz8/jsdl9AIP53l/0ssv/JSBxF4gOrPx/Uwq3bP4GwSgqP?=
 =?us-ascii?Q?QjK6Qeeqvudg470eTI6FL3UWBGT88YB2h55g5ViUYeBoep/HH5XU8BhGX5Q2?=
 =?us-ascii?Q?B9Z25AGXcTiP+iVlnrHGXv2Ca56PTwrg53wZMKlhs2hjNBuSvaH0bti55ftY?=
 =?us-ascii?Q?kcipdskRi5wsiJ1TZ7PF050P5Hx0+7plMGZW9IWguNG6zQtJ7uG9e6kQN/9h?=
 =?us-ascii?Q?C8ExBqjhV7/xI5NZKrBnZvAUoiV0FBuhcVD3h3znQJZLCPGMapnMZhxwONQ/?=
 =?us-ascii?Q?nwVBXzGqpYgNydL5s7S3e5S8U2Jslrylrv5DhIW2S1mU2JgpWkobbKa+rkHB?=
 =?us-ascii?Q?UQshBhyM0poX4K64YQqs377C3b8mbS14y0n/ZqyWMstl1c1XD6EW/3jCD+ln?=
 =?us-ascii?Q?k3vnnpjGPv4ZBqAUBIDaH0ou+fR2Syv6qSgF2wl1NyoN2e5OFiRrt8TsqEy+?=
 =?us-ascii?Q?OnDt5GndQgqS9UNKTmPkGAOval+E8JAhJ3Lk+BDSCX4tG10sC0Jdg88nKqVz?=
 =?us-ascii?Q?A3f3bLkIrEhTS3m6dss1qPkxDDj6+52TJB+E63Quk7R9axkILn3Sd6pkZzxM?=
 =?us-ascii?Q?ydJFQkrwJWDHD6rBPDRXxFaz8zISE2ClljzvzwaqRTmYyBQ3xTgauPHNkkYY?=
 =?us-ascii?Q?nBTu+8NofSVLofSyEMS3QtDVHKevs6TpWhfMMr+Lv5o9luM/CkBrYmUAF8n8?=
 =?us-ascii?Q?7VMq/OJh55BmP7sdYZC/asbEo4x8pgOEf8uHQvGl/yU+FzX/907oXEeFYTBC?=
 =?us-ascii?Q?YH2OtK/CzotUHMjFjxlMbLANwV8sV5y5QJu/3cCiCOwPZKhZIzECE3jcYDoa?=
 =?us-ascii?Q?u5jqfEZ9Nr5v4Pj+MrqfhcVuYuwjL/lN4VPgjEl04bSfr9FO4+Vv8Z3vSw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Puv2YlTm2hAiQrUvOZ4nboywjyhMwGpFy2VuqYyB+5aC7on+leblxQNmeSA4?=
 =?us-ascii?Q?cCwxcZIdG+lWM9LpKqzAv6L43QC6yxyzErVcx6k+ObpX9uAw52N6saqOT/AD?=
 =?us-ascii?Q?b56dVKnuazezETq8iqfijLrHmC7guPY7JOYTFGPhn6OiAFv7Dow2PcCsoEZa?=
 =?us-ascii?Q?3dOWUZ35AF+gk4Tr8lN3pNdSh3J6QFzUSATFLjWu6diJHH1crIT571wGav4R?=
 =?us-ascii?Q?88P44ICIqHSLhSwp4KaavsRO4THBuphFSeODkLzbIQXH+46Xkw9awB8Z4Rr6?=
 =?us-ascii?Q?PKt+WrkONCyUgGPgp2r6MnccjgocL+ZIjSqeObdiSVeoAC+E7SysN7uVQ3vJ?=
 =?us-ascii?Q?sHmw5dpNClcXcnCMMM/sii5dDFq0+aCj9YHcyy+dRSQzSkYsK8EPSKkIMzWi?=
 =?us-ascii?Q?zpWC21vSY7u+CjVDpzm6+Zqm/frg+xFZQTxjSTMG2qBChI4WUzZiTxzcsg0G?=
 =?us-ascii?Q?YvTHzycgnRV6Gux+dEYf4wu1AQ1a9j25fWu2dOhcN181LC3X/HjTguStxprc?=
 =?us-ascii?Q?qKh9mGsOYw3RkUtR1oogIi8p6x2azzWh//VCVi4r04ikX364fsLLlne7kuof?=
 =?us-ascii?Q?PCNG3h/HHL+Ja3LNMswBuTr82CfFSj9n7wxNyEAS4tyebFbP0lW9/h5R72VX?=
 =?us-ascii?Q?7oetu1ex2loLjRyVFxJSOpq9kyB444XH933FNKD+Bcqq9VRPwjaD2oL0Vwdl?=
 =?us-ascii?Q?O8j3rZv/AY6bTX6T2ctQDg4hYQhm+wKKHdDGPcjPUETuI4HhC+Q8mjUlqgwK?=
 =?us-ascii?Q?lcDUTFdFuD/Y0ZCpxHIhI5n27BN32QiZs9TFggdKyUnuM5Knj5PATqFO1Px7?=
 =?us-ascii?Q?SSF4ja/lVasPczVzaUTrgVk84zjn0LWoQvsjCabNUtYeqGF9FTfZRt76F6of?=
 =?us-ascii?Q?nfhkug4+5vQnJNKUBVqEAvow9wRRwf8mlbviniL6vApKl4iok/mvs6ppErsY?=
 =?us-ascii?Q?9gQNaLEmoxHHU3TP7BR68jcbvlm/0l80fmUfh1aG0FNaPd7RaBb3C9V63q6C?=
 =?us-ascii?Q?ObJag9gwMjpzwGG/FOZ/qJBtFClzcqEv+EGyKMqF0xbBF6mu8lb5GJmpNPDB?=
 =?us-ascii?Q?UcgBYC2eQhn/CijAQZtjvTM4dX4US8CeeQhiOofhoUnTiIqywwHGGcdmsVpd?=
 =?us-ascii?Q?98uM3FAufQqT++MASoYqvJhHhFM7pAqUCUAvhBkV8aI5rnC1WS92ahADglV2?=
 =?us-ascii?Q?8Rzh8Iwam5HzfklkriZBOJkZsnb2u42ME4wfFbtiQTvp7G8MsbsD4nFqZLs3?=
 =?us-ascii?Q?WHc1GsJBWcUARt2FDs1TtZ9oWqYbCNa9FScAj+518wWmllmzmoOR3ZDYPvE5?=
 =?us-ascii?Q?ZSz72g5E8R8GJ4/CeQR45TmS74rmmzuYXYz7l1n7lkxSyV5+F0h6uaa0P7HF?=
 =?us-ascii?Q?v8JqvwlhZEXhCXJDzregXDmQ4viSsdYPkeADSNVcbgT1uQSVxPQl4IVNupNK?=
 =?us-ascii?Q?oOYAhB9pqsbOSfiROQE+ryJLCbI/+HWUr5Dtpi//84OJHP8yhGCNe9FYqttj?=
 =?us-ascii?Q?uoC1T7FEPvoV00vdAeWuzE70DEApmiNzzq6D32VH2OVAOuuIDTMZxpmw0Y8A?=
 =?us-ascii?Q?tzIv4EnlGTbdvrT7x+H5MljeQEefe0IyipFawLdubnQy50ZcM7HTQAOHdlDG?=
 =?us-ascii?Q?+XEcaiRWQ4j/LZexWUY5blI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ffcd66-f025-4f3e-f826-08de27ed31c4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 04:28:03.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOeztUCfJzkSDC0CI/D+niF/PWezpg5fXCP3ZcwqZmP+EW9SDkCQtjGOX5A5js5STikSG1ixzyN4HFMQGKoOu12GSXIuw+FOezepR6Vb/pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6541

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..a2f2ae7c60d2 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1057,7 +1062,9 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct airoha_snand_ctrl *as_ctrl;
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
+	bool dma_enable = true;
 	void __iomem *base;
+	u32 sfc_strap;
 	int err;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
@@ -1092,12 +1099,31 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
-	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enable = false;
+			dev_warn(dev, "Detected booting in RESERVED mode (UART_TXD was short to GND).\n");
+			dev_warn(dev, "This mode is known for incorrect DMA reading of some flashes.\n");
+			dev_warn(dev, "Usage of DMA for flash operations will be disabled to prevent data\n");
+			dev_warn(dev, "damage. Unplug your serial console and power cycle the board\n");
+			dev_warn(dev, "to boot with full performance.\n");
+		}
+	}
+
+	if (dma_enable) {
+		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
+		if (err)
+			return err;
+	}
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
+				   : &airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


