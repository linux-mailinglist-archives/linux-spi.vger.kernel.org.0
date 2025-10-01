Return-Path: <linux-spi+bounces-10409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920CBB1F7A
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE88019C4DA4
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD82D23A9;
	Wed,  1 Oct 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="kDywf3Oi"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6928C86C;
	Wed,  1 Oct 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357445; cv=fail; b=dVnrQCMijQJJqvKOdow17ctYn6nGKw4aX9Apd5kLPcR18XZtNF69HK1H9CQT1KBATLTq46wcdHUat4dNwXBZRn0H568Rlz7Pm28FlWqLvJmQuo79uvJjZCmSK0gVtK7tl4VA3wuQqfxrhWHrYUvAOtl10uq34De+FPgvOBU20P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357445; c=relaxed/simple;
	bh=obHIhFUcGxmWKO6movIYZRxfkEvNHpdj1r8QrGoJf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idoeF0LJRN6j+9ZxSkZGECo5j7cMS0QzDuWSxRvuat35thToWvYMrK3R2kESjxusgdMf00KVkWhU8YfbyG0qXyLNUsxyiBUxoT67XBBPGI3rgO8Q6wGrLPQ/cLCd/SLtHH+cFq8rPDF9W4xjF1O+zLBxfmkdSd1MlAwbJwbXcbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=kDywf3Oi; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkZoUOvYnsKP0Yw5m2jttrc8FWN9TRMYe3GAd6Lu8OEKqDOX5FWKx2+mKKY8JzlbNOAevgCo03HRtsXNEfPzoNbLHKFtP0cGDYfLwW2slZJoJ+RXavazf1d2zWnK7DFXN+yuavVpB8Oj6PJEjA3CYUDEM+pSsRkUbOmBzDmPyVhUhUgfkJ0aaXmWms/d/tsXHwDBnW4Ky5yvtLiKhe1QLRroqqvaOhkERIB+AvifE+jhyjp1oFFLAVLnyPUfY+Y+iATH4XB+/5Xuf2OxPUSFUPnvqkEJwgT1AcLDdzSz5+hkPT5BCJ74NsASWUbyWNysesvf8A0l309Q/wfUEZJogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=wuUXtE2+sYSR7vi8Dueto91tyxlHPxQPOucaHLfxmn751xnrHlpRAsRecJkaq3HJfRDwq0rimBmBq9nKer6Lik4GyaopsXgGwDeqJDilM+1q6lvsxva4euqMh7MIYsEC1UHa41yMoQVVEUW+h6ufpNy+lXKSOUYetZzm4UtFkbInH0Wd4TpVmCqlsueV0l+GvXl053ZI8CH+MyRoaHq/BmEwpIIG+7aZOfYX34nLSGWFgkUqstUT9p8nXXA1zk4UdlAue06uUY7u5Z7Dr9995QjwPevlYR/JlOG4aoadTnY+bGPdELBYkmafaGBC92mR+7+zmqvs7pf0bgCAB/6ODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=kDywf3OiWB74g9OtveiZUp0hDnu2NE9h5Gbcy7jFZCe1SUGtrvM48jT/ZlXyBjK4g7mFYetkmsxnagykpyeu4dP/WWm75GCFj3kT0wWZ4tcsJ6Kg/vASUyAJBIuZIbZoCfFMp+QJuRfGSqjUmqRvhFvcsELpczhz95fGOXn+BUOrZv8bOVWevAoYxUJG2uKKnCP1TnMEhP+Qy4FT9rJnLPOdufWB69BO+5AEKIc/jJOry+PsfMCLktXh0sZQVdTVQ5Jou9xlDwpe4bnpELrR/7h/p+QRE6vvMs2LlRh6OMwiJSe4jfJrvqYPYtyz2BywsxcPl1JHk6a1k10zV5Ykjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:23:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:23:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 02/13] spi: airoha: remove unnecessary restriction length
