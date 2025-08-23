Return-Path: <linux-spi+bounces-9642-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D83B32A60
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB73EA25D7C
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631A2EDD62;
	Sat, 23 Aug 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="rwntrh4m"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023118.outbound.protection.outlook.com [40.107.162.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BA2EA492;
	Sat, 23 Aug 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964900; cv=fail; b=tDYGEhW35fcFrIZSAfEwg80x3friX3luivH8HG5/XagEC5guVzLRGG6u8rFdQ1YWer4pRqQaqzuBIsRIKXAv9c7a6j8X6J7jeB15FrlIT/rm/m1nzJyhcaM+NBweeXZl8QG8TBtUu0DwdXY47kuZ+pLMR7j4IEphJl6jmCg+tJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964900; c=relaxed/simple;
	bh=itxJdX+yYNFhnxYfy9jI/J6GE2fQllGPktzUHastZLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdXwo5c3Ln+tdEIjXUv1P8D39H64ZX8NoSuYP3Ut+DIwsBHVZm/PGdFICDvXE6PU4yjKZvsETPkAHW5oh99V52GVUZ8gkHN3bQCy87wbn75fY5gtiH4+f4QKQqM+sO9d+c1sdCYQg7O8xV318hc8dPyCGkklp7zByjOPxXYr2Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=rwntrh4m; arc=fail smtp.client-ip=40.107.162.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXxFKipSz1Qlb4h4RoPip6hquokLlJ+Ti0oEdK4oaVWbOw7ItzoSRRZv5O/Ea87Ig7ELGQ4gwyq7neWzoa3SXTqqtj6oLGt6f20r2VTrQDexs6sH4qArMG7OSbECNCt07T1j7HjyvW3oBHgE+tBrDQNHxaeYsjfvcY4VDUXUg3117/uAZEVRST7AWTu3FbjywNKO3X/UTdqIj6o2WQesCruqofo4Pmc+RpwhNO7aDBEMqZl1U/3O468uivSE/6cFrx9uV8UlalRuKoAZYWnEPmPNdMItOM+0ch7a0sifexhH6PnBUPaLNQbk2Igq5ZsK34mQy5bpV5rEeRAY6HtgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF4cS4HL0Tbq6Ho1SuwttYdLot3XiUxvW0Bn5xz74SM=;
 b=HlmRLJB/VBsyRzpQLps5WEy77WtmV1bprogh9bf9ZTioO8kaxJrYEvOFM5Kfl2kOr74Ci1pc7Pe2bHVaCJnGoNqhaktsGg1aVmKpAKZXLwb5soeY6Fmqu+rODJVuyv9yHD7YtS22E62b8jGG2BBP+bEjaoQkqk8SJdYyH6JhM4ItQqJm1rsaEyH9qtDhHg+XsjdWlMg8Bwh7owrYFF6ineUlilbxgg53kJgzTNBVzN5+I4ynhlnJBpqhQAfC6mzZ/n7bSH2WX/DgtY66KGmIqxHkdik3c3ANpEvWF04h/jLlijlbgg4trVr6l2DIDgQnfIpb9UU1Iy9CijZhq1EzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF4cS4HL0Tbq6Ho1SuwttYdLot3XiUxvW0Bn5xz74SM=;
 b=rwntrh4m5PeRu7A67lOCIpq5uGYP4/p1hjIl4PkmG3c1n84grJ6nvYewLEiKEovE2RDz/TyZnbQfYzhPPJHLhhJL5EhjYUKsBEBjOrfgMDJK8VqXcz3fmNTVFl5DkYiuTOchrdXHDE9f2QALRwDuB6SK5MfRs84rhz7SGSGrsdaPkvcN8w8WGSCL2H4zzSyL6WAdkvyXNfPyjxEeSxy+zSkJX40xZP0uiIuDbZMfLHDzPwwxySk0zNCVb813yBIKpPZHxEjP8577XLArvas4KXA0pAWE7qhQzZtN8u38sCIRDUGsuKNX+4+uFg91Aaym6tpIbo+qh6XIg/nCz0VFeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 07/13] spi: airoha: unify dirmap read/write code
