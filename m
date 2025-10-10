Return-Path: <linux-spi+bounces-10507-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7CBCB87D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E01B1A61FFB
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A370275B12;
	Fri, 10 Oct 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="EC4j7DK0"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603DA274B32;
	Fri, 10 Oct 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067128; cv=fail; b=nzyMFt94DY1PsMuoavTfmgqOjXRqbgFVkGffaLoqq2HMZ/+6Egwt+qcgk7kWfPCplLFfo0xtf7XVF4n6LH/hdNk7TG7CYe9+uholSWvuc3icKN+uhoMkym037fDu0psaQwnQ1Dy1zBeEx1DhMqNBjBUenyQBBUoDfRw0yVhiOz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067128; c=relaxed/simple;
	bh=8l9JymTCgM+epgUzk4VcWqTdwxznhd6zcMGkq7eDAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4mBgAdkb05k8wa7apuklws7JVhGOxmvem07qkuZx+vq2jtEimp3QDRupYhK6+OKsUTzcwoOKTJiM4+lqmyd27piGiev6/0EcupiOWCJcZz+XaeuRU7L9gkzp7pVP71GtQdPWfMsFy8eLWee3owP5UAOuzwiHydJ1TOUon4/PsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=EC4j7DK0; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=es0fLiq9iS/UcZx+xne8SzXZlXKx8Fi+AnkxLss0VHJIkma5Nkvlmc75hM96GErcRdL+sIXgf334uJaxguIHtdCIPiA5kJu7bxnu8pOtZh6nckr8IwUspyV7juU+WIgNTRQS13H3IZu/+1bNZ1RKvmmhGtp8i9rIPHLUZR/a64iA9te4jCugVS0DOIHmJbWq84y0vMRWDEsYVH1l0LJbEDK5Qnz6f78Cqddz7R8ds5iVOe9ZdHj57YUqvMaxm+dqKhjN9G9rHo0BT7V80d7PATwI5Nlv4Kpq+Pgcb1IhRh/3LWGwiHIlQHOmiGg2D19GGOFiJybG6MmmNBc2si5RfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=nEkzQmI8NKo+7nMDI7PeqohboSJb3uJKH4ARW9v0yZsHTnzVj1LPXLCv0cbjWuFPEainKwb6NsFVOIrKhcasKTQ8Z2BrYSVDt5CNQT/m2c1mKsM/9xRUC74lmN50NyPa2OdlsHvoCmeizBGdAPpORg/c+peHBIhlZ4AjRryYvqYufX5Ryng5CzCjBpTR1cc3+5tzh8wTYhqMmUHvKnY/Wx6hX+hu4g3F8mnM8LMtaaFmh/QysrGC+me0+I/+qLQYaEwrCK4KP0oTVyj8z6TkGftZaVLWID7BB76RskfvF9LbzXEZ76sQigyzIsTfwpVEAuadz2+h7YXtXJJ8utRVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=EC4j7DK0hGSYpFT1hmLwIgjDpC/4JShp1hfpM2S0JvkO0JlpcuTHSzRNAZHB8KM2Ja1AfUHlo6W8So1n8N2lErmCF9CMNrkvu5uJ97BOea02Iy3UXZNJnb0MB9Y0DzpQiwIjzMqsDgwDf3LqTtc0IG04a2JzttYQirxDWgmzEiQ/Xfk53WaMp2rFXdWgDnk5PUbb03tijYNzPVVhUQGqIfNPZnG3JUDuU6CVxzvE0LhPWlKUFgLds1WyysZnTGqj3xDpoJ5OEjCg96IW+yO6xSUivqWSAlMsog2noCHS96ATqxFlm8OM8oqHkjI3LPIa0EOepWuv5VsHdozk4kSn5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:56 +0000
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
Subject: [PATCH v7 07/17] spi: airoha: unify dirmap read/write code
Date: Fri, 10 Oct 2025 06:31:26 +0300
Message-ID: <20251010033136.1475673-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7d26f502-d491-42f0-cd74-08de07ad9031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jLIWVJsNV0NjAmHnqL5pZtxiGNajc/33rn8pCyyDPhjzzOAZZQHW1Go5jwQw?=
 =?us-ascii?Q?oAs96bxEfxKj4XKZDjRuKhKiB2QJn8bJc5/Cf4BCcbZjvXkbXaekKLWddE1Y?=
 =?us-ascii?Q?XT1HaRaPnoDbGlfhT2IifH852T0OFgWBhTUXIJ9qzpBsHgdyu8gySgaS/gR5?=
 =?us-ascii?Q?8NPrrCA32iv4SGnKhs1C2/G2Gp/VLckLuXeJfvff4lShtf6aOZpEOpCHN4pm?=
 =?us-ascii?Q?GdPiZIhiVqBpwNv0jaeowtcpqMPjYqSoyddJGnar+yqXtdAx6HWcDXYkV5C/?=
 =?us-ascii?Q?AjTANdTmfJN0VVcjMiyH8txj/ti+FMGZ2SD4MU9JAFAfbBh/o1jF2WBw7305?=
 =?us-ascii?Q?yxm4sV/ymUJwzfJggLJaOvA3AXQcrMcIMPRZnnYriXwIczttGlV6u5DLa7RR?=
 =?us-ascii?Q?7VfzlKsMJHm96rRXsq6xxs3SWko7lJSoezWgUUD0iGAhGZGs+g/lPJ5G466/?=
 =?us-ascii?Q?gRQzbaq/o2WDluW9CueBdEk3Hw0TyqY/Kv6DYTvShHnvMeB3hZvgrmEWEcTF?=
 =?us-ascii?Q?cdzK8heCdn6t2RrrWQ4A0O5D8cBGqQT4Kph4hKOIaF7DjbgGc5fi4Px2tu4I?=
 =?us-ascii?Q?NTjRBRm1foM+grjmovJfY6/3rvCi0s0ZKL4BoVab0554jfVoKs5kdNQ7SRak?=
 =?us-ascii?Q?PFPsA/kCZNYl92xfR2mgVTbUatUw3TuQEXdgTU2LxgMovts176qgPthUKyiN?=
 =?us-ascii?Q?EzEkSU19s+gmcLtVBWrzNUbGPkywsps3fMvnGceKS1pPqi/+bNrmTYQWziXA?=
 =?us-ascii?Q?0qPQ3jcbaNlTe/M6Q+Ec4zdra7ONOfgDbrFUoUFvce+gZ9tNCwievYRQU02D?=
 =?us-ascii?Q?brk9BolYNuzS5kPIlhrEc/j/lbCTTQtapbQ9gp0HXDoO8WjPiRCLmfrdzCLa?=
 =?us-ascii?Q?dprIZ8NNf5HlRQMRIRYOR0Gm5IPYzzk28jBa9RP8Cp7CsFsk2ELyu137U04t?=
 =?us-ascii?Q?AKnORdj2d6uvPS3qGb3WgfOykl4MY9Q0rFJYFLMqxMhq9BqoPUc+Fn7Hpa6j?=
 =?us-ascii?Q?VxlJ9EnkjyKRI4SpPw5cEJGsZ+jjkZ12injhxR3Jd11AsUDOhaI19iHaZFMh?=
 =?us-ascii?Q?9o/3llc1IA/L7rzM0s43oGMxp9zWiE72vPKbqQiw+he06u9DZYQIV+PTNgmZ?=
 =?us-ascii?Q?8pOwuWIQeC8t2ZJ2CqREiFetp7yVs8vEItFuLAjHPeS46/76bliq8ceGyCud?=
 =?us-ascii?Q?NJeFdKs7RW8qoTX7XQowmFLKbcQHJQT3GEIL25aXC7+AefN4i5PnqJ1P1Ssf?=
 =?us-ascii?Q?AccxB5apHzklNsscLWFmOCUQy4x2unaudPxIjNvnvxctZBxx2yiU2uEuWAWe?=
 =?us-ascii?Q?3V62hj6kRLpVcQmBMnc9UAkHWwCeQnblRFrVB/KkhNVWjFLCVYVWgNVAxr/b?=
 =?us-ascii?Q?r2zdRb0HFgCQnKRDFatFsyCxBid5tnxaHCUyqJxK7Vho0qAZ9cy4yCyS0b55?=
 =?us-ascii?Q?KjHgJtqoYsStbg3mUbB2BhTM6q6bYSw62a5/JfRM1pynpSHwwLNlJx9IuHCZ?=
 =?us-ascii?Q?meET0BOsnOawZjWGOy/3Db6t/OXgHhET27oyoLVDpNZfxwPOhJcKw04KMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utCjfrK2NPm8vrniHwymJH+bYxPdwfDJJG/VeTxkePi56i/+w/XeaPeEvuPh?=
 =?us-ascii?Q?kPTSbKIt4XfM2T7qE/DEJGeabbuiasFnWuvdDTIymg7o+DkvnLvxb25KYjCi?=
 =?us-ascii?Q?6KWfmKRO4YPlgpbpdIYhPe1OwXPJH2Uu5vebKqUV/drUB0gk+Ec1vT1HdZQb?=
 =?us-ascii?Q?ct88Zck0yEr6nrHvlSmaD7TV1wmKt1uJKZ0LGF+MAauXlSgqZtbYOGxTpbXV?=
 =?us-ascii?Q?eIa7NWZCPxLMt5MFIK4nEq6IidkHt3i+J1G2xpZBKEc4f06UKo2WmQkbiVKK?=
 =?us-ascii?Q?0yl0kvuOEvnFN7hCYr2GYgOSUa7o9BuwWbKJAG0rDlrg+GKXwZwMsJicJhVU?=
 =?us-ascii?Q?pOvaG7V+0NTxjtUPJJyR68u5Ck6R8qIyXhfFUR5gEEfNfkKp52reesIGw1jd?=
 =?us-ascii?Q?zcCR99pbu+/zS1ZbgSAQoAWnn9mk2+IegITQNvpFdDw9JjsmRctiHdAZqNLs?=
 =?us-ascii?Q?vquNWHHMKZZc0zq20HEKd0rDEnVcWD+VuF8Uh1C2KTc4ScX+EYw7Hir8umdn?=
 =?us-ascii?Q?rF1pv9d+JmLQS4Fdp5uDaSky9Z3osveYgCdACnIJngT/wX3XcXU8qVM0Nsgw?=
 =?us-ascii?Q?Ew4+bk9g5tQ3IP8KESeQ41Ciatt3+EUFK2axwTg+2R1U8SyU8oLpKasJJ3ZZ?=
 =?us-ascii?Q?9ny1MCoxN3eDKrO8UTIPpGxJmvmmjEnAMyaGxCflvQ+mEm7oSJDDOONW8EJR?=
 =?us-ascii?Q?uRXYJ/tKvKfvg5o6gorVRXG5hBpAIsfffOX9xLrcWb16Bmq4v0CD1PMJF6i2?=
 =?us-ascii?Q?twRRQrfva36HqUy2wMx6onV/CfLKz8boTWc7JlFg4vgMnOMJxN44nrMSikDY?=
 =?us-ascii?Q?Uvi27pRgpYn43JNb34E20Mq6M8pSRm8PbUcjkEEhSUrHVuogEobaEXhKfCKa?=
 =?us-ascii?Q?CU96riZkh1vx08CH8UbcS6J7UFG/clZ+2k5vzL7pp6kppCngjFahsKoC8dLl?=
 =?us-ascii?Q?NCuPpg+1tRtpYosifAAPyn7mWbensB6Q3ns3KBQK0lkOp9fBV93wdSqeMlWf?=
 =?us-ascii?Q?ANmblhk9bK6KEtzZPdTwf5ocUFJSICw+Xtv+yMfYgN1+3rXHi//5nEGlTpax?=
 =?us-ascii?Q?k9SLXT0Bb89Ca8y159OVX+xdLZv7FBr6COdOmnureVLUlQDsnN+xIfzc8z5q?=
 =?us-ascii?Q?3l73tnxj32uhZfGonSIJv8sy8WnTGuud2DdcM6F/fmll8rxAsAb7HzrhfFq+?=
 =?us-ascii?Q?6ENFlA4iYx5dHefd8VLuC7xIU4mGLH2BDTqN8tFM6gDeop6RRFzlT3PKODqA?=
 =?us-ascii?Q?F1ff1jQq8wiGvZbPeTZWnEjhZAEyrOoZsxvrGgWWxncfWhIN72m4AeUrpjvi?=
 =?us-ascii?Q?wKIpABswLPm+7NLPReWxk4D8AelA9wZPk8+X3yKQldggC5Qs4s4X3fBJq6xI?=
 =?us-ascii?Q?ZjsSU6gFfXQcQomYb1/w6mUGLTXjamoi+2T+pB6gyVx3t9vvdsSuqudKKlBv?=
 =?us-ascii?Q?HE43yJK1Rb0v7oPbjlpOJ757bBZfDthgE4mdb9dQgcJ9sg1YX0JXfM5Dlk0p?=
 =?us-ascii?Q?N82n9dNFvaNDZGq9J6d2S3sQ8aHTky3e5HE6zutwzzd1+FmSNvYxFRKEzT/h?=
 =?us-ascii?Q?iYiqVH/QVlIoe+lLHe5QZ2hC8jpTPrU7UU8hoOIdI+fuFM1GQ/dveprHAD6L?=
 =?us-ascii?Q?vl1KMt42aujuF4iDM3j0wrA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d26f502-d491-42f0-cd74-08de07ad9031
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:56.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urLDWch8+W1relj0WKUvNVReAuKbpV7FYfZ3fKuhVEQQYoGwPnb+FfE6p8TNArl2eQp8xPJQS/g5hch6fhRDlrJfQ4nOC9Iyr2gFqSskBrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

