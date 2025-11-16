Return-Path: <linux-spi+bounces-11239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE634C61427
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 510C54E3B14
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA42C2372;
	Sun, 16 Nov 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="dXKxF0jg"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021140.outbound.protection.outlook.com [52.101.70.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEE221F13;
	Sun, 16 Nov 2025 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294455; cv=fail; b=Dz2RgRkRBaWDRUFtE0rE0jVdYpmNsraDmumimPD5I+h/6JXLe/OJXSKv3TPSOnfD+7eJIJksS/qSoD60rj7wzDj0GbIQ5pAdfK11vlcFraqX7gPML5qpAPFSMTAUSrtr6SKZkJ8ls7zjAdDnwWCynTdIhvTsnpzpPnqcLpkLyvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294455; c=relaxed/simple;
	bh=40mUwvlFHRT3YNWx0V1enjTKKIqUZ31DgHscct/UXsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rei62mnYglqg2A5cvxPeR2oe8sE66F3ZenHxB/JqWNfpPiKEgwNi9coWyWiYaNPFsqkLr3iSr6mhaLJeu+jCLWh1Mhk8els404t0SypQZz2pZf/WViBcHAvOx10SCOHYFaCCRxskExmsJYTydkZTGtzRln8GJe4YJyjl5++57x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=dXKxF0jg; arc=fail smtp.client-ip=52.101.70.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3RPY+zTm0OVFikp+7e/td38OUjRIOhpeB6vK8OFryl3ldxOFgLYP9IdKnZMT8ca5cKiWu86/DGWWLaimNMw4Pc0RK8lb5yuR8ARkc4/nJjB1K9341cKwFfP/YlxSl5xOG9ffneO564hVKgZAHWGDfIvK3/Q0yDZiOHN9CVK4M/ujpUr1ReTDd5woYrLC3YCc6hZitoO6SWHM5Y2MpSFH6gTthHonzVPKW008l/DPLZDtbXAvSbbHEwCkWHFyRJGFdN+Drkf7Bi+fFGXdac+dN9e3Bj5GKdjdkUknH4ArvLaU+TknC7xb/bKk9n4MdgknbBJ0CU9BuXPBaKy4l+EXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fWdaPGBk1s9zsIqSyLWrCZLC8/BpGgpXCQuBm/ba8U=;
 b=G5c0APRoRImuI+tkLwb3mtr6BM1gpoajpZ+iHY8YqlmXBrcfI4Kc35eUJLRFh36ibht+/KFDYNV1l7/MWFoxcaNEwE1yzGQa0bAJ+EqYNE9h4rvVgqvBuhhaIzC9T4OUqmYDHj75xkSVGQ/FZ3tTtXlzkWdwIOAPLHXqQQerO/OkRTNPIbNUQVbnka9pzXXaIfvFV05TUGI1o+Hne92c4t9DbqD2oyFaOkVxtjbwqHZe+sQ5yFsv7vp83lROrsZdTLDebwhJEabEcz1OaaxzdGJZpALMUWE8ZMlgMj9Ve0IxSwt1rvu9BPLUDFFc4jzbDbzb08azscFLlqexsSkWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fWdaPGBk1s9zsIqSyLWrCZLC8/BpGgpXCQuBm/ba8U=;
 b=dXKxF0jgbMbHAd2VLEgaGZjutb3E1NK1x9eHlH7WPBzX1qFfOflTl9dQaalk5leTKKFb+BrSpydqNFL4UmFL98vAGWYCL70iCn1o3Gh/kdZ3/dFKlKSUqNyVLg7WjG1ccSCu3aHRaPboCmKTAkzS+HkGfBbPbZEsD4rqOOvk4zClCzB0i0+AtKygoRswtgeOS+X/8z6VB89ycNIsqbQkrjcDTiUBhDW7e7fiGhdZFFKKZu02gB2/0aytl3e7J/2EHNFWVJ5sibzWvv1HnE1u7xbqHFRBycQ8TnTiEwXpHz/MnQVhJw8fOObChFHyOF8aX/Lljv8qr5sGDlptCrmg5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11201.eurprd08.prod.outlook.com (2603:10a6:102:46c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 12:00:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 12:00:49 +0000
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
Subject: [PATCH v2 1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Sun, 16 Nov 2025 15:00:36 +0300
Message-ID: <20251116120038.672178-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116120038.672178-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251116120038.672178-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11201:EE_
X-MS-Office365-Filtering-Correlation-Id: f6671832-78c0-4bfc-5d95-08de2507c898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GprLxtwnKk4l70CHwdJUXYlPUOuQ72Zef/wtvMmbPzVjz/mUkdzxRRmqmmrl?=
 =?us-ascii?Q?BON60pnjNRMairFe9f9heT/BCvO/ED+A8XoQPjrQWsai5NmooEqu7/Eq6e7U?=
 =?us-ascii?Q?WQ2KSxudKgpoZBHZdxcLB9PbQLvK/y1tzIadQJ1R0dB8wRVZGe4DtLSrtKox?=
 =?us-ascii?Q?uiS6Nwc0k5SBdGFiiogjdiQLSFwjSgLmESo28/H9mvUsM8jgQ6/9XShYX+au?=
 =?us-ascii?Q?COFW5PjVTIBhdIVQ4hwzhmTUPs3yVeMEbV7Y3qqcXOJQAObEn9brvBKdo9fp?=
 =?us-ascii?Q?XjWE/9br7u309XtgTcp0+XNF9bYvp9jeto8y/k72AlyywQr3Bxhb9qi0YJgm?=
 =?us-ascii?Q?rjzi+x/45QzpLH3HK5r8mKh0JCJJL+KfRG+xK/iK+K5bibPkSFjk3wpUdJhk?=
 =?us-ascii?Q?x0lX8RD/CN8fj43T+zUc1UK87lUHFHzdOHgkyK5U02qq2CYXgL4+mQV3gZsG?=
 =?us-ascii?Q?ils8okvaCo6SEH64LbbewM64UGHRmOdedIim5DXKCXkIae1RbUeocOVqU9om?=
 =?us-ascii?Q?V5jNSYnIqMX/ECj4RmTkQXgsxYilbVczjZPhp9l2fJ0FkGxxh66VDlt7nWAb?=
 =?us-ascii?Q?GNoiRHFpeuLJVypv8/FuwLtdF6/GNVpA1X+SyKc8OA1e2TTdUIFL5Q/Kmxvh?=
 =?us-ascii?Q?yMbX1qz/h3jEfq9tSka/0LW3VwDxyEuuLsEgVJ8CgmwzrA4SK2cwtjYoc1fP?=
 =?us-ascii?Q?cUH/4z0ii9vOwmtN7LiyfCVD5KbGB0O7bNMjzHa/JPf8ShRSsb03SFpYHSPL?=
 =?us-ascii?Q?v94nG2pCUPetLzQrPlQH1b2z4F489e/gEJyoLbuALo9Qm4r/8EefiE/PlEOx?=
 =?us-ascii?Q?jo8i/OfcpjQQLhRZPOeCjOlFrCLyw97Tm0P3/gmGPkOS7o31EmKorVAaf13k?=
 =?us-ascii?Q?0CLEVBfn7lXO+nzLegdvEv6VN0nOCqsFksSXeaLUYeLk+f98yTYJKhNkc+Z8?=
 =?us-ascii?Q?jffua/z7rtJgJO6D0wzzocEurv+AlBfDcCF2HLy8l+OWYGm2dJBCfNv7rvOD?=
 =?us-ascii?Q?fUSnIdZGcca2bUDrrFA8J8Z8pm4CQiCc80RmxAql0xD1xm2OYJcUBJTDMyN7?=
 =?us-ascii?Q?XBrg9zCCwnr2a+fLIBZBGg4q6TiE5IEnMxmSFVJD4rbDWnoJn2wzglePT+XV?=
 =?us-ascii?Q?m4DEiSanpxArwr4xs/EKlJ51g2GjeNlaTOkNDKqSTMG0EzrGji0++8MJXYJE?=
 =?us-ascii?Q?cxRZZMTIgg50OGy/AXi1XPoBIni2+vekS+vNqlQrvAK7LARYlVOS5W6hq7fy?=
 =?us-ascii?Q?i07yIR3cHUwNSu3j7CKzOKl2IMLqUKWmiHDWRZ/2llenaAYZH0p/+SysEuGW?=
 =?us-ascii?Q?INg0LjVcFjo2JY2jxhlNnJhu6eWqEIifW3kCZzsTWAI3mZtTmDxmYM3+x/Az?=
 =?us-ascii?Q?XpSJiDxcCz9YbISSbCs1T1T81pYI7m/z2RC1Zr7vN7jC63Ix9W2CGrLl1mQ+?=
 =?us-ascii?Q?aicewttKI8wAeXurGt/jmT3P01c1TAzcY+ND/NoK94jj5CDhlG1hsdVNEdAg?=
 =?us-ascii?Q?MFvloP2i2w7gTgjArz2g8oWlhHqaleP6rMtMxGemzDXNz0ktOMjiU7S/Jw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGpVzw5NyIEHlC3bqgjijC3phINgk1/YpZvuZvSsfHaPb5CUHa5F2o9EXfZK?=
 =?us-ascii?Q?w+af7VF+pS/QIxoFRhorrjqks22SQ34icNhNnuUJM+yHVGPls7n/+SRdbGD8?=
 =?us-ascii?Q?eCpF6dAeB6pbUFjWqr4gH5WC3mnsbcbwPHZi1JgtWZHB/bWfXlnYPtTJHQKi?=
 =?us-ascii?Q?xW7kWS2o9/jLPs9ZVf4zuKbcBpMfdv6oiGOMzCZEPiIRRZTgqtW/DO5q/g4/?=
 =?us-ascii?Q?6Vw28EResRx2iRXUEkt++saxmSGPp3Y00G/WERiV4c2Og2ioATdKj99jRzmB?=
 =?us-ascii?Q?myX5coJm7ziTTnbCZ8WWswkjxMk75PDPYcQicbEkyrEJets46ANDpTA7/LIa?=
 =?us-ascii?Q?qTz09iEP3f1I8QW+4jLisGoqJuDvE47rM+VhvYNWN4FWNZSx26v0yjx31xBA?=
 =?us-ascii?Q?GaQIYyZcZ/7VJY42H3D83529m/+HIuF3bnpLqkvACnf0/JDo74af0sKlZq0g?=
 =?us-ascii?Q?MksXlqxDOIWy5XH2cXrIENEZEvfm+jwfBNrCrwe9FerwtV5P42V3pdza9QdA?=
 =?us-ascii?Q?Enkn+w79Azkj02kJA0B3LoV96yfW4PLSOrTIMCISONVVBuZklEjMcDHT+Z2j?=
 =?us-ascii?Q?TqYYqsxn6d0NQ5Dp8keBJX0WTZ04ZYs+Kl2YsibPhgr/bUnIDJ3BLB9w/1Zo?=
 =?us-ascii?Q?q1x/Q1qIayUgR+axvPVyknZgkjhuTIexeYR+7kohNCA+rK3r8DwvJTIF5oMj?=
 =?us-ascii?Q?FPgovjK1len5nHKlGZQeFi4PN9kfu+2hNzzYh1pFuYccjKul+yhVxoi5HPE8?=
 =?us-ascii?Q?gMLbtwTxMLb5uPOGhxAAw/NvkjSufgF4Etx4wfnR5zvDyS5Qb8gGRxN6iJ3c?=
 =?us-ascii?Q?B9TknYL6h8o0LhdhGyePd9PgNxEyrtE22CRz56eil9Lbc9E8sOL7JkWEal5W?=
 =?us-ascii?Q?/YoP8XXZ8wz1sJ8eilfaaEfueGfQ1KgTLlNiOGYsrwqoPrnFPc9T1rrBDDFW?=
 =?us-ascii?Q?1Dmex5UDvYpusiDxGcaZW8XppPFfcpjOA8mp96AxKYX5XApnoMiejh9wSM4b?=
 =?us-ascii?Q?6UF8N/T0va+Xpkwwi/fNAYrSblnBTEDa9gBw/j1Jf0NfPlFDxjSYV2OeNM8g?=
 =?us-ascii?Q?G9iAyadI2t5WBXgFEzlBUdGlHt5y/mE7jnw01PAHhy54MDmQiZM04mx3jRnP?=
 =?us-ascii?Q?PkdiMa2MRbR5EFI1+8ripfIjp4aBb8T0feI8v48LHceb5fRArAED+bG82SxM?=
 =?us-ascii?Q?5AgWz9lUxc+Ojow8GL7lwg5g2uSMqUeG88SRA6zefNMG4CziLE4xwyW0ga6b?=
 =?us-ascii?Q?H0RAgzp2HUYfPA0wKCr1Xk68XHHS1+H50KpfhN38FhfjN7FQSiM/1+RL75Cx?=
 =?us-ascii?Q?S1MTX4er1tOuHXgoBZtug4WSfkJKkS0ky+IZ9MiNURbxaM7ixeuYhVU78NlW?=
 =?us-ascii?Q?Uxt4cs9rA8RCHgrfRqY1qST7FTOsMVCFVCZBA2bcahIZQb9gideMFAbbTGYn?=
 =?us-ascii?Q?vy49NQv95i5IEgohpX9FJwoHRyFQy4iURN8krxAHsgTYwAKfIoVu/WFmEHNg?=
 =?us-ascii?Q?8HRWTcitAEq/bdvGoBWALJQ9PCqYcWrgcHYTX97xvq0btz+YTUrFKYLN4N/P?=
 =?us-ascii?Q?jkSg/g84Zg6xtzmVbJeEOisPwFNE9bo9VDEqptXeCJbxEqGfija2MKrg+Nxh?=
 =?us-ascii?Q?wn3MICH3WM/y+Q2LITH3x7c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f6671832-78c0-4bfc-5d95-08de2507c898
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 12:00:49.6435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Dtc0anxKdC0jVa+xinz1rwuEkyMmOck20WQrum9mIz8T7UVlhwvcdlNdNFtpzRXvzP3LORx9R9EAhmFjhz+FslsULVnhhk7WTU+FxjoSck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11201

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
 drivers/spi/spi-airoha-snfi.c | 37 +++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..ed1fc755a1a1 100644
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
@@ -1092,12 +1099,34 @@ static int airoha_snand_probe(struct platform_device *pdev)
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
+			dev_warn(dev,
+				"==================================================================\n"
+				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+				"This mode is known for incorrect DMA reading of some flashes.\n"
+				"Usage of DMA for flash operations will be disabled to prevent data\n"
+				"damage. Unplug your serial console and power cycle the board\n"
+				"to boot with full performance.\n"
+				"==================================================================\n");
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


