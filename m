Return-Path: <linux-spi+bounces-9479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1AB27F08
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43BF1C21E53
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6565303CA1;
	Fri, 15 Aug 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="UCTRzXuj"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA5302768;
	Fri, 15 Aug 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256607; cv=fail; b=BUPhFEBEWpXJy5nBd2gZsjsutOTevkS3SO89Duvt+IqjyrZWBtFZbN3RYzVn8JNiQRsj5S8BRhDi2xfDweEezSpR0DhRdLJVapqI1dWd9eXZVhYSzndTMaW0S1i30VB8soYzWhTi/XvFrvZeXrR5gtuZli/gCnVtvaWK8LPs/Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256607; c=relaxed/simple;
	bh=F/mR7dRNDaB6MOWrTo83N5YtkRLNK4BDQYIZwDSCZlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMzs1m/qz8S3m2o2XjbK+gpkNyOaN8UekQkVlGbH1uBVZwXHrKyb8Wq+ibsDOMSFIFKGTjRgmoFiYasX3y7wtSYLdsks2j4KgaOpJIMTZHREPwQClLrWRSj2dfjzky64gzXgEyY9/qEaCBV4+3I7d720rMIrbHG9LF10qeq5m4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=UCTRzXuj; arc=fail smtp.client-ip=52.101.65.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj0hIKy+15xfg8ZalY5B58Tc5OWeCgDhzYpC+uRVc6iqiFNiFPQnOiDtai1K5T/mPYtI/Hb8wqJC5PvXR/oHIa66w00uzvt8dMbLn3XQyfHGgEITPbp6glqSMWh+RB/IHhUlz8wj7aWpoZwCPMBgF6e44rWBiL819RPViuu9QZpiYgatyyoiUW+BrRohJznVnpzSqK2f6Dgbr5SVGiIJCSaIz3vkGYPzx2cuqBILgVjJCZe1hsZ+XNw0GDSSOBtHcQir4/YJG69STWjF+ER+D+iubg/TSxbjmHEzY9ymwUdwr3HAdwKwr+o1sCZP/2BJwDSqsxzrSLD8xZagRM1Hww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNZasuXEfv4xOtNP0xgODaQmSdY6QuTe2mWMTNxOjvU=;
 b=h2ewDZh8sM1tS0orn9yWkzQe7KMBfSWY6LnhP/Vhu9ckqlNd6Y2/rhNrHb0p0+Tof+pFdAIUJYm14mtJ/RAclx/o5FhGmDbBJTp6gpIRPpPXvycJ97zxBez9L9CIpwpiaExOpFoaMDY0qnNguqC8KDrhVGxraeaGGWR80j0l0aBrXSmJXqFbbga+7m+AtHPFktYlSH9mg7r72hTbJJ4T0XqceGl03odmX1cPz0KxY/U/rFpsLaFHc2JszlzIPcnNhz6RT/se4lcLcdmUCQ0/XJLH7PKzJxAfViLkjIfXthekI4gITJaoz/bO3LtmWToznJVC72JJUTKSmPT99hmCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNZasuXEfv4xOtNP0xgODaQmSdY6QuTe2mWMTNxOjvU=;
 b=UCTRzXujaoG8Fej/JO7NLkc6TE4sladvmn6pv1BIx0dDFXZHrCqpC96x2mO+e5HFwbbCBB7dLKhCURLzUsQh0TL4TQcaco1dn1Wuwzau4CyVVjH4KsEYfgskbmYHe+L2dfktwhz/pJiPS7jc3lSlUPBM4Dar0fckKenvMGftnjdANEQG3g++bsxUWNjNEOmsWyK9mkIklEdXmxKy4FFHt8dsApaUv7Q/6hGKrrOs8ZEaR6VVxStJLj64klbtnLeeoaqrrxWTk87YJasMRdhMHNE7PyWTADGD6ihLTERORebQiDCP6+7wRv6RDem1tk1BjqC/KY7tFmU6a/SQbGzLqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:16:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 10/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Fri, 15 Aug 2025 14:16:16 +0300
