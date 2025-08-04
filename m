Return-Path: <linux-spi+bounces-9276-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D20B1A98E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 21:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF33818970CF
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE0218AA3;
	Mon,  4 Aug 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="wJu0UqYd"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42B2163BD;
	Mon,  4 Aug 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335309; cv=fail; b=ZpROq9FPJwkfA1CxbVqDnARo28rrFfEYBBDtMZLiTmdPbrwuuaaatBLP9S5l83kStjtgZYpSHfLYihatBxSpylFbgj3rrudqvEgWXpB4IkF1kYP2mTwUpK4052CnAnroIt0T/qvevtUryU7vEB7w/LaEQikAZNXK0oewTx3UtzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335309; c=relaxed/simple;
	bh=UBf0vsPIsPOLUFO5R6oG68JSIV7ignFM4LECSwaPtOc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=orBFBpRYwScbBFhSL2CzKb7Zfua+g8phaLalIgfTAp4JRj8uw16esXJD97rBTwSPgMyt11h+5Xq+cR+hVtgpJ386uZzOWbr8M8CkYpkSgzyjoKeYuDTgdZ3oE8A7nx1jsoBxXg2E0fb20Ku5AXfy18Ao80T+eE5VlXzJSMUtdws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=wJu0UqYd; arc=fail smtp.client-ip=52.101.69.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/i7HOG/y5G6Cg+89f8F3ZOpn7RrFIpy90Of8aiXiGQmMBzRnQugO1kbeso3nSuxEfmqO2YJTyY7VSj/qj9OYIuk60ktQtWOioqbNh2CNGysXlfvtpL3tUrhG9Hlmn+CTaAzNgBb954jTDVzy8sOGCRdsBIwIUSwgyCzPzlGTDvlF//VN2sScPGGh6Fmn9pISHexDHkvKIfKb9U8Zojk9JSzcV+nK7D2l7gdu/vhDFv+Aj/MJ85FvGbre1s6eA1X8nNfIMoTujHQWqARHA+s89u2FzfutSHJNLl3aQPebaf+49S05a56DWDt+7sM2TXS3dhB94zCdEjSw/XCg0zTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2kpNXV7SgX6qaqAE1oYmw7utFzgec/sGWGQ48knQjc=;
 b=HpzYSeSTshktq4z2QxvgtGnEZSg0uFf8s62nr09NmoObNuiDdG9HUezKOMCyXSX+iP0n4Ok63SYLRVHTkBFakGis0VrAr62w1w++J2M86x0wp+Qm81H0pBs6eISN62PPFNlVEMbkZMAjACIHVUMDPBmURU6mXgmaTx8oY2Ocmrq03bIC+mEgpm5R14NMWzVh0Hw6a/vL8TOpIpHaBvXGHrQRRE3qtgR3gl4m/XFu9fr5ISJ6Ut+EBJfiIZWtiTIOb1W838h2gzKR3Fejl85ETgsniQkR+P/wdFAQaLFbOt0ZmT7eiN0WTSsOk3e9xRoipo3zSEr5kqi64AKF+jo5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2kpNXV7SgX6qaqAE1oYmw7utFzgec/sGWGQ48knQjc=;
 b=wJu0UqYdQniPG5v9q8TE9MlM/4EXLrfDsvCih560A7FTLUBaxtjQ9HDt9Tvhl9FzeEEVdzoQJrdl/ZneuFJoPkUEZQlotWgNuBi9IVxH2TicbqAKtaw9NsaMnMh2tUPVmBv/kzguN2beJO1hr8l8XxQVFbFkcGTezDoHsgmW5jRu8XIGFjtWsSlmEh2Xm7KnDOH38mrdom+Mkjio8OBb+nGpPD9dqVm3VnX9C2+nQc7K8PhoxCYTG9bvQ59JoIvAUolRbb00FDvNgG0sqjGaR1toKxuQdo3o0uVFv+A+oKcgZGz1WLyKxvoZ3eL8G8kwy1xve1ZY0b6jje5lekwSEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10844.eurprd08.prod.outlook.com (2603:10a6:10:538::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 4 Aug
 2025 19:21:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 19:21:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/4] drivers: mtd: spi-nand: fix continuous reading mode
