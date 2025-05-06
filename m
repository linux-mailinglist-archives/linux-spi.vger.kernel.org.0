Return-Path: <linux-spi+bounces-7928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E0AAC3C2
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7D2501B66
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D527FB3C;
	Tue,  6 May 2025 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTo1tCjz"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94E1DED51;
	Tue,  6 May 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534206; cv=fail; b=S47c39TxEWTLhrUMvTFj2UJhNanl6zifQUSVLT6qIQdR3FHqw6lX7qOXEcKHorZjAPd5CxpZ+VeWAE7hv1yS8LA4etJGc9SJgFSMhLwQWQrg4VoJY/KHHwIgYkaS8aDAy0wn//Lh64tf0oVej5vG/C2+bgW+HJlsWWKrYlBPwQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534206; c=relaxed/simple;
	bh=+fM77CEV2X/D3P41Exo2CYGpSFbSwl5TnW8ZD7/fPPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn8EUPAvnNNragyQuWgYqdQ0BjJ6uvPgXRL2frGS6qzZCChL61zShsmKG1G6y3xOS2R8wFtiL8go2i6VtCQ6tK3xU2Dh0psLkl6fNOtM70njvLxd7cKrRuIgSF5K6MmeLx0QI1+hLjTwB5jFXOlaB5jtw7Llu7vv/s2Sa4l7IgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTo1tCjz; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/ktQQ14PjLdgATQyRyKClBjuaulqMOA1DwGCbC+kI1YTf9/R8fYRUcEoa801c8RWwGXBG4/GAJFWdSbvz3+Bulwzp9Rs3mxZVeMjzGtpKTE50hazr9CCvovxfXORpiJ51ZTZYtcevX/x7gynGhyabI86gdrsdnS7m6uXicVIbMP428E/dust97I+G+l6yEr0nhPf1SjlQfoDPT3e5cNk8z9QExY8r3sNMyBdWOZ12HZKLJ5JvrZvjY8M3/1AqXwDM/1eYcU2m3CPEVCCG7zmA/xC52gNDW8PoFUU9vU1ELsrb+jnzDIfPSKFqkw8thjc1hnvt/dxQoSwiKxh0bvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHsN1WIbN2/6Vv7k3AmNe9WQhGvt8wHweEIpPuL5myk=;
 b=KKt8uTIe8pvPPJaTaN+EAN/gLXKwMeJi1DcUf2LnhnJrMyXFUmiL3FjaLTklHZYf/VgETJf7R/wVlXc6rrc/b6N+ww2ZJ9oeQMNVNzmqSdl3a/UZhw3EgyPXGnP71PjrA78KLH08yVmeKEhPXXVwU+XJUk8bUKujvz6Mfq0GTFbv7zJjLH/45UGeYk8TB7CA274Laz4BVRVYtz9xGRuvGAeW5kV6q/KkqFTfo8JEaWzMxJqB/ej8Y+201xl89ZXf9UWcLNTNL4kPVjmi3DXkB0OOWTZHypU8/TwSxbr5b4OsiQ5UcVveN+4/8O0+MUcI+8+OUqJXDEtWOIdbtJrRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHsN1WIbN2/6Vv7k3AmNe9WQhGvt8wHweEIpPuL5myk=;
 b=mTo1tCjzBzCzvQRmz4Spu66d2QkMmuSyD820sDfkyzJMbwMkAEA2yB6zeSr1+SlvpEVXMA1lYmasuQycz9+3VKXWYBBhRVIHzLtN2bV1Xm/FEX6LnFUTeJEZvBVodgZx72tOCXvSe0AqJHMkda3RKfcqMU4KDx9p9g/HWMAf40vNDhbZ9lPcDwqxz4t68EzwdiJTXpele/BBF2fOQ7a1Oeh3Et+vlnjxO1gZ1v3IkYvfgWKqOX3k7jaNG8ZxZsKYjoqCW/qIMDkMG8XUmv+Ocy6LXWyVLZpgN7IADVnvhoDNwGcBjaKsGDl1tfx7g9998LO+qO21LPGwcif4nBLDtw==
