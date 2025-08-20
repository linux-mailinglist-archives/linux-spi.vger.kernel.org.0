Return-Path: <linux-spi+bounces-9555-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18046B2DCA6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEFB4E381E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD931CA78;
	Wed, 20 Aug 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="rgt2uyCa"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363FD31B10F;
	Wed, 20 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693218; cv=fail; b=Ib199sfET06F4bE2SrZloK80pmbYZinjyV5nwMv/Vuz81xnr5sKnplOVbI8D+qhig/bN7jw1b5oIpk7vLULsOWZNRi8E5SRIBTbv9R4HdmuaoXOcTc7JnLVAWu7+Mea8+ax/m46SawUC10/SnQKRTqCcPKVGeAwmtR96dNz8d0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693218; c=relaxed/simple;
	bh=pNp22Sh6e9AsqSLN/KzmB+Zok3il72N8/jfIoC68sPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxh10I6TPltCDY9XagTqJwwlLUrqFqSXwjPrAkMSwFxzqnbVhF4x5Y3rTn4pX8BAimU4+WWk/51oDYHFQPNVTbReNTxKMVbr4wgho3rrAWolIIA+W6urMcTCDv0GbZDXV8jfLKIB3W0H/K2nWIkPERDTbaejTrIYtlKs4fUh2m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=rgt2uyCa; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iat6zVvw/LVkaH7SDYe+GZ6ePvdlsQR78uGYVw7OxkYon6q/X7STqlsg3x/UEvWfenzcboNRspP3K8kVtgayTEVITkcC6Sw6Az23GpILEjs10EjYsfKmh4hMKsZIJIDS/mTdowiDxKYdjlPkCey7l5jcz2kFwB1siek9yLkuV1jaWZMe5hWn0HUb6rGhRig/FUNVm3Mg3FE411BwGf6qElFBaoqTrTPxDiaX4iggOfvaYR6l7jdthvcUF4piOmrvVWFEWs9aLRb/8XhjPxCfNfG4U/FixXaVVfR9iCd/Lu80iI7W4zUZa4KqeuOwPDW9RupXl1FXUTlFw9TAZAq62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es9x+/+9CC1n6oSvune5pmvqNoFIy3LcqCicOnTCaOA=;
 b=sHH96G7WzlfdaaEmavqVk8cCI3TQnqqJ57AJ0MRwQOppqWPaW5sH72uNgmHdsbVCpmK3y2mkpwfiMMb0sc6LQ4ZS/E5H//IQiEipbzVykYkVkIPZ8HRvZsHVxKWyblIi+SQDw6R3sSKoC1twVMyH6okI7kOmF/ESlpDyycKYIpKxY5/zX0NKXTYGPB9JFuEdFd8rbhbqJws8ZBvRWsM88eTnTdsaLeHlm5VSkQBAq9dvbOYP9rOPzHOUaSoMAfSlNVjezPiojFVV8rB6LdFLgXM4qSJcY6Lt942+u8DIP2Fx5BoB+Mhdx/a5vKzjig7Hkap/mrBVuK0Nz6iK3UqmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es9x+/+9CC1n6oSvune5pmvqNoFIy3LcqCicOnTCaOA=;
 b=rgt2uyCahlqrtdm/2gxgPJbkVtAwYZ4RlVRZLkUZQLGYzMKALFKBocoJPy1AZ4bGHykFxbdEw/ad50Een+0obKpTB9QAjJafACxbBdDk9533ijgNS9guh99g15sMbG9smoSsYIrvCI8VVhHpAoG/aHKdCnKrZ3mmey3hp8DUaAbCGFMFj0vjuaEvb7w+QsdwleeQ/9pNnjuBGUgW6UThpnCyVA7kC/Dg3eb02dKzN+Pw+IT0Y1eyWv6RK3oO5Ct+o2K3xVIy0dqPz2w/KfOYxkqKnGzr4dbVunuWeKDeqU69p30q31ZUYNBdWuc+K0B6bJlh5Jk8yYthu9Lx7ueh8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 08/14] spi: airoha: support of dualio/quadio flash reading commands
