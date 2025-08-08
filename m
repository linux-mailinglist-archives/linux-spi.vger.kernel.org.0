Return-Path: <linux-spi+bounces-9328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB283B1F01A
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 23:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C421C81AEE
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04B23D2B2;
	Fri,  8 Aug 2025 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2QQN4jBa"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023080.outbound.protection.outlook.com [52.101.72.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1124337B;
	Fri,  8 Aug 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686925; cv=fail; b=bzL8rEY5H5bZTnlOUCQ9eKTggU2E+UDRfF1jk1pcHkSUTND0PC19XaT2MZGqvnzm2Pcs+kxwGqgGBAa4rvNltjkU0QZWHRrSRS/ST5dhCoXFbWH1grGpNXJp7OYaKZZF49ML3Gu0w8ufJ0GuEdMMZ43UvkXzDAC28KD/n9vJRYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686925; c=relaxed/simple;
	bh=a722854+ZFIOBIwtA/faruYN+leJ6NMB1sEWRtY/Jy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1Q9OyjA4AEafIRekW0SYsvzbWTIvIj1ji3OzN9ODAFGSu0krAAPXDCwSSF20TOSxHhMFG15MNa0/Z8Xc+mA0xDP0orXi7JBs1v0/cOo+37P9+V4yzLHVneQs/JU1stuvPU1VTxJzqdNnWUkni92WIFbx9fieGC72Jml0Y8lK9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2QQN4jBa; arc=fail smtp.client-ip=52.101.72.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD69cstSFv0R0Dr48Sr4vQqc5SkDsq1kvXs7sxQImDDhXgk8imM/CaARNm4EpE62Kjz9CwmHiavjU4ogXgfKUuA/+dx191XaqnRnBqYpU/tGu/w2J66acf9xPY6RV00dnv4jmnrikLeNmOjKeNvsSUZQH43F7YPWpXZrQZBmlZHHN26FoCsllhE54Mb85iJExZUFouySI567Pn238piBOB2MaBrfnnBsL8I3ZLADd9WjI0obCclJ6jT/mQvcC5kM4SA5eVItlSyc/GMzKaHpNOT8GnBUGuqb7SV9sM+wvdlyI0t+SsczAgxS3ZqHx+AkFEBmabppjruVPxOlcQ05JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/EwYdpF9K6sjVt5w2z62CvGHASk1fIADsNc5mWne7w=;
 b=kpTFLtI8K++R3t7P2WqJ2NW33FGtVBUZJSkrAUNw9ve6l0mTfOP8R7+KJGMa6wvTAo+xJF+4B0SNBCFYA6Sp+3wDm3z3aRIF4xuHXalivt3WM77WujowDzc/4VRFgQeGPN+DVV5nCQrc2Gp3KWp3Sg1DzqxR8zmtySBH0VbGvOD5nDEMC9YvFnRvuaUaCoeZONJcx+ueGGLP3++W1K//bOEyNDcsgRHD3o+RWfAAMYeP/Zeh4GMM2fFc4MPApbpyyGbhad1rK1xXjhHHTMcBA6iP8uXabUtBr+CtUsEDRwFhD73r1bx01IMd7fUAqx0dhbZIsRV1oJJj+j7oi/5C7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/EwYdpF9K6sjVt5w2z62CvGHASk1fIADsNc5mWne7w=;
 b=2QQN4jBa0J46+ZEBMiotG/eJx0Met03lLQ6Yv+3mRfuo0xx4twrpI9b51vKHYq2nHUtNXd8wvnanDyckVdUJWMDfIimGwMj0CvbHU4UR2hAWbjJ4koZToCv8IVZ6ORdb5bTru3r0LAenFcyKpxqp5SUZaM2HKaGdJwxkm0dtCuAViPuO1X7QZBpdaqlnklbizEmkho7n6Lu9lLeHfD1KV0Da/nBiAfLdQ6wNMAnhy6cFNBPePwQyLtT0Lrn7Ln+41664y5Ch3S39+GCEmskchPu2yWfgP+GGyLr90nrF2sG/4cHri4W6jpawd+XkIV6oXUBuDgjMENUpBaZBMEEe0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9739.eurprd08.prod.outlook.com (2603:10a6:20b:605::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 21:01:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 8 Aug 2025
 21:01:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/4] mtd: spinand: fix direct mapping creation sizes.
