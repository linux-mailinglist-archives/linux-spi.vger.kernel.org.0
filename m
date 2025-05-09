Return-Path: <linux-spi+bounces-8045-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C306AAB1B14
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 18:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258CF18897DD
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750223D29B;
	Fri,  9 May 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2HRSV/M"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458B23CEF9;
	Fri,  9 May 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809688; cv=fail; b=ss09z5ofm9l45YWoGnzjkdMZjYTDhp/sTB+Yc/XmmQE/FD1ooc5NhYlGe5M6KfoUc5YWDikWQgbrtgm//EcqhBT2FRghl4myDoPvPDSaoBQ3uTBddBn1TUMxkXijy/9JR6mmzDi4YzRXffU83jzw8x9FddzCfha7y3zUCLobS0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809688; c=relaxed/simple;
	bh=LsBrQ6P+OWRF06+RM3IXl7WgyribTIcIDlrAqKs1eyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cb8rxAC/H/LQsDJb9Rv1OImuW2abTP4HAB+AXfXvWb4FO/qVR5momLzR/1yD5YIk+k3aDuhbtWMjcvgoV83vYwIg+ZJNuB0bWBKLOWWYsJxbupjO4G+PgFDgdyV8/VUw1eoxlz7HHYyHAfys9qR+dOPXk03pTcbkjf2ZYCOGbp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2HRSV/M; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOmjc2Y+bihrCCAYV4I5fyRPq1qTGGsndYodbCt0V7jNc0h3j2V3AVrEfD4IKihb5S+gOMth8lKRAixpPJmZbgFXD+6EWZUoPSs495OH/fOSE1BTMwgQqtUb5TIMz7nWMTeJGp23F+EQGyMXVAF9gHi+/PZCkk6oVuz+jXkup+wNikAx2sgrbtlbn9EKmbTO/EjWslhvsEwek46xSvmQr6yQ8+Fu1WKsFaBLKeG+JobOFQ8Phppy07Al0rryAVGWCW4YC/16aIqCY5amNZODTCFsxX8wfzVVNsDJvpn9icilIq5SKCvBfb8I4n/yTiTYrAUNDPTCxGibrrdjQe5NeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9lqmypYj0tUgoJEu4Ou/+9vpQc0ofC2Zq+pTzz7kzI=;
 b=LMI1JvSos39cbXzKCvoDN81ju1KkoiZacW4P4UHN9NOlsth0TqDwqEPtGJ3PPU/ap9cJpFHgpCj/GWHhJ03/999UHVppDzdIt1sRE7OSaHGfQZN8J3e6T45YYOi0lECjtSqfpajg5t96KNVxv7k1LSD1voB8C3CtsYQf302S8fke6E5IkTKFMKi3WQN44N27erDRE5gfG5WPP+gaDiuX9eqJ6tpQPGPxdNWU4OLa7gNlN6yuhYqZ1ZVHeuFb1AZCl/fEVAd6OLDCW/Y8GM7Hu6IBvW/3FVaYQNYvvSa1NnXQIiJqIppnG+VoOmdVsQzXqjWbdK6MAU7+azlZsWhQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9lqmypYj0tUgoJEu4Ou/+9vpQc0ofC2Zq+pTzz7kzI=;
 b=h2HRSV/Ml4t2NdRlypKx0Oqxf29oiy1G62KNQS1pwlfL+K7DQRPZ2mj/QuDNbOnVBzmSW/aL9fDwqorJBN+MLWV05nQn36P9y2xN1mNIQ37CETj2fPK0tYIExqPvRJY0EV9vmk3p7OjAygDmtkx6BVt1V0O14ZzMrbkAsc+N83I8h9F2gsBrj0dVD/bwZbVxHpC0rfMdYMVY6yb9OpenO9r8cOSax2aNnvcBKOo6RqN8F+X3dH56cKW0ZZSio5EVR11ERBTTsz7Or5X6QPlwJL+hvuDp//EIZzq2OE0QKTSVyH988sb71LidTYwYwMTh+4OuBRtukrM2qpSWKSgPtw==
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 16:54:41 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 16:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 16:54:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 May 2025
 09:54:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 09:54:33 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Fri, 9 May 2025 09:54:29 -0700
