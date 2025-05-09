Return-Path: <linux-spi+bounces-8033-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99F1AB1385
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 14:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F144A8790
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD16290DBE;
	Fri,  9 May 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gvn1D41y"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E7290D8A;
	Fri,  9 May 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794159; cv=fail; b=E4Ou/BCim9k+LFOwZz1TSaWPmdrvPjXSchXmY2QX3AfN1QhMtm3WUv0YOaJGrN2SS4tYNGJUnAmearRVVOlfprR73rKbcxzXsAUaa4w4QUHoxxUjs/YpH6RhTviSTmKcwcE0xlhBKsXUDHeepsOkkRhFp4vszk3hYB7VxrGGmck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794159; c=relaxed/simple;
	bh=c2N6vP2dDd6n0RxIcj66uKHA+feuCGAfyLAGC4eu6Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx/hvP2gMa9ZYkfbzXOyWw41G6RPkCQSgd/hCpya+MWLXS2HNZ0/fiKxtMD9u5+Q4gu0FM+myuaYh+tZ8Y8Z5EKvr3zt8pDhPoGlVZtGQywy9MNvcMvF1n0EUTKaHj4gddks28poduncoYvivorxUY2zK2UsBw1NLfj+GiwQrkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gvn1D41y; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8+XtoBJ1q15/8TcsYyntPpi8LhHhrSq5tmEXcrdkoV1/Rak6iZG/IWozylEs6G5vt64hfxzNGP+4KxDi2gsj+OFoTVPgCZ+eBBdCLbs3x5x9xWkYe0EuL32RwQLJzaJ4bMeWK+SSx1Ks4ciftn3FgkGQOF3iEcfd8KfzptomZyRGduDwofLJ/EW4G+yOH002LwKsePAvQB0AFaJHEOs7i8TABcASWfGbQUYrJco/Xz0t9auMmK9RYnib8N0KybgD2X2N5RV002tD2sN/jT+s/KHu/E4kcW6e6GvILznDI6VE4O2TXuQYMvMJncvEelUSLEMU3lhHeobsK73bHg04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEvJgej0Y0yAUHYnHR/XuuTZYQF1tJsOT1+hh41kzkw=;
 b=TW8BPRLrT92XM2kNFiU2OJK0bCZxdnNpoPEKo5T2RGDCFDrAlJD2bawAWenSY2WgRhxjT+ELPW+DSXsM2v/vs0souUV5brmIE+ImoWZy2R/kmX2vv7O30xDRzI3KcULay22c+lkYz9YtGsGTsKkpBEDOKQdwX0WeZX/BpIFsZ6D+w/ukL5lSPUfHpecEddOuUek/UwlSBWBZ/kGKTzRAYrkmM1ZkwlGJqWsi/hN06dkHXNWC0PZDC/buj+gHRM4ldBws63yh6zgMnVz8Ld/1fVubR55oezowRmFEgKBjchur9uAS/Ive+6zOFP2ceLRR2UxM8ETsNCxC/fQEViW6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEvJgej0Y0yAUHYnHR/XuuTZYQF1tJsOT1+hh41kzkw=;
 b=gvn1D41yQ4IeY1nDYBI6badp6iZNDJ4TZxxOLkHvnIa4137keLWdUExBn1hwLlCqB9nnFIhOuvLE2alDjpX0YuDDCFpB+nWlShzznlvQDbDXU+edE9uZLYWN8baCHWZi1Cb9ar/ambL0zNp+gLbUU252Vl85FNVvuOhKtuAxjq1Q5dvbNOiqb8wPoo8D+5twF8UPbcYpxfSCFWCg/HiuLYT1ANDGP+3F6a1il1iKhZHiOPB7q2gaU10sppwse9/39gRhny9ssoLLTZUsfMGoJrYfvuQzLWCBn1qOmPF8nhd4BRDF/gJh5E5P0ZDxF0y6jdyE6k6sIRl7pQDipotVXw==
