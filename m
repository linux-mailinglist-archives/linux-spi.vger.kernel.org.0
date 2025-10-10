Return-Path: <linux-spi+bounces-10534-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62FBCE586
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAC1035225D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113030149F;
	Fri, 10 Oct 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="AhIapOD4"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD6301035;
	Fri, 10 Oct 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124056; cv=fail; b=gqPBNspDOf+A1NKpBPOL/ROctHtHcx84+ADBHehbi6Q4O5Wp6Su+fjy0l6dkP4/q8P0pb1ooD0qVjXFwbMez5Cvv5070umrnmWUjOWtc2V/u8UI26uAB6Q7gWmQt51PCMt4BIYFT3ZNmN+mbJw/EV82SvbfVBDFfVzztO/IgAbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124056; c=relaxed/simple;
	bh=obHIhFUcGxmWKO6movIYZRxfkEvNHpdj1r8QrGoJf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WOxDzwwlNG0VN62MDPjWkQQdisaR8CJzl3o41YKMaZIDeEzcym1DFXWKjreYwkFSuc61IxcS6c9Ip3CuP7ucS1JLcr8jw50tD8K5cVHo6/84hdTZeaHRjzuyFxxtZ5Id47Aa+K7UX7bi9FnJvMKlp/WAn+TWdDPwfAVnok2cdU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=AhIapOD4; arc=fail smtp.client-ip=52.101.70.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVLre+FfPWfHo5HBcNA6s4KcLxsuD/txEgBkG7S/oocEmh/6pOnuBDk98TsDbcHZHtllp/ecnHdNQ6+LvImJ53pchJ0QeQBjBmqO4rTBlqJ2Fd8kVmPKFzucgq9OyvFbxB4XUjuedCcQC3+lUIl8G/NceprxVocjDTsIKNrNFdl+qg1x5ZNtMAauLEZxPE5bo1Bq4NeELO1PBVFIebj0TqG2R+KMGD7DVUPeuBom67gxtDWnzTwIC+HUetIpuqc2cKhsGwiu1dspRo2p/HIgKgV2gJV+jEqJjSZdYCoErxxAARMGZCdSqSpAVhvwlh+s6cdVnErtnPYaDngrZ7UHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=v8Xx4hW19DUwqORoyiHgP1ca+NTy3m1rHumxWfR/ele0990EtVYBmYg9u8pFWQUKY4PdumHs6Y7br4saDgela7XzmwMn3mFelDYKgXv1S0vY4Md90mI0gNYQ7SdzSmdsEepzZxf+Ofkq8OgFxZnCb/X/NHOg2OmPO48JHI4gMG63JIZfVSpMtBrrcyO8pBN19VWZJfbBZZlLKcNP33uRHvTesBrDssHEBoOcIO+WQv5qrVHLfLpO/sO8To8Uo1X5P9E9Kwg3ZgDNqyT5Vi4uHLy3mppos7I6ayJj9pai8IxnAVJIwHzhrFBJKbrj401N3uyH2EgttcN+iV5Ed4E0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=AhIapOD4jnQMCac6pYaeOt0OnC6144nrIOZ7FAqWc3bQA0Y+G2zsmmF2aBGur5X6LzQZF8PgS7f5dUM3BDT7tZTAen1XCakOD5GVexYCDO72YIFtZIrGamU7XJgD/aPl4mz43f1f2/MYBEUtEXARhEziKjaSY8VnK9eLzRlgCruQMItf4eSMmFy5OWoPTyVOXKXzupXCGfG75zCO3Q3/5Mih+2EFyu8vWcczRwCHNWGbaPUBZD4euh90OtGapcXG5ltO7LGoSBnw66kx+pCMrxMjN4MxIrxRAARRNFAbuHEYtyjlRcxnP/VdfqDd6ADgKbVzlsKhs8QNiQpkHDYKDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11352.eurprd08.prod.outlook.com (2603:10a6:150:2c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:49 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:49 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 02/15] spi: airoha: remove unnecessary restriction length