Date: Mon,  4 Aug 2025 22:21:28 +0300
Message-ID: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f57578a-ec76-4652-f765-08ddd38c2439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kc7j/J+m2x23joSMWK7GqhHhFFPQC/i/LrJpKH0wbkKmZlbPG3Pa08YSTsPt?=
 =?us-ascii?Q?lhrhO1Gi3qPm4RkQqBr4lFi3BO9Aoos1H6Uw7qLM2Q2Phv0Aw6h1wFet7lHl?=
 =?us-ascii?Q?jRUPlzL7wqMVJgqngXAS03olya8AkMElV/NwEy5g6oC5Ie+FyxZiC2nMLG6B?=
 =?us-ascii?Q?tZxIKVlUGveA6oqRzx3slpR8JlkCJir35bovMVw4Y1/WROrp99x0f639mwId?=
 =?us-ascii?Q?m75b+adcJ73QuoTORQFzuz/HHQ9LU+QtyxhH4T7/svTx6ExZkiaWJwVBAyGJ?=
 =?us-ascii?Q?4FuXA10Aa3NiFrTKXjJLPu5FuMFQWP0XVzrB2erXAFXNSMSQ8W6/K3SaDRvm?=
 =?us-ascii?Q?LQEWq6ZxROTq6Uc2mAmeNkFPJi/eH1TDwQC2cBq+UJ2+2siPhAuwP4L60EDo?=
 =?us-ascii?Q?jVt2SkXA/8kDlZVxcYqbz0xEZ41N7y3Gfx/iFeg00+yBdIsBKguqaJt6Ns6g?=
 =?us-ascii?Q?cwwhspQz8vWYP0Xzzg+sVRb80ayNienTqXMpE8GxoP8tny91AEw7QlHKRL6E?=
 =?us-ascii?Q?ynOSNWySxbJR6gFKefs8Hqd+uwga1b3rOsqKZeMdgDWBl1+kQgONlhMptDxh?=
 =?us-ascii?Q?otbetFfVU/UUFTifM7hglPDQnsCkaJ1HlnHHEEvSCLs0OKGi9wWsQ3UC+Ete?=
 =?us-ascii?Q?vsTa7VzK1kKrfHLB2/b+x7WZ0SW0SBLTyD8fo1h8x7IeAv/2k5Hdl4ysvOJ8?=
 =?us-ascii?Q?nZ2gxxbPBYsuo1kbTwTfyxbp89kFfAWBeiNWoI+5Qj8d2TX4c9OHlpkYAo0o?=
 =?us-ascii?Q?si/jvyqInuo+qNdfBpkGOlSQgZrNMX4jU9yb4KwujU4PRmObEZgor+deMsr5?=
 =?us-ascii?Q?1Fs/3RANdqBNeDKEmLJgQZ/Pyo1lVG2LmsguCykxRqh2/d1UZWjw3bLNbowW?=
 =?us-ascii?Q?LE7UvOUZWxfLu1QU7r39IPRw4rvp5J47GONBD90BFIiOKvnRmnwQK38UTUC8?=
 =?us-ascii?Q?1IMDWdEpNN9rx1HMBfMJWe5uqhAUTW1iLUomBwLjgU8//zOkBBn6Ozgf8z1+?=
 =?us-ascii?Q?Qlrq1lV+56eYD7KSQtfxDtpVGZwc2UM1N4nDkEMvh+yJTlxhcpG2pQaSNanu?=
 =?us-ascii?Q?hGrDb3DDmhjkfyou26mMo1WO66PATiIVpvVG/qDc/un9UoMIZzwkuCmKkIPj?=
 =?us-ascii?Q?hLVjKd3fUC2pnnVVs1epjug/FTnXHPhvwFdSQDjW72lnyZVgztvVsCWbuKJ3?=
 =?us-ascii?Q?Nv9E137m/6F1nH9JJ6jyga181obhIU2iDRwRxE9AErPPhwM49RGR8a9LKvbO?=
 =?us-ascii?Q?YXcq1qMKC9Ccyvl4+mdVLBieistPvQHSAdcoWjwtS7st9YGL1zKgBsdIzac5?=
 =?us-ascii?Q?UzSIgF/2XBGmuf/0uTnXdlJaxpAjBVvBS57a+DE/+lo5JoSrXPiIujvbOD75?=
 =?us-ascii?Q?wp16YbrzwXSQmmHyeqWAUHkEleI8jEE+iO0lUSuj+gA1hGKyDhZ/ySxuD+5k?=
 =?us-ascii?Q?Rjf+UqMn5gPCKyOw8vYsIuqqjuBD7gLrRAgcUI4JUF1yrLaJjwMzGHcO58MT?=
 =?us-ascii?Q?mb8tly+DKIizkJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzN5T1g2koJsXVdlgGHhujYIjdF1Q1JplKRVxFpOduc3az61zkznJE0YvFbQ?=
 =?us-ascii?Q?f0dfhQBMCpJm8sgi1egYmU35ZMbBTZRbK0IgHPXDwKKK9LWB4B06OoTVLmC4?=
 =?us-ascii?Q?6O6xhWNKADeBzVb3fGZoHl+yI2xaT/j6eIJ4orxt9O4sa4+5KmgbfuTbHv+k?=
 =?us-ascii?Q?8/0XuaMMO29acxgKZdlhD/45wmTMtGI3V8jULEOmz6q/fFZLbev1uqYefVRZ?=
 =?us-ascii?Q?MdkuZJOg03cB3w175s5b8M+BGizt/M/Q+2S8bYa5oXN4ODfqGBVZL3TkrJza?=
 =?us-ascii?Q?6V2zBQsUry4ur+t800PzeRZM2jal2kubwhBbOSTDFkzjTVFAd036KRnnYDpL?=
 =?us-ascii?Q?Pyn5i3RRvgylxm65IyXpUd1X3igCvQkTiMyWl8ootqhXnlWwFftEb1nG2FGO?=
 =?us-ascii?Q?p3OQiYwrzuVd1ajo/yTvUnrQGi5zTrPoisvFJ2riaGpUAHUApmPGQ+Xrp80M?=
 =?us-ascii?Q?WaUnNP3paExApKs97QXDYFtMtUADAkqfywZpoDtt35Sg0gTuo6qVGgibFXh/?=
 =?us-ascii?Q?2CM+8Uq9k/nG2PyJD5NZazsP7EI+eiG6nUkrCgg5QWMGxVJyoFJyELlDXyrM?=
 =?us-ascii?Q?OEbTeGXrPRHONRaUQeiOGIakCGJaZKJcRFivUoIR9PHsxmw8W1qgJqg8vNsN?=
 =?us-ascii?Q?WlZpa4XGLlQ7mW5VaBxA2W1XVkogKHB80mjqv+RHesadEu6qm//Nt1KGmvvU?=
 =?us-ascii?Q?B3OWi8vc8Ob6D5t7MlpnuYDfm4Pf7Ac4YmAy9g+jC1fEJY8RWm+akY/MGZzM?=
 =?us-ascii?Q?hrhsmP8TiN93YiZ6D05FOpcr4pLZUUEKDOiF/NuSOudPTlgDWYOqPyFueYSy?=
 =?us-ascii?Q?jA2ZG9X1tnGlli/BxbKwQqW62aBsXMEXdLLy53aERo7nS8zLJrvYkwseK0Yu?=
 =?us-ascii?Q?ZsWXR+iWFrgPVs7QdxbpCqeupAxDwI7bMagoyJq1ldfPgadDbMbI2gitTbUr?=
 =?us-ascii?Q?G6dtNbuCHeaZeOqKXMZaUhwxXK+shgcdqSB+2/GW4LOVFNZxL4g9j+Kn/rkq?=
 =?us-ascii?Q?QGNf+DntFpwjnHteYxTxXKvyc+3NGaEc1JLs/hHosashXra4Tt0OSmJP/MYj?=
 =?us-ascii?Q?hf6V6gqaNG0VIl78e63OSZz/hYSUmjVjT8RHH6ff951/G5ejpT72HPcC1bIY?=
 =?us-ascii?Q?+CgEUpFTlIDKNGrPeQP1mljwx3O/E+4WS7D8yrNC1ArZMklBw6WIa/i02KCm?=
 =?us-ascii?Q?FvOPrgesOO3Q21QqmD9hvZ+ia1NXnFnNoN/5H9cVxI6mcd4E88WHcA3Sd7Nz?=
 =?us-ascii?Q?vj6lFdfoIIX8pK9x2v1Ammx35IVF7TjWZxSpStoyflohp+BNeDCRnq1RmG7j?=
 =?us-ascii?Q?DYHsIaKH9ufV4gf9VTR31fKd0RfYnFhM6nHyULbVxHiXhDhCN8nWtD0N1vXF?=
 =?us-ascii?Q?7t9UgqIsIbyULQ4rKc1pyIYlD5eD2QT4Rx4nqfSrYYR/XGVnTWfaA9mcSkat?=
 =?us-ascii?Q?OOgqBB79KVW6PNPU9FJJDpmI1nADpNuCGEUfGCn4fOVs/pbJbf6ydI9inSUq?=
 =?us-ascii?Q?psmxRjnMHyzeNjy4u0sou2HAX1RTn1NgEReQwVTxZJ4mb7Fk4OocE2D+Axgo?=
 =?us-ascii?Q?mavN0/WwCx0iBzcob4Aygr5zgbw7lZcdkmcqhTcVatLASc3N2OPRflJ4w9If?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f57578a-ec76-4652-f765-08ddd38c2439
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:21:41.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QLDaJba8UMBizBj6rG+xX/rkbdy2Ilz+qRS0q4lwR61GFL7b2AMKXHJfWkRhs3blsn5FfNtgXfB2MFn2BAPe6L8QXkDRm2JEyu1orFi6pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10844

Continuous reading mode is broken for some spi-controllers. This may lead
to errors during reading of more than one flash page at once. This patch
series improve continuous mode support and add a fallback to regular
reading method if continuous reading is not supported by spi-controller.

Mikhail Kshevetskiy (4):
  drivers: mtd: spi-nand: fix direct mapping creation sizes.
  drivers: mtd: spi-nand: try a regular dirmap if creating a dirmap for
    continuous reading fails
  drivers: mtd: spi-nand: repeat reading in regular mode if continuous
    reading fails
  drivers: spi: spi-airoha-snfi: return an error for continuous mode
    dirmap creation cases

 drivers/mtd/nand/spi/core.c   | 54 ++++++++++++++++++++++++++++-------
 drivers/spi/spi-airoha-snfi.c |  4 +++
 2 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.47.2


