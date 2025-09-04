Return-Path: <linux-spi+bounces-9907-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65650B43EB4
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660BC1C87BC2
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED8312835;
	Thu,  4 Sep 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="QxcYUdPs"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021101.outbound.protection.outlook.com [52.101.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93933112D5;
	Thu,  4 Sep 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995851; cv=fail; b=pLUTBNMgj/4zPq5dbruh80zncS+rpZBL0NYPIwJz2DUMZot7ouvG65BgegOwZHLHW+v2q7U1bAseWCDPC4+TbTIJ8NDN0DLuEFYUoYgDPvm26oROgsKtE1L2QwzIgak7uNbKtWWd+aJ2GIVQrna5v3IJzWWm+nXD2TwGwrljcDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995851; c=relaxed/simple;
	bh=mIkWf0s57UR8OsMs3bGeC0x0m2/NXwouHXhaMLLyJm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZa8NMD39ee8qzn6RWFaYmzvllQP96aX/o1eOFoMdFqj0Ohp5sCxAcVRnDWyH6x2RhYkbQIE7Gt8iloF86AS3vpITtZe6FNJLZBsYjYr/A8n1eeddmca73WZedf9VccO9QRnmjHYb0rQjPRVuJkEmNaXJuyQ2L0GtQfZhN+Vcpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=QxcYUdPs; arc=fail smtp.client-ip=52.101.70.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtWPeMFdLC2G3EmsQJ4v2JKlNmvjIeUk0yx3JCXKEB5xVKhcSCSWBeN4nVMHWT5h0w467vtT3hdaII8GynDhKGUAOcdpVOuQNazmTVXq7gBAmQfspyd76+X9WpdXGjPJdG3tohX4QH7kHnwutfQnESqB7PSOpMLGz2AqtDhh8Mn6Q58V01XQ3/Jksft7S2el0b/OTa0k69ARHU79QFXXlZNN6y8hw/dUXpoVm0uC7E2h6thLfMEdKmRwkbw7kC0EtlIthEd/DPid9ZZLxcBN3VpKydPhOvYhrYMXr9m3k+LKXDJKvNIUJkITUJgugvNVo3yNd829OU0OegpVzvHDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1koqH0E0qJmiPIFwnSdrCnYxju+8bSv0nXlAqye8tFQ=;
 b=CgC4bHZur49sp+aVWIbrL01uZ9ZI+yVkEehOwcP0IzkZ3RRP1FtVc5ueZWSAyppT3X5cyKjcgEggF9zwEuCk9z1Uh33/Jjwq/0/3Q+Dy1PDv+UAyS0BvO1uOtUcCTcb7FbyEeh0T8Uiwh+1US9+4XBA2RYqlwr7yYnW7UJCI8E1heBVB/ZciybIMjE1f5Set2C3KJzNuQZ4mCz7eFCriO/fqmApDuTV9IdcHH2+b3ydRdmiJz1FyrrtrNsG1GPr25QdJGcbYZeesjOuLSTCvtU5LLyfXMFBYxDRLhETWE+9JInaca35TGnr4zIvza3/w4f/lT2v0Lj9i23Xggd1+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1koqH0E0qJmiPIFwnSdrCnYxju+8bSv0nXlAqye8tFQ=;
 b=QxcYUdPslcZOaZcCT0MJvzSwRNY2n3DZK8O4kggdmrgveqBnr7rspHKw+ZaC9tp3jbc03oNbcvOBoZ5erbZJZciLwDmJ9IJjVChl0RrXJd//h9YyMkyfUXM2DeeiHVd3tPq+ddJGpeMXfXBCD2TDdlrAqWbD+6UqMytsf053PICIgSssnXNdPiFkDbOGwTv5dnWHWx3zwth/SWrvlRnE1FSWDGMhLPCvvlU0MyTwygEJX4UjjjSkLVnRlbg0r8N3/qGEUrN66swxsslMbtu7IImWa8xIgU+cBY5XfzTqNXfbkz/zOK539vhR16NBF9dOwqpar7PXIiBFEQqh2V46gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6436.eurprd08.prod.outlook.com (2603:10a6:20b:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 4 Sep
 2025 14:24:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:24:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Thu,  4 Sep 2025 17:23:38 +0300
Message-ID: <20250904142339.656346-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bdb5cd-6caa-4132-5bda-08ddebbeb24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GIy2XgFyTNrY9GhBzPjwKLa0/Qi162xywHCfueonVBVtAKBBkWXOzKDxdjpN?=
 =?us-ascii?Q?Z6BGOOqV11CD88I9h+ju62SWB1qYVJTfPpnJXysVEySj8c+qolqLlytTyZlD?=
 =?us-ascii?Q?2aIv9mW4uCu/gADIyTkk5Ku3emNtgnvP486SyXSQAYa9HC/yOZbikCsYG43i?=
 =?us-ascii?Q?xWjzlClfTCafmHQIdI2kUzPUudQfV17mB2B8QoOBNb5oKG1Rk/B7p0lXzBep?=
 =?us-ascii?Q?uLnBN2Tq7uXpHSu9jXm96iFiQjoMPQEH4njyVyyvMH/Xw7xLE+c2yUJsTb/C?=
 =?us-ascii?Q?fq0UgvWy/NFseU+xF4LENeu/YNHJAXxTfDnIGjjbF0zNSaeVfzNiCEFfX5Q3?=
 =?us-ascii?Q?QoqcfI7TfLH/d0abs2MfOhg5JOqAv+Vg3Mp9FYzOs6wRP8lgo1IWWZpAOP18?=
 =?us-ascii?Q?J4Ah9FgXfu+MWMnpuMb0jq0SOZWajJIwQxminXnvPpvxtII+NpzTYXwiz2ZU?=
 =?us-ascii?Q?pPt0bb0h7aLgFCZ9IOTxoE1/hcD37mHNc+4tWkQz0q83VcWWjdNHEYmx/oF0?=
 =?us-ascii?Q?CJPghifpfj01jK8V4i6iY2S2tAyCrS3kdIpwuX/+MrZHyExJZsE19FvNMaFz?=
 =?us-ascii?Q?USz5BfkDsP2kSPdvdLERXCuC4BOSKsSyMXunVyHvYb8mwO27BF3CqiSMzLFy?=
 =?us-ascii?Q?ncWOsPuZZnqqQAUwB+fK9xyUv3+eB4YGYyNplo59o8GW/y1NIxQnQkulyQA1?=
 =?us-ascii?Q?HRzn/g+PCqJOAsdtNBbN0/5ywV3hsxD7wgC83xhjBZCKu+F0e8Kfe5p+0Iw7?=
 =?us-ascii?Q?nDZbjXjP0/yydcW/XwTi3YaUCmmR6v+MdIYLMrIWN9Ums7kxpSS2Ajj+f126?=
 =?us-ascii?Q?UNLjeflZXeBpWCEY7kPDQLSMrQ+qZSzgxlRUDRFyKPRWLjbrfCijqeh06K17?=
 =?us-ascii?Q?n0TC0RC8gupiYp4v7/Yn01HwobVacz4V7pmvpZv3GZJ19s3ZSGxkludJVBfy?=
 =?us-ascii?Q?9mQIu6EKq/pxr8RPfZEJw0gXrvpbP+Vcwsy7SHcUG1qzh8piy9uqSj9YXslA?=
 =?us-ascii?Q?E9TM5oi3OrOZEIlupGS6kfu9ijjgpSJN14FFuLOSEED6nejQOIeipQsEaEV+?=
 =?us-ascii?Q?YnYzxymS7d1oe0PxX8/N/BKtNqzPxWYBMyVYttCC+3ZacOSUeg3Jb2PMtiXd?=
 =?us-ascii?Q?rWOIFrUIrmPRa82keESL1Egjwm4Ko4cHkSaD5Bw4oNF2HVobjlhQOcum7dmP?=
 =?us-ascii?Q?j0KK5MHUPZ/huYH5k0ZeRJTEKIBZWqe9LJI5WF1DTXLNFMfLsKdDw6H01sc5?=
 =?us-ascii?Q?7G9eKQ72nRyWgeS+yJ7kDplxT1MRy6k47IScwaC73HjlbZVZut/9QJqZq/j6?=
 =?us-ascii?Q?7fVl4qgl5uOaZPXKQ230VR7/uAs5YpD7YtPd3wUyxU9fXt0HkFVPU//DOPSE?=
 =?us-ascii?Q?0P3pZJpiHy91yc/5+zjHTRaiCA+glA9QgeUpzE++mnaJoIH4RLlk53SguMzT?=
 =?us-ascii?Q?T37SjmpOyu2tn7iEzf2POY7ZOc5gsKpqCmrBbEMFu2eQDjbiGeoC8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdlz318oyePwFccEZtVQJK3hGgpYIPgCRy7oyXfaddOBGEPFVWyJJod07b3x?=
 =?us-ascii?Q?bC7ZQeadL7ZBymWvwSzcxkSk7KIQ1ePdHrrmIu0EtDi0cb5f8k0ijIUCSiip?=
 =?us-ascii?Q?modQZ13p636eSpy7vscji0vgD9mMX5QEBmsEsrGSunjgQuWvkYNeSdYrdBzh?=
 =?us-ascii?Q?L7zV+IW0eGyxaGyRAGHi8xG1Q84JDuUq7kKMV6h7S+r6eDa04hYn5ArR4vwq?=
 =?us-ascii?Q?RQE4fz78Qf2dEHonFyxsAaSVkdmIUCedEZ5X/NkIr44+CNp6tDf8ToeSGhDe?=
 =?us-ascii?Q?Vuy7/a0zwdFkHk6zbzXWWo/V1jWkjnYkkSM6dNjJ63ptIbWBSF+fh9+fx4cL?=
 =?us-ascii?Q?+dyKbJO7W/8V0rviXnSxzVlfjEreO2xlWrSNL9/GZ72KG5B/pJTcNv2cVMvN?=
 =?us-ascii?Q?sBeXy2u4YJyVwmlGSQpQNrQRF5MRg2K5/oMYZ2tqeENooFbz8Dr4R4+0nUCj?=
 =?us-ascii?Q?yZZ4j5EldVTrZc0KQn21TSoJH9OT2zKSTMerXdUVDyivJohh9Y20F2e+Ohth?=
 =?us-ascii?Q?UVVuw+gEtNMeUL3s7bpba9jYJGQwrQYx4hy0o08KVTsWhpazVF6xdaXSm/0f?=
 =?us-ascii?Q?MszLxDLEfeTIT9TxXUoBCxxe24cr8oEynd8rAk2CD7gi4GyVCNRRaTxsfHA5?=
 =?us-ascii?Q?FBAFg33u9qlw6MMT6sV+Lb6c03rUpBitstwctWYY4zyC6O55u1sDVTO6IgCT?=
 =?us-ascii?Q?8JE319rM2Mx8EwbmNo3zXUlwxrwAni4lIqGCkS+XY6/6MDiT1nvff1s9Weyi?=
 =?us-ascii?Q?Xxqyq9AsCv606jPtrco7rwZuAUnwQsNFE1Zn/P5pfPE5+oPCz1aQcJGYhal8?=
 =?us-ascii?Q?hq33temmo6w+YIvDiRszJ75pfpHVWWZLU/UKSr6DkzwS9uGC0RmpqjkJOPe/?=
 =?us-ascii?Q?dn7QaQhNdetTdkN2vy1Hv/3jnnEJkb6H1k2EOuOmuL/CYNJC4zAI8dCFco/R?=
 =?us-ascii?Q?F0nikYkCgjG8YUew7cQb7MvhLyl7ISZqM8Lb71X4qfiZUjypjFitX4kP7xVj?=
 =?us-ascii?Q?395SxwSBvkdlOCbfTidzOGkyU8uH+ZDSFa39aXUiJmiSQ8qFrXViNZLxL7wU?=
 =?us-ascii?Q?/6XR+WPNWLOSJ4r7joKrbDq85x79+Y7Pa6MwToogjBg+9irSKyjjli+AdTRM?=
 =?us-ascii?Q?4KYrnQ9UZHl7z7pOAMxOdtwlwtRdubFIEe1bM8lCjPmdZ3l9AztxrTBZU+LP?=
 =?us-ascii?Q?XSOm0Y0qeb/RPM2I/ChBxpqrEq73Bn0qSTm604WsKT29fTJ08SLnuWIj/zFd?=
 =?us-ascii?Q?rueg8ignf7MgmTaGwRp7bNb8ZWxeYlxO1MKeRWV9zx/UOAk7SbLa54tEP984?=
 =?us-ascii?Q?6bYmeDH/fDF6sNWecX0edK7E900FtYbhwLqjkSvX0jliIU7I75mAGpOMy/Aa?=
 =?us-ascii?Q?cyCC1wOUYs+QfOVoBc+luGV+1kGMt1VlBGHRNDmgHDA+8fxUBOdGtZfHZx9l?=
 =?us-ascii?Q?syCMAbuLnpu3WecGgmcdPhgMkU2QfeSzXwaZF72VGpDGAtYai8n5roi3/d5A?=
 =?us-ascii?Q?3NqJo6N3hSxAkDtCQOHBLrCRJpZpa5LN5kWXCQO9Gwdk7JhRgk2Zpw4a97JR?=
 =?us-ascii?Q?+Hvegm/goNBUksy0dEEgmDLYZdKR5dEe1vi2gm/ZDfbApS0DfWAG3D7mvtoT?=
 =?us-ascii?Q?hYR+PKnXYimdu90MNxy3pYM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bdb5cd-6caa-4132-5bda-08ddebbeb24c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:24:02.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXLl821g6n68BHeGPIgD3AsUOjIWXVTqTmPhOgwoSg9mPL4HKvZn1B3CN/UaZCgSAH81GtmXb3/X5qSC0WoIkzJfkghvmzcOGCTWrzUCJRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6436

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
2.50.1