Received: from MN2PR06CA0002.namprd06.prod.outlook.com (2603:10b6:208:23d::7)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 12:23:11 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::e1) by MN2PR06CA0002.outlook.office365.com
 (2603:10b6:208:23d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Tue,
 6 May 2025 12:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 12:23:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 05:23:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 05:22:56 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 6 May 2025 05:22:53 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH 3/3] spi: tegra210-quad: Add support for internal DMA
Date: Tue, 6 May 2025 12:22:22 +0000
Message-ID: <20250506122222.3345040-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250506122222.3345040-1-va@nvidia.com>
References: <20250506122222.3345040-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dec2ea5-3036-4018-21f5-08dd8c98c459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4gyzK1ppeaHSN9dEHrDmFLYLC5JpoWsYCGI08kOSCILdGGQ2VkbZpdzUODyH?=
 =?us-ascii?Q?R4jIvOGwZTwwJFQ1oV8pfXJi+7ypjzF8huV6UnnZVjtZTNluE9iVWgKhvkEm?=
 =?us-ascii?Q?G4g8sxpNpsUiL1VtLTtpU+YWBcZL5OoYfGm4BURWhPKTj98bhz7oWwLDuglO?=
 =?us-ascii?Q?jwPjOQsr9dppoda9BhePekQhqAvwN6ewUIXYi7BvQDHnlErrEOCBCDwI+Ggq?=
 =?us-ascii?Q?WDd9vfibhnDSV7aKyr4qIMlesJDaZ8TTSz+45NhNfbrF7j4U8MMHRhhX5O/h?=
 =?us-ascii?Q?FNNVUdv4jCAlAhn8gxU0kfLGekYQKqdop+8/UIeEvQxjmGduVcmTQTFJ2xXF?=
 =?us-ascii?Q?ThcxDfaVp712uz5BKYbc7FAXWYGagQpwkubLFRKiL/VIN3XRUMhf8sBsP3y2?=
 =?us-ascii?Q?aqzacXB28jUOmXorI6uyzgz/GiL1/YNItU8dthDeuURFmzJIoZTV5E5l5jjN?=
 =?us-ascii?Q?t+yMEssLBI1h5tQBvdBxbBfJ9hccU6OdtHDT9QJ75eZkvZVABw9rx7eqorXo?=
 =?us-ascii?Q?mEpUObnYkYmSTTY39MmDBOjt4xKVOLyBV3yWZPm2F8VE1chX9hN08+VhQmlS?=
 =?us-ascii?Q?nEb4CbvEPHvnc+Bh8+QZnesKS1RN+EPbj/gw/cxkJF0bT6cocx3nq5AvquH+?=
 =?us-ascii?Q?NW5VETq+hgpf7nOFUrO0MF3l+Gq8seI3PG92+du62GeQZvM2clB1swmU4ijt?=
 =?us-ascii?Q?ojMayAPl4jyidCV34aa+nz7pWAZHsZuFTLnnVAhfmYQXJemJPXBmzGfjRhkd?=
 =?us-ascii?Q?RQlsfgUz9iK8HENVCzjwp26H6S/48i0thZFmTuCyyrlYyOXuh+5UAel/GwYs?=
 =?us-ascii?Q?48Zt7IUmDiPbPCISd3CY5pX2yeEVjO+6Ytx7HUdVhnVgHdImqlu/NH3gofYU?=
 =?us-ascii?Q?HEG0h/iO4oHtx+n0oGlwYnmhhHrXL5tPRQpzyx/6p5lf/YUdV3YgqAkTokoO?=
 =?us-ascii?Q?rHRjdIMmP1EjpXm5HDAmj+d8GRiYK49ggzxlByMHb//4h8uD+CSArD3rxxH2?=
 =?us-ascii?Q?6Hh4TSs9TlnJImdBFo5BbFAXBgYRn2Z9U+KMWvDUIhJP9CUOiQCrDUiwkMpq?=
 =?us-ascii?Q?JyTOZMk+rYNpORanZl8kUHs+RfI6K+6koaWp8IfUNWI24KBu/W/J9RTfEB73?=
 =?us-ascii?Q?4PxBp1UUS/Lbu33Ywt8WNjIPkXZWkRuy1VBbWvKUK1Asl0vc1OCNNuJXO6Ad?=
 =?us-ascii?Q?iASXO95XOryf8N3DavagTaqsb05RxiDILLqTegb23vokUkRbipEYnwSW1sIJ?=
 =?us-ascii?Q?2SA2INh8xfKz7XxST2Yg1P/Rr58iBy7kSRpGRyWnfXGATHAMsnzELVCXqq6j?=
 =?us-ascii?Q?0AIaNcRS7rL2ZCg0x5woLkCFaNTUcPaRBX3Cdw3smB6DrIJHfNVBdndEBwZ6?=
 =?us-ascii?Q?lBcPq2069lBmPgH9c98nW/tcp2ZMZbK2yZo192XnFqTIGEf1nNIY8oakR3NP?=
 =?us-ascii?Q?/Uo+CVBu6WvU+SlITfAc/zcgsOSE0SwMnpMMmyJnQXNbs7QNSyoQ+UMy5cPo?=
 =?us-ascii?Q?Hj9QR+czLiFv9r0qIAFHfYzccT1Ryul6bteLTpsNa9MTDun32lQgfTNlhw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:23:11.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dec2ea5-3036-4018-21f5-08dd8c98c459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

