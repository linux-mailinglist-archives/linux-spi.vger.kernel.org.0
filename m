Return-Path: <linux-spi+bounces-10086-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6BB82147
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D758235C
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8411C312830;
	Wed, 17 Sep 2025 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="CWfbLQlM"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16E3126AB;
	Wed, 17 Sep 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146367; cv=fail; b=Sw1ZN1VnAG8IB8v65xwDbgiu7SAAj/3oG70xkMOeu3OIopvOzcKPLlcvPi8eNgH7NbzOhcYVB5MOCkOFmrtdZijb/JYy+dAQ4b6nsVpkgJndEaSTDC4jkoD0lGZi7vPTAQZM9mZdwP5Y5EKHR2zWXoik6cdwFb86BWkZthMU3Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146367; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eg8RjTc7wKjrZatyaLLwywZP5LOlQErkU0D9kDk08YBTGgS3ki3SXiIq0UscILi1CVLefWo29NeBZ/RX1KBTyYAR6vMUGiNmdjTFVdmwOgrGNzkpNOjGzDTOBJoLXSWH9hN0DJty+9BBAFuOWp/kS4oW1cPLCqqUE4BB1f3L21U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=CWfbLQlM; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvlhuuwjR1tdg7FSCh/KVj7mMt90ldwvT9lR+mtLWkoil444Sqo1KhFvkrPixCZcS2tv3ELs416h/remdmIKB5BRwompXCvj4JmDc5xuyXCsWtHJf+QN0aw+xlr+bOurDapfJuxIKS60kKbFrxZsUqzs8rhVnugYCnk5w0nL/hJUJyVL1/nOYbhk8wphzPEdZh13Y+7WNp7G3btiIYbZFRQlhJuUQlf9/tx7kf8YngOKCPzbp0F/QgTNYriwpcoiokx2HNLMI0lOpdm/n4WlS3CHoy9JX6g80hzG+yBuWLpeR4RTTi6byC0DyX8N0TUuUGEcwR0z0EsrQu5b4tCl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=rFq3D5kyAQ/Y20tvg2rTR4prsYQNnDvwyAyurMPE/arxFlcrq3jJLQrM9EPeHJssqd40oe43d4CW8OR4wvnRuUH3VMTt5xrPn1Ykl4+P2Dcaa8W0jmImYfeJpXcUaoqD2k7jkdi1/Q8P6IN6qVG9h+1JSGy9GQGVgjueG0z12aX/jOTxGEPbJmeNvuI1zaRjhIvtA0A4GH8J/ghwNyV9FRiDRMFcWQ4WRrZJPUShE2bJ1wsIs9+4QGJfqwznG06YNylT/KV6RXqACy9VFUhemE/87k4ekr/Li/PZkcJD8TFIi+RUs5uT+PrlsCIpr+sb/0SRGYt9yHevhtRg0ed9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=CWfbLQlMmT5l4Lv8p52HISqH2Vr95Tt6vCoXHfdDW0UYckxw/L6y0ABERzIe853cQw7SLtRA6iFkSnCOd6uoyM39fB9tPcUhxEssNHC2QjZW1FJTnSY6i2BtdWYxucj1pAHW5l92NAfmVHVEOsKr8GXzcecOEggXbs/jTTuFFqs93+kMwpjp/SyxrWyAfF6Zbg108cocli8x1XBY3Xefg3fH5Zi/wxlsJLoGvAXjz2NLiRf6kQpVAGHd58aRg+AK6tyoirIBMwGd8uJO43KvN64w5yZFz92MqmP26/FXSauKFq/2MUWPLDQrUVXnGeYp9VKsvjD7RL8WVtIkLcH2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Thu, 18 Sep 2025 00:58:48 +0300
