Return-Path: <linux-spi+bounces-10527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6006BCDC6A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1D01A668AF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFB12F9D86;
	Fri, 10 Oct 2025 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NEeXtDjV"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67B2F999F;
	Fri, 10 Oct 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109644; cv=fail; b=pSGYdwh02n56RS5TrCyhA4AhLzaH/8lnDknbuvY6EtP3u5ZeLKvmr/TSp3b80dTfzByvMa9e+4qjEKzjo3JTKYVFHSNv5MQurmB7mecipQV2ytVnk9UupOBAWgmA9urKKWxrxiwC55heLmZ1lY9mZnxpJwCamx2sjw6bvBCFUpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109644; c=relaxed/simple;
	bh=mW8+e9k9I+ifDGa2bQ2nEMZrDe9C369vPqFatgACaVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSQfHa13TGQj5EVeAHJEfbF1Au+MI1BR+2Nn2j92OUu0tZEfzIhC2zXKmjBhYjl+r98et24H9/2heNa5PhNs+RrmQIWu4fhSqGYf0ZaAW1UUqdTcuzLFYvB6oiM4N/2ORcEsgioTD5OvwxdBxHmgbH2Xz4ReQQn7M9iPLJAHMi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NEeXtDjV; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9wCIVj7uEB4WT8OG5N7ZJ94lWoAbg04qEZ+/XMhZse0RAnoD//uWwUw5X/ETgGsNxnXhhHSEnUzog6HG74zAULjgY0Z6uosb1JT5F66jL/4mDlp6ucoWtBeznqiZA/oRzjdpob31rZONrzBgAQrwMDrEX0vEZYBGUHCb8ebY13aR2ibX/BTtTJ/ShNMIlN9P73AgWGwKWZ4SwVasE3dwVgbI2AzcfLooQ8obSDHlOtpCbWijYC6r4lGc0Sf00gelgUqJsf3rdo7Df794D2z6NI9oub+x1/wFEpxoA7jw3LXeByvvRaq00ILvEBk0DTiTnuQ/LNGFD6v6gc/NPengQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8Amco04sq+FJ3wpgWneGIykLDBgPATxS+tNaSBTXL8=;
 b=ZXIuDND4uUQ8WGCDbhainMrcJcXtBKqKQn1+BY53NlNNsqwoomfDjcmmaOXtWavzQEp431h+An3+AjfuGv9Ez0exUFNTvSH20ljzOuaatCaVV9Pbqd3T3qMSktrap+TZb9UhdzyBiqpG9H1xbFIP/IuVuAlnc67+EeIzWFgLvQ7QgAV5xh4wtqAkBmg+guzkAMjE7Gln2gt7WLPpeDu+4q6mzRsPCx2hCPDO7hWlPMGGA5S62jrEE2R/k02Srmg03H52NU6osP53APXT3sEZT2+Rwh/HfKD8n1pa03TW8S45U0ioqT6KUtpTAwCsFJ3NmFh1KBVeg5f5KkUXzBdSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8Amco04sq+FJ3wpgWneGIykLDBgPATxS+tNaSBTXL8=;
 b=NEeXtDjV70W2cTjxtUFhq6FySYiDraEHv8T09qdX8pTKPq5JJloMdruy5i+Z3H65U8ojqCT1vju82d/1Dtvuyz8upmJkeuoKPp9p6Iuz30V/ZIp3pXu0Olldfz2/5bYp8yFMlCAJNrC/7yK1Zq5J+COpE1txqOtnQcxnbolBACT9jgZ4uon6Ws1Af6EdnfBGX9G7Kood6nr4qZHzl8laxXZm5eThTjet54n20Eg2RiZWCKsBq8G9D2SuU2F1R7SMyUGTSctp3ayVJDci+bfnYsLtzk3BFDe39RExf2i5W4sBwWOWv4pxs/IEKMZYu6J1ocyEEHI4CX0cmrFdlddSsA==
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:20:35 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::96) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Fri,
 10 Oct 2025 15:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Fri, 10 Oct 2025 15:20:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 10 Oct
 2025 08:20:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 08:20:21 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 08:20:18 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] spi: tegra210-quad: Check hardware status on timeout
