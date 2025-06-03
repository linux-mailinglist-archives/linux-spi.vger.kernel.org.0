Return-Path: <linux-spi+bounces-8360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B9ACBDED
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 02:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5373A1D2D
	for <lists+linux-spi@lfdr.de>; Tue,  3 Jun 2025 00:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC3A22F01;
	Tue,  3 Jun 2025 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="j13X2wXW"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E8A94A
	for <linux-spi@vger.kernel.org>; Tue,  3 Jun 2025 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748910250; cv=fail; b=dvySAGfrLNgCTi7knVRNSMbIdYPpVPLnS0Pw55XVGftxAvUBxQ521MgXNgGiPuqcX47Tsh25rKp+2Sy1UMxEYwF7fvkpGGxvh7Jt/RSTV/8GQXGeON9hUwZ7XxVQlDvwE/rNdB2w7GzXl8jcUJmYI3eFcOuNDZQuyWHw46/3KtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748910250; c=relaxed/simple;
	bh=RiQ92LQ38MvJv5H4tRRj4ScCa5yOkYi4jg8eX3CpL0k=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GqBR6xD+eYzsTJee/LyGka893qAX+minvi3QJCFLP2X19gAV0VZd3n+Xvl9ceuqtlZ7LJtokK0BIUuR8o6/5pI+wD9A17OSW88ykL5wneBL7bvyHS1+LpvvP6Gi+ZcJIFEYGuRs4CMcSl8PGsGjjs/W5BXzlbBR2i26tgbEB/eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=j13X2wXW; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVICRZzy57RUgZBQEVtOSwZWU9tCn0Hh4htcyeJJFMEO8o1AjTIBxZGk5c2JWWRxeayuiLY0Vg/AyVHtAnlDoJphG4p2PXaKDv4/J8N+L2rehP5Kf9WoeyxT2iSCK2etoPG1ufbBhGmat+BV8ggkjI0E7qZPMEtmKqspNhTPA66wmqzOHeOIrrmQvBcuPAb8pZbo+DrGpoYwHlEk4gMgbamHxapuh7jcydxViPxSm3xooOBw+GVOvSCPfd//TM/iZlBIT6rrDY4kim3doDlZ5WcbdX19L7iQRoj4m2pfA1Fyg6QNxiQZvzpq97RvQvX/SC+FAJMa0KNEAjEJz7h+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGDvAt2d5c8yh7YJVwpTSb9F0uCT2XWLBrYCCJq/l5M=;
 b=XwCkl+c/RHLxEKWRo857P0AETmJvMQ3+vVHuZ9yoEw1dQd7MFZTwODd+EqJcRNnmlUKjhK6nUIVuY2BlR2Ae5b+VTzKunbhtgtwhOxljp8swE8pKJGIbdLVE3Vovecv/fu4FiP5hER80h1a/vqZLywVMqk/GUotOgWygRhq4mRhryE0O047A+vsi1xtMs8Iu6H3jJswhMIhjepc4Gf32yvGFvIH/RXCeQ9qVhGyHoNM2BTWO2pUBNPXeta0QLv0cTKI1WG/C4e4CimxmwXUDZXE6/6elsAyJADHgvtOEyZYupzFzhusJiu3O18kf81ZVhCo+ELGFr0eSLQP9xeYdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGDvAt2d5c8yh7YJVwpTSb9F0uCT2XWLBrYCCJq/l5M=;
 b=j13X2wXWJOh6j5WLpMbpNj3Q6Zs9QiHwP4cqkbt/HU9iJZtT+KkAiQ5JdWpEbHp/7nVLQczBKfOs6L84NCn66Ru+4YDgHD2vzEDFw9Xx01nTmWiIHycA9hLMexO+xSNTBaiXr0s49c+RpNIDnrW7Xm1mOyZ3vf1aue77ln/AsLbCTVGYkJHAL65kCT1EZBPe2Cg4KuKyp2DkryNmj+CBO/y5K0cqHVED609j3rR1P/GG3MzfostrHdOV+uA6L6pnGOKnT4TRavp71QFZ5xFH7paaPtyM/7JXMKjPjIaTEf5bacdc8jFtTxJXP/TaGgp+bEu+WQMznAca0hAIle+xqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by SA1PR03MB6434.namprd03.prod.outlook.com (2603:10b6:806:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 00:24:06 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 00:24:06 +0000
From: khairul.anuar.romli@altera.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: [PATCH] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Date: Tue,  3 Jun 2025 08:24:02 +0800
Message-Id: <20250603002402.11024-1-khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|SA1PR03MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: f82c1076-6ad1-466b-fdb5-08dda234f34a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bT1NoXBikhkHFOrO6++KgrEmKB7IuUK3J5TeHZTM9L6vUe/zlzxK1HBo1vPR?=
 =?us-ascii?Q?WFakWM2vYHO+1GQOT6B907vyRR0UONN64oQnsXqfNWLEoW5118GS8g0mPrui?=
 =?us-ascii?Q?KVkNT06aH4s0ZPmp4+z5bPRU0SuRzpqjMJAClggJWG9j5PdZQrw0lRrdJaEV?=
 =?us-ascii?Q?UBoE6vOEactEtaiDS06isnALrkrPxDHd25iLhILZrQBYmhPjQJotlAcWgKAD?=
 =?us-ascii?Q?DsFBzlFqMVhK+0PcJvv7GGcdMh3PW+WQK/tfPc2oCb7t8nYXNT/mExkpX1F7?=
 =?us-ascii?Q?sAPFW9HIrJjy0atREbg+A2ZU0Pbhr9yU4ZXLG5x8oIuv0wQwQYGhl2VmkjNd?=
 =?us-ascii?Q?n4zOT9H8x+1UhEEjasavG/sPs9dJQjIm3wBkaJIYvyLTw/O5O9Q/7+wGxXJa?=
 =?us-ascii?Q?b1aN8ff/9FU+b3mzB29EfLy6snm7ySOJ+ERCpoTWFYshpOAMN2U5jzhs1NPn?=
 =?us-ascii?Q?WUw6avlwsfHXv1hX5Bfxdr8t0UABZPJFXKBdjbYGxi6QLe6np2dtBrfALJ4x?=
 =?us-ascii?Q?xJbhpXBDtEE30stc86wfyr1Bq5hYoDefbeHcyVeOV9Z465eo0acUcAAjDGpQ?=
 =?us-ascii?Q?q/ghllBueOLyvrFS9a/5yd13rO8Yb+BdTKrzRFL1MWTmXPXvnQgd+UFFtnjy?=
 =?us-ascii?Q?pt5Yhx/WjYAor3bwxfsh7POtO4RID68spFK3Km2tzfoBPxq5aeIeDRRNYU+z?=
 =?us-ascii?Q?eFIBlBdg/WfvJjiYggeFZzwF1kXLrIFeuiBeb1z5Us/ZMwQZWCEVw+YTa6P3?=
 =?us-ascii?Q?H7+oDo59e6528vGRAJ0c3oyvtVvnttdWhSnK31h8z7xw7QqSGbtYOohohuRN?=
 =?us-ascii?Q?mDnDUaKqIlbaEIdapv4FdX4oRiEgMXmbZXOeA8T+Chl/KqHPnxM9vG5NmU2U?=
 =?us-ascii?Q?DjkL91PzWZ8o9OOvENwjs1O32RO0eu+FMoReYI39xZWalNMESlcXGVH1LzTd?=
 =?us-ascii?Q?RBwlIz171pao+APiIUSg5dQ0YaajeMBlTr6iVPOy46nGmAFy6qEk/4RpZFpi?=
 =?us-ascii?Q?3+SLFvZU37xmvUmL6fDY68WZYtottp5JM2e5wvjQ2THe0AlyoEx5hYxNSeYV?=
 =?us-ascii?Q?F8kPFbEBhJ/D4MA/uAjq40IAcRtb206Y+8+FAi3il+6c8k1vdQaISSIE9FXQ?=
 =?us-ascii?Q?oiR//3oyNMP8hnvBuEoeXqLoU5YHtLOEaYVLsr+4L++w9a3pmH6ziXjEP1Qc?=
 =?us-ascii?Q?Vr4bzo/M5R4gt87OZY3afi9homDtuXP5zZppYcnvvaY6kZJ1i59a2wsolAY6?=
 =?us-ascii?Q?uuh+TZ5srh/kydNEq4XZ52a9D6qM8uvNBJItyS2UcjtKy5DsItteOv3zbB2O?=
 =?us-ascii?Q?YjkYXzXWl+xHcejPCDXB8Lgmfx3TmIBN5FhUNVJjgLRzncqDHfQ9+EwEuzYu?=
 =?us-ascii?Q?59OzNp2c2bVcpXW69zpw+vYdsZU+yGhYC19RryZZBpImFYf7Twqz0uG/V3ra?=
 =?us-ascii?Q?ancvfrqci3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YIUkvkDhkg3lAGzOVHV9kdKHWSahx+4F9ud57NRtqmEF0MkNBx+iNuctYSBL?=
 =?us-ascii?Q?Gsx7kU1P1zlXLXNMlARBQn/MiTeSpVuaSbqZaA4AVEOVglMuSYYHc01MVZ1F?=
 =?us-ascii?Q?r+w6NeQThHbClo7GfpBX7Ak4SfBBg7ETsR3qtOEGTfa4tE9hqj2Q+GCcIdbu?=
 =?us-ascii?Q?0dnL3c1QG316P/pIYy3eLje+dIS+m3paxTuhxbJU3q9mj+A8zoc0CjVBzu83?=
 =?us-ascii?Q?ZThSOn0gvSOMJA8B1xTGH8KkF214+2X+b61JFSpURxQCBC1jb4qdnprp3bIc?=
 =?us-ascii?Q?10beivn1c0JC6jjF5lj/BTak9VFG+eB/QuejXMvA3CJCilGRxnQWWjLklfyS?=
 =?us-ascii?Q?G0knR0FChgikb0bZ4Iq7AAJYYMN3RNmAIy4IFY4baxMATDPJWuVcj1GTG28v?=
 =?us-ascii?Q?2UoEpD2rK2S+VYfk6ScZu4YzWO+xoScdBHSstmRAUuTXuLFvuSvLrh/jKK+J?=
 =?us-ascii?Q?OcxLCROqt8e3+s4rVV41CaIKD6HaC1sqzabpv+v9bf1CK6xx2m4KYb2a9ApY?=
 =?us-ascii?Q?VlKximsKjvFocRVjfh7nbgN2mg8FTeLQ6NxG5qi1dPVVBvkyFPo8mC8cmkIY?=
 =?us-ascii?Q?kJyQ2LU1dYAmbPB5vpleJvX4V9sfcuHu76RoR4/uqLqgV10bYhl6PI15sWUk?=
 =?us-ascii?Q?cOaL37x71SQ45Jv1/PhI7VzJMwDWxhbhTG36Y5xak3ipGaGExlDqh/fxTHsQ?=
 =?us-ascii?Q?cLyppQmfbtYb47AWzIpA4yrN8m8fCZinUTAt7mdC7VOnSiqsBOTx193oNKkS?=
 =?us-ascii?Q?8dDz/yiTugBBDjzBCaEIgb85dDL6hC0q7rGCXeanFGkhAhvoyK8Ty2FFjLZH?=
 =?us-ascii?Q?GzYuSnckatyJu0WgaaCBtECOLfSgiWus3OpWUUvsK5fvBoUY3OJdDUwGd8vV?=
 =?us-ascii?Q?9R0/SWVPCdY1YZA0YTbT0IkCCOpILMdxvwQbLYkevXDEszz5KMiRFIb327lL?=
 =?us-ascii?Q?bLjSxrHcqL+ycVqVANQ46UeeswSyLcUy0Qgp4QE8D1b/PURIYnVOp+jhI4Ow?=
 =?us-ascii?Q?dC5LLiIzt7JbeItpNwGytggKDG9zOT813JG8HiIq5PNkyhHyo6kfGH2zY2w8?=
 =?us-ascii?Q?dt9EQstiLiMiKfgSCRyJldNvFrlYUEPgmQ7cXa/7JoOYInmui+kC0McCCvyf?=
 =?us-ascii?Q?mKvENNn1toab10WskS4b58AjrU69Kz0DIk/0BZmgHfsZ7/29rX2d77bOv/hf?=
 =?us-ascii?Q?lNA0VtU/Rd270KG7aYO1M3PfsO7UPDCWvJYwTnPPymcyVnvAIRKWK9krNmLS?=
 =?us-ascii?Q?sqWWfdgh3fmnRPyF2Gfmpq13AFKXe2XygPeow3ZoyCOckM9ga1IR1maNc2b2?=
 =?us-ascii?Q?0bC5yHeImlIiYuFbmTPe2CAuSDoAFtY9v561zESy5cq+vzOe+R7kQ9ugd/ZL?=
 =?us-ascii?Q?FoppcEH+wMdk0UNMWS/IdZGdIrjVBuo6ZIsusGCbgArkYScjW5+qpqjrXR9l?=
 =?us-ascii?Q?K9xylEFOI9q1PEyWYRnnCOX4LJbfayP9fZP1wi0iSYwjcTcVOF+U7EDOYECw?=
 =?us-ascii?Q?CxTNXlQTO9SJssTQxUG5weO7996bwGAcM7Z8ytPULDNuehUfjHCkwwyQx/TN?=
 =?us-ascii?Q?QpInHqcbUEw/vShNi1IWO6vuxo51vqstU7PX6NaHHVdj/jcS398N7ezhK6B9?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82c1076-6ad1-466b-fdb5-08dda234f34a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 00:24:06.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywIrUMuiC2oynr8bRcyxOOyqg1ZAygYgkE3YNe4gb6eO1PXFSKkKhAR5IkyO09Tm7RZM8+bKGmRXffZwFnL/YQpdzY172zwBr8s+X7KPmks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6434

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Having PM put sync in remove function is causing PM underflow during
remove operation. This is caused by the function, runtime_pm_get_sync,
not being called anywhere during the op. Ensure that calls to
pm_runtime_enable()/pm_runtime_disable() and
pm_runtime_get_sync()/pm_runtime_put_sync() match.

echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
[   49.644256] Deleting MTD partitions on "108d2000.spi.0":
[   49.649575] Deleting u-boot MTD partition
[   49.684087] Deleting root MTD partition
[   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!

Also change the clk_disable_unprepare() to clk_disable() as continuous
bind and unbind will cause warning being thrown with inidication that
the clock is already unprepared.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/spi/spi-cadence-quadspi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c90462783b3f..85e5f0304dce 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -108,6 +108,7 @@ struct cqspi_st {
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			disable_stig_mode;
+	bool			runtime_pm;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -1958,10 +1959,11 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = devm_pm_runtime_enable(dev);
-	if (ret) {
-		if (cqspi->rx_chan)
-			dma_release_channel(cqspi->rx_chan);
+	if (!cqspi->runtime_pm)
+		pm_runtime_enable(dev);
+
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
 		goto probe_setup_failed;
 	}
 
@@ -1977,10 +1979,13 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+	cqspi->runtime_pm = true;
 
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
+	pm_runtime_disable(dev);
+	cqspi->runtime_pm = false;
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1999,13 +2004,15 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	clk_disable_unprepare(cqspi->clk);
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	cqspi->runtime_pm = false;
 }
 
 static int cqspi_runtime_suspend(struct device *dev)
-- 
2.35.3