Date: Thu,  2 Oct 2025 01:23:35 +0300
Message-ID: <20251001222347.3386506-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f21206-07fa-4a56-53fd-08de0139362a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h1UwCgFAT+jhD/5SyXsZAdchBAZJHJBIoVqPNXeP4FjeFBUxCOf/3WwTouo+?=
 =?us-ascii?Q?NTrdysRGZN+7a11I76lHdwzNcJAhQ8B2NB4Aj3r19xPoPKhJR3eYVIKCfO5H?=
 =?us-ascii?Q?vr4fWAkMIx1rfz1oXLsCXsolw9uLkhGnaCaHd4Ymof6yPW+tFGPPWZPacUvu?=
 =?us-ascii?Q?oLEiighkAeUX99eAvkjdD8Q7A0XE1cP+QENKHg66y4Rl9p4/S/qFbg4uRFQ7?=
 =?us-ascii?Q?G+3s5r1y8zt8Fh2G/aODzhf4lWEzYCW3ZVSrr3E6SPiihCBleVYp0mDDmbAB?=
 =?us-ascii?Q?mplbmzsGrxWR/qXGFzex2MuDsHKqRTQWvbQnFgJG4cz9egFG9Iv4qtShn/hb?=
 =?us-ascii?Q?xKullHHiQq0J1JDGCafKwOH1GeS7DeKMlAoA3wLkBDyA2mNiZAg7Pcfsg4gA?=
 =?us-ascii?Q?Tu8KQB5Zdy32B9QBugWKbSLJViv3W5GN7SDVcWkuWDUjYN34Qkbtd42ezQjD?=
 =?us-ascii?Q?t8P85sEP6LwW4Pynt40y2FAfge2RmckwFz7aWRQOyOOvbsNtqu3eURiY1ntx?=
 =?us-ascii?Q?Hdm4zN1ZRRWES8ncL37U0MxUH3dOv2T2TjMAqoKLKRocsbaW2zuIDzvMnouS?=
 =?us-ascii?Q?MSywoMv+g1YdItRC54St/IwGNSh7JsrwLiaXVKv59fDI+xKkwTTUx/cWNXG/?=
 =?us-ascii?Q?px9NhVHokHBHuzGc/KJDIUqaLMh381gS0gRxYKgAIGgCG+kUoRf+aHJyrCby?=
 =?us-ascii?Q?vKVooQaSaOM6s/xmKuKtf/hEDsB8iyKdtR1ZkcOfCaRqyyIKanCz9Qfg3x3Z?=
 =?us-ascii?Q?dr9ITKFH1tR7WSrNpUUUSGL7I39WDCqlISxYclJ5+WAHx1HeZ/9aoU+1MEdy?=
 =?us-ascii?Q?4nE10u/SU6qg7Ick9GV+vt+suvqDRPYPhE0T2CkeZuG2gzkxKzWD0i27D27J?=
 =?us-ascii?Q?zhZqiVWawpKR+TZ5OIgp7kQ0+F7jvWwnPSl+FNXudbnCScvjIfnYc2AgOdiv?=
 =?us-ascii?Q?Ge+HQBf+qKrzrKdqWgH/oNlQ717DeuIhJEF8Yl2M74VOkOZoXfLDcOXwehg8?=
 =?us-ascii?Q?rQ/rNqBq0SBDlsGxY//VbLJwodvfwP3cVXRcdZzVVG6rJX64L71hvpni0sNq?=
 =?us-ascii?Q?a3Jv3iV92kg1QWGqbU5UIrDoGX1LmQf55/VZARWd+vZluiNZih6qfOGQQ9nH?=
 =?us-ascii?Q?4ROkkq6upuQD5CQonywQCANC07wM8JM8SPMoVEsd2ZIB28u6d1r5cZu9qIaC?=
 =?us-ascii?Q?E5wYWlzBsxQYdu3TuyygXYM+Oo35bSNkY+ZlHnH5TApK/foniGGBCC2TGiwI?=
 =?us-ascii?Q?eUkBX8cT2wzjXys8vtJZtgynwIJ9X0UgsLVc8VxqDX/vv+g5mxybk9+I3gp7?=
 =?us-ascii?Q?ifhgph173NV1DJ0fWEYzvg8vKV8xObb3uSIEaRKTsfQrx0iJSteF6oq1dFfx?=
 =?us-ascii?Q?Sdik/7cQIRFHmo6WIKfU0gChDvB/IKo9xGYfIEbLD7re1MWEBGkT5ZzcBLkK?=
 =?us-ascii?Q?5g6ZciIMbFWpiRjbY/+P2r6/nkhER/Rq/w+N4fBvy5pWEy6kCAguPSTCKQq4?=
 =?us-ascii?Q?iG5dVUMEqcLO9chjIfhaK+0Dti3mIvvoJOCT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59PLEuGXt3UPFp53Lo92uYL7JTe+FzHTwdvK7vk/rJ4rXkaSgJMrcpAcf0LU?=
 =?us-ascii?Q?8fJn8PFrIGwbG8s4+aFbxukiCXUuCQsPNiXUvPCh7g6fhApSDiBd+mxv771S?=
 =?us-ascii?Q?zGOSTxboh00XMHhNU0rrIL1SlxoLZ9+yQ1uTzqScpXqzXYiy2nCLFECEQPGr?=
 =?us-ascii?Q?0O0js4rWnUwA4L3PFj9gNnTPBHwbtd08bSZbRAd57fX8ncdAPNcJWkXnNIkq?=
 =?us-ascii?Q?HcnpM7WOYobb99M0MdVthoFKU2XOm1Yu2EoHzQmHGB5Q8hmkug85H3XnqC3B?=
 =?us-ascii?Q?vFnmpTMjx0FojI7/N2LsxU+tcUNp4JiiKwTEBRXGH7hLxTnzxQUn+9xCaTya?=
 =?us-ascii?Q?7oeoKSyt49pZCNguEYslnw8T1qvqBj/t5Cw0ca0snCbsdjgwg5rXjZLTCSYq?=
 =?us-ascii?Q?P5iZDpATHlb1BTnKY9P434DWXTjUQgBKq/jB5SrruGxW8mTeazYMRs1ld0OS?=
 =?us-ascii?Q?i4R0oGCmKHvzjFYjCxEPrke9MhlLNXQkoQyVT2fRFysKyyxAGLnHbvWlgU0e?=
 =?us-ascii?Q?v4fIkrqrpN0e9fQEWJ3fLEYAnzhoGnjYinmIweCNXK0Gp8vsWbC6jhJjlBUt?=
 =?us-ascii?Q?diMJEccqWcFl1K9SudZSPYWTs1d8/hTOX5ug8j2XSOnuSdADGa5Y+ftgmEl5?=
 =?us-ascii?Q?pYS4M4rGfEDJbLtTdtnsyNCJXMuK4cMD341/Y1zREYnKgBB5cd8qBiwIZIj3?=
 =?us-ascii?Q?jGghV1nzrfDHBsGAZBGETT6YQTQC10Y5OHbU3gOtfh0TEeA6CbX96k3ULVq1?=
 =?us-ascii?Q?MzddLLeWYpngNFFwzf26q7W9KYzDznA9znhiKVhWlLbBTDD6gAKp6asqlRCf?=
 =?us-ascii?Q?uyRNPRFvV+ENCDeDLK8vved75xB0t3IcLmSZv7Zd87DI4pljXPVNWC6orYBt?=
 =?us-ascii?Q?WJopiJxmMQ968/Lqj5rlKi/YOXVRiFeH94wA8d0WhRka//0eWszc8bBlDgTF?=
 =?us-ascii?Q?I7Qw0myvAIbhKbU/2WW4/tjtN5GVXpmm2egAvGs7uCan+8ZVKOsnUQTkvKLQ?=
 =?us-ascii?Q?ceUbDhATmmw5eiUKgpuexUmm2qtLbuf1Q+U1HRF/Q+14W9InwgjvQ0a+Qx9H?=
 =?us-ascii?Q?VdncVWF98l7xAEzfcCI1xY7yzqvivLL4xY8Jg03PIlizT4kWYF2/R+r+Pbxp?=
 =?us-ascii?Q?w1J7zGv9uZy5id8zMqzsj5lgyhDHeLd50LKAupm/LbDv4tq7J3EGo8MPQ91C?=
 =?us-ascii?Q?p4fWZeWWoU4/Kch3gwa7zWEI6Q2x10zGIHTke5zUgM/O9wMwnQykCIOWpTxu?=
 =?us-ascii?Q?6JFpyV3b3YqldkIqKOVyR9PKl7Yv9Prfk9n0Jdf0+nZhGDJ9qbsfkn+GKOwM?=
 =?us-ascii?Q?0zHcEjnh9pVoun0qFM4z6SV22CAord+9DAumLwltrtX3EWl4buOXXUg9YZsr?=
 =?us-ascii?Q?VkSrt2MTPUP0x1YvJlAYB/3SIPbrngL0PTFKDXZYBmfF0gkT94lITnZzDg9f?=
 =?us-ascii?Q?HPevbIpJn766AblMgrjI1nu2scxdzOrr3FZdhDWeWnLIdCa4DMW89SIPoxQ7?=
 =?us-ascii?Q?92srIdUPcUiH6JhjnoeuA2njGRXbhHG/71azpR+y19QteiyZaDd3h9wuWkeJ?=
 =?us-ascii?Q?UNqfLQIxQoV/CVTs7soF6XXEl3q1EYpCzDhzh/63KdTrdUV6cSocrVrKhAYl?=
 =?us-ascii?Q?P2XUJY6qfFYOunlyFacKp4M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f21206-07fa-4a56-53fd-08de0139362a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:23:56.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/u9mlV+lH3t6P8QuYv/ViUYU1Be49t/wXZ+3p7g3XkqvrE8uXVkYZmK1tCjtToYzJIgNZAo3c/CYwMbqlqDLCsgC3knkjdQG1LphzMY22g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

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


