Return-Path: <linux-spi+bounces-9406-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C3B25C4F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 08:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FC59E2720
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD3266EEA;
	Thu, 14 Aug 2025 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="fIWYMcMC"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059126657B;
	Thu, 14 Aug 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154484; cv=fail; b=fBMAZzHIDFjEhm/Qv2ecv1hSTnfG/HTaIbHOREMlY4AmqofdXjkbrcqFQ0SjNGg0+UgzYO8KMR7bFzNymom+q8AiIR9yR3c+c/3ZwGOzBHg3S/YouPbTdgt2YY3HIoGHJhy3iVpSZr5tOfa+01H7EkkU4L9sTiVE76cach2T3ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154484; c=relaxed/simple;
	bh=enXdG3k2lP8+ILqzF+56q4R63zfqfspac6Ynz69H75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhU21xaz0leoP/daZEWRbyi5FOCbugQjspiHn0mGTpyM56i/+uGPGOUU7tIvX6HUf+X/Dh6AJDjrichcWMBychtfkm7ZCkUr8yHSX2DBG2oanb7B55Z20wahTwnZ1ktZVs+z3gKzvO6b52iYS4MUZOhPpRbP65V+KFNZMhVde9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=fIWYMcMC; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov+BHA27PXyR7yY7gwkGE9HDrbJFRIh9kAvUPAedR/fzyOyLvwNutVk5tbzEiChWj3UlJUEwxChVZs0kXJKX8ZNon9gKtbXIbVjrMdIelVrvsGcLsE42Ook5Y9UhECQXTZPauumkIvBo+UF0WyXTapH7EYCedG1GQre05xndwg5Cd0fTOJ5Hqqr5oZKZeiNeLYTyVbopatZYqITCXfzRT2cndNgJEomb7yFt+TxHt/1L3tarb0CujEBjOkmk6v8eG/A/S0jPdW3Te7M/kWuGG2byHQPFcmYsDt2sKkfiqraKQqzzPccefWKtmxVxxR6TbIEo8U7VOHCyithqK0E+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQATUBF0fnU0xBIpNZ0UIwL9CHxB3T/bvR2BEeSydgQ=;
 b=h22Rbnk+RGkSEsSkAhvkA7emL7PKoklBL1wyTPeV3HNDK28emyWoBliqzLDom6URvJ1Qax8qMDLxYll6/jxS4CU4rj1v6k6vlTTGPvjePnKlXJfYy/q63e/YfurPh0cxLA7dDDTlJm89df15vEHnFowrnsMa69z+79ZlViVz9/S8IRSWQeGRGOuPeQv3TKny9LTym3lFk3V6wUv8+NVi4lzL9eK4nIcNpbHPeW+Nk/kXWOAJr03PRdv+DxjyW3BMiAks66N+mdLDqkuFWHZ2j8j11LH6T4kzPr5H81mS+21c4fehRH5U+UxVmxp/NyNKsSlEqU1lHzyurAkyNcvhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQATUBF0fnU0xBIpNZ0UIwL9CHxB3T/bvR2BEeSydgQ=;
 b=fIWYMcMC1q3EaQMdJGMYhxRCV/Nl9+lFx/C3NwTDiROjab9quaACth5dmsqWRHS5I22p28HxqB2nv5bdr7eQXxf45H98Ur8Vwk+5Zn70h3sJjOd9sG+8LOnoOb+psBJgo7FJviSaXhsrieQmFIYOADDdjrpuu5q1liLuqp7SI+oU21oIUfMaCZeSPejealziJkgko8fghYZUk1XZTcvIwGOAF7WvMSDu7UpcnVi8I4p9KdXcxq1lqbBkHOnDGPVM4fCNqCsYRR8vUrWKwyOP95zdvcGEUN01DAzxiHL+EOU05nBUwBcF9NT4EJ8VIdyaKoFmMDrH2gp/YOX8OTA/JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9013.eurprd08.prod.outlook.com (2603:10a6:102:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 06:54:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 06:54:36 +0000
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
Subject: [PATCH RESEND v2 2/4] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Thu, 14 Aug 2025 09:54:21 +0300
Message-ID: <20250814065423.3980305-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:7:28::36) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ae3e4a-2a71-4972-a451-08dddaff6e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iMwGesGeznHLNLBVWGevJIdLTYZb1CE+cG0LGiiTsadLDjq2elbs8i2EARMr?=
 =?us-ascii?Q?kFVoi/GoCAYrOEU6ctlM9fgtuswsvUP7qS/bBWRhyz7owE50NdPGUxQY9Qw2?=
 =?us-ascii?Q?cQN0N3F5TYnWU/Mmt8Q/sg86AGF5ehxEV3FDOsvxWsnpdG70Z/CxqxqVqRxW?=
 =?us-ascii?Q?DJpQQ+8mbAsm3KbGk3oa9oFC8Qrl4o3SAvEr/EgU1qAeq+DWXxNq5VulEZnL?=
 =?us-ascii?Q?miOMVxiMqnKOHBxM8zID8ba7lAMx4H1xFCdfHsgvbLHANQBi5QOcKwXaLvkt?=
 =?us-ascii?Q?gok70AukbjK8VriMlxhdPTaQYawOxyO3NjBF64AgT/6ykUSHmg89RoAdP9eK?=
 =?us-ascii?Q?jhZUakcHWh6MGCMgVxjxLZy93qHwCMSv0dmdPFNj7EGNfs45xfuq7j10WZ7j?=
 =?us-ascii?Q?Sr3XX9KZEQQNvB+FtSvw2SGJtOnZLRBVNsVTYhRSzukKwyIItKG00AWmALw2?=
 =?us-ascii?Q?MwZMqxuVt+5o2DJaU7ZtcrPRXvX5mAJ017dp96+ATotoCh+KTacPf5pYeIB8?=
 =?us-ascii?Q?j9CXw54n5G1RJ4JoryYzv1UX7X0rbqbq5AHPcpdkHKadm3+A4im7dOVLSeoH?=
 =?us-ascii?Q?xXEppa5UK/AUlDlpQ0vNuWnotONkisapbcazZ/3rS2DNnz5pI6ukWhqQMsiL?=
 =?us-ascii?Q?CRtV8SxeYcC5iFNGWiEALBmBaNfwWNixJa479Nc2U47G14iqOM1s6/2Z2nnG?=
 =?us-ascii?Q?AWhqlvI84fNJimmR+pITDPFcQIhKjfT+ex25Wim1SAckGwz9BiLdEeznKvo+?=
 =?us-ascii?Q?KogvL45/z14seANWwbMV10Ow3VsjMWOyPI8pm5Gn2NquRZsk04qS0vwHy4fQ?=
 =?us-ascii?Q?iGIr9AUeaAm4krcMtxlrSs5fzfbtDlqd8BI90396IWYLHvzHc6cwtcGjOfcc?=
 =?us-ascii?Q?S4qYRZPK0fKIspMM0x90T45GTIfmK9HAa8bbXpOf0LdOf9pa2OaeRG6DGUy9?=
 =?us-ascii?Q?pPuR7JI/83gSEP6kPejnK/j/uHxalOSUdvuhUPN0H/kBiHQZj6+HSlLMSkhW?=
 =?us-ascii?Q?Q08LNiC/JSz7Vl2AQvgwhciLzCvAJHhP6G8RTmvFcMFXKq9ciJpVEvsUm1ep?=
 =?us-ascii?Q?la10t3bEkKekEcZwb/qsns1I24cYepGkUrmCUsVnKhsPSFfpC9jHqF7siLU/?=
 =?us-ascii?Q?5hzsAt+VMVE3jm7fCaeJibVPJLb1NAKCD5z2NGMb0BVKbJ4OezXNIP4y5WqX?=
 =?us-ascii?Q?tBfqW2euWeyFWlQkWaQ9WnxrxGcXVcPwsgPMBZhFZUTFmUqg5RC8pAOujbMi?=
 =?us-ascii?Q?P/1c5XEoxNE2w2UQ7KSE21wFXHIs9FrZOeKErIn3hCUJdk3EgyRiBNhKdgeH?=
 =?us-ascii?Q?sMA317Oys/mnZ33BigUJw1oli7oIDn/j+8C5jQETkcwbuQ8u6y0rRJDxLcj9?=
 =?us-ascii?Q?z+Ev3g6dyXL9bT7BmUC1a9VCBlnw8P/lFMWyppyeK72MYYvepvyu0NTwl4tn?=
 =?us-ascii?Q?5skPgUyj9OIFtrY4dnPCBAbzNLkCnBt9Y+dTA9e9YzUEm/+C5imhS86OX0ho?=
 =?us-ascii?Q?ruB6rEizSLFqsys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WA/duPDPqZCeLnozNNKoMHAVQRQQ8J0zFmZokhyVD1UU1UdUWEuCIvkZ64kf?=
 =?us-ascii?Q?Rz9fllxPyOH/gEAFuqTYb+HbwAJkuCN3MUCeqz65+y70cIJ/n2zhaiHF+A8n?=
 =?us-ascii?Q?j6fgaL3lVImPtbgbzz3Fk/eBtqssNrVzq6nlZwi5kkbRx0h2D/6s0MrOnl4T?=
 =?us-ascii?Q?+qe2eF0DI0AEx+bj2NC771b0+l8qRUU2CT8uBOOcDJoFn2O1hzbypYL1lSfk?=
 =?us-ascii?Q?KjXtA/GWn3k/SOFSzQCSnS7CeuomLfA1kLjTYogXeADxEJFsx73KcJldRJi+?=
 =?us-ascii?Q?PAEVtaNLQ4dBqPExObpOv2ABVf9yc1xSPER6Gmk4jxmdhdjBffALLjvNinTm?=
 =?us-ascii?Q?Cv1NxXG9HnX3KvOmihXDln6d5GKpvDnOGWNHKTh/trItGSQPU+T768uUPfsf?=
 =?us-ascii?Q?z+xeeeKYIzE1krvFXCMIDh1x2LRjvCpB/fUW1k5XVbaOCSQ2+K4D/+6Cj4Zw?=
 =?us-ascii?Q?VJ/A+jy9KjCmIsJgibP3QU5yS+h4hpl6k/kjjqe23jtsk9WVCNM2m9YYgDZR?=
 =?us-ascii?Q?XVGZKlvJIgBxl233bdpREyHZKLhzS2DMRV4jflwKUTSA6tysKHAf92LMTyjI?=
 =?us-ascii?Q?/O0BZf/GJ13u7mbBi1aX1YdbAMck8UF0KOHlLvpNvzAeIel3fF8/II+SxuJI?=
 =?us-ascii?Q?pDPySB0sshX/8D+4h1j/XuUxEjWdxsSjaGNT7KCd+yFGKqw6CVt3DENdGtQU?=
 =?us-ascii?Q?tpg+G9ZuuIIvM+Bi1CCRqTkVbQxUUDlA8f5Kr2z9apEp+2hejLpjIRGXm0pU?=
 =?us-ascii?Q?g8K4Jt2GdgvEy/P70u2TCaCtR8+uFMNDQ53FaLxSYgCtTu2JYvJ0PmqQe0ok?=
 =?us-ascii?Q?UeNb0HpDWldICrHFksTPFGyfOQ9mAcK900huEo5BSxS+t+/iGDHA7afVKjMt?=
 =?us-ascii?Q?i2/WLD67JXC/PYput4O6JJKEmnizzToeoH57eOZ79wVYbv3F3HzyL6/qZO00?=
 =?us-ascii?Q?ti3XoaBpBP9eM+wMOQThkFABwEjgcHltrRvfUaJmIR/tnPXo5LzExp1sy+gC?=
 =?us-ascii?Q?BVMTPVQazfeT3SkfHRtjYg7p7nP9ow5Zr843jw7DQyNs3gIb4qEDHv6M1U2y?=
 =?us-ascii?Q?t8X5Rldq/umdyPRd9/3EDLDLm9Op70Yc18+zi3gLYbDhBlBrZKHxIr1K3Htv?=
 =?us-ascii?Q?+pSNLDoN59CxNxlGiJGQmlr8lu7ckrQaJ/bpU5iFe9++6V/+vzZh5HTNL1td?=
 =?us-ascii?Q?he0Z1Q79EK3uLpO/aX0rDuXM7JInvDn8/fJOH8TjFSq0gHk7FC6i1ZNtxb0o?=
 =?us-ascii?Q?FsKdwHDOY+zc2zHEp40vtu61HYIgGeuiyuMpgZYmkJpCF79swqOUfqKOG5e3?=
 =?us-ascii?Q?7hsCPASJHX4hVlfy8rz9aCOqyH/6oSQXhSX7ggGGmEikRgEy27VGd1pYTdHb?=
 =?us-ascii?Q?XCSM/in5EfRSVT8joUWiEEIooSV1RK/i1ANHJ56NI2IAsS37s4Hw2lsulein?=
 =?us-ascii?Q?DPTA6VNlj9Vd7xl9cOQ0VgmBYA27xoCvzHl720h10nm57nh3cSjIycBylEjK?=
 =?us-ascii?Q?iysqhxG9NWQCANfaF0fPYy0XKwcOSeKf3QyJDqcEQf1M5m8qfsENvbMT6Nl3?=
 =?us-ascii?Q?GqfrfIMyyZKPQgK37+O027zHgaCgrx55nd34WRBqw3ZAl6ZF/ROqEl9i+vc4?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ae3e4a-2a71-4972-a451-08dddaff6e28
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:54:35.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+vtN7K74MmiJAdwl63wjgcA9Ov69Xnn1fODh5BB47MyoBAjrh4/fvxQ3W22+XdgaRscDiK9eJ6q/BoTrordvie5YVZH3E4ksYcuKQl2CT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9013

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 09dd6e40e308..0f8636047365 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1093,6 +1093,39 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc_helper(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1112,11 +1145,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -1139,12 +1169,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.50.1