Date: Fri, 10 Oct 2025 22:20:25 +0300
Message-ID: <20251010192038.1592889-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11352:EE_
X-MS-Office365-Filtering-Correlation-Id: c3051d89-7589-4904-ad31-08de08321eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvER7p+He2KIraH68MtYtFuGtGT1JOqWq3MN25/eAydBcUBdEgveDM9j0A+a?=
 =?us-ascii?Q?VvN/0iJIo5Am/8t18Rzkd+uW1IjaNkNIvoFdPcChecSzGCk0B42CyZmbIzbv?=
 =?us-ascii?Q?j+HD4+TwCXMAYlxJV0unGgvpyEM5a4JHz1k/yeIxdLzQSXxb+I+cqQiZXNzy?=
 =?us-ascii?Q?Ml5J152DJ3kP0XjHz5k1oD6S8ksIKe6It1Zl7ctnpu1IwTnOt6VOoPvzwjYo?=
 =?us-ascii?Q?nEt6DBblmYuiFhgVnoGD/uThkjpLtdp0cMyS3I3qgF+qmT/zCuVdXlQI6MAS?=
 =?us-ascii?Q?n05LDSuxrSrL0eHKpL4CDGOxh8LgA1ovzZtad1yQJbC9Is3SemwdxC8UR1JT?=
 =?us-ascii?Q?JtE2DN6buas1CYNkBdVfycuJ4DFewc8XEK0vUr0XFTomGbhMyckyyhp+HfSn?=
 =?us-ascii?Q?NZF5G5s6MiBeO+rCz7Ep6XqvJtD/6o+Z18Lty1Ks6A/xM9BsemCTZ67J6uY8?=
 =?us-ascii?Q?/pBl7NYSPKejgvY7g0/sh2tMb7KOtwQckzFAvLNHPaAbmM093Fzz5jOW9puh?=
 =?us-ascii?Q?z7bXEL9Oqvwu8388LrZhn15jQvvtk+lXqQjb7ZNN6i13TtVkxSzrGdak8Z79?=
 =?us-ascii?Q?gZChwYA3GheGB4+6nbi4yey6HTdcRZRkOA+wcQILLaJV9JR7ZgneDhr/1uWp?=
 =?us-ascii?Q?xReMyXfXEuSs5I4p+Za7ekh+XNN+3MTz15p5V3cJvKnvS+EYaU+KoUZRCSH3?=
 =?us-ascii?Q?iVAZdcRXbKwby6Q9uJBzr0cb95Tjq/vuY3U7zJEXoNVZvI2ZrDmK2S1B93MM?=
 =?us-ascii?Q?2UR7h3kP2v7y8WkjKRxDDltnrgWUH7IJ7McPkdxQs2BiCsk+nI1xZsuo4ZtJ?=
 =?us-ascii?Q?SvyC2wfrPiTV+ZHS4vA5QcsXzdl9f4g+3vTM8mb9Z9Q4fYMdwxCy7K+IdnFG?=
 =?us-ascii?Q?w6IWsDCnFkS/m7UNdWbz4FSViXihnoCIMRM39mwipccf2Ut9MfDOGFcoBXzV?=
 =?us-ascii?Q?OBHoMSf+265AopXPAOc6W1jiK8Tf6Xi5wIYemp4O1Js3nMSmXIF1hSiM4qID?=
 =?us-ascii?Q?enqbwMxirMYmNduT+smtCPFG25GEp+YPnIQUjUj8DJJiJr7Y2hTBqtAoioOG?=
 =?us-ascii?Q?VWaOkMfSd9wovY2bjK9f7bYzi5alK9yEEtGimRLuKOFcNNEAchnfLo/jwyFQ?=
 =?us-ascii?Q?vDpdIy1/nd0I/RSqK+RvJcohP+Zx9J+RanZ3AJazTAHEv1erd3TKAOc/tgfH?=
 =?us-ascii?Q?vQSjJEuXbt33jVVRIvsIBofawctoeeIE9j6FZsEam2Dani1AMArSgeuBDnyp?=
 =?us-ascii?Q?Fir20LGkmxBM6dCD7YNWhR2jS6rEOTXI65uxRiqJ+GYiIkeUswrU9ywUmoQ/?=
 =?us-ascii?Q?XMekpyl3HVfU8ulSssXvkCIbxz4wgQ9POv/fCCcUpOdCFcQd8HQxXPqUdWqs?=
 =?us-ascii?Q?UD62/7RVAVCavq+6ksCEZRbRXxmtvtRW5ZvF1P6wBLX+OCJodMSSNZsftQzp?=
 =?us-ascii?Q?HNs0nZFeJsy+ENYjSIxMcboXavrYEemDSkfsmZWVB4Y8W50m0Jtt2MnD1QVY?=
 =?us-ascii?Q?iDp/Bt38lzj4zdxKS59ok8qUs4ArJYJJLaVObjlZ/f1eB9C8ht77LoGvUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXXau5H58XwvGpPZYc1qPkRgyF5CLCiTlMj4wyuHG3Kv483eOxeSNK8gR8Je?=
 =?us-ascii?Q?aC/C0EbqyVk3r5p5eAMBcaJRMvNsgP+5ODHuf1wjvPB0qGcvzjT4LuT8BBFJ?=
 =?us-ascii?Q?dnhQdB15htCXATpMZ5jabeVUE4bO1/DmaunmrjAWWRVdfHry9M7PijNegEqK?=
 =?us-ascii?Q?r32cqr+W658+hWMcBTkxHmiIPggHBfDtXLyMpSiYekkfFAO/X0hGucK6TerL?=
 =?us-ascii?Q?Md80GFa1CcsVlRFyhdP60h9sKJBIhs5gDJ32Q1DVx0mfkz9RdZ062YabwdlH?=
 =?us-ascii?Q?3EQzNyepl6EWuUJe6UcZaAAooFXCVc1Lc7Ds9sBJcZNSJ6/su+wL2vuczzzp?=
 =?us-ascii?Q?8yfYGzH7SuG0zmQB27jBVE5qI9JH2iIDLKJ7mURFHJOlU/6hB4OdQZ7E/IwA?=
 =?us-ascii?Q?bSG+IjoXoOK8ymHjE1cIxvqQkvECoxIjpdoTa7SxEWtRdRcF+yUN8MBBFrtQ?=
 =?us-ascii?Q?WdBMzKpbE0wm5csTjHwEY83jci+SqU6s/Li4v+Wm7r5I4oE5vvtd4z/KhySe?=
 =?us-ascii?Q?4/yn8OASsMoWiQUivKZb4YrOHjTd5hvU88+7kNKtUOQHCTxYDmqehOYIeVhr?=
 =?us-ascii?Q?3BkUHWUEp7Syq5Fs824TwqnMNH/7XRbzTlUceNX/bCHAB3eC9E+Ya6rFfYD7?=
 =?us-ascii?Q?1vH4zYpHwAdYLm1xAje6hdnE99e42cQIxSCZ0BVDfm5PGjrxs/tWCNalx9Td?=
 =?us-ascii?Q?W1L54DwfUk3HTGZN2ZhwiDnfBnXZHCXGlxaLuUiOCNIPVeTeN2YhuRA3sAhB?=
 =?us-ascii?Q?/AZN5YsWxdQ02/7WLMtMugXGfuutCuT12IqIv8Fw6G8DFcteCiV2lOfaEFJv?=
 =?us-ascii?Q?MW9Z4X3IubPdyLAUyHf1vRafOgMA1RR7trzSn4OD4Je69+coTJNYNURpt7QQ?=
 =?us-ascii?Q?K/kPcx5PKu0g+zXOgZ5RQTYT4F+puJL7iAlxwVhfHZeM+Gxo7lpgimDQ5E9D?=
 =?us-ascii?Q?9PXw09xOnYTSZApL6+ZK13JnfJFTzXRY/a07qHJS6nEuOe3juf99jRPceWqf?=
 =?us-ascii?Q?ZyFAfrtMKMMUk1Iv37GzMrc5EsZqIHpyymbXuYbpPJml2gG4y/62SDS4dy0e?=
 =?us-ascii?Q?UaRMYtsIKAWvRR9oEgB9V3SAbpxLCR5FEMjyjFDQnWIe8iheqfVERFlV0NwM?=
 =?us-ascii?Q?QGal5kV+jQjkbsb2IBT2shVklSF+0wtouJs3WxV9jcg6WTrxAD6e+al7tByW?=
 =?us-ascii?Q?2NLvsp/eb5aCX4uHz0WXxCmkjoriemzQemxb+mLnnAkDSO25vxCjTY4zUNcq?=
 =?us-ascii?Q?oIxG/IXJEO5NV6ercYVATY6UL47sGjYGCt7s4BdCfmurYm4IRH/TvO5wnB+G?=
 =?us-ascii?Q?+OqLBY9gF0vZH5JqT/6ElK/EF7xdvOXVkBrmFvf4Bzy9w1TjBTPvSGwy3CMl?=
 =?us-ascii?Q?ZZlW3gufcdduW1ng1aimrtPIcvkZuU7+rPfF3fTAsOi4kMrehNKq2frMq4ru?=
 =?us-ascii?Q?sVthx1lds2tTOpIR+CAdLYnkIhqbIT/295hBT7PzrzQTjxebN+5TgPaPgJdy?=
 =?us-ascii?Q?3k0Fn81pgSaTB1YwXmNTKJNCaOC7+Dka+AhNY2rfpUcAhc38uUmtgw5dvbrl?=
 =?us-ascii?Q?5QYwCE9gbOgH77vF3dRslY5L0WyNpyOnl/xo+9OLMR47R9t0IZk38qYWs6LZ?=
 =?us-ascii?Q?pHTtgnkIK7SezTIZ1KCyHYE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3051d89-7589-4904-ad31-08de08321eb3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:49.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRuoNGUZbrRa1AAnIFWkdNkybVwoAuQfEdQi86g1VCNNsVj99u3ZG4+tamwSoUJke31zF0vwFVzDMBOaPUJUvOXqXP0CEyivyG8vAzZa5jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11352

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 043a03cd90a1..bcc464ec9c61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.51.0


