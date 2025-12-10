Return-Path: <linux-spi+bounces-11847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3FCB2BE1
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08F6305E348
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7EC31B818;
	Wed, 10 Dec 2025 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LMvuVM48"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090531AA8C;
	Wed, 10 Dec 2025 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363829; cv=fail; b=eZwhuQ3nglnv97QEY7TRNIWLbjcb4DSq8nyoC0uRKO9N6yxN7a/KkPHzwqHVtS9sStF5qJwklyyusC3sJ7w2xFUdfDtnqr7oAoCJNi0NUwpSkjNmw2qNAyoCt3SWzXu5ZqRIdZ/kf4rM4mtK/9mM+U10Gtw+liEeiAdKA00mqNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363829; c=relaxed/simple;
	bh=ieBXOcitxWgzkcqGu7ASL+kCp1P1zi0453Zn+/Oze1s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jhc1ZkIFDUmSDQE+LxlOuqCtKD5Zpa3Xj8IMsG5hUyo+N/qd0bhQiGTtbALAsMimtLm91iVH1oZqfkgr8fDWaw0PC7ZiTjbV380cg0HT/aVgnvrpJJtpMryWKkiHdhUVYNhNjXZGYA2qsdaAe6gVJBFNQOuSIhQpkS5F1kMiHGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LMvuVM48; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDhqy26v0oc79J898bg4zQe4IW+dmLeL+qf1usAuRX0bh8ecDjfEDVDCeKEzM13Q7Fr/uQlXjz23w3oxMvHDV8BUexh46td3yop/Knpuh7xW427rDRltIxHGuZ8NAdzQ/Y3zsvAmlYuqVx7mio11aeEDRgewZvqe6/U/w17hlLiiNlzS9GrRfgQm33qgSWCYbcM4MDazw0ZtzPBxND/jdtgMWme4/cGDp1ExIBO9uh022bUZAhuvUhgR2/adMGq5pTFX9aglKmJUTqPfm8ygjtJG7uYqEizboOlEgjWS4r9fkG/lMocIoJXg5Ma329TFrHR6uuqtB3A2kuJN+SjCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7DAGcxVXDT1E2kGIN5l/PXg75UN7gSIsFXk21loY14=;
 b=rgqZmSFBrKXpLz+RFCRoJhg0aDbuM1X084LwnYF7AwJEIO5R0ZbnCHTKkj+sUaVUGhu5Bj5aVdVR0euvAh6YmgIquD7siCQrHdEnP0nqNT6pPAZaVNIPLa0+BlGR+Dk+8wRI5Lgrw6WhHuQHbTRTOEkDLIeiTWodwpnQ+1HR4d0DTZFjxtn5JowQwnOQ9ejnBxRltAn6PSAfkI65I9mlDlPVEOSAeNzK1DKgjYK1rWKsbEvXoE7LLpr269qLN4HoNcyHpx86279jR4kKdecYMbjE3HX0Ba9a8t7tuzB9CvXfI35pZXnHVgnFL7HLkkik1MdT4zdAhQf0tz+CQ/xXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7DAGcxVXDT1E2kGIN5l/PXg75UN7gSIsFXk21loY14=;
 b=LMvuVM48q5PXkoYh3VmKjDYpLFBO86M/+2JAkAI1GERgSOewm9JaG+K6nrqTniKC9qi3vIVX+qbCdw87a5zW50WDMViGCpSkjB6PyBOdFOi2XS0vkipWF6c3+uwKR1lo+ddBARfN2zYCUZ1dsyiWNrI85/rmJ60f2Xw88Gyli9xRRfvEayaq3i8Fxk/XAIpWIB3CI2eRXrRcpgtzMPMHynq5fEwu/Qj4Nr6Uz5gTmxb+C8ykLnPqIZsaDLwF2lIlO3rwe7pkdcgNivaypdO+jXyHe97xUKQiG31YygRWlHjS5nNtmoT33iWhLlqTHf/7yyvp0+f/Loauja2agAbpxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA1PR04MB10205.eurprd04.prod.outlook.com
 (2603:10a6:102:465::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 10:50:18 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 10:50:17 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	daniel.baluta@nxp.com,
	carlos.song@nxp.com,
	david.laight@runbox.com,
	andriy.shevchenko@intel.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v3] spi: spi-fsl-lpspi: convert min_t() to simple min()