From: Vishwaroop A <va@nvidia.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>, <bgriffis@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH V3 RESEND 2/2] spi: tegra210-quad: Add support for internal DMA
Date: Fri, 9 May 2025 16:54:09 +0000
Message-ID: <20250509165409.311912-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509165409.311912-1-va@nvidia.com>
References: <20250509165409.311912-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ec11e0-8208-45f9-5ea5-08dd8f1a3159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6L6NH3SE4lc4Gf1St6mJJM1AU8FT06J33KZ/JVU5rKTzf1amfyJmZ5BDXDaC?=
 =?us-ascii?Q?u+lhYC9xZz+FlE7davKVYc98L7ACRWpXlKGfAEm6LbGtAILsdqBL7buREuq/?=
 =?us-ascii?Q?noYwRy10un+8rb2o1+QKOXp3iyLjDfJ7M2qxHi+rc0Rf2vBHOkhHGpZkWLGh?=
 =?us-ascii?Q?XXHaVBO3/BzGvxlbyyp5ZzuCHUVzGIByBTWIp7bE7MEBjw9ukGEojX/6EsM9?=
 =?us-ascii?Q?nVlb340QUPHRTnBCdxlAho6j1Pz+TBdGRaLng0j3qu79RnIs2Io7j+WEVXYx?=
 =?us-ascii?Q?hjHts9FjSrxk/5qW+/Ko+rvLnKBgFAbFpULooItNgnF382YA/xKDavBKuWrT?=
 =?us-ascii?Q?7SgtXyjP5BVdDBE9dZ/fEt97qvcx1ubIg36dSDUXY3VcVmet++BbctZWu/fM?=
 =?us-ascii?Q?0gCIG1zG4dKyGT8JbbfYMy0awMJTrstQN6J1RlMNctBbhSm7xxhg3SNH9eAu?=
 =?us-ascii?Q?FW6UaaX7dEtO6EqFeBOqHXOkIaRCCACC04vBJNdx33i7ZixqqEZTctu0KIkn?=
 =?us-ascii?Q?h3CssLinh9OOua/g6c+KTLzT7UsSnQLgBELGsfc24isXZZcoOvSAhellDwac?=
 =?us-ascii?Q?P/vwUXa+WixYsMlLOgw43Xjv7hheHaTl9k+aaYDS9VW2SyluzjzFRd0svKEB?=
 =?us-ascii?Q?gIVOZ2qin52mYpsmXe7VuJsOVRvWFhupxQQU+1lotAQoxr6Anwk+8cuwLfgy?=
 =?us-ascii?Q?m0gDgS51EpfqCna6eVn3nhEopnfIjZBaF0ObGjP/RCc0DF4+568mNaGHxv7N?=
 =?us-ascii?Q?idNyEzs3SkGZSOpyIiBpuTZTUK+zIohj95fYK9KAFbnG9ghC7YNcMXhXxSfP?=
 =?us-ascii?Q?aLL0+LA2KOZyMWh7/Hd3jzHvlXKyQY2kMDXOXPCEZvmzycX1BOpnoBksvG47?=
 =?us-ascii?Q?ZCVaapVwlDjuAaf1729NrLrzCnjfESQG+6bNCo2bHF4AHF237+0hS6je81bv?=
 =?us-ascii?Q?7e4BwF/nVpsODN1rItMgkY0bCtwHFHviZKa85lM9PC18vk9CChUh3uI0U7SD?=
 =?us-ascii?Q?ZzevUwhVsH0wQfLeH3vWKwwnCytyuqMZoAG+JZy2iMkbZuehUA878/PDC2Kl?=
 =?us-ascii?Q?2bCO50OgI+iA0jw6i76kQM7dHB1qJX2ybvhv42rKn5jPOHN73au4bcsHnYtA?=
 =?us-ascii?Q?NfS/M+NBPmWL+GHAUDjLM/TnMtT8Fw0Dbsn8omm1T4k8fYZKcgvlDKt+qMUe?=
 =?us-ascii?Q?ZsYQPSDcldlEnB9f6EYnzr++liZbeU8fuF4dfE3o6vCLJuDtikNraip5MoJ8?=
 =?us-ascii?Q?jaVZvqqbdP+aVJZbHj94HKtiZx2jzinvoaz3Wcp01d19GQYfXRTutd3jQ2q4?=
 =?us-ascii?Q?YgU9tFnxlzuy76bZDpnMsFtUCvL5zT+KZW6sK9RtvmneeL3t2jBtdsNfdkaI?=
 =?us-ascii?Q?BNUR44WWsBWZlfPWBM9ReGnc2TctCqO34fCBoxC/LJGbWVk7wTQS9CW1S0Ta?=
 =?us-ascii?Q?pNJGU2m2LWdf7afILz1DO38R+jJtZUKpjWRRoMENeJ6X6jysXp77k4JHt87p?=
 =?us-ascii?Q?GO4zcFofIzlcYJIeJ6i1Pm2RAPeTLa/a97fwx85zbHE1p24KHoJfOXWYUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:54:41.5974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ec11e0-8208-45f9-5ea5-08dd8f1a3159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

