Return-Path: <linux-spi+bounces-10893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F1C155E9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5844D18849A4
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08CA33EAED;
	Tue, 28 Oct 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0jM8TcZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D933CE83;
	Tue, 28 Oct 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664575; cv=fail; b=HYiUbuMiuFJslPg3nUT56xLi+4dhC2v10cHlms8c+fuqakrtad9PKDT3LMxt8tYzbHCtr0YPYkN6MGXFn9+xwrDxml3dqGpJp/ksbf/ElkpMEbJxBJ8eiaekegvNxcfYWjA3LsHlsPcjyhZk0BK+AqN3QWoveW8ZR7W3G90aEfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664575; c=relaxed/simple;
	bh=IBIO8yEy62rUlSG9dz02H6fpEq/xZDe2/qQvy82ioFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc0XpvBKtVXV722Tz9acw5U0K0GkuR3q6yEXy2WkjS2UuM48Qjcn06Xu6fmmRJDd/ipQV3lcErjj5eSiNQJRV5TCooeOyxb4wyPCloTL/iTzaDCbDr2zILfgCqYogCfKYnQph9/XYFq3McfC/xGZTPm71cp3OHdlaYz0c6Po2rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0jM8TcZ; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA30a+11GfyKmdF0S0TT+DLCbM0GWjt8nvMxkgYc73XDTnb8Obr8TN2q+R+e3wr40awLPtwMOBJZbMO8FZdbERtbA9TMUTX6+8LgPI9W3Ejp5uQr74mG3o2sDzwaw+z05HD4rpk1BT3KxeeOMGSX7+TtUlqD8WlnazyvDJzg3bW5m9EJamxcERPNEfNb2xINidpUw+qV+xcEl8ALU0zBwAoaPn9M1n8bSzMUoiyC/GKyEYu/KnS1aHr8tGhPWMKLA9GnDBtqurpj6KixnTYjFgwqv8G4b8QgRDJbhcGyrIOeJlf0zD5+9t8QPykqy+CE2qpKFXj8d1GBS/d3sRwYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUuC40FQnfta7YVWZWE8h/kG9PWNCyaSAIVSikdGkVI=;
 b=TAwblwGVjPLyfLlT5BB0SMac4t98QkF8dz+5R/6dOrD+oTThm0zIZQ+mRfh/249jZSBwpgo2qdAau+4WC38+GzHLT24TKTci5wCMNNC6RF/etFnQaCKMFsLp5+0ZjY7bmSddIeehIaZqQaYTHTL/fc5WNsyx4+oezueR3l/U2DKOXXXv8eumvxsWaw/y2i4wRUcRBlg6vfsSyzj+I9zicqjlm35xUf7diNT7jW3MNGJZALdLuMcNcjcTWqXXJzBdFWbZBicjAuKe4gxZIr2+bp2qALiiW+1PzTw5yrO1PZ+Ei+NiIQBbktpCH91+qL2Y7CuRaf3azoZoYkPReyixkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUuC40FQnfta7YVWZWE8h/kG9PWNCyaSAIVSikdGkVI=;
 b=R0jM8TcZ5bmwmTTnQlMMJg4gNIp/HNXN0GW7bbnQDktSEO3WVJKLaESm9x9RvUfbI7b6ByHrxLizYvrMCDLDwoONP3ttc9rBh9bon1kj6X1w9bw5/uvpZv6ptpkdS/ZzkhSj+72L7ZyAFvyac2Q2KqIInzOYMDqr+TyGI+ciy9h7SsFOC7DLhu8xYIZkaO2054eus+Jc7rQq7EolzZljzRvE6te7+4Fhe6wqMjILL5+2AwaL+gM5jaAhkuLNLzSqMXqp1JQFn8eSiwGuAwJxAa1EIta2ebJ0m3YXuS7tstZoVI6VuqQ48b6KxEKFNis3jUSCCdb93Vn8RE9LW3wl8g==
Received: from PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::35)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:16:07 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:327:cafe::33) by PH7P220CA0135.outlook.office365.com
 (2603:10b6:510:327::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Tue,
 28 Oct 2025 15:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 15:16:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:15:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:15:41 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:15:37 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] spi: tegra210-quad: Check hardware status on timeout
