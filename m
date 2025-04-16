Return-Path: <linux-spi+bounces-7619-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021BBA8B764
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 13:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A065F7A5CB4
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4A23F295;
	Wed, 16 Apr 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gU/hZWVi"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628224A05C;
	Wed, 16 Apr 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801631; cv=fail; b=HFnbYwzsERtjjMqO+xcTOdsWFbMYhxCDM9MRvM9YbWZ0YyEpsqpgZkH8pw31+bNZBY9LSQBYNzAfTzGN9FsEiWSgo2pmH+0Vcqn4/IVVzs2mhEQ1Au9F5CCyzpUyg4m7z1lHiS3FiBiEN0JChkwJvS6Rh72Y8QcNOrk5Jv9H+Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801631; c=relaxed/simple;
	bh=o7Vq6zLbC2NwgEMD+P52qo8f9b97BbVhX6rfP/WYd6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc+WxZb1fWfKx5CSFjifffg0dRb9aiiMcASqJmLs8u0RgG9h5mwlcftjXFLvHbNINmIaiUXDWh914RWUNoCaBB2cu1QIQH3I188LSXVKfCYfApierUNsqZcXYyAAAxFsjklfd2O4zYhto7+xTgHdf5mULc1SzCfyUmEaUxwpBg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gU/hZWVi; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFDEMJZARcxGVL3z+ypW49CShl77/cyFf63GIeKaanZSxcs52vlkdWSzXq5puJof4fxKOkF4UEGpIudcmSu39cvxbNsYADxfxsBX1wUO5sxVpPRQIhK+CAfuk+TggGxHacaPXn1E6jtflb/JsUx3VLvoohUMuFjw9f1TtH8VpI/uPmRuuI6V0hLEUd+h1SYLoKACCXNUQzRJMHd5naQs3dganfx/RXx9jEixNBZyOnX3dx1vaW0s+ei0IeTliRG2/07Vju6w2VtltHwqNjgH/UMnFvJ7bky39+jhVaSxZguDgpECLpXt2Z/ikmkIR2n5yCMj6SVou6FdeejeJJjfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNd5dwXqUMH4HQ9YkDC7nVTRvwbJctwqPDTOqeCYkhQ=;
 b=l16ERRPaOPi3YSRRY2n2uEk4wy1qgGHBDVMYYQ0xfW25W34I3ZT2WCrILr5hRo388oc3h2+YymyqekSh1IoKhcGHRCGQYBaeXl4NYb7/MzeLprozZRZRaNzb4Q9Kni/rNPltiNt+GdC/D7hhTA9HhjTkQMRuwYdNTpVepBBFnqPFr0liwRatb2HLC7TiZ3ntWzuf/xR2xOAhzX+haUZIip/76T/JiPUQtxzqIIuNGPTRGgw0O2c0OE+5xclgadC9i37HJT6nNNII0mxQTwfN2VF7GqChp0iw6jMr57p1lCOS4iceT05R0YXzK7jpw2qSE9uVVkRq7x4BK2hUYmIVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNd5dwXqUMH4HQ9YkDC7nVTRvwbJctwqPDTOqeCYkhQ=;
 b=gU/hZWViTV0bi3mXcp8EWQXd9q1C0CTe8HUNd0mCBX45SqcAlyNj5MdXSJVdi63DpVjDW8+YnSGjXpuiAad4QqaE4OfoGzN+q8/mDKeX8arllF/vnAUodwU2VAmzaJ6UHebwWp0LLxeBeQPIcABUWapONZw4/O9C8Soq/oBqI9O2fK3NFBN9u9egMKesfpZenPTZ2CxqLbAWl2J6cL1mZIPdMSZ3Ck5qetcO84jv74kNTVlv2FoARzaGg2paZjxIQlul3WlHxuGbPExuTdEy7/1UgRMvNhA33IA1hVwakzyU7CIVl6fxuOV1qVn1s+D2cvZ7Q/oLBLl0DxdzBhHB6A==
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 11:07:00 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::14) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 16 Apr 2025 11:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 11:07:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 04:06:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Apr
 2025 04:06:46 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 16 Apr 2025 04:06:42 -0700
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v3 6/6] spi: tegra210-quad: Add support for internal DMA
Date: Wed, 16 Apr 2025 11:06:06 +0000
Message-ID: <20250416110606.2737315-7-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250416110606.2737315-1-va@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe60241-4ab5-4234-1ea7-08dd7cd6cfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VB/b42ujL7McbQwR5kEU+6rkBf2KoDH6128Uh/BlOY1fWIUgs45EeIsOw7KI?=
 =?us-ascii?Q?QdbDOlOjt0NBrHSN8rSgBSSA6DyufoV8Bg0S+zsUYPZFU/DwsmANRirFS+WE?=
 =?us-ascii?Q?IW34lUn7XXrnh/ofwNDQtLniuezTWkPgBOfgynjBeV/25dVd/gsyUi1CGOpL?=
 =?us-ascii?Q?xRhaTv0P7ooZlEpaM9vKOW5r73CgJ3B6IUCS+V/q3guoUycVKR9u1bvJnStm?=
 =?us-ascii?Q?MeTPHImTUJ48Lhz555oqyIqVgAokfUImiEJWYPYFZAsIBMBPOECP1v3KLnyM?=
 =?us-ascii?Q?3+PqrSiiuU1FPOw1XUG4PUi/gFbVLgra0KErPC5qg8rL8fJc0Zjh2zARlxkH?=
 =?us-ascii?Q?pPxzRlpVKQHoqXWG3PkOfM8mjQVGOHj0STbm7tDAOs06yT4zIU5AXXxJ+b3v?=
 =?us-ascii?Q?5spfjUTDY0MvOtHZXCwUqBAzSM8aB3GbyqnnQ/XCOgMtoGxlvOtOHzg0P5uN?=
 =?us-ascii?Q?HAUY/ovB6I0VW0MkWzSoSwTfzWkJPOmjVSVIstFaLKNReMJuytmnu3Bruymu?=
 =?us-ascii?Q?XN9sxxQqGTU9XKwbP+lBYaRNJlnakzAK3c/nolhkfHfV2/KOOmQbcslml1j1?=
 =?us-ascii?Q?OhCDTAFYuIfXBVaoemw3mmvUYbS3N2ShrgnSAHFFqI4CGqCAxrEHAG3VqC3A?=
 =?us-ascii?Q?Tym4SPhJvE3Hn5UKV+IFjyXZ2WFDHDJLeWNKoWN2I6OduZYUeJkjloVMXEq/?=
 =?us-ascii?Q?GedYqGCv9S9cX/oMjwAbl4h4XzOEXItafGFE9ifFCB2p81ANNyNoM9wdutfz?=
 =?us-ascii?Q?PV39tBAM0It9d43uB8tVMOV9PHyetLIO9Gq8ox259UHWYxDPe3jCOa6E4Mpv?=
 =?us-ascii?Q?pbBW9hKlHAmIOsMupuc+zWnJa+w0i1jaBjKjjXBp9aYOSio3eMEdzY6Szb27?=
 =?us-ascii?Q?jVK7LWpCQipwrsRtGtV4JEKg+1CEy5WG+Jh7DkMX5BIWaXcsEUNWL+l9lpQZ?=
 =?us-ascii?Q?Mp6fP27xSiYPeLrAf5sOgtZM4mtCAYtWbVrhoTh0dwS/sRlppXPUL8MuqUss?=
 =?us-ascii?Q?fW3rSmMHh8ojHKBSAQACn6rSNUJKw9oG5KlB3OJBj3cQLcjp5Dp6FZHO56rU?=
 =?us-ascii?Q?NW4berF/eEA8SY+EzigA+gZ2l6iWQsWEM+6PcgKhfCybofHRK2C3qVT6lph1?=
 =?us-ascii?Q?aMuh82b8et7r0/a7qFip+KOfeHt7PSAm6x4V2lEldu67ASQ+CMwXZ0NjjpAo?=
 =?us-ascii?Q?NtvdoQSlTGIKW3ni8cVu/B52XsP3VnaRbD7SdoOF59GJKCVYhownuTUpo/G5?=
 =?us-ascii?Q?lhaByZXS8OZpUGWoG95HTFvbR4nro90Vdo6lnwFVaCLa1ZFsuq2zyxrhokb0?=
 =?us-ascii?Q?EHfU3gdY/gkU4glgpHwyhN6bKRQE2ceEoSZV1IcavxDnhY89O+4Hb/IrQNmE?=
 =?us-ascii?Q?56UcIEsADN2jUfA3n5D3cMuaxoGK3hUSr0qGChFbO20VKM7D3hQbON0ob+lk?=
 =?us-ascii?Q?4FLxWhwWlONtiBlxaMQ5aEUnkg2CpAUglVJfHHsVlAQtP7qaI/Dnr0KN0WQm?=
 =?us-ascii?Q?4RmffvAx6iSV7CgmZ+8x/M8Jd7AGSDlBXPXqH6D6sznWHcbq8xbvayKyPA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:07:00.4711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe60241-4ab5-4234-1ea7-08dd7cd6cfb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

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
 drivers/spi/spi-tegra210-quad.c | 227 +++++++++++++++++++-------------
 1 file changed, 132 insertions(+), 95 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 04f41e92c1e2..e80a0850d07e 100644
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
@@ -1056,6 +1088,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					struct spi_message *msg)
 {
 	bool is_first_msg = true;
+	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
@@ -1128,15 +1161,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON(ret == 0)) {
 				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
 					ret);
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
@@ -1197,6 +1229,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *transfer;
 	bool is_first_msg = true;
+	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
 	int ret = 0, val = 0;
 
 	msg->status = 0;
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


