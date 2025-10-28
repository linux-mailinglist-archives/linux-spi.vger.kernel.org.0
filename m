Return-Path: <linux-spi+bounces-10905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293BC15AB7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57333505B07
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BD19E968;
	Tue, 28 Oct 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="urLoiZHv"
X-Original-To: linux-spi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909A340DA0;
	Tue, 28 Oct 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667073; cv=fail; b=hA2V8jB4WoIOlPOGcy4e0olt4lAPvUGnpzFPa8jrLbCdpM1HDHHOmwWCJU81qWOnAcPZfO+oVsMcA0XxlcOcydLSZERz9/eZalb8lADMQ0Urpx2gP3Y0WmM1r1+UrZcwrj4NfxN5HmSMoqLvbsj3yFKut0FTWesuYfph45lw5Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667073; c=relaxed/simple;
	bh=YR1ulCsGwtuzZIZd5ultSpb/k19LfslNMfH9vkzQpYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKF6N46CR3Z0Ov4GNho69kJULoInarbf97Wlk7dqHaqzCYxTRlG7ptS0rI4G9vha3f+acEFaKmkWAPeUaFSq9doL3//JIUkuGhpTxX1X56mI916BR1JJlD7KUXFVIwYXyIQkQB+XX4XgKIC6WLJPEqiiNOs/NxEbJtAMIi1IiKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=urLoiZHv; arc=fail smtp.client-ip=52.101.48.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfdAPojj5ZLp0fkt0FuWfdXQGtyemiuOxBxeDY3/txCTudHRyEixuK6P/f2fO2Wpypke1CEO2pT5w0/0ATEnKgPpBQRKyfzwgQsNr0CTJx6/aoQ0yOsJxIE7xYBqVE+dzBYW4cOvRV6uPiGkbI4Nx9JVwbo0KrLHSrUdj0BKwx0IbYlciiTTTdroOif6X0LPh8vZzEwSKhi8yaAtqbPv/LG3s+SuN5Vct0XZ7lrj8tx+ZxhNKbHNG+0947U4/Z8wu8lNiYQP4xfmTXX6luzwPq8fyOV5HSlNHdI6a9aylKhb8o99tOtfpb94PG3keAxWOuK6pHw/79HKjFleMut6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWGekwxey8n0bGNDDNe3/Lo2+kr93gBpDD65mjMoOSw=;
 b=MsF5Y3Sg152v2vfX13ewAE9npHlwOVz+vTRViVRWyEE9zgcyrzEAGWPJpGcfvhKLjEELkM3jZ5vDy7ddw6S4LO7Wjs5kVSwaF3wLYYDS66Goyljt3pIvNFbOjJyt+caRttSFJmyY2YSV4rWZKJiGlaQbKa/h0S0DfHxUX+h56gUKs+6O8/R19o6T8V2OJzm6qbipj8aB2rYThAIXheWq9jCTI8gwoxGR2oZVAZksInuH2c39gLVfErZw+1eKJ6yr+HLK4zMrlOvSBQdV0HHIvcKgrSpR5XSECdnt10dkPVpX3scQJI9o16HG8hnsyJQUWT5ca2sOOLjWztxl+mJNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWGekwxey8n0bGNDDNe3/Lo2+kr93gBpDD65mjMoOSw=;
 b=urLoiZHvEXmIvda/sj4DSMVEFywkpAV1wu/mm8amfRJ23KBUC8e1UV9X6kScj/PV+RzI9YkIFrgrJpBoikHTN0FrqE5AP3cknK+D5XR+MmNO+0XU1qZhT89USluy1QN38ku0067DBhyu452ip9PaLYUT/t3LuCp8IoT3OvHThsDSo+Ov2dbXDNpOxNb8lNoZMoaC6N31tJfEK40JxHxg+X8rdO9pCtyHt2lYCnYCrVDiMhRKG9KOdnHOtI25g7f37G+3MekiMdHW7tfcaTgPjdc6BP98b5LGHL/DKZwIA0cbCHVGXj+D3Kt7LmORsPEsEAvH24rG2Xe0QiHFZ44i0w==
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:57:45 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::82) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 15:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 15:57:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 08:57:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:57:22 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:57:18 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] spi: tegra210-quad: Refactor error handling into helper functions
Date: Tue, 28 Oct 2025 15:57:02 +0000
Message-ID: <20251028155703.4151791-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: a02ae061-7871-44ee-bf82-08de163abc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLzIQaOdT/MyK6yPX9dy3msGH1iud4EWN1DKxgjKSDA5Eg64DqCjHpgGCxT4?=
 =?us-ascii?Q?viV7nGmDtdH7fsJLcf13veqFHJ1Al/N/jZ96M1szxxDOn5PXLssvLW5ksQo5?=
 =?us-ascii?Q?/1JGGywh9UfqKOgKFcWB9vm2bBCRc5WCVnA/PWAA+JcMpqE2Cz48y4zTEntK?=
 =?us-ascii?Q?kNnZfIEc8p8zhbN6cafClCzcfsT+wnu34Y2DY+BljgIjFC2xB+IQcovlj+Q4?=
 =?us-ascii?Q?P3nBqONIRcxIbYg91NF2kMRMMX/JQETtCyxp/7recprjOs1FlKs17sYCi/Q3?=
 =?us-ascii?Q?hPk5993Z22TfUiz8C9GBsMxcQNgcnHSo4WfTkmlE2Ziha2NrsxZadXOmkXRj?=
 =?us-ascii?Q?bRQx4yGBRzQ7HFa+7GSZb/6cDSc0CqHC1Cxr8BzzShDGFG3yqUMCa/MLT4Hl?=
 =?us-ascii?Q?B94uB6eiwsAOdYpwKeoHyQHJ9HlNu2EngqgcT0bhgN94ubxBxv8rqXaK3oyh?=
 =?us-ascii?Q?1+6QqnemFQOZa0OGcNIIs46cLcipYBKh7fePNpVQ2kotVGBJIkoFC7tS83fc?=
 =?us-ascii?Q?O3G8/UesBHJVtM8+KTe+ATrtodeGCTNet33F8p8RP0HZ3iDdjaQLY6Ib0gty?=
 =?us-ascii?Q?C9g3RyiNT09DLQyJ0/fi9wvXJBEywwqFAg8qyweN4xdG4++SNIKbWfzQAZUd?=
 =?us-ascii?Q?0TbZLt3izfBNaAPInBUNxE7/KhBn9Q2djmWycUdzCft1VrIHERnFddDwq4RS?=
 =?us-ascii?Q?mzWZ6ptx+XujiB5sYAGfQ8idwrvVO/wggHY7crXHDech73SzANAJtyYkLZNb?=
 =?us-ascii?Q?xjXmGqoi+fCGpnFRNtruMAi1EApYSFGCviNhfWRAE3wB6wqFeFi9r4s362SU?=
 =?us-ascii?Q?376rYGfQn+Dp+MNn918oy7CS2gS9y2Co6moxfNh5bg/yGrlmLw7IJTEv+pyn?=
 =?us-ascii?Q?p8puwmiKaFQ0U5Z8hR21PSorbS+UPE4DS08wgeHo2AeT0xFsW1b/BnFngEm9?=
 =?us-ascii?Q?abcD9XqIvJ9fNCC6+U9iZYWdRYMBkcW/XWwiJYzoFGHVo9NIbYt2wia2tueZ?=
 =?us-ascii?Q?LHQE8XfH8IdFItkCi8v72JD8otGJJTcH9dEt0irwTQVddREbcf8tNTJtv7t+?=
 =?us-ascii?Q?OMX32Agm2dF6SDfeWHT3SjtSirrMLwNxoIEd8M83htk55g7gY9oU7Wiz/o/X?=
 =?us-ascii?Q?GFHWeri/F7LOONHUqsAe1oFa1vfxIpcDbzEoG0oeOLjkPUwh4/GfHj0Zmfg1?=
 =?us-ascii?Q?KQCSBEmM2y8sOxcQ/l7nYPC1eYorajudYi56D6LYE3PPDlznJlfTw4I2GSZM?=
 =?us-ascii?Q?IyyTF5IlyHVs7C0Tj7OTDF4kjh2Uiuvz0jKHzUGaDw7A51wFdtthAtEqPyHR?=
 =?us-ascii?Q?q2wv4NSQBDtQ4mJBUd088Q8KqXocraVK5/4wDw+7f6FKqm3d6JrK+k9Ge46F?=
 =?us-ascii?Q?ZrRpipSx/lzSi53OUGCrZNkNTgAyaOSXfgYOx/BHGXIiDOHajeRj1X5IHZlM?=
 =?us-ascii?Q?2du2SCbmNHeR9Ka6+Ims7/lKuTyr8P2tUHcOduaxPQ5BmDBa1Vg94/sWn9yx?=
 =?us-ascii?Q?nIWqItn02btFvT+cbpuAe07xa6Aao0nUjbgRQVS05Tai5lZJbtSCGBbbNlMg?=
 =?us-ascii?Q?dqNV7Jh8JnF6dKC3Rt0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:57:45.0831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02ae061-7871-44ee-bf82-08de163abc05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

