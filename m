Return-Path: <linux-spi+bounces-9611-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31846B32598
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33C35888C5
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E0EAC7;
	Sat, 23 Aug 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="lmjkNaG7"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023102.outbound.protection.outlook.com [52.101.72.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475A393DDA;
	Sat, 23 Aug 2025 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908202; cv=fail; b=mV0akpc3ViCpGVVJpRa7Z3fgfkIktiRexMsOE8gHRHz6nSx0yTjoc7xsSNAfHs4357BrEQBgp9YGSyemF4hYkmqaMI64ydauvGiLuL6FksbKkZCs3UoF6itJo9nnXeUPOK3XH2wSa2O0rWl0qyhgJcHojEmu0lHRkbMA9eTLXZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908202; c=relaxed/simple;
	bh=yfVgRyVAlRoU3SzK1GEy9nQvaGLglKASwFFrlb9QsS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bqsCM4rkUS27tyETjFEyeFSpJRp86IwYY+WuknV/ORF05QC6X7hBAG46i2pUne/sPj8ZsV9Hla6eLOeg2C5N+I2IayRKuYwbo7oGjoIRVjW0/eiFG4+uXofohQXi7yHo4pY5JmDQqnPdDBTcQVsKKAL0kOao1d84hr/rmriDYzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=lmjkNaG7; arc=fail smtp.client-ip=52.101.72.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftAEZ83I2HSeasLcwriuYki1Rf2EHLPruZg2QIu6yTVL6lYJHGWHGr10VKbwa/ZpTYaAQmH1v6LOHqweYh0lU19CUHHVwODIwUlKj33IuoqjB7nxOgkgvshG2qz5flgIbJI5lUg05umtN549bhg0nQ2Ko9SeGqrxWE6JCQVvlouZyrMoy3UTjulFAdLMe1NMS9GclEpXb+r6hAXsIMlTZhVUsZo6UD1Ai/pzlNMCl2QKUQBvEnL5e/QmVFlXmThKa0WEae3duAIO6TWKWrkeIuxyja0RcdDwwftDL2fLUeNeiCnOimjt/eBtW8Qyanjl3nFiUZwAcK1/0b0VbRUqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=oUQuR+gGvXhO4m6G8ZEE2EWGDLIW5IzwXpZcNo9nmiSm6yAAoNARz2pq91i9rNhd+KS1v1UoEKRrDx8+sJbI4chaY9fK0I3GiWGBKbySDAViHVbxD3H/6opht/kMKGyhJdSW9jzpB3f7OOkYGEVVo1MpQHEsvsXTsAP13FONXACMS4wjXZShM5+d3jEFIs4p+JbZb7j5iID6438NvlaboXoOZCFxYwYCc/Cy745n/YzmiT7tNYnUFxKHYImRvoXDSXl7VGiV2TQ0Rsf/HLMVfR/UHlf1FNyYRGSrlpOq0fBiKZcLAkPpflSqpop280HGxG7czkQWbC/Njw4Z1ZBEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=lmjkNaG7K25pNmKSFtEq708XZCAQI8UJcyBEoUa5vsZZ/uTbgPXcCo4hMWdRU4rhObOVQGddqOA2T4Ydzk28FrA0xuRFIkqZ8JITBEz+vgsd7NpBOEMTK2Bbm+Mqi4ajslfYuRyiJnk4hLJWkAD1vy6r6+rQ81A4Edpdz1zUkrJXuOeXf6/w8z1yn9EtKtXbjoHvz1vAactNDr2d64yh7Xo0BvqBsdEjlZW7XNH21VE+zS7a8bcUolQo6XQQg/W4B3HJpbrPBaE8Y1LhrYSYrBoMb0uNrMzU6slNtjwfKvquQCK9iWmIkFayf493Y2DG05p82QcLMCwetfWyThk7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5618.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sat, 23 Aug
 2025 00:16:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v4 01/13] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Sat, 23 Aug 2025 03:16:13 +0300
