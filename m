Return-Path: <linux-spi+bounces-9278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98118B1A992
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 21:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5A6189947C
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331528B7E1;
	Mon,  4 Aug 2025 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="TExfEQvI"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AC28B4EB;
	Mon,  4 Aug 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335313; cv=fail; b=sRJ+8lXte9whQ6N/V/MB8ZZv6Ds9Q/0edOZmKOt2RRvnOifhKG5xCyY68C7xRcpeZAyI363goC36iwRcpH6G2PbTLpTNF+Cf6BhSGFnyAokot/bzNSwvIY9FYNfDRo/nk0PhFG7t+MN/Jd2ZPcWeSZ8ueD3hIVNaV3SI2lnx9mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335313; c=relaxed/simple;
	bh=7kPBCiCf9IR/oAkt7lidVlNSLSxAki6UXFkCqnj7J2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CumJmGY3FObDEL23QDi+0Q2K8xihSIwtcfN/w28SwfaTcPrYGgcBweIw7rvoGv9YlGGID45EwgjIWDbYg2+hAvvcgiPD4WWVA97Y765dGroH16G+OMgjylgUtHZKJI2xUOC2v1TRhPsZCG5sNJFPdVd+iQyVKeE2owtUnjafskQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=TExfEQvI; arc=fail smtp.client-ip=52.101.69.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2X3XQncJt9JpH9mv+q6Cqccc5xZ4Gp0P2mtsUW32wUgHXihsDodXOaHxRVNncqeH59zUaI1LZPZgUXfMtibqdpJcbp5MXhxoAFCh30ms/OdPSWOptCgjiCdKF8IxIlWRH4+2yTHKjZIN0itb5wW3S6S+0VddprVjH61U6t/W9VO8oqUg1HutCmPqw4vqinFOfuyMC9vFjh2K/Y9D6oNE2gJ4dJtlQ/O6SHOARR8P/O0Ms+95gJ3RvsI/qYoqkRCTZoO23/DaDTUQ9ePVGxMRJoG9JPT19RX6zLMmC2uSK4iLjL9MprdlBUu9itodzpBfNZZpt8HEAplBNCYOH/8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZlQfwT0L/ixL+7GHKWaK2ffYME/N0CYVb4pemxy5j4=;
 b=EnzlxMKLCfOaU0c/54Rgh0LBupGv2gzAjIm7xWsl+9fU+f/M5YN3lJwjVkHYW2O9PMMhsJWXY9os4DFyhWBGnWqqzeyHAXBSrBZ07wVCd9GqDiuYQKo/PF7WSm8vnUOgfLiCTE1Zmex4x9GdguvC5VwANTtlC9OmJaKvPqXkNwGJfd3F0ItXVl+QDnr31SO/ErLbzJ76gCdfuODO0Z07xEASH0Fn80XqVCp7zB36hxmVmTDsIuZFJr1q9uT+t0AVKqLjwvrBkyO3rYONOrOLSF1P9v+XnfgPEDq0jpeZ1PZOmLU9kvhlENryqYpydhTHogfMUV4z/Uw7CQSp79i84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZlQfwT0L/ixL+7GHKWaK2ffYME/N0CYVb4pemxy5j4=;
 b=TExfEQvIkf7EkUhEzaOQMelDOdfJdqnRVbCGePf81qtJ2s0BH+Dm0VUwzaPWPiYMDYGuDE2L4M5E7dl/F3qylL1L3O5wYOkbDhGTXhiXJhX1xZvj5+KhUqSmkNXRcYZWrRy83g7rbtBMkt5X3p+rC32zBSsF9MYXSMheGxdZ2JPLfdLRVEoWjWkBfU/aWJ1UerZgKgh0k8+M7EecQKZuMFwpnzae7ueiL81P6KSuGNdHwxE0C6lwxKIGjznmp0aBtgaK/yZRhonmS0R7bbWsYxdopRdxKSoBh9cCr9/W0MTAn8tXp2YcXZBZUzzrToOzaK8M6k8O4pIj3Hjj8L1iOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10844.eurprd08.prod.outlook.com (2603:10a6:10:538::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 4 Aug
 2025 19:21:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 19:21:45 +0000
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
Subject: [PATCH 2/4] drivers: mtd: spi-nand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Mon,  4 Aug 2025 22:21:30 +0300
Message-ID: <20250804192132.1406387-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 10739877-cd66-44d8-fad8-08ddd38c265b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBQXK9LetDGwpdqz8YTcLMlGnhv/poc6aG/dqEi2Wn6xhUEa55/FwBbWLXzK?=
 =?us-ascii?Q?UI9Aho66d9jtZG3HlYELKYaFNPIWUQzsoVw3LYKSAHIQkr9xo11QsOdAJDkW?=
 =?us-ascii?Q?hWCP8ZAEF1yWiET/hHK/U49rSpbzOSxfinHkWJbEsYTyf+FVGR3aa5oGA2I+?=
 =?us-ascii?Q?7cZRLs/DG7jnme/dOigXJ/xNEjyo5We0q30VLnVMqh67cy7Pv3+6mkfHsu65?=
 =?us-ascii?Q?x97k34+HZtPssdRRz4lrc0TAo9r1Omk4N1KoJVbTH3pKKNNFVtZrYHAKCPOv?=
 =?us-ascii?Q?vA8YLHl7SBjk7siewClVzQKJ+1rK9YPjzzeNI/oMu65C2LpB+Roj+0Mjzx1N?=
 =?us-ascii?Q?kCvHU/ynzmw6MuvYybqFzqQmF8jm+ntPUpcqznGR2dfHAkZYQBSllrhw2Gch?=
 =?us-ascii?Q?8hOa79kVov/YCGDnEr3Ypet9ecFLaP6QDONss10xDVGKP7lj5O1q8Y2cBb3n?=
 =?us-ascii?Q?ya1AP2UPpbRkJboYWGYY2r5AirFkN4gLLKYr+Zr06Qe7hqlBCQePxdC2baF6?=
 =?us-ascii?Q?tAzsP+EOR+VJassI8qfFPo097OP1tOW9hktVKOl0c2eFa0UQKTVOF9BTaInP?=
 =?us-ascii?Q?ViPixsmmWHw7F4GuV+Wnoy+zFVZMf3/LW4OTx5DN2ZqDGgfLcaCD6evbXVTp?=
 =?us-ascii?Q?WYfEe/JE8B9yPk7HWODlQyOMQow5EXUQpErtjAJxYDVmJ5h+57iwXVrF7WCd?=
 =?us-ascii?Q?8Ow9rWOj1D6zXeHJHsrX65jyjLtL1Nl2cl6CV69MVALtEWXmMe6+Jb1pxc+e?=
 =?us-ascii?Q?ZimS03zA7UQCn9GI3L+3AMygTmvXnaL4D2wUoxkpqzq3czWjb+9HKLtnYFzD?=
 =?us-ascii?Q?D0M95VPPd7IN9g8Pb5EGsxcpSQtcGXaEQ58JVhgM175s/YW6XFBNZ6lEc6S5?=
 =?us-ascii?Q?3qZh2qjE8NM/KO8fg9HdKR1vffr1TAZJGWJmeA0br1rlBSX69Vtdl7IAA2DM?=
 =?us-ascii?Q?qq4EmJ+Uhitk8bPovtaGSMR0TBqAgTNoZgnqht6R0HEOozj+4fPci0DRUowS?=
 =?us-ascii?Q?QGvItXEo/+7NmzJz92rARTHMhiGXYQSr49Xc5T6k9bR3xTw9IYu4IvP7TtIY?=
 =?us-ascii?Q?F1ayMk2Z2WYXw9ai3beSKZkJyffA4D6XCfHumC/FP3t+YEbV7RkaN4DnM6bb?=
 =?us-ascii?Q?rjWP6VK7qRTjnhN6qIjppiH2sOOXSuLxolQQv+TjoANFRPUWVRkkESLBHqbQ?=
 =?us-ascii?Q?9BzlrZVyotWH5xwjknn159VJXJ1zHJxhgWlRr5UHLtar00ZWZ6+SbyrVTcPI?=
 =?us-ascii?Q?p2TVNRE0Z+EmFfId9aT30obzOQCWgYfIMrLWw75SKCE92KP1yNuDDllF/kpy?=
 =?us-ascii?Q?DwSed9THldrEE5wCpEo1YFNOaySfOEcGz1HNQ8h66rtaeZsCErlNaQkNwCfu?=
 =?us-ascii?Q?Ke9mi/7B7B5ZUsy62+fkpJpuxze0lhVcEstCYi0PJm/GgyLQOFqYWFEn6buw?=
 =?us-ascii?Q?rgpMQIXfkekoDx7Eg59+ZFQ2pTuuI5VcUkSeC5wAdlxJqr62sTvmaqZTZRI/?=
 =?us-ascii?Q?9Ey42a4pOA6rsv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEcK2NxXWa0JIDl8Qa/IGO4jXfcxa3ZszrmGNKAK9OtwWSlFATNeMUFOPg6z?=
 =?us-ascii?Q?DcBqW6DvPscxunMI6QtapU5Z5Xw3B3YRnh3oKzmCkV7dDUy/8/AcTXt8oWpP?=
 =?us-ascii?Q?KWOPwrIX33dxBXZECVztdtjp/0RuUH00cvNp957Cde05BSjn/8wue6BGVPT5?=
 =?us-ascii?Q?TR3OPpaQ8zNf2OQaO9rANF3Xu7N5GFhZWVeq8Fa+IXzQVjCwV84mPGGWIJG2?=
 =?us-ascii?Q?GVTruTDeGQyWiutBDJ1JDJ4204rw+dNd49hzeptK13Hp9KFjOKnBgxU2v7I9?=
 =?us-ascii?Q?1PfkilBsvh3e2GB8MCvLLR0+gd3t5bODtWxl9W03XwXN/xCwxqYJMVYZ2oKd?=
 =?us-ascii?Q?vv+N+WJqvrjuQa+lh2Y/GGHk+ZVqdtNrm6RWum6AChEJTlziaNQ6OL3eUqs8?=
 =?us-ascii?Q?JNdeEJYDCOq53tvp8XVo+U/gt4yRZyrJCyTUgvv4L5QTzii23zX6YY4gukIT?=
 =?us-ascii?Q?ml4rL2YRQlK+ZPINQVgJC9mYF4U8SGAIb0JtgaFO7YrtrTSm6V2r/Vnpt8aI?=
 =?us-ascii?Q?Lbf64kpcmv8Lg7ytZVSY8vLlOPl+V1gPfM/zAZGZ2mw7NoWZ5Al6wTy4cjQX?=
 =?us-ascii?Q?SqKA75q8jIhFKQ9+Iq1OsCdFczoxSEhog2VCGNon05zU0wTy1jHkVnuV7jN1?=
 =?us-ascii?Q?GrOt2YtFW0nA7FzUe3LgRpm7oH29PDzfJPKYzH183Q+9EteeoDssiWIIm1oX?=
 =?us-ascii?Q?W0nH7FdWbE9tqWloVjTQHh0JwoWjP3i1Vtj5eCgQ4m8JQWInQYVVcO7k96Qn?=
 =?us-ascii?Q?D6A676OBrH93K+5mQAi0zgXq07SOoifJpgwnY16hVf9cHHbBdWBE/IbGA8yE?=
 =?us-ascii?Q?XklrZQi/p4JqQ4Fmgyu9SvkwBBIKO8/hhwTUTMtgjnx/EUf6W/tNiixLM0B4?=
 =?us-ascii?Q?tsj5tTd4qbxQSj67OEAUwrdrOSetu5154pZd1QcABoA87Y7iJFlSMqmymyf/?=
 =?us-ascii?Q?QXtAo26+Sz3baxCIHGUif2Iw3AuBh+ndbLGcrd4RvAR78U0wtk2yuWoMdGpO?=
 =?us-ascii?Q?+Yp7QTFnOYf1w27Jyjkh/TfDGh+hNrBpHmbO6tPiCyVvVSxhXAuxoVbWmQUg?=
 =?us-ascii?Q?6y1qYyzMEYi1JuDfwCTM+l6KUR0iVN4l6cJIATWK3vboZiO5aiiGpnysNv08?=
 =?us-ascii?Q?dNoNV2OQGUNdpdR67+7qtBpkyimpd02MXlSjnLcgGPM8zdDyGdCVQnmLSEvU?=
 =?us-ascii?Q?Ln9J5oyLAjsWeDto2ivOnSifYxYoOHWKItbvohiWnwwDdLdTvaCtCe9mTf9b?=
 =?us-ascii?Q?df8RDMF/OpcaVrcCArLVhmPqQp7o3cHTdthAhQPSMxdWB5tv/Jrh+Bwr0eeB?=
 =?us-ascii?Q?jeirpKZANjNYHYXHD1usDL17WSrpCMLXHGan5pRnEb6tdIcSn3zJsDHwWZsg?=
 =?us-ascii?Q?G1xTRE6s15R2D41FNGOrAw3tjTSfHwTXqJqa/ejjEkm2CPRsHdNMlNtvstI2?=
 =?us-ascii?Q?GxXSwtxn5/SoQ2XsAMTRnTj4x1iXFcgKmwEsJJUSfze/hvhRejbGc5HIBhKI?=
 =?us-ascii?Q?qvxaVrY8PAY2zKh9D+4V3m7NgKxBmO9biNPIs8wE/5qiD7rMz1pPgCq3HePz?=
 =?us-ascii?Q?8VlLpKEBRQn/ToH3JNk9yZNxEXAtJ4Oi+PgGerGYvWMUCg9vY76l+xut5vCF?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 10739877-cd66-44d8-fad8-08ddd38c265b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:21:45.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bRK48d29Da6ev+/Nwjvu8/DEPMZXUvrPVaOqHGhiT9xrd5l66PL23J2+Fp6Hp5hyOEcgwfyYzuZRLyOtgqPLI4KKOvn71ENx9+K9XNzVXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10844

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi-controller
to read up to 512 Kb in one operation without togling CS in beetween.

Roughly speaking spi-controllers can be divided on 2 categories:
 * spi-controllers without dirmap acceleration support
 * spi-controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi-controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b42c42ec58a4..ff6a1e2fcfdc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1114,11 +1114,32 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
+	desc = NULL;
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi-controllers may return an error if info.length is
+		 * too large
+		 */
 		info.length = nanddev_eraseblock_size(nand);
-	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+		info.op_tmpl = *spinand->op_templates.read_cache;
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, &info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi-controller, try regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info.length = nanddev_page_size(nand) +
+			      nanddev_per_page_oobsize(nand);
+		info.op_tmpl = *spinand->op_templates.read_cache;
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, &info);
+	}
+
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.47.2


