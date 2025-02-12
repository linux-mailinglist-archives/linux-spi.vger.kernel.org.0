Return-Path: <linux-spi+bounces-6784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B808EA32913
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF427162AF0
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A2211261;
	Wed, 12 Feb 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VMTrGgCT"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A602101AB;
	Wed, 12 Feb 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371677; cv=fail; b=UFyldULi5q9sLszIUQSmGFyBA+Z6JC4W1BH/7pNqX3EXn2fjzWg+n6CdtPCMa7aVJUgyaZ6DGiZyf+ZXFoKn5XaKA8YDj/d4yG2zlgqfmwRyqLWHzaDnxDxXSseShU3BhmyzyeP/yCeRIDsq0F7FcnOKUlA1mVEzSYyodwK1Kjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371677; c=relaxed/simple;
	bh=j5Bw2CEdqEJhb2CsYlhC4iHXGJWB2dhAWQxz2leN28s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f90i77L3htiyFuwPLQYlE1tfie9+aYWH/ry4i+oxqcp/NuanU4wovJkc9SO2aWbbpLQIpeQutAoC9vEpm6mY7xl+i2j79Fm06GUUGcevciy6Y2kL+AP0RyXW/Q5ArW2P2m/xPOYbfAQtJdkYiNsRMN98WmIOFuIc6+teXWHIHPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VMTrGgCT; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqISn8lkeU7LY6YGq8GpXKx3+FJjDfKqjPN9OMFrmKbkTT0QmZyvHQEYiQ1QNa4DaIT/5oCn/GBbo8gztp2ulvGvcOeOQWr1uC4m3r6j8EPmKIyjVNRzNbVCGGYGv1IlwGOfwzRLloft0EE0rIRNOftGu7QLaQlKhiF89CWnISTL1IlftQrtI7oRMjsWnqsqi/wc4aOwdcqjqzrTdJSRqZgPMyRRmHCShhNIRXHEsFJtgKkqDIxodKvu2MdUNvE0J6k55vGA/sfAViEXFZGkIatvsIfF1WStCRfjaRUoEsBmMSb03Wgc2Ahv5ZcwKqbpPGlcR+JnjV6vjIfA0LMrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3sSXi16rTi62ZBd/zisRT1KG5D54Y7aR0JkL+WdRHs=;
 b=rjj3G9URm4X525QRMx1qYRchhDsnJY0fiUb6xd9AhCCxMA1qqzi5emk+PwN6MDBO4gKiMZBIUEWDtYvgT60fx7OvGMVDA2ryBD3nB5xZxjCpge6sobhKRHiMVM5GpQOg6gxMpuftJ4qUcKkZwEOK7zANn2q0YHgRjtiiyGYWuVrrEFZdjB1UItEgQheRlFOQe82f3ischKiQ6uZrCGxvAW91fkKacJmypKOX36Iwi6KOrCppIL32r0fr9pcm8a2gzV84+IZ0l9s5GajE1yogG1MjXfnC8t+Yqa+dXiy6Jmr3Qx6g9HHw3cuLqT1vSph21TYHJerpoJqoeJg/yv12Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3sSXi16rTi62ZBd/zisRT1KG5D54Y7aR0JkL+WdRHs=;
 b=VMTrGgCT4DSfDN28A3LaYV7XTRQy0treN7hfMB71HW4PWG/mWcKsX8OiX6+1GK7Dz0dc4yMe89/ZaBLq0nefAFgRNg5mKufcPX44/D8arWxVp80+SP8jjk6eFS31QF37xhZVnhkxQD0Lvlw+U8FMeVvZ2ZVLQSK/EAbiJgGQlfuI15CI+QF0K5fhfr8T58cDCg/qqC35MLRYjq9+Fg54ZCnukRfKMykKrAHXYtkJYvK3UF4jJRr5fRZJWMOdCHCZhV6+x8KzsO8sTIh8Js3MhkL4DRfdF3CneTFp3UqdO8v3OjnVTZLxJq/oTK15AMU6nLWZ0ljabNTMUT5I4ymjPw==
