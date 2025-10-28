Return-Path: <linux-spi+bounces-10906-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67129C15A85
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876583B9690
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E33451D9;
	Tue, 28 Oct 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEu5Ksnc"
X-Original-To: linux-spi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229443451CD;
	Tue, 28 Oct 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667076; cv=fail; b=VLc+83zBvuGWxTuryuKnJNMykzEFRVx+QF7D612DTzaCxWgp8rsUmXV5pMsJ5+5C6FSCc+S54RlZ9CVMHaF+emrW7SEs4yWe2kIQfnijqSlHbdwiInbltmT78m94IEptbZAc1MkbPRU3sV29RevKoB2ruWILjSZdCIkakhaJkH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667076; c=relaxed/simple;
	bh=whIfqwR3n5bzGGxprJSjfBGxAnkw8946MW3SCf6r6sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmdn5IrEy//53L8TYk5LnoeWT30dX5inGnaHYOgvFVS2l4OGTNqkCYRP2N8uaHzuF85lHuFWDmiwhJbDmlOJ7OTX+QzlbWXWZ9z0rXdh6NMUFamyrs0gbXcqihpsOl3xWJ8v12ISGfjFkXOfIZSS7aYS39w31+4oGGK2mwschnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEu5Ksnc; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3CInKhX8lpKOHFb7P8cK0Y5KoEbLkoLlQDT6eAKbYYpDqga3LvEGbEaZWwyrcNjZMdgTThA4UUaNAiBoKkv1PttWGD8lG0wpjuceJxY2RvMByA5IXFXdWJJlsrn3KWEXLf8gMqLGpPmbuuDOIlRJZtZ9pmuCWXCH6V2jPmzJ9YCienmBPgjV4xUnbZYSdlURgNV4+oVmW0hsGu9uUCbwK2uK+N4wRXSrM84XAO2LsdfSjO6K74Ehkiijcg8fyTCCjU+LFwfId9iN8oMLygVOkgfb+F/fXX0VZJ7iBB+/07nr4e/qmWXO/67ZVbOfjBQDIf5ccl9C/MOMNRWF4N1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tCjSBuUryYOM8imQmAcR08yeziUoZvmzheD+np5jb8=;
 b=kQtQDsjr56QnjqiAb0kAe9NTdPWaRjqTfHNNo5Tev1EcVIhEP3Yvd3oi8KGXaVABH8XkLutWRIgjkykJi/710Tsa0jy0s+nNxazHki4o4oIOWKRkVGBndZOEAZzTYaW6Co4xsY61MdbS7qBwCmvfUCcg7ylK16ju3Fxi7VFOONx00XK6J1N7eD7KKAZ9WM3UR0r3wKWZlR/E1dFzgGmv/mrodlBBAdK2XYhpH8xJOCBFgDZdRcIocc8yGo1qENa1EzoyL1pCwTpgF0uZGc4Fyjd4PgFX162Arg5gacbM77J0fApskNblXRTewmuK49GIeuZkmsoDhOfrq12C6ArgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tCjSBuUryYOM8imQmAcR08yeziUoZvmzheD+np5jb8=;
 b=kEu5KsncLk8ulpFnUd61IaQcM27A3vKI31iVvj4uDSBaeUUsE9kGz3YKu5eCb7Zp0erOZBcvdHvrCFH59mfmu4J5MbNHGOzdbByMv12YEGucdrb9JPunwpl4lbeYYUnLV/2A/G3UGIt7Kq9UtKLdHQnZG0KJb0lL9l+CdWp3xsYtyOg+vJzrOFEnxtx7Ipt3ncoXng+D8TWNBmlpRIXZqg/rLJFtv3VxUnRhZ3wofrPnO/ZDMtv4GZVkk8hpmpe/lb6D1pO2t+rP9+sJ2IjtPdsfNbyaUD9Veb5u4ooSS6mpn6TNWSYad1ylPWnVIHbNI3GAVxkwz7zTCPFWzIroqw==
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:57:49 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::c3) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 15:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 15:57:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 08:57:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:57:28 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:57:24 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/3] spi: tegra210-quad: Check hardware status on timeout
Date: Tue, 28 Oct 2025 15:57:03 +0000
Message-ID: <20251028155703.4151791-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028155703.4151791-1-va@nvidia.com>
References: <20251028155703.4151791-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e6e66e-a37a-4653-1ac2-08de163abe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gNcdp7W7FO9CCMK0L7Xidi2pS0jbrawBNyXG5McSbAfzg2xO/mzjwZSHcWsf?=
 =?us-ascii?Q?tgISxPMfr70bu+zl9IzXbYpV06kQ9HklDWX0lNPjlUlCbcGe6ewiVTykG7Je?=
 =?us-ascii?Q?HFF7CKInZXATB3N19SW06BBya9UF8HVmt0GV7TprojECLWJbQ2EM+Z067eap?=
 =?us-ascii?Q?wPTLkWkw6bGND8cqB5kBwxwrWAl/tLQOIcVpi2eRjd/F8hYoNrWS/I18wq/r?=
 =?us-ascii?Q?3wfpWollpriuB5LPoDKNSvj1jYNvxJt2yUbEkbB2AHSEDEit0fZV635qb3lT?=
 =?us-ascii?Q?MwJ8JibRhqD3K15Og5yCNElZklyXiPzP+6mVJYMw4k1fFj2vzgobVhzqrp/X?=
 =?us-ascii?Q?a8nqsRnsFGAlil4DXkyDEV/Tui+vY0prxb7seKioNol1Wp2wNu2yxRzl+9B4?=
 =?us-ascii?Q?jhrzOLTjuIDRjejgll6atnbbwowezVkWGH0LN/RiN2jAgKTofuDfVAdt8LDs?=
 =?us-ascii?Q?w+3QS+C1rEUQUh966ZWzgwKrd6RRXPyYDIvUzH4nS1xeiPhrF+tZf0s8LLRa?=
 =?us-ascii?Q?5Zb/ACFCmQ51edyfl7XJvGS24GtysvA/j+OYrAx2YnvhdiQhvtBBggFnIN2U?=
 =?us-ascii?Q?vavuiuDaP+um3lNc5yGBzxbNuHIu5eHLnFHKGbPeU9RRI+zyrBGfX+3l98ff?=
 =?us-ascii?Q?1Wl1mbJ4Up0Dlt8EFpYFnus49j50hWHlc+Eo4aigC5bhjTn+QgWcBkTQzCKw?=
 =?us-ascii?Q?oPeLNb0YeVMduTCdzu41bxAqr0urvI5HJwlDrc7td9mwDOYjNaSJMTV7Ggs8?=
 =?us-ascii?Q?IO6QLdNH1Z2jMWB56uInPlXe/AgqPPcP2hrsys82z7F+V56AWUN4QqriWkTg?=
 =?us-ascii?Q?JONDo0zd6i0Wq9RErPG2FgoZL+Slrjlgt2RecU1N+WiCEw4UKN0HdLdioK9+?=
 =?us-ascii?Q?IUu0uJ0gOwhz6G9muUnE/8yeN8HtdM6lFr8gp4YuVIIw5BEPImmoXCnS0j0H?=
 =?us-ascii?Q?mco7lg3WbU6efCcKlEsSiZKdY4kve/I9Z8cARE+YRKxqOtEQHIL7nzHAwcSp?=
 =?us-ascii?Q?TKCUsH05wVP3+8h6mLHE70DXhx3UVHA4pX1SY/yMBGopwu+eIgZoWYo5V+9+?=
 =?us-ascii?Q?FyWqDsF41phof8iMtjA7ijVOst9ZFYV/0a4Cvh2c0mjVBhk5FJ1qYYQRk1dF?=
 =?us-ascii?Q?og21Y9hDrDTOEOeRXwxmUcoUL6JXuIRvRtFmU4WGwpNuif4q1TwzJdILgMQx?=
 =?us-ascii?Q?TDpTbAVvdPd68BVzImBvKrBNWvp9ARlM5T2PBNGddxp+E0Jv4xrOoYM3og9O?=
 =?us-ascii?Q?G9Jb2IOpD/zGlQVRbWbkYRRebSTh7JrNnsXKKqgVIf64RuPE8060dNR7HeBT?=
 =?us-ascii?Q?agQ2IRJ+bHbkX1KwqA2Xw1TcEackRej0sGqqilYALvrRrAu85+x8Oh3AQcM4?=
 =?us-ascii?Q?0gTt5LpG/AoNv/+SNSK6Mzui3vFwnLyk8r9V1jlMa+UqlY7K+oq4E7qbFO2j?=
 =?us-ascii?Q?3fJdXWp4ktzILUf+kOuT7w3UyXGv1Cl8mue1FQsfMA7CFkvVqfCMg3Hg2H2K?=
 =?us-ascii?Q?APHNEnu5nsyRirKyIp7N8VRH4JeBENv2/yiF2AbzssZEQqy9gVtDpFDUKREE?=
 =?us-ascii?Q?YukokPQuBL18RbsgY/w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:57:49.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6e66e-a37a-4653-1ac2-08de163abe9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

Under high system load, QSPI interrupts can be delayed or blocked on the
target CPU, causing wait_for_completion_timeout() to report failure even
though the hardware successfully completed the transfer.

When a timeout occurs, check the QSPI_RDY bit in QSPI_TRANS_STATUS to
determine if the hardware actually completed the transfer. If so, manually
invoke the completion handler to process the transfer successfully instead
of failing it.

This distinguishes lost/delayed interrupts from real hardware timeouts,
preventing unnecessary failures of transfers that completed successfully.

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