Add support for internal DMA in Tegra234 devices. Tegra234 has an
internal DMA controller, while Tegra241 continues to use an external
DMA controller (GPCDMA). This patch adds support for both internal
and external DMA controllers.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 225 +++++++++++++++++++-------------
 1 file changed, 131 insertions(+), 94 deletions(-)

Changes since v2:
- Fixed version number to match the actual version
- Added proper changelog section
- No functional changes from v2

Changes since v1:
- Added support for Tegra241 device which uses external DMA controller (GPCDMA)
- Renamed variable 'err' to 'num_errors' for better clarity
- Added DMA mapping functions for buffer management
- Added support for internal DMA controller on Tegra234
- Added new DMA registers QSPI_DMA_MEM_ADDRESS and QSPI_DMA_HI_ADDRESS
- Modified DMA initialization to handle both internal and external DMA controllers
- Updated DMA transfer logic to support both internal and external DMA paths
- Added proper error handling for DMA transfers
- Updated SoC data to reflect DMA controller type (internal vs external)

Initial Version:
- Initial implementation of internal DMA support for Tegra234 QSPI
- Added DMA channel initialization and configuration
- Implemented DMA mapping functions for buffer management
- Added support for both transmit and receive paths
- Renamed variable 'err' to 'num_errors' for better clarity
- Added support for Tegra241 device with external DMA controller

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a93e19911ef1..3581757a269b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -111,6 +111,9 @@
 #define QSPI_DMA_BLK				0x024
 #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
 
+#define QSPI_DMA_MEM_ADDRESS			0x028
+#define QSPI_DMA_HI_ADDRESS			0x02c
+
 #define QSPI_TX_FIFO				0x108
 #define QSPI_RX_FIFO				0x188
 
@@ -167,9 +170,9 @@ enum tegra_qspi_transfer_type {
 };
 
 struct tegra_qspi_soc_data {
-	bool has_dma;
 	bool cmb_xfer_capable;
 	bool supports_tpm;
+	bool has_ext_dma;
 	unsigned int cs_count;
 };
 
@@ -605,13 +608,16 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
 
 	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
 
-	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
-	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
+	if (t->tx_buf)
+		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
+	if (t->rx_buf)
+		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
 	struct dma_slave_config dma_sconfig = { 0 };
+	dma_addr_t rx_dma_phys, tx_dma_phys;
 	unsigned int len;
 	u8 dma_burst;
 	int ret = 0;
@@ -634,60 +640,86 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 		len = tqspi->curr_dma_words * 4;
 
 	/* set attention level based on length of transfer */