Message-ID: <20250917215849.19720-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 034efafc-04fd-4251-2a03-08ddf63573a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mewNuLefDMYOyWfAa3oRi8OyPSTj+o28CVjzWQrMtdrrjKA1zq3LjAb26Cgh?=
 =?us-ascii?Q?55cwuEubjSp30MX80IBSEvZg/kJUrtJ/MKtYrPqkecCUQF3nGb+tqK5aPp9Y?=
 =?us-ascii?Q?y4ZpZk6c/gvg9uE+GU+Z1ts/EIQnz5uIAwQvux9UCTgonF3EPXMsKm8nMOa1?=
 =?us-ascii?Q?ENhjU50tYNvjMEgrmX7tHrYraoiROOqK3HCBmPOvv2Tqh3XijTUExFChR3oY?=
 =?us-ascii?Q?vM8BBvnkldIa9sF6ZXN2BRQjZ8cUXm5Z5zQwlsUS+qdl4nVRdZovG6Nov2wR?=
 =?us-ascii?Q?Nwn0GsgoWmDwsRt5LNB1nb8B4ahhOesIKo7glHN29sqHxg/EqLBp2F78bksb?=
 =?us-ascii?Q?tzGAIawosHhANqvHCgpTzQDeuGkUJreYRzBF526j0Z8VLPC6+ipC7gLUPWr5?=
 =?us-ascii?Q?0ORqkMVAQBljhzHkGr1b5u1xhJkYwCDLBHUcHM1O2w9AOWOV+/FhrVAKS4Wx?=
 =?us-ascii?Q?oVmQSGOdmZIA/V+fPV6Bd0OQ8EY/gimugPD+ipD9DWhcMJZJImv4elWUc/xi?=
 =?us-ascii?Q?LOLv18FIVAhPzn9gfMTmcQGIyMtEO4LBMn93K2gl5/2Kgax8jXZLhxp7Gdct?=
 =?us-ascii?Q?lYh1JjHjhz5rCoS2WG+xipE1+5eAU3VZwRyInNwg5lHzCFE/0u8mqh/N62lm?=
 =?us-ascii?Q?jeG7jabu7sAdJydSUp41onNtwt+eWOC7EpxXhLIYCUHL+6dENgOKDLSc8tOR?=
 =?us-ascii?Q?0JjrSNYDpkOgAgEVLpGqFVYuKfYx+8qowxxc2o10rSFrbhym+oOIRFX4GGxp?=
 =?us-ascii?Q?0+fUDqLUTOC2fXAstUfTak1Zhm8ffDbtOM9fANeLEZ5dYA/9qy7e/YTuo2U1?=
 =?us-ascii?Q?ma2mh0a00CUKxiY/g6bnLxyNthmKmMm+yEn8cugMOC2fv+WzlIdgZWLkMcFp?=
 =?us-ascii?Q?hBd4a6r2cboxRhRVy5bTPjkv6+Idjpme8oAcAoSSSPK4WsCxaggMRRzbeyb6?=
 =?us-ascii?Q?tvBehhXYDPJUxGW1IONtdYMi7ZfAmAxZnHoms/Uju3a5wt76a7jwjxNOxbmy?=
 =?us-ascii?Q?IxVdMnOB97Lga5KVt3d9K8AZhNy1eDMeTBxDgfY+5h0fGdjcI5lR8fdsgByW?=
 =?us-ascii?Q?5gNWqeMajwosH2Knuc8lJz0Ym/hHK2nz8NRYYickcORfgFFlxzbn+yndeqFv?=
 =?us-ascii?Q?Hdd8Iwto91FPs4GCZSuile9bC6DWZ95dCzx7OvLBDYbFQTLl3rIpJhC/w47B?=
 =?us-ascii?Q?wS5LHR7wHEw98AlTgerKZpLqLLcc/C4s6VBS1VU+31zD/taz+5uZLlk+76bb?=
 =?us-ascii?Q?97iBY2JoUqhzn02TfAyxubDC2n0lUhq+EiV7ALBkbZuJ6z1qcqw0tfCRAsPM?=
 =?us-ascii?Q?DwqA3GQ1KAs5uczRvenUyJ35Ron8vJWv2TpPDO+sY+iIxX7KqBgVWIJP9VMz?=
 =?us-ascii?Q?9plj0ZLpX1FZe0UL06U+zkmanfILZOA3b8ZwoLdSsGHQXsigJuZh4QfJDSJp?=
 =?us-ascii?Q?zRUJOn3hbyJviRe4LP1h3ANpPLQkWWaPcmKRkANTLG21FAOtgbJz1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fga0idcYPyZBPAoQP8TnvXBRLw33HdxguDXT3u2moJgLcrveUCQutKUbQjCa?=
 =?us-ascii?Q?l4o+axgD3kr9dS5p61lLqEUucVTVZBgLdryjd1/6io7gcJER8I3U5pSqW2X+?=
 =?us-ascii?Q?jP0XdBupEOMyROiGI5kBGlBIy1znHroIm6loCYYJmaNSg+2krs5B5Agf5wjv?=
 =?us-ascii?Q?h/Eh2LGhFF5Dr+E6pDGwUnRRRVUdj/mxKiw6BzIf3iOuzFd7aACBBLMIKw1H?=
 =?us-ascii?Q?rD6l5PQWmA3rBbeGT3NbrRUyju/NslYqvpq8/k2V6qZKisGpivtSCjWgNmGL?=
 =?us-ascii?Q?rEUTzinifHgK5inRezkrHfhOkycdbsbehuVxdAUuxtYMYx9xbRIBtuij9L2q?=
 =?us-ascii?Q?bvcPS2pb1Jrayx/vBT4Peq0QFM+LEC9HWSqjyFt7fMYG4fig5l230aHZUWPE?=
 =?us-ascii?Q?zNYnAhfqkAlOMQq8xlyMWpjef3hkEzjcdFYmG0MuLUQLV4jKxN4jbINVSq68?=
 =?us-ascii?Q?mW1fZ+5xbcRtoiCVIyj+oNFgEo4pNjj9plwZKFp8IAN95ZzHBmQHLFTlaAMf?=
 =?us-ascii?Q?xMB1q9erKSIjWLtiVwBYBTl9wBnaI4KbQfyhagUcbHFmdVncuS2R40/dZRwd?=
 =?us-ascii?Q?tdk7qQon9IUmkyCq9LmqarGfVZKtVqKf//aJSaYpQlCsiLn3Xv8oFymfpzg5?=
 =?us-ascii?Q?0RowBG7KOOIxUq0Nq/EzlMo2DVp+ICULPst8JeVdbMUDxmj3BWNutOEOT32y?=
 =?us-ascii?Q?xJ+XeHHPz0HPDqJpjVZDlHE1E/YPonLA8betUOY8HVHb6saXSAMy9U+lP63b?=
 =?us-ascii?Q?WufJLG8MAvukhd0OEL3ASaSVE3U24VUJT0cmpW13WcJPQR/qvgEjBWfUKVyA?=
 =?us-ascii?Q?sfFGchCMbGwXLVjzMKQ9O0HpmL/mFA6PK1b2Y8AR/GhBM7ILB58uDj1OZ4wb?=
 =?us-ascii?Q?Z1AsvIDnhyWfOnwGCZvSrwZ4RPpNFsHJuEHNSzVJgZrFFoV4c2sxnHFwDSnj?=
 =?us-ascii?Q?flsdh6vz5DMT5sWOO+bmtJhVa0cNznslAQ6qGwoVRA5xb/bwd9kO0Tqu0ZxR?=
 =?us-ascii?Q?pPfD0d6GIEuOqiQ1B5bxfxiixWdzYKIi6xOERvFyHEaJ7rqoq3ZF9bDXl2jG?=
 =?us-ascii?Q?F1Wjts0Rhs3K+zOqgIqj/BIzIW0xd8FyN5hC/hD1hjaqeX3thAb8NMdU42R1?=
 =?us-ascii?Q?ntQqsHPly9B6XJNrj7R+t9AdkmiQNm5dVe0g6AFPX9/EtqRrIMaZ8+UazsSb?=
 =?us-ascii?Q?eI5LDYPlBNvOZQMGfmCwIowM26PQIgaeennUSG69XM5E86Cs+2bjKOtfB1Ny?=
 =?us-ascii?Q?2xvd13+BuI7UUqTpZosYWzQzZ31ZMTD1pQYGwHGRcs/5C6+dFQRC88hPYnC+?=
 =?us-ascii?Q?TmtOGYV57wJJsW++nemM9wEyXQRtcToTBQ4allIZndzw5X+/DSazHPkU1bcA?=
 =?us-ascii?Q?FC/Ic2STgzRm/umSLApBxJSCitgj3omkakwDv7U2JV9tvXv1pID1+qdx9A69?=
 =?us-ascii?Q?B9My4GJo8y1lXNiN3mAl/dnZwCmm5QRROGIDhX00Dntq2jS24R9J/tBMsNzz?=
 =?us-ascii?Q?nwFc48txcbzb8txh12TUllnXQ1hmbbtJyENsJ63Lc7+M1dsWqRv5K0UYTsdN?=
 =?us-ascii?Q?TqyX5gRNP0S+hgGzuLm3VC2OGvLJhAXdo4Qwbagf2+TGQtYmDBRSyBb8e4j9?=
 =?us-ascii?Q?xpRuPBNGskdzwB3FWTi5vdk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 034efafc-04fd-4251-2a03-08ddf63573a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:19.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sj21vdukNyl2fND0cM811usT5zvmch5kKgDnb3pBkuy3cxfrXPjk/SE3/k2AwrPInYQSjfv69wuCt2Rd2Bj9M7eAd6RVi2NOBGMiaPzRQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   rounded up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can remove a dirty hack that reads flash page settings from
