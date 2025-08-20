Return-Path: <linux-spi+bounces-9557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81625B2DCA9
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3525E222E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DD831DDB0;
	Wed, 20 Aug 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2ovOcJwf"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3331DD80;
	Wed, 20 Aug 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693220; cv=fail; b=PEvsiYmIW2LvHH5mA+SPlPk6zh80E9K/O0hLi9uMv4++pTxPgrhKGooY6pUqaRrFxFtnYrt03vDFc5vZcBlYp3X5yyONnN32jrj/7OcveDd1qfJ0Ih7CGOANNx2kr1keuxz/iv9DeuXWE050O++U4CyvaOi4gMV3ddldYntSRI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693220; c=relaxed/simple;
	bh=i04+eb8g9SXFr2bTa/+xpfU3fsY7aa+dN9+ztVa3nAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tyismydjt2VU97mCdpvE9vgozkOE11gLO5S6uI4L0h22uVg5ln0VtcOI+IDsUDlmR9FUrOMA492NGs7+8THepcIve2Zpz0Uhhj1B+UZxdGOMZmpXpw6U6s0+WfYBz8gIr5U6R/j0oOrxh4+eVTniq4ytOADlf+9MrjLU5uKqU2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2ovOcJwf; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPItSfF6F1ovOh/y00G0J6ozoADGYiNjwO1i85SUCJlkdtLXWdWVyWCvUuO6O2t5EQsLAqRlo0rmGCi3Y8ZZz9sTcnFUkiNrxOh9WgNneyrfQ/0Ti8i8X/VZkXXksrpBQBfxvnOG8tdNsWd7p5vcVWLp+ItFwGdgdmuhgEFvf2yF6yKFbpPzXko658e3JWXQ2yITO13FUXaYYzvOqpNSG3T+qE7FdCO/CfTPMbM/MlRN0tberk35k6F1q7xspFes+ObwSrCCXmf1KG5P3eLW+woZuwqjJIQEDI1isJe6dU/kPiVt61Xbas06KDOSpHAlW9ekbwGBBATyaqTxqeqwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQOWKxyFALTFR9dLPY04Nk+oS1W5+W5LD63TH6xOvA0=;
 b=muVwA1qyxyEcP9u7Vr9Wd6qi6dWrxFI3zaRGMw79wVHDZcFPhAPIScO4k9tYKt2VS3GbiBrsYPfFt5mbItYltxg46z/B3J3QmwQ+fRKJjM2Kb1xa6ooBM6exZgypWZqP/zSWauKJT1K+2I07WCJ/Q6uWUTsGuPLRWkyNFMCZ+cKqdRkq/8r1GXyDQe1azR1BZ6WA7t250Le68urXgDQzmYUx8jKZWDmIC/kzA5r2J8pa9HFYymx/+KIpn5g3qEF19VpAge8BpF+sGvg7d7sPbS2ZuwTzPBcy3aY3FDI5JTMJ8jWC0mi3d+ehciklsZxL5vUnpcmfZA8CIugQbxMVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQOWKxyFALTFR9dLPY04Nk+oS1W5+W5LD63TH6xOvA0=;
 b=2ovOcJwfTxcNH6mtmoaj0FVYJxaOU6OhqbMYLZJe6nN4RxCQYoqTGcVvEsyuH+3uVHuPoFbaP3oPjUfb942TmFEOKCw0uVPU/Z2PcDLJ9tSS1H3d0SwXTkgCN9fssadq7kuyUTuKNCheup2Np3+0XKugFJ8cTjpUp0AdyuDTl5jKWCyotb/qU72N8WkcKniORhFlWntD75YKIc2XeN7kpWKhWqg+Lzh8feGlUwVLOELIP2CiReGzw6lvVJwKQexBjUzNny8Wx57d/tPFnRJNmp2jNEA3/nfWTPE1yvhaMcttlE10TN5X5B5Az9dY/q9ZYYOqkcRftWMSK2H6b7gIWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 09/14] spi: airoha: allow reading/writing of oob area