-	val = 0;
-	if (len & 0xf) {
-		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
-		dma_burst = 1;
-	} else if (((len) >> 4) & 0x1) {
-		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
-		dma_burst = 4;
-	} else {
-		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
-		dma_burst = 8;
+	if (tqspi->soc_data->has_ext_dma) {
+		val = 0;
+		if (len & 0xf) {
+			val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
+			dma_burst = 1;
+		} else if (((len) >> 4) & 0x1) {
+			val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
+			dma_burst = 4;
+		} else {
+			val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
+			dma_burst = 8;
+		}
+
+		tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
 	}
 
-	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
 	tqspi->dma_control_reg = val;
 
 	dma_sconfig.device_fc = true;
+
 	if (tqspi->cur_direction & DATA_DIR_TX) {
-		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
-		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.dst_maxburst = dma_burst;
-		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
-			return ret;
-		}
+		if (tqspi->tx_dma_chan) {
+			dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
+			dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			dma_sconfig.dst_maxburst = dma_burst;
+			ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
+				return ret;
+			}
 
-		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
-		ret = tegra_qspi_start_tx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
-			return ret;
+			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
+			ret = tegra_qspi_start_tx_dma(tqspi, t, len);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
+				return ret;
+			}
+		} else {
+			if (tqspi->is_packed)
+				tx_dma_phys = t->tx_dma;
+			else
+				tx_dma_phys = tqspi->tx_dma_phys;
+			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
+			tegra_qspi_writel(tqspi, lower_32_bits(tx_dma_phys),
+					  QSPI_DMA_MEM_ADDRESS);
+			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
+					  QSPI_DMA_HI_ADDRESS);
 		}
 	}
 
 	if (tqspi->cur_direction & DATA_DIR_RX) {
-		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
-		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.src_maxburst = dma_burst;
-		ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
-			return ret;
-		}
-
-		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
-					   tqspi->dma_buf_size,
-					   DMA_FROM_DEVICE);
+		if (tqspi->rx_dma_chan) {
+			dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
+			dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			dma_sconfig.src_maxburst = dma_burst;
+			ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
+				return ret;
+			}
 
-		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
-			if (tqspi->cur_direction & DATA_DIR_TX)
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			return ret;
+			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
+						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
+			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
+				if (tqspi->cur_direction & DATA_DIR_TX)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				return ret;
+			}
+		} else {
+			if (tqspi->is_packed)
+				rx_dma_phys = t->rx_dma;
+			else
+				rx_dma_phys = tqspi->rx_dma_phys;
+
+			tegra_qspi_writel(tqspi, lower_32_bits(rx_dma_phys),
+					  QSPI_DMA_MEM_ADDRESS);
+			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
+					  QSPI_DMA_HI_ADDRESS);
 		}
 	}
 
