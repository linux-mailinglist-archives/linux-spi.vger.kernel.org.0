Return-Path: <linux-spi+bounces-10501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDABCB841
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF061A61AB6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00C26C3BE;
	Fri, 10 Oct 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Km2hwKLY"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4D20C023;
	Fri, 10 Oct 2025 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067117; cv=fail; b=iBRYQ9LdI47FL1i4RTUcblVZxElAP3J5sSp8CbrLEkRjJYY+2aFFvOEuXxguOVBQB3JrcK1PR1e4NrDRK7yFpD5ZkzuaWh70nHRbCbwnofQodN6Tqc56WasQLuiMxx+60P9bcDkj2KpT3dShKBzVucHfY7Cv6zjUsfRrxcjyirc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067117; c=relaxed/simple;
	bh=A1bSBGy2kZH8EFv3WwQRHeaHSvuGuDCdM/uEwJlCwto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SW562i/BUVTAC6/L91l0LmHVNjZrSOM/7DPS8mNRDR6q2nhmoPKIKrTXMcSMpYVypMivCqtvaFOQngbru4fxtD/l0l/jPWnkZ0xz+xAV8WEiXtIu2ToxZ1aFwxpJ7Vu60j/HeIZ5lCc4NVVREk3srcAK6djtwT7xKGNQoFp6SLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Km2hwKLY; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdOexut5QVOLCv8vk5nxljyob6i5L8F/S3ykkqPg40HsLDrDC/0k7ux3GM5kJFoTkxefVwDE9cM9mdSk3256pfEcalWhVj+s53CnNx1IYUgXbPT+quxtrIkDuZy2M8Ocv6+BOD9yAQ6YSxDDDJ+oFt7EOfJrAOhRGr4aS6QtdduaRGoASZlUrJiVk9Fle2fE+S765tiw7lq41dd3LOICY3tUjFX5cUnmIHs8OZKLq6ivCsC/eU5KY/mSawBgAG198mqgjZVNlz31LeMvJyDG+HUMvoBTt29gQ8mUIXexTQi48GCCAQMt4nmp2R+XBXm1hdmrIZb8DGRlRqNM3rR35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=jUClb3V/uGIzV5RutdA620argfCryObpcy7xrrQrSpnzU9bbp+hE5Nv5pLw9fC2TZlkSJOTPEO1gNR4HiCoP3zxaKJydHDERNNrnVHhi+zG6NTRR79SQBX3Of4FZF1j9RyJFoHsfoaD12GBWsJjabXl7htrxIhNJQahmaBAIitd+iNrAf4JoqCsSJK573p28LIo1AzaVZ7m3IWZGyrUYCcS6oSOI0sD+BtQKPnGQyijdcpQRwC3ucEQkF4aYChmBmYUP01FoauKEeZpEwYJD1ycQerL5vdOSKLwekcMTF/VHNbtlQ9b6HAqbDHNEg2vrH0FXVh234wqzj/iwxAvdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=Km2hwKLYtbBSZrXb5Ie9qaSsSMeUDcFDq++w3zZsEeoG2klEr1HKIkEzHSd8YQOp0FYLJo/budk1JktlA8+qiDQ371LqvnwMBgc9v5HnQifOSF02ImHRI2hHMWClrsI/WjZNdX12D96rw2Q2wo60CBGvO8owINYB8fAzIAwHOuSkOhbSseLQ9u1uoj0bX5SMhU3b4JlqyE3AJkcHWBoECFZSSunJvGQGcRsEbnLZDnRHzKmFh+JxXt2lYLJUAD+AdSRPj0zcSEdpxGESWFVT6YFj0ujq3ri3LfYGR5TgFQwu1CnelbdNv8IS650r3Eg8ndCq9W9XaRS+M9ZRidKgFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v7 01/17] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Fri, 10 Oct 2025 06:31:20 +0300