Received: from DM6PR08CA0040.namprd08.prod.outlook.com (2603:10b6:5:1e0::14)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 12:35:51 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::cf) by DM6PR08CA0040.outlook.office365.com
 (2603:10b6:5:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 12:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 12:35:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 May 2025
 05:35:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 05:35:41 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Fri, 9 May 2025 05:35:37 -0700
From: Vishwaroop A <va@nvidia.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>, <bgriffis@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH v2] spi: tegra210-quad: Add support for internal DMA
Date: Fri, 9 May 2025 12:35:21 +0000
Message-ID: <20250509123521.3471650-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509123521.3471650-1-va@nvidia.com>
References: <20250509123521.3471650-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: e83e41b6-8e63-4aa1-fcdb-08dd8ef60892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mb4cHiQiETkUDwKGg2TRuZ5ICUXxoGLSHpWbukXmhiOoAueAJgEwGCIgxbCx?=
 =?us-ascii?Q?eMMGNYtKap20vtynhjbDy9a92b8GhyFXMib6tWTNUjLXDIQxrCuXXT6aMg9a?=
 =?us-ascii?Q?H/SHrYv6TZ5om1c0D7aF7rnBDIKqOHTwwYH0nWOhZRMV9maf5GlH9Dyq3ia0?=
 =?us-ascii?Q?gvgY7IHwl6AqVG9KFn3UrWq7bUV9k+PqSlyMLfntGJ5eThYnCHa2+PcuQt/R?=
 =?us-ascii?Q?HHV/vZKUjJ9bAZVRLe+S2vpVSGUm3mKY9oTxJ0Y80x90ZWIC1/uFa/ba36Zo?=
 =?us-ascii?Q?moVh8diW0W64PC/5y3hii55rBnFbQ3ZYP41TTWf2F9Admb0lleEafPtaoHZj?=
 =?us-ascii?Q?8qsWj5Pv9Meephk+qsk5BM1qeDbVZWkOlAPzXZDXqgQWijKt+UmOdFd58ZEV?=
 =?us-ascii?Q?UmLLIeXbtB95n59Haa8xeaUC41aDkfd2UQFdoZsIJuHhcDnZGrobaUS7ddIN?=
 =?us-ascii?Q?4GIiVQVIQcD2x9rWR9HQsaQMCHOtZywQIbQr8oCFI0l3lCpeGKfmkNvJJ4/b?=
 =?us-ascii?Q?ByeeXKi5qEC5mfT2jgJHeou+vef3kXhjUxbgAYTTGVQEaxIRaGIeXH1gqtFX?=
 =?us-ascii?Q?EL48wO5dJaMIQhjPAE+n/yo1jSiGg31Q4j0I2vyrQuZNbisOilGC77pheI9G?=
 =?us-ascii?Q?ZC6V9ea9mwPFs6HUHKw3/2IAGBH5a3txNTqElW5TTwpjQjE6KAU4cUQ5C3Fc?=
 =?us-ascii?Q?i2NmctvvCdgkTXthPcF8iJbgomZudX144w7Uu18j4NqgbEvP9IZoVWsx3Iet?=
 =?us-ascii?Q?sebpLfOOgCPDVMqxHK3ZhkwdykM8DecpfMvMMR61kAgMJVJQz2QHslG7V0A0?=
 =?us-ascii?Q?JTtU7qOtHTBKdghFfhiqOW2fwYWtR7Bkr6nslwlPql2i3VjfrDk1YRAb648V?=
 =?us-ascii?Q?7C27O/cP7Vh3tkOndY5o3+l/Afl8qHqcN2VndN2lDkTRXmIy/+O4MMObJTTU?=
 =?us-ascii?Q?iImML5ozieQHi7AUw72eJ5ht0hLvzw1+86gXVvA1e44kuh54E9Q1mJIxO18M?=
 =?us-ascii?Q?Q0czpHF0p5iIvRYiqkYSEQMtS5lTqtXOKbO85leKa51/ybEG/+aJDeSrzq/u?=
 =?us-ascii?Q?G17xomm2hmLUOOqvjPnOMMzvp6fBEdVNH5YB8EvARIdR/rf0qpD38n5p5BP6?=
 =?us-ascii?Q?H2vvssM6QSlHvYlw/vT+EZkmm0wWp9B1YvtO4Qr6sQxkjqbocj3dRrXyaV4X?=
 =?us-ascii?Q?+nmIo7t11GztXUlAHJDQz2Jn7h+YcME2WrvhaxtQIayq/LZ2OCu4uv+v1UqG?=
 =?us-ascii?Q?I625fk+fl3LggWQbmeo4GE65s2UZfjXbwUo/FfmfP9putVDCc0ocw5mqPwdY?=
 =?us-ascii?Q?qUlNyLrqO+kUUtrz0V5ThA419LGqJeE2qYf/ejLQBZuxF2hzp5dGEXkprKFl?=
 =?us-ascii?Q?TmrAzfFYZFvDHnbdDVZ1UyWcRPV11MamI6703L3lZmr3ux16Z+lkHXemUvn7?=
 =?us-ascii?Q?8pUB++FwZ9CoKdgSCSGny4R51cHTWwflNCB34Ylqp6kqIywelsSe89WCkN5r?=
 =?us-ascii?Q?EPYxKw/or3EVolzBX/A9ZRu+uYvqedK0uA0TgyqVOhL/jfEdyiBnyucOKQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:35:51.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83e41b6-8e63-4aa1-fcdb-08dd8ef60892
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

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
 drivers/spi/spi-tegra210-quad.c | 223 +++++++++++++++++++-------------
 1 file changed, 130 insertions(+), 93 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a93e19911ef1..953a4a74afeb 100644
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
@@ -634,60 +640,88 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
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
+		if (tqspi->rx_dma_chan) {
+			dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
+			dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			dma_sconfig.src_maxburst = dma_burst;
+			ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
+				return ret;
+			}
 
-		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
-					   tqspi->dma_buf_size,
-					   DMA_FROM_DEVICE);
+			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
+						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
 
-		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
-			if (tqspi->cur_direction & DATA_DIR_TX)
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			return ret;
+			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
+				if (tqspi->cur_direction & DATA_DIR_TX)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				return ret;
+			}
+
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
 
@@ -726,9 +760,6 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 
 static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 {
-	if (!tqspi->soc_data->has_dma)
-		return;
-
 	if (tqspi->tx_dma_buf) {
 		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
 				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
@@ -759,16 +790,29 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
@@ -779,14 +823,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
@@ -1128,15 +1164,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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