Makes dirmap writing looks similar to dirmap reading. Just a minor
refactoring, no behavior change is expected.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 50 ++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 5ad3180ac6da..e90fab69d81e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -672,6 +672,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -684,7 +686,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		break;
 	}
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -748,7 +749,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* trigger dma start read */
+	/* trigger dma reading */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
@@ -806,37 +807,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
-	u32 wr_mode, val;
+	u32 wr_mode, val, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		wr_mode = 0;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		wr_mode = 2;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
 	memcpy(txrx_buf + offs, buf, len);
-	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-				  DMA_TO_DEVICE);
-	err = dma_mapping_error(as_ctrl->dev, dma_addr);
-	if (err)
-		return err;
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-		goto error_dma_unmap;
+		return err;
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		goto error_dma_unmap;
+		goto error_dma_mode_off;
 
-	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
-	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
-		wr_mode = BIT(1);
-	else
-		wr_mode = 0;
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		goto error_dma_mode_off;
 
+	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
 			   dma_addr);
 	if (err)
@@ -850,12 +861,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
-			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
-				      op->cmd.opcode));
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write mode */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
 	if (err)
@@ -887,6 +899,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* trigger dma writing */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
@@ -931,6 +944,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+error_dma_mode_off:
 	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
-- 
2.51.0


