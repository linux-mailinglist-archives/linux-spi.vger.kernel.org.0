Return-Path: <linux-spi+bounces-10897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D30C157AD
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF90567134
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE21340DA4;
	Tue, 28 Oct 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Va/oTuVs"
X-Original-To: linux-spi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EA341657;
	Tue, 28 Oct 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665249; cv=fail; b=XZwAU72s4/a0VDOeXSyb74famgBDgkyzgaEi5hJJS4lMGPJmz8Lepgtcu5+XH45c1QeT+Kqwh5TpAJUY1t2gvrRNcfeOvQj/wx8jpDLm9HCjLRGCor8SaVisDQTuXRBGqTPw0cst01PWmYIBSXLbntPJq65aNzbSbmO5ueI3Iso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665249; c=relaxed/simple;
	bh=IGJwx5jK6OrH2M+NWR/c/WMMpQtLjfOir2T4kGyAkIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAwBw2U0LVFszZyV65MvXpcXVIaEhvR4hO4sgAWP2X8MxJgCtmfx4rIXLkILcAkqpVPYOv4HAaal4b0Ch9nmatlPiEnR4I4e5s13saUr4N5IsUNWZtTBqLlpn4cVFqlLBDi8J5hZeTh7JOTyywI4Ep1QR2gwIBIKpkKWC/NwauA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Va/oTuVs; arc=fail smtp.client-ip=52.101.56.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krl8XrOZlWHxDqjOXS53fgIsjHEVSWrVJNPZB4T3lLWk9hxbCA0JA6eu7yS2PYDsjlgDQpcxZQj5/LQQlEUheaAJY02cS4oCJunyXTRWP8b+Ked9HIfbhXt7dkF6mNdr5d9u/c2uiIbDC/6+qVFZ5kJX4EB2QQCoees9caNJ+kwEAC7ULVw25WrpSwCu5UU3ezR0jtOBplVyzL1I5Lvkn+uFo0CtCrt96daW7AlE4kFp58SIvS3ydf0G+OK8DRJjjs0O+fY7Rl0I94ENAeuFBarG1veMCwxNsVB6pcLDbq1tZPG3m+g72zn4k4afrD0NRntgvo3SLHay+5Cufwt7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PPaXuQeMPiSW2gKTdCzfQGgDy+u0w8AYKgMifcnWNY=;
 b=tg9AtsMpfIO65cEmM1vgOcOSvy3xAQFS764nlv7PUb9tzwrTjlpc2AutTNi89P8IYuPhmlqa27UaAI5B+GlJW1tCnU67LkdhjDD30rwcZ+EhRajx4Jca1+0fIFuDnMr/4hHOkSKvdheRtdFadKdj5Fh7oAwdO5k9wApuMkxRLTfQl17RFb9CuWIsKJ7pFLqWpWXk5/yJDZuPpJ+U5HDAPdayFUIR7NkT40HNkBa9Ww5hpm49Y7yfYlD1GxGlJGq3rzznRJ01WTjIJnFMBKgym7DHetACyhy2jUKGlywIaUl9k5nos0B5puNoh+Yw52swTHcc6AQsv2aopK8/uu5lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PPaXuQeMPiSW2gKTdCzfQGgDy+u0w8AYKgMifcnWNY=;
 b=Va/oTuVs+hb19rHejUaubp3Lq8WR6ibZnLsddR68xb48mACzfxXJ6fdfrOrCPFTqlqbnIHuRgLrVxiFyQZht+WB4lknxAkfF2ZCzYn5gT4SOpm1zCOhxA8F5oebaOKTwZCiYQARf/ZbFqW80k3BSeK/cU9cm4zwqycBmDgbKCwGCCTftHjdCsEMSqg/WSaf4b+Syfy7UKJrqFs6kIvF5QBVcL1SNXcGDwNrQmw69UjWpaC5tQ2JN8WTlqrFW4C6clzdoIORRJeefH4X5fLC+54aq1bIInhL9SRJRWZm8rSZgTuIGXgToqgCrBGeG+QwkJwwz4OP8EFZ1xBgR/Gp3xw==
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:27:22 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::3f) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 15:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 28 Oct 2025 15:27:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:27:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 08:27:01 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 28 Oct 2025 08:26:57 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>
Subject: [PATCH v4 1/3] spi: tegra210-quad: Fix timeout handling
Date: Tue, 28 Oct 2025 15:25:15 +0000
Message-ID: <20251028152517.4144609-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028152517.4144609-1-va@nvidia.com>
References: <20251028152517.4144609-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: b63af579-79dc-4b79-1117-08de16367dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DEpFXB3fPKt9hUqrpOHKRo0+jV3VUusplGhJ3d9+fEQB1u1Y/MRgGKUTZwQb?=
 =?us-ascii?Q?nYiFv3H0EjzxQFqXy6y6I8Z9uTOWnEmRCqEtLiYEon7pugNbBLIKw4VLY7nm?=
 =?us-ascii?Q?n68inPYjOsyXflnPEFBG1pGi5ioIXIBS9qqff1ahug34N+fTdef+yF57B7tQ?=
 =?us-ascii?Q?JIAeP6HSlPYDzs+MDLipor0W40ZR/YjbHOeQSnke+6p97OO18N/2yYIxD2yo?=
 =?us-ascii?Q?EPIy8QsHgAfnoyjv4k5YMmQ8Qu8AgvA8U6U/6R1dy5W98qrDhf7NZAeXvV/c?=
 =?us-ascii?Q?AgFWsz2cngmNxqoMQGZ6ZAN5KR5ngz8HQT98X+MZ0SQcNULz4/nEvADGng1p?=
 =?us-ascii?Q?+Su3WFpk2ZyDWQlkqgM2p81ZMc5RndhT4F/y0qDNbIdBIBvLuN9k2MZWtj9b?=
 =?us-ascii?Q?xDOk4NxqMUdnHdPMsl5+p6b5bMrUwqZDr7QK2fBHWlmgo5LsVtoL9KpXcVPz?=
 =?us-ascii?Q?wZrXJiHJqiSPvohyWqWjkIC7oPOycU45rPyyIpWUkudSLD/DDUZuGFztP0cE?=
 =?us-ascii?Q?w9xnLOm0wqiRdf/NnavWxKh3KPfcB6Tqq7zxfO0QoleSiXGZ2tmf64g08b6Q?=
 =?us-ascii?Q?s+4AHPMZPrpahEPaCm1noehmvC6p2vUim1bxiwZT60LOE34E6qC5UAf5Pl0T?=
 =?us-ascii?Q?QJjjJSkJB4qnGRTWu04dcY6s7Cdb6d14o5YZjCtiVgD2ex896zPeMi5TDqYq?=
 =?us-ascii?Q?rW8PvqOvoBTXvHMbD3giK5/EcDtH3ZOUbORT54bhTDcSbCteOfbx2C6mRGKV?=
 =?us-ascii?Q?8xugLt0CpfttjAXleKnNJguF1kRh2AN3FG2Raz0EhV/BAWfZDgBHI4BpUqLh?=
 =?us-ascii?Q?bjXJmztqIX9B+NtFnAtIU2XSMylT4oAWUPdb9eQ6Ko/bMEHiLI6uB+PbgWhO?=
 =?us-ascii?Q?vDkwCmPxcJUz6YlLlYDBQGYdhNsNCyJDnN97OmA+bE03C8j6pqBiJyw6SGe/?=
 =?us-ascii?Q?f63zExeSEZnVqSdHeMhFGSMDrJdWp4bwXxjhu8b/i/kaQLuea+tGXGJfz2kz?=
 =?us-ascii?Q?1UeobnmRvwY7lMkD2gAi0zuG3Y1rnPgksRcdxrhE9UEi05viffsfD/WsmKaG?=
 =?us-ascii?Q?qnyAw1OQltts7ldS7AJygjMxHgrAJvr4T7SMTU0HPyqeYTj1ZcljkhtqP+L1?=
 =?us-ascii?Q?nMg5Jc5msPih3J21FUjnHiW0Odd4Y0GXH2msCKGsD0ROc8yqdFyjuIXTHBDy?=
 =?us-ascii?Q?Cvd8prCpVOHk4KLHSa7CkuvCi0deaM+yICFfWKNcYt+gKb7k/BOVD2xbQboX?=
 =?us-ascii?Q?CFreUBqQSEShY36Bm7vXX9kxQ9lZIemByeGgsoQYhR6Z+4MWBodCXBJon4R+?=
 =?us-ascii?Q?+l+HnLW0++HOuWfDv3Lye/l2r0UfVAC6PnwnaeiCIOeS1wGFASSmUdn+Yqnw?=
 =?us-ascii?Q?EWeGoN5WJLYTKYr+tSl3dHgh6hcrm27P8OisaaTirYHnpPLazLQ0/ot2f0mK?=
 =?us-ascii?Q?dCGlsTp+bagbQeMjqZPSf9uoSDH/4Xt0koG+Fa6q3kgbFtn3V7USGMJCiwYc?=
 =?us-ascii?Q?EKQugMa1SE3Yv4Kij+VzDB7LN79LabxJPnIxefipqvdbNX3y7UlJjjZOt/Zn?=
 =?us-ascii?Q?WBMHohLxnlZWJ7POkX4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:27:22.8140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63af579-79dc-4b79-1117-08de16367dd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