Date: Wed, 20 Aug 2025 15:33:12 +0300
Message-ID: <20250820123317.728148-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f1758c-be3c-4ef3-1f11-08dddfe5c624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXsVfBq0wkE+EkNnAuTYqmTYFCpq3U/iln1SbxRTqTkZTZVq+ehPCBMuyWhJ?=
 =?us-ascii?Q?tV9fESEQdEruuq9eE2l3JKDhiGKJtq0wdWt7GBInVOtPE3UQhndpyBKo+4Do?=
 =?us-ascii?Q?qjskIQC+hJXu9qND9eAmHmxUIf0Bq5izxxSW4MO7lABxJ+cHtQ5RBa9B8mFL?=
 =?us-ascii?Q?gHSKsDmhiOawV58r3SQmvjZx0rkOvYbwGuYPPDCY9Hmef4esmJjFV5SJmdzl?=
 =?us-ascii?Q?0fJ+vJRBspt4ijuFLgnmKrvAVsQQB/qM8sGJOASQeHzB7/UEMF9JJE2QDyQd?=
 =?us-ascii?Q?ENcJbyDM30ySjCb6cvLRfNAvrNcE8+oZxFRgkQ6ikMxM6qLqrPoxLYmRqC64?=
 =?us-ascii?Q?LcU8tFl/WPPWj103KRwUuhvTsKshMLGUKncPVCGcBOtgm+akaBcDMvslBX6z?=
 =?us-ascii?Q?36IKom30/HiC6gG3ciruWURdA6aZvPm4Qgq97QSsxtv/tYRc2AZuH2O0e0D7?=
 =?us-ascii?Q?iF3jjtESFxKGf3c968P51mdNBrRo0nPLg3rVoCbIENx78MynaX/XDjYn0SGB?=
 =?us-ascii?Q?sI9IxJkk7NSlHyouwGIn7nCQhsGEWbRXbObr1zwN8IW884IrrCVPXD9UFQAi?=
 =?us-ascii?Q?yKCXkrho8xHSaurDwqa4ZcKdG4WI0brQmEqYcLmweC0vGIkUyEsbaC9mlUR1?=
 =?us-ascii?Q?9uBp1Kl4ZqyByuknaMB8OSRKjfEeG6Ok1CIa0W2MFUigrSJn0tPbbRizBGd/?=
 =?us-ascii?Q?F4NkmC3jJF/36FwhzpS8d4E9QETudvjBmznGsHECUyGaZVIL6EUlrB/RVOHT?=
 =?us-ascii?Q?Yp8qtjZahbEOpt4VCh/A/TjZqBAkZJPMGvVX/9ADlCSynawlf+yit7f89bqg?=
 =?us-ascii?Q?q6h02WI6QywLcYGniEnD+BEzfM5bm17P9+x4Kn3K3IK+BLmGSIol1SgkgBE8?=
 =?us-ascii?Q?g3HrTHulcZpz13lxSmWpr8do1CRUt1gfc275TyD81pP/dgdu2xblng/wKI2A?=
 =?us-ascii?Q?4dYIagY2EAUf1jiS2HqMX9GDrrpCBXmKmvimiBLjw2kcwwdAL9mLU6tXywYQ?=
 =?us-ascii?Q?VrKYiA5a2ZF4ILi5ZDgTk3D1yAZkloKd8K0k/2IAUxabcWN2835c5wVqz8hH?=
 =?us-ascii?Q?gO+2XP7swtXsUEtCsAbBsJ0YleHFA/ud3/vN/UM2Pb4sjYcgPEIV+RsFsbQg?=
 =?us-ascii?Q?ssje+YkmILOjdYDWJDPkOO31DhuEM9eCwo4rZPASlfitGBuGnlutLrPYV5Mt?=
 =?us-ascii?Q?wQq4NKC7Z3UINdTXmQ6uyOVLVQK0LvrpShbkDb2rQugFlH8LFRxbQt66dsu0?=
 =?us-ascii?Q?hX/kyTm3GY/ZAgnihTDcVZsWAoJWBRB6QvsYe+tswqyBQA+GHJDMUucOYLdA?=
 =?us-ascii?Q?0IyYyaQhTHR2jCRxXmnPRUss8gpiyALf/zYfMZJwiiGvlluSzCFYDlrHg+Nq?=
 =?us-ascii?Q?eE7PH8VJQoDpIE1A+ciEueD5sX/VT5WneUOMNrDp8F7mn/B8S0sO+bZyCbeP?=
 =?us-ascii?Q?Q1qjcAlesQl/kow6jyeYTqf7WEm58NiuzFHOmji3BC3zoI2F2RsnnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBunKhoWui5G7ujXvDX0oqJPsfJC+UzViF+cr6FyYjurfOYeMuHRvIe0JTPx?=
 =?us-ascii?Q?UIme4jFt6O3b+EP1vxrS+iq1durSe2l5PLT2LobLgAEWJcrI1wi0mujb6etT?=
 =?us-ascii?Q?d7FqH6ACVGbUcyObdgAMSkIZk7muxeJyeiiOSUn5fOjg8/0FN/95DEl/oPTG?=
 =?us-ascii?Q?ZoMP+QWSe8cTProlX9JvAXdJR3EzEZR/5E9r3itFZzTg4kuY66qKxZ9d22gd?=
 =?us-ascii?Q?Oe84/ccAVaxLWG3nIJQnMUB2s5/5FyHkSdk5grZivnDuyc7DlqX9/jaKIYuY?=
 =?us-ascii?Q?nIOomhgWYME63AbDq65U7UZtVwYxNiroV4ZbGpOTsiYnOAt2VMsFjpKviTjZ?=
 =?us-ascii?Q?NeEmOp9FTTmPJS6zXj3ZYQyrOYHJU+vpmBYyhHj8WP663LzpwmbNnLZ037xu?=
 =?us-ascii?Q?SPwrpxnnqGyUL75h6Nk8yC1AiAi6ev3DTyexQ2aceeLTGqeOblHj4AWgF9gj?=
 =?us-ascii?Q?J82qqWe0eFdIzJb1nWMxnnLRA+fwYepWp2oqIZMfwq8/B9ohS85GUJwId5uP?=
 =?us-ascii?Q?aIf9oBqfutc9EHKlC006989oFx5U4iexavouUQRgQDCLimgqKP0tkdMt1Tio?=
 =?us-ascii?Q?otQG5tfPyIK6NTgwlvwLYDTj7soEB0Pt6nSyfUGO68QNE0mShTARNwbLhQfS?=
 =?us-ascii?Q?oPthvBXqR6krIvTmAw189zU/tCSF8jR7Z/wK0NJ7qO/n5oF0Ag92oIAPQtEs?=
 =?us-ascii?Q?m984RwyNfVNJSgyn7jwd5EaGMBuhXzf3trpZs9lVD780KN90KCuRG2IGvnjF?=
 =?us-ascii?Q?bSSVMBFItR2P9g8ov77JlPeRfczCS6wt0vw5Vidvtl+zotKuUlkZ9qXkQLG1?=
 =?us-ascii?Q?oGU1LzxTEnaqeuPlUDbRrLc6vWPRduCvIrf0c6D5JDGPRH2LLB7qknRZbtjs?=
 =?us-ascii?Q?/pwP0vy3xNi0bBiV2UDnyVmxq4qHApHCQ4pugRDjY5F5m4gi8vWz1VQ49a0Q?=
 =?us-ascii?Q?39ffeUN/DU1bdzk0ydwjoZu77OAnaS675zHG9yX23WwVbz1lLLANBRex211+?=
 =?us-ascii?Q?G30c4OzDHhDQC0AcFxX+dXU1Zbq1qhhNOegEQXxlwsdfe0w80VtAM/cpK0wW?=
 =?us-ascii?Q?bBCwqy4FPMtby+44PTXc7Qh79hI+Lyd0LMgYSPy3txt9l0iSy7kWA2k5esfs?=
 =?us-ascii?Q?sUqDhsF5aqHnUYv3xIvD1XFPA3ufoDNswGOIkVCURIdX23TP0tMQ+yA9qu99?=
 =?us-ascii?Q?JX64dE1fEI/g2PcJoV8L1EGzx3lSLXKlcEKrzQlkwIcoSHWd+06V/evCas6e?=
 =?us-ascii?Q?CDZ1NgrEkg4M0bZo1q7N409o0wc5FU3TZRmKDm27K7UUwe9jQ5Ifb9T0cqeX?=
 =?us-ascii?Q?qDPb6a3wQUy5GfwK8ppcRiVLZZEJLV/r/RDi2dD2HLhBDQgq0X/pIV3ikdQg?=
 =?us-ascii?Q?2+ELFxGUDQDpA+bTHQ2r5Y6pKmms/bJI3QSstMDSmZSKFi6T+RmAhmmHyrIA?=
 =?us-ascii?Q?XwV7HAu/TfSJJsg8M/LVkekGikgvQNPdWSyG7G+aTM5CU/3cMs64KHXWZe8X?=
 =?us-ascii?Q?tl4fr5NigEtDxrYt4hZZszbWOCD2THRm7U6s7zxBa/A2zr2QhSCtbd8QzMey?=
 =?us-ascii?Q?JhfaKkE196OVCJa0vU8CRR+54RxTzUMqA0EmPQpRqdPBoVr1xcjdsZwiD4Yq?=
 =?us-ascii?Q?Xuiw6S0GmdY3AUIq8o0AZ1M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f1758c-be3c-4ef3-1f11-08dddfe5c624
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:32.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdbx3WaVX3BqP2Kvy228Lw+63ZSX0/ewdLJGDliTLC6sDF+NVx11If4aaBhMSuXm5D10fpLM3XfkuCguEdEewzQzNjZyQvobKR9kdIi4e9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

Current code does not support reading/writing of oob area. Thus raw
reading/writing and bad block support is broken.

This patch fix custom sector size, so oob area will be included to
reading/writing operations.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index cbdfb9051dfd..c3348ef4fc08 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -568,7 +568,9 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size +
+			 as_ctrl->nfi_cfg.spare_size);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -720,8 +722,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	/* number of bytes to read via dma (whole flash page + oob) */
+	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
+	      as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
@@ -867,8 +870,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/* number of bytes to write via dma (whole flash page + oob) */
+	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
+	      as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
-- 
2.50.1