Message-ID: <20251010033136.1475673-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fe3df2-1db1-445a-4bf1-08de07ad8a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZtBD1MG+X5zgpINFrJWI/up2zaCsjDAIHVhxws1E4+bR4WSO4djvJPesvc2N?=
 =?us-ascii?Q?wkVv1EUyZAglmiRmwS0DTMoVY7622R7CCP7k7CdLJUM0nxw4KRBuZfS/esdZ?=
 =?us-ascii?Q?7R6Tkg3vwshw1d15vDHUhfI43pJCGvPHbv/q4L4fMaBRlPfzNqknNd6VJ7Zv?=
 =?us-ascii?Q?7zhOYgUMBuxYgTMZJit5tnHftYYV9q77Xp1DHq/iXsvxUxVnaUbbOqiEWWIF?=
 =?us-ascii?Q?6a3xMVzYYecs74nJaaKfvPWso1n5cNaYd/NQ5wuRKTos1ToTkDvD6pYiYADh?=
 =?us-ascii?Q?Dk5agAJSWnJgkE/KB4dAA3u6a2B5TuRjN90QBuiQXwOqMutRN50zEQQSa+vc?=
 =?us-ascii?Q?LHCfGkKocAVGwOeaDgSk5Jyl4+N9bLpAo23Dzywbzd3XE6gOGLcEyuCI8BqB?=
 =?us-ascii?Q?pnZ+QNX1wCy+jMbq0yEbfaJd1dqzy7lrvaZMcEN5+K2QEycy8i7UcSa1R1WA?=
 =?us-ascii?Q?g5nnrGhzwgJiLhN3PBiM9Pgb78WKqmSqxSoUEDrJjPjcn8sLtZ0P3RRVAlNQ?=
 =?us-ascii?Q?oV4IRvz6mSFoVUrOwVahBu6BFmpUW7ciQArZiQFF7GlDmWrDeqzxU1JntlYP?=
 =?us-ascii?Q?8DKc+YdZH8FYnQIzI0bXwmchftp23ca2183QggmFYyHWhbTxbvUUycBsdES7?=
 =?us-ascii?Q?ph/3JZ8gY4crf6q6a6YnadSngK5Xlz0FBc8rNBqGgHCIaMvNT1Hu2eEO0wAM?=
 =?us-ascii?Q?zOOB1yQJ1RuzjXJSkz6iP4mvrpXkFUV7tgkBzT+i6D5PlyQioGA256GSLhCm?=
 =?us-ascii?Q?4eArMhFrH6qDPqAHddslg3da9HRVgcOR1rd5apzFnWuESV0HiYhs5tr+K0he?=
 =?us-ascii?Q?IvMVbtU+u2tqQAOMQ1h+HU/Nw3wdpV0IpGurDvBH/HA6y/rof2cv6Uc1xDou?=
 =?us-ascii?Q?nOYfpfito4CSICgkVhcJikSZ3Mj6iSRWlKrXgK4bqToy9LTL5rEf1RkLJb5W?=
 =?us-ascii?Q?mBtX4nAouzRUi6V2TrBh0+lzxq59uaaUthi+lCbpQGQi/ampzpBQqOX4yJ8G?=
 =?us-ascii?Q?Priun/fRMXGOVuws0HSRt2+baOonJFrLhnJ21s/DMmBEd8RERzAGss6K1lkH?=
 =?us-ascii?Q?xcvanp/fiyqLaRGn4CtfOSfqmydR/qjiecxkkFL9Or8WtHXJoG0CrWWGYDaH?=
 =?us-ascii?Q?10P605Hu19IwmKzxiHaKJKDe7h0kRBWHlmQTyWyP+NEkqAlkhwpPM3JTNFd0?=
 =?us-ascii?Q?ssh7WDfnnGyOtR/+92pH406svzrc7bSboJ/7qSRTgZSGi8KPjjvFb3KA7iBk?=
 =?us-ascii?Q?jGZ9LP57BnKUH14MlVbSYiljbZyiBCAHZ1TWmzEFQ/tFO/lXNaA1xgc8KkQq?=
 =?us-ascii?Q?zKDCsvDxuHxqy9eY/dZUqqQZMHqcojGM7O+eomFP2S2MBADuVH3mpJZ1UeIq?=
 =?us-ascii?Q?doqZkspiarT75Gl1FvxZhgcZ8KCdGNk1QozBnxKat6+9iJiIpHUSk2/tKOlp?=
 =?us-ascii?Q?4CobrnNu3WvJXnwihHGhBCRppEASdmaqhDe7oB2w9gZLf4mrXi02cG1fUq4q?=
 =?us-ascii?Q?D3bEXFFaA9KYvMtXJvefD+b3f+/XGN28TSM5rTT18/M+Zz9LtNFuYjYZAw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BaCWw22dvHHpp2sy4/LRdk042f5ne8LsfPMO5KD3FvIGzoCvOl7hDawmLz7+?=
 =?us-ascii?Q?OzmyD0bPObYTfi8+WZgguNaGwFjseBiIdarC2diDh337y7ErWrFHZTE6vTSy?=
 =?us-ascii?Q?1i8dBfflDh2L894CyBrGDNEooqwsEswQxEr4rDCk3YId3AmoYorBUFiawiq9?=
 =?us-ascii?Q?q/BnQIbhldR1EqYAuDHb0P/iocBsskhUO8il9ntnSpmowIGKi8pteHhWTScc?=
 =?us-ascii?Q?DSyt/rSOOHMHXOb05WsG6yQNYhkCNtn1vkyFVYSVXatFPY/qiBPTATEuRXPS?=
 =?us-ascii?Q?wKognEnB7K55bLdMp79iJhEg+I0FCZULtor/WtYihUA2VWngGuK5b4rD5j2+?=
 =?us-ascii?Q?4mwgs1rLMzBIPRwbWUz9nLFU2/dqUEdqM3mEJTe8VuS1hIp7JKnjM/mkv6KO?=
 =?us-ascii?Q?3PGWk8cz11EPNcwbRN6FsUK69GaBh+tk8IzRhpuqYyd45WFesS7BgAL2dN0Q?=
 =?us-ascii?Q?tjbWil3xHhxmtT3G6AsiRzlllW+b7rKNckAWWfn3QIyIHLFwkmLMeZOdlFsQ?=
 =?us-ascii?Q?XaQy3x+466/iVpiPgGX6Hlz25nZVhgwyzLQQ5411cpt8JESgimzJ+3E/n91N?=
 =?us-ascii?Q?853weyfCkx1cQgbtHF86P2AuhBRQovAVgeepeli16QbYf8XMAPxwoPRN+izs?=
 =?us-ascii?Q?K0U1paty7kPkV7SWb9JCVgzMHRrNZc15DqOPoW4IlLSbSE45AdXPeygQNwk0?=
 =?us-ascii?Q?8dv/qH4dS//LnsP8blfMfTa6kJpYBxtRAReftCFMCc7yn1fJ6wKlwxXnq9oN?=
 =?us-ascii?Q?IN3tEqmh0QyNiGyaj/VijHDgOrfHZTSJD3GOWTP3ocU2lJmdPy5dGqLXKF0W?=
 =?us-ascii?Q?UPRoYkmtO/a9L+qU5SWf5WySw26mwRZaxCllQnwSo6FCr9AW1djMn0G0wiIH?=
 =?us-ascii?Q?c6aSy3KRlh4UlPkQpbchuOdI+XF7tSCwi8rlMj3jn+BDKvqe5nsKeXoNP8jV?=
 =?us-ascii?Q?Pc7+lXEpG00D2aZm9uCELO96eLGBv5X8DFVD2bm36ZEdOFWDPAYncbne0xn7?=
 =?us-ascii?Q?DO3bKZKvqdGB4UdpG5Yi2HL2Znn8TisEIqwzuasKEmb54RgIYiilrnlHsbDK?=
 =?us-ascii?Q?9qG5U0Xncim96/5CGePOR6dJcxZogfhLxHPyuMsMmtKMqdlZrgdiNQmCmSGG?=
 =?us-ascii?Q?W8OUp814hNAu4eZiMhAhKU76IpaT1RPEw5wMdA1AR26Pld7r9yP/kj1SipRq?=
 =?us-ascii?Q?Ry2K7WBDqUjL8xbSJNKPlIRF4z6dAyBjPaCAW+ySLqtiO55vWV06ExF4KAAi?=
 =?us-ascii?Q?LZB1ZFzO77mC8fSCdAEgpFTiQ9HoXZDqDLH786SEKvr5RnfNeL7XDT910F6j?=
 =?us-ascii?Q?BZr12xU6jt6FN4I7bd1pDYSVNsXU0hS9VyiLS7p9CgopsEh3PNqeuvhXQvmg?=
 =?us-ascii?Q?e7K5xhflqbyOsS/LjW/pNxYGMTKdzk83WVGKxjlK1JXgb6l8+3LixiFGLPTb?=
 =?us-ascii?Q?3qb2CQphhOy4dIhnWI1BEngvhgwHDEe1AVsq1xlh3yWQYjxbdl8HLMreP85n?=
 =?us-ascii?Q?xTfBFYh2lAb2Ag3SSK/az5LuxytPzITtkiInTFE4xYTVereOPiBb6tulmOlM?=
 =?us-ascii?Q?Dj74v7SY2XmH9JHMfH8KqVNZmr2zLHR+ZHwd9fckN8/PXFgH+RFQWMCoGclT?=
 =?us-ascii?Q?ZoKZSUGcn+smMYlmaZs4oFM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fe3df2-1db1-445a-4bf1-08de07ad8a8a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:47.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXB1ghW42wXRQKU48VOE90BOnBxiC64/weyzZp+AjovJhowHJoQjxeeCp0plBPuDBCoOzn8Seyo5FOOxFMdRNyaGmOZScSlZIh+THve9DfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


