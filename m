Return-Path: <linux-spi+bounces-10894-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3973C1561A
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B43B0944
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288333EB16;
	Tue, 28 Oct 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1rFZOEJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B133DEDB;
	Tue, 28 Oct 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664576; cv=fail; b=CW7hEh7ya9pQlImHeNdu4glp6dDKPujX6AvFZ0SOMgWNqdVEODx37ejj0yitq6FTOVZgRSM1FMFSXrV7oS5BEhAU+ZLKAD7fV1t1aTjULN+c9CBcxHZC4pauYIt4XercbX+kBt/0+Z3H5diUc1GToE6ECmTX3xx8ZkE7QjBglZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664576; c=relaxed/simple;
	bh=y5WNxF9ikNx4tbDYZf5jufOR8SlfZgTp7Eb9HK7j2Y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNceUi1wqbOVPZLpzUHjKkJ8znHs0bIFOUOpZLk/gYUwnlHEoKLVbmPkoXumgVPwYkwH49UDzWiKmXLBElb4Od/zbOhpvxo4xk3SU5udkOCpXj1ALYF6ATZkLGu0VsRV/wL5GTcDN68DTsMKoLRTyfvLgkudBoeOMK8Fozk5swU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V1rFZOEJ; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGL9eOaq5BHJB+CzsH7dwJPOqxP+lzhJOnuaydSBZs6/N5lqIzzmtmn5dNrw3ilAPp+4ZIxeZHokbWcLYhnR70L+iiNyy8E6qHpDdj1rIdikizmGteqRDP8goOOJ5jhb05OcOqsXjV/eGYA3WQL39TKbdtXXKrYnqRUr/zJn7BFUmfYtQOy+IKvOrWoyISKyzsKjoTEPVahNxvVqJX03ckyg/mu3AOMSD8QNfGF6DxgMBrotO3PIH+WGXw6yXWUNj3EdEUenxSON94ig7lJzBiA4ZTu14rt8erf8yVZpD31PxS2oqs5H6s6eAC4sGw2++okKOS9FcQeOcOyk/YUA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVEkVsq+jb2RVFSOn90BuKVytqvYNraGnhuJaIibYEY=;
 b=UAK2A3vce0rnuv56ZTEF0UmnJQvsBl9ZimSCfkdmFv1Vaqvwj6/a5+Ov3VO2NaqDF59XwpaJ/FvlPHKX9gTkPgROln6VyDkpBaYCtcq6PASuZlswzOU8h0rOGbhQKT2D1dZllp+IOV1T6k1rI9dnqv9LNruOg6Wj/R+MaTT8dIbMiDI6ZeFFwJyrZmyHY7hz054C8QsErVdGd3r6tIQU2G5/2hzbOQXSkYN1GPTu0EeKuFG43ZT17INuaH1EY/o85hxuL/oeI0K9NX30SXENme6JV533ZVX3tcv2JSTYOS7MxZ7iR9rXPrdHeQEBMZE0VnPyPDry07Wh97R1s/H9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVEkVsq+jb2RVFSOn90BuKVytqvYNraGnhuJaIibYEY=;
 b=V1rFZOEJbSQYVTQxZvG8sxaAxrQNmithSCWLERrSx38hOQScPTgLZ0N9wpoMboM+jepKKXd/z2qZ/ATHXZaWtx7Dyiwh/dKZRrCHPamNxzKKVscozWjQfH5/agOh9uArpusl633cMox+xsMRArNNMxVsJ+I/W/8ZC2lDAcV/0Vo9vGJlQ7BLzKIM8p3S8JeYgocHJhj6tS4EL6+HAGI3KxRSafQehhQfoyg7+Ptxjrfc0kozN9Eqlv50OWkAjQFtNycQW730yBrLahI1WgQ0zvRGl+qPwqm59TZHG1a7jqLwHqtDf+4wo2wBHBm903bKuJDye2bctthuIuZ+kAtK0A==
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:16:01 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::6a) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 15:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 15:16:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 08:15:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:15:35 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:15:32 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] spi: tegra210-quad: Refactor error handling into helper functions
Date: Tue, 28 Oct 2025 15:15:14 +0000
Message-ID: <20251028151515.4142618-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: e49f5c99-bfab-4919-0ebe-08de1634e7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3rNvYEOkmwEIV4jWAov1S05UtzONHXbNxQtbdf1bsPzqscU83/it/AdywhP?=
 =?us-ascii?Q?Z0WQY0tsesSrXPYCPk1lpDOr/3ZUb3I6WQoG/JsBJ0jDumNDauEKj2hf78Fq?=
 =?us-ascii?Q?4mjr3krGNu2rrh8p+bIP5fzC6wFhasXiRNPtlWAfkiMr5SuarINW9F/XRCfO?=
 =?us-ascii?Q?692W9uWQVvnp/1FKOL0/M0jkiIEOqx6vV5LRMn1aAw0t2Y79mSYjgfHJ8nd+?=
 =?us-ascii?Q?A67HRvM+HdNnNSlilmMor+y/VBgHHjuH9QhOENbwQ52DvN1GqMH6owqqHiSN?=
 =?us-ascii?Q?zWdFa4n6hCSNGG4i8q8hHOIqHQwGygTnsBwSIEk3z/4TrvhH0DcaYfu7vLY0?=
 =?us-ascii?Q?s3b8z9sfEWA1EyMOY9olF491eSZSXwPBToB5xzAsQmV+Mq6uwzcYiCfrdXGM?=
 =?us-ascii?Q?Qe3sKzi3BkFb+BA6U/yTRLi88j9+Ei2mo7DXndfjo+j8yHHkZBpgA0lpiVbr?=
 =?us-ascii?Q?QxJ3hInrEWEM7duNpl5RBAKqRev2Sm8UpCysbeQNL92GKu4XxqPExEj1dUoY?=
 =?us-ascii?Q?VJX2PpPYDV1T+oI2BuJW79wwJinT9V9s1NyE06Y2jHJDp4t7oQgyGsWHE9Po?=
 =?us-ascii?Q?JUO93gVyWpSDxcbLjUeKVohrSQ9BZIn4M17hWmckN+M9PDQ541Rfza8UfUOU?=
 =?us-ascii?Q?Z6SVCy0Jr5l0SPVrfauyQQk0OKi1L11jTMudF98g/AJa1kzs5CB98HKNAZwK?=
 =?us-ascii?Q?SqCoG0fPPEhf3MoF+hvJfLn5zxMdnrmDKc95jStWZUFlRoYmW3/tUwXYgDu9?=
 =?us-ascii?Q?4xFEHKCpd2dZSXhjz67uXhPxHPCOvzUT3wD0QWlhfQuoRSamoBpO6YyozN89?=
 =?us-ascii?Q?ShLLQ4TmKrpoeAOrCs7JUCn5OCbOncnyyDfnFUPuOQ/5QZfIW9QeSCQ2l7Og?=
 =?us-ascii?Q?mFr5Xacv1o4wy+LxzW5/XKI6Dzv56TSSAxZ8MLqL1ATLyioykMUwg0yHJzWK?=
 =?us-ascii?Q?wK8aUh6bBk2ZueZ3NsXOAY3oAfHeHrnWOT0H5f16/PU4so/efFA0e4SnzsbO?=
 =?us-ascii?Q?S+SmHtVJqRX9whazFG4LP+r8yjZfQjI54oChtjnVKVRe8JopJo6FuLPuC+h/?=
 =?us-ascii?Q?8ec7rpfVK2daVORS7gYop2FHxx+E5gZBxbk3YVI6BeI+EC6S9TNBaK3xM7KT?=
 =?us-ascii?Q?JjQ2/yvA1YMXXQjkDxktWZ6Ppc5CCj9eTk+k+PRS2UbA7SHjbsLyIbgLVqHy?=
 =?us-ascii?Q?u3xfli+h3Rj5utA2Q9ZwUAhpKVGkADF9t3UcMUzNsnuDRGGbBQtWNK8Uoaw/?=
 =?us-ascii?Q?T39vWBG5nebCaQ1xirvChfH/EGsxDJNOubZejP8dQ7WE2CgPL4NQ4X7jQH/5?=
 =?us-ascii?Q?J3IJfz+ECj2/KESSNHVimS5ZFIP6oa0Ab+NhlSEsGM6A00TO8sf2gWMhD2Id?=
 =?us-ascii?Q?i4n7GyP/ZwLF6581TEY0+qs4V/EsqocTHflzlweaBjbnKfe2OgmGPmJH9v14?=
 =?us-ascii?Q?R245ysnuukyIM9E8Rj778OQPacbL0fDg+tB5/Yt1wuutVkiuSoglRbZ7Nkce?=
 =?us-ascii?Q?4Qni2HmLVxkxBjd3RTec+nvjEF5gRXNzlvG13WPqNSVBoWhAFvC4nyS4iPnp?=
 =?us-ascii?Q?iIuEXzuse9tElLpLmqE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:16:01.6255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49f5c99-bfab-4919-0ebe-08de1634e7e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611

Extract common cleanup code into dedicated helper functions to simplify
the code and improve readability. This refactoring includes:

- tegra_qspi_reset(): Device reset and interrupt cleanup
- tegra_qspi_dma_stop(): DMA termination and disable
- tegra_qspi_pio_stop(): PIO mode disable

No functional changes. This is purely a code reorganization to prepare
for improved timeout handling in subsequent patches.

Change-Id: Iab526e0c19d160a39919ad98079b97c2da2dba94
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


