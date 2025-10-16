Return-Path: <linux-spi+bounces-10695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FCBE3B56
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 784E9505D59
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D19339B5E;
	Thu, 16 Oct 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qIKaVWAa"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A6339B2D;
	Thu, 16 Oct 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621403; cv=fail; b=UC9VoYbMMmjj8KbTJ6hCOLiLSAuC17jjpFf9kX+XKKV6VyymU55nWsfi98qEGogtFZEi6MFyy/iRGdqf6NG4xTNKk7pTBt8/eGBoIw5cI2RxOB+Riu+N1VobXADMXOl70/AzKxaclnpxlwuELcxX0l22gJE2dFnuD59lMZblx0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621403; c=relaxed/simple;
	bh=K3VKhpzS6VSZ91z8hlF/T2o2bbEmv6vcsZbbZAgbjss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA43NGwL/mKDGPazYLpPU/bvDln5vCSs3ijvj25tUVbIrhoHZHDuGISRCQrG8F+mm27MWdpSJbfrBev3F2Nsuaqq7gsiGz6sXXQZislc1tuuiE4mn1619uWQb7JYB9ayUTSHxGNLESAMzMSmdlCVvePamS7mX4LU5E7lWQQ3DUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qIKaVWAa; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bog4POKwqlq0zlnLlL7JqafkSreMSsc8DXygN3qHCE54IHcHkGFrT9gM7Emy5aPRmfriwS1vQXbc3UodXGZoxJ+2yzTBwWljzYrL6+dbCEyDuyT9Z7LoVLXafJZHq4OccvGIoJYHzcJvELRgyPD1CQjwfcl+xBmWPYmp7bxBG4+rZE5Mx1Oa9AcZ68+1IeEC+jF2TDE/smcSJ7mUGhaXMNle0ma5HzPdcmdLp6NvxHCa18B0u2HaszmZ8fOfzyJ36vTisHrmiB2z6W+/kpMB7tRhS+2NcKlpTvQ0+R5RHrpS2rxDP3r8OutPGLdgtkfCp9LUVaL2iX+M5D3vy75plg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbkmKaTPaUKdOPBs8I6pjK6endHcLHEZQ2Kuhl4hr00=;
 b=WwziyvJa9o7Q1yrn0+Hen8aruxYVizdcsbhY0z6dZdhk7+PtsCJAERdMNP2bCdLw53/5wPc+Bo7nC3dG659zqEGyRmbu/r7HfZw0Kh+RoCJ5pcz6MxNKB0UMsFrCD0sfh2smlX0qrjb9YZSx55KNX35xfW0gEtd/gna2dQXEVwZCT/AJNAvd14uLEo8Vt4X5eLEJGXzVODUkFltDo6UT4tK+wskQWY5Vt69vyHi8ZN2iUKjmx2Au5RzYDdCrHoexUM/MK30qzA96pf+AvaWuCNaDpAxR+XU3cfxmgNQT/gM7PQFLvE7YiMBmC1NVd8TYB2BPbFarqHUKw3OukYjRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbkmKaTPaUKdOPBs8I6pjK6endHcLHEZQ2Kuhl4hr00=;
 b=qIKaVWAa7LiJ7a48qUlJ7iJGv//nyY67fcT4mlfiV56VwsU2Z+UTQXw42WO4d+VvPjZz4L+PCjazLgGNFvBaCGOpgSDGh+XY9BKukIxeRO7Mlwc3p0XAyEfFOYTetTe0evGJ1vJG4AsQkMHYVZCVjLBY6ywHMeI1+DFhtCZMC4r8WRPOK2Qm/V1Ddw5sjvlpVPMOZcaCiz6oSGFLTjhtRtvFj8fSKpDF1WP8zjZ+++ChHz6NR+LDnFLqBtNp6DojVxLl4R6D9oosLHKjVJBg/tghM6DYcP3Xoua7y19jnULV7wu2HE9VCaSyupuX/a56kIlLAWP69Dfsq8AB1PudDA==
Received: from BLAPR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:36e::26)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 13:29:56 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::85) by BLAPR05CA0011.outlook.office365.com
 (2603:10b6:208:36e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.6 via Frontend Transport; Thu,
 16 Oct 2025 13:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 13:29:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 06:29:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 06:29:41 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 06:29:37 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] spi: tegra210-quad: Check hardware status on timeout