is excessively busy, it can lead to rare cases of the IRQ thread not
running before the transfer timeout is reached.

While handling the timeouts, any pending transfers are cleaned up and
the message that they correspond to is marked as failed, which leaves
the curr_xfer field pointing at stale memory.

To avoid this, clear curr_xfer to NULL upon timeout and check for this
condition when the IRQ thread is finally run.

While at it, also make sure to clear interrupts on failure so that new
interrupts can be run.

A better, more involved, fix would move the interrupt clearing into a
hard IRQ handler. Ideally we would also want to signal that the IRQ
thread no longer needs to be run after the timeout is hit to avoid the
extra check for a valid transfer.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..d9ca3d7b082f 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
+		tegra_qspi_mask_clear_irq(tqspi);
+	}
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1176,9 +1178,11 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				}
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
+				if (device_reset(tqspi->dev) < 0) {
 					dev_warn_once(tqspi->dev,
 						      "device reset failed\n");
+					tegra_qspi_mask_clear_irq(tqspi);
+				}
 				ret = -EIO;
 				goto exit;
 			}
@@ -1200,11 +1204,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
 		}
+		tqspi->curr_xfer = NULL;
 		transfer_phase++;
 	}
 	ret = 0;
 
 exit:
+	tqspi->curr_xfer = NULL;
 	msg->status = ret;
 
 	return ret;
@@ -1290,6 +1296,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
+		tqspi->curr_xfer = NULL;
+
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
@@ -1395,6 +1403,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 	tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	tegra_qspi_start_cpu_based_transfer(tqspi, t);
 exit:
+	tqspi->curr_xfer = NULL;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -1480,6 +1489,15 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 
+	/*
+	 * Occasionally the IRQ thread takes a long time to wake up (usually
+	 * when the CPU that it's running on is excessively busy) and we have
+	 * already reached the timeout before and cleaned up the timed out
+	 * transfer. Avoid any processing in that case and bail out early.
+	 */
+	if (!tqspi->curr_xfer)
+		return IRQ_NONE;
+
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 
 	if (tqspi->cur_direction & DATA_DIR_TX)
-- 
2.17.1