Date: Sat,  9 Aug 2025 00:01:44 +0300
Message-ID: <20250808210147.3085391-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
References: <87cy98g6ts.fsf@bootlin.com>
 <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f31e57-cbe3-47f2-69cd-08ddd6bed073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+9wENLc1xiBAJ+o+tqkcgdTU/xyDb2PbBytuQYKPjYmiZ/0kMcvSsrCWtSw?=
 =?us-ascii?Q?FC153X8D/nemRK5ULhmJGShMWQFWOujou2ykDOeBENzor1vdrzQjnRS/rI6+?=
 =?us-ascii?Q?tcAarIg/Xa/gT24G4yd7vpW1POVqP9bzirJTs0pq/oE4w80HPLM3lnw3tC89?=
 =?us-ascii?Q?FTFuflsbGaI1gGsvZ94hyqpUtlgbmmBtFwW5wEQQCCaxD7uUG0lDbId6VpVq?=
 =?us-ascii?Q?J199eRtchQhO8be5ZHhSOG44eeD78whH6wPB/51QDGoHPTP1vesTaNc0Cq7G?=
 =?us-ascii?Q?oQJmwux2E6pYYM/NwFZRH2U0dJTXUExy03HMVyKK3yEHiuEMqZRXQlgx5X3M?=
 =?us-ascii?Q?K4+FeH26WBOu4Sv5bR/BDo5OJRLqIkTAGrDlt+YQv0LpTc0fXFWTfqCc7iPx?=
 =?us-ascii?Q?fURkhIGScdhLkVChM1ibsKX0sxAJvt3ueuNSQrAyuZG0VgKPPBP+IhFuvyfA?=
 =?us-ascii?Q?qbps97RMQ6vZPh3W+iOzB0vg2aGOSJe2Er9U6BH/05XMXjx8MyZcpHdn0hgL?=
 =?us-ascii?Q?sgrgc+ULCs+zNXDndu1yY5TnhF2YtCbcULtwlnkUe6VqzuAZt207dAqaSbJF?=
 =?us-ascii?Q?3mmTSSg0XUV7tToihaiAYOVuDNbmm5cVYRXeBYMTe+AHbeOfd/28TETeuVq6?=
 =?us-ascii?Q?MWgwZrAQW8Ylt+UelZe602zfgN8sjg/aQc2aCnYCaqZRQfAsMKzJz1SJZXzq?=
 =?us-ascii?Q?hMaw8xkSSk6C0JIvQva2CUdYATFYRPBXQ8abzzsYQtVFzj7wfjMOqP2dYTC8?=
 =?us-ascii?Q?QuxRIBYLOVL5u57dOyn851/i3fLTeNXN494dVuRHKSoPnYafRfqAZ7ra2R4l?=
 =?us-ascii?Q?+a3t+Tug7ZuGbuokTmTGrodI3LL33gS0ix3BYcdclcHyKVnnlv8Xmme7GpWv?=
 =?us-ascii?Q?2M1GeShokinrhIMcg9bb/rR2qtBq7WXAj/n052O3AV/uWBN1dW71v12uRwSS?=
 =?us-ascii?Q?Q7T4rsm3PBZaBm97FDUzup1zcKu4T2T+LXtJCKFYDdl90XdGyW5HOSjd73i5?=
 =?us-ascii?Q?APtK51MdtNf6u2zS4FRb2GGUk7nYJYbC5Xeg3QGo/e+T0cWOmt49g43ksAd7?=
 =?us-ascii?Q?G472IfDAb5jwrFC6lmobaoVCal/vtQDnLlh7TJgOimd+RZL/xskZdmLiqOhJ?=
 =?us-ascii?Q?OmA/JTlicUPGXbY3vXnZky/nSanrWxjSlfk9JFBltDddC4j6vtPwKPJeHCwI?=
 =?us-ascii?Q?g5UoKtuVzl/lR0YoN2y0aHE+BLHOo76Bu0qZn88LdZP2XqeRLguRs6eYIMMv?=
 =?us-ascii?Q?s4qMdYW/nPuIoaV5QmyZ049TMWY1vYlVXi12fslqQNctJ0A5RnKGwR/OdVQu?=
 =?us-ascii?Q?weQH0b6OFlKiYn7hjJiLUqyL9SKj/8TQK511HRV0dr1ZSIp5FxoOIHBoctdW?=
 =?us-ascii?Q?qAgI/QXHS5EYr2Mz0PUytq4k1C0R/ePmTLTdcPDdPwR0RTUlT535Zn9Q6b0Q?=
 =?us-ascii?Q?aHVhfugoDcxnj0o1sP8mncGbbnBbwYtkqJ6HdeGPsUZwyEWfmzvafmGj903w?=
 =?us-ascii?Q?Q1oo6tAMytsxMr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tiygbm+7gO3NqMKqgmMdRdt50++HYUFcswdpUc7UaVYr7IYCA24/pkn1sdcJ?=
 =?us-ascii?Q?7KVqsDH1PxinyjcQ7PQRZpFfHO/kbxW5ZSgf7fBfQ3jHkuwuS95QWQnYvDHT?=
 =?us-ascii?Q?thO689f3rN6O2mQKl2gcFI/Qb3uMQbT9YMIKQFchrAe7NShnaqZn/k9BuQdf?=
 =?us-ascii?Q?sdN8v7KQ1Gz2/SPIcoTXGAXW9Yv5YDqgebyP8jFllFQj6I/AIwAKBRvXO14L?=
 =?us-ascii?Q?mfCJzip51CRNg5k0YeaoG5vDDgTWpH4Qlzkw4zfmgwGihehQoILplI5HKWUt?=
 =?us-ascii?Q?w7R5FogmzhhKOAk15y3MfpEUJ7C0/wG/1ryAutd0HpcRFkAyNa2oUYmMHz1Q?=
 =?us-ascii?Q?S14W80ktah7EVxL7oOimcscenYkLNfxO0VZGqVff3lvGijxwm3Hft1uaQttl?=
 =?us-ascii?Q?pdWYrJKUS1GemF012+skcOAt6WLR+/Ixp6tgJHekc3g81+X5aagEkhC+T+uz?=
 =?us-ascii?Q?fMsmeoJXq+fbKVzuaIu3e7FgHcbCof++M1lPJy3u6t2MLx1mm6SltmrAscSJ?=
 =?us-ascii?Q?JUNG98vPNl+TReUs1qvWRdwKo3coLHDfQUM8s16MGNaf5wFoXGK10ZBO9wPa?=
 =?us-ascii?Q?Ds7lxA8skNlt6D215fCqopc76krRxvWvSCbikb/USL73idse8FNHF/cWK7pz?=
 =?us-ascii?Q?C3oHzpU/0CBYGIb3eFpfx3y4vLsWsqGIBKlSDJTkXLAThxsXv2dZHdLQ8xDN?=
 =?us-ascii?Q?0g146h5SOUcBN3geQxPj2kcs/huQbv+mMk60H8fNgJTY1iE39PdFKkLSj425?=
 =?us-ascii?Q?JU2MEtLMeds8Makxa1NZPGwDew9CrIZeI0T+asUw/Fm0Dn+jwf/D0rkPd6he?=
 =?us-ascii?Q?vlSwoN7wZ2aBAkb0NIS944tNJx7wVvOxbmxNyygL0yCxDx0yPxcVa96Fjnz1?=
 =?us-ascii?Q?2iJlNb6H+Y0d/j+BrrQwSijs5W+f2vq5D5k5qOJbXUY0iSAUixHr762aqH97?=
 =?us-ascii?Q?FeUd3qeArvlgWuDjOo9lEVysDi/YMO7vC31lERed82ruPKNiwNalzj8WnG0h?=
 =?us-ascii?Q?a1PQwlxUvkAldetIIBSto+hCaX6Wcsftxhlyn9LpDSU0WzFQ7W8/F559JoMb?=
 =?us-ascii?Q?sKuOsj0z74r7kGzFAyRnjWg/G9XYA6xBI0/IiLPUORHBKAqpan6J6vLRIDx0?=
 =?us-ascii?Q?fhc+Efs+YNq3/3Jv/RkcQRM8A5V9vkH2ITTXXtyAeK9obHBiq1Raqbk5yVOD?=
 =?us-ascii?Q?I5L5PmpQZ7GscdP2pMcSpBz4H1yEcH/cO6P+VvjFmEqhBj8ab3eW9q+v8o0+?=
 =?us-ascii?Q?2c4HWBtYaEYS03McdxtS31QIpvKrwnlDo4gm/tc+pKWwBaZNxDRChbhGNHaJ?=
 =?us-ascii?Q?+K7d4tQmNTrhfst+EtqOgLALsWm62y0iQEvxdg9irNPEnQOH5IIRYwzJb6jC?=
 =?us-ascii?Q?EnfTg3ksAHNJJtXlgbDLhGEQhyJYXJpGtYLapbNwVR03LYMs0zn+tO60hO4+?=
 =?us-ascii?Q?8HFnD5d8teRtHWXMvf6aKibVNIaDFkENkCM2ynmPT0L+FXOHt0FYMf3ECUig?=
 =?us-ascii?Q?eN6pXbZ6OPka373ahG6lY3AkPGy3Qv428ZCCdP8iLXSOLdj01t9wXE35FIwN?=
 =?us-ascii?Q?h/p7nGV+FLsi1NFJbON4WkMlFSk2T3HI2ugFb1ACh8HMlcmgIKy0cKUqD2bP?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f31e57-cbe3-47f2-69cd-08ddd6bed073
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 21:01:58.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99w4KKCwa0M6qGzQzA/ps+K3al6DTW6hcMjp++erpE4a1qGYjwel3ylvtuDUf+3Lef3X+Y+tsjz3Bv4KZu14D7AuOyJEF9BaWdjZun4DXOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9739

Continuous mode is only supported for data reads, thus writing
requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..09dd6e40e308 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1097,18 +1097,13 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct spi_mem_dirmap_info info = {
-		.length = nanddev_page_size(nand) +
-			  nanddev_per_page_oobsize(nand),
-	};
+	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1117,6 +1112,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1132,6 +1129,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 		return 0;
 	}
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
@@ -1141,6 +1139,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-- 
2.47.2