Date: Thu, 16 Oct 2025 13:29:23 +0000
Message-ID: <20251016132923.3577429-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016132923.3577429-1-va@nvidia.com>
References: <20251016132923.3577429-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6b6175-95a7-4a73-0039-08de0cb818d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nY6RNg7C9HyP56qeLlYl9Qm1Z6Jhr4J/3r7V2oeo7JIN1+Y4boib5PmmMTf0?=
 =?us-ascii?Q?yCykPMqE3EwcA5ELGk+ZUFcY64Lq04wjUPhnlD5OpBNUqoxC3ga4tKOjsJtx?=
 =?us-ascii?Q?RplF7lPY4P6ky+53+uf3ACKCqXYjJBuQBUbrYQE21tpYzWl8rHof+/F2FUO/?=
 =?us-ascii?Q?bT7aVnHY2LZ62u9rRDA54h6fk+u0LTcEbVvbTHhNYMAb20cisQIdoiPyh7/o?=
 =?us-ascii?Q?3tB/NMvAArof6oroFol0q0y0jfyK8tSvwZ/8FCC+0bvsjFOTeLA+C1SOEto5?=
 =?us-ascii?Q?maLYOmMHumssy1GAJSDetuaHwn3wXlumITUsu/4chOxWKGFjiO784u1KFi4u?=
 =?us-ascii?Q?FMOgCCEjQAr9Ls2gzW9MLev6fqz15MGMcQDB8HoyeV93SiJA5kn8hWjHlgsR?=
 =?us-ascii?Q?OFn+mVbdqybmS6hGNUcsgXB/a5Ks78SLjKNMXRki1g4DgWOrdNH5gV5mhxAi?=
 =?us-ascii?Q?bBPu7rVtHYIugiuIWewBgd4RndaG2KqNrz5actqeo0BaGbZ+xw1DEKXVHqHE?=
 =?us-ascii?Q?B8Ivz/2cDtG+mAfqbDwN7BWG6QYC60KcYtl5uFObK+maC5U8xJU/fKOIiGuF?=
 =?us-ascii?Q?NKav3/Do7B5sLMkf6rzeOUdM9AVJ3jy7PjDIqt+v0jKRGwlHb5lMEmPwkTX4?=
 =?us-ascii?Q?DfZhhifJTmP9xxzALKiUpR0XNJU2TwuChQIzaXCFtM1JL//zExdt2Ioov2GV?=
 =?us-ascii?Q?HDqrSCVcPiVgitkzUXTNKOxX1uRTAPBdMZNkqxRwB5xhhrE5qHTmwpg2rJxk?=
 =?us-ascii?Q?/K3+hxhtliqL8iaVAcFX/+9NHhFtZ9Cz7ne5a0ZiCEDmS99C+/KP/L66j+cC?=
 =?us-ascii?Q?4J029cclqSqgrZEvwlRiM8RpqOz1BqBQmT78Vv2v8c1qaOrCmBOrbSCfc1Jh?=
 =?us-ascii?Q?RwfVZQ2FZuNLVxNQxnI4ve/0qGtVXNRQ8Eyc5kYeP+aH139Z0WydQxqiyzGO?=
 =?us-ascii?Q?vR2HmuI4HQ07lSWpV1yBnaPHG4SCNd1ipNL0Yj4TWhAyE3kYlRzEi+Li6fLj?=
 =?us-ascii?Q?QjiGHAWBtFo7ZQ/ITxhlZW7/uH5iT9aNnjDSrEdX2USvRlrTN4BB3HlPrrLn?=
 =?us-ascii?Q?CiFxUGl5m3AiYxDQ29Vjm5hpvQGZVzJ4uhvX9eTbQNjnu91B04MjoWgdC/zC?=
 =?us-ascii?Q?qdbb7Ep0xRS30mFSKzO1kdhv3JuptTloCG8rcPFRezIk4frB5x9I63bqnbrA?=
 =?us-ascii?Q?0F7//WrfP0oYkuo95tTgRTlu0naTtjv6oWZzgGlGAotStfxSOlAqDz3r5Fb9?=
 =?us-ascii?Q?egc5LL9ZCceoObbPAtK8ROVHR2ahwhmioADC/rsoUhXbg2G/esDnzR8Frwzk?=
 =?us-ascii?Q?eb8tKUWOppceGyUBLhsy9RM1hxuFxkGkUPhhaKcxE8fWrqjvZpGQu7OcdIj+?=
 =?us-ascii?Q?SA6horUB5fj+W/ZvzCFK/lKsQez2UfokNgByQeKJXxq08SCD/StS4iwZ0N8I?=
 =?us-ascii?Q?eX3yd5yA0sU0wAOrdmsv3hl/FneIGEt1KPz8I6TZW48w22DqS3G4kBT310yn?=
 =?us-ascii?Q?3ePq8lCLrrbgbqG8SxoHOxv9Ew2NOlV1TUYDmI6R8J1RTmLkGOu2C4RuZ0y0?=
 =?us-ascii?Q?8wcUzzg/eVYzHj08IUE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:29:56.1303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6b6175-95a7-4a73-0039-08de0cb818d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

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
index 10e56d8ef678..757e9fe23e0e 100644
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
-			}
-
-				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0) {
-					dev_warn_once(tqspi->dev,
-						      "device reset failed\n");
-					tegra_qspi_mask_clear_irq(tqspi);
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
-				ret = -EIO;
-				goto exit;
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