Message-ID: <20250815111619.45001-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f01017-36fb-456d-7514-08dddbed3347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6aTyeaS5KDBZT6f1xmGlyi8XWfGLUlAA08plT6QXPC/6nyNYwoyv3D+5OoDY?=
 =?us-ascii?Q?xnHDkBlcaEBKiCNvda3+SE8nErMFAKMWOsekAHZxyhHZFdToAb+DmOv/zhnL?=
 =?us-ascii?Q?paGsU2jhq09WeKRpl7IDwl1+AGw5oY+dWauODNbIgJBUz/n6TuihFBiD5kya?=
 =?us-ascii?Q?g2usf0LmBd6IpvUa5+q3V897T+tv/PjMWoI7ftv0orx9cOO3/IDVAILafTId?=
 =?us-ascii?Q?ICRSqbSIgE0tI4ralSFNt73V/0kBilUHIx9rIyPIJry3pGanHpgtykdUj5DX?=
 =?us-ascii?Q?YTCMLz3tL6QtrbfBJnLE+ZkGOOQI2JDi58zkM4vHT9rds96UdgPZEYNXMhUg?=
 =?us-ascii?Q?A8r+vhb97SxuPFs/pkkLSb8BCJ23132O10v6daQ8MxK4h5cwPz8niwDafryE?=
 =?us-ascii?Q?CPh9eXD8DaruEUOORCgP04tGpssaMBiRyTF1plMPjq0XiSL7Cu3U0E7Od/6N?=
 =?us-ascii?Q?sNKkFcLjyYsW22Tv+FjWdiwvkOtdVX4onZ3hoqJ2RmvHgi9swQXyeJZblOi2?=
 =?us-ascii?Q?J26loNdox4ZeVFRMqoFL5PyhLUVtTknhoG2dLSN3Zn9iJDyV3VlonD9ttD/e?=
 =?us-ascii?Q?S5CXdl5z72QC+5FLYehsC7YrPwcw0xQ61SsWquh/FKC2cLSu//UpTKLMcBOh?=
 =?us-ascii?Q?H2KKUTQnqPaFkcnrvVScO+DOJQjNfr8lG42ZZZmC+3lFMdOS3Yb7uuPbDZQf?=
 =?us-ascii?Q?V/f+R/SRfA49eNoODm//q1Jk3JUzAJNGpn7xKb8/g/rbrlQgrWfipCZx9/04?=
 =?us-ascii?Q?8TJ/3zr9StVD+S9+JlcCzrieqyl/pifGsi08KvyvlpNgOn3IVsqoPv9LYW8D?=
 =?us-ascii?Q?ESh0FXCjn/XEKOiTpJwc0cdX14ipqU041vLErpfSnS8iKBH88ecfDobB1GfI?=
 =?us-ascii?Q?z1b9fsbpaqmERBwEbbPD8SAI4oTCYNCoJfeV2CoKl3j3Jz6vJIaWw3kwkiO9?=
 =?us-ascii?Q?f6w1hfxGQnbBi+rq8rkz+W4hW8kRDkLSKEjKsTOixpvYFx8lAl41KIyPu76A?=
 =?us-ascii?Q?lHaE2EDhlorFwPTiE5mifafXabjJR+V7ulK5srinCq/T2G2NEAd4DATbtIAw?=
 =?us-ascii?Q?308uUA8j9PL40wxaxng9hg4AF9NCNJ1XnL01BveMOcj4qQLXdoA6p0melcgI?=
 =?us-ascii?Q?fsl2ayj9VRHv5k6Bh6zVpAqMuRo5GcT3whI84Ls5wbI/kbl7cjgfpfh+Qmxn?=
 =?us-ascii?Q?4+lZfOrzmPXBL1yRTlaN/HAFjYr4ThbYonD806yxkPu67QgA1ghR2alGHlpE?=
 =?us-ascii?Q?TBaPVo4xKyaFi8Vr2gicxORKVfuOk8XiUpUxUI4cu+wT0Ly+GzKSsjeDIwjm?=
 =?us-ascii?Q?pXbk5nv5+5qNlF0MDqzfpMpr4Mw9sbNKXf23kiXNa/lluJk0I6IktdbqPmKm?=
 =?us-ascii?Q?GMQk8+dPiSj18Om/JQ2FXk83cES0HDWmWyYr0xQFjjixBzJKH329DntGrdYy?=
 =?us-ascii?Q?biicGXy0iirTOfAwBGIBbPtnmP4gNFXpnTPdsyHbg4+1Cn7k3lr6mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zW2XJLPRTRGG1za3LBiAIHDcuH1kKD3Qb55cuX+q6jBg9FWysjVAMVLizmRT?=
 =?us-ascii?Q?x2UXZZKCs5/QGovlNnrwyMxluZL3pMdQOHWg8WvQJr+uPOxjIbukEl4ZgrPu?=
 =?us-ascii?Q?6Yu46iyOFPpwS/n5A5D6fImSqAkbhKsUAPNiyORQG+UD2mFiHzzPin3VDKeu?=
 =?us-ascii?Q?LCukSGB5oFL433vGzFoc1nCPf9qhNBomjNprES/4p7WKyT8kFuXmep1vWuMT?=
 =?us-ascii?Q?1QQKpivmtEpl0D7ozlcgP1lVMwxgiPyg7pCco1VTRzw3uVabdJYS0paTPMvp?=
 =?us-ascii?Q?IAits/Od29Wro+cmd1ObOSEhf0dyQNtHZ0tXF3DPW9wXlgeZTitVyOvGNJ8G?=
 =?us-ascii?Q?7XgzCtWfSEhar5wUJ1nQ4++pzODn2hxFUBVjNKDd5Mj5IKQjj9KJpqnyRdqE?=
 =?us-ascii?Q?YLErvN17xCP92ZB5en3KtpnQ0fBJZguGCUMHPJa73dcfttkWiB3nd/mE+fRF?=
 =?us-ascii?Q?wDa+E6PtGjYUo8E0TySDfdPHPIJDEK0BgsQXtL7hnnQtesQ0HCEgBHOY+Ote?=
 =?us-ascii?Q?vShVQPkfKeVhysDxGE9uXNG6tWfDzdfhT4XrMR0TE276hDURpsZwfkp65Ln+?=
 =?us-ascii?Q?lrYzSLyvwwk6mjqiBqVDEj8sAlekbNPK7pPeY40nc5jsL4yMtqXmgxOUGn2O?=
 =?us-ascii?Q?lzU0XntLAkYmwUWtIQPRqxCiKctGDMLvx34k1jQjxPU9AdI8VDGLq3ghCu4S?=
 =?us-ascii?Q?VBH4ilpGwd1otXlwcwY5xpQNui/wIg5bhzqQA6y/WqMZA77iIgiTuoMxPg9O?=
 =?us-ascii?Q?bae3z/itWGB3o8I9dsMqFkFMzYboqb8CvY4lD1yk/tsBQm04owfJOVJJIsxD?=
 =?us-ascii?Q?ylcphzErkSWB3Dmr0vY6Y21twfuxIbzbgaOCCCjxfGtw3qn134g2LrsSyZ/u?=
 =?us-ascii?Q?jEs128IbIXz5rzejDyXOBEfG1/9X9Qa6T+RIMLbXHbOgr8ZO2RN8KJ83fXuj?=
 =?us-ascii?Q?ixJmqai1yu5t0CDAivF3thgwoPcD+zG01nf0+9CCThQeP0FzF7iPWTPucZgI?=
 =?us-ascii?Q?tB8YIvyRnnzYRAU+M0TqOy1qz6178HwDUDCHya9tDNCgTJZ3DC+vhZpE+D5C?=
 =?us-ascii?Q?JYMedLX6MHQIZwiskfeR0Y3K/SAvLdN+XfC/FPqbAb9uUlEPe3Gb11djaYWk?=
 =?us-ascii?Q?3bYwrrho8ydG2jRrT+u7OwOsaJkymta0C2vYYdVGM9VUVKKXeGZqhnmDiL29?=
 =?us-ascii?Q?dR1cafyR8c5SFX9pfvhWAh/I3ZJkTMdvpsT2SB8kY1B7h3wBVhYypjy0b7fZ?=
 =?us-ascii?Q?tl3C8ZZc9VlgfHpLed9+NfsAhrCrL307VJHzoPpE2yR98Kd/ZAILcTcamc/P?=
 =?us-ascii?Q?N3rwdRb0F1WeV/ixE9ilLPwAGPzS8ImBvseigyxfdIIKn3MQs2t2rFJAZ3HF?=
 =?us-ascii?Q?pVK/F8ifV4anPeufdpu/az3SCze4JEiB9SFOLZi9opQhr+rqPMh9ytk5aOAH?=
 =?us-ascii?Q?lc6EKKAK50DuSamCMlhbNWoXsEb1+bv3YzRb/ZieVNXsJoarV4Z2ftohersm?=
 =?us-ascii?Q?v2/cU8FFPd+HlZgAkkGyoiigKb3QWx0ajzdvwycNkiM2UnC7YclrVbjisuVq?=
 =?us-ascii?Q?cYwMCC7Ix088+QXU8xm4kP8naHT55/QH6SX2MB4krIwezYSSXZIUufGTqX+U?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f01017-36fb-456d-7514-08dddbed3347
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:37.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo815eDphQBxHyxWcbbLVDxWQvyqpfe4cN9NCEa6cdM6+EGtVZF7NrFp086bHqjoe8Fp9XQ/nz+EbDogkP/cvCNC+3bLVg3POkJdx17x4L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index ed49bca1f9ac..78695fdeab8a 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -516,44 +516,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.50.1


