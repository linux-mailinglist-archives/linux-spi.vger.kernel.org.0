Return-Path: <linux-spi+bounces-10417-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8DBB1FAA
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666E316E298
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C6031328A;
	Wed,  1 Oct 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2r8qyoc2"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020128.outbound.protection.outlook.com [52.101.69.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375E3128C7;
	Wed,  1 Oct 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357456; cv=fail; b=txgjele8M2aUct8nM8sbaUPHkkcMkZG8VQ2PX9JT1t3QmUHVjEXKXMTcH++3wvH1fgBlxN3Y44iA21gPK57zvANjK4JpWURdnzvPoxWjELSfkgCDQxYp1bwUQ21rUHufSNwoJQ+Wl0uggUMJb1IL8KDKbCefYCXUrH18MkQP2pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357456; c=relaxed/simple;
	bh=cBHsnFZtmlxn0wHvSPe8hsUcctWdvufB77xOkfG7jHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWa8P1XWyyhmK0WO0Q6lBWkrOjWGCTPKtYaTwV22B5VBECvoBj9ygmJIAekWKK38E62kijhiUwM1TjS8060BJk8p3SzcGA/iIaJ1r7Zno295WsYcENCdhxb4jckJdp4dtcCccYlxyOnnCFb9VTXgpHSLBId6n6RMY7K+C7CK5Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2r8qyoc2; arc=fail smtp.client-ip=52.101.69.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2oeLdEUW54sgkTvt+EanagXLv6X8YtuwpNW6Kc+jUaafizGXcHvqBeihkKMIradHzQho4eU5qaYr9KdBXUJmAzwWz+fspmo23iWEUnXWLYGplmQTk0Aq/sHKKs+zSYdS7KXgEgpJj2XgTseUSB3qfHnUUSwJ1Ekx3oD0mL9rf4Vunk38alACYErH1jGU/z8y3mDcTLZcTjuu+yrFiiOcYflw/bFnw2MMZ2mnHrFm8IZ/K95vPu4RmnYWxzdnN915WbSLEgxsFL3t6/ylO6BCHD8WyiFDIVqTnwmjYFMWZcxYrX1uaPTr16+a2pzz8ck2p8N5Yr9Mq8OfFKCAyr+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=TFpvLqu7Ssa8azu2PjTcAbrXd8RiVkuMzlL+ZBf2Ig8KWBSK4jiZ0Bm1mk673a68c1Xee+KrQHyj4YKMUY93C3U4k4ncVReD4ogV1SvfHw6nq/ABN99g4ly3/Teji/ACw5akCMDP8qQUxjXQ44nt+ekO2y1fG25jB9biaYJQbnwBslphxiEPYsDcqjYZBEOsjAKKYrSsX95K3ioleoUHwWj5e3DBYk+RFMz0NG0cir017J3ecCRzknqntWNYxNmnblgjT8s5We6qw/lNkkNLv8usij6iXDujmr8LlbCsauB5tUD6aMYXX+7n/i9m2oKYvRHYioTdfGuXBSVCXO83qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=2r8qyoc2td59QwoqRwMpebZYHKgQcL/c7WC7w3BANnxirvk9q5tSs/TV1qfFKZL20RZkq3eWJdbwJreDwhrdcLWRd4xBtgO6y+3KNL3eqO2RmRII8nLvm+MK4RXDR2HMKHFzwg8F+EStKUnSM1FAT6IwVlO18DCa+HiSHR1krJHQysiVpd2ux37yF1ZtDp2yLSwzbKA/Ofdhjqb3HB7kvR9Y6S5onVNFffTnJ/HLhq431YzxdO8qqNyyfJa9f+ew1Mcj7IwLQAtX6IEYxbA1xR2nJKRklIkAoUPoD3hWmvjf/a+M1qeMsAItSTimWNLqXS5T/uK79FijrrpulQGd4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:04 +0000
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
Subject: [PATCH v6 10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Thu,  2 Oct 2025 01:23:43 +0300
Message-ID: <20251001222347.3386506-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a2c998d3-d1a7-4a77-249a-08de01393ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxuT8jtFNR6vMZ7DncefJjsAuOo9nU/r/OEce98ewP/z3h7n7LfzUQV7Qsgx?=
 =?us-ascii?Q?lyrwwJ7ap/iPmODHMFJjeGdOILe6BP7SYtixNv57w4wPw8FExkKuxTh8iOJ3?=
 =?us-ascii?Q?2rguIyri6bdxz7qiLV80GfyZaxPEdEVDzz9nI0N0QhOtMQwBZkQb8pebmo1a?=
 =?us-ascii?Q?J0lZk13SK+HEzFNtxFNF6WRLlJJ4HxdTsWa5Lyq1VVMUqQyP+qAniLQYLvDq?=
 =?us-ascii?Q?H4PrIPy57SWndsOhmB1A8IkmVUanktnHZOooeuy16kSIxlYYGbZQ9Edf5qe+?=
 =?us-ascii?Q?SunMqlU3HGqNABtOoA3YHMTvbv0CBLVyeAPdPhGZx/kJp8fJOQbQigi7SZlj?=
 =?us-ascii?Q?fUu3ET+CfU/ss0GGeif9/rrX2929wV199/SvuBSZmFXSbmPb9Q/TyK0UFKs0?=
 =?us-ascii?Q?wAs8lelVydrCB3GGfbO/m/wjblwRpD1GlR39FMIYgLmwlshn7G0TZwh2/S9l?=
 =?us-ascii?Q?UbMiXpILUkST42jWhWLMLlHIrM7P1n9Bd7RdgkvfdNbr0GP1/Ri/H6QTPEZX?=
 =?us-ascii?Q?oES0br36dqZds+Vi9696aWE7yTN2XCnzd0I4ZXNwC0XsCGAOht+xxnojzgSB?=
 =?us-ascii?Q?psru0/vTPzFClx5TfLoYU26u+gJqudm6qL75k0QzYqKWqRrbaxCU26ez55ac?=
 =?us-ascii?Q?03qWmiTSqT95FXcfTG9l2K1Ia5crudSODPwI0pGB+EIEeUgock5G5KdgBXez?=
 =?us-ascii?Q?yyvhMRIzS4JDU5LoesSvlDz6wZPS9dqJEhrNjoX7gp9aOeqXaUm43xKhLuH5?=
 =?us-ascii?Q?69TVD4ny2VsWUaM2MGO6jicQifoenSvAxyu2DAzbGgNNCSJT3rmDMcLd/Gpo?=
 =?us-ascii?Q?Dd0goAGDU0RdoAMNzymf7sm8fHxLQMc7JYNxx6WNc4zbb59/NHEYtzCVqWaA?=
 =?us-ascii?Q?ASjlnOTfg6YgYl+huU5rEFmePxzEIfgaxjK7KfPyB9LNc0Q5y7H/z74Ws2EW?=
 =?us-ascii?Q?l+RJ09UH1IwNMwpIJab19VuYsrcO8RRTW31jSXblXQu6HqhEQdIxWMQe5Czt?=
 =?us-ascii?Q?VDYFtvxQZRWoE/JXFdAwBw/PNxZUaNct/ahWAz+WX/fTTfMATPM5t/askE4V?=
 =?us-ascii?Q?Y4mjyuaRJkbDaKZoj7JLWf25ZKQYNIiIs2EULf0bQtdVq6fGJylxAFjspeUQ?=
 =?us-ascii?Q?clFm3C4eWLvOBqVlnqm85hvVi90Cu9iGHtB8L6XXprw7W8dowcOLK6dU2bCb?=
 =?us-ascii?Q?jpN5nPZcNtJuO58Dd+n4loFqeAV07kLLCGqA93d4xpUrtGYCbdcL0s0zAnIc?=
 =?us-ascii?Q?em6RvMYLn3Oa8lL1qmBCcvHhi51b05jcQS4Kx1TQ0E6wX62vWCnSwPKyOath?=
 =?us-ascii?Q?Cug/lozPcaAI05ymHvNVpthq+RWGa2X/iJsGRbPAzJixfRMIlDyJuaaQmq/3?=
 =?us-ascii?Q?3B7cpkd3bdleqtLHa8j+wsu5CD1mFMPGBAwQx7HCxcd67sseOmIvjfaspPpL?=
 =?us-ascii?Q?53KmHC7auQdlGwBwHjln73mtjNW8DZgWFhuu8TmsAK4g+eNi74F2gBvlMVOL?=
 =?us-ascii?Q?8WOOwADE2z3vR4qD+m3fzOV6XHULmzifi5Ay?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cma57ki91a5oGS9a1Ewa2adoIKUGrOpJd1E5kGSS/X4Eo8b07FGJS+haIDG3?=
 =?us-ascii?Q?uXhy7QBfQGHMxvYWbn9xKKok4lJxUXRRZKAMUUbaLPjAQDXfDJ6/T2TeGYNf?=
 =?us-ascii?Q?RROMfb5eFpZ3mFbOXxD8Qf76SwtJkU0LNxz7k4weUSiFhpcoMgOzyaFdE8/1?=
 =?us-ascii?Q?L5TTGcpBFdrn5j9dqPcVuwM1wdUjWTMzoK+DlI0ztiR7pOLljLhy3nRY9pik?=
 =?us-ascii?Q?zvY6XmjVmFh1Ag6ZCWQWAln4qDcWvjoWujzYr/S19MkGSapSIWNnZGMCJSaR?=
 =?us-ascii?Q?j9+89Z4xsmh++3V9Ry1gp1kBZfKFp6ZhDXL+UoWgo/jSGI0bvOHTjjn7B/EP?=
 =?us-ascii?Q?T+YBM3b+U/qRNqxkLLREbBd8M+7M3YO+dsp8ZdMUpEZljkrifXlPMZYVqTTA?=
 =?us-ascii?Q?CDDdlu8D9KwbBXPgrLtzto7Iicmmz/ZAtq3b5T8gW6cSL/8D0UoCK4XbzwBd?=
 =?us-ascii?Q?c/6+ik8wpHA1TJFwermN0cuSvfCO0d1Nll6vJ/pnRvc3r0BeQJIS+JP5JBXm?=
 =?us-ascii?Q?0WLaGd6piqz9emJoRio+xCQ3uqrDN/ewAQ2hTmpbil2sOVo0/xnJ5AewDIdX?=
 =?us-ascii?Q?04Q+lgS8aiyaUFmcaoLCXAEFibQPKa161gCkWAgHE3w2keI9HgVd/TnpKVoc?=
 =?us-ascii?Q?c7gbB8d4xRzdfG3+YUjwhoSxMT9hOwhaLU1AFlwQhqAHhXVpLECeVb/zhWj2?=
 =?us-ascii?Q?21ZHKwAhxlOaYkdf7ORF0UL2iAUbz4lkcRRiG3JxEH9KWYYxMtvw90GgE9ij?=
 =?us-ascii?Q?+cDKXEe6zf7zpuSz22238mqtvSRojcMFTG9U95vPvE7Jx0dzdmlX5kzB97oR?=
 =?us-ascii?Q?rwO6txNMTza2FcunRhCjIH1HuBiw9G0dhmQ/gTkz7Sxk11t5WYn2KtXMmi35?=
 =?us-ascii?Q?sHJGHsRoXsBAmSfirgB/r0KerUlbluGFdVk8EqfqmhucGNKEFFPKpXF68QxO?=
 =?us-ascii?Q?IU/RoQ0uYTVZro2gSqv1Zbgvmr6SRxRf0oXsd/bih+lAZfqb4FlAzPEwaVFl?=
 =?us-ascii?Q?b3gAhzl7HyjkiUpmHxJvBkdQ+tHeROasklGm6+oOe9Oa5RPOpe+vmKI0HJ7u?=
 =?us-ascii?Q?uP/svP+Kin2hYtyd3CgM4jsJQxdFwKdpPQCKLMFJA0GWkH5+WWd2hu0bUFMb?=
 =?us-ascii?Q?940llXiWWFrSDVQsf79rH9MDx1LzKr2ry65GM6ys/TEwNpX2JkWhzQSi/VDV?=
 =?us-ascii?Q?pif9aSEWTfmuYEmDRtleGxffIEtoSpyyyXQsu6PhKqkruO4fkf6+W8rXNZJ5?=
 =?us-ascii?Q?F9Y7nPkzB+WELl1QEMRDplxS0gzdQ2mEAhpNWSe1wpyQOO6jU1nrI6Xd1xrk?=
 =?us-ascii?Q?wQZYqIh1eAqgrlwzXnPNIZSGjMT0UyjP7BDA5we3zrqYv5Mn2Wr9CFKW+6QP?=
 =?us-ascii?Q?vKpIdR3LpEUlAOe1duey00wH6+DzI6nvrde6mAuZkB1cCHoMdeo6kf8NiN36?=
 =?us-ascii?Q?RmEMsSp6scfjo8P8zeUTIGlzJ5yrLIg83ViZQ7L+GuHuON2+h612jCo9mFzk?=
 =?us-ascii?Q?/ictk2W0J97AmTRT8f1SMqA83n/lIQiU46AchdFr06fdxKAarvOxRVuA0hAg?=
 =?us-ascii?Q?FmL/YVXqdhdrGiQyp2pI+CBkA+pAF5W4DXB+mlyPKEPYbSssf87gFRi+Smzn?=
 =?us-ascii?Q?n+KAvu7VvJ4oenHloUH4CuM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c998d3-d1a7-4a77-249a-08de01393ad1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:04.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ywXdchVs60QJ8gDtdXNNMmxgwBfPAt8B1UvXLtbyFLtnKNJ7NRQ8BoaNg0d4mTVKTXa1E4BXikWx7cPPo2qtfh4m0bAQigYLlrqJiNU7UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 135 +++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 719b424d4cce..3fb76e2dd5e3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -668,7 +668,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -684,7 +725,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
@@ -711,18 +759,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -815,7 +851,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -831,8 +908,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -857,22 +942,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
2.51.0