Date: Tue, 28 Oct 2025 15:15:15 +0000
Message-ID: <20251028151515.4142618-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028151515.4142618-1-va@nvidia.com>
References: <20251028151515.4142618-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f421e7-88b0-4a94-2667-08de1634eb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MzSyUWWJyylCNLCBaE0shiNBLqS35N0qI1J2ZNCqZbwh+lH1gRuTAG+awWom?=
 =?us-ascii?Q?FBU6jDNm1cm42bkUH/6Ejn2I+EGuQ2/IFkr3RX7KO/Rn2aWgeTW2F2A1OoIp?=
 =?us-ascii?Q?3GgS0j33a/ABDKJ9//nRmsLqOFBu54vgZ/oWRqU68WUTuiMbqq+zdFa+hnIb?=
 =?us-ascii?Q?us32aPx2v1GvKJxsdvWLh6EhfVTYtodUsCA6uFXCO7YofFo2LENABaam0cro?=
 =?us-ascii?Q?7xxz7tEZnWJ3EUcF0lPXOt87K8EPvpjUHnJwr2bqnSQl3LT/fqEvYf6n7oCM?=
 =?us-ascii?Q?hIl3l1OMeO5ZjxSDUB/z0VBT6GchoMMeCiGRrQ7xkA39FKiAhS64Sq/D6r4H?=
 =?us-ascii?Q?rzI2xmzgPnNL7WlOcLD/ZJ19o0thduRh/oQnrc7xk4zEN50zg4/ygpEXaDeu?=
 =?us-ascii?Q?++nUJeYZ/epDqV7WCpnk6oJvCPbXrSvPDsB1+hK2+jKa3nl3rVqzLzAC4jgw?=
 =?us-ascii?Q?XOFxyiPQAD8bUfCOXmI0YVUec7/hXFdUNdGNvrhNq5mwmwNTL8DJqcMhPDkb?=
 =?us-ascii?Q?8SpsLaGoCYaWthYk1IwqUAa5py6NZAaChfKLE12Q+AixnZinPirQ6IxVlB/c?=
 =?us-ascii?Q?GvB1caqQJwPz3jAXsUzOd5bCZGCXmKIdHLflWQBFeW68UxT4zPnspFw3GB/p?=
 =?us-ascii?Q?fu16AEv8KnxeoqR1K/Vjez9geHv2vLeJQBZV1jCW2dyY1dsUCMPorlkeTwpX?=
 =?us-ascii?Q?02u6Fz6jP9MOKlr/ML0+LFIadqc+VFOUxbZhoq8MzsF8xadpQjWJwvo7bkth?=
 =?us-ascii?Q?VlTUG9ZJv1VYolSeIFwuiitPgsY0MhF4fmjc9eEizwAUAhzlF7VImIJYP1zj?=
 =?us-ascii?Q?PKLM7ulLBCEX7i/l5uSIPZJxk1NSnPFZkUohNi1unIY58164aRVcJaHqYM6M?=
 =?us-ascii?Q?zXdt0qUaLUf0RyhksgJ5SLsFV4bt1vY4ZyTlv790EdKEDKshUEHpbnp7aurf?=
 =?us-ascii?Q?YihGlZqAIv/niPOrPA2Z0WwKmW7dfu3XieRLsrSFT3IV9Jo4M+ckWlU6E81a?=
 =?us-ascii?Q?7bBYiajUGQm4V7HGEU4ZLje6K3H/VMs/HYnQGu6KMG/vErcvdyDewVPDHorD?=
 =?us-ascii?Q?DeVifearnwa9i1Oum9K2NJTIvN0xSGB9XOrLYA43GDIN0ZWIJ7Eq7K77lCh6?=
 =?us-ascii?Q?jSmrfpiKRmS+ntO04yEXQjLuLNXOnPhJXoSkl70UaK5HZDBDqgdgHkZVMJo6?=
 =?us-ascii?Q?i1E4t3bKMHSjtfDYpR2gpXkZ5IbiL83ub74QLB1SZ0X/oK/UvbXT1ta715nX?=
 =?us-ascii?Q?oRQ7eBNfwa12WldqZBliGFpZ4vwrIOep6l/6azAa1KbaDFYHrR0EnroJATe5?=
 =?us-ascii?Q?vn/5k95ARNxqw0z3uczehLRmDtDFmA7xeCLgeGxQwNPUyjFQdrLwfC8mFGGr?=
 =?us-ascii?Q?F9tDF7YonkPDiy97E2ckJRcwuUZr3PFh0xHyfey2vf7dJzYdrqGDUT/lFzYi?=
 =?us-ascii?Q?/uSGuIceKpzdX+o/uBGFsbIB/OXHF+exgcaJ2Ws5yxk9p2VpKQr/8wH6QC8v?=
 =?us-ascii?Q?KM3PhHXKJGT4bB/5w5aCmGRKpGbDNKQVoRoLbBsH9HdlnJmHIVXewChekYPW?=
 =?us-ascii?Q?Qi3xSHqZKxBPjij061o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:16:07.4615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f421e7-88b0-4a94-2667-08de1634eb5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