Date: Sat, 23 Aug 2025 19:01:10 +0300
Message-ID: <20250823160116.3762730-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b5480e-ecc6-46c7-22f0-08dde25e539b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njEpqYWcGCsy2nrcwLBVV/6neQm28ia61AGDuU2iKTvDZiUlfrW229kc+KmV?=
 =?us-ascii?Q?ziUj76s7Q+AP8azUBBAjG6dXqNIdLP5+Tf+bKJpCShgO5nCMVpxcf5OoZGok?=
 =?us-ascii?Q?DRrhYAXztRGWPX88sxLGsTMhwo4CAcNuWwVUtLvpUoXb+tQkFxcYJ7MdC18p?=
 =?us-ascii?Q?NK1WhNC75pMeeFldo3MtotTRFBhPkfOoxv4h6A5EskwvdKOyiBzB8NfABi8d?=
 =?us-ascii?Q?cTZ2Yla76rR9GC1S8ZcV8DOW3nuIvYioBpt3qfdrxGBoAeHcS+yLKiFM0ArR?=
 =?us-ascii?Q?B2Axx7QFWKnSVjFdiBTgkytdL3aU4U0vMm1J6/RK1626YKLSuFk09gMwX9to?=
 =?us-ascii?Q?Xn3GQPzkH8EwPVKhih84YUPGugxWuFGpxNMNELqKS7czDfKaC2tAArwDvzqA?=
 =?us-ascii?Q?BMVagXhFkh0I4WpAWnFqkyU35OYbTlSeGqvOL0twVVrm02//uz/l9KmXcHSk?=
 =?us-ascii?Q?f9pvcYyf4QRT3fpMkbqSZoUVR2uGa30IISuH+lCvYIUtL0QJjVofsSBxl39X?=
 =?us-ascii?Q?uC0VOaxY00dxa/dxV3TzSNVh3pbYR60BiG8AtjTW6/PGMaEFshBWluHfyvQA?=
 =?us-ascii?Q?EDKeBb0WF3Q1n4kQr3gwSZVL+6xtod0UF84PTAY8vHOYfFtxU0Wi/qXagWXP?=
 =?us-ascii?Q?pq5FtqzAUa7Q3SCS2IbrxvYJ96kQZrknTiAGY7QALWtYeoRKp1NzCZo9s67e?=
 =?us-ascii?Q?0T+N4BlwF35iw5YERnj4V5VriR0+CvSlXDFVcMGVChyWbuLOubwtszNnGr8e?=
 =?us-ascii?Q?asWmgTGDA1ohc2xXCqhmFVUnbABjpTuSCjuK5WNqyPHqqqJ4+OL82zeBpFdH?=
 =?us-ascii?Q?cyn3T95VLjRmN4YYmrpgWgydNyuYoJtRQpWMLXdBfBRoW5whIY+ZE00sTbjV?=
 =?us-ascii?Q?kWeZC3PBR/MKG57FcqK6fAYVrzfgSJmZwLIA83zLEunwSEviWivqJjV4m3vO?=
 =?us-ascii?Q?0M7vkPBLbok5dHjRAxpN9h+Stusqh4c7x+Zh6DmyewuPTucvQhRI3/6rkTBy?=
 =?us-ascii?Q?f9kL/LTSlmZOP5xk+AIG4sR6DH0JU0g27z86XqByXWTAMQeFvAjw52QMk2Ub?=
 =?us-ascii?Q?PlIvYzyuVHVAgCrhUA93E2aiywQC23mzXahTaN+pPUv++Br5fri9FqUQ/CaF?=
 =?us-ascii?Q?mBuscfTNvqSQwtfCwgNKRRkx2IWUgzQZbIAG2RFqE4bxnf8ZG/JPMGkQLI9i?=
 =?us-ascii?Q?UZmkdpMJBjGxk0s3tN2P6r174fL0gIXs5IRyvEzoBfq0RVXhD6uej4M6QaEs?=
 =?us-ascii?Q?voezGX2rfUwkbcib00aBOELwHI4SCtTd15JWdJm2pWrs+mAH9vBn5v00r9TK?=
 =?us-ascii?Q?k8wRURMtjEc4hSsUIF1qQwjwQO6f0KaPPQvgy2pnKXtMmEWjHq2FNlC/PREh?=
 =?us-ascii?Q?ZxhVhoDa+0qYRVyxs6wfzD8GNeFSADymw6BBRGhUuRgyS1O1WeKMnt1v0zhD?=
 =?us-ascii?Q?M5PaRAfYo+vcuE8G4L3a54BV7L8/WjCz4oe/6MHsbfdAzgV76DSdXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Lq8+Je/ldlbXodn7JBUjo+Vc0CjR1x7ismZYvfm+BQxoUOOYvssv5Q0qdWZ?=
 =?us-ascii?Q?c4y027+03kzJjL81u8OUg/kIk23DZI7ngXj4alV4AEGM4CjhZfjfORAH5Mcf?=
 =?us-ascii?Q?8rcBiFCOqj6bZtrAGzdPKY23Xbf3Qp5TNSzGeai5w6YQ3gwSqyNI+tLRy49q?=
 =?us-ascii?Q?6l/PMe7E/CSnCipul5m6JwLiNvgSqYeoa9SJehzs62yDvuCPp/1T+guCqLv5?=
 =?us-ascii?Q?MO1UnQcnixaGapIkYhwPgDfw6fTwDGItRLrAJFNZwH/AJRmrziXqG4LvSWTq?=
 =?us-ascii?Q?7zGAJw2xrp4q1YqwOmvtYr8jQEIKbb/lUikZZ02tAUOFlG4khuNM8nBvjJB/?=
 =?us-ascii?Q?5v+pjj8YLHQo04XGFLg+C1g1EJPlla6xTj/zZUusvXOSx8YMu3TWVJmU/sGu?=
 =?us-ascii?Q?3Pc8S7jOtzzIzQxDX0HZ79QpIneNVx7uHomgDtHFeCZZ6WWNjp0b/ppkoazn?=
 =?us-ascii?Q?YXV2U5oDQtZ9NMAauh6NJHYUINU+XtNnxVbJ/0L//6RuxWaoSc4uoNl0MDOF?=
 =?us-ascii?Q?bNXBtfeDYiRV1SjDLUodq7+fUyMzcxZXIWtSOap8qNdvKeVkt2fzq5C3gbzT?=
 =?us-ascii?Q?aZ/CZPTkwjYvNjaXAr3/A7ph82dQmPnZptKmoKcZenU1ccWh5sBKn53Zk3Re?=
 =?us-ascii?Q?lNbK3afG3yrKjx6RDiX2ZJb+p4NX5FPRhfJq+6BVfQ49KkBfHnQPJOfb9cfr?=
 =?us-ascii?Q?WVL8iBsJsPWe1Is5wxzdmKgFhDKY3xvtR7kWKnlzVbO+tN8O+YXZZsm2Nec9?=
 =?us-ascii?Q?4/9UfUide61YbtXeGC9CuEfkWC+bO346DBkuPcGYuO9nVKycp6bsaPQ+zvff?=
 =?us-ascii?Q?9K70e+xKhD8TX7vru2/xvJjSC5Dd4nlSNEFQGscKoukHIPghKWVZxTDDZ1q8?=
 =?us-ascii?Q?OR4ozkDUbgZ/Qu23k31B5MPIHox8Z3eb79gtq+D3YuhzQTcsVZAOD0XfzZmW?=
 =?us-ascii?Q?lPcctsu+7XarFtlMnOaSAkP9foylDSdlCrjhuY7WuMg9BzhsKuwR2ik90zcO?=
 =?us-ascii?Q?ZCUDq/vZ4aCd5of3H3l9tyyQWVhyiY15wFwrFFefOMCQK5VMmd76GoZCXxY+?=
 =?us-ascii?Q?523srUXa9C9m755fOXsPdIpGTHl11g9GItonAV84TfhCaRw0ImjkWMaz0UAE?=
 =?us-ascii?Q?+x9gefe9ZNmP5GR8iASksDqL8YZGjqtYwHbjoOMwlSFv5SvNHL/Iue+W6b7u?=
 =?us-ascii?Q?8/CJkKRqnr51i78tFwTxWVIHKjnIXs9Lnyd7wOABT8GuMt5SwsRIX7tgOT9u?=
 =?us-ascii?Q?tklvJH/YKS9d5jZvcPdNYXRd5OWwiCzsd4J1nmEkotPHAsklFYxUHiZRcapJ?=
 =?us-ascii?Q?erFNZGoTguhNmAeIJD/jH77UUlLv0ZATzPvZiIYktinHCPdN+NT5UaaHfjer?=
 =?us-ascii?Q?rYHZIRvnkNvJJIjWQRNHu5YAQ0y6UDsFprfyxfy1ra1I3Wb6CG97Mj+we4zd?=
 =?us-ascii?Q?3MvzKR9xb8EPVQJSywaKGFlAzIFQPaB32gMzW+7Fjt4o/XVAsiEQ5madTtyd?=
 =?us-ascii?Q?Btxsbsb+Q6sNnm7aAxIbiJY5WifZ9Ek+r6mL0EYxBSzCejC4H+oinTmbE+2a?=
 =?us-ascii?Q?m1/ez07Z6/1YTogWnXcCV8AzjpYimGQ0oVjoZkx2GgRBDmQCivBd1hrumlYL?=
 =?us-ascii?Q?08u5lC0pizeXX6uK3eeKr2M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b5480e-ecc6-46c7-22f0-08dde25e539b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:31.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CXbzQv4zAeDedfrmNY3roPHRnXHEt4+rgd12XCSat1biBazZIn/X0mfT4OKgGwh+l8MT1mzzAQm+b5ZKcv9583RRYVPO70OZdNACCmsu4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

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
2.50.1