Message-ID: <20250823001626.3641935-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1fc31a-5a67-4951-c188-08dde1da51e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aq4a8zCk2NnnXripadfqog3QVkgjFD01CAMW8aZn1TM+sgY3LuXOzd4R/CCo?=
 =?us-ascii?Q?Y/xH7oz1KQxljt3zrUi86d7c7oDOI0haW35F4R4gZjb0ieQ2MidSck1fibJF?=
 =?us-ascii?Q?keUQT3AA2vIPffKO7tCZPFh8FDlBGfcsmcqzIavyadDJZ/gpNbRug1QnKK5h?=
 =?us-ascii?Q?Gp8XH0S+6PP6JVq5VCOStYTlgbZWNXsZG6Yx29I+nsxssWoLNdqHKcHKoEOR?=
 =?us-ascii?Q?jtn5ULTSeYVawfGHL0N67hzlUuM2JrnhDUNrKgkpptoxr0okQoKRq+D4xSw4?=
 =?us-ascii?Q?M+aT2xWH1v1HO4GCvxI1Xuf9XG7BcWINGu7iq1YkpUIfyPQzuKJ3/LFqC5IP?=
 =?us-ascii?Q?yDQSY/n+ISgOUByK4yAii6V4r2dEXnp6tX/S5j4+/gAAiaIamSW4mzj36zEm?=
 =?us-ascii?Q?qMycXWhInQU+tziQpVly4DZC358Z0gmN7gH2/1SJINnXzAc/ZypD1DPEpvep?=
 =?us-ascii?Q?HUagQhTqMVQcJac7JofBZMDhuzVihPunn5Nblhk8Haf1FlAioklDyOc477CR?=
 =?us-ascii?Q?55qGYvFs6KtYP1WJscYhbTVJvYO2/twV9fxlTPxzMS0gcxhrMzsY7yQDQQHT?=
 =?us-ascii?Q?7iEOjjISDAhdLTjzGfAucO0ZD6dv4rr4hp9DIzAT9zpI4ahNtPlWI3O5JWfp?=
 =?us-ascii?Q?ai8UOQAtCILgFICHa4sG5CheIESP0jt8tFbV3Qvj5dIf5+h96ZPU9Xus81Fd?=
 =?us-ascii?Q?E6PSewAv/2Rd0sG/9Nh0gs2UB8u8m44sDt4pJE9L6loznLkaGMtNbC6JnQxo?=
 =?us-ascii?Q?u3L2fku2EPb2BZQ9KeHDBQQ7T3k+jcbduHHcIP0HxCgnyHISyvztxeaIbwBD?=
 =?us-ascii?Q?ONz/eH40DVdFlSx4+o/LTgtvDrHZliDLMSsYyLDkNEHKFfpEaP9NmGUbOFIn?=
 =?us-ascii?Q?8L8U3A/KkKAO22wISjq44W6qQGaSpLy7dlo/iWFfXKllI1gBkcGbaV2N2dP+?=
 =?us-ascii?Q?Y8q3GpcJiOVonfVmuaKgVbUCfbPN4KoN7qz+NZYw2R6Mp5Ihn59olQiXRA20?=
 =?us-ascii?Q?nF+ZvCU7+8d//pT435FUXkTkXXya/7K640kCFOae6+Zr+nmWHgp8iYCr+rGm?=
 =?us-ascii?Q?s4Md9CButDLIs3DLAEJDL0D4rzL/fMLtR7ESbYO7qOuAp4T1QoZtYp7FiuMn?=
 =?us-ascii?Q?bl7SYwvmrIfFyeowwSRQYxc3TKnZVGWI2Qoaa96mK5o9J2szOblNDlt1cASF?=
 =?us-ascii?Q?EVoM+NGHYlKkr1gVKyUjb394Nn6PxSi81dC0fxrbEmn5hJXRzePOWsvsuzDV?=
 =?us-ascii?Q?xRyNw0mbwgvGgIHgr8H6Eeb5gCPRUR4tt/VwVmpOvacb+BGlA7uiqqHqe2kn?=
 =?us-ascii?Q?V/77r+YuXLvD2MdIpbxO2nTp81xyUWvss0Eoh5vJB3Gpq2lfiPvPrBi1Tskv?=
 =?us-ascii?Q?HRawfLIPgAXGEnDeG7gnXT2zayXkOQvcctz8lkp6VZ2FWAbgg7bDDVFEaQsI?=
 =?us-ascii?Q?q4ZRcy6lPxFOG2CiQb8KitcJonwFwEHMXCdU80+iJO/MxLMJyuXSRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kwoljv3Ji+PZ5vV6nHkNvUb4RmBB606sB74caxAVUlipADkIxfAxmQ7OXHKj?=
 =?us-ascii?Q?fAVe/DpnZSZwgXlDOt7hRGB+DjzM3yuAlXupDG+ALbawlrLXjAava5/VOAaA?=
 =?us-ascii?Q?TEANAv5uVvZhw9yh2KCPv3v/UPgN3gJtkV4FF2KDN81Km0WEFGZ9xD1puUZj?=
 =?us-ascii?Q?G/MhpQKlmpQlPj8633bH7SuWc5d84lOfTiGmujZMnoJntjq+RfnCjH6NleHJ?=
 =?us-ascii?Q?c7j3PqCFdlrhEWIG5lDhGrJU6HVg2WLiXW3iEkBl8350vL3f1orEXLvrJw8t?=
 =?us-ascii?Q?rBcXrmBGiaqHj0W9eWLx2/RZnvBnd4GfDYABfQDNb9qHFR5chpvt5Kayn0kN?=
 =?us-ascii?Q?zdLmB2N65A4R/lir5foufXSHN3trxoEHoZnO5dyvzR38+KpmQSJpeWuLYOeD?=
 =?us-ascii?Q?AE0AKqbqcOMCO2KEpt2lKYvw40LpaqGMhYiVmYLRjmPcYDsLJTh1Bo/DI0zE?=
 =?us-ascii?Q?Q9izfLQy7cXzJ96NnXyDqhUyHL/dBMXYkbuUer0f+ILYty5YAPqissER/wXg?=
 =?us-ascii?Q?sqFDY+4qPItAWaeMAkwt6V5t16Y61+Jd/gMOthCJ96z7/7wuhx01veg0s/1+?=
 =?us-ascii?Q?nPIWcUpM+8FHOnoIPl8jqyD1TnMWmhzJSooV5g+TXCqx5HEvhIE+NRe5uV2p?=
 =?us-ascii?Q?BbfJcckHtzfE2Pd6+IcM3uAi6DlWdX0RHJwd00uH6XkDjs5csHKfg6wKa0KZ?=
 =?us-ascii?Q?rUkOOfvHaXJmfDVGzgqSF5GmpagekMmCjbutAARBICiltihCZI3KN8eIOfQS?=
 =?us-ascii?Q?3IqrETu8a6LpiL1iUbVdZTv1LmNR+tXQPxT9mReZO4MZowa1mMjqMQs0XVR3?=
 =?us-ascii?Q?4FZrZ56zzxUZ1QCTyPOtiU+Z3FZcEGrLpu5M+1n9+4ne8NcoAKToG8NM2IdC?=
 =?us-ascii?Q?C++FMi9kzR1cvXH8VI6JJ0cGpy6J5vrt5346DuJhpVKd2Ht0o/VrofBC1HMt?=
 =?us-ascii?Q?uLmGeSMrrfsg8vRP5iwg/r5oAeN+8/bAr9TZproMd85+SeqE3ev7b9NXHYV6?=
 =?us-ascii?Q?FMDzF6FqH+JthNAguUB+ce8FaMaVGe1KBUDZucgx8naFugkBQ1hkgJy7C+ny?=
 =?us-ascii?Q?4Wxk4HwucLVWxNEJDzRaM+lLu2xHknYasVhQ/DKpFSwqezT+fzCCd3RHX+ag?=
 =?us-ascii?Q?DNFZF66t+62k/D1cb3jeWUjJSnEenG5g1wKeTwgMK+W8OTV6IzeH+6ww5fW/?=
 =?us-ascii?Q?5iWFfdRaXkP10myPZ133yvoya6QkiwE6OOedlDnpGMyDKcNqrpKBwS2QBF+Z?=
 =?us-ascii?Q?DLSWAjFq7cgsiltbGngd06xGlnt8yrQR3e7eGOrPBbdyJYxgTTglH4kSdMKt?=
 =?us-ascii?Q?y3d445AXieRWjH+/u5uxRNXS9YBBHp7m4YDPEK4GGZaHNEXVgL1hu3MWmF9U?=
 =?us-ascii?Q?G2p9NmAG/UQuuNOqDMiWQAgt3STubC66VUFzoL2euk0WiYeSllj60nJ6utMc?=
 =?us-ascii?Q?5eXi6FVlK18yel+VBix0ewUe1RIzNy8U/yy5zednd5FFHsm8P3d+W9wW8iv/?=
 =?us-ascii?Q?J79xWhS0zKe8wcPI7z7mD7o2diEmRR5UOWpU9bAVnLyTBNYweYw/epBjHPf+?=
 =?us-ascii?Q?7tI2j0mv1QVQjNghG/88mB3/jyGUfrh1GqO6q4WB9pqKxcufuufC4kHvLhRG?=
 =?us-ascii?Q?l4VlkRCOvy0R69yh0pKbqbE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1fc31a-5a67-4951-c188-08dde1da51e4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:35.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Wf4QN4aZL9GjJRrTQj7dVwERSY88XtMg+DDlMKDyGeAHZHe8G+mM6PCJl342KVFDq33HZwpBm1HQNmqrL4Sau4/4+/lXF4bsI+7BLieN6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5618

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.50.1