Date: Fri, 10 Oct 2025 15:20:01 +0000
Message-ID: <20251010152001.2399799-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251010152001.2399799-1-va@nvidia.com>
References: <20251010152001.2399799-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a12abe-17a5-4776-fd98-08de08108f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ByZymhZuDYF4J0VreXiIZWsX57CnKKyIpaqk82kOvAnlOstHHgUI9OBuCGOv?=
 =?us-ascii?Q?GKAsdu1/TfTTkdX6hyKgEwCwXFXdh89duPbfRkzh/Vi5p0MfT1gNqT6KZvUn?=
 =?us-ascii?Q?/JpxmxAYuPg/o6Zac3bc37PqU54LjB2iNL/7bRqm8tt0WrFj+GA113Oi3RVo?=
 =?us-ascii?Q?6J4Pg96lWkkeJqy/OcZgfyPY/hIhwgmzCmOyPYN6Bq0SE/WzbhAOmQF2Du+C?=
 =?us-ascii?Q?4Y7jqgfBEpbNqq3lgppkl6GVhDN1gIiek9d8Bvmg/fOxXT1B4mHBNhS90pC/?=
 =?us-ascii?Q?umHAd8T7A7+1eCp0fh8aIWJVOgxUWZAyl+fn3OwqdXxICCXqXBLLWsGc5uFF?=
 =?us-ascii?Q?PWMBTN6LfKoHZvemyfEBRxO2gQaUXqDsHYiTu0DO8qqZ7IrGF1DZUgm7VQQR?=
 =?us-ascii?Q?/rNXOjUwY9KzzWTw71FKaPO9xg21HA2y+2eos8JPg8Vr+0tgtHPPJEEmyFxR?=
 =?us-ascii?Q?QouOrHxXng/Usqc1OYrp+2ccvsNVN3YKBKgebZfTzLFSYT3S9QNMFIOKTok7?=
 =?us-ascii?Q?mbF82Dhl3VziiQ6VYExurlDUN6retYJ+W5SbAMei/ljYI8ujy0CvPCBOL50k?=
 =?us-ascii?Q?EupBcVJcJvMaCEiyZw5A+tHbs7XNVuYvg8nw5JbXNnQ4HOG9pXCMJ3UV3PxW?=
 =?us-ascii?Q?sKbMLwCddshfN448r1shE9uF7OT9WNhCvOCpIFHnkrJAPwC99H4SoE9j7FI9?=
 =?us-ascii?Q?yNUWmj4h6qkySc2x+vJ98ndk0IalxfRB5e25pMkjkDcyURR0rtjjsh0iA5tm?=
 =?us-ascii?Q?ZypCmh3xBLzrJ3xujO0ZOdPQJxZFTivMesc2mgYNRHO6hvJMAO9bUuFhElYf?=
 =?us-ascii?Q?z4XPsyBaCVACpbl9ltBSm4ZJVL8ILxgyJxkHu3aMM/zU2ROF1WHSag83QWDn?=
 =?us-ascii?Q?w+Eq0Vr4NYv6Brr7B2dcQrQ6pSTPk1aZ+cr22oK5BQrSOmE1a9FTLRXPVSq8?=
 =?us-ascii?Q?Ln0/PTuChGJ/J5zr+pSGNRKmAlTYa1K52O1Q5fUXYsq91PyoS4452n6s7B/u?=
 =?us-ascii?Q?uobThYTAfxnmKVNH6zjy3NL26kWtIDZMpVyVgqEAPtPw10gJfJwQtWxMZq5j?=
 =?us-ascii?Q?zrK6P4vANI7kMRp32gHaWtmjkOcC06cdd29buAv92e+QdOFVvN5xIp6rJyVa?=
 =?us-ascii?Q?n/c9af4W10QCkW49/Ret5S9VhMt8p/gVVznGjwmQ+N3+F+zCHuTy1nYoUKcJ?=
 =?us-ascii?Q?LKdS1qwzWk08lmDo51ZVbPpxIxqi3QUkOpjMAd0xrbqM/7hsD5jcUMwNeHIM?=
 =?us-ascii?Q?3Jy73SQqXYdLeCeXTjGfymiRlYf26DrKJRCM80TGy6xJEGh1LufKbdhQWDCW?=
 =?us-ascii?Q?inUuN3KsoFIsMVaTkdnWhVJdEBVOlqac+KYPvoEcpLYZ/+j8nI56MM0t2uIQ?=
 =?us-ascii?Q?0zUSDHRfWx23usXTP5MKtHLRJbjy6b3fm0j6j2r3VkMRZSqLU3hj84lHrn6p?=
 =?us-ascii?Q?esfsg/Q74/ctlRVgg1CU45BugW34+BmK+nT72ZkJeOGMR/WOmqKJOGD181vD?=
 =?us-ascii?Q?hJ+/jzdMMiAnoAXEn7qEty7hMbKfKB86zSPdNe/x9BAvUUQu4yNE64BhYktU?=
 =?us-ascii?Q?7ylSASoPq/4T+DnQTVM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:20:35.1620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a12abe-17a5-4776-fd98-08de08108f85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

Under high system load, QSPI interrupts can be delayed or blocked on the
target CPU, causing wait_for_completion_timeout() to report failure even
though the hardware successfully completed the transfer. This has been
observed in production during error injection, RAS firmware activity, and
CPU saturation scenarios.

When a timeout occurs, check the QSPI_RDY bit in QSPI_TRANS_STATUS to
determine if the hardware actually completed the transfer. If so, manually
invoke the completion handler to process the transfer successfully instead
of failing it.

