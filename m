Return-Path: <linux-spi+bounces-9560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB59B2DC9D
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD47B206E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954F320CB6;
	Wed, 20 Aug 2025 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="AaVn+SNX"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E6320387;
	Wed, 20 Aug 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693224; cv=fail; b=nG0HACUxshGoy7I9zbrc1/cV21LrWsi70oXk+TUrSRqAXyBqWHDxp44hqwsWt1DDBWgVwiExY+XvPPFvlC7LJfcTBmrixLe+gkd0nmxe7DDdK+qzbougjkxmd1mcWbNUX8T+8Uy2uCFjJhTLogN2DP781WZtUBBbDnhKYB38AKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693224; c=relaxed/simple;
	bh=6XfGr4khJAJ4WeTkCIjZCUiGAr5orp5/tPEMM/J6V4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rtiPvEZypI3ExnQ0zyWg6bSTsiobKd65nl0Ind+AqmodrLuFgugeE0HAVlAd6i9Jj8TrC+ldv+hjDFVe4f89eSmau6nAJQLzF4K5BxbC70s5YU74zomUKIp5rLtssq4RLQYYwjF0N5DLn3e4EDTpl+hKvKPfduKLsYSvfOh4+ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=AaVn+SNX; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLgXZLSpllGz5HZj8hvHYg4XLKCr3AVZo2kR+wASp5uUlNKLQjzFjpIrAqyfG0LLcMOXFEgRCoW3uItD+eNALs2tkDs1T1QZqJrxEtjeaD154CtKLKSxAqPbyDuFrEACaaL2OPj8qVYa0kZA2mUNwakMKbTvFx2iEdjOTBcbEbMwWdQHjsjQhdw/19sXOJhWkzNKF2JFd+yU9Jk2DxAvpcKPQNQiyYd/a0xhDPJvjEda7hiy0nDR9oODopLWqI70kFcu6lwwG7hop+XtYVswNkHjG8xPPJQxaOLtoGq/tOjlPbEbXkGPXt2sl+BoKT3UNCFWYjtX3OMtSFOEwoevwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yp7KV2PrVX71F7CBS7Uy8XANyR/fUklHJmdvOxdudag=;
 b=WcNBaXQSnI23jEmqZw9CHA7rDm2Q++GhCnJbZGeUAtuyOKdlgUBARaLylbVeeDYY4Rrfv8pOsKWc5/HL25tiPjbRvatQtlipLHUeKoITk5Hw09eGOFBq7B4wrZDNmpNM7m7kdkGUxv7mVZAKYgawbANFwBIcwMb/z36GS3wLfYocrBldmxd+qe1fJrFjiM6uTpqF3FJz1inTwnlU5uNPZrbaAC6WyCg7LhJepuAMPDqLyXrTVwQtzCF2Dq03o0rDKeeISWnWchn6vvRujqskDqZgZxQRKQ+tM3laHHUMpPOTf0rcEO95zJ4lrzGrBGvHQQLrIBzhrWrCQ8/R8DAbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yp7KV2PrVX71F7CBS7Uy8XANyR/fUklHJmdvOxdudag=;
 b=AaVn+SNXE97qAmzzYF1dHFsYYJyLjcohoZLO0lkoeHgxIoDBEfgUsg23EO84mqGC2fKiC70HSLbn+DGuxvh9sTdsW6Qgohp6Y/SGd+NZogukHTlX9VxHBImaHPzHGyhjYCAX8mSK12P4QYzOBftRqGQhw/NCn6tvpo1MDn9vCzvaTg5rh4pxevarSM9LA2qTFx1VlwjodbIjXt1Mafz7AR75ZS2pR10lLwfMvrixKvAVXe9EvC9Ez/otrMml1v0NVkjvx9fGq5+Nd5Nexd0ONEjAkZzXzLtZ4laDgESSthvG4B66FsLPvOEgXElMZ1MeJEpP4b5UjBFgT2SLstZvTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 12/14] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Wed, 20 Aug 2025 15:33:15 +0300
