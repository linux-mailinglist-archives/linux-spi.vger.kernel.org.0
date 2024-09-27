Return-Path: <linux-spi+bounces-5010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A398864E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D75B1F22691
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF718DF78;
	Fri, 27 Sep 2024 13:30:39 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2132.outbound.protection.outlook.com [40.107.222.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1C188904;
	Fri, 27 Sep 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443838; cv=fail; b=GEohlCn83CgGaYcyzRnqumFycoYu5pHfUv8/UrOx8Uceqm3b/g5k1Q0avOv7lSQo6tyUipcKyKu2bI3sj3806c0cZuuWpTFucdQcVcRvmxZnVxo8rwlwNh6LUxsp46BM24fh1M9DQOyarjscO8jWYOzgYtvAAhVDup6UynhLrbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443838; c=relaxed/simple;
	bh=BLPQobnsXc5DFv1jL4jIR6wSGaEqVPhzKuld9KO+xmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyoUydh8lAyk7OS8usP3J+imvZh8W0/gA8FNfIV7wRml3ypvLQn9tk0TRtFnxKt4QfyHl7HtWmq8IIcYuQur7wO85SmE765YkOerCOopCozrezS5gCAfHdV80tPjFdIzuc/uPp7zRRSQxRxf4fDCD1BG2s2N+ZjfYM6PkuiKsp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuJe3mYmgkPYiZ4fr5scPiCKy/scFMuen5QmLYg8ZOB56010JoYm0j2j+Smwv0eQXyCUNWpvNpJrMP6VUNv+Wp+Jr0rT6AxdSsTKt3HQSKTxvV8xJTDPFCpYb2HQ2zSB60c7iP/jFyPSzD7bSQ4R3xILWn9+ZBHsxjzD0tZ9XU9+I/TJ77d4YncnNua4fdAZy3sqUvj46CFRxgmARIxZ6YYwYD5mpY/dvC3kMJLJiEP1Ml6ircR6J9ePVubRyG23Npo0pFjhahYtILBlS1gyytvZry3oFn2h62YiRwnvvUxqR5DEUmQi5TBRSxfEECMMwFM3rjF+KMcD8Bqo4MdcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Goe23eKv0FHtvSpyhAkaUM+ubvUAUhr62D7zl3x3PzI=;
 b=NKbfwttm7GRG8MHnSyKm7J1QV1knroHr7sv80dJpujZEcXdbLYZ7Oj5yC03KvAKCrwsijhgPxP7dJwb7CQMeHONnhTLb+gDKEUbX435VVrAG7yOv3o7GakNOJGf/X25yFnSMjky47S6gxNTWRTxJDcaYBre/aF/ge2m5MYjYJ6DtE3pJT6DPdN1CBqex7jZohnkdNGqo2ABRB+Dot390lLCMwvumiF9FAMwzcTFRlXz0raQ+Jv7a/LbE4mPwPglJNFnNfU3sRsq3aitBorM1/Wg2qVG8ycq6ULoZYAnYzNhWlrIzCSL8AEyUH1xrAGOSNWlKB7GZIUQOpDMUfhrmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB0416.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:116::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 13:30:31 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 13:30:30 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	broonie@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Han Xu <han.xu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] spi: spi-nxp-fspi: Fix casting warnings