SNFI registers during driver startup. Also airoha_snand_adjust_op_size()
function becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 115 ++--------------------------------
 1 file changed, 5 insertions(+), 110 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index babf7b958dc3..437ab6745b1a 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -223,13 +223,6 @@ struct airoha_snand_ctrl {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
-
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_ctrl *as_ctrl,
@@ -490,55 +483,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_ctrl *as_ctrl)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
-	return regmap_update_bits(as_ctrl->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -571,26 +515,6 @@ static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 	}
 }
 
-static int airoha_snand_adjust_op_size(struct spi_mem *mem,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	if (airoha_snand_is_page_ops(op)) {
-		struct airoha_snand_ctrl *as_ctrl;
-
-		as_ctrl = spi_controller_get_devdata(mem->spi->controller);
-		max_len = as_ctrl->nfi_cfg.sec_size;
-		max_len += as_ctrl->nfi_cfg.spare_size;
-		max_len *= as_ctrl->nfi_cfg.sec_num;
-
-		if (op->data.nbytes > max_len)
-			op->data.nbytes = max_len;
-	}
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
@@ -641,7 +565,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -833,7 +758,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1076,7 +1002,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1101,36 +1026,6 @@ static int airoha_snand_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
-{
-	u32 val, sec_size, sec_num;
-	int err;
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_CON, &val);
-	if (err)
-		return err;
-
-	sec_num = FIELD_GET(SPI_NFI_SEC_NUM, val);
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE, &val);
-	if (err)
-		return err;
-
-	sec_size = FIELD_GET(SPI_NFI_CUS_SEC_SIZE, val);
-
-	/* init default value */
-	as_ctrl->nfi_cfg.sec_size = sec_size;
-	as_ctrl->nfi_cfg.sec_num = sec_num;
-	as_ctrl->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	as_ctrl->nfi_cfg.spare_size = 16;
-
-	err = airoha_snand_nfi_init(as_ctrl);
-	if (err)
-		return err;
-
-	return airoha_snand_nfi_config(as_ctrl);
-}
-
 static const struct regmap_config spi_ctrl_regmap_config = {
 	.name		= "ctrl",
 	.reg_bits	= 32,
@@ -1204,7 +1099,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.51.0