Date: Wed, 20 Aug 2025 15:33:11 +0300
Message-ID: <20250820123317.728148-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: fe189351-b577-46b7-2cfe-08dddfe5c59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBqO2CfSebOr5yR2LxBsOq+BwMQj70EcN60/Cka+qBnX6iGENNcOpPAGnE+7?=
 =?us-ascii?Q?aj6D4p9Pzg8uAD+L+9ELkRVFTTEDyOGVL1lY4gLGvT/G/tm2YYH+R3QGK633?=
 =?us-ascii?Q?kUx5xPms1XHdxwAhlYLF5hAHOw7Vc6eLEsPU+RulqbnxUA6ReFhL+S//OuMR?=
 =?us-ascii?Q?0qRbDN62PlA13Eh/Hvm7TXsis3y3r0w37B3DBB+gTS2HFTKWP0e3p9wccdq/?=
 =?us-ascii?Q?wUluqm5rpDA9s+ne/9NNM7wviai7CEP64H5K3hmvLTQnupFNzmmAJuGx6SNg?=
 =?us-ascii?Q?2CPFXPTjAK8EwUUb+gBgke8irDpEGTM8hMEAdtHFdmSUs+Pszo+Ym3ctXPKt?=
 =?us-ascii?Q?2SlzYfDUPe/uyOlCN+NKke51yzgwL7oDEqQyzKTTVU4raeGxsEN2KnfjWuWG?=
 =?us-ascii?Q?VbHMC5gw4Ywd9yLbX2zQT5VjOhVznGIXtOkCmfIDvQKQ0sMr4X1lVmh6Q2lT?=
 =?us-ascii?Q?DBZ325xa1+WSwzTAGJgbM69qR1U3bZr7AMV6YypDntxGwvd/hxrczzvOI6hb?=
 =?us-ascii?Q?zMgY1jYEQvTkjOKO6r5eUfgOHYQAKg9tnovRIcJgr4BvHk6YO2ENWc39Zv+O?=
 =?us-ascii?Q?ACFeme5kZhMz1exy0ZC2koFGSTETh+aySfDMkxj+v/jwisONWu44LKAqEbsd?=
 =?us-ascii?Q?TshisHzDhvu5bIn8/nZxaX0+7hEToFDnCIBF5zW+FEJUZIEORYetndRd6YHZ?=
 =?us-ascii?Q?6jkkgcxv7M9tDBNgJM2nd6T4H5CJXJlOn84ExOTprRlEKcpjbtU51VAwmU0k?=
 =?us-ascii?Q?3UzebyFRzNVI1cPWw7VkI1Y5wABJtoM5dePiraT8c7twSM/71tSqhiHSnz9R?=
 =?us-ascii?Q?u+6OkRs9aO7X9DeVdCP3u25mss+Ph97BevtFheRCFhEYRyIu60zZVejEVALp?=
 =?us-ascii?Q?KFdlspjWuEGSdYlrnOpMWn6xsJm7hr0OfAln7PouoYtaB6PgRT1qQzbUh2rq?=
 =?us-ascii?Q?TAymeF8WJE8kBJKzmkez32MWtReAJe48TumVCZiIMLQuI/r54w94cJmmjGDq?=
 =?us-ascii?Q?0Vh2MCFFOQEPEWo8Ior3ZamUjeR/BOUpHdPLqzpEbxyZoh5uO6fhEZMav9Pk?=
 =?us-ascii?Q?J9W1rKzgYYrJTvHcN+YVVmeg/Xf63nabLIoFuKv8YfaijZVOhV2ldFHi0lgr?=
 =?us-ascii?Q?otfxshrCS5qAYYnAy7M3PjmZu052GqRvYqARV/YEpxRgialqs0Y373MDJTZk?=
 =?us-ascii?Q?Ob+g8xJya5Oo8MJyTdP8+xB8dgzTDOKDz3eaC7Mq/arjOkOqFxZlahrFrE5G?=
 =?us-ascii?Q?wkTfUwkJ0MFvURFjzRIUzqylYxsjBFoOv1gXJ+qS58BKsWv2VO+cfK79Nmhj?=
 =?us-ascii?Q?V9KFBSKO+V2IooiFidKWlK3esXSjQcIPcbX93NvH6NwHSlHFKTNTmoA/fyAR?=
 =?us-ascii?Q?uKxdA9mIh8tBlgjHSziOOosutd76oxavRuhV51F4Jqft1n40w7XSPROJiEif?=
 =?us-ascii?Q?WP+k2H7fQ3VFHg1NigrKC4bd+RTblikFHtuL2LnK7drkzGc8TnOBIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7DSuFADo9/+KN2je2u87rEfQM0zFGA7rbrzXES39miDO5HYPliw+vnFLAazU?=
 =?us-ascii?Q?3NhwhQaRFLv3IH7+sIXsSiJdKv1y/ADGtClIGgDadyVckfBw7BdaPGehEADW?=
 =?us-ascii?Q?5CwdWEMoMyHd9DTZbNxDAVEdBzNCUII6t6GHY8cHZp3KY2zybjzJThZpcZLx?=
 =?us-ascii?Q?vylfayn39RCw0/AFb1TzR5yKT0niL4RrekDNfg7zXDY75n40eQuMnKwfqg3o?=
 =?us-ascii?Q?cwhrZDSm9qHq7Kc4wnM+J45N+iTdTFdoBDGC9i0YRFoSC0L3blT01A0Oy3pC?=
 =?us-ascii?Q?1ZWi8M+A4DMJxY7dM92kDbFNxXEzf8TK+G62m6d28u9XOEQvaaVloR/2V4KJ?=
 =?us-ascii?Q?A/KP8d208TrMvgnrZ89k2Q/iiDlhaHFmOWONQSXW2iTTsHT4JkRJ6C83Qs7P?=
 =?us-ascii?Q?Xr4STApLxJVc+tpcklWUzQhTVmWEFwoV8uDCKM6C7Nt5yQmTC31e9mKQ+ol0?=
 =?us-ascii?Q?SASZzA0Nz4X6qPPka4t4yhq8SjZjU3QZhHQ6gOSTSNveUZHVxP13o6GWs/sM?=
 =?us-ascii?Q?dimN0FOHY/WBUeaH6lL7g+uhANdrD7F8ptlXLxwflrlxqmsTnwW2eKZPujv+?=
 =?us-ascii?Q?Ng3Mf4tnyhlUZNZGtAsn+zNYftrhH9SA6B7iLQ2eGlBI2WaJ472MD5yHRo7S?=
 =?us-ascii?Q?mYHOyKWXeonOXWkFLF3bYREyGwOx2fsK0F7tZBebprhsc7W8f2GIsqYoNZQq?=
 =?us-ascii?Q?Do1kR7SQpRWp5K0jS0RJfgUCpLu91Z1mRQTDlyZAY7xawYr2AGGUhbe3b3Id?=
 =?us-ascii?Q?kIhYwgc2G8nZbNvrFE3AyYWK6CdPhj/SJ14DUuRNl1axrK3kX5RW6nXBemMF?=
 =?us-ascii?Q?pOv4x57zIDeTO6qpkRe5O/K4xscGhiHsEXmrwC0qbi7t1G/Jo/Kfz9ChUfmZ?=
 =?us-ascii?Q?xrKqHKfVaU7R5XuiaF9NMEaqQl8pVo98BCARcolvC/Xa62ZX/Y5+w7QbOeyV?=
 =?us-ascii?Q?GW7Zyac0/9Q8U+NNDrbBIjnOeHkIEiK+eNoK69xNuxZn0jkJ2Shynv1+wn6/?=
 =?us-ascii?Q?wXmmquTDEok9SAC9nIc3H+VqshaB/w1HqYI0mLffhLPav84NkkFnjmdpscgq?=
 =?us-ascii?Q?kIIRAa3JO0N3vJsNP89ghlfvKoy+e4D02bpDtbXK6BEqq046VcOZwckS7tzL?=
 =?us-ascii?Q?INCIcv2HDjUfIjd0S6rsfapBTId8M4Ha4uc11FkspYb81Eeyqgb8WZdmnVip?=
 =?us-ascii?Q?u7BF2r5uh3hasQOoL7ntfymeMsdxpeQzqZolHuCg2LNZJG+D5Sfh52qgRMoj?=
 =?us-ascii?Q?Kt5jMAp2OWNEI55plj6OjJoOcNYV5AqGJHlEcXCwTcVkXCWMcu8ESZBqIBbG?=
 =?us-ascii?Q?2UNbTSF0V+k9+4ouzK1HqQ1NVAqM5h8DfjTltZMtUlpQRW38Ar+GRL6+cJlX?=
 =?us-ascii?Q?w+WOuHyJsvcUOVRcqbp+8rNKz2fOjzu5BUm2lyOEBE+aROhoJU72ihlNF0eq?=
 =?us-ascii?Q?vQKjA4HS1gNUnb1T+cEIoonCAk3d+jsGKhY0VXoXQS8NAcE2HxjfPJWYSlgK?=
 =?us-ascii?Q?1FYQxaRL4TF+aXDk0EW1Rtm3wgx49ozGbkau4Z8TtzP4cqZLnEEYjaoqoQ+l?=
 =?us-ascii?Q?cs8MZ5AqBPgjtNjR7MVmsW95StQtqigSyMP8jYnkHJSvfp+30IORoPmeTm+D?=
 =?us-ascii?Q?WIRe3Lys0IVARj4vma9yEEw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fe189351-b577-46b7-2cfe-08dddfe5c59c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:31.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUBQboYSfOBRQyMj4pKE5okzenHXXN5lH+8SlCjtPcUTo0KGeva2qM1HTr0kTF+hg4SarvnTt+SfgQGcFQNLtSdsFWd99W+isJE8lZx3OpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 7e1381c8f44b..cbdfb9051dfd 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -662,26 +666,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -715,7 +731,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


