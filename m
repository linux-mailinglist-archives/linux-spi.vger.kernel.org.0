Return-Path: <linux-spi+bounces-11229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC409C5F9BB
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 00:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF621360593
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEB30DEC7;
	Fri, 14 Nov 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="LsCsTrU6"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023078.outbound.protection.outlook.com [52.101.83.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942930B53D;
	Fri, 14 Nov 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163289; cv=fail; b=duHtEdxq1ybHJbkWVSl3fwerweynrFWiRTF2V8BeqprXJFgCgpeGH1113R6u+6UQp/RJSLFrKU4m4cCOXHx0hGoPp4NzevAbZbBMP7GwPLdH0rRTdLKYsR1w+N7mgNkPGK2n7PVCq08TzTqz/cklYYFs7HjXuo6hXVuMnhIgyC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163289; c=relaxed/simple;
	bh=g6nspgcyIbvVangKIHd5Glmd1e5eAig43i8yFjejAZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXKJF7TauIKRXZVkY+EkyPpvkpY6WKiwI6s9jrm+MFNET+b2vZvK+5mb4YEUQ4hQkRhKjGiZub1BWi4OOJSsrmYZBHMGazhNYxVjKFvJnZAMVZ0OikYW7BMH1GLcL+ppke9N/TdHdmKa6DZAiTrFGwgZmbn5rj3egP+1DNvFLeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=LsCsTrU6; arc=fail smtp.client-ip=52.101.83.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTSXyvh9lAnmKGKwQd80NaYKBBdW6Z/4M3d1LY/oJAboBoD/doSlbf8o7udmVF7s92NzcqyKvrjNwoYuJL53nCsPaaEQbGaI4RxBiH1gbPqk15lier1wZ0v6jbruMhJCMD3wdIcvg961BblA36LwT0M9cloFLtGy3N2Q88FfWUF2i2D6vwv5ryFU/CazktfwpL7qLSDoWokpF56ZrUCQ6Pntd415Se4Xqcc24RPRTdaI6pD+/UoVmAxZBSf/E8zjQqxTE2+DpqLJoavPXrXoN9c3RBUagXhF9+NQHv0xooriSitq06sskg++6Nnnl0t101M6doM9Ik5eRMURP93WVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjpayUDT8VRfpbxTDvjkePuHartjeEWR/8a+pD9h+L0=;
 b=RvnsR81F/di4LkrfezcdN1Qy4CUbkRJeZ1YwCf0B/5rNuLNARqdAyjln/2KrZ/LSvIbjN3KnMwmK5thQ2A8qdUYeFMExZFDUN905FqkLZiNpJBdRajIy/E+sONa4Kka+3jrpd+P+7XpI2GocOsPx5h5va9qvnHburzcUBBeFZBjhh2j1CpLisJAGxiBgpnBEUw7RUtBMr4B5aDopXCjAxZFW6ZVkHbP8evFsrN0vt0hpVEZnWYT+EX91kHSq+Z/lSLOF380jvG/arQsjoc3ySTr/XQ9Iwc/xYGs25MCtUj+F1ej/R+EHkJFjJMByxCHeK99BYHg3T35AB3Z5+oIHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjpayUDT8VRfpbxTDvjkePuHartjeEWR/8a+pD9h+L0=;
 b=LsCsTrU6whptqALzKVUm70F6nh9IMkZbnLlbK4XzUVyKCQrMIxuKy8b3zJpRE/V3FRZyIomf+wmkrknPBGAO8lY7/bmCyu4d4+sGiEXrc7st4FbEErOxhLBvFGRi2bfkpwhGIvA+pmtvFqRDvJyPqYVUIT7tErsd/DqKkG6HfJjqttDcErYZT9ESAq9QIkYoNwLEEmY/zy7fSYJx6sPniaabFFzAKLwQtiPD7LA+QW91AI4f4rZedvfqQZCGxycT1ZKwa6I+YPNbt/rgIaRi7yGVN7ShTN7Z8V2SZLMJKc3mwdCspFL8qkIIWJmWjN4BP5m96CFjhIodbnwwUEcLLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA6PR08MB10739.eurprd08.prod.outlook.com (2603:10a6:102:3d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 23:34:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 23:34:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Sat, 15 Nov 2025 02:34:29 +0300
Message-ID: <20251114233431.1920015-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114233431.1920015-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251114233431.1920015-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:15::43) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA6PR08MB10739:EE_
X-MS-Office365-Filtering-Correlation-Id: e16aac0c-d0f8-45a2-b60f-08de23d662bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJytd9RYwkTuHXuHv951n4GLZAP8FrF0Pf87DwTEU0X8vKpxzu8Fib7+OpY7?=
 =?us-ascii?Q?sh4DZL+skxrRu3OFSI86u8+bC6KfIwuJpfkJDJOA9fYvbKKMZA9pgb+VNVDi?=
 =?us-ascii?Q?t2zuWENi1zeo8ZVYkS9DpNVcHyAN6CL4F0cDepWbjmo1iXYR7/YRGDfEVkVv?=
 =?us-ascii?Q?WswRsT/ND2wlH7At0gjeQRC0OT+/00TNDmmRCOL4p/CiShSaIK5LMgi24sxB?=
 =?us-ascii?Q?Glv00Snzem1q1aLEXvNg0mrwndJE1ZDD2SChvDDHJwkj4441qX5ptCkIWcnl?=
 =?us-ascii?Q?GHTcw6aSVCmtoe50ZgFKHjGGyyz7t1GBN6jj4319eNufuO3bcKEtkF4/YDjy?=
 =?us-ascii?Q?PRyBMyprG7rXHdbHW3zcBKJLJkM2Rb2NzHcacGW4w77bYi0BlaTHATuS7ooD?=
 =?us-ascii?Q?RErrGgnhYu6kG2nc35VZiD3dGMVnvf24UpjD/jMfE5fRC66yWOrNZbI1GxnE?=
 =?us-ascii?Q?dh2T3eJl9ybEflPvu4rqvtGZEJQOvbRCHHPmx15VUqSdgulxxLNp/dzG0pOc?=
 =?us-ascii?Q?liJ1dvYM1M7OBG41v7Y9o5vTX/40dhg20vvdKZ1eEMLIDIDkyldzKz/uAtrG?=
 =?us-ascii?Q?2yNuTOPGdoy94KoTGfyvKUgWrFScJJKyzfIfPQiXdC7Dm2/G4fke1iWQcM2n?=
 =?us-ascii?Q?xjoeAb85vAUqDndUddZhtOZ7pSi9NVhzuiHbc1VMPkgmyUx7Aqo406qu73A1?=
 =?us-ascii?Q?BFXLtSx9nXKoCOfySxqS1zdKCpV5ZxZpvFIKVQ9J7jyqeIZ0IbJ+XcYNqssG?=
 =?us-ascii?Q?HMQfZTnLITSrBMw816RuIH5UgFzqAaGm0fahw9vKstE/g/vqYPO+Hbq+1Z/s?=
 =?us-ascii?Q?5urRuG746QWZ7arwaZPHzhfko7zvLIiYsni9F+m02wG2aP3vfF0YFdIJG4Yi?=
 =?us-ascii?Q?VnbjzvnVnckRuZrKj21HMQFzRlc1ARZ7eKDXpFbq/gEGgaeYP4W2g+SgZstV?=
 =?us-ascii?Q?kqlY9nHResFIcs4i1u+z2FmYmjCuDycIMwkyJVmMRl8jUV2vof/Z2XpfrVzo?=
 =?us-ascii?Q?TMtKcmkzfYxdCV8hx7l2qglmjjozJFHvqAwJxYFP9GSQ6EmJeyH6nqbV6JnT?=
 =?us-ascii?Q?UaabRe+DI6Cx8/gc5avhg+fyYFdCBUIW2si1Rxmncq8FJBwKQkRkkjcnqm/v?=
 =?us-ascii?Q?Hu5bDZouSPW/T0bsolNJbSNbLiaMTnkK0uspay02cUWSV68QljSW9ZN0e5Ff?=
 =?us-ascii?Q?4Pl1v6ArYgrDQ4bjuHf59m90STHnscwsFic6geY4qTJEWmrrly6+RqRUpjbI?=
 =?us-ascii?Q?euwrPN2jsr/3zFMrjoIwskRvsW9HkOH8FucznMVVxKkygUJduWSedrzac7EP?=
 =?us-ascii?Q?Vzb2FVeON3I7gntfwoDtatmXDu819RswtcwJ70P/trE6ydJu7mv7pjgsztOg?=
 =?us-ascii?Q?YTSYThgrYrBN3sZsWl9abJF5dVs4raI09r0ZfZAMyryYJNxRRUhnWJ+qkPlI?=
 =?us-ascii?Q?+R23IpvldxBivZSRVEt9QMlI406DUPnuQq6CpfxQM3iiExzAUftZKpg/zUZr?=
 =?us-ascii?Q?HGPoGe/cZ8bksUdnWajX60zAPkOYLx5t+UlnhhgbF8G/QB+2M13C6dbFSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oe6WRm3x6wr/1aVh48pULgg2TnwrKuwTCKW2WJmg6ieIzNWzHaTcG4RXRlZB?=
 =?us-ascii?Q?gcw2Fkm0lZIQhfqdPbXMoGt4nxknur9oNKiryxuJI+fF9e75ROwqSUIq64Cy?=
 =?us-ascii?Q?32APXCmj8DRoz6QD12JGFCCgt7u9OAdLZge0jsht7ySSIU31EBE9y3H9XpvP?=
 =?us-ascii?Q?AOeylewWKLciuFO7tu4vlr6ylDh5dce9vk4AJaMkKopXnF4yn1ayG/S7JzS9?=
 =?us-ascii?Q?4wmWSQhSl4xZHxfbaEeVkE1ZKbGO5ruzBjTrNmx3IaBxLpK+qMbQ0KDZy8N8?=
 =?us-ascii?Q?V6i9CvHIb7sAZuz0dOaMW3bjsi5y8SU1MK4m5m+ZS6Y3E3g7G6RHSzvRpho2?=
 =?us-ascii?Q?AeanSu/7Tl09jtpr8M5X9i4dfr4vLc+2YEA2Hoh8Y2XNrr9lsbrUsuJNPGK5?=
 =?us-ascii?Q?JgpjrgrlMzt1EazLwK8qkAURGAZvdPAqzg8A4sOpJgG7u+ij2jClQuyeFOAS?=
 =?us-ascii?Q?uzvhIWoALHvYVt+zCYHd43G4bcQCfrkh/51+6x+Hz0y4/W+qZMtEjNP9bwGc?=
 =?us-ascii?Q?xU2sGsND513DnQ12Dwpymhun9Sz+wnWEFpkbymMxcRexLie5F4fKg946wE2j?=
 =?us-ascii?Q?t9KSsOwPPTcZXmULbdSO5UmlyF/O5NcVYG41lUyyKXlqEPZHeDoDJO/BSP8q?=
 =?us-ascii?Q?H2LRnfCFLygZju8J6yvGbfbjQ6+UEZVRp1CRBeBVmgCutO7qcgkAAVCP1uHm?=
 =?us-ascii?Q?k7Nm2zBTwGF/HIKKlH2qWtb991VSLxV87JM9yg57UBKKe+7UKmnDkrhDx38F?=
 =?us-ascii?Q?J8UBXnKmXKsp9C81hMU6Ggqew94VXqEDUt48I35g9MPvHdsDAxCRqWyRrq1A?=
 =?us-ascii?Q?C/0OZd+6xulTK/RrRa5XGS5ZyBfxvAYjG159sXYPAK9xQrieCWy06OIlrH5u?=
 =?us-ascii?Q?LYswqGxpJXJUr7kLBye3Hrw38RteSgffL8qb+WL33mkdZZ7MbcD9eDxfTgb/?=
 =?us-ascii?Q?Mpas7BJ8I1LUKab8tpw86Z5CeSTg56F7pWeMx+rx0edD/+20bdPPt1sIND1p?=
 =?us-ascii?Q?DCtjE8iTrcj/qMQjToNmAcQKsv5w7Jpj8F2NBCP2q4E0V3nhOm4FKnQV4dRG?=
 =?us-ascii?Q?4OH8sUOt6ENaipHv9r3lwCyDZMg8lhW6cO1md82BjO5DvbFTxyDSu94sPBRI?=
 =?us-ascii?Q?S91Zy3gYlrdZ4tZfILhlQv0vgR2hbsGv7fWiXbOlRvKV5is5YuWbGBgUkS+o?=
 =?us-ascii?Q?NmOZ1F7Bc4Pjx360/u/illyznPSLbLKjA4rGO9wbi1ojVO/qfKmDhchWd529?=
 =?us-ascii?Q?zKHRfWXrkAaA1erJko9vjhoKhBI1LD+TQQ48Dy1/itPOoYB1cr1q2pgyXU+r?=
 =?us-ascii?Q?HBFm5pgjBOFVi7ubfrFLJSV7XnY8+QBXZfqhkmTf18Tq7englp4YCRrxYGnS?=
 =?us-ascii?Q?iwnSLQqhozMUrMCkKMF7s+3MrffU+ooK08+F5zr/nnpPETgN9NfFiRBpfhn+?=
 =?us-ascii?Q?FiAIpACwzk9OkvoW56ewwafAHo8AsjGPqA9yEC0W4qSrcmjm1M6Vc56T0TlR?=
 =?us-ascii?Q?URJVZfFtRPqRQ3bibcBvoYb1q0z3cRvdgtkLxmgipruWtpgdMSaxZxpESdhW?=
 =?us-ascii?Q?VDSzqraHK22+1UTrarWOGhtBQ1K0UUlI+Yln3N5//CenGdInnVnXqWNqzd6b?=
 =?us-ascii?Q?gcnO3wMzHxz3bHLLxiRYR7Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e16aac0c-d0f8-45a2-b60f-08de23d662bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 23:34:42.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STLRUrezkrMt5LMi6/TOxyTiNt5JccxYQcKr10a9iwuxd0Jv1oM1t1366coKssA5MvlX4I3B6gMrtsQusqpqrkHybPEw+yM7x6Y8IslKlis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10739

We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. Usage of UBI make things even
worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
becomes impossible.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 40 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..0e84a9addfa5 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1058,7 +1063,8 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
 	void __iomem *base;
-	int err;
+	int err, dma_enabled;
+	u32 sfc_strap;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
 	if (!ctrl)
@@ -1092,12 +1098,36 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
-	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
+	dma_enabled = 1;
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enabled = 0;
+			dev_warn(dev,
+				"=== WARNING ======================================================\n"
+				"Detected booting in RESERVED mode (UART_TXD was short to GND).\n"
+				"This mode is known for incorrect DMA reading of some flashes.\n"
+				"Usage of DMA for flash operations will be disabled to prevent data\n"
+				"damage. Unplug your serial console and power cycle the board\n"
+				"to boot with full performance.\n"
+				"==================================================================\n");
+		}
+	}
+
+	if (dma_enabled) {
+		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
+		if (err)
+			return err;
+	}
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enabled ?
+				&airoha_snand_mem_ops :
+				&airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