Date: Fri, 27 Sep 2024 18:58:35 +0530
Message-ID: <20240927132944.19285-4-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN2P287MB0416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9216d459-39be-486c-bcbe-08dcdef88ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HrOIOKq+dGNdGI8iqH7nHwidBSBiUVEt2FHbpWZsnB03Fdt6j3zXpQQbVv3c?=
 =?us-ascii?Q?XT1Ux1Lwqdz+618QVJ+LWUlmiWMxlzrmq40bCab65xpSgJLLhMD4uFV3+ax3?=
 =?us-ascii?Q?bocRxAUd2YjUGcdJJh4/wt1c/05TQr3E939mtUBwRApkmm7jSLOJVGgfJ/Ru?=
 =?us-ascii?Q?Q5OiLyHE7GJ9QLIiHcsHB9p/e31bd6H0CU4fZFdyNkI/ARzFRV7wD2T/zUUL?=
 =?us-ascii?Q?JqPFhvJQon/OO28wN8fYlBLuPi7/utg6gtwI4qQKjmmpmovLjg4KDC2mdkOu?=
 =?us-ascii?Q?SF90iY49eLH4o0gnZYCfl4fqBVMdViWJuu4SL2rXmcO8DR6wLHghcYolfZQD?=
 =?us-ascii?Q?lyzhNo3tZkxATAWerXl8MiuEIyi/s8XOtFpU8d9AKpuAs2fapoJr/zpfzR6C?=
 =?us-ascii?Q?9zy36MFSlJPtLYT5smf1wudkFc/GN0gJmFpMVjYDuF/rNV1iYDBb1Frg4ZBU?=
 =?us-ascii?Q?sZd53hHTmZY5snWdzQPdnpHsTE9QaeAjFZamWzIRynXmsGAeacOFXEUaaihD?=
 =?us-ascii?Q?Vv5WuW+sC1k/VR3kUFEXx6kpt47TKA1jLGccNjP64R2QkYuEh2aFPe/j+v4X?=
 =?us-ascii?Q?mQPqhIwRcIU8A6VZqNWVbYKOZ14et3tiAB+f/tYnNA+30Ts+kx1q5OvW6DC2?=
 =?us-ascii?Q?yvPmplQLXMbV66w+ZGe/neRZgpCvbSNOJZHy9TZUKH+b6Yra4af3GHzw7eFu?=
 =?us-ascii?Q?Fs5CMGAVhs+j547DPUxXP2esBTAGOL1ELMdF0OGxoyUqK2BZUR2NyzHJy8VI?=
 =?us-ascii?Q?eBgx7MvwtJYUgeJvjKYBMq8USkUI0HwE0HIwmkeufbtWtBuPphfi/dZBMtDR?=
 =?us-ascii?Q?kTGNvlkemJ4R3JxreV60jfUcCOxpTMTWsLR7XM2kI5eqABBJ4ObVv4aedRR6?=
 =?us-ascii?Q?oAnR67oeUUhetVjnraa6ejQ6qdkHqrNnvV5/wOG07UONZzhkxyO/S+Lv6twY?=
 =?us-ascii?Q?QqkdaKLeYm06hVJdE8AYlDYfVAJAuNpKpOZi/0tVcXloY9j6OkgP9fj6uZAY?=
 =?us-ascii?Q?tt6X303AdJ0ad57zX2672Fpq39Ep8eGVx98qmej5pEzIKIat05SkeCVt5OZT?=
 =?us-ascii?Q?JQn4G5W/8vM/mW2JMoFOm7AYbnYME3LJFhS8rps5O+eHkCATLBIkyB84U0oR?=
 =?us-ascii?Q?7RULNg2V/5AlOBzxeunheKiGKQNT1Bo3ZKdVvYPZnDWBLwAg18SAPk+QjD1+?=
 =?us-ascii?Q?+8leCeG39kmCN5nFN8yiEJrOpfx7ypvf7vQJvYvHleXvJhrdyiE96b5CFd5K?=
 =?us-ascii?Q?QgjVO/t6kIUYWVZGv16yMgBJ77S1vdfEGqrdYzIb6qxIJgqokHWG9hv/G6xD?=
 =?us-ascii?Q?/8ATirUoA9NiUn2BaR+xI6AT3p6+O8tTANNnWtFZz/HI/Xy1z8D8Tc3sw2N3?=
 =?us-ascii?Q?cEY/utemcSFrUdnHD1npF5gCVXqmZ2uj8d5BbhD8ZHHHpd8zYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5HhtWHaql2eI06n8ZVJEuBLyQfTa80wncr2QEpeRlwl8OiyCxS2hqI6WPkQ1?=
 =?us-ascii?Q?E3f7ZDK3pN3mjvzUAQ4ti3jO/oI2yvz41EHPSikf3tZ2w/zkzFgj8+TpK6XS?=
 =?us-ascii?Q?+4SEO96OoguWY/X7afiw+9Sp54jHdMokc+faQ3vPEEjrzc2Wsxj6PX5UsVZ9?=
 =?us-ascii?Q?blJqppJIegdE1zCrk8Os/DOC8+k5HL9JV/1NCLwKvJxoIBi2Ziq4uCm+ko5E?=
 =?us-ascii?Q?/tJtMgIdJIZMGYsGAOIrh8XQxF+IhvXHXnfHAFKOLeUdS8s4jUgOxAvytQ19?=
 =?us-ascii?Q?H+wWSFKy18Ckxx0rHf672E2pNENQ6UQFFLqZAiQnLbMVlN+n7vIiBdHuHtO+?=
 =?us-ascii?Q?xa1GO7rxQOSh9ChUNcGLBRIy8CDY1GuI8SbT5U9Y3pOyREUN2LHBO/WpZSTc?=
 =?us-ascii?Q?74X2kE+msRxfkKp4VwmpVSN0YnWWFA/6ZpNLPJ02mvKHg8G6mZ5fxw6VlwYy?=
 =?us-ascii?Q?M1qEdMbCXILnmnz9LcdRn3KznQiFHC7jkZHn3WshCZqiUl3HRwPbBAj8x7RB?=
 =?us-ascii?Q?nzpGxI/KOWfBO9+cPnJLzsN6A1sMdyy4+1Q93vbqNuyTlNPBnTGqmsKts9P+?=
 =?us-ascii?Q?xKS/uZcVjSOpt3Nq8Sezebdd4tBbaLeYWWa580XnflYtF/HagXmDNSGgWyay?=
 =?us-ascii?Q?nRVaR70RaUy46DWboS1ixKrf2leqpH79NFluVVvJN8qBq5IuWOqI/D6KfuN1?=
 =?us-ascii?Q?Ig2CSP0651vK3yngWtt+qpIlXidbmlVxUiziqU8t7vglCAzJ7D2GRWUOfjj5?=
 =?us-ascii?Q?L5aoYmTKe6MSo1kVG9rFhpMVR4WeSbAekS70Vkmitg2i2UaEWeEzP5VcLVBx?=
 =?us-ascii?Q?4SQDK31Xvqz1sDh+VGpyTIL8GRR8pj0B2AeRVTgrF0RlIGT5mDtT20gX1Yut?=
 =?us-ascii?Q?YbdYGsNuS7gqVNdAvijV6UWz5+gSoauglS2b34h6hetyjTsUUykEIG7JdNHn?=
 =?us-ascii?Q?7DAEYbXMcskfyTlmal3kN8xVZaUKkVWYVHKxrP8gj1FwJX8eP3WeeN4hSuE6?=
 =?us-ascii?Q?5yv+AKFd81RAB8zZoi2gaz9jZ3Z2LitVu0R+TqHJWNuDSIhLlzuaSPP8dFeS?=
 =?us-ascii?Q?7UsoiPEn/xMy93yObTbLiya3YhiqO9P2n8ugGhfc00OclEtBPhq2D1Vmf0vA?=
 =?us-ascii?Q?s7SyX/TzPbC6an+wPBwmxMTdvvKFy8kQsBU6rNdK8iPL3WrAhQL+F3/+Wwb2?=
 =?us-ascii?Q?ZqUo8HkwnNGRXBSmeQ9FVeGbcscM6S0S/GdpQI6yFfUju0+Q6anIkdn9xQ/k?=
 =?us-ascii?Q?eDueE8F3V8Dvi8U4CYDSnE6jhUIIeTCKf1V3nIEarnogMuQcNbrm2gmqHDJ9?=
 =?us-ascii?Q?JEKzOCO+92Zq58RPT0RjWBsZbzh8vr5rew8/RtbR0rvQ3UTYbiMwvHicpnyV?=
 =?us-ascii?Q?M4Bf4vQNGDWe2XTwf4nu+gzAokdXJfTsvikjECxdWOi3Hrr3BYPHbcPY2DfU?=
 =?us-ascii?Q?He/3VlKlZrj5+xOdf4GIfNbIMXncvkiHy+ivFO7doAr9B/SdWB6ctv5t6WJY?=
 =?us-ascii?Q?Zuu2fpFXCz4k4KAafvaAdwQkF4olia63S+2qZOyGWFAv6Gux/B1/84H24UIq?=
 =?us-ascii?Q?egIGJuk11SzkLSx2gm7+I2/0rUbpbhj99P6egOlVOMUDdeXLeb6Gy0iOGLiH?=
 =?us-ascii?Q?Ego9lZgFkOSj/riGXRuPlQgBcP/QbLNpyhVlQJRQwZoI?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9216d459-39be-486c-bcbe-08dcdef88ebf
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:30:30.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0RMW7ifhR4Wp5tgUrMpah77JYu6+46i6YrJ81ErRvo8NhGpKbW8I4xegQHgBX5zsWOzExthBnJZnlTPsZDGnPhVsCICmtUGgaDqhhvGNZfk6555o+rHgzpmPSlJyt2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0416

Sparse warnings:

drivers/spi/spi-nxp-fspi.c:512:25: warning: cast from restricted __be32

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6585b19a4866..f602bfd11426 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -509,7 +509,7 @@ static int fspi_readl_poll_tout(struct nxp_fspi *f, void __iomem *base,
 	u32 reg;
 
 	if (!f->devtype_data->little_endian)
-		mask = (u32)cpu_to_be32(mask);
+		mask = (__force u32)cpu_to_be32(mask);
 
 	if (c)
 		return readl_poll_timeout(base, reg, (reg & mask),
-- 
2.43.0