This distinguishes lost/delayed interrupts from real hardware timeouts,
preventing unnecessary failures of transfers that completed successfully.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 164 ++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index c2f880d08109..757e9fe23e0e 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1019,17 +1019,22 @@ static void tegra_qspi_dump_regs(struct tegra_qspi *tqspi)
 		tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS));
 }
 
-static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
+static void tegra_qspi_reset(struct tegra_qspi *tqspi)
 {
-	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
-	tegra_qspi_dump_regs(tqspi);
-	tegra_qspi_flush_fifos(tqspi, true);
 	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
 		tegra_qspi_mask_clear_irq(tqspi);
 	}
 }
 
+static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
+{
+	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
+	tegra_qspi_dump_regs(tqspi);
+	tegra_qspi_flush_fifos(tqspi, true);
+	tegra_qspi_reset(tqspi);
+}
+
 static void tegra_qspi_transfer_end(struct spi_device *spi)
 {
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
@@ -1043,6 +1048,49 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
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
@@ -1074,6 +1122,30 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 	return addr_config;
 }
 
+static void tegra_qspi_dma_stop(struct tegra_qspi *tqspi)
+{
+	u32 value;
+
+	if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
+		dmaengine_terminate_all(tqspi->tx_dma_chan);
+
+	if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
+		dmaengine_terminate_all(tqspi->rx_dma_chan);
+
+	value = tegra_qspi_readl(tqspi, QSPI_DMA_CTL);
+	value &= ~QSPI_DMA_EN;
+	tegra_qspi_writel(tqspi, value, QSPI_DMA_CTL);
+}
+
+static void tegra_qspi_pio_stop(struct tegra_qspi *tqspi)
+{
+	u32 value;
+
+	value = tegra_qspi_readl(tqspi, QSPI_COMMAND1);
+	value &= ~QSPI_PIO;
+	tegra_qspi_writel(tqspi, value, QSPI_COMMAND1);
+}
+
 static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					struct spi_message *msg)
 {
@@ -1081,7 +1153,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
-	u32 cmd1 = 0, dma_ctl = 0;
+	u32 cmd1 = 0;
 	int ret = 0;
 	u32 address_value = 0;
 	u32 cmd_config = 0, addr_config = 0;
@@ -1148,43 +1220,28 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					QSPI_DMA_TIMEOUT);
 
 			if (WARN_ON_ONCE(ret == 0)) {
-				dev_err_ratelimited(tqspi->dev,
-						    "QSPI Transfer failed with timeout\n");
-				if (tqspi->is_curr_dma_xfer) {
-					if ((tqspi->cur_direction & DATA_DIR_TX) &&
-					    tqspi->tx_dma_chan)
-						dmaengine_terminate_all(tqspi->tx_dma_chan);
-					if ((tqspi->cur_direction & DATA_DIR_RX) &&
-					    tqspi->rx_dma_chan)
-						dmaengine_terminate_all(tqspi->rx_dma_chan);
-				}
-
-				/* Abort transfer by resetting pio/dma bit */
-				if (!tqspi->is_curr_dma_xfer) {
-					cmd1 = tegra_qspi_readl
-							(tqspi,
-							 QSPI_COMMAND1);
-					cmd1 &= ~QSPI_PIO;
-					tegra_qspi_writel
-							(tqspi, cmd1,
-							 QSPI_COMMAND1);
-				} else {
-					dma_ctl = tegra_qspi_readl
-							(tqspi,
-							 QSPI_DMA_CTL);
-					dma_ctl &= ~QSPI_DMA_EN;
-					tegra_qspi_writel(tqspi, dma_ctl,
-							  QSPI_DMA_CTL);
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
 				}
-
-			/* Reset controller if timeout happens */
-			if (device_reset(tqspi->dev) < 0) {
-				dev_warn_once(tqspi->dev,
-					      "device reset failed\n");
-				tegra_qspi_mask_clear_irq(tqspi);
-			}
-			ret = -EIO;
-			goto exit;
 			}
 
 			if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1275,16 +1332,23 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer) {
-				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
-					dmaengine_terminate_all(tqspi->tx_dma_chan);
-				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
-					dmaengine_terminate_all(tqspi->rx_dma_chan);
+			/*
+			 * Check if hardware completed the transfer even though
+			 * interrupt was lost or delayed. If so, process the
+			 * completion and continue.
+			 */
+			ret = tegra_qspi_handle_timeout(tqspi);
+			if (ret < 0) {
+				/* Real timeout - clean up and fail */
+				dev_err(tqspi->dev, "transfer timeout\n");
+
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
+
+				tegra_qspi_handle_error(tqspi);
+				ret = -EIO;
+				goto complete_xfer;
 			}
-			tegra_qspi_handle_error(tqspi);
-			ret = -EIO;
-			goto complete_xfer;
 		}
 
 		if (tqspi->tx_status ||  tqspi->rx_status) {
-- 
2.17.1