Date: Wed, 10 Dec 2025 18:50:01 +0800
Message-Id: <20251210105001.3891776-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::7) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA1PR04MB10205:EE_
X-MS-Office365-Filtering-Correlation-Id: fe37c6e3-b4c3-4391-a752-08de37d9e7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ln2X3oDB3g43WVSg9wGY7tQguYY+sKBqYOgIPCu/S2On3uFzEJKUXsMLz8G?=
 =?us-ascii?Q?CVXbBFZ1cZRY8wKL8xF11kBhduMmLG/2S+vO2T23Hw8BurHWoZzq+1JJn/73?=
 =?us-ascii?Q?2Rlx8x1k0pHsl1zPi5QMQb77AqgrIh08jZjFgeV3+wclCiXi3uMbKPClKKEO?=
 =?us-ascii?Q?uAnr+jN3PFU7WrEI3/u9p/ZdNTOkj9TUGECNkYSxjD12pfNYPNQfyXi0Skl9?=
 =?us-ascii?Q?CmigxtSER/bDwoYFd6W1/YlfKWkWd/YHyDZskwsfd47/xPKCUosrVWVJwzty?=
 =?us-ascii?Q?bCTSCezg9kptcRWojBTmlhi7BAaG1z3k3ZYXWRqHOfsxqUg1Lp1t4d8sQ1Xm?=
 =?us-ascii?Q?JnRSDIws3sUeU7aiE9ArsF5KPCjlQQ6VXgdWwd1c4wAJDaaqdS95ySOzMcZ7?=
 =?us-ascii?Q?CskZNsRUlXF05H4d6U3gYh4swPMxSkq1AdzwZvvMWMmAO1MlnVcc/vVSnwIc?=
 =?us-ascii?Q?gTVTso3GcduRVT+yl5VOAA7JmynX82AQZN3Nk2zhF8jFj796hkVBhOfSaLBc?=
 =?us-ascii?Q?llm6shyyQGiOygUPAVgGGWVBb5e4OGpxFZZZsJ2u2uH+sgh+wx6niaaawEHu?=
 =?us-ascii?Q?rESSFqJzJaliKCNMDWIm05+yAVtuWG1b/V0pyN+qHAWwCHlk+NTiHEeCcFMw?=
 =?us-ascii?Q?HzG6M+XsjRtNCS5xKpb7YPAan5iwdsYbijSyczpTMOwYvaLepI4M/gg+J25k?=
 =?us-ascii?Q?x4yQWRAw98U6qCUb+BeFmqyHZA3S5a3+sDpVsjAWnllainLsIh8nsav6Qbbn?=
 =?us-ascii?Q?XqKUEy65iGDwF7mZ3/qLI3+P32chC33rNbbh9KuEgXlgfT4R87claLXP4tma?=
 =?us-ascii?Q?Tm4PcP/Kt+si3W1L6BL9eUO49dLGWY68W+h1i8KSL3nPdtY16GIt5I0WYj4s?=
 =?us-ascii?Q?1WgNyB9xAGY3EBgEFSBuTnuWtMHUbuscRHW/avkqIw2M8GZSGxIWWZLCCg1x?=
 =?us-ascii?Q?+bUQXBABXMGSFbkfEdbW+3IibugiiKdcslwtp4l+hCECQ6wBoo0MYG0D4D7i?=
 =?us-ascii?Q?EhWR48qD28HuFmml16kuMFQf+FUXlsBrAEd02hBTu61Z2w4wjJaqQMniMmvp?=
 =?us-ascii?Q?aHszNNdR9Fg5kd27/tQPnQUQ6zRv+/Oi6JGtGDEQd4BueNphu2ujnyquHuPz?=
 =?us-ascii?Q?NtGxxzQw3GEPHYx0TSUEEgMYeYcWGAEpLNvRsdZamwFVbtmu7gN/lXiZnrea?=
 =?us-ascii?Q?dfHgcbjfawQxMSsKAnkCLjxDnzS0HJGlKig6vw0QBT1TUphrfSS9N5J0BeBV?=
 =?us-ascii?Q?Z+kJYDdj+rI8J7kZdPMYygNTKr6GhVH9sbCYmIGqKW8h3fExn5nfdv0jX1b9?=
 =?us-ascii?Q?++qC/d7meOsgBt06LzTX+1VPx5Gd4TiHySNZH0LLClx/4epG9DNRtaJh5OIJ?=
 =?us-ascii?Q?OeYFaa+wGYLwp4bMZJvXg2yt+LlrcHQpCfBKpYsTjf3iguUuj9XGVXkZTghW?=
 =?us-ascii?Q?gJ1WELZJs9DEeRGVFmTGaaLeqY+pr9e7tnVX99DVFcz3RLr+ls6ApmSDBoKg?=
 =?us-ascii?Q?lswiqwwWGKOOYBhmFX8Ys0U+hv3MrAgqM6xm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yxt9LbT2lx203gZ0by/heQHf1Uj4+orK9+2MiLerW3YRGFh9nloqELwe91ig?=
 =?us-ascii?Q?m9l6a3dd8J5uIXpJPXc05IPZcsZLGFLDlXMqMFs0/Tn2OxfMwCOvEt+pu3lp?=
 =?us-ascii?Q?GzOmofohvHQzrTiU5wfXYUXfASfdmUJWA5313YsDGUw91glkB/tRd+t+cP9c?=
 =?us-ascii?Q?1zNneO/jELrgxJ2zTJBvPa1r/W3sYnJSe1HNP+ZRjWOIPFZvQkMOLIraKkVz?=
 =?us-ascii?Q?JRaTDTYteCMAQiN6NKDvXu1fTQVMdQy4pYeL9umqPYGkKC8ohnCvcXJr2RbW?=
 =?us-ascii?Q?/5OcNFl7m5Okb0fpjN1GpjwzLubJ5akVtEL3ctmR7mKpJSUjmvbBcTo0L/UG?=
 =?us-ascii?Q?YRqnImK7Ugi1jfksHeFMJ0BkXBy1TC3lH33MzzTah5fq9wO/frEvIVbEGVq5?=
 =?us-ascii?Q?FBJmDySpStD505KxJCrKY9YWla6iJEArWbZdyg/5Wj7DSk0R0vHFFF17Uy1k?=
 =?us-ascii?Q?AHxzNIt9xcneZxxMNCGh4t/vfviLnNWbbo0SzjFPanDJ1Zp0WzFVZ4K4re90?=
 =?us-ascii?Q?U3Kqj3LrBEzAvCwPEpQfizjK5/AL78RExVzgVxHRkY2bMVMy4mAqgmTLprOr?=
 =?us-ascii?Q?XQ4a9vRYAzUSNkzUaUmx548IKHDC0JQb58zCG9B3PqFj3ULQUZ4rhMrApqHv?=
 =?us-ascii?Q?GAhtXZeAc77TmZ97sfAyZNP1nrkK4RcHs39VV0+nM793s1S2SblzJ8NRT4MU?=
 =?us-ascii?Q?duEZ25RRGbhwDaHHcLUq3jdexfiRujN9jKBMXgT4oS4wzK8wHyPXV7qNRuvD?=
 =?us-ascii?Q?CnBxzix30NuCH8jclG/5d39+uEOOKzjF/6JGJJk2bRrXntpxDPAkrZeNVND+?=
 =?us-ascii?Q?eBtHokg2zM4bihshgaSrSU3nrwv0Gsjp0tnELt/SPE5mgVSZXPp0v5opbrw1?=
 =?us-ascii?Q?8srSkhcjhXRUyrjsuKQMtgazm7G3lo+HvdWpYTel0NEuqtqdctms5yiTB0YJ?=
 =?us-ascii?Q?znhAoNfEdh9DX5VrN1+OtieiNfnBN9mWO0mi1BsvYukA7epLqR+6lijw3PCD?=
 =?us-ascii?Q?PHvnRvDPyqSX3SDY49GX4ADYzvIiHiMwQa759dRnjUoEvMr5vAZMqkfYy2m4?=
 =?us-ascii?Q?3MlrHDGpTzP+Tf0FyP9sAhbt+/9pBDfnU/aBQbCXsNb3Dz+jFaJ74WarliKm?=
 =?us-ascii?Q?RYjIGhY8jvNWSn9R7X7CXnHbM2XYTAcY+BZuHihJ+qHULRcb3gt6AcOZCBJB?=
 =?us-ascii?Q?KPCtarhuC0J8yjLEZkVQkC4FlIFDOkucC1+MADiuEkMfEh2iBLPfVAp6ozaO?=
 =?us-ascii?Q?tZLu2d/A19u8zCjDIHud6HorTsDHfJhzfvRMT4V4atBAc5l9p4exakno46Bo?=
 =?us-ascii?Q?isyieEYxpzMFIl3220mN7MNX+QWqxITN/+kSIF0WBJgImSrhOlS3PkkD0DYT?=
 =?us-ascii?Q?FskQgBp4a/9GVRoFNQCQsbCTPXw8yw2sjwAdGRZNt1ag/6A5PgnCMRzrzZl5?=
 =?us-ascii?Q?1YqfFtK/ENcx+b2V8oBRiHYZfWZjNzZSvXL676ZGjghtrX5kseh125c9gIiU?=
 =?us-ascii?Q?bqaloaZNBbGsnML76hq2FLKQnQsZMUf6Z9sDB86Qp6mc2Mh8FDNUQdPq3VRr?=
 =?us-ascii?Q?RZ0ppQBgKEq8FJP6jYtc6G4MElFjZ5n7zlYLIdW5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe37c6e3-b4c3-4391-a752-08de37d9e7f1
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 10:50:17.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE3GKeujGNrtB3k8JWclutViP0KzZKeQWFauI+R6sh7uTcX+59LtG8GSyEuVEARcVo4cZVAIB8WpOtfMM3+m9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10205

Current min() has supported comparison by normal integer promotion rules,
so explicit type casts or min_t() are not needed.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: David Laight <david.laight.linux@gmail.com>
---
Change since v2:
* remove 'Fixes' tag according to David's comment
* add review-by tag.
Change since v1:
* remove unused comment according to David's comment
* improve commit log according to Frank's comment
---
 drivers/spi/spi-fsl-lpspi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 065456aba2ae..8f45ead23836 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -486,15 +486,7 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
 	}
 
-	/*
-	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
-	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
-	 * it caused wrong watermark set. 'unsigned int' is as the designated type
-	 * for min_t() to avoid truncation.
-	 */
-	fsl_lpspi->watermark = min_t(unsigned int,
-				     fsl_lpspi->txfifosize,
-				     t->len);
+	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
 
 	if (fsl_lpspi_can_dma(controller, spi, t))
 		fsl_lpspi->usedma = true;
-- 
2.34.1