Previous generations of Tegra supported DMA operations by an external
DMA controller, but the QSPI on Tegra234 devices now have an internal
DMA controller.

Introduce routines to initialize and configure internal DMA channels
for both transmit and receive paths. Set up DMA mapping functions to
manage buffer addresses effectively.

The variable err is changed to num_errors to more accurately represent
its purpose in the code. The updated name clarifies that the variable
tracks the number of errors encountered during execution, rather than
serving as a generic error flag or code.

Tegra241 device supports DMA via an external DMA controller (GPCDMA), so
enable this.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 223 ++++++++++++++++++--------------
 1 file changed, 128 insertions(+), 95 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a93e19911ef1..db68e9dbb90e 100644
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
 
@@ -605,17 +608,21 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
 
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
 	u32 val;
+	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
 
 	if (tqspi->is_packed) {
 		ret = tegra_qspi_dma_map_xfer(tqspi, t);
@@ -634,60 +641,86 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
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
+	if (has_ext_dma) {
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
-	if (tqspi->cur_direction & DATA_DIR_TX) {
-		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
-		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.dst_maxburst = dma_burst;
-		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
-			return ret;
-		}
 
-		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
-		ret = tegra_qspi_start_tx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
-			return ret;
+	if ((tqspi->cur_direction & DATA_DIR_TX)) {
+		if (tqspi->tx_dma_chan) {
+			dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
+			dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			dma_sconfig.dst_maxburst = dma_burst;
+			ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
+				return ret;
+			}
+
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
+			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
+						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
+			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
+				if (tqspi->cur_direction & DATA_DIR_TX)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				return ret;
+			}
 
-		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
-			if (tqspi->cur_direction & DATA_DIR_TX)
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			return ret;
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
 
@@ -726,9 +759,6 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 
 static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 {
-	if (!tqspi->soc_data->has_dma)
-		return;
-
 	if (tqspi->tx_dma_buf) {
 		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
 				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
@@ -759,16 +789,26 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
+		tqspi->rx_dma_chan = NULL;
+		tqspi->tx_dma_chan = NULL;
+	}
 
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
@@ -779,14 +819,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
@@ -1128,15 +1160,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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
+					if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
+						dmaengine_terminate_all(tqspi->tx_dma_chan);
+					if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
+						dmaengine_terminate_all(tqspi->rx_dma_chan);
+				}
 
 				/* Abort transfer by resetting pio/dma bit */
 				if (!tqspi->is_curr_dma_xfer) {
@@ -1251,10 +1280,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
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
@@ -1323,7 +1354,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 			return false;
 		xfer = list_next_entry(xfer, transfer_list);
 	}
-	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
+	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
 	return true;
@@ -1384,41 +1415,43 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
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
@@ -1444,9 +1477,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
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
@@ -1474,28 +1507,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
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