Message-ID: <20250820123317.728148-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 1bc935a7-5261-4661-3f21-08dddfe5c7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7O1DcQr03zkYPazuu31/BY/2Fi7lB9jdxj4IX2Ha8oWImkdc0uBgzminFXM?=
 =?us-ascii?Q?2B0vX7+J8P+LI7DKZ/czRdbJqC+Rm9JBghbj8o+WthXI1vCWiiPsE2jHgvZ+?=
 =?us-ascii?Q?hlbDljTp93h6XbETkzwYsekgvOo76Ia4R7Oso9NSC09oM2BUCCrGCYCP8Vtj?=
 =?us-ascii?Q?41CKvuxsEPoC4LKBJIVSvAIaSXxAxzAejBWd2h0Q3Gur/mim0rrXa3hG78pO?=
 =?us-ascii?Q?bPUn26ummAlJsXPSJ/Zqd2bBfh8zgjTG6pC7JeS7NlLzhfs88UoCA5tQgeUf?=
 =?us-ascii?Q?eC1IDalHDfqPuxImEPFeTZv+zwPs+hdVe1ztfxVGUnE2DTB40fGoa49K2syn?=
 =?us-ascii?Q?mzaNRIDXp5fMAF6e3/92wl9ISTqxAH2PXMzmeZHaKPP3ZFjZxFxObKQJ/fym?=
 =?us-ascii?Q?6fO3RhemG9jrdX388WPMYuveyadnANKbMcFG7jkNNOiq+MoaDtr/68id7u68?=
 =?us-ascii?Q?e33NTSmd+6krTmwBDx8f9bKOhi+fDRoLlT2RROd8bbeWEfSCbCLsjp1QPoft?=
 =?us-ascii?Q?wuoIajk3xOGBCfX2MsXE02yUMTmucmHKhr409Dv9Zpddz/jpBMKgFfcAoPtp?=
 =?us-ascii?Q?b6k9HctQTR39MhqJhopcFx8ksU5jA7+YHJRejgeF7eIPPHy0M1KkQnt4aTvL?=
 =?us-ascii?Q?82bu9KE43hv9EC+r3rdd88/aE+XEbSLsOptfCE2enOgDV//ydGnzMGYP0L+p?=
 =?us-ascii?Q?ex8SF4cQGfKmmPP5N3AKm4/V9eVvWFCSzm2h9ncP/S9DW0LfNjL+mfEr6MfY?=
 =?us-ascii?Q?ikEitOgF3e0wDcz9Wzs+2WhlTjVbCsfStkHKMBAm+5Eflwwq+UJH5c54TbJb?=
 =?us-ascii?Q?XicfHfcmdEk/gost50kcRiKr07MZFn8zSdUfwjZl9Og2AzuPCFRt7kwY1scb?=
 =?us-ascii?Q?JFqjfeHlv+HN83eej1B7vu3hzL8TV9D6ICO4fnnLwYU3R4EcwpD0n6cnN808?=
 =?us-ascii?Q?js6gcGkD+UnOCKus6VtxQBjxtjznH75KQ5RilTp8k/sKOhv34pwM4zVI3P8Z?=
 =?us-ascii?Q?ELRNlS8RUxFrDgvnm5Yi/8Atx+rqqbaD1AfPbbWH/vqD9JhzV80VhuELLT5h?=
 =?us-ascii?Q?F4Z+47gAmOV/qZw4RzPyn2dFddnLvyYjWgDlA4zAZc35kmAHJ7KZKLF+iL1x?=
 =?us-ascii?Q?IioqCnazT9AGnLFWtxMsEA6jNvjw0ZnvwoIq+PyXvc72wwIkJYaLI5pzkJjg?=
 =?us-ascii?Q?mfSlsKk1dxt5DmjdP8v9QVSJcojjZWNc1E19624rr032PPbYDUsocJ9KMIIE?=
 =?us-ascii?Q?68W8kOPA30aaZdPRbu6YlHBAhSooNKjh5TitIsCZtIwvE2BnAzjrl9ZE2Va8?=
 =?us-ascii?Q?koqZqqn6Bc+kKoiRg5LQFqVv7RAZ092BB1kROtztZrX/jT8vSo+HxRSzPMfT?=
 =?us-ascii?Q?f/gZox9GEj1rNsp6cvKC3DjpmeGfDiiv4iGnVSIyp0QsykSyseznt2+u05CG?=
 =?us-ascii?Q?M+HKVhVL120XMVAQfpPP23BzHRALSp5F45rYd1uJsuH0rhFnO1/MYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+4yvTLKqxvQ0O8n0NR+4XWkC96l/Z/lmUoKfSI0zP+jFZ+BckN5Ke/sPFb2?=
 =?us-ascii?Q?61yF9T9YBHdtHybwmmqTYfqAwObRnV2gtwAC2uGRhuJgcl3QiAYFRERyDqru?=
 =?us-ascii?Q?hUovAs4N0y+QI5l3OhAKAoF+FmbQT4O1Sk2jbD8d7TNQK5IAaGHx8Us0Ogid?=
 =?us-ascii?Q?GrME02zF2VRBUT0bgrJv5Vp1hSoLb6bazgPoiB5qUSP/DLvlis+IG3BrC+iq?=
 =?us-ascii?Q?0aDty5C3DGpxR6VfOZiJevXpV3jFuLmDsuhnu8TFIA10bJkuhk4X6F+/1INa?=
 =?us-ascii?Q?W1DECH+2dwrBdcTIL5eim4Dd3TKDc7sET0GQev4JhlLKKNI7EHqrRs7yLdoX?=
 =?us-ascii?Q?X7tXkrsyn4TslohLcm8up7s7NsrJNkRpnXlzqYCDIQbOCT3/mORfFkjiBBGd?=
 =?us-ascii?Q?XxscG2mlLrFFnm/fbSnWuUnCCkSMmbxcVt6fAKDqJ+dliNjWhe+yFT9LsIrB?=
 =?us-ascii?Q?frveznjmTeoWm+Aqrb4/F/uPwMwm58FNzg39TAIJDvcfE3mwTCZGy82f5bAw?=
 =?us-ascii?Q?/hlitPEBlA1B1j0Sk6AyfpvApodfuX020B8+pzk0yUr1+c9dLOQTMkFNRpt/?=
 =?us-ascii?Q?yUujwv+G+VtqIQgQnpS/cFEroyi1j+7BM12XVZLRKGXCt2wx2YkSK726s1uS?=
 =?us-ascii?Q?y0myJO1OXFYROsOUOUmgn1IwFE69nU4AUxBCu0RKPnDbUAK2G4oLp2zoVczU?=
 =?us-ascii?Q?kXPsZvE8rWHk9IOU/x5pS5Uc9Y/lNg+72l8xaDIQnOAIizOT2PBgBp5Qm70t?=
 =?us-ascii?Q?kRqD7B8TilGzT0DORr40Cegr1U+3L0sphU3xvGez8HClPZ88ot98cdbcb9JY?=
 =?us-ascii?Q?qq3f3VdnbV9MC1DDxNNJzu95IPdYG/xCAmAAvDTrcw5ScJSBXCCJjNz84kzV?=
 =?us-ascii?Q?ZmpYZI7KMJDbAf5ss9BKvMy2EI/HTtSCT06kpvTSprfoMf0fAWejOWzyjP6y?=
 =?us-ascii?Q?BkCYuKwfNkyLdQ8GwqgKdLtkXSQMjohGosAE78Pxwxl7NYT36cKHJ4mDPWzD?=
 =?us-ascii?Q?iK8z4zfvL3Q6Nmg2giDMkKKyRqnlLIQ7An5Z3VPdohSkUEZNKEGxBZigmzxM?=
 =?us-ascii?Q?9UMe7S3Zp9SQrRJOcdQebcIDQtCJ7N4LCIGvvsfR7yq8NgcWZqjYCmy3XA5b?=
 =?us-ascii?Q?y0RCYvfFC44It/xfMxPlH/KQPR5wae2V8zrO1qQQz9Cnjdx3Jc/rU20Oq6fM?=
 =?us-ascii?Q?Cw37L14ePYgzI8KNNWwpMfVeg3BNQh9vwTOTfoSgv4cq/1rqYYNAAjmD+jor?=
 =?us-ascii?Q?2LEJyOeUGdhNc+R58ZoyrH76wqk8jYzD8+AzQ0Dk4Xh16+VbcbwKIyPavndh?=
 =?us-ascii?Q?WXmLLtPtp0VjFpvjyfN+5s2+/GO+TkEgwLuuPZZd9vHk+/T9A4BWTgD0mMAN?=
 =?us-ascii?Q?T1VKCyo/10rMYsqzQXFoA2PoOcjQAIYwqlZiu1XvwgnX3whY68mhHpuYzau1?=
 =?us-ascii?Q?K9g/fPgIGs5Y+IrZ1sHksxfI2nZ1G5sU/mIODG6eX6qq98Xle5SgjK/jEt2F?=
 =?us-ascii?Q?6zyAOIAg5RtszkBJnRp1lvwX3+/+P8bnYf2B5FLDwrObuNoQieNOCmeGkRFp?=
 =?us-ascii?Q?r/5a+FehRuh28WiSi8I1Wl3pr+rwD92/9J+u498msN/NH5p8T4gngiXIa5Mo?=
 =?us-ascii?Q?KI26vJHFxbu/BCIxgQznxds=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc935a7-5261-4661-3f21-08dddfe5c7c5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:35.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSKvWUniolPQfh1P8NryHKrWgrNZwvDtSUbCUEsQfKdAatP56TiTVkrpv6u3xx1COii/0QoCAskfFmrqI4Qd2IylG3G/aim28B9fCjcwwvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 113 +++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 5d8e1a233d98..10c4081d54cf 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -668,7 +668,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
+	 *   - Use AHB bus for DMA transfer
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
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -712,18 +752,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -819,7 +847,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
+	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -863,22 +932,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
2.50.1