Under high system load, QSPI interrupts can be delayed or blocked on the
target CPU, causing wait_for_completion_timeout() to report failure even
though the hardware successfully completed the transfer.

When a timeout occurs, check the QSPI_RDY bit in QSPI_TRANS_STATUS to
determine if the hardware actually completed the transfer. If so, manually
invoke the completion handler to process the transfer successfully instead
of failing it.

This distinguishes lost/delayed interrupts from real hardware timeouts,
preventing unnecessary failures of transfers that completed successfully.

Change-Id: I5431bf3c13cbf0d32462dd4c0d8e252572939bca
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 100 +++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 69defb4ffe49..cdc3cb7c01f9 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1048,6 +1048,49 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
 }
 
+static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi);
+static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
+
+/**
+ * tegra_qspi_handle_timeout - Handle transfer timeout with hardware check
+ * @tqspi: QSPI controller instance
+ *
+ * When a timeout occurs but hardware has completed the transfer (interrupt
+ * was lost or delayed), manually trigger transfer completion processing.
+ * This avoids failing transfers that actually succeeded.
+ *
+ * Returns: 0 if transfer was completed, -ETIMEDOUT if real timeout
+ */
+static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
+{
+	irqreturn_t ret;
+	u32 status;
+
+	/* Check if hardware actually completed the transfer */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	if (!(status & QSPI_RDY))
+		return -ETIMEDOUT;
+
+	/*
+	 * Hardware completed but interrupt was lost/delayed. Manually
+	 * process the completion by calling the appropriate handler.
+	 */
+	dev_warn_ratelimited(tqspi->dev,
+			     "QSPI interrupt timeout, but transfer complete\n");
+
+	/* Clear the transfer status */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
+
+	/* Manually trigger completion handler */
+	if (!tqspi->is_curr_dma_xfer)
+		ret = handle_cpu_based_xfer(tqspi);
+	else
+		ret = handle_dma_based_xfer(tqspi);
+
+	return (ret == IRQ_HANDLED) ? 0 : -EIO;
+}
+
 static u32 tegra_qspi_cmd_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 cmd_config = 0;
@@ -1177,20 +1220,28 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					QSPI_DMA_TIMEOUT);
 
 			if (WARN_ON_ONCE(ret == 0)) {
-				dev_err_ratelimited(tqspi->dev,
-						    "QSPI Transfer failed with timeout\n");
-
-				/* Abort transfer by resetting pio/dma bit */
-				if (tqspi->is_curr_dma_xfer)
-					tegra_qspi_dma_stop(tqspi);
-				else
-					tegra_qspi_pio_stop(tqspi);
-
-				/* Reset controller if timeout happens */
-				tegra_qspi_reset(tqspi);
-
-				ret = -EIO;
-				goto exit;
+				/*
+				 * Check if hardware completed the transfer
+				 * even though interrupt was lost or delayed.
+				 * If so, process the completion and continue.
+				 */
+				ret = tegra_qspi_handle_timeout(tqspi);
+				if (ret < 0) {
+					/* Real timeout - clean up and fail */
+					dev_err(tqspi->dev, "transfer timeout\n");
+
+					/* Abort transfer by resetting pio/dma bit */
+					if (tqspi->is_curr_dma_xfer)
+						tegra_qspi_dma_stop(tqspi);
+					else
+						tegra_qspi_pio_stop(tqspi);
+
+					/* Reset controller if timeout happens */
+					tegra_qspi_reset(tqspi);
+
+					ret = -EIO;
+					goto exit;
+				}
 			}
 
 			if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1281,14 +1332,23 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			dev_err(tqspi->dev, "transfer timeout\n");
+			/*
+			 * Check if hardware completed the transfer even though
+			 * interrupt was lost or delayed. If so, process the
+			 * completion and continue.
+			 */
+			ret = tegra_qspi_handle_timeout(tqspi);
+			if (ret < 0) {
+				/* Real timeout - clean up and fail */
+				dev_err(tqspi->dev, "transfer timeout\n");
 
-			if (tqspi->is_curr_dma_xfer)
-				tegra_qspi_dma_stop(tqspi);
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
 
-			tegra_qspi_handle_error(tqspi);
-			ret = -EIO;
-			goto complete_xfer;
+				tegra_qspi_handle_error(tqspi);
+				ret = -EIO;
+				goto complete_xfer;
+			}
 		}
 
 		if (tqspi->tx_status ||  tqspi->rx_status) {
-- 
2.17.1