Extract common cleanup code into dedicated helper functions to simplify
the code and improve readability. This refactoring includes:

- tegra_qspi_reset(): Device reset and interrupt cleanup
- tegra_qspi_dma_stop(): DMA termination and disable
- tegra_qspi_pio_stop(): PIO mode disable

No functional changes. This is purely a code reorganization to prepare
for improved timeout handling in subsequent patches.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 84 +++++++++++++++++----------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d9ca3d7b082f..69defb4ffe49 100644
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
@@ -1074,6 +1079,30 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
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
@@ -1081,7 +1110,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
-	u32 cmd1 = 0, dma_ctl = 0;
+	u32 cmd1 = 0;
 	int ret = 0;
 	u32 address_value = 0;
 	u32 cmd_config = 0, addr_config = 0;
@@ -1150,39 +1179,16 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err_ratelimited(tqspi->dev,
 						    "QSPI Transfer failed with timeout\n");
-				if (tqspi->is_curr_dma_xfer) {
-					if ((tqspi->cur_direction & DATA_DIR_TX) &&
-					    tqspi->tx_dma_chan)
-						dmaengine_terminate_all(tqspi->tx_dma_chan);
-					if ((tqspi->cur_direction & DATA_DIR_RX) &&
-					    tqspi->rx_dma_chan)
-						dmaengine_terminate_all(tqspi->rx_dma_chan);
-				}
 
 				/* Abort transfer by resetting pio/dma bit */
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
-				}
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
+				else
+					tegra_qspi_pio_stop(tqspi);
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0) {
-					dev_warn_once(tqspi->dev,
-						      "device reset failed\n");
-					tegra_qspi_mask_clear_irq(tqspi);
-				}
+				tegra_qspi_reset(tqspi);
+
 				ret = -EIO;
 				goto exit;
 			}
@@ -1276,12 +1282,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer) {
-				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
-					dmaengine_terminate_all(tqspi->tx_dma_chan);
-				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
-					dmaengine_terminate_all(tqspi->rx_dma_chan);
-			}
+
+			if (tqspi->is_curr_dma_xfer)
+				tegra_qspi_dma_stop(tqspi);
+
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
 			goto complete_xfer;
-- 
2.17.1