@@ -726,9 +758,6 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 
 static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 {
-	if (!tqspi->soc_data->has_dma)
-		return;
-
 	if (tqspi->tx_dma_buf) {
 		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
 				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
@@ -759,16 +788,29 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	u32 *dma_buf;
 	int err;
 
-	if (!tqspi->soc_data->has_dma)
-		return 0;
+	if (tqspi->soc_data->has_ext_dma) {
+		dma_chan = dma_request_chan(tqspi->dev, "rx");
+		if (IS_ERR(dma_chan)) {
+			err = PTR_ERR(dma_chan);
+			goto err_out;
+		}
 
-	dma_chan = dma_request_chan(tqspi->dev, "rx");
-	if (IS_ERR(dma_chan)) {
-		err = PTR_ERR(dma_chan);
-		goto err_out;
-	}
+		tqspi->rx_dma_chan = dma_chan;
 
-	tqspi->rx_dma_chan = dma_chan;
+		dma_chan = dma_request_chan(tqspi->dev, "tx");
+		if (IS_ERR(dma_chan)) {
+			err = PTR_ERR(dma_chan);
+			goto err_out;
+		}
+
+		tqspi->tx_dma_chan = dma_chan;
+	} else {
+		if (!device_iommu_mapped(tqspi->dev)) {
+			dev_warn(tqspi->dev,
+				 "IOMMU not enabled in device-tree, falling back to PIO mode\n");
+			return 0;
+		}
+	}
 
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
@@ -779,14 +821,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	tqspi->rx_dma_buf = dma_buf;
 	tqspi->rx_dma_phys = dma_phys;
 
-	dma_chan = dma_request_chan(tqspi->dev, "tx");
-	if (IS_ERR(dma_chan)) {
-		err = PTR_ERR(dma_chan);
-		goto err_out;
-	}
-
-	tqspi->tx_dma_chan = dma_chan;
-
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
 		err = -ENOMEM;
@@ -1128,15 +1162,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err_ratelimited(tqspi->dev,
 						    "QSPI Transfer failed with timeout\n");
-				if (tqspi->is_curr_dma_xfer &&
-				    (tqspi->cur_direction & DATA_DIR_TX))
-					dmaengine_terminate_all
-						(tqspi->tx_dma_chan);
-
-				if (tqspi->is_curr_dma_xfer &&
-				    (tqspi->cur_direction & DATA_DIR_RX))
-					dmaengine_terminate_all
-						(tqspi->rx_dma_chan);
+				if (tqspi->is_curr_dma_xfer) {
+					if ((tqspi->cur_direction & DATA_DIR_TX) &&
+					    tqspi->tx_dma_chan)
+						dmaengine_terminate_all(tqspi->tx_dma_chan);
+					if ((tqspi->cur_direction & DATA_DIR_RX) &&
+					    tqspi->rx_dma_chan)
+						dmaengine_terminate_all(tqspi->rx_dma_chan);
+				}
 
 				/* Abort transfer by resetting pio/dma bit */
 				if (!tqspi->is_curr_dma_xfer) {
@@ -1251,10 +1284,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
-				dmaengine_terminate_all(tqspi->rx_dma_chan);
+			if (tqspi->is_curr_dma_xfer) {
+				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
+					dmaengine_terminate_all(tqspi->rx_dma_chan);
+			}
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
 			goto complete_xfer;
@@ -1323,7 +1358,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 			return false;
 		xfer = list_next_entry(xfer, transfer_list);
 	}
-	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
+	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
 	return true;
@@ -1384,41 +1419,43 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	unsigned int total_fifo_words;
 	unsigned long flags;
 	long wait_status;
-	int err = 0;
+	int num_errors = 0;
 
 	if (tqspi->cur_direction & DATA_DIR_TX) {
 		if (tqspi->tx_status) {
-			dmaengine_terminate_all(tqspi->tx_dma_chan);
-			err += 1;
-		} else {
+			if (tqspi->tx_dma_chan)
+				dmaengine_terminate_all(tqspi->tx_dma_chan);
+			num_errors++;
+		} else if (tqspi->tx_dma_chan) {
 			wait_status = wait_for_completion_interruptible_timeout(
 				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
 			if (wait_status <= 0) {
 				dmaengine_terminate_all(tqspi->tx_dma_chan);
 				dev_err(tqspi->dev, "failed TX DMA transfer\n");
-				err += 1;
+				num_errors++;
 			}
 		}
 	}
 
 	if (tqspi->cur_direction & DATA_DIR_RX) {
 		if (tqspi->rx_status) {
-			dmaengine_terminate_all(tqspi->rx_dma_chan);
-			err += 2;
-		} else {
+			if (tqspi->rx_dma_chan)
+				dmaengine_terminate_all(tqspi->rx_dma_chan);
+			num_errors++;
+		} else if (tqspi->rx_dma_chan) {
 			wait_status = wait_for_completion_interruptible_timeout(
 				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
 			if (wait_status <= 0) {
 				dmaengine_terminate_all(tqspi->rx_dma_chan);
 				dev_err(tqspi->dev, "failed RX DMA transfer\n");
-				err += 2;
+				num_errors++;
 			}
 		}
 	}
 
 	spin_lock_irqsave(&tqspi->lock, flags);
 
-	if (err) {
+	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);
 		tegra_qspi_handle_error(tqspi);
 		complete(&tqspi->xfer_completion);
@@ -1444,9 +1481,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	/* continue transfer in current message */
 	total_fifo_words = tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	if (total_fifo_words > QSPI_FIFO_DEPTH)
-		err = tegra_qspi_start_dma_based_transfer(tqspi, t);
+		num_errors = tegra_qspi_start_dma_based_transfer(tqspi, t);
 	else
-		err = tegra_qspi_start_cpu_based_transfer(tqspi, t);
+		num_errors = tegra_qspi_start_cpu_based_transfer(tqspi, t);
 
 exit:
 	spin_unlock_irqrestore(&tqspi->lock, flags);
@@ -1474,28 +1511,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 }
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
-	.has_dma = true,
+	.has_ext_dma = true,
 	.cmb_xfer_capable = false,
 	.supports_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
-	.has_dma = true,
+	.has_ext_dma = true,
 	.cmb_xfer_capable = true,
 	.supports_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
-	.has_dma = false,
+	.has_ext_dma = false,
 	.cmb_xfer_capable = true,
 	.supports_tpm = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
-	.has_dma = false,
+	.has_ext_dma = true,
 	.cmb_xfer_capable = true,
 	.supports_tpm = true,
 	.cs_count = 4,
-- 
2.17.1