Received: from MW4PR04CA0048.namprd04.prod.outlook.com (2603:10b6:303:6a::23)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Wed, 12 Feb
 2025 14:47:49 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::54) by MW4PR04CA0048.outlook.office365.com
 (2603:10b6:303:6a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Wed,
 12 Feb 2025 14:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:47:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 06:47:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 06:47:30 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 12 Feb 2025 06:47:27 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kyarlagadda@nvidia.com>,
	<smangipudi@nvidia.com>
CC: <va@nvidia.com>
Subject: [PATCH v2 6/6] spi: tegra210-quad: Introduce native DMA support
Date: Wed, 12 Feb 2025 14:46:51 +0000
Message-ID: <20250212144651.2433086-7-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf610eb-3383-4e77-2b38-08dd4b7438b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tUgcVyHs+/x89XZwzKiA27ca/Q8PPJbPmEsTKO8sZmdNNnkOiyCxiCQw1Hln?=
 =?us-ascii?Q?ZlRF2ZibXlo9rhStqqr5/N7NAdRx92/MsbaEdZGRchTotb0Ag4DNNCKiqSRK?=
 =?us-ascii?Q?etFjYseldF0fooUYEaE0fD718g7DMEcdh4ucEyZM/o5Qh/OVO40wB7BsK3nv?=
 =?us-ascii?Q?Et48TyXcdVPCG/TkfrMjcfA1Rn8CtUuwX7QXWvD6M0kRtsebkxwqPMApEA1W?=
 =?us-ascii?Q?RDCY0cgwHuT+a4N5Jgdufsp/8/X+FvsN2BSsXwfGVeHmlKpT7K5l52rvUv83?=
 =?us-ascii?Q?UpI/txPGuKkxGE7CmENz0aaXn1ggFysh/M12OzlPnXt5TDH+Y7hjh2rYgtxR?=
 =?us-ascii?Q?sMG5VO8ACycPJqpDKQ3YEDcHUDcBfp9Y0xwzHWqhAaDAcX4bNDAgVrgMdZXs?=
 =?us-ascii?Q?HyfXJIM8TZDlbx8USRqQk24QH1kj+3xPSD7R/dNDUASnd/2CbEdSS9IOc0ey?=
 =?us-ascii?Q?lChwvjafrDYINyEIzMNyWp7WCWAff904OJD5EXUjsmcO/C3sr0SwII0SCeFa?=
 =?us-ascii?Q?GNw7UUBOf2QmtsStgr6dxgSvC4Yb/aYVdH3oxYAz8wBSSBYKDWZ0PLwjk8gb?=
 =?us-ascii?Q?uZHnAQBe8KH6jQ5RgIHjHEBiglBLgV2lCXCQ8op4ZElkGZCPi3rQ1QsPJsye?=
 =?us-ascii?Q?D3vJ34VfrTREW6mc7ZfaWsOQc4NO8p5bd0TWMlrKTmU6OtzxedVZ8GJU4k5e?=
 =?us-ascii?Q?tdjzZLNlaHmjXWzEhpf2maBOjLKHekH7E92g/3Ff7adR4LN+PtJhy83tIucK?=
 =?us-ascii?Q?LQRgHj5vmc9PACwGSvmcJ9qSOjIMC9gHTAaBJK/vqaZMq0nkNrPPfJodsWv8?=
 =?us-ascii?Q?+tdGB3CHNAETBQxHOUr/B/BfjeHYkSjmBWmRMt9df8BKA3i0siUMpRYpMJZ6?=
 =?us-ascii?Q?Hm+BQ3I70FRGn0D40BWZvbl0Cd4ovuDaBbVAuadWY65GFF7ooxa7/bf42CyF?=
 =?us-ascii?Q?o8ZbK1Q+63I9HU0xBmbmZneNLnnbDXmzODWaWsYn4327BY83+SYjvlFg+yx7?=
 =?us-ascii?Q?MqgTg48dYGMpZUZtpWTvvDe0kWs/88u5kmEc3UKJRH/MDzoMVq42ljaV5VmF?=
 =?us-ascii?Q?oBMpLXwVdXsA6Z7Ao96EHipcFDyGf///EkeHw3wPvJvBhRF33tnfMy+o6GiZ?=
 =?us-ascii?Q?BNG8MdGr1aegvwhh6WxeIqduXZs+BJbgjKHScoEk2lAannz0LstYaA++25Ic?=
 =?us-ascii?Q?DH7HE4EPA5D32YfPQ/6T93u0UPYlbGwGXcM/3TbUdepWDGNLthzGOrXHCDLz?=
 =?us-ascii?Q?WT6IJJSyCSNFe6bvR23oZnNsU1Gq2Bk4bndZVv8cJ4PsNsAiOT5Ns9MZhDHE?=
 =?us-ascii?Q?xiGX8njsFUWqFZsc/jbGfmRoX4p2X1D22k0xksHEOliZBmep24i3DnzNRUbB?=
 =?us-ascii?Q?L4YMz8FjbHLsVKsIN/SVmRkMgt2bQfHB0iCpH4SoB9K6vdxiPYxRMU62AMiD?=
 =?us-ascii?Q?Dx63YpZb59hwbeyfRIIIsQKSyaXzp3HcCMERlO9eh7wsk84vReksWbFHMZ4Q?=
 =?us-ascii?Q?swJ/DEqxF5gplPtqnY2151GO1MpC0rjI1Xh0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:47:49.4653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf610eb-3383-4e77-2b38-08dd4b7438b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092

Previous generations of Tegra supported DMA operations by an external
DMA controller, but the QSPI on Tegra234 devices now have an internal
DMA controller.

Internal DMA: Uses the QSPI controller's built-in DMA engine, which is
limited in capabilities and tied directly to the QSPI module.

External DMA: Utilizes a separate, GPCDMA DMA controller that can
transfer data between QSPI and any memory location.

Native DMA Initialization: Introduce routines to initialize and
configure native DMA channels for both transmit and receive paths.
Set up DMA mapping functions to manage buffer addresses effectively.

Enhance Transfer Logic: Implement logic to choose between CPU-based
and DMA-based transfers based on data size.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 218 ++++++++++++++++++--------------
 1 file changed, 126 insertions(+), 92 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 04f41e92c1e2..7463b00b1ffb 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -111,6 +111,9 @@
 #define QSPI_DMA_BLK				0x024
 #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
 
+#define QSPI_DMA_MEM_ADDRESS_REG		0x028
+#define QSPI_DMA_HI_ADDRESS_REG			0x02c
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
@@ -634,60 +641,85 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
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
+		if (has_ext_dma) {
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
+					  QSPI_DMA_MEM_ADDRESS_REG);
+			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
+					  QSPI_DMA_HI_ADDRESS_REG);
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
-
-		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
-			if (tqspi->cur_direction & DATA_DIR_TX)
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			return ret;
+		if (has_ext_dma) {
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
+		} else {
+			if (tqspi->is_packed)
+				rx_dma_phys = t->rx_dma;
+			else
+				rx_dma_phys = tqspi->rx_dma_phys;
+
+			tegra_qspi_writel(tqspi, lower_32_bits(rx_dma_phys),
+					  QSPI_DMA_MEM_ADDRESS_REG);
+			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
+					  QSPI_DMA_HI_ADDRESS_REG);
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
@@ -759,16 +788,26 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
@@ -779,14 +818,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
@@ -1056,6 +1087,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					struct spi_message *msg)
 {
 	bool is_first_msg = true;
+	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
@@ -1128,15 +1160,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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
+				if (tqspi->is_curr_dma_xfer && has_ext_dma) {
+					if (tqspi->cur_direction & DATA_DIR_TX)
+						dmaengine_terminate_all(tqspi->tx_dma_chan);
+					if (tqspi->cur_direction & DATA_DIR_RX)
+						dmaengine_terminate_all(tqspi->rx_dma_chan);
+				}
 
 				/* Abort transfer by resetting pio/dma bit */
 				if (!tqspi->is_curr_dma_xfer) {
@@ -1197,6 +1226,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *transfer;
 	bool is_first_msg = true;
+	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
 	int ret = 0, val = 0;
 
 	msg->status = 0;
@@ -1251,10 +1281,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
-				dmaengine_terminate_all(tqspi->rx_dma_chan);
+			if (tqspi->is_curr_dma_xfer && has_ext_dma) {
+				if (tqspi->cur_direction & DATA_DIR_TX)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				if (tqspi->cur_direction & DATA_DIR_RX)
+					dmaengine_terminate_all(tqspi->rx_dma_chan);
+			}
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
 			goto complete_xfer;
@@ -1323,7 +1355,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 			return false;
 		xfer = list_next_entry(xfer, transfer_list);
 	}
-	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
+	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
 	return true;
@@ -1388,30 +1420,32 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 
 	if (tqspi->cur_direction & DATA_DIR_TX) {
 		if (tqspi->tx_status) {
-			dmaengine_terminate_all(tqspi->tx_dma_chan);
-			err += 1;
-		} else {
+			if (tqspi->tx_dma_chan)
+				dmaengine_terminate_all(tqspi->tx_dma_chan);
+			err++;
+		} else if (tqspi->tx_dma_chan) {
 			wait_status = wait_for_completion_interruptible_timeout(
 				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
 			if (wait_status <= 0) {
 				dmaengine_terminate_all(tqspi->tx_dma_chan);
 				dev_err(tqspi->dev, "failed TX DMA transfer\n");
-				err += 1;
+				err++;
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
+			err++;
+		} else if (tqspi->rx_dma_chan) {
 			wait_status = wait_for_completion_interruptible_timeout(
 				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
 			if (wait_status <= 0) {
 				dmaengine_terminate_all(tqspi->rx_dma_chan);
 				dev_err(tqspi->dev, "failed RX DMA transfer\n");
-				err += 2;
+				err++;
 			}
 		}
 	}
@@ -1474,28 +1508,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
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


